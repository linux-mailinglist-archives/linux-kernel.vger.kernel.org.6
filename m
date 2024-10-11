Return-Path: <linux-kernel+bounces-361526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE499A953
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7128389B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4319F12A;
	Fri, 11 Oct 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OVsJ/BEb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774119F11E;
	Fri, 11 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665981; cv=none; b=FkaIqp+tzmguJfmyIHoN2k6MslS9cbes1nJ8bkfmNETe5kNenXuV1GGnaLtnj6tTrptPejxEYh9DpS4HQPWB39prZC4uc8HG32sHkWuqoOYZ/Z0CPyHmYzry6n4uGzxfVyhDQuKfAMzicwx7ZSOd3nigWbdm6inlBSD/5SVWj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665981; c=relaxed/simple;
	bh=F3eutEqx/XX9PFy+OXqa4y2XwTxqJYt9rXz7fClXPzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEswADC/2ujVxbeioW3MeM84OGUOnxR/UIBdGH6ErR4ZbcpNgbcmGP/WCqQfnmtbMMmcBARlR8gGCU+9zvnmDqxTJOpf67rxwfeeT+/M80dC3r2MURCCyDJyNqMh9YOu/umvzGfyXzmbXrvPPx0e0Kit7bLfFSFRa92NF433688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OVsJ/BEb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A6FD40E021E;
	Fri, 11 Oct 2024 16:59:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kjl4LXOMatof; Fri, 11 Oct 2024 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728665973; bh=hVINV65D3f3s0MuexXOqTcMqS5x13SFxZTTU4tIG+6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVsJ/BEbejMFE/I/a5IQna5Ww4fIrcVgyM24gpmQXSAG3w4K8wyFV4HuhTfLNvFlm
	 RWolyT0JOuRAd5Vj3kwfjOQUuY1v8yOvdlqLZnKZK4uD2znmKIckuT7tQPZ7ueH8gw
	 GV3y1a39PVXpvdGjhYGbcwdKI7JUFGTZvGof8Mxe8d8z4UJcluVutvENSQ9iI463HW
	 4yA9V2LJ2TSi7Y5SrUDbgQES1r3dHChYqFydrzoPE0JUhkkyITXUEEGweVaBI/2XxE
	 bZi86SiBPCu+epY29lnPyKraHS6og4qseWP58pAUJNAOB2dpB5/xXBMH1mwsUDHdAJ
	 2bY1I+9x0Cz05klL5t4m+/ZI68/EcivomTDTQPQDZplPSrBMHnmfVQ5XGg6oMOk4yo
	 Vuq41LlDqrWZ4WLY8YNL1/XvZDJct0WlQdV237m4HYg79s9+8q2SmI5LzAXzMMcYYY
	 TbbYd5M1Cui0URE9tHbn7TkPiR5JaLcFcKvaB0alfdI2g+mc3Yl2BEXhMv9HK1R3vO
	 AE9IqpOQL/UNrS2Nwh2LHMpFuVFJxqUOUd6XYJXLPg7BEs+P0+wk9ywyS6pNB6DwCY
	 V/43D3gvNnI5jBazqlDhgMkNMMSvwjXiwZ7kJvix+98uqW6Fx16K2YMieoQJ/G+0hV
	 Yiu7apJoTKz1Oj7em3tdBk/0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD71940E0169;
	Fri, 11 Oct 2024 16:59:18 +0000 (UTC)
Date: Fri, 11 Oct 2024 18:59:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dhaval Giani <dhaval.giani@amd.com>
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20241011165912.GAZwlZYDO_kz3HQ_ie@fat_crate.local>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
 <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
 <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
 <20241011164825.GEZwlW2XggpAMsZ3P9@fat_crate.local>
 <7df1961f-f120-3914-ef23-9e466cda6248@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7df1961f-f120-3914-ef23-9e466cda6248@amd.com>

On Fri, Oct 11, 2024 at 11:55:14AM -0500, Tom Lendacky wrote:
> Ah, that makes more sense. Looks like he's missing the include for
> linux/cache.h 

"Changelog:
=========
v5:
...
  * Remove <asm/cache.h> stray header introduced in the previous
    versions because of __read_mostly attribute that is now moved into
    virt/svm/cmdline.c"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

