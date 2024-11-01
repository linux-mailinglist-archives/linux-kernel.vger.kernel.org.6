Return-Path: <linux-kernel+bounces-392518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242B9B9521
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D246E1F22E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D8145FEB;
	Fri,  1 Nov 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hLVTrvFv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B421DA53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477954; cv=none; b=Cv1WL352CHrEdg2aDgKIaNlG4jEXxLwEjKs3/8OjUxA8FnSYzc3bKj/JDOl1yjxXBxjHchp/500PyX8l5HFvCoKeMwrqcbRWGThDVvI4zEhAI04NEEBTIpLhxYr0LVX0h5H92en5M7Ajkxo9kIbRe56bqM02s3hELAUbK68x9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477954; c=relaxed/simple;
	bh=YmTqFyapuFkDexlNLaBQ9TKRefl9qZa/7LpQlueDPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWTY6vbnZ5NhxesE3C2HPyAZ6IIErIF3tDNWSFKBci/AajaNnXJFZVlSsTZP1a4qH1+YnMs6dSEct4hQX3gMxw0UKQ8XJNfzX6UhyofkPFPenXPv0m3ApU6qeUvAns8DxEtGQBrD5aPg10tDEetO6taEpwjTftvkg1rprDnnrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hLVTrvFv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E752240E015F;
	Fri,  1 Nov 2024 16:19:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0KrUJmqolMCh; Fri,  1 Nov 2024 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730477944; bh=ga3EU5e3LwksEz0FqQ+0xvAlawIA21BzAgKw22O3GpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLVTrvFv1Kcd1oeV1zWXiHkv35eRo3qpkpEAgpWhWXB8HfSOnhhB+Au63RxpHFNGI
	 fodSE7M0iUFnzbiA6F7BJJLHhJU12JhwvEHwcBSPXRubvgVwsENtkDwtvlPIwJsaW8
	 Y1t5hpxM+6kJ/psHBQd7zMxewNUyJZbIKqIwTKArATUEYn0FFRxaWV8msbMneQprNj
	 /snidavlN2diEcfcNE5MA54WNsPQdjYV81/SPfMsO0Xgg+vW3CI1qwkZVVSC//GyqE
	 Y35O0ECSUYtR1yRQJGrApjh8N8TbkTEYfaVu9ELLr59qqxohbiPdo2XHayRwVzyCJ8
	 Xdgwb7YfrXJAhCuNPhM7PQ4wNO3+T3BY+kPxxq4AhuB0hdmGh+lJY8MseZMpBQxNcF
	 l9NMntdCANZlcXFlDVApdlgFMNIUXoa5XbCZWxL5qSzLJQmMjjMFex6Fklw4J7DrR3
	 Xudte7uQRmvJjdlRYl8DN2PhLaHobJA4wh29xuTWYytIb14ENlgU+IuHuGfb40NO3X
	 HdODACICW9EsLy4IeUS4K00CfXtKtHoTPrK79Gll5a3IIH0eBXXOBHS3CuL6T2FfbY
	 Vba7yBIeRsTkMmV95o//WBGygAS6tdffNtSlGVZGhdShh2iOJSLyGgCa5tMJQ4RDor
	 G9sTpr4zgz5NGWRLFy69DEQ8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907DD40E019C;
	Fri,  1 Nov 2024 16:18:55 +0000 (UTC)
Date: Fri, 1 Nov 2024 17:18:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>

On Thu, Oct 31, 2024 at 11:41:12AM +0800, Baoquan He wrote:
> Should I send the fixing patch alone and clean up the useless argument
> 'size' later, or squash them into one patch?

First the fix, then the cleanup.

Btw, that fix wants to go to stable no? Seeing how it breaks certain machines
with IMA and kdump and SMe...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

