Return-Path: <linux-kernel+bounces-430203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31B9E2DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A33282614
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F0207A01;
	Tue,  3 Dec 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZhxWxLjH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEA1FF7CF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259422; cv=none; b=KzDLkrDYiF48Qo/e5ZcrW4HCGHcZ0D5NJ3Dzf1/id/ZIXZB9fj1VgFRit3E7P4DQDgECUIdjE1RyTK1KWu5unGwAgKcRazbWo9sLkFeYzUcVvlg7NFtfdsRUHBuz/cMkWHq54MTfvgjDC6e7SsRQa+aX+JThKDxxCmSuxvmuN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259422; c=relaxed/simple;
	bh=Ld3AiIu3bMELPlaD6H+ONVqS6JRYPmv3lUD1Xj5dWCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdPFNFV/kcbBIxe2nNUSlJJo6Cqxf/x6SHDVpGAHW4+hJ7gx0AfWDJkYODM1z/7c1vqS/JwGoD8FsFn9xge6BOC16HR0qwJ3yOdLRdmBe97G9zRgkrvgUKuLW+HG59+cNY72oOvrQPwRXe8xoizXu6SFVLl0XAIqD/WEbPbDSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZhxWxLjH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8589D40E0269;
	Tue,  3 Dec 2024 20:56:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EYQ6qrneGs17; Tue,  3 Dec 2024 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733259410; bh=UHQunaY1XPQuj1jaEbc+ll16wR3ra5Eb8TGWyUckvyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhxWxLjHDRYcbl0L+fwG6a3WplCl4KTx2M6gMqpe6c+RIdtvWWIy6n+8nBvY4V/8G
	 LhnVy9G17pyWKhQMUjYtzN+JLXoSoVM7s0TWXnvRcD7NjbCwF5DbTn+JQiqdhIq3Hm
	 AYkaehpg5u2HhYqIQpYUEYBEIDvk4J3iEuKLoWDJ7BO2NLT5ch0wTrup61izp1mBBf
	 WiiogsRsr+AJr+Gw4fH8hPaHbcdinbc5OrGBohUhDG55sdwQbq9sRaxRBzsHsU1fdO
	 OUX3bYPUhE0d+YK7bbI6zNAfBVWtpP3bjiu5L6ccWHhJ0zew4BqV+k77TE1NJ6/Sqv
	 PDvRhJHQq6wW6uqGdti4ON/Vt812VAIzkcca5pLHw5ynV1l29JVxmYcu8/fZ1s4FZr
	 YCDhnHrFB0eI5CrNxBH8YNMMw3QyzqW0xlrBhYuPtbYy9fIurP2COskHjjb6/6qdBU
	 B5LL9glBG9e8jnatgvkRhPgTY/EcKt+WnxqsnDNc5ApLHiIBvOdrlZrhrDztUVy5NS
	 Tj2JjAuJ87Pydsnx4+vO6oWyVTZ/s/KWBWBPVtk+1GxjbeKzBf7CHFQyE1bi0uRzZI
	 5H2fnyfyHQEivTJBuCbvVJzePctQjL3GgZs+MZ34DAvs5omYWHtS4i3yBRGM0Zx7dS
	 IUyX1cZte3XF65vlfLz+vDWo=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09F0640E0196;
	Tue,  3 Dec 2024 20:56:39 +0000 (UTC)
Date: Tue, 3 Dec 2024 21:56:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 1/8] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20241203205633.GIZ09wgSrmiK5x6Wuc@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com>
 <20241203160146.GDZ08rahZMYc3vyoxq@fat_crate.local>
 <1a3c5a5e-585c-a629-8700-f2e76694b0ee@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a3c5a5e-585c-a629-8700-f2e76694b0ee@amd.com>

On Tue, Dec 03, 2024 at 10:08:59AM -0600, Tom Lendacky wrote:
> The idea is to dump the actual RMP contents that exist in memory. The @e
> value only contains what the RMPREAD instruction chooses to expose.

Aha, ok. 

Oh well, get_raw_rmpentry() is fast enough so we can call it again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

