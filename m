Return-Path: <linux-kernel+bounces-549898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BFA55854
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE68C188F25E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C66209F4A;
	Thu,  6 Mar 2025 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bTTVwzdG"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9435207E04
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295273; cv=none; b=rI8+LcWhYyT9esMxUz2JAdlXMIHdHgTX5ELfm7ntq0iCGlBo2d/X2+QX8GPmGxatnAzgUe+l6Z2tU6+ZIgv5pe/tp1i2JWdpHQdfSrvNpYsPfiVcCEL/oYl5pHfxKoVT/l19321lSb0xvFgWYvl6JkOJNxkLIk311aMQGWXc7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295273; c=relaxed/simple;
	bh=Vlo0AiwzGRy66OHyDYS0KriNF7fYNWF2EEn2K+6ZGkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSYsoRgBvl5SEiBTo6LHNNH/VPPBMAtMlJlp2l9w2Tg4febvnTI0FgKxQh3UD1tuGOi6yvku3A5WxzLJO9hZSaw77DQoAzjpGRp1sdKtaV/TtNnb3afblU0QD/es5iB8jLh6hytL5Q/6wButODjUuxHw09Bjy6Mt/4xD84U+GlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=bTTVwzdG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912c09bea5so872322f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741295270; x=1741900070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c2kNo1245tP1bETmArOySHs5HV6f6m4/M5qZ39i0p8Y=;
        b=bTTVwzdG9mug5jX3q6OmyC8MyQbhhTUw3Q4i3/3y0PM4NyfOf1ndmmh5sS4n+Kpiwq
         BJkcDCGo/I9uEJ0umRfyamYv99HJK7nIJn6UgsZTQn9WTdJbgZDg0aRhMK1n581R9DvY
         PWYrv5gcYAo0Z1JYAC2VomgRkjv4rIx+/eZF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741295270; x=1741900070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2kNo1245tP1bETmArOySHs5HV6f6m4/M5qZ39i0p8Y=;
        b=TN9+BFpcpIqKceouTLCuzgGUsvD3rZeES1bByl9EXiC1KLsiedpKxLlJexhfcFJOlN
         /gucSTo/CjWJEyeRn5pIXNauVuGPiA0A+wm/F/qUprYLY4oAT6xke3nIkCZ2tqSJX+55
         4yCnqAtFfvGA8Xo1iS6XY4Bp/G6Z4650elb5Y4AU2/LLAUztQo6HVCqHrKnGh6KTnlGE
         KLqpPKSQM99ilMzvx1fHfBV2PIP7jWi+QhSEJEt2LeAkv8bWwNWm4MCMs8qN7K2IGWHn
         mVs8yCEAzSlfng4fygszZ4Zx5BoB/c33WmGE6jVe2ZLH++pEF1+F7lapRrNhWZ514ZmY
         J+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY9r4wTzF86AcgWgteuwc1qa9r6VUwRzF9IQbLZaNHi8hqtWwbu4i/Vca2KnNCK1sxh4nkWNp7qfQc/rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY90d8N6I5bROLB5ZB15ikKSV32irTP7MZU/D9pEOPhmPyUP+k
	qzVx3N3GkeWEZ/OyeQv51T8EHPy52mIfx94Z3RnHfSna0+VGh0l1KkzD5tqFpNo=
X-Gm-Gg: ASbGncsYYgFDTG1rn5ZOrwwofHJDABPpOyt7vfHW2SDUkTcgis72MzGIQ10Y6dXoXkx
	Wt+vbf61/F7JTMJ0Sx9Yyw92Xh++YzjUm27atU/XiweguZusho4oL6kAvJUuBYrZ8j4G8VcoB5w
	t1tnDARed18xN26LKzBci+8hUE2QsTZUtke5+JTW9v3igmrnLsHTGCsJejpSgNuBh0WDUshu9be
	+ijlarYcmdMHFjAa8tHWn/cSR88sXnRwkyhVZg4g47okVbRHI9ybd9sH9boVJTOkd1Q1r3FPR2p
	h1bAnQzncGk+Gzj39XcnZLAuDpij3WHTVEV1DaTi1sOcRU0sss0rbhuZWMRJs0/jssqfZt4qtZ/
	w5BxqMPKG
X-Google-Smtp-Source: AGHT+IF/KwqCUWrwwOkk1hrlYGnd0QVj1q31c1PeWodBjakcgGYj3qpqhStA5n9FqEUIUxVMbzT3Ag==
X-Received: by 2002:a5d:5f93:0:b0:38a:88ac:f115 with SMTP id ffacd0b85a97d-39132d98703mr395285f8f.34.1741295270025;
        Thu, 06 Mar 2025 13:07:50 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8daadbsm30459385e9.21.2025.03.06.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:07:49 -0800 (PST)
Message-ID: <01a2a955-98a5-47f6-aeb2-275ba840a9fa@citrix.com>
Date: Thu, 6 Mar 2025 21:07:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/12] tools/x86/kcpuid: Add rudimentary CPU vendor
 detection
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, John Ogness <john.ogness@linutronix.de>,
 x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-8-darwi@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250306205000.227399-8-darwi@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 8:49 pm, Ahmed S. Darwish wrote:
> @@ -145,6 +166,40 @@ static inline bool has_subleafs(u32 f)
>  	return false;
>  }
>  
> +/*
> + * Leaf 0x0 EDX output, CPU vendor ID string bytes 4 - 7.
> + */
> +enum {
> +	EDX_INTEL	= fourcc('i', 'n', 'e', 'I'),	/* Genu_ineI_ntel */
> +	EDX_AMD		= fourcc('e', 'n', 't', 'i'),	/* Auth_enti_cAMD */
> +	EDX_HYGON	= fourcc('n', 'G', 'e', 'n'),	/* Hygo_nGen_uine */
> +	EDX_TRANSMETA	= fourcc('i', 'n', 'e', 'T'),	/* Genu_ineT_Mx86 */
> +	EDX_CENTAUR	= fourcc('a', 'u', 'r', 'H'),	/* Cent_aurH_auls */
> +	EDX_ZHAOXIN	= fourcc('a', 'n', 'g', 'h'),	/*   Sh_angh_ai	  */
> +};
> +
> +static enum cpu_vendor identify_cpu_vendor(void)
> +{
> +	u32 eax = 0, ebx, ecx = 0, edx;
> +
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +
> +	switch (edx) {
> +	case EDX_INTEL:
> +		return VENDOR_INTEL;
> +	case EDX_AMD:
> +	case EDX_HYGON:
> +		return VENDOR_AMD;
> +	case EDX_TRANSMETA:
> +		return VENDOR_TRANSMETA;
> +	case EDX_CENTAUR:
> +	case EDX_ZHAOXIN:
> +		return VENDOR_CENTAUR;
> +	default:
> +		return VENDOR_UNKNOWN;
> +	}

Many CPUs have ways of overriding the vendor string, thanks to
GenuineIntel being hardcoded in too many pieces of software.

I suggest you check all registers, lest you find yourself on a CPU
claiming EBX=0x68747541, ECX=0x6C65746E, EDX=0x6E65476E

~Andrew

