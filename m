Return-Path: <linux-kernel+bounces-536428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC51A47F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566F5166092
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4722FE15;
	Thu, 27 Feb 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OXr4V6H7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1022FDE6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663587; cv=none; b=ptMm9gyWbpsa+jTL4PGHlqD5V/zgW44bvOT6Vlyme6Oxbrn6bm09qMmSGi69mqOtMpcSBvVwJq0MqzqGjGI2XXmFEE2Xod4BuQ4Xysj81pbJaDFflUsKok5EIHNFweG6hxnmDUCwHJWMKmSu9uSWh7J0yHs1zrsIg1VHhcfhpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663587; c=relaxed/simple;
	bh=RCZ/znCiLgPDJlD8DO9J07JeZbOzuydbrz7wYkKnkmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txUTI1lzg1kW6oBa2faqmEVyKmVf8RG5rOG5Hrxx+OHUp3hOb/Nr2o4ev+RFbDopA/hjvWdg7ZpgEd3qNroap1cRKtkrwvFW6hx71VWPi/czTy1YDgvPT1I3V+saFBGNB2pjX678RUplldi9+l228B1aTWcLVFzbKAn4WAtj1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OXr4V6H7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3116740E0202;
	Thu, 27 Feb 2025 13:39:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rIH1zlLNrMQy; Thu, 27 Feb 2025 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740663578; bh=18WFGl9s+05bN0lVPybpQk0Euk09X2qT0aMw4pcwvPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXr4V6H7GonxyNFVgf/KaBm8Pqfc2RtbX0xDR4pYa3srCkn8FfE3h5G53N0v71Xxb
	 d7Iz+Be2AAVzHclVd3UoAUZ59I/UuNbczgACEYtknpU4dsrIcKqppaqMa3USvxuRfe
	 h8OoXdOzho9oxIcVZv+SR51iA4ymQONIciomVKR4AYpCWngv56biEmfuoDxgDPznfS
	 yZ235X599K/cUYfytUU8twWFvfXkyvMzgcJG2YDo8JDTaQqF0kayWaB5DCZNrXS8N5
	 oXhbp1XhyyWqIfwFZsYl5zg3A20t6afRpghwiIf5pGxJLAfDeKUf6jeMMjwb80Dt7T
	 ri0A7g6iY52QEFsXjOhov5G8IisHLeHI3ukw13xflxsVnn4yk2V2z5bDGWaerB/DV0
	 r9qzkYBaHt1TUJJLxca8ag4wTxqhvlr431KVrrCW2H+KxQLbC40OVRBRTw0HlADzcY
	 li+vM16FXJnrP9FvmYI75R0S+gdWqz2JGz2u9xjnOIbVjBOLTkVxOj0vvCY3hm0dJ2
	 2b8FfIfnGzMoh3aZdm0dW/lqOoJrs265TmRfdHET2JowdmuhykYiHHSYjsjrOQz43H
	 ecJ6Ryz/55e7P1j2Wc6/r46WzafsSPYH0TVghw9+Qr7iHnWSQs0m7yxuO2NWTro8oT
	 TRYcmUlEH1feM8xwD9cUyM/o=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E5DB40E01A3;
	Thu, 27 Feb 2025 13:39:28 +0000 (UTC)
Date: Thu, 27 Feb 2025 14:39:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227133922.GDZ8BrCjnPlQBOLB0y@fat_crate.local>
References: <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <20250226210129.GHZ7-BKYvxN_I3f_B2@fat_crate.local>
 <20250226215147.233kxx2z7v7rnu5k@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226215147.233kxx2z7v7rnu5k@desk>

On Wed, Feb 26, 2025 at 01:51:47PM -0800, Pawan Gupta wrote:
> I got that part, what I meant was allowing to use =off,<enabled vectors>
> seems unnecessary when the same can be achieved by =on,<disabled vectors>.

I think Josh was the one on that thread who suggested that we should have
negative options. You can go read upthread.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

