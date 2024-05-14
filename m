Return-Path: <linux-kernel+bounces-179213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49A8C5D77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A441F21FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3A181CEA;
	Tue, 14 May 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c4ph5UTE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A112181BBB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724231; cv=none; b=Fq0TlT5LTquCDZo2VNh7xQTb2fNhysymIt2cZ3ilHGg/efD/AlqYSQXvRh7DS9Tv2Z+aOxYZ6b1Nl3OtdJT1sw2M8YYNp6CwtoZFZCDnn4/lotiobcOxfPyi9G1ka33HKgOgk8YgP4DLTqFUZl2xtIkkU4HttAHaaJ855yOBlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724231; c=relaxed/simple;
	bh=gmjsQJg76AF0rBjoZFW5AFzN8fWfAw46dbA4FZIhxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md4jPSu77lJMlF2cODx1oxV0A2RkoyNTyEjovSaHs/BUAn5UD4AU/3L/yaVHtA/8rN5YNV5wEOmXteQsSkJYK5N1uXMJ04eXT4JE1Mnu9guFUjAtoZagGNpfkmzYlOJbzvDDzEP+4cuOcitxv20IUUHNvMHtdZWNMIvoabz1XYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c4ph5UTE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f447976de7so5344390b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715724229; x=1716329029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkiSNZElAJybtnCmIixSp8O/INwHpHiOAq0SsZz+2kI=;
        b=c4ph5UTE4tt8GiFBlm4HjS6iUuPaASkKF53D0IiBBYFwfTF31eYw+jinKR0v4jklVm
         oL1cZZrVt5xv8lCl3McQv3ufXjY84wu7VX2ht9BDAv5vprRP8+91uISqQewl5wF+0g7T
         dOpim/2NDUs5T1uHSEEJRAikXrxl7/0WsTlA8fayCdCZyXvii9qkDuVvC4Mfu8qlpcxa
         tXf/P58TYhVJRCcEW0f5wGo2tuZc1KrDw+NkAPWFMn37MU44WJlZwU9TpjJViatdRYfc
         FfHISbcisXAN0F7bPwzjdoPi9R89hfcFOev6rJfZ3dVMwuL72cAfWgjlo+4A1eNfkdIu
         qkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724229; x=1716329029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkiSNZElAJybtnCmIixSp8O/INwHpHiOAq0SsZz+2kI=;
        b=p8vjb8JPnVRGT8w1yp0qz37MxTDh28C6JLoG8HE+wNxIfb/sOgwV2hGyfuLScTRDMQ
         FHWMuV+q8XnM+Kmffrw27xE32xImhvQS1pBfFRg0gYLRuFaWIilBDYBbXLQxxpSDJcR6
         J6sJVWHgDJd/q7AGjK6g/lUYVHPxmJsJlfDigMvOdzxqg+uevrx/glf8Q3jBVv5igMBU
         EQd/EmThB7biYA5jk5l7x1kpIorM9CaKEdgYajRSFoxm+pK/Voeow+OgplTIwzxJo7fg
         L9QEKUyEstS5WF0Z0DMrYviVvZpkBKFEo9xrulamw8Pnl1Ek1k74hDRbusvfVz/H/XtT
         Kp8w==
X-Forwarded-Encrypted: i=1; AJvYcCX6ynf5EJCdd4NDvVBPZDVQZYFtb9kGM+K3/L+uRVsoHLQwQHSWzJX4iJzmKw854c6Xr9ttyst8voorAtYjN5hehPvMyZ63cj0bWs8y
X-Gm-Message-State: AOJu0YygGL8qsZS8IRRfz2FF9gRHE15Osk9oiTvNS4gmARGYv4ZJ64XJ
	Z0qUI+8isI6KdJW8KQKGbMeies+JYfPWU7SglmlQkhK7Vp3BdfFloFFqIZtUSMh/hDpLyzHBvyt
	C
X-Google-Smtp-Source: AGHT+IFzz6no4CjoUbD4CmZsphn6hLm+cR/XvpBU0wg3uHhiu2k35I3C2xLgsT9+XMdGuUICVA/YGg==
X-Received: by 2002:a05:6a20:5527:b0:1af:d647:3108 with SMTP id adf61e73a8af0-1afde0af5c2mr12122015637.2.1715724228879;
        Tue, 14 May 2024 15:03:48 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf32b4dsm105280505ad.137.2024.05.14.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:03:48 -0700 (PDT)
Date: Tue, 14 May 2024 15:03:45 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: Re: [PATCH] riscv: do not select MODULE_SECTIONS by default
Message-ID: <ZkPfwRj+QR2okyJv@ghost>
References: <20240511015725.1162-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511015725.1162-1-dqfext@gmail.com>

On Sat, May 11, 2024 at 09:57:25AM +0800, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> Since commit aad15bc85c18 ("riscv: Change code model of module to
> medany to improve data accessing"), kernel modules have not been built
> with -fPIC, so they wouldn't have R_RISCV_GOT_HI20 or R_RISCV_CALL_PLT
> relocations, and handling of those relocations is unnecessary.
> 
> If RELOCATABLE=y, kernel modules will be built with -fPIE, which would
> reintroduce said relocations, so only select MODULE_SECTIONS when
> RELOCATABLE.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..3f92dd3b45d2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -169,7 +169,6 @@ config RISCV
>  	select LOCK_MM_AND_FIND_VMA
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
>  	select MODULES_USE_ELF_RELA if MODULES
> -	select MODULE_SECTIONS if MODULES
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ
> @@ -858,6 +857,7 @@ config PARAVIRT_TIME_ACCOUNTING
>  config RELOCATABLE
>  	bool "Build a relocatable kernel"
>  	depends on MMU && 64BIT && !XIP_KERNEL
> +	select MODULE_SECTIONS if MODULES
>  	help
>            This builds a kernel as a Position Independent Executable (PIE),
>            which retains all relocation metadata required to relocate the
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Looks great!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


