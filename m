Return-Path: <linux-kernel+bounces-227639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FD9154DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FDB21788
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33AC19E7F7;
	Mon, 24 Jun 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzYaWLkJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D36142659
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248201; cv=none; b=VqlT/5iVfPoZ0k4RuX0cRHy2wlKDxvO1vWnZDVHyvrPx7RuX4o7m4flKsXUFxcKW/UALEwWCJIbkD96O5PdQlvS67JgcujknY6+DO/+vdpbLLLxEjHwcBH3qRjcYt6tsPDDZt6FCeugvNCQtVzAuMOA2YtiMgHAFvSsyt8uOO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248201; c=relaxed/simple;
	bh=8dC7zutNXYS97u7qMCFvxruvUdqrxOLwbSb/vRFzut0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoV7OwBWkXeMLnU/DHEDAopSof3qZwi513ppEdQvnovZVvbDcKbrlzMlmtChFCbp1cViGSBOdNUz16gxttH/7bA6XXJr3uSRn39Ytz1l0/C1L8kGPN7fmsUkb1dVOtQVCv1hVPnYslg/lMntlLf8jH7xt7cqdmvDD56QQslx+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzYaWLkJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso2973298e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719248198; x=1719852998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgpq1QF/Ve4mEImU/Kh0C9TjVcEEm8pShiW7TRID6w0=;
        b=pzYaWLkJpXO2YtEXz+5cx16fAACvEVK5zpj/Ils5bSf7qDFbGm+GGm0dVy41rDKIfA
         X/JesINVAZdNrYTXjrtjcWhT3GxcyA0Si9e/i4toMpN8SgkCtux5pCyUEiCLEwMWDcok
         h8+8ZxpA+G/XcM7N3Wow78WBfF8t1y4s2XMRz5DRHFGEdkpK0vLWS6mSAUEl0A2ErCMY
         Pgkjm4WJjec0uBvlYn0FgTAN8PTw4IPN11ZgOyxVCzb7ntY0mWqLIRLYY/g33puFrdyp
         HqhRxPg0cxL1uL6ybUzPjl5FEavc5cThnoxcbmnY5LMTHVkBDBQNBn1VBdOwyRMX6Q3H
         d4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719248198; x=1719852998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tgpq1QF/Ve4mEImU/Kh0C9TjVcEEm8pShiW7TRID6w0=;
        b=D8Bx5rGjkbswNlJHkwd+LxXo/m5h5fMi9LkmgOkZJMDQcG0VHsV4VPGhhnwwXMUiN8
         dl0nzeC28pGkFWiaLh3QbLvs4rCQ4FLID49+JdsnSrCHJrd24f40uOenlQ3/5gH+ainD
         5aPgcT+7o8qDeAF1QvSSuYgHKIONlUKFj9FfXBeR4WI+kqK9MC060g0msNDp9dRY1FWS
         Que24Nihy6ie0khTiqYPWYb5kS2Ft4kvuMDykWJFW4al7/J2QQK5MeNrIOqmdoQCMEpr
         8aa9IKe2+9NFCm5qCCSm624I+7z6ng8FxYRPNttYdTtdLjCVpr4VSWt8R8eXnbHTy2wx
         4ieA==
X-Forwarded-Encrypted: i=1; AJvYcCWsT6RC8hQUtwraIHridXK2+obIFxzEfy8jowtQ0dyAK8DptBngABHlIzGNToNMIjFTATs9LInmMh5QOI5wjBVi4gL3uHQmvtVOX0lm
X-Gm-Message-State: AOJu0Yzfpf1rqJnFxF7YcyNTr58c/4VLefMUnjRWJrJoG8TkjlOJU0Wx
	4Oc9yhUrZKQfrek3b3BlBwPkNFMVp5c64IL7UG9AaZmAFNOiR+t2lxgoZviQnTLPJMuc5crn7/J
	QO7ngwGUXKyLebn+MFQ3KjogBFQPHgUBTPwH6
X-Google-Smtp-Source: AGHT+IE8sFWItYyQrcc7D82fyGAeyAkoAiXZQQd6SdE0goCRpyIPtEQ4YkvGbn4Lbkqv8o2yAvJGQIZLNEPiIHqc+nM=
X-Received: by 2002:ac2:5de7:0:b0:52c:e05f:94a1 with SMTP id
 2adb3069b0e04-52ce186282emr3466994e87.68.1719248197229; Mon, 24 Jun 2024
 09:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com> <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
 <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
In-Reply-To: <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 09:56:01 -0700
Message-ID: <CAJD7tkYJVa=dd=hwqhJ8_-uzxFDaP6-GcTk3RdG_3DJouJ61AQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Usama Arif <usamaarif642@gmail.com>
Cc: Hugh Dickins <hughd@google.com>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"

[..]
> >>
> >> -       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
> >> +       p->zeromap = kvzalloc(DIV_ROUND_UP(maxpages, 8), GFP_KERNEL);
> > No, 8 is not right for 32-bit kernels. I think you want
> >       p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
> > but please check it carefully, I'm easily confused by such conversions.
> >
> > Hugh
>
> Ah yes, didnt take into account 32-bit kernel. I think its supposed to be
>
>   p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(unsigned long),
> GFP_KERNEL);

You can do something similar to bitmap_zalloc() and use:

kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), GFP_KERNEL
| __GFP_ZERO)

I don't see a kvzalloc_array() variant to use directly, but it should
be trivial to add it. I can see other users of kvmalloc_array() that
pass in __GFP_ZERO (e.g. fs/ntfs3/bitmap.c).

, or you could take it a step further and add bitmap_kvzalloc(),
assuming the maintainers are open to that.

The main reason I want to avoid doing the multiplication inline is
because kvmalloc_array() has a check_mul_overflow() check, and I
assume it must have been added for a reason.

