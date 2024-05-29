Return-Path: <linux-kernel+bounces-194698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AD8D4029
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434AFB21849
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C51C8FCB;
	Wed, 29 May 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ptWh+/Qw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092F1C8FB0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017293; cv=none; b=BRGYiMmkxctvsSSjFpPoF7WpTMaC0tUjnh5NpUBWgRQfiVsjvJs+MidKeLKpG721TGsPUDNzMMO4tRA1+AzstPNJYc3NZwCu9S+DIFafPxTaEEjpJIBAwNe/zbUMLcv888JCfVsj1NpTrnk3UF6guQtmQ8grJz+PSDE7TQklWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017293; c=relaxed/simple;
	bh=xp+CT/tD0icXUGbC5J0bXRQdnp9X6jvessR57e4Cx/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW83ocmABmBTZbVJ1zeQZ1C9nVuhiEogHdY91FAhhOonfX13VLTfhEN7PZodW1yNmYKxlAx8SG5do8cm8gRhnQVNk0Na4WYCZDfXLkgy7lpTOMa29iE6FGKxyKo4GTI4Dreq3XbzPcA3lVA+tSzKPZZe0RXdK3jtchuVrJR4+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ptWh+/Qw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so360323a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717017291; x=1717622091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyPCzefD6ExSaxdr+PjCGM46RBwZY2JmPFT75MS1UY4=;
        b=ptWh+/QwXfjC0xiH9R+rH2bP1WiYDhuFIRl235qIWLe4+wFCijZH22VQmsT+7WFaLK
         65BEApyEru27jJPXb0OT1JJxFQ+Qw5W7ffuqzc0M38RV+cdTa5xmbOsVq9znqWx22QcI
         aV+TsNVdlg0bLFfhdkjthRsGwQlDXoVp3smjAJMIKoqEbgBAY2hxSdKac32LhrSG26mS
         yBxLzcXjJvwahrKGw+MRF8yAOWvSRxKWrlbFX/xohLkdGf+zCeC4d1K5o0Hq00pXkf+w
         vBIBgJ7mqVCvHZRVGtLFu7J0KwIUY2d22zHbh5Gq9im61yQ9WZaplSTeA+m8QhHUf0uL
         UjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017291; x=1717622091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyPCzefD6ExSaxdr+PjCGM46RBwZY2JmPFT75MS1UY4=;
        b=G5nx0YtSk+/8jeKc4l+cqPhqPqCaWOt6vkPvKNwc2N8ERXxelKiOEJqmbhldMna1om
         uX1nFbU5YUmAkScO//9clgYR5g9Djj4LOZhrEMqGHNBNCHWrywpxh7UuA06eh8oiP38B
         G6vkFLyb7T5UBuqAnOy13Fx5gKv0+vUIpExQu+GMHBlzMsL0iptPPsHSteIqD3z9TvHZ
         2usKstKwkrJ3zYvf3cA0NjJAS+EAkGPZ915/D5gGFyZB/0fhVydis98E8FC9WgYv6ehd
         ipiWCHX/XBEfiEHi28nVHIMGNqfHrlgwJt8x0l6PYWDxuFIuEBSmdXpfxse1ZOeSH3fn
         72jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnLdfW1ehDU3SyGcDoCCe6UUEG+xxSv88X8mFBRrk3rFGwg8XfWTqTFa3dANPTlLq8sWZgDszqy/fRMFAt12FK9eCLd2fRL6ymNJGR
X-Gm-Message-State: AOJu0YzZ7RBhrsIcqWPjgm4kTe91AG016z/jDA+xjr1LvBtPtr2zoWl/
	vCnoM3i9FgDwjyf4T9/NymxKAt7jO8UXmdxlp+ItgGIU4mDh3jHEROZV5ZVIF6g=
X-Google-Smtp-Source: AGHT+IG2IgGB1U/59maFbM1d4vodmm/pXlp59to7IcvevJSTn91eUicHERweTS3JUiNUrA0BDLmMlQ==
X-Received: by 2002:a17:90a:e150:b0:2b4:329e:eabd with SMTP id 98e67ed59e1d1-2c1acc2d94amr11415a91.2.1717017290645;
        Wed, 29 May 2024 14:14:50 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:32f9:8d5b:110a:1952])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77656e7sm237485a91.7.2024.05.29.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:14:49 -0700 (PDT)
Date: Wed, 29 May 2024 14:14:46 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
Message-ID: <ZleaxvrTZWr8I6AX@ghost>
References: <20240529182649.2635123-1-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529182649.2635123-1-evan@rivosinc.com>

On Wed, May 29, 2024 at 11:26:48AM -0700, Evan Green wrote:
> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
> causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
> since SLOW, FAST, and EMULATED have values whose bits overlap with
> each other. If the caller asked for the set of CPUs that was SLOW or
> EMULATED, the returned set would also include CPUs that were FAST.
> 
> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
> returns the same values in response to a direct query (with no flags),
> but is properly handled as an enumerated value. As a result, SLOW,
> FAST, and EMULATED are all correctly treated as distinct values under
> the new key when queried with the WHICH_CPUS flag.
> 
> Leave the old key in place to avoid disturbing applications which may
> have already come to rely on the broken behavior.
> 
> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
> Signed-off-by: Evan Green <evan@rivosinc.com>
> 
> ---
> 
> 
> Note: Yangyu also has a fix out for this issue at [1]. That fix is much
> tidier, but comes with the slight risk that some very broken userspace
> application may break now that FAST cpus are not included for the query
> of which cpus are SLOW or EMULATED. I wanted to get this fix out so that
> we have both as options, and can discuss. These fixes are mutually
> exclusive, don't take both.
> 
> [1] https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com/
> 
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 8 ++++++--
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 204cd4433af5..616ee372adaf 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -192,8 +192,12 @@ The following keys are defined:
>         supported as defined in the RISC-V ISA manual starting from commit
>         d8ab5c78c207 ("Zihintpause is ratified").
>  
> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> -  information about the selected set of processors.
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
> +     :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
> +     classified as a bitmask rather than a value.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
> +  performance of misaligned scalar accesses on the selected set of processors.
>  
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
>      accesses is unknown.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index dda76a05420b..bc34e33fef23 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -68,6 +68,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 969ef3d59dbe..c8b7d57eb55e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		break;
>  
>  	case RISCV_HWPROBE_KEY_CPUPERF_0:
> +	case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
>  		pair->value = hwprobe_misaligned(cpus);
>  		break;
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I am not sure what the "best" solution is here but making a new key is
most logical to me.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


