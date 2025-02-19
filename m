Return-Path: <linux-kernel+bounces-522704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC29A3CDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07601189C5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DE25A2DC;
	Wed, 19 Feb 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3fGHOz7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FE1D63E6;
	Wed, 19 Feb 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007863; cv=none; b=GRZ/Aynb/hnjVAQo7AqEbNMpiI1nEdAO62kx5UzsrenmNeVwhi53fnp1aP6eJsPgO3cjKPWhjT7L4k0AaR3fiafkuBUvv5NZTaHgKueJfUvVbzmNz4QdaBTUn6QwaEezxvujdfUU9t5G2QPtps2KC1d0d5ok9cmq5jKVygHr9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007863; c=relaxed/simple;
	bh=7BrzSMiKS+jH9/fqTN3DBF4ouoSiL1xdrGmLjC1j7lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPLWNS93gCDD+lwTLVfcD4zs/Vaqg6ErXh6yqM/u7x/SEPXyUWDP04OCOgg/LxTUMFSJlAE2EutsFXS8SJvH0Un351oJigz5udoIgpRXcu9/bAPIHBPLMaGAVtRLFPU8dW/s/dbi2U6/hvQvmSau+ftkorjsAG5Fs2DgRMBUGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3fGHOz7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso2756875e9.2;
        Wed, 19 Feb 2025 15:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007860; x=1740612660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dUybulOhS0kE/3bK++ET9eEzpvtsmycFrLhnO/LKN0=;
        b=g3fGHOz7PW3eAVloLI/nywgeomR07cCNNzc8CJxAJD6/78HDPw7iBWzZX4XsUNh7ZF
         1fbdLUft7zEnX+p8DxATgC9FNI/vdyxCC3wbhUEOhBs6p3Ua9vaIcdvNA2cbIwBbnEXF
         +gExa2OkZVdALzRB3lMWkXbYO1IVLxjjM+OhrpskIxmI85R4G4kSxdyWyMC0s5OVRCbB
         rfOBFWiNhBbKj7IvLTuoiY6TC6OXi/uP6oPQ/EPirhR+PMoNVxnaY8c2s7yv+u6UXU8O
         K0HgcajUO7viATxuZHkpwnQON679Eqi57uj/7dT1Eyv85LKF671E99nDsjoOOrua15DB
         gxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007860; x=1740612660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dUybulOhS0kE/3bK++ET9eEzpvtsmycFrLhnO/LKN0=;
        b=rrVZjG/UUtNFhpdaHDz+LIDG/CBoC57GSuWDojCuTI+t5btF8riEegDktZS/Rsallx
         DXv1LMDxiwj0+go2RNvkNwG9XkiPRyXylE2w0c9SOtAXIwPa1+1/zBGvu/qS5onq/RT/
         ZvH6DX/62Gg8vKJ28AJFCGA0Zt2Gl46bEMK42g9C65YQpTQDMsWdAtXKxjPU4FgM4UKy
         npWYZ3DJjYZ0+ju7Ut41CiHOmMTmwu8XrV8Hqppt7Eh6IwmqVDkdOqEbjIRug3So36b/
         cVs70Qaz2+kHXLEgV6V8Cmz4GnN6oZ91FmWnhlmHi1JOvRlDFMU8qNGAMGZGkjzVN8/i
         XMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56YVgA6Oc8jLTqCm2kX/Vk54XDsiLsHGDeTTvbV5H1ktzLl4aZ1iWnJ9kAdW8n7NOERov0fi9hgIx/9VL@vger.kernel.org, AJvYcCXrLj1plhIp49FcET3q14jmNhXdcULMAuJR/scC0nP6eRk7V9lOeiOWKi0A7iQh29gOP3m+clUQM4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5KBsCvk3AufIafUhRFgHfp8WtbczqShYGt9XxDCCAh5xKGKi
	rbCIhO1gTP/6J6WhuK8NTQUdC2NuCl0POMnCAWb3Qr93QpVk5ndi8kcT0tkw0XY7ayYXuUynMQq
	FdFYa+xtxlvOb0vPunlmDPKlZwh0=
X-Gm-Gg: ASbGncvMt7m4CSjk3QXU1ZpR4u09Vlwe8UZVPSWWZmpStyG1OtFtvOlzJ9Y2ZZpRX5M
	FNdED3zDld79PGq1ykSWy9hc38ByfPnc2x5pDfYwef9CkjpjVfbxIWc1NNu2dkKaFlDJMgkQZ8q
	w=
X-Google-Smtp-Source: AGHT+IG1BHmj8hJr/EIeAG45G5dk1X7q0NRly/wfy8NOAsFrU4xoOf+BepllUdF4Fr5/tdIMeI62DxfMSontKQGQR5s=
X-Received: by 2002:a05:600c:46ce:b0:439:a255:b2ed with SMTP id
 5b1f17b1804b1-439a255b574mr11307125e9.9.1740007860050; Wed, 19 Feb 2025
 15:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <7492f65cd21a898e2f2608fb51642b7b0c05ef21.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <7492f65cd21a898e2f2608fb51642b7b0c05ef21.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:30:48 +0100
X-Gm-Features: AWEUYZl1gRQjDF8bP12LoQKOk6SUSp8U6yzsjJnNm_UbyNhEUb3N5bt4_wbtQpk
Message-ID: <CA+fCnZdidM3Sj_ftw6pmtzw-tjy0LLD+2aqtzSewQTOUXMs2hw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] x86: Minimal SLAB alignment
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> Adjust x86 minimal SLAB alignment to match KASAN granularity size. In
> tag-based mode the size changes to 16 bytes so the value needs to be 4.

This 4 should be 16.

>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  arch/x86/include/asm/kasan.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index 8829337a75fa..a75f0748a4b6 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -36,6 +36,8 @@
>
>  #ifdef CONFIG_KASAN_SW_TAGS
>
> +#define ARCH_SLAB_MINALIGN (1ULL << KASAN_SHADOW_SCALE_SHIFT)

I believe ARCH_SLAB_MINALIGN needs to be defined in
include/asm/cache.h: at least other architectures have it there.


> +
>  #define __tag_shifted(tag)             FIELD_PREP(GENMASK_ULL(60, 57), t=
ag)
>  #define __tag_reset(addr)              (sign_extend64((u64)(addr), 56))
>  #define __tag_get(addr)                        ((u8)FIELD_GET(GENMASK_UL=
L(60, 57), (u64)addr))
> --
> 2.47.1
>

