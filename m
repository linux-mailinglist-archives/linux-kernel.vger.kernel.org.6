Return-Path: <linux-kernel+bounces-274807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C5947CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6BD1F23682
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69313C827;
	Mon,  5 Aug 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw+LRdkR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A413B585
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868903; cv=none; b=LN7T4Bh8iqF3gq9xJ2Wb30hHlJlSVv99seql/CEIB7Hp+x5pWNHNKopckHP/DD69aX/GC4WtGn7HBxTbuPM5etV52kwzoS52b8LvCQUSx7LuyavLBaADwN4pLB2I3YaBQf8rhOlFGJ/zHAszI2z/A6qwcTOKQxK3jnRJlUcsccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868903; c=relaxed/simple;
	bh=ecjp0Hf0iQhOloLg+5THly2RViSs1xyysVIbS5xlfqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSAEXhOS7vBHvhf6lByPkQHa1Rq66Apw+MRnRqHYnf55RnmzZ4s+FmSUqkNaCWuyaeNAE7330rcIPTHaEPUw2zl5VnFEujhNem/T08AVSE8MNHungfulejDlUECElhSuO7ajScVKRliVzyXEtFHfrNm03BzR4c4NVb2tZBpg70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw+LRdkR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722868901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=is1WM++VT4Ceny6+rACPKsaEum5ihnLIwJEdmx2bnoE=;
	b=Jw+LRdkR5kLiYXAY8cYNYhvCLlfOw6JHIU1244UY40QgUlGaPeDACx056vOBC4nZJmgjtl
	mjZqnxBB+WHJtHipzdrZjvny0lGPSM12wva4yayDPnJkNJ2ciy5rsO32/uNcuXj+VJcAKi
	ZmglmtUa07/ibo/6cf3L8mCAVAvB1A0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-TyzLD987MNeFNFxAEuY51g-1; Mon, 05 Aug 2024 10:41:38 -0400
X-MC-Unique: TyzLD987MNeFNFxAEuY51g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36871eb0a8eso5508550f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868897; x=1723473697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is1WM++VT4Ceny6+rACPKsaEum5ihnLIwJEdmx2bnoE=;
        b=nxPP+vrPr8iUJNHVOGdqDZk6rMwGEv88zi+s+oGgsL/5NdtA/ONeN+NMWAnzLkckCr
         JTWVBBSxcQUrvWjCOHQtWUVdhLsJ+kb9m1onumDHS4E1FNrO/bWufjLZI+vhWeXOoYQY
         pKU4S2Oh5E6PijcJyZbxq786K4QpaN5CnWegEq2GgpH8Av9gioLS3sZS+wUbDoCCXIP4
         U1HNsHxTPS+Gpyb3R6puVYWsq9jBcrWrS3SP5mfxGQeRVfTRT1RJykBJKyni5ftiMbO+
         u2b+YwG1K6ZhryT3H+HP3gTkKeOLXuwceK3azMNv7gfi8OJ6d51zAu44F4OSiFgp5OtM
         gcSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjGsiizAoiW4r4WtqTNUU96fh7+EJLSbw6fySrdOsFR6HvGbLqeyb8nDwf6ZvTN7MZJ8F0zSwk2bzArSmS8P6fH7+/HZOBd4Ibgiu1
X-Gm-Message-State: AOJu0YwCt/fhRNXkIBxht7gX7yRVoYuf9M8m39gr6hiS1KF437UJq2gA
	EpyJ+CXd01MbQsSE5BhdfK4vkBsQgWxrrktfr0hV2++e0a3CLQ3bjlvPQHLvZc90xy7dYRqPe7H
	6p+COLpmZDLlDuHCXkwYdYrP04SACq1+pW2pR7aCf0peTLU07g+ftGlxbrSQbbQ9H6TPBxDkcOQ
	h5ybBJ0/xiUwj6PLd12XaHWxI0ignZWsWjpIwI
X-Received: by 2002:a05:6000:dd0:b0:368:3079:427f with SMTP id ffacd0b85a97d-36bbc12c503mr6358671f8f.30.1722868896956;
        Mon, 05 Aug 2024 07:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGORe404OR8+lZHyt0xrqRf0852CVHZ5agUPquA97aY6bZLBMVWP/j7MHMW1GPe6Vlxbu6hfVrrT5hYjROrP3g=
X-Received: by 2002:a05:6000:dd0:b0:368:3079:427f with SMTP id
 ffacd0b85a97d-36bbc12c503mr6358656f8f.30.1722868896526; Mon, 05 Aug 2024
 07:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805093245.889357-1-jgowans@amazon.com> <20240805143223.GA1110778@mit.edu>
In-Reply-To: <20240805143223.GA1110778@mit.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 Aug 2024 16:41:25 +0200
Message-ID: <CABgObfYhg6uoR7cQN4wf3bNLZbHfXv6fr35aKsKbqMvuv20Xrg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Gowans <jgowans@amazon.com>, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Steve Sistare <steven.sistare@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org, 
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:35=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Aug 05, 2024 at 11:32:35AM +0200, James Gowans wrote:
> > Guestmemfs implements preservation acrosss kexec by carving out a
> > large contiguous block of host system RAM early in boot which is
> > then used as the data for the guestmemfs files.
>
> Also, the VMM update process is not a common case thing, so we don't
> need to optimize for performance.  If we need to temporarily use
> swap/zswap to allocate memory at VMM update time, and if the pages
> aren't contiguous when they are copied out before doing the VMM
> update

I'm not sure I understand, where would this temporary allocation happen?

> that might be very well worth the vast of of memory needed to
> pay for reserving memory on the host for the VMM update that only
> might happen once every few days/weeks/months (depending on whether
> you are doing update just for high severity security fixes, or for
> random VMM updates).
>
> Even if you are updating the VMM every few days, it still doesn't seem
> that permanently reserving contiguous memory on the host can be
> justified from a TCO perspective.

As far as I understand, this is intended for use in systems that do
not do anything except hosting VMs, where anyway you'd devote 90%+ of
host memory to hugetlbfs gigapages.

Paolo


