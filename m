Return-Path: <linux-kernel+bounces-340072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C704986E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4208282940
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C4192B76;
	Thu, 26 Sep 2024 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XGC8kOGl"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39C18E37F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337329; cv=none; b=A55CJJzke6MS7u0yHC1kNV0c9ij+Wq6X4dY0+YrAymykj+BkBCQF+nYanurCrMBpDmOlR3aRh5Ec0vDZ1s/u71EBgjwVODAgyeh6Dtl1Kh7HKhsnrH8lephi3RbcXHYw8yuW1nY4kG/Iawl4od/5gU+9O1qEtNj/GUmFTMFuFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337329; c=relaxed/simple;
	bh=9b2UAsGOg9SpZCJtJOd0VXzEm7cNSJn9y/YwV2A2PC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=en61SjBz4inZEJvdq1L3oDwQCquAkUvjItyta/fg5GxwdRrNni2h3FnKSuzlZUr3ksF7NeOjtZ9H+rhqoC3QeD9jivv9hkcSUK/0kSPMkc8fLsHZpMUw7WKZ0+j2hB+NghoJS/AuxB74ed8/jSUqlGZPvVjsEhboUvKaR4AC/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XGC8kOGl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so642944a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727337328; x=1727942128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LgZ47RUL9Q35qhgvnJyIYSeIdz+lshHPal4Oi/Rxhg=;
        b=XGC8kOGlYqM6Mn++8IRbew8l+VK3txUPLbq6ErZR2ey7mLP7zqC98ROhmpuYtZ6pVB
         DRtJayF/t9HZrr2iTK4Ge0rtaPU4/tisOycG8wim+NJlk5o2ojVIWDas6ToN9EI0fLj/
         z8DaLgNNIdRLls0aJW/ma2W/py1aOiD4K6fE3zXIBUpdXKjbEL5HH6CbT9F40lwoLdBx
         j2ySx6APSkssV/vri3kO2CJDLcA49ZWFKut74sXXVryML99pY3gQDza0iwTzupK8n1km
         GsNN+sUexz8ch9EmaJu7hYFV6VUfoAbUnFz6BwV2vTcV83NDJD/5rs+BM88GRkfm3cVH
         OR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337328; x=1727942128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LgZ47RUL9Q35qhgvnJyIYSeIdz+lshHPal4Oi/Rxhg=;
        b=duomIT+dVffALX41fjerY/vG/0HTTIRb189TBRHJiUFz4agRb3t3yy365EZPPm5mtj
         dId2dNRYod/ToDPCJvh7jUEZn50yPfhDMFaVr0M0yoAX+YN49mrFyXUv8By/XDIdvL3M
         bnjggCjsauGEeePQ/cLyiAc8ktrKinD3sGyWLNfci7ZAqU2JdQvZZR+v1OvQHxYFIBx0
         FmRifN6WbW4x9ApSDKhOZdGdiBdeHEMccE/Yd2gZyMWHpSBANHEvvXv9772KVkF+4v9m
         rSPDEtCZiRu8y3cZ1EpxtQCMd8xeeZ2pV0HuRBg8TQfhj0zK3wbmel0FZwJvaYFiI9X3
         klGA==
X-Forwarded-Encrypted: i=1; AJvYcCWqCoOObPimUkPsZ8NEe4vEe+TZKaZ8JsPBmqCofhpQ9p9N4BuLqfKp0ebY2U+ULKMNmyp+lIg9ipwhet0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsJjluZ1xoz9ox4Mcy1sfmDmumf5mN7u/Ia2Gb1x2vdev8Sdq
	hHsMui0H20QprjvWF69beTkAegHKZU1rp/CDuq+af/zr8k9bOV6QuIB7woE+TuD2Y6o4g4196Vm
	SrbmDQcXSpRraRhBCDMOGkxCYHYtDPz5U/MUQgEn3G9HbsH5iOQNHkg==
X-Google-Smtp-Source: AGHT+IGfCsPiGE2BFpV4KG5e5VOW6U22ie7unsTyky8krBo2ODZZk3WquPDzFMghPM8+SRvaTcZ5PAFYHsrzAW5xO3k=
X-Received: by 2002:a17:90b:4ac4:b0:2cf:f3e9:d5c8 with SMTP id
 98e67ed59e1d1-2e06afc142emr7296939a91.31.1727337327759; Thu, 26 Sep 2024
 00:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
 <20240925131547.42396-2-luxu.kernel@bytedance.com> <CAJF2gTTzqcNyeSAxg0uTm0JVXvE0PYuKL5qeivVSUh87FTu95w@mail.gmail.com>
In-Reply-To: <CAJF2gTTzqcNyeSAxg0uTm0JVXvE0PYuKL5qeivVSUh87FTu95w@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Thu, 26 Sep 2024 15:55:16 +0800
Message-ID: <CAPYmKFsJu8fswWD1da6Bj=GrdNvjnsyF9434e9NNP=4PKz5t6A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] riscv: process: Introduce idle
 thread using Zawrs extension
To: Guo Ren <guoren@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, christoph.muellner@vrull.eu, ajones@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lihangjing@bytedance.com, dengliang.1214@bytedance.com, 
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hi Guo Ren,

> The hardware implementations of "WFI & WRS" are different.
> - The WFI could enter a more profound power consumption-saving needed
> to keep IRQ alive, but the WRS doesn't.
> - WRS is designed for cond_load, which needs to keep cache coherency alive.
>
> So, we couldn't simply & statically use an extension check to choose
> WRS or WFI for idle.

Great comment.

I think maintaining cache coherence is not a big power problem for
WRS. In a naive implementation, the wrs instruction only needs to
maintain a valid cache line in L1 and wake up when other cpu wants to
make it invalid. This behavior won't incur too much power consumption.

And there does exist a power consumption gap if some vendors implement
WFI instruction to flush and power down the entire L1/L2 cache (for
example, provide CPUPWRCTLR register to control WFI behavior like
ARM), while WRS can not do the same thing. Whether WFI will power down
cache is not mentioned in RISC-V spec and is somehow vendor-customized
(Please remind me if I missed anything). So it is hard to use a
unified method to detect or control the cache power down behavior of
WFI instruction. And that is why we provide a CONFIG to let the user
choose whether to enable WRS IDLE or not.

>
> > +}
> > +
> >  int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
> >  {
> >         if (!unaligned_ctl_available())
> > --
> > 2.20.1
> >
>
>
> --
> Best Regards
>  Guo Ren

Best Regards,

Xu Lu

