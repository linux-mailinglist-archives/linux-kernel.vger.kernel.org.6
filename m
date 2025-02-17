Return-Path: <linux-kernel+bounces-517729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C980A384D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E803A5628
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1521CA0E;
	Mon, 17 Feb 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QNw2GuXS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD95216E35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799248; cv=none; b=pu4IfyTCnIpRD5vVKGk5OQcL08CfET2fw/1TJRzd2SGvf1J8qqzxHB+7c+qHJGm6nZsCrEyTYYwZ2Q3IhmzXPKPfen0hLpiyP0lLSKUx52K81Y5j5KV3zfcCtNnYmAAWreUZB6vjQc9uLmeSmyTQFzYmLyU6WlalaKKxyVSUhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799248; c=relaxed/simple;
	bh=nWLEbWpGOttfDGud3WCgzhSqY+v9U/t3v+5odapcK9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKCMzNzNHKpKQ9JTUArAXVlaI0LTcGP3/G6iaFnsAlb6t+JFI9sb+gF4XHKGdJN0N9tytERMrPfTswASqo45PJ8Taryry85UslF9Wx4r0+hw1wkUXc13KXwyXebUo+D2bWnoHvMTm+ezy4tL8kZDXLZKW6zfApqRFahOe8KjzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QNw2GuXS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E844A40E01A3;
	Mon, 17 Feb 2025 13:34:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q5whEWvOXJ4Z; Mon, 17 Feb 2025 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739799240; bh=DXWApFL1gDBRijNF8a1Jpwo2qEyBu7UJ1LfTD9wMDDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNw2GuXSmHi9Fjvjy+0FCID/fT5IMJKLzwSDvQj5xoxOxTjI/X0K5hg2xib2olA3y
	 MHL8BF2ud5jICMdsqKTXNjbmR2pa6WnhSVt+hIBwO98CnhS/8I0SOz5NxHM3LH1vJc
	 VRKU9iiqzzgmfIKrz+TyKbgN05IAHgdKDpfCEiv/22bQuJbgUWx5jhJ2YnLfeM1UWk
	 Ml3S0e6tDPnqP8f1n/v1OfYCoAQRj27dexkPyINaPYKd5OZaUAblJmVCemmac7G2+z
	 U1b9mwnrTbuavrZYChOhb6N4KeMvsnDQgCHuu6uxFt73P/1+BAAOz6SOOFq8Iw4jyU
	 j3H35chyVlgP1N1YpMtXnXdG83xC00E/PLo9hYYQM+m3l1gHLwWIl2QZz/7s/AmHeq
	 kGOjA7j643GMenf39tlzOZBKwXHsvTUMIpYLbWOV3x7POn/6edB0cQA+a9f3wb4GGB
	 UEyDelAMNvMBaZTJlsPohxKz5ymZPIxvEtzVTrWHToATej7JW0pfmq2v+b1nNK43K/
	 dPfZkAk4S+Fj7KbLC1TTOexRhWmajY9t/JtUlabclnKwKmdITJCRSDTJovM3X4JHKx
	 0tDtss0d0u8OzOZnAQAo22hmvWO6moaVqG7uTH4QHB9u7ukqqAZDBW6rJ5nNfm/wws
	 V+OEChMndunUOIbvbM48v4q0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96E4F40E01A1;
	Mon, 17 Feb 2025 13:33:54 +0000 (UTC)
Date: Mon, 17 Feb 2025 14:33:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 1/6] x86/microcode: Introduce staging option to reduce
 late-loading latency
Message-ID: <20250217133348.GJZ7M6vFdZtXDd0lF0@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211014213.3671-2-chang.seok.bae@intel.com>

On Tue, Dec 10, 2024 at 05:42:07PM -0800, Chang S. Bae wrote:
>  static int load_late_locked(void)
>  {
> +	bool is_safe = false;
> +
>  	if (!setup_cpus())
>  		return -EBUSY;
>  
>  	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
>  	case UCODE_NEW:
> -		return load_late_stop_cpus(false);
> +		break;
>  	case UCODE_NEW_SAFE:
> -		return load_late_stop_cpus(true);
> +		is_safe = true;
> +		break;
>  	case UCODE_NFOUND:
>  		return -ENOENT;
>  	default:
>  		return -EBADFD;
>  	}
> +
> +	if (microcode_ops->use_staging)
> +		microcode_ops->stage_microcode();
> +
> +	return load_late_stop_cpus(is_safe);
>  }

Why are you even touching this function instead of doing the staging in the
beginning of load_late_stop_cpus()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

