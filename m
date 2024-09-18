Return-Path: <linux-kernel+bounces-332243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572A97B721
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0700281DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA78248D;
	Wed, 18 Sep 2024 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ig9kuF2k"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302E15A8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726631380; cv=none; b=GIhvYkzIIYZuxHs+A592VNe+3rR4NdVBhRQfyZ0eQi76j187glvfQIkO2+m15kDvSEqJ6flSVnjkPpqjwolRpk7bpvXHSz0guKy0zpvRLP3dwjt1Ea7o1QpO+jhlo6VdVuu0UtRspblnE/y26yor3gqdR5EZpLMsFmVF+UImFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726631380; c=relaxed/simple;
	bh=jFTBrvXiqayWkT6ooMaQbB058hNxSap7Piq/nhT3hmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb2fd6rws21RGdVB0iyQc7cBkuP80im389raRLSUNNepX8fScsGPfYv4CQt0ZKX5PUFm178Y1XTuwv8sdKVTWr9iGy+18aU5nBh/iXUMhovwWZ+iW0bXsJwG8wVyy/YQNKlTmx+zzgjZDjnRryXm1ZdREjEzsknYBND8gSm4JuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ig9kuF2k; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e042f4636dso2628184b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726631378; x=1727236178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE1dJbAWhCPBAK0t0zhX3bNIT7kXRFcGehfITM1od0w=;
        b=ig9kuF2kR1+2Yyb75Y386uwSPqBkT9v26MnHQ+1V8rJU35+wxtUwdCbsnmuGG9HOep
         lN8opqQs/SjiqvK/uV4bScRMmcYjk8zNQQHF1CtWF7EyDd+AnXefOEakLQmnjfXpHrEt
         apzNQw1tctQM4bVz1GO63+Iaai2aM67ixi3o5tp4QEyPtKwN5Us6NVn9HIHs4yIOQfaS
         NyqMuKo9bqPN7irq9W50yF12wcG/Qgb/oVjbVx39tQ8YqIh//dbNk62PUOZOQ0UMDp/Q
         pGgnepq51DH0mVtFI9WWEbLAmQLYnyW7hpFhhXiNfnbBJ93333nhrwrwQ9rbhdPTP069
         oIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726631378; x=1727236178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE1dJbAWhCPBAK0t0zhX3bNIT7kXRFcGehfITM1od0w=;
        b=N6B7EMOIz/PvYhkjkuJ2Hx06hftnsqr06X+bAjkSaquRhrHLiCmIcnRyTCpG/yAgbI
         jJwTBRcbErZhFQRQ0CY2oxbJIZubXwuOlbPOkGtaJs8GK3lcXz2dqraHOAlJKLxeCPL0
         u46xKqzWGPXhCBMx9wXIgYfP3MfvfuoDt5aPThpUT8FPRYeKbK5qdUiv+bnGEcBvKlZE
         lSpwhRGiK5mEV0uLMDT42LIbLq9uC8/1/QQcG/u35/Tggt59ZkZCqGlzTcSRzT7S6DBW
         RaggyOKZAgmQrE9yUylOIHckGF6/cFRr5hmA+4Zxk7opynBU0+rlX6tuz4M9F2nsaBGH
         A2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUA73bWkjY51DSfI0ZDB+n8wzu4AK21WDsq+qC8Jr4Ojp39Nu775ZN9M+xfuyPA4udTqx/tKPg8nu9PmEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgcQksRQq2r8f/Ej/9ZpncpxJgl2bTTYsCI53lNqHnJZthGMO
	tcuPt3zyxFpvq9zstu98b2Oc/EXmD/TPIVCG0IaODrKCTsF4efKYqoPXn/szWVwdo3ZWMCLpPY+
	kFdD+Us6T8SDFsBp9ILb7e9tEIonZf1c151bBQQ==
X-Google-Smtp-Source: AGHT+IHeC3dsKkrJc6ljF9R1rShW49VPA4Ien1gEXCjQwV42Ui98RWbpm6Atdeb+k67hVyRYS7hwlqTZVvQQpFlTolA=
X-Received: by 2002:a05:6808:3190:b0:3e1:7061:39f7 with SMTP id
 5614622812f47-3e170613b17mr7499049b6e.0.1726631378299; Tue, 17 Sep 2024
 20:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814062625.19794-1-cuiyunhui@bytedance.com> <afaa4192-da08-4180-a09b-2b953293ba76@ghiti.fr>
In-Reply-To: <afaa4192-da08-4180-a09b-2b953293ba76@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 18 Sep 2024 11:49:27 +0800
Message-ID: <CAEEQ3w=S=Gn9qER=qNwUn8+Gs9AN4Y5-0Zg0w8-4Vps4L7n97w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: add a warning when physical memory
 address overflows
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alexghiti@rivosinc.com, chenjiahao16@huawei.com, 
	guoren@kernel.org, vishal.moola@gmail.com, stuart.menefy@codasip.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

A gentle ping for this patch.

On Thu, Aug 15, 2024 at 7:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Yunhui,
>
> On 14/08/2024 08:26, Yunhui Cui wrote:
> > The part of physical memory that exceeds the size of the linear mapping
> > will be discarded. When the system starts up normally, a warning messag=
e
> > will be printed to prevent confusion caused by the mismatch between the
> > system memory and the actual physical memory.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   arch/riscv/mm/init.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 52290c9bd04bd..c93164dc51658 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -236,8 +236,12 @@ static void __init setup_bootmem(void)
> >        */
> >       if (IS_ENABLED(CONFIG_64BIT)) {
> >               max_mapped_addr =3D __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
> > -             memblock_cap_memory_range(phys_ram_base,
> > -                                       max_mapped_addr - phys_ram_base=
);
> > +             if (memblock_end_of_DRAM() > max_mapped_addr) {
> > +                     memblock_cap_memory_range(phys_ram_base,
> > +                                               max_mapped_addr - phys_=
ram_base);
> > +                     pr_warn("Physical memory overflows the linear map=
ping size: region above 0x%llx removed",
> > +                             max_mapped_addr);
> > +             }
> >       }
> >
> >
>
>
> A bit weird to review and test my own patch, but here it is anyway :)
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex
>

Thanks,
Yunhui

