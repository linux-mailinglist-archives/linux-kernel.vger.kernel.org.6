Return-Path: <linux-kernel+bounces-254317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D69331B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FD1F282B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529321A0B09;
	Tue, 16 Jul 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a2Q9am5M"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92919E83D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157039; cv=none; b=eFeqZFUxks40scifu/R2qAtH7tICdDIeidhAxEqQSdcYHTNBGANvRA0mKWBdsDm2YY9BoBRXyRQ7eTZDuKtlS+UfgAhQKxXXMow76rNesI+2uCGdU2pwBtA9wke5eaYHLzTicctreDyx1ScXygAEe252io8N1IpA1bZS04Z+KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157039; c=relaxed/simple;
	bh=exM08PG0KXBZ7OSJ8Yqzlxtv4hFIvPqfYkZo2wNcZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqRWKiICo4eOAGLpvVwHty5iZUbvPifTDQJ3lX+8chQowsssXhOnJ607mmBL/YnSU7bWzLZcEhPW1sPsQqq3HDhFttLps636AOr+QpmlD7mm2ytlB1QimfNxks57cBZmFympxq1Lw50XxhOM3RePfcfMf0WF8jWAjyuZa2llgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a2Q9am5M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 224DE40E01CD;
	Tue, 16 Jul 2024 19:10:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZjWBgfjO3D2R; Tue, 16 Jul 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721157030; bh=LGxxX1iqcWokTGyOpWHd7fF6v3g8gbatuUrZyYddcp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2Q9am5MS6a34b4N22c0tF9zWhfcVsyhRSZXZlFLJSRm4dlAoJA24zU4BoneAjkRG
	 bl1+KISdVE1bCrult08oqhSAeKTYtR33KhHg9q82vvm8eQFWE6PPrTFzatE/SqDW7z
	 h85cBofHQb5Ri9ZWrPqZQdnlel+wRfafVDppyrngIWc0BNm4th6UgnOMcQacYBPFK0
	 snUW9ZxyQ11Tky3MfwsR5vhhql9gMq7zp39kZ8S4Fe7z3m7Zr2FtCRUE+CFDYFaYCE
	 jS6lQiRvznPzeZrQAtyN0fy9C2ThAU/rfzxj4sNr4nZUuE52xZRfZH5FHoitxW5oIQ
	 ylzFirX+xol5q6ZyY/qt5qxDDfiPoDIM8tuKyje27CeYOPDlum+dMykdCCioPXG39d
	 DFD6/7Ni0JeK333aFYGF3/MP4s4ibhObu7YJTGid1nmQ788ivhCgj2GNy9dr3cY0BL
	 eCFEhanv7kSaz0HMUHNNQ5ggtJDiiZDxKJFdbR6P03T1u5lQWbVGsiSSAXUKdazoOk
	 fLUGek46XGTsiQD/IfOuyY84Z6Hx3gk8wna49GTkTycKz6nvmwu6CCsauRxzDbmxOb
	 QsR0ILetRSRg8bojtPNqu2L+EUnT6T/oMids/rAzXR3v/3FJwNM7GDVQx8riGVG+Wy
	 G2oAQjKlOB2eEPoE1YVcNtEA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 573F940E01B3;
	Tue, 16 Jul 2024 19:10:19 +0000 (UTC)
Date: Tue, 16 Jul 2024 21:10:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <20240716191013.GBZpbFldiurOunkngt@fat_crate.local>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
 <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
 <97041043-7198-4044-b1ec-f4865f614cf2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97041043-7198-4044-b1ec-f4865f614cf2@linux.intel.com>

On Tue, Jul 16, 2024 at 11:51:23AM -0700, Daniel Sneddon wrote:
> If no one is using it I don't see any reason to keep it. It's just
> cluttering up the code at that point. End users can still set
> gather_data_sampling=force anyway.

Yeah, right, thanks for confirming.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

