Return-Path: <linux-kernel+bounces-238631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F31D924D20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000F283DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B01FAA;
	Wed,  3 Jul 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL6RtaIb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B19184E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969593; cv=none; b=SiC1lO3pIdlth9HNh5d7x8xk84OBwcXDIMoN6XHu1X6g166IP8cO/DvrwvpFgWfg15AZfQ84Txr0w3OnN83rjDL2EsPhPA/mYnvtAEMO349I8pY8BIChuTRYK9TuqDArMhxhwKONUzDl4XWofltdOsVvtBKtf0rXXdwREgEeiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969593; c=relaxed/simple;
	bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2odKXJa9iC96m3jvw7Bl1i6AWjOcAwtjoKV3csGWf3yw72JXBWUfpJAtxPuKLNSz14PJci49/8wlB5KjGeVFFXIctG9DjJLGlr8hAxC591IYShlxs+Y5BKQCNiF2KA2C37e+u/2u9pKY12wBfDVcPqQj9vSQfAsV+cSesT4C3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL6RtaIb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719969591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
	b=FL6RtaIbTmYUr+pKRYUsAnGGDEy0Ix9rAvL9lktvMOpNi/TJJKQdEB5E8G0+o8CoXMmFI/
	g/lIwChyn0apmG3dqg+gWwuYoK/IrO9TIaBEIhMQT2gnqGmEW0EqaupQIJMr8gcDILgBus
	MJ7ta8NFtnbBK/lI5N5/7vkljddIU4g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-2m_FxH2POGWpo67TFaEHKw-1; Tue, 02 Jul 2024 21:19:49 -0400
X-MC-Unique: 2m_FxH2POGWpo67TFaEHKw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec55065e52so43715621fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 18:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719969588; x=1720574388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icvHM6vHx5tc35KsWjVeZnOUrDfdLw9A4yDiG4jpE1M=;
        b=uPWdhtaQwCkNdein4tQdsoV+RBN+Dbejhr16x7+RFhEyI9r8SVofaIsxwBHcYEqDMH
         hor45J4tkCvrBuVN83avJ/f3xiKg2GFj3UXc8xWI7bOr7wmK6VGOcuhKELC0bp3sfosj
         nb9MarzdMELdppn2bwXtakqMkDCMwzHvaeI2zUBu7afp4ZkkwI2/ggzEHpKCRu96ORvP
         H6WVqbNBnuu9sjG7BiKiyyxSxdEp19ofwRryo9wU8ccq+5JIPAa6bpPiT8YuABDenbB2
         6cjSRKXXbuoW6j4TmUcRsWtaSnR5QPhaoUPDe514Tq9xCMlSp0qkG/rx5oLr0M90ZD2m
         6vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCAUVD5DvJqIYqG6NF4BKFGwW4b8AmYZ89J7UelLxTGC23UeOf+n2Povd8FG1Dxcbl6y/Ree9CU+QIB+w35Brlrjeh7zdI1XDvueC
X-Gm-Message-State: AOJu0YzHkYH1PcMsqSe3L1+w911SbxN7XwtXpLBB2Xs9cbsmXqTLJyEC
	BXMW+r8vrmIQLCdRjFywppQDsR1iLNfLS0WqSsQFOnUHfDvDnBAQLDyrud2fkp7PLJIdHFUetBl
	k4B3rz/6QiWTPvyYhXiMwWBhbSIc9cuWG+mcycruY+uVlWVHNUdNF+kOFbksLSpooUx3EeCQguI
	e192Fbprcvxc6VCprsWBAkhn/j5r2v/uR+mdeI
X-Received: by 2002:a2e:87da:0:b0:2ee:84af:dfc4 with SMTP id 38308e7fff4ca-2ee84afe254mr1112281fa.43.1719969588354;
        Tue, 02 Jul 2024 18:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSlLCK3MniAmeHCNTRdpfutNVFg4NqDVwYsLGRYKV+Sfjk7uWrrnhbyYN8jIK9spnz0JpXL33Bgon8txPAoQ=
X-Received: by 2002:a2e:87da:0:b0:2ee:84af:dfc4 with SMTP id
 38308e7fff4ca-2ee84afe254mr1112141fa.43.1719969587971; Tue, 02 Jul 2024
 18:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
In-Reply-To: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 2 Jul 2024 21:19:36 -0400
Message-ID: <CAK-6q+hCQNg8XK7v86hhgsgPu2c_aN_+xRZBzTG7DQ-fee8vRg@mail.gmail.com>
Subject: Re: [PATCH] filelock: fix potential use-after-free in posix_lock_inode
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	=?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 2, 2024 at 6:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Light Hsieh reported a KASAN UAF warning in trace_posix_lock_inode().
> The request pointer had been changed earlier to point to a lock entry
> that was added to the inode's list. However, before the tracepoint could
> fire, another task raced in and freed that lock.
>
> Fix this by moving the tracepoint inside the spinlock, which should
> ensure that this doesn't happen.
>

makes sense to me. Thanks.

Reviewed-by: Alexander Aring <aahringo@redhat.com>

- Alex


