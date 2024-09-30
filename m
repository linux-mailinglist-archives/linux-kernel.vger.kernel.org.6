Return-Path: <linux-kernel+bounces-343339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7B9899D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379EE2829C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0B7DA67;
	Mon, 30 Sep 2024 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cC+ayzOo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29F2F29
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671422; cv=none; b=X6WHPM5bJA+8AJKayBqQPJFe+9ZRmjS0Lg8DBSM//40hxtq12mUQfF5sR4HzudQ0It/RvydP+AOGIUi3mg8XzJ6QYEWtGIithePBZzlpwlIurNsUHkNBRVK8q3vvAXHbuVmOcRLD/pEcLX+8wVqaV2kHPwAXwgqbhFYYvebJwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671422; c=relaxed/simple;
	bh=wedc9imWhpym+O+VXa9BVxSk33HPk2fMWrNxxZTvdic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYrszq6e3qswU39YpQbHMjz2HH7Fvlij/gDjkaEQJtqbNbqR8gYuu0xr1+/0Ry6bf6w8zfiF5o/sB4zEPu5Te1nL7sL6mS3TV8eTM0pk1lNEUoIgjBkRxQkLBMAh4VEOcwoW2ar5jKmek6ku74subWr+9ZDIvVCxuU0yWRalmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cC+ayzOo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06FDB40E021A;
	Mon, 30 Sep 2024 04:43:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fgBiHBLGsxCI; Mon, 30 Sep 2024 04:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727671407; bh=M2NHqiHS8zSOGwrLzsFU1jh5a0T/LEfTfte9sDHw4Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC+ayzOoqZyiwjm0p3PtWIazGy7Yj39L4ztPLewWT3AIO8XcAoTNOX6BnhgllkcNg
	 cMmyhJs8o3u06HZNDJX5YDasESoyqWm6ck2D/XYDiqlPEojo2tIgOtQjeAYEf4FExu
	 3r2co+Jn4UYnlEx1XYP8ruMxFu2dYkDBhm1HKcsHkuqoVysbV2x7IMsQIb7cE0zoHP
	 3PQJWH+6SQt1eSC4SEC6lQQEjtJ/OT8/PL8jsmSf7am8009i3dmNjTewLJWArG8J2/
	 5LvDbRakpOj9mj14S31mRC8tcofAbfgamcCrMNAl5nTtGSInBBv9Wxk28+e5W64c/h
	 14BdtjWLSwW0uguiR3BMt5Uh0eyRQHOWK7RSt+cZL1ZympIOBzRTHs2MDY9jwv6YWq
	 GSWdNwZUQNqfoV5yeIUG9vpxcBEMj/yp52T5jND8GyG1z78N6HTT+LfHLywLNoea2z
	 iKNN3mKvNl3m1UvYi8TZ0BfoHLWumEWPVV2LdTVcLRR46CRmuNH2rmxoUcIgi2LHDc
	 JwJqxdsB7wPr6OoUs0+KLUf/gdew869eZzZeXLBTsa9Ks4pLWyygeyGFRWendVLskR
	 zxY5s+HoL3cMKsW1T/dy4aRzVOi9PCkpUbPfKfN6CJylY4/iw3TyPRa7A7WemmoMf1
	 fIqeQaa/PPneXeGo6ySPmseA=
Received: from nazgul.tnic (dynamic-176-000-005-255.176.0.pool.telefonica.de [176.0.5.255])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD7EF40E0169;
	Mon, 30 Sep 2024 04:43:22 +0000 (UTC)
Date: Mon, 30 Sep 2024 06:43:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>

On Sat, Sep 28, 2024 at 05:31:36AM -0600, Jens Axboe wrote:
> as the box is running debian testing/unstable.

Thanks, I need to go find a box like yours to try to reproduce it there,
after I get back from vacation.

In the meantime, you can add "dis_ucode_ldr" to the kernel cmdline if
you want to boot the box with -rc1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

