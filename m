Return-Path: <linux-kernel+bounces-416335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC99D436E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B141F222CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAA1BC068;
	Wed, 20 Nov 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AFpzmrLY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23214037F;
	Wed, 20 Nov 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732137339; cv=none; b=PamgR9ozJ0tQ3lRngS9BheQNZ4sfzqmR+jaIsN0b7taD7jsZynXEh+qCudrtNfuPYOsRCc/bOnu2FEiQLjBBhtWO1xet4QyD4IRFtD+EUFAjksJtvb6p3N/emcR3/AJiVEDLcOpQJkAq9zV6VS18H+E9AaHqq2t7JkBS21FKd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732137339; c=relaxed/simple;
	bh=BsPWBjDlIHldk9u6ExGHBAxKRO6gfIMDbEFMPn/tqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtk/99MMYBWO6/tXHfmQ+7+PZz/C8ckqlkBbpPPaIvjg5wLrgcqXGkrPaYTJExKdCq2K+NztA/9NSJevEZR5dX4jflBbBapO1K92ilfg76I29iaLfpS/QENx0FintaLoQA7omdtjicMESXYB1JLxXFJZQyHXOnFM8GyDcQk4DME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AFpzmrLY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDE0440E015F;
	Wed, 20 Nov 2024 21:15:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T75JQP4pBQGS; Wed, 20 Nov 2024 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732137332; bh=T0vlX15pz2NJblllAODXy8/ru5NjDSIgys3eZddA52k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFpzmrLYCdBMjSEeY383FHkJVOM/8Hkn5O/g0lcXj2gaNDHVbAySt9X5TKDHXvhUw
	 f5T9hXkblLGh0xZo97GWpYs77j10+On6uJa0aVS+CBwlCNw4nlQYcpuCvA9Tdw+7bN
	 JLvppyRqFXKGTeb+nNu4BvNKbgaceczUxWTNyP1Rc3nIHruqMBZoG5epBzYxsObtro
	 QbaLKS01bwZrnm5WAOADvonqyu9vVJW2W+Gqc6ISXnBkVOj/3dIMKtqZAHsETwIIeJ
	 mWKNr96c6x0O27dAhEBr7ZHgHBE/2cFYyrE4nbmutxHdbKDnuuAU1fsLTxBkP7jpYl
	 EjdWnj5UWAgz0m2l2WYnRXQBHcXh81Xg8vB8Ns/k9a443UUfIrAZDXpJON8Gbuekwt
	 a6lANWMO5nKILSPfi0XP9r0nKGDt4hJSegjZh1Pp8O2lItpmt6JH8fLbOyt7CXRjRJ
	 ytqjl4ovNkHySEC6HmF96OaGdpH558c3Y6SgZrImLIVFisLA6zwnWxGOVOM1ebULWk
	 g554CWvL/jiEWxRQPVrcAkI8xv2FtLxdiOhCyfeNfypst7aHLMN/bCMyfZRmG0uhWv
	 NIp4NRsyU474JH9KKrAsVD4HXkS/JbiXVT3TshBr/OhPO8P8MGSLBeFyx61uDAekGb
	 y6iyFJWZMvG23A3A0KZ3cLJ8=
Received: from zn.tnic (p200300ea9736a1e2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1e2:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFFEF40E021C;
	Wed, 20 Nov 2024 21:15:26 +0000 (UTC)
Date: Wed, 20 Nov 2024 22:15:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, linux-doc@vger.kernel.org,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
Message-ID: <20241120211525.GEZz5RbZEtEExSz3h6@fat_crate.local>
References: <20241120163033.12829-1-bp@kernel.org>
 <1932ef4f-b797-49b8-ab86-b687210c8778@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1932ef4f-b797-49b8-ab86-b687210c8778@intel.com>

On Wed, Nov 20, 2024 at 11:46:22AM -0800, Sohil Mehta wrote:
> Remove it from the index too?

...

> Whitespace error here: space before tab in indent

Both fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

