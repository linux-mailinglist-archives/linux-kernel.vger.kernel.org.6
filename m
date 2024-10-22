Return-Path: <linux-kernel+bounces-376214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152819AA1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D092837B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605719CC33;
	Tue, 22 Oct 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kT7DRTwH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31C19C553
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598744; cv=none; b=BbkWsHo1w/jyJracGadm2gaa9eQqdVgziABX5gc26Z3V3gp6M7YeShMgxJ1vyaOoPar8tynQGyTv7edcVNd7EsqRfL3x/DFgEKx+WA5cBpfUgrtApL3cYzWUrHoCRhReJa9y45NyPBiODeFqsNWEC0gnANynbgbj4Y2byv3ugds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598744; c=relaxed/simple;
	bh=zQ8xCol0b2IXw3GbbRNG9lcP4g/Bl1vyDfYyIBQ4hoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rorw2XuZHm+sqzaRiVq8GC1PVn7e7BBA42XCCh5J+PVVK4NqoQiov1VFghWduRw3PENXDyyWrGSBb8F+q86/VljE5bnsbzZ3S5qzq7JOc7N3ROuLL/e/tijpkiJz90i8y5GS9muffXNXFsPR+xcgCLwtfGLu3XI9FYqVSSWCaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kT7DRTwH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C56040E0198;
	Tue, 22 Oct 2024 12:05:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aX4vhu4VESL5; Tue, 22 Oct 2024 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729598737; bh=7F9OrfklmLQw/JAMPlpkXiPsZiBMIQSI/Oh6TvZHq3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT7DRTwHPDj3hWkoypqgqX+Iuyk/Hu0CLUK+Vtimk41mjJnQ1bFVfY76wPTi8C/gK
	 irGXTI0j0weT2+bjwbjx9D3k3jkk9nS6Yn6/FiCcGXyUGIwH6LzmKqyO9XLqY3/dvD
	 xVDXz+kFtZ7n2Yb9GDc/akKYl6VtDFjIK9uaCIVIxtxYxwoLGyN9eWvWU034xSYHAw
	 JCZFuBP6gbWA8bgeCh6MumtrY12vuBdgyONry3tgC8rHlzlry+TJp9cLGSU9Ihbcbx
	 gZc1D/gOrt5JgsGdrMOCJhskeZqKHHZIyG5Uc099ezTWhd4bHj9mrXRjG7DHLi5RAT
	 emPzaS07GrUUXNxwS18F3OALIjQbA7CmjL8pKSIaSt/w8K9Z2SVKCL4peW2RlDte/K
	 IziS0ZamemFdKhSfbdfnW0whxngM3j1imSxu7eUZpQOg8XoE+3qmNVJ2AXc8EjOiPD
	 N98b4+rZWff8te9n3pu2Ll/yhuRcGVT47gfFSUJXlvBQIgLAj1//oP4PJs/y2QZdFn
	 RXMI2RsBBGe9W77GYvAHxjOfCJ98kA5DyfjbwC7jS8YVADgLpt5amkU29oAgFNwl4G
	 JTWZurltdR0M/3tjf3YNvmFZrDsai5b2AP6pGqFoU8y4XRSWTf9/QmnnStFAfDYkpL
	 bLIiB1rvnXaZI1a2oljdOsVo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64ED440E015F;
	Tue, 22 Oct 2024 12:05:32 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:05:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241022120531.GDZxeVC0WeUPhInkYh@fat_crate.local>
References: <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
 <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
 <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>
 <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
 <daa98312-cc66-4c2f-8e64-01358ee99305@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daa98312-cc66-4c2f-8e64-01358ee99305@kernel.dk>

On Mon, Oct 21, 2024 at 11:00:26AM -0600, Jens Axboe wrote:
> Sounds good, I'll give them a spin once posted.

Coming up as replies to this message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

