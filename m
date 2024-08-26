Return-Path: <linux-kernel+bounces-301020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7995EBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38A51C21613
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E413CA8A;
	Mon, 26 Aug 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3Z8bs/j/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29712CDBA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660311; cv=none; b=dNgVcPBffsQBbD19CYmNMcFMiwZLgWZBTR8dMsfzLa1h3YYhZ450vHZ9LTtiWQjh257qLxPX86+QO8KFeQRhI0oU3ZlAD184fc441XaK5WWz9rt4nwVbVyI2D/xqrJP2+fzbfsOP9uEa8CC70sic2jP2WyfWNrT+DY8C85wdTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660311; c=relaxed/simple;
	bh=idw76+ME2xVPxT+LmB/TySoa+VW38RnWwyxpzExHNjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUbQvEklKhq+qfLyYIVlnkv66NfuDNjVzFlTiNezzvzQqeVK61PPIOSgDhwYsKUKGNs3XUAZFhf7yB/ocoAcftp+qCfkeFA4bdC9HO0wPCenkCa9z8pQ4XgFnMDJ67Sx78Dfp8Seyu816gWfM/a/G77ZLFxKe9yFLsYFmPN1oUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3Z8bs/j/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so4961877e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724660307; x=1725265107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8tBE5AnV/AXnlHSwS0Jd7WPw9I4XSyg15D7PJ0BupI=;
        b=3Z8bs/j/nvv8TPDRQSXsy2ZwfroTDMKXYOWeBsaL5ryBsFszrw9Yo3XGb/zbROSmzq
         Qm8hm0HM2V3QXeMwNuPBfEafTFaE1k5wBcO+xtyPlkUNM38IakKYZr7VPtMEHEoDiifp
         gqFAIx5DM/ovd+2xbUqWdMVfVM1rXDdjU8/iQB5/0gqnH0bEsaOqJrmuAS7XHStc1Ho7
         izqSCDACntD7U9o9ymkhziNaC6JO8rguafGsmc4h2iohXHax/wi1OpUCjgtgcJF/junC
         W8YNr4sNzSqmf5edfYlItf4NeiaB2JvymH8o+TITuFjKbZmoqk/aqhm+Ap1eNv2xrs2/
         ZL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660307; x=1725265107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8tBE5AnV/AXnlHSwS0Jd7WPw9I4XSyg15D7PJ0BupI=;
        b=ovWPopLZ6k2mTRl+uz0L0sAX3RxVQtlgMTp4ceBOyfg3MFiR8CXBBS+xwwEfJPR2v5
         aJO1K6KTvWY4R9u35/MiX6abHdTBsTmKujsXjzQusmbUu4kDXml9nwC12VgHcpdqRZlo
         SYeZtbkFs44CQUPmYd3DHdHo9R0c2tmwdbhG+Et6Y7Py7INJZxAHIlaSDEvMgqqyOZ8L
         LiXWvWtFE4hR+Ciohd8C+Sn2pnw0XOjbPtQ//R+tclFkQk6JUZ/r6JJbRrOA/ksx3KVd
         tCMHlnm4ixAe7b+HDZ7PlzA42gp3dEFL8784k92RDSs2S95Yi2jCkB2hEBprBdX7MK+v
         wKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUMx3R5EJIw3vww+hw1x4P88XVwD0tZtw8F38Fb7HVU+3S/8/l0nTvDyvg6hnMiYoFCkidqXoI1weSBz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjOKiJ1GiOUmc8bnCRUBkDS1fEhVYD2IL20eua8Vq+W/kOzG2
	SjdzxMqXwrJntHYy5NHDQck9LcLHPX8O9iiu6cpq8V66rd/FphRvNoqFDBDVzs8=
X-Google-Smtp-Source: AGHT+IG1af/0IGJ0QjkvosonpMXwxq+0qen8YkX9IbP7e613sYhSI/MpkfV0auYQGrPxSpLk8aEjag==
X-Received: by 2002:a05:6512:693:b0:52c:e07d:229c with SMTP id 2adb3069b0e04-53438832ee0mr8125456e87.22.1724660306131;
        Mon, 26 Aug 2024 01:18:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a442sm145885225e9.36.2024.08.26.01.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 01:18:25 -0700 (PDT)
Message-ID: <d0a45b83-06e9-4fc6-ab90-070dd90964dd@rivosinc.com>
Date: Mon, 26 Aug 2024 10:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RISC-V: hwprobe: Use BIT macro to avoid warnings
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-kernel@vger.kernel.org
References: <20240822203913.2306574-1-jesse@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240822203913.2306574-1-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/08/2024 22:39, Jesse Taube wrote:
> In uapi/asm/hwprobe.h file, (1 << N) is used to define the bit field
> which causes checkpatch to warn. Use BIT(N) and BIT_ULL(N) to avoid
> these warnings.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> V1 -> V2:
>  - Reword commit message
> ---
>  arch/riscv/include/uapi/asm/hwprobe.h | 102 +++++++++++++-------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index b706c8e47b02..d0874ff2fd37 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -21,57 +21,57 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_MARCHID	1
>  #define RISCV_HWPROBE_KEY_MIMPID	2
>  #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
> -#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
> +#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	BIT_ULL(0)
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
> -#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
> -#define		RISCV_HWPROBE_IMA_C		(1 << 1)
> -#define		RISCV_HWPROBE_IMA_V		(1 << 2)
> -#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> -#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> -#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> -#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> -#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
> -#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
> -#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
> -#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
> -#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
> -#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
> -#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
> -#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> -#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> -#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> -#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
> -#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
> -#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
> -#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
> -#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
> -#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
> -#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
> -#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
> -#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
> -#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
> -#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
> -#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
> -#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
> -#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
> -#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
> -#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
> -#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
> -#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
> -#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
> -#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
> -#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
> -#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
> -#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
> -#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
> -#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
> -#define		RISCV_HWPROBE_EXT_ZIMOP		(1ULL << 42)
> -#define		RISCV_HWPROBE_EXT_ZCA		(1ULL << 43)
> -#define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 44)
> -#define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
> -#define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
> -#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> -#define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> +#define		RISCV_HWPROBE_IMA_FD		BIT_ULL(0)
> +#define		RISCV_HWPROBE_IMA_C		BIT_ULL(1)
> +#define		RISCV_HWPROBE_IMA_V		BIT_ULL(2)
> +#define		RISCV_HWPROBE_EXT_ZBA		BIT_ULL(3)
> +#define		RISCV_HWPROBE_EXT_ZBB		BIT_ULL(4)
> +#define		RISCV_HWPROBE_EXT_ZBS		BIT_ULL(5)
> +#define		RISCV_HWPROBE_EXT_ZICBOZ	BIT_ULL(6)
> +#define		RISCV_HWPROBE_EXT_ZBC		BIT_ULL(7)
> +#define		RISCV_HWPROBE_EXT_ZBKB		BIT_ULL(8)
> +#define		RISCV_HWPROBE_EXT_ZBKC		BIT_ULL(9)
> +#define		RISCV_HWPROBE_EXT_ZBKX		BIT_ULL(10)
> +#define		RISCV_HWPROBE_EXT_ZKND		BIT_ULL(11)
> +#define		RISCV_HWPROBE_EXT_ZKNE		BIT_ULL(12)
> +#define		RISCV_HWPROBE_EXT_ZKNH		BIT_ULL(13)
> +#define		RISCV_HWPROBE_EXT_ZKSED		BIT_ULL(14)
> +#define		RISCV_HWPROBE_EXT_ZKSH		BIT_ULL(15)
> +#define		RISCV_HWPROBE_EXT_ZKT		BIT_ULL(16)
> +#define		RISCV_HWPROBE_EXT_ZVBB		BIT_ULL(17)
> +#define		RISCV_HWPROBE_EXT_ZVBC		BIT_ULL(18)
> +#define		RISCV_HWPROBE_EXT_ZVKB		BIT_ULL(19)
> +#define		RISCV_HWPROBE_EXT_ZVKG		BIT_ULL(20)
> +#define		RISCV_HWPROBE_EXT_ZVKNED	BIT_ULL(21)
> +#define		RISCV_HWPROBE_EXT_ZVKNHA	BIT_ULL(22)
> +#define		RISCV_HWPROBE_EXT_ZVKNHB	BIT_ULL(23)
> +#define		RISCV_HWPROBE_EXT_ZVKSED	BIT_ULL(24)
> +#define		RISCV_HWPROBE_EXT_ZVKSH		BIT_ULL(25)
> +#define		RISCV_HWPROBE_EXT_ZVKT		BIT_ULL(26)
> +#define		RISCV_HWPROBE_EXT_ZFH		BIT_ULL(27)
> +#define		RISCV_HWPROBE_EXT_ZFHMIN	BIT_ULL(28)
> +#define		RISCV_HWPROBE_EXT_ZIHINTNTL	BIT_ULL(29)
> +#define		RISCV_HWPROBE_EXT_ZVFH		BIT_ULL(30)
> +#define		RISCV_HWPROBE_EXT_ZVFHMIN	BIT_ULL(31)
> +#define		RISCV_HWPROBE_EXT_ZFA		BIT_ULL(32)
> +#define		RISCV_HWPROBE_EXT_ZTSO		BIT_ULL(33)
> +#define		RISCV_HWPROBE_EXT_ZACAS		BIT_ULL(34)
> +#define		RISCV_HWPROBE_EXT_ZICOND	BIT_ULL(35)
> +#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	BIT_ULL(36)
> +#define		RISCV_HWPROBE_EXT_ZVE32X	BIT_ULL(37)
> +#define		RISCV_HWPROBE_EXT_ZVE32F	BIT_ULL(38)
> +#define		RISCV_HWPROBE_EXT_ZVE64X	BIT_ULL(39)
> +#define		RISCV_HWPROBE_EXT_ZVE64F	BIT_ULL(40)
> +#define		RISCV_HWPROBE_EXT_ZVE64D	BIT_ULL(41)
> +#define		RISCV_HWPROBE_EXT_ZIMOP		BIT_ULL(42)
> +#define		RISCV_HWPROBE_EXT_ZCA		BIT_ULL(43)
> +#define		RISCV_HWPROBE_EXT_ZCB		BIT_ULL(44)
> +#define		RISCV_HWPROBE_EXT_ZCD		BIT_ULL(45)
> +#define		RISCV_HWPROBE_EXT_ZCF		BIT_ULL(46)
> +#define		RISCV_HWPROBE_EXT_ZCMOP		BIT_ULL(47)
> +#define		RISCV_HWPROBE_EXT_ZAWRS		BIT_ULL(48)$

Hi Jessie,

If I remember correctly, files that are in include/uapi/ should not used
defines that are in include/linux/. In that case, _BITULL() should be
used instead of BIT_ULL() (from include/uapi/linux/const.h)

Thanks,

Clément

>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> @@ -85,6 +85,6 @@ struct riscv_hwprobe {
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> -#define RISCV_HWPROBE_WHICH_CPUS	(1 << 0)
> +#define RISCV_HWPROBE_WHICH_CPUS	BIT(0)
>  
>  #endif

