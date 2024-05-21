Return-Path: <linux-kernel+bounces-184630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E768CA9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560282814C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284675478B;
	Tue, 21 May 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ8VP87F"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DD51C4F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279514; cv=none; b=sLAPou+fbg+hjdp2buIYhKIUNVs1l/2pW2BrA/qpor0t4/AoyeI0M1l+Rvo5ivt1l2aA1URe4AEWp9gfb/V65oW4I52E/uUynZoDpXZncOrR93L8PImesA2G4QHYu3lQverS14JI8k35cGSYNBr6F7Cs1uFKaH92PJg0AiBCcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279514; c=relaxed/simple;
	bh=iVc81OSdxb5pERXF6+iUCUmWh0yhsTTa7HTkE+s0Rgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu6/sEszAm0wO5smi1qFkyR7P/dWpbs981Fy8pEGYaoATNGL5daEw1UWb8sj0ndpZjfsyF2ggXtT9InR9T9YvbLuYkXuBeQecyr6GJOH+jmpbimtON8UthIFknJNx9kX3lrjRLuVuwT6b18729PoT3eVgBqYRJ0bc2Qo+2F8hHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ8VP87F; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57825ff689bso198763a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716279511; x=1716884311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNToKk98k1H7Spnqg2uOPUCXlDMEsg6fOLbiC3/CZak=;
        b=UZ8VP87FQkI8R+/RkJzzJsCRf02zqORd9TroTYHbY8fbTXlQLc4UteyWwarmoH/sHr
         CH/+5wV8Qr6rF2TYYiTlw4Vt4M5mfF3cQWlfyvJY6zCnPNWRqbFJ/Woc2pQqrZQLRZEK
         PYk6tkQMPF6Yy5XGnAnX3yL9D5MS/n5Ia/7uY5VXnm42n2MDtaW3W+u/KLqDOxFL3L31
         XYbkbDypUD5HejERbja4tmSshJVJSVT5NzFKGkX0Ra6yujecCafvgdXakHrRCzoa10sk
         mtIi76ru+2NKPXMIf2CqknNgXsSHyPx/8CCbWuGpma4L0FIHpp/F8j3KU4G15eGokGQM
         MkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279511; x=1716884311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNToKk98k1H7Spnqg2uOPUCXlDMEsg6fOLbiC3/CZak=;
        b=OkP2gw0I1trHYrh2iTIoE23zg/vfolm8CRHTfQWG9IBPLMtJ+K1qOLI4gPaUNpNFv+
         OgPGjLvznYDr9DfEYHgA+XnDe0jtzrT+DnSmwd1ii9MOqYkAddamYzLZ1pyieYR3tp3J
         VV0Y5knFCPCpr23wY1I3V0jSXstKjUemfYPLu40N7nZEVsObMi7+GET+YR7tn4/O6No/
         JcuJoYlx2gka0L428ZivLPUqGqddVm6GPWvuztvMpRfkoLrtWfR2XQ7VZ/pftiNYsJyf
         /v9Nsqk8K4O5RKA7uYnYGNlbuK16eJ7oaemWt0yarF89plGSTphI7/3OCcnx5ZbYCR6l
         qyJQ==
X-Gm-Message-State: AOJu0YyqN7GAIEtl2yoYhfNEwMuQSenc1gDVHkXqd5UXAqpw17/qxID/
	KJzDhQcjdAQEJZeamxaWVOMoNqGHvb9QA+jK0p2nLt940YuR2wVtjBQQybKM
X-Google-Smtp-Source: AGHT+IHlEHOib9NDYDqzIR09r1rtbz1uLpCgROxsqzFO8gPg5xl74alEy0rhcXS6byPPy9MxaQdLcg==
X-Received: by 2002:a50:bac4:0:b0:572:9f40:514d with SMTP id 4fb4d7f45d1cf-5734d67aadbmr19405007a12.29.1716279510748;
        Tue, 21 May 2024 01:18:30 -0700 (PDT)
Received: from gmail.com (1F2EF63D.unconfigured.pool.telekom.hu. [31.46.246.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfbd3sm16764046a12.44.2024.05.21.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:18:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 21 May 2024 10:18:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/percpu: Enable named address spaces for all capable
 GCC versions
Message-ID: <ZkxY04qY7spBvlYb@gmail.com>
References: <20240520082134.121320-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520082134.121320-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Enable named address spaces also for GCC 6, GCC 7 and GCC 8
> releases. These compilers all produce kernel images that boot
> without problems.
> 
> Use compile-time test to detect compiler support for named
> address spaces. The test passes with GCC 6 as the earliest
> compiler version where the support for named address spaces
> was introduced.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9d16fee6bdb8..c9e0a54f469e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2430,7 +2430,8 @@ source "kernel/livepatch/Kconfig"
>  endmenu
>  
>  config CC_HAS_NAMED_AS
> -	def_bool CC_IS_GCC && GCC_VERSION >= 90100
> +	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
> +	depends on CC_IS_GCC

So ... will this test also trigger on Clang, which might have a 
__seg_fs/__seg_gs work-alike definition?

Thanks,

	Ingo

