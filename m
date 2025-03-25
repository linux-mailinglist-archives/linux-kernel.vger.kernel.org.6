Return-Path: <linux-kernel+bounces-576100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E599A70AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14B6177CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13C265CDD;
	Tue, 25 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HCCeVMnp"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695A19D086;
	Tue, 25 Mar 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933183; cv=none; b=Bypsic1q6uv99rz4agNLL9N87m1vH7mzN1t/n8wtr5oUyMKkYy0ov/GFql+OxoomcLiRWygadoc+ofWxZ8h/Rkxpys2doPMVJGYdn2ZKvx7UpPI3tJLBuOF+c6R0QSYZKIqLLJe0g8pMDtygp4QNpO6IxoQAmtxKAnEzruriXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933183; c=relaxed/simple;
	bh=Cl6QVnTB5YCC/FVm/coWYuUmQX1W1s+5B+rLasrzDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMwnEn9EKljl2teldFiCPsq5BmiqOrIks1BwdNQAAp0PZfyVb25hlTZL0NMxmlRGsGEC8x1IqEqYvP8DBbxGF9Fm3jjqaamoN4NRHSivxGhTLr7r1DifNeYM68M8PPyvxoFhb5NQ0jv5UigfLVcdDsF8FK1rwRR2RXAR1402csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HCCeVMnp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u391UbKFVGvmzfRNvrSMOMUkSs38r0gsxMcawH7XpCo=; b=HCCeVMnpLQe/bWPQQg9mwikPs5
	1uajJpNNK0gSaoEVnRVvWw7twSYWKMUQrUm2/uAz3YtKbNOiM54hrFQF7O39RQ6xSQSOg6TzQEiBp
	+j7u7Z1/lLXcToMrM7Y20w2eC1gHddZ2qZG1cAA0yGi4cSGJk+PaOmqp9FaXy6kFE9Tj3fvD9WXrM
	Bt02/wQW3dlo9B/0dpxi3K6p/x0PkbCSJpZ9cr3cbQcCPpn8n1trzWJp5ktEX2pp+pV9h0xRL5/Um
	hFtG/JAVHq/Tawf46v8Lo2zcaeX4vkTBTiQn73Xu+wLmG31VECtw0i5umMpMzR01BI1/YTfD4jOW/
	oQ5PGjrQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1txAXM-0042Ut-2p; Tue, 25 Mar 2025 20:06:12 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 95BDDBE2EE7; Tue, 25 Mar 2025 21:06:10 +0100 (CET)
Date: Tue, 25 Mar 2025 21:06:10 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: 1100928@bugs.debian.org,
	"C.D. MacEachern" <craig.daniel.maceachern@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Bug#1100928: [regression 6.1.y] microphone no longer records (on
 VivoBook_ASUSLaptop TP401MARB_J401MA)
Message-ID: <Z-MMsp3XJyNHOlma@eldamar.lan>
References: <174248253267.1718.4037292692790831697.reportbug@x>
 <174248253267.1718.4037292692790831697.reportbug@x>
 <Z95s5T6OXFPjRnKf@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z95s5T6OXFPjRnKf@eldamar.lan>
X-Debian-User: carnil

Hi Craig, all

On Sat, Mar 22, 2025 at 08:55:17AM +0100, Salvatore Bonaccorso wrote:
> Control: tags -1 + moreinfo upstream
> 
> Hi
> 
> On Thu, Mar 20, 2025 at 10:55:32AM -0400, C.D. MacEachern wrote:
> > Package: src:linux
> > Version: 6.1.129-1
> > Severity: important
> > X-Debbugs-Cc: craig.daniel.maceachern@gmail.com
> > 
> > Dear Maintainer,
> > 
> > After update to kernel image 6.1.0-32 on Debian bookworm my builtin microphone
> > would no longer record
> > anything - no levels detected and I checked for muted channels with tools like
> > pavucontrol and alsamixer.
> > 
> > I found that my microphone was using the `snd_hda_intel` driver in the kernel,
> > so tried rebooting and choosing
> > the 6.1.0-31 kernel instead to rule out hardware issue. Previous kernel works
> > as expected, mic records and playback
> > is fine, so some update related to this driver, or the driver itself was
> > updated and no longer works correctly with
> > the builtin microphone.
> 
> Thanks for reproting the issue (leaving boot log context, hw used,
> below for context).
> 
> I think this might be introduced with 3b4309546b48 ("ALSA: hda: Fix
> headset detection failure due to unstable sort") wich landed as well
> in 6.1.129.
> 
> If you revert that commit on top of 6.1.129, does that fixes your
> issue? Would you be able to test this?
> 
> #regzbot introduced: v6.1.128..v6.1.129
> #regzbot link: https://bugs.debian.org/1100928
> 
> The solution might be similar to c6557ccf8094 ("ALSA: hda/realtek: Fix
> microphone regression on ASUS N705UD") from 6.14-rc5 (which got
> backported to 6.13.6, 6.12.18, 6.6.81 but not yet 6.1.y).

In case you need help in trying a kernel build with the revet applied,
I'm attaching the revert patch. With that you can follow
https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#id-1.6.6.4
to build a kernel using the `test-patches` helper script to test with.

Is that enough help so we can confirm the breaking commit?

Kuan-Wei Chiu, Takashi Iwai any input on our issue?

Regards,
Salvatore

