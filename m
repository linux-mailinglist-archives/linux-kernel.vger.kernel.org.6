Return-Path: <linux-kernel+bounces-539595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B0A4A636
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EEC3A8874
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8A1DED44;
	Fri, 28 Feb 2025 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L/QzjciV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5891DE3C5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783177; cv=none; b=PP1P/2QqccT/n+j6dhFlhcM07lL5RBW/PaLbvTw92lggbupMTTq1ZQcvt6V/Gmk54kJSGBQe2RkTCLtbpwIkNuntXo2bO2G+utSQYQ50xC8fUD5icouAgd0qvxY1PIHfbBGKzxNbbGFC/EudnqFzI4lhetNpaaVxK76k55psZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783177; c=relaxed/simple;
	bh=h90kvu5iSqJCvc5DdzBIQAzGoR9h/C9uYGG8AjFPFF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYnA/ql16dxIo40vTKbHs5ApVqP/3a+kGw9Ewj1MTC9EFA4LsiD5Pz1oa618w2q4QvU/KUJMyt98oUezmeXGtHkdMOHvRd4TN+U06J7mmFNtjykLQ98QI/03vphftAf2K3igDgGVerGkMXt2WU1JR1s5wShCc9xR5Stkmj0QtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L/QzjciV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3C25A40E01AE;
	Fri, 28 Feb 2025 22:52:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UhL2etBhPipe; Fri, 28 Feb 2025 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740783169; bh=Q8CPGnBcYQ0z2mF7VyF7zgGcozIGUedzccreIgsCT04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/QzjciV1xg1OCNQ9blV1E1FkRtol4a+VRyHJQ1eznAz4Z03YDRGbj0LEwOdmRqoZ
	 lPoQyORBLnxVIQJ3AqqbGsAMwxDvSRTLG4mj8LW+yCSBp1adz9jXKF0dUUUBCkmCWa
	 FiScFY0bKP8WGyQ7nMjajs8lhFe18ymanJbDiynTpTbpvd8RVyDLNSSrZKFzkEY3Mm
	 fyxqXl8Q0/GDYGpXsaVR787YaLEL1TZoHDBDbwXViIhYzk0GBfqwusGFz9RUGALS5b
	 M4wRCl69BEsU5WQgZbC4pz/wJxvrEQbU/iHgJFijnIyAM96Icy0VHqJsrFFgtVHXz/
	 nxG2VBRHr03rYFHOjtwQaURVIWg2jj8Ono9mR0186NsrlhM0z3/ZkFBt1PWe+3E9/Y
	 8TlpOccaxkYHJhne/k9xQLfgrOtUye7mEe3+ymDzkLKc2eW4HRcZy4sDWbKeoqkGoG
	 UhTni9MTUGBqh/F0sLPumbpW1gmvvJopFznR/SSixy9qJgPwr/KrOzhFzihHFFCQuK
	 c/HmFrSAlbMJkD5+7icm2sxmO0snLUqms08sRbhh+ZMNEETHMdH1LdLUX+QYKIZE4W
	 pfsOzYNnzpyR8o+jIZeXpIoH4216DMtivM8dLnwJXGA2V0sX5H+yjymPn7YZSngcTA
	 xx8ihHo/uaLYFdRpJETCpWYY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 684FF40E0028;
	Fri, 28 Feb 2025 22:52:42 +0000 (UTC)
Date: Fri, 28 Feb 2025 23:52:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Colin Mitchell <colinmitchell@google.com>
Cc: chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH 0/6] x86/microcode: Support for Intel Staging Feature
Message-ID: <20250228225236.GHZ8I-NBTC6L6Qc-iM@fat_crate.local>
References: <b0cf3395-ed21-4f48-ab49-81c67f6a032a@intel.com>
 <20250228222715.3306015-1-colinmitchell@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228222715.3306015-1-colinmitchell@google.com>

On Fri, Feb 28, 2025 at 02:27:15PM -0800, Colin Mitchell wrote:
> As a potential user, I'd advocate for an option to disable legacy
> loading if staging is supported.

What happens if staging is failing indefinitely, for whatever reason?

You can't load any microcode anymore if you've disabled the legacy method
too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

