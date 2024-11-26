Return-Path: <linux-kernel+bounces-422403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F159D9939
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA442B266B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C721D5AAE;
	Tue, 26 Nov 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R2aO6oXo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B61D5AA4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630257; cv=none; b=Zgr8QQc5JwBaYuq5HtIxGspRmuMUwMtbLPCQivzSIugitPJtgubbn+fEnxaA19Z7JbSvylzWHz/DXShZWXzX3gNAAcxXUT/9S+B25Se/VnUH1jfgwKCTj+EeWJ9oiCpKs79DzJ+WpgXalrrALIPV3fCxg8fFuFJl2bpwGV6ASAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630257; c=relaxed/simple;
	bh=nZKhL8EFNMoJEHQojhCMl/hxbthph7JDnt4tk7zcq6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9Ew7LiqSxMZ8cEu/tWEPqDBbG2SECzBgbwJHeRUYpofDMgWA6EHhJVpyDmJPw8QxeeY1i2bQOxPS/9s20OkF/tS7QhllzhgdWUUfl03wdFDMLgaiNRT+GxV/5kk9nAKW9qf+VfLtewBum/THBoCN+K7Y/C/cUNxFjLPQqo2pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R2aO6oXo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2C5940E0274;
	Tue, 26 Nov 2024 14:10:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sW_42ahrHXqq; Tue, 26 Nov 2024 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732630241; bh=Z5A9Ec7GsJrkl7DHzhwGNiQ94ID8a6tMbHhCzM4H9cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2aO6oXoLv6jfCF4OuAxwYRXUABZHYLdbSnZKt4bG5+EM0QJtXrv/fCWJ7zej+j07
	 q8WeutFDeVW76DbT454XFPX2c3sFs7uXoFmkMfoeP+CVd2Wn4CVo3w0SPIML2MJBQn
	 beEAfj6nZksNFt39vRGzJQAoMgB9s01ZR23O/RiepqprFdl/U/JeHFsr+gxJgz58+r
	 Sxx7eh3eg6fGQudMLdPCRGmHLg8E/ze/dOsQFr2NXPhQ3tOrbxAwpTn7abwcbJ9KhR
	 RbchikBJoPMM7qtjn6hYBUIRFIHn1XgCncHwgcNxMmvB+WTJQnSeeSOXYpxPiieH/W
	 X4GCrdPksJRb9I6yJ5+Grlsuif6hu5aalKj0NIWm1KcGHQHstH1zyrcwVXqRAGoy6v
	 FvLEjeR3WEAwDbtGrgyF+wozRrZBTLiziLxoiv00t+fPZAFp5jpQ2N6FJI+qYebTvI
	 NMsFuEn1vZ7kAZPj9DpldNnJtqjiXCgp4NYds9pbwSY8BosMW3WBgPKcocRveObUHX
	 u5MC78tT2mFQbZIwxKRk8Z47GGcD9u4Yi56B3M4P+qz7blrb4PXWM8aL+NfEYmPyuS
	 6jvXciRmUBxugIdJoPNLYQIvHcVW0C2qgaGBaQ8AiO0VjYglNFaRJnirK88f0mhyPE
	 YbHYO05XXkWLm1NecoQHxTtU=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D92B840E01A8;
	Tue, 26 Nov 2024 14:10:33 +0000 (UTC)
Date: Tue, 26 Nov 2024 15:10:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/CPU/AMD: Terminate the erratum_1386_microcode array.
Message-ID: <20241126141027.GBZ0XW0xWfB9JCxrqp@fat_crate.local>
References: <20241126134722.480975-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126134722.480975-1-bigeasy@linutronix.de>

On Tue, Nov 26, 2024 at 02:47:22PM +0100, Sebastian Andrzej Siewior wrote:
> The erratum_1386_microcode array requires an empty entry at the end.
> Otherwise x86_match_cpu_with_stepping() will continue iterrate the array
> after it ended.

Whoops, true story.

Thanks for catching, lemme queue that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

