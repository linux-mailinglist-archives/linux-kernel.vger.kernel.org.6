Return-Path: <linux-kernel+bounces-215763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2379096C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A061F22E04
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F30182B3;
	Sat, 15 Jun 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hykZg915"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887318C05
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438964; cv=none; b=WlgX1gyzFdzfYkQOHsmXZ8U/hTURTBqLHy1Hz7AY67uf1DQeXekc2RgomrJY8TRSkwpypVWkLxRLqgvD0wFd8UWaaWJ4vlPbcT8MknFDE+ErZSmtp+dkfeMX/GAbWGZIswfJHV4hYvOD0F95JE6YIkNGADxncJ/cI630l4ozWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438964; c=relaxed/simple;
	bh=n83mPvWjimvPBHYnbxfFpH0H3iDBwKsj2ER4c+LtfiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPU+LP9VABeA630yAzfrj2Bln4ZT2XaccfgN6Eun8p7B+KSiyprx/hDuiV1WTGmSDuM74OAACDe7e2reQoLFCGhlSdqeV/BKcYXVWqDezf36+8f0oHD6VodmBhEmmZoYm72/UJImgVbJ5W6WhfW/TMq7+MWb+UwyrvrvY9nD21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hykZg915; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E93140E0218;
	Sat, 15 Jun 2024 08:09:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wp64XGPxSjvQ; Sat, 15 Jun 2024 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718438955; bh=OhaztBundoMh26NQ9MzVLPt0712eh6MJFjegOkfhMeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hykZg915vWAWbeEQLbvUJ79MJlbFiIPpAdX+q03XGICtbXTMe+ZIfw7vXWgpJBy6x
	 /v2lbQiH60AE8IC4el+G5Xw0V7CUx54NZm0Li+YZ1o5XbhxzQDxNW+fMPPP2zJkaAP
	 4rfYd2HKhQ1c460ZGMrJAL5G4/4FxBUH6x/LYVYZQqnRz92E8FlCg3KxpAxempgW1S
	 aD/osz6TBQmiQ0Klint9NCjGRxDQj7J0KrnALst6FxSJGjYdFg8hjJJJoH0Qge1XNI
	 HQjsmQcM2DTx3rm03ITuBJ0DWcCFgp88KYxyeM2RSfjCFb8yBC0V/TJxRPCDd5B5fo
	 wLcBM5KrIxTPFVCim1RGrxWnbTkm4xMDraQYiZu6fWNrAy15fCzrde7dmiTCBnmmXY
	 zSONVMbzSRddYz7qbJMlWyl2eKZBtBGGTAzjFHqdbiwkSeS9157LaON8YmrObXFvip
	 DRaaMMwsFiB0oyw8YEvBUxTSG2GCepprJ+omUiU53koVvppr0JnNs6bEkmjJcya/MT
	 bt5HnsMAapiNkTJAK0LtM46JC3e2yf93ZaajRydbqUh1vCKvuDt+ppLYk/HK502bu4
	 ZNssVc0+XRh7yDVqNRBk3M20t+jk5k9zs6eBm+TboLr5btsIgUpLiE1fa4g0GiZLvh
	 0/sgRCKHW4UGM3QTG6K036pc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB0D740E01D6;
	Sat, 15 Jun 2024 08:09:08 +0000 (UTC)
Date: Sat, 15 Jun 2024 10:09:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <lkp@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <20240615080902.GAZm1MHvXQ30rm1Nnk@fat_crate.local>
References: <202406141648.jO9qNGLa-lkp@intel.com>
 <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <ZmxjOxhPy67QOh5Q@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmxjOxhPy67QOh5Q@google.com>

On Fri, Jun 14, 2024 at 08:35:23AM -0700, Sean Christopherson wrote:
> > I know Sean had a patchset to cleanup that gunk. Sean?
> 
> That series was just for the actual VM-Enter/VM-Exit path. 

Right, about that. I still see:

vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0xb0: call to sev_es_host_save_area() leaves .noinstr.text section
vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0xbf: call to sev_es_host_save_area.isra.0() leaves .noinstr.text section

in allyesconfig builds....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

