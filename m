Return-Path: <linux-kernel+bounces-207727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E422901B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4651C213EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5C125DB;
	Mon, 10 Jun 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YcqYD59/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E63125DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000338; cv=none; b=VXt+NYGoCIrHIcu/SjXg0otpCTiZ10ajNBElm6dp1CIOydbRbuU57839plbMHwpUapNf0uk/re48kxKaQpN9eaV1Hhr6V3IHHo0v+MZVO4/Lb3EKPVJlvDMtSNBV60ofL7LJsjcRc7V1k2yljOCr66rh8U+B2fGTjROoy6BAbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000338; c=relaxed/simple;
	bh=GzKDu7raLh1uA6ZH4oM9L1SLvxPHTyfPPBw59hMTUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOTRFPW/Y5pq2tFvFu9M/i7OgAk2ijeliLHKAlH0neDFn6KbPJzFSFyvH0d6PMqIUbdq+864IGmzyKn4T8ZHeRQNyBN53Io56kq8H7mC/CZfeR+pOdbjvftq8Sy7FTT89bV7LL3hbyUzi4bF0kVuel3wy3tUOPN1cCm6frD3QW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YcqYD59/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9DD0E40E016A;
	Mon, 10 Jun 2024 06:18:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v09hGW2k2Dod; Mon, 10 Jun 2024 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718000332; bh=cLhntZLDgpaJbQQ0oQQo6/43RrTMaI1BX49O7nb+w2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcqYD59/3XuzUdAHPK23G/JpWOCzDLrVx5cGWBXDJCbo9Tu0P2ntPQvvY7/6kU0ri
	 EQWTbtq0XIbO38MKta5RBroHuG2aZzM0p83feyGtaJCKfh3dfmp2abd5xGcWRk4JC4
	 U0DHTVbmsamnATiTQ/rz2xxDOxUv1Bz2TUrJhGn6fSX0VKxP++QhZ9mw0xZYsRf8qu
	 yNsYT0Mv+hvpJbflAHqp421Rl7PkHtpLlNg6Suy4XpCaLhO86E/t2MZkMKvq3f13HK
	 3w/u7ZbdPMdfD/pjsOcB4EQVN/QsL+GtlVZbN0x/yzXsJAughM4+embiJvnYOKdRkl
	 k++shOdHgrmlboKLjjAcN/yOuctv+5TQw1Z6cRLe0JS0ouhzBMgrQ4gSj/lrj29NUe
	 P7QcrV5EKxxm/H+2IW4cWM/Wn0KbXj5rKDNA15gSFXfsrUku5tQnMViwE/IsYKISIa
	 MoSGUrrCFLsI89zYsVgZkL4tPEoyg8syatE481HkxEpTwHuApPg5C8R+TUh118etbs
	 y/b1AlnMkohNN2UM+5He2OX2oT8coo/MpDAkWws7wpymnClfnjHKlw25pJUS7sU1vX
	 WCQ3eA6VfzwKAblK4uvyy7/YCrXK1ooGr9Eblmj8rUyI6EsJ3Oq/GORrTJLg1V7DYv
	 lIUvtZx9ndpEQBvcJehZWnzg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20A6140E0027;
	Mon, 10 Jun 2024 06:18:46 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:18:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Zhang Lixu <lixu.zhang@intel.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/intel-ish-hid/ishtp/loader.c:172:8: error:
 incompatible pointer types passing '__le64 *' (aka 'unsigned long long *')
 to parameter of type 'dma_addr_t *' (aka 'unsigned int *')
Message-ID: <20240610061841.GBZmaawUaFvlSBVSXM@fat_crate.local>
References: <202405201313.SAStVPrT-lkp@intel.com>
 <20240610055334.GAZmaU3nwT-1y_kw9m@fat_crate.local>
 <nycvar.YFH.7.76.2406100756200.24940@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2406100756200.24940@cbobk.fhfr.pm>

Hey jikos,

On Mon, Jun 10, 2024 at 07:56:48AM +0200, Jiri Kosina wrote:
> Should be fixed in Linus' tree as of yesterday by 2360497238261f17d4 
> ("HID: intel-ish-hid: Fix build error for COMPILE_TEST")

Yap, I can confirm - thanks!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

