Return-Path: <linux-kernel+bounces-409583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA89C8ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D4287881
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231AD1A7AF6;
	Thu, 14 Nov 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UxzEyFnb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837219340F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599244; cv=none; b=kx6QGeSzcEu26QvVUPSHzxoMa0deBGJ4PDvou/T57gtDaESP6gnA1LAl1aMlk3a6qvJMrpJjmUD9AvbrlO20J/c/mPojVdE2d0KgOjjb6C6zpgDINzdDaL1vghv9V3uvUv6UegXPpbgRTRu204+2TWl3DaSI99DUTbz290kfIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599244; c=relaxed/simple;
	bh=gJlPsVw4Bp3UhRIgBen/h1GASsa9ADTXePOkjH4J7jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsK5YtK2YIzCApm59clCpZbrvAxlKbZ+Rovoo/ujxaqA/cyEYp7fXw0VYRctJ/5W4M656kttwXfdxSLoL7od0sb+2WKZP8Y48cq1VKwDzEoi+/d0iIiM5kN3pdMD2ZlMMWx6GzAZIOWtpv1aMXc/m7AO3e0KN4sFg2j+YvMqGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UxzEyFnb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08DAC40E0163;
	Thu, 14 Nov 2024 15:47:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tHLEYMXKveSj; Thu, 14 Nov 2024 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731599234; bh=AFUXNajZZy78VJ27cRanD0LArZecfOwqrwjk2dVAxgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxzEyFnbu2B3aDhqDsCnCsiCTIqW/9FysFBRqU5mTcqIHCPmXlSan5lWPvGI35nfs
	 Q5iW+2aQGetuCJg1YmhkLktu3ij51o6TST/hoA+cKqIC+BJBDZtltBq8jnu7627yXW
	 jU9GGkLztcK69awK/tGiQxmoZsBxrtsM7fEssTyXAGNnMgOv+YiA/N/xckMNzktFje
	 b1zsNEhu3nxFvspvlZPg1G6gzRv8pl/xwir9TF/H3HqAWiRwSAea/osEGy0n0/iHKI
	 ZnAC2WWh/KK80MunBl1P+QAuH+K8IBLyW7JNLwWSfoWWkSr0VU8II0ImYxevz8dkcL
	 13iEqcZ6zRWJGsEzNyla561AD2lijhzV4rkw9TkvSCHYZBvFako7855Alun1do/XLJ
	 XHBBib0r97Ooee5dY6/UwM4KxgEc7bJu5Nduw6eKnuUFjjVutgPdOmVNyGuyiGKn5F
	 SNKXSGl/0R/grqxgS5Elhf+Ylda7Rus2MOGnYsANx0lVUizlp4Y6hdhefeub8kTuM3
	 zq1ECbUM35FEKrib8KXG8as3Vwjk6AQkS0lVtgBz0Q1d5C6sQBWuozP9KYNC2KQkkw
	 JO0rtMOmQJ3Xt4mPirpAY6F7kOh5715BGD6jhuX3afzz3Fh+cYUgdDPzQqUlukMMp7
	 Bsxm8qWy/3Dcudkb5n7Et5u8=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A977040E0276;
	Thu, 14 Nov 2024 15:47:11 +0000 (UTC)
Date: Thu, 14 Nov 2024 16:47:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
Message-ID: <20241114154704.GHZzYbeDmCV9u1fdVJ@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
 <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
 <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
 <3fd8368f-fb21-452c-b9da-5382fcf4f657@suse.com>
 <20241114142652.GGZzYIrHJUVoE18vp4@fat_crate.local>
 <3cc87528-e7a9-4dc0-800b-bb8f0cf279cd@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cc87528-e7a9-4dc0-800b-bb8f0cf279cd@suse.com>

On Thu, Nov 14, 2024 at 04:40:50PM +0200, Nikolay Borisov wrote:
> Right, the important bit here is that max_size is not really max_size but,

I take that back and this really is max_size. I went back and looked. These
are the patches for the older families:

Patch 00: type 1, size:  960
Patch 01: type 1, size:  960
Patch 02: type 1, size:  960
Patch 03: type 1, size:  960
Patch 04: type 1, size:  960
Patch 05: type 1, size:  960
Patch 06: type 1, size:  960
Patch 07: type 1, size:  960
Patch 08: type 1, size:  512
Patch 09: type 1, size:  960
Patch 10: type 1, size: 1568
Patch 11: type 1, size: 1568

Lemme go and look in detail again, just to be sure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

