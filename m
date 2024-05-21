Return-Path: <linux-kernel+bounces-185485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E08CB56B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB563281B65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE0149C45;
	Tue, 21 May 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoksG6Zi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D515EA2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327435; cv=none; b=oHa81XMoe94FtchBMKBHZzb3kVCT/80IxtKoo/M3Fq6czRn2RRdgAyMtupr3jdaJTqAsqo0r842UbBq2e/o419G5QWo9KxekZZxfDhhpZr2SKJdIPCHbL0EtAIyt+aYInJGd4XIEVJIzpPLXlFymX+qduh+8s+/dYzGb2b0FXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327435; c=relaxed/simple;
	bh=fI6cEyNp0OvlkejRT4oAUfcpRMswuK3u3jTLq3XEYHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZADdZQHrGyGYEtmUjoT3rbP9zPHzUgmL0HfpzFR53aP99JCHsNk+abULEfnTY2Q6kmJS2rJUM2AMmrbVEYLMN+ntpMY3EuwxNJahepY2xTJZMJUKimbkt9y9CNs3u7kfNjxki4QuAIFjYa2XDUAsyNoaKnLqRnd5LSw6jVJjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoksG6Zi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716327433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOOUcDoB7zn51oiG2G/m9VVZoM1IpKgtfwDaxbFOJc8=;
	b=CoksG6ZiUtPLET4+kSBakc1lXAqVBnRa0hYuR/nM0Zc7LvUr2sD+h8xX+qZrR0HPMMxbq0
	SDD2D95h39aF7EL5PHI7hRBcKzhOv6FN8/OYprb+Ldf0QfmWRNqRp/eZhln65+TwskeOHA
	pyKX75mmZ3pkRj6fyp5cVDtgS8WGo8E=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0r1xThRRP3uVf-VOZumlTg-1; Tue, 21 May 2024 17:37:11 -0400
X-MC-Unique: 0r1xThRRP3uVf-VOZumlTg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-802c720980dso135444241.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716327431; x=1716932231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOOUcDoB7zn51oiG2G/m9VVZoM1IpKgtfwDaxbFOJc8=;
        b=gYY9LRCAYIb9zFqBqUXdS2sibmr8XGoVPLZw5lx6hvD1GVe0fB/wltRtbwMy7Vewv0
         zugwGO3SRFsLACpfRa9wVlUlpzpm7z+Ae2fg7JlN2iR3kYLeD9ygWu7K1vItBawzFmqp
         MzhxoViSSITwhTDOHE7Huakf3Tt8NzJaLgP88oIGXIm7r8cHvqljKAVayW4H5p427nFL
         PKJy/5NfFWTXzwyNm0B662ma5Rc6IAnqguJbzC7gIimuSCtxpgsF2wiaqxG2b7xU0CpU
         nzNR59geOMP1oPCzAHOeRAUR8snPCvoy0kfVQeopPdeOhM5i8/ApiP8wa+B47tWa7syM
         xCPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0SeDUI7iOjIVlVJ3q3gJZV3HLFoiFVxessMR04U0DaxKPkSqY4ke0aKr/GDVVgJWgsW5uzIV8Wb4r8AQ/ptAoGFwJPWD8YAcUt751
X-Gm-Message-State: AOJu0YxX+hkas8dDNHPE8keYpElH7/PirZ+cEMjhzzZJxOTIgl97zmk/
	1fLbB+kiQvT1vmci0MSlasgN44rOxNO2TMPk8fHkoH7PP4IVfqnBKO8MHtSZRF14FP1rJSBLQN7
	aQ2VnTGAcXqwFGJuF6tA5FgFbLzQFVoxhP2YiGb+GWfIyBSDH+U2K1hU/I705wA==
X-Received: by 2002:a67:e8cd:0:b0:47f:1bc9:37b7 with SMTP id ada2fe7eead31-4890a12b43cmr156654137.2.1716327431055;
        Tue, 21 May 2024 14:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Q5QA6BnBX8hYhsWYnFSu3O2ruJ4scyYeUsKVcJaDjIaZrrUh3Xl33J0obqDC+cyD4ztjig==
X-Received: by 2002:a67:e8cd:0:b0:47f:1bc9:37b7 with SMTP id ada2fe7eead31-4890a12b43cmr156624137.2.1716327430375;
        Tue, 21 May 2024 14:37:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e40f144d0sm70996451cf.96.2024.05.21.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 14:37:10 -0700 (PDT)
Date: Tue, 21 May 2024 17:37:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com,
	David Hildenbrand <david@redhat.com>, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk0UA6wABOB9X_Dx@x1n>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>

On Wed, May 22, 2024 at 01:48:36AM +0500, Mikhail Gavrilov wrote:
> On Wed, May 22, 2024 at 1:45 AM Peter Xu <peterx@redhat.com> wrote:
> >
> >
> > Did you forget to attach the kernel config?  If so, please attach it, I'll
> > try that, as my local config won't reproduce with CONFIG_DEBUG_VM_PGTABLE=y.
> >
> 
> Oh, sorry.
> Now I've definitely attached it.

Hmm I still cannot reproduce.  Weird.

Would it be possible for you to identify which line in debug_vm_pgtable.c
triggered that issue?

I think it should be some set_pte_at() but I'm not sure, as there aren't a
lot and all of them look benign so far.  It could be that I missed
something important.

Thanks,

-- 
Peter Xu


