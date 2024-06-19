Return-Path: <linux-kernel+bounces-220706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52790E594
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36750B2191E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E67BAF4;
	Wed, 19 Jun 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YZfHFums"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3767B3EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785980; cv=none; b=D1LGHoZETD0RJ6JaBv+u/phILw+23/NGkJrGC8nqnQ8zKR83sVkPNpO9D8vYy1p4uA8bdoqLPbPjf7/qOSMp+4DZEnTMJI63yz09p3PlURhKOPyvzSdywsllTkSaSIGpFSHok/VGuIp4PKxj93nr5PjSkaz/pnAok0E+VryLTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785980; c=relaxed/simple;
	bh=1aOsnjyeGjHK56EdAG6AHvqLc15XIVGgBNxFv0/GaOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyxEnsC6bVzGQ+/mHJZaS83IpQub/4km5I/pWh7K6jZwvK6h2UZNoh9SE15NBRkSn0I343OgY65WtrxHldFBwjeREwXSqhmoSJaULiBwpYlF1r0OXicbG9/AQLA9YPCnxS0ZHvygNLnD/9ln2otVhVNHho9bjzF2cYgpkU7aZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YZfHFums; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DB1A40E021A;
	Wed, 19 Jun 2024 08:32:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4TICYlQAY8ip; Wed, 19 Jun 2024 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718785971; bh=YpQvZTMpBpFWjwMazILSpWIJFQjPZrO1/y18SWjuVdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZfHFumsBjulKoXcsTjhrVp2T5kNYntu7WA7sqp8Ouiaxh/SHaTO1+rf5d+0L3g8f
	 n906G/MhRigol9Vh/4bsY2IKEhVdBBZptb16Kp/51dnlgIzUBpA9BIOujkfo25YfTe
	 mx2ZCc0oPLkam2sYYMTYRO1h559saFRFbsWgF2Pfj5wnY9hJsCk2jFS2GHpUnzu/+C
	 veQD3jM+eOSTEd/DFSng3mTawXBPCgvMNz5qhRPBmlgLP3tTMCkkwa217o9XqWAaDd
	 H3N5ucHMV5vRomOqqBYh0ICzBfjHZ8XyLfiR68rBDdkrHVT/0VHQguMTCMXzkduIBF
	 k8D+9X95FAZ1gMkFwb1QVrWc1MM4dfy9L4sHdcKwfQmTT5eyPxhROTlYkiDLCBSkIL
	 d07YuUY43n1SSUKYurFBUAZbaDTzGXCAvSDzahTcp8Z0Vn8YDuR5ClRGIEa1yvj+LA
	 QYrC8MAEwOknI6+zPQ7cbsehRVw5Jr2AqGr3xDywlsxMPEVN7fKrz/RgooPt6tJ9Nh
	 KLOAPX3pjmgE5GYkHcBKQU1RAVj+HWfW4XqGKaxFNSNpP1YT7Ix646c+hfkCGbCx8/
	 sggo3CWb5uoBnIcXgMfPNCM91ia3cy6rTa29oG5uHwMEgpddGY7iB4P3z1ejDBFaMh
	 sKzYVtPdEeludI1B7kKzjL9U=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5808140E01F9;
	Wed, 19 Jun 2024 08:32:47 +0000 (UTC)
Date: Wed, 19 Jun 2024 10:32:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/emulate.o: warning:
 objtool: .altinstr_replacement+0x12: call without frame pointer save/setup
Message-ID: <20240619083247.GBZnKXr2AsrX42ztqE@fat_crate.local>
References: <202406190909.XhOnJC4Z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202406190909.XhOnJC4Z-lkp@intel.com>

On Wed, Jun 19, 2024 at 09:43:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
> head:   f776e41fdcc4141876ef6f297318ab04c2382eb7
> commit: f776e41fdcc4141876ef6f297318ab04c2382eb7 [14/14] x86/alternative: Replace the old macros
> config: x86_64-buildonly-randconfig-r005-20220613 (https://download.01.org/0day-ci/archive/20240619/202406190909.XhOnJC4Z-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190909.XhOnJC4Z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406190909.XhOnJC4Z-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kvm/emulate.o: warning: objtool: .altinstr_replacement+0x12: call without frame pointer save/setup

There already is such a thread from another similar report of yours and the
result is:

https://lore.kernel.org/r/20240618200539.GHZnHok3nr60R4BXSK@fat_crate.local

which fixes this too.

Lemme queue that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

