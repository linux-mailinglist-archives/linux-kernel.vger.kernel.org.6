Return-Path: <linux-kernel+bounces-546721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A75A4FE00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FC93ACF45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6C241693;
	Wed,  5 Mar 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K7clPyQG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FD241675
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175454; cv=none; b=f2zA6S67eGFVmy6XPYn1m5Xqos8SSy2YmFzvHs7+7vnasYNycJRXOVEP8xEXlHnbCq675Tb4dJkZMs1xgAoi0wB6SOet/D+FUx1N8t/2AMaHdHxzlDnG5AVwf90GCDRWiC4HD949IVIM8pu6qlOM8v5tpcZTuiRA+I/2tyngUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175454; c=relaxed/simple;
	bh=tuOcDYJSykmVc5uUz2SP8tjZNqiHaBoZ6co3vfjuC8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiOo0GdYapLgujt5hjXrIN/44LWcBu4K/HQF6ex1aglPUsR6RyxtfV1IpyMscMgQtIMsp9+R9mc3cYWGMzF5HEMH73TdkdBVwGCOxelUESYDIjgBEaeXNZarj/zZIyMA+jrL66bX6+oiaNvANVlOXbFFm9Przuo1a5+xqT0rV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K7clPyQG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A541740E020E;
	Wed,  5 Mar 2025 11:50:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RxaQG4TpSx07; Wed,  5 Mar 2025 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741175446; bh=3xwS+z0VuCaHW+iYGsMFJ3crcRT1QJkSDjfOlCSZhKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7clPyQGESfP37aIlw1zH7YgZIKNMEJH+RKTLE8cnT46LomXFHmPABZgj97jx+q9d
	 tdaT4Tzubcql2h9b/6i/yfNvRX2JFFV7/mJQ4EACvMRjgX0rJVbPj5Ieb0C+Pgx2xJ
	 qftzxO5LReMJDWoLvjSq9I8bzDmZ0Z99mi4CYqFTkq7BdC9ffA9OMqjSvmES9456Gm
	 1q5I9qROQcNkwRJPhh9mqqXnKyqme7168pDm56PoT4/ebzgIX8qWkJ9pDvKOWuQdBS
	 UfdE6G9vBgESZjRHTDmUGLTL/01xxskFw4AGo1dA1rGv7I1wAmvZdHzq1rMP20v73Q
	 ET72e90edYWCLB7PYR+o5hGxz3deB1Dc176pndDEyX9jFIy6g3DTB/xPijf2jhYFEr
	 4dNmy1kmQcTc94TFcCAsz2U7SboZV6gEKjHKmFuXb32M9QI1hEO6mO9M+ZQgigqLeh
	 uRMjz65H/I566UQkhH9mheDoaUBRrjhkEs3dAe1uP2ovUdW1mNN2PsjcGBKFxgJUfZ
	 7cdZF+WySPzCCAi1ZHXymcdSx6pLIUg+FkbtwLh9eFm3R6vP2IzGMaHr5nyhTjBwp2
	 Qntm/U2yCtCMpIPWJmOV39AXyxd81axoknOI/4vEWwdCVAzNsaJygZ+V0QsOOCzJdQ
	 Vo9qiDBn+bL8c9cJGkDNuGNg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21A2E40E0176;
	Wed,  5 Mar 2025 11:50:37 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:50:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8g4sU_dsZgY0PuS@gmail.com>

On Wed, Mar 05, 2025 at 12:42:41PM +0100, Ingo Molnar wrote:
> So if the convenience of tooling is the argument, the raw feature mask 
> exposed is the best option overall.

The convenience of tooling *and* user. I want both. I want to be able to boot
a guest and see what features are enabled without needing a tool.

And, at the same time, tools should be able to use the same interface.

Exactly like we *and glibc* use /proc/cpuinfo today. Now think the same thing
but for confidential guests.

> So the /sys/devices/system/cpu/sev/ directory already exists and your 
> arguments already apply to that, don't they?

Lemme repeat:

>> - a .../sev sysfs file clearly doesn't cut it because TDX doesn't have "sev"
>>   - it is the Intel version of a confidential guest

>> - we have a general need to expose what a confidential guest supports

> As to the hex numbers - do you prefer to put string versions of these 
> into the sysfs file:

See above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

