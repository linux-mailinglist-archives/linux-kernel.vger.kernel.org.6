Return-Path: <linux-kernel+bounces-400189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213179C0A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B383AB22A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591F212D2F;
	Thu,  7 Nov 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HOqVHlTp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F921405F7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993458; cv=none; b=OEwQsdeLdLwGKTYxb+azB+pS/npRMAEPbwgqO+AWMc6sTOmVu9TNvY9jw/yxsWUPT2MgztI4g6CQVqij/NQ1xIMtFGMHKY56tyYdncVeVEo5mE9E+VOlL3Vi67F1dq2Xv46uEdhx5TNg+eO8cLXlks7hFfAdz+8jEGMzruZe6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993458; c=relaxed/simple;
	bh=lNjgYAudIgWkExpyyZsx+D0tuPHbz6VJMEO6PwxFqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LndRxxwoJsXjZw5qmes9Z54W9wyAONvm8N7azTGBGdMMDkRCMjsgIqLJDsXqvUjcwGxQfnsMAXLhj1GEY9uLSOck/dRsCez+NGM1o7/XaATFRnDCIwjwng5Hlf+nzspa3TqNTKzWrEgtor2X+fAqk7shHiG2yftX0ZdRZb/nUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HOqVHlTp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9562740E0219;
	Thu,  7 Nov 2024 15:30:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 61w3N3hPa9Ef; Thu,  7 Nov 2024 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730993443; bh=fgLds97ch92WcZQ1oNOjdrZo7KLnc11ckcGB0z0JARI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOqVHlTpMQOlAbMW0rlVMbh6lGTaJ/WRakUx4uXOiq1dSgSZtBRGUjXi8rkQbhKqs
	 b69tjorP6wgOeqg/Ez7ITEfzyX3dkGtdZg+Sh6Lv/3xE81n/suq0p3W4BL1OLvKvfE
	 B7nPHic3tVQtQ0rHTDlCuITUO5SawXGfl7YQJU2CoJdI8dSqahB6KRK8Xhid/2KgAN
	 NC3dVW9e94/sJRhfHLH94hTcnvY1/8W6RhVhhliYtlAHfvJf1dLr97Bkx+tHcbA96Y
	 9bnQsQaNu2psqwDwLNveeHAibaBRChFdyZLAjdreMX1Y7zqC5ISFTJdupx+kEBwA8J
	 oA+novt+0ObnXThbjKWhCzk8dHVSM058sx692ukN265r7KgxC2DzKbxbUxgw6/QNIb
	 IpD30ZT7d5iLf+IKatTS5xwIIRKlzEPWfFt74VwdUKYExm85+7RRGhQiUhqmfDIEDB
	 CBwNL8n0jkFVJax3XACje0JQaJOtYxoNrbHwim6QOBB2jR+uxitC8GB20RNsw5oe7M
	 kr95v65NVfed5nLG1bIu+gkbSBqewczDjyzGY2jyy+j92Nwu9QL1j6h1jwounuCyy2
	 OlsOBeabx8ilDC43oB1a9AUcuzrFUYI/Almp1Ar4Xcvvs/7U7+8OnDdIuv7Tb+f7tk
	 IZXeHe+KEGOksb5dME087PNY=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 264AB40E019C;
	Thu,  7 Nov 2024 15:30:39 +0000 (UTC)
Date: Thu, 7 Nov 2024 16:30:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: thomas.de_schampheleire@nokia.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>

On Wed, Nov 06, 2024 at 06:50:12PM +0000, Andrew Cooper wrote:
> I recognise those symptoms.
> 
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=f19a199281a23725beb73bef61eb8964d8e225ce
> 
> We found it in Xen in 2019, and were instructed by AMD to insert a TLB
> flush immediately after patchloading.

Thanks for saving me some wild goose chasing...

Thomas, do you want a diff to try?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

