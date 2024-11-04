Return-Path: <linux-kernel+bounces-394583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FF9BB16D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351521C217E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A53199FD3;
	Mon,  4 Nov 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dWc7O6gK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238D290F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717128; cv=none; b=bn8m09zxnVJ6x8LEaQiROfRwrYW1XZZXP68f7XcDAgNxwsMHN/AlC5uqQmLJQhKPe+g2E4Fl+vDltCCLi+SvNVPC3ZqQRmOdb9h8922ZHnolRJSxmD1xaIzW8vfY1/jtZIdSK5UkRw+59hWYEv4qR6aPx9FRkWO/RfmCJXERNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717128; c=relaxed/simple;
	bh=mimCO2RIw7IpcTKa/9qpJ4echdy4H5giHHQovNW8o1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC7n8auHaTC6V567/5Ih0G5RgsLunvU+38FXdjn9OYm+fNTLQqzIMH/RlmxmKXgvfmH7SPuER15Xi38xTiEkrVRL/v4Kwh03AnfbrRy0ljf7Zu/EOx51RlCHxlE6oyFGa9oIKXiz4ounnYun4yp1Pqo0stwt/H/ZgbYq1smP+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dWc7O6gK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 905DE40E0263;
	Mon,  4 Nov 2024 10:45:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id knthAzzkWCyt; Mon,  4 Nov 2024 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730717120; bh=Y79FvdVo8V6y+OzWYcGAzlO5DaOUiFRUHsT9yHWaLdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWc7O6gKiNWxp0GTAYt9sh41rqSVewOXBR8xnOlOSfdnuF+W9sgyTE1VfO1WDJNrb
	 Q8tzUZlNNn6QZX1S6wTK0an/NSyh8GTXUsEDJjm83IuGmqAQbOn5CBe9s+hUIGuczR
	 o7omP8CxHNpuoCFVmKP+VgsdurXClWEoLuIGqn8pC2WLX1P5yIiQKk9Hm9ISmf74O3
	 1M9pP8HH6FYuM7QjYStNDVSpLOlIiU1+2usmIrXkX5NzADaMYaMJnPU3B2Kshoh8P3
	 IX5ZaSB5o1qrnFnqYJHVfaETj7S9DcHoSvWjE9Kv7FGlwsaZ5jt7de8eLIU5EmzBvF
	 wli/gJO+N6ehepCIBGzoL8Of4YSDsG+tcnLSNcmMVNakU5nRvTYw/TsmE/FQFsYXPo
	 7J0ZUaFuzCNqD8F22yclFH1N/2rFWDeoo9qOymUHg6W8itACnYyIkLUVzHzgH7rk+F
	 LgePpBmfFa20/G3ujPbK22mbjpeJSoaRXwdofXGivDE65GKnK5t023GBFtyvrH9mhj
	 1L3ADezbD5Q1HEP9Nd+RfXw2iWVG2hMoteREYx7aZl2xIged4rr70VP3QYkLUQ4F0o
	 nZwy1yMr04lsrMLn/gqJfsxH6Nfb0Lp46HVa8JrI/3iW8dC5s7No41DsZnAWKAGcdq
	 g2AW7FvmDdnXC73q6uRIZo38=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F18240E0261;
	Mon,  4 Nov 2024 10:45:14 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:45:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC 2/7] x86/microcode: Introduce staging option to
 reduce late-loading latency
Message-ID: <20241104104508.GRZyiltIGuSF2cfn76@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001161042.465584-3-chang.seok.bae@intel.com>

On Tue, Oct 01, 2024 at 09:10:37AM -0700, Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index 21776c529fa9..cb58e83e4934 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -31,10 +31,12 @@ struct microcode_ops {
>  	 * See also the "Synchronization" section in microcode_core.c.
>  	 */
>  	enum ucode_state	(*apply_microcode)(int cpu);
> +	void			(*staging_microcode)(void);

"stage_microcode"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

