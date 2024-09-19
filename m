Return-Path: <linux-kernel+bounces-333713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE897CCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2110E1C21DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9221A0B0F;
	Thu, 19 Sep 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jojTEVFX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026619F433;
	Thu, 19 Sep 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765139; cv=none; b=JAM/AsBgahMGS2jJxdlGEZWh3hO/AjX7v1LJzH/rKL3AMOzn7eN7NhL9t0+fEXtYifYHmVqrZvIKK8d7YZvoHypV77+H/z2AEmQ6cWs/3456LHiOUr2HLjn9PNRP1G9/+RgdSv96IKXhxermA0+Ztv0eZkDBDIfeU0XB/qjoVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765139; c=relaxed/simple;
	bh=PfR3/HmcUIVzXWSn7odYFMbCiH4SxtzEjt0v2ntShuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7PzlNuAeotPaqktqit63ZXhKfCtcxVLD1hwuDs5666A3TaK0VcuVo9oqrRxQ4GprKg35QfRXNtcbIU9TsXOJ+MOI1fDmP68ZDW/xHjBNDzfdpwnM9LNi9TId7Cqooo49SsmMFzzEuJhy9w5uq8MCxVLQs2CTvZC8r63pl89B4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jojTEVFX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb806623eso9307565e9.2;
        Thu, 19 Sep 2024 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726765135; x=1727369935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+tzXQdEW/38DDu5IJpN7fDMm3pCd35uJLpLMmrIQi8=;
        b=jojTEVFXYmw2oJ2D54NgqOXYGmbETyONbHmuWcGex0OzaK4SrAZQEUKsza1PBRc5g/
         RpnTaE+LI5ariL+zZFCV9nxHPUUvepZNlzihWGVrpDuTZqXrb0jWxY0BuHMfY33Hw/7z
         vLSGbSTZSeyjVJRFUUpGh2cWg58K7vjPUCVgPpbTgcU3EdOrcgUtrKwi1PTe6YtlI6G6
         D6Nu3Paip6t83Sji9RblI0RoelT74YEy62wikEZRZzPGxuy/Q4KoNpSU0V6NrKEP9Bmn
         owF9qpMOGARBDeBfHV+rA4cgfu10wzeRtkbS/iLOFKoekNZ+lAK+7a9CVW8m9V5aU/2Z
         m51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726765135; x=1727369935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+tzXQdEW/38DDu5IJpN7fDMm3pCd35uJLpLMmrIQi8=;
        b=Y1bm4CCpTHJhmZzjW1y/B3ppyAG/zPqQwTDrbz70MBsW1/yS+EJoyKsvkB7wMoO3PW
         /0NXCN4QnSZZal/MOLEEcnT5cCZf+TA0L8I1yn2d7JrG1iBGVeolN7aAhZVRn2Ny7Qhl
         GnnXz2sZa7GN/Gw48f5ym3mi/VqxdLkexpaBmwbJEup4G9tP/uKsQtbdlvyBFBXIuqVM
         AhXbxHQxYSDW+8Ac4RqXtEkvL+z5I4VT227Qg4IRZID/rWli3VePjfqiFBz7+8/YOP5G
         OOhFM9MpfuxvPESdxs9KzkJ8hnd5rzm0+spsiHLjeFCV+jPlF/6MhQm0liJkX4YBmmpc
         KTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbjRh2ki0uji/oaWLx2BOV2o+TKs+2LPNK5O4o1D+Vux5Mp5a6CcS2YcYTeOLO0MiUWQL+BFgEg2rsZIM=@vger.kernel.org, AJvYcCWJPJRRg4OD7V6fr4IIJ9DrnQft8O+oz1x1iUDuL9ocDabGtjiCN/2fHdZOxFdw3ZESMRoFXSNo10ix5qW+Wes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5M7hhbVydn0PyULmVTokJf0pd25JJKo3a10ZkalNTqIeyf1Mt
	bhQW8vTpdBHfaUDKp5GMrkeWBhtml6TzOsd1Ecwi7/HONqGN6z01
X-Google-Smtp-Source: AGHT+IGJFVk86mlf2W401chCJXvIoaCpIV3Fsk4yvGGJ7oiuCp4IoqAzIgS4kYMXhhLjuyU+iYnwew==
X-Received: by 2002:adf:e7d1:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378c2d6165amr13847582f8f.49.1726765135285;
        Thu, 19 Sep 2024 09:58:55 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:452::1ad1? ([2001:871:22a:452::1ad1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9b10sm15630208f8f.59.2024.09.19.09.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:58:54 -0700 (PDT)
Message-ID: <f994bff3-6e0a-4d57-9c86-257c304f513c@gmail.com>
Date: Thu, 19 Sep 2024 18:58:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: fix `ARCH_SLAB_MINALIGN` multiple definition error
To: Gary Guo <gary@garyguo.net>, lkp@intel.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, palmer@rivosinc.com,
 rust-for-linux@vger.kernel.org
References: <202409160804.eSg9zh1e-lkp@intel.com>
 <20240916003347.1744345-1-gary@garyguo.net>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20240916003347.1744345-1-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.24 2:33 AM, Gary Guo wrote:
> We use const helpers in form of
> 
>     const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> 
> to aid generation of constants by bindgen because it is otherwise a
> macro definition of an expression and bindgen doesn't expand the
> constant. The helpers are then have `RUST_CONST_HELPER` prefix stripped
> and exposed to Rust code as if `ARCH_SLAB_MISALIGN` is generated
> natively by bindgen.
> 
> This works well for most constants, but on RISC-V, `ARCH_SLAB_MINALIGN`
> is defined directly as literal constant if `!CONFIG_MMU`, and bindgen
> would generate `ARCH_SLAB_MINALIGN` directly, thus conflict with the
> one generated through the helper.
> 
> To fix this, we simply need to block bindgen from generating directly
> without going through helper.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409160804.eSg9zh1e-lkp@intel.com/
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/bindgen_parameters | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index a721d466bee4b..b7c7483123b7a 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -24,3 +24,8 @@
>  # These functions use the `__preserve_most` calling convention, which neither bindgen
>  # nor Rust currently understand, and which Clang currently declares to be unstable.
>  --blocklist-function __list_.*_report
> +
> +# These constants are sometimes not recognized by bindgen depending on config.
> +# We use const helpers to aid bindgen, to avoid conflicts when constants are
> +# recognized, block generation of the non-helper constants.
> +--blocklist-item ARCH_SLAB_MINALIGN
> 
> base-commit: d077242d68a31075ef5f5da041bf8f6fc19aa231

This is also needed for 32-bit ARM support.

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>


