Return-Path: <linux-kernel+bounces-413167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D69D1477
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512141F23021
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2F1ADFF5;
	Mon, 18 Nov 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DJoKrmPi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3A196C7C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943751; cv=none; b=usb+8emiN7K5BEoaEHCfmu9zkMMD8BZPVhG80S/alj1FI5clDm2v1U6riHkI/kgkQ4JAE8imRKxR+yCMfrv7N5HwX5mMEXURF9VfyAzaPH5TVRq07DHh79S4rBMgllz1uA+SXxXppiANaVyICzJiRfwzOfCW/U0TvBztj8pYTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943751; c=relaxed/simple;
	bh=k2b/0Enn1DJ6HUTZPguftZzmgfxtfW28opFnRtHoyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvIK613uOvaVPbFcxXi0LYL81U8zwdepnfRNgsBoKlra4ASt0P5jv4vVx4iHvpqPiMoUS07SiT2EQWbONr0kRAyMngQC10op5PwjeEOabnwak8It9tZxFEcV83rMN60Iml9WgJx8cLKtymjPTs6rVWvABC3ENwo2DOCaFySlATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DJoKrmPi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3685040E021C;
	Mon, 18 Nov 2024 15:29:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C0INMp4CpLFl; Mon, 18 Nov 2024 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731943744; bh=qxAM6KkJ0c1A4qIEnJNTKeDyNRNRUQpSCV2mTqhRyW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJoKrmPiep5cFhlYAuGX+6NZ7Eui4St0wpqu7iyCvmLZhmzl9S7K0V5vBIiXkaMe6
	 QSDFMh9LMkrlgzWBdsPmt7+ga0IaEUqGuEBlk4Mi49JNNAoFeiCnhiY5SbJog7ojn+
	 srf12fhGSQLWwo8HTY7mmmJFKQumAzmBbzlRCTXlMsb7WLK65MJ8cG/EJJ24z3cND8
	 anbDZihrse2qH5mBTLG1bkR+vq1e/SxClSwdaulCJfm3ovHEHjFPji60+VLJ4oZVGO
	 /dyEjy6FdeBoZQ+4o5YETnXxm1g6a3umMwKMmYwHEQ+O0toIfm8rrTEP7Q4FIbfXW0
	 fTBlL1gBz0zJlZ+blcxVXHZIdQ2AjqeypSmDpb48CulPsgJj9VyYTxXRAGtvOcq6Kf
	 pXG+M08ATglZYYad0gfN8g6gw+EjO6z/9ol/x+d+ZKe3ndKylxcCRMBEVdLOPDXxO9
	 BMKGEdkVBPJTYlrSqyoCh2u5mhKr9NbB5WKu+k7slA0gyhGAm27orEU9hH5zFbcCSp
	 9t0reRJY1aEEE08q4rhXtTG79m2JLMmQvkM93mKcL4Gal/CMqFNsJ5RXrY8t6NoqVT
	 Wb0NINMqzvFWZhwTGL8KUD3kq/tvBfeTuW8B5cdULCzLFkSnPiRD/hQsMGdou+sFdF
	 qgoQv43wF4tVqH3QLaGF9f7w=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F212340E015F;
	Mon, 18 Nov 2024 15:28:59 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:28:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
 <ZztZsCgX45rrMOVD@antipodes>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZztZsCgX45rrMOVD@antipodes>

On Mon, Nov 18, 2024 at 04:13:52PM +0100, Thomas De Schampheleire wrote:
> Thanks, I tested this version successfully.
> I hadn't included the 'size - 1' fix yet but I don't think this could influence
> my test negatively.

Thanks for testing, want me to add your Reported-by and Tested-by tag?

> Please go ahead with the final patch.
> Will it be backported to the 6.6.x branch?

Sure, I'll Cc stable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

