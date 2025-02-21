Return-Path: <linux-kernel+bounces-526192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5238DA3FB66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C6883FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203471D5166;
	Fri, 21 Feb 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLtOcRHZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C5442F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155206; cv=none; b=LON3PCKY+wmmkTbrdi+O94nxvYqq8PH6t3t9Z8jsese0Wv9nWw6B97oxAD+gMXW64rUmKw4DuSfDPFqsx4FyY6eDXuFfD3UrsozB3AVabVHlgp9HcfSToiVEg7HVAq+goXxi3HV6Qxpjk7UvPIuLjhsbZDenT4wPQ5IC8Z6roPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155206; c=relaxed/simple;
	bh=wnOFlB8KUulQ0HaRITKvcaiCCRIdq9wHPOnMzDH7Ods=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8HxWkP84Kspx0jraN4eQ3r3M23661S9uR6IDUdRA+k7F9DG5RaWkNXD7VH3mf83Plg8ZRGz1KPWhDXFTB3wrG7YKejY/Bu9fUvtpMdpj0mjdl3vnMMxxhCSlKUaPpIE9353UnmraO7eFDqCdI+puVoo8hQM59LdU3uHfXTZzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLtOcRHZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740155205; x=1771691205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wnOFlB8KUulQ0HaRITKvcaiCCRIdq9wHPOnMzDH7Ods=;
  b=mLtOcRHZfgI8Q4vnwDsZA0gEa/QTgSkFCq+IL0wXR3dhf0vddNTwh7nv
   uHEQX5o4zNUakiHA0v/1QAT5hRJy8/DICcfSqk70svIDxEYzpi+m9KKv+
   Cv/DJ7zmoDcQZd2FhU/aIs1I2Eqh/6Gi2vYNo4zSo+/n5sbAGeYdr6Tt7
   HVtDB1uCN/HB22aEtcWEwdZwmzNI+Xepb/1jpxQKiRzC3lPuQ2JhuGbeW
   pGU+TQ+uM8+kzAR8SogINroWVVbOwJGQrB4czqYVLSiBAupDz5u8eL+yu
   ObZFkwv24nSk4RDAjdr2x2DRvINxnda86EMphOmPWxQlU0shXX9SCuJyh
   w==;
X-CSE-ConnectionGUID: CE1MTBdsRXWrTrS5Aq0rhQ==
X-CSE-MsgGUID: ASRMwXUhQXyDiZEACOVkAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63451912"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63451912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:26:44 -0800
X-CSE-ConnectionGUID: +Ol+TIdYRp6fR8X5P4UvqA==
X-CSE-MsgGUID: elZ0qfpyTLCQajgicGEwkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120337275"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.110.177]) ([10.125.110.177])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:26:43 -0800
Message-ID: <d6d7745f-ad25-4faa-a3a3-65a4604e8592@intel.com>
Date: Fri, 21 Feb 2025 08:26:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/signal: Use switch_to_permissive_pkey_reg()
 helper
To: Dmitry Vyukov <dvyukov@google.com>, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <6a97e9986b0fb05935204f55f8d16fc5e66f0ccf.1739790300.git.dvyukov@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <6a97e9986b0fb05935204f55f8d16fc5e66f0ccf.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

...
> -/*
> - * Enable all pkeys temporarily, so as to ensure that both the current
> - * execution stack as well as the alternate signal stack are writeable.
> - * The application can use any of the available pkeys to protect the
> - * alternate signal stack, and we don't know which one it is, so enable
> - * all. The PKRU register will be reset to init_pkru later in the flow,
> - * in fpu__clear_user_states(), and it is the application's responsibility
> - * to enable the appropriate pkey as the first step in the signal handler
> - * so that the handler does not segfault.
> - */
> -static inline u32 sig_prepare_pkru(void)
> -{
> -	u32 orig_pkru = read_pkru();
> -
> -	write_pkru(0);
> -	return orig_pkru;
> -}
> -
>  /*
>   * Set up a signal frame.
>   */
> @@ -157,8 +140,18 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
>  		return (void __user *)-1L;
>  	}
>  
> -	/* Update PKRU to enable access to the alternate signal stack. */
> -	pkru = sig_prepare_pkru();
> +	/*
> +	 * Enable all pkeys temporarily, so as to ensure that both the current
> +	 * execution stack as well as the alternate signal stack are
> +	 * writeable. The application can use any of the available pkeys to
> +	 * protect the alternate signal stack, and we don't know which one it
> +	 * is, so enable all. The PKRU register will be reset to init_pkru
> +	 * later in the flow, in fpu__clear_user_states(), and it is the
> +	 * application's responsibility to enable the appropriate pkey as the
> +	 * first step in the signal handler so that the handler does not
> +	 * segfault.
> +	 */
> +	pkru = switch_to_permissive_pkey_reg();
I think this hurts readability too much in the get_sigframe() code. On
some level, it's silly to have a basically empty helper. But in this
case, it does help keep the signal code readable.

In other words, this would be preferred:

/*
 * Keep existing big comment
 */
static inline u32 sig_prepare_pkru(void)
{
	return switch_to_permissive_pkey_reg();
}

