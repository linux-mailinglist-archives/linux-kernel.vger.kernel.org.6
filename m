Return-Path: <linux-kernel+bounces-326354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C990D976713
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDA3281787
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425019F425;
	Thu, 12 Sep 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iI3TCyU4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C515D5D9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138647; cv=none; b=FtMZPu3ExE30jbImgKNgARIWzGW0J0RvY7f9666xtXM4EsU9+LaGWIAi5S4K6USqaAU2edpIvqaG/BE9fk0m1tQ13QYZ2T5jMV/iQ8b8uqFsBSFhz3F0CrWRDiF5neg3yLA2dO3XXSZIZ6fXQbO3TV3DUZQfvhGfvrJIk+mNV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138647; c=relaxed/simple;
	bh=RNrH12uCylYoxmdQLt4glumo2cnznmtL10jIk63nHLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw+yyOe2XNVPl19S9bYocf4cAsN7TaBwgvmYFp2P0x8WKH2Kx1Jh3V+0l3+6SPdVQTxqOMDxGJA28Z5LhIBQxm1pK2tD0I6zSQ6khxsLz0Fl7u0LGTWPInJ7kRF8gMqMvFPE1riiRavQa8//6eh6dqvPXYJ1wEJu/niZyzS3r6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iI3TCyU4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC1C140E028A;
	Thu, 12 Sep 2024 10:57:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tb5dPQGEPXb9; Thu, 12 Sep 2024 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726138638; bh=y/A2BhrRlRkuUusp8T3EU9bXIVJma9RWL+7ouaZ5iws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI3TCyU4+Pyki6mWZkQmry2Q+YeZAHyqugEG1L/VwBZsGyzP2CQI6D09bZEZVQrtl
	 3j1Yji7CDNyWSfpJW6g1IWMczGr457CiC+QALSDhQ9MM/1pioWrJCUWbrHr5QGsR2M
	 8ry5Wr+zoEef5wSMNBhIy/6m39xNlzCxd8DdeIlDUxg/1go2IhG8KQ9+dUQ5wSaWou
	 DkbQdueLhbU+gnuhwWFwiXrnnBru2No1R8rNxOch3aX2dkc/ikg6dWMtKVlOPUm+rC
	 qFHP2PLZFJs3NK0KZKhlLygpJk+5nLoLzMbLrha5bkDpmTIjFHBrJ/IPoP76ov4KXn
	 f8Cvp6z1kXmeMQ7ZsJYVerCaLnQnF8prE5u/gnjEDUg0HtP05pDIFpQ0s1MCNaSVI8
	 KGhrJXwXa0tjoubGRJ1JED4GaplG+USbnFP6JvYNZwIYct2LJfIAzMwT4aWqmqQOwM
	 pH0stVDAh7XN50Jc0erxlHRodv5xqSzzKuJNdn76g5hSHG8BTCN1g7qBXRcie6woBF
	 wdLvIl+I2BJAeRVRqxsjDe7s0E5ofVerDe7yV5kkD/HX2PrHSAWpuvOOtSjGwVvEz4
	 cc2O1slq+gNcR+U09huIvH1IVnwegBUMd7eZesfkEn46ELkDR5+EORwpbjiONgee3g
	 7x0c1Wxy7T7zKZUycwvzGjNo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5E3440E0288;
	Thu, 12 Sep 2024 10:56:59 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:56:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] cacheinfo: Check for null last-level cache info
Message-ID: <20240912105653.GAZuLI9fCfDjZ1Ler2@fat_crate.local>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-2-ricardo.neri-calderon@linux.intel.com>
 <20240911140509.GEZuGjlfyxj5hvSDYU@fat_crate.local>
 <20240911233746.GB7043@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911233746.GB7043@ranerica-svr.sc.intel.com>

On Wed, Sep 11, 2024 at 04:37:46PM -0700, Ricardo Neri wrote:
> Sure! I can do this. I assume this should be a separate patch.

Not needed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

