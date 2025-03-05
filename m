Return-Path: <linux-kernel+bounces-547863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF27A50E77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4808188EA4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751D262D1E;
	Wed,  5 Mar 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tk/WPoIo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E8202C4F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213276; cv=none; b=g2KyUV6KncwdCB7HKbHSpDBf4s6I6CIDKAJ/ztnZzBi8hj9DzDrFC2B/FY5WL70q6CMJM4pvI4Wo7BII9kTTBKeOEELP4KSW5oJwVz5n9QnoJWD9+Y3+DT/HGmRLTgwlAlCPM9qp2gwPGsaFMeHoYJ/TGwLl4ZlTcVhiOf9btzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213276; c=relaxed/simple;
	bh=tAO5HBb0wbzXwiCCtcaCdM7SxsFE26fuqUBILr5YaI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXT8ypkbzVbOjQ59YHc7yoYzzFFSwaS4ZWe0EK7G0uXMGLNyITlLkNT2xr5l/mBhVe6bcyCEstHGhgpmv1siAqkuVBGAYMsIiW8U3fqHaeXAW7S4X4gBU1xUanVxXKSHZn6+xVk3QVDLTHm/dDoPMLzpO3I6Ig5pM2Xoaoo0+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tk/WPoIo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17A1740E016E;
	Wed,  5 Mar 2025 22:21:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RSO__GKtC8pb; Wed,  5 Mar 2025 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741213267; bh=OMt6ls2Yd/o8+jHAtk0KlyBacTyVY2IaM2NYWF3mpZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk/WPoIoNBI56q/FcS3YJnKg5V/AJPg/Vd4YfLUJN6aFf0SPQX1pR/S2j/CRDBHZg
	 s+vJoCKb6bcTdkPlTS2IhmtrOiUpdGGfnSUZ3ABHUwP68u3Mkz13ivGInOSCy+PlJ+
	 Y3w4ztQlccVf9Iz6WE9A03EF7DNNEXJjYNRVVacnCEgPR1HSJFuBZMGSRknxuQ1iyA
	 ImXltduMnNZ2SlP0RygUHMtUjGvrAOx8IO7TgGjfKLcmU6w5eFAvXqLP9RagTLm1eC
	 Aka2fHmGXYyuJRc4EBHtWShyL65OD6hixUGXYaUUfvxXR4vY92RY4GjGrPe7zN1JGP
	 XmULlkkjFWVhrbFVbimhVQSWGRt6u7bpqcX0qy12ftoNb5eZaQslgwXOMGN4W2T6Aq
	 0Cr0weAxyBxiRMhTdsvQuWzf4xp29Jav3u85U15i9/czkOt2q03+c6DhrMIVGh47mN
	 ewd4sM03Q/Tz0/WPxPAsvb5Zy9P/UIu1wT5h0QraKcR0+OB0NJVucQQJ771ECuxoi3
	 IHwcxYE33Uc3P1ABX/G0oHdtjPwtH0rI0GRmeKXhxRcAineAwUrZiPXoBKDQHqmP/9
	 s6+DKVEefQuBuWBqq49CyF326kWKyuEY4kIB/32oxK9albus+vuSV3Gm4lRGSCYJ3H
	 zHgy5zRNiVedSIUaT1+xLhFI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35C2A40E01A5;
	Wed,  5 Mar 2025 22:20:53 +0000 (UTC)
Date: Wed, 5 Mar 2025 23:20:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Message-ID: <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
 <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>

On Wed, Mar 05, 2025 at 11:17:00PM +0100, Borislav Petkov wrote:
> just because of some stupid gcc extra warning switch?

This warning has been kicked out into W1 once already for too many false
positives:

c9c6837d3931 ("kbuild: move -Wunused-const-variable to W=1 warning level")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

