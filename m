Return-Path: <linux-kernel+bounces-242255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD6928564
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540F0283E16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02A144D34;
	Fri,  5 Jul 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J5ZIUpf4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC921474BC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172692; cv=none; b=uPlS7fijgG0FRgxbt/IiueTCGaTg8zQIMFj5irXYQ9fNZj7t/NIIpSIDwejQFfXsASkVJKDlG9cEizw3DghbAPypfPUBqCMvQnrGiCsZmOdO8bCQNeH6mcC9q+Y1O7lULeNXuEO/kaZMQ9R3q59D4u/ln/gJyf+YNqfiYkZ2vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172692; c=relaxed/simple;
	bh=lDh5K9l6F6IqotxOROFxBJCL7+4RhQ2yBeqZ84vPBxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCMFHffj+Oxep4DGrulHg7j3rTaM3hdske5sfvbWVdV26lwMKC+YZz7foAmhhm5uQZ3f3WrnPRyy2Vdd65q7TlejAFqZJzUBhw/vUDL/nOoWy0vDg/3Jg1xrlBq5CL36gTKIatL/ne5YaMbazWjoK4t3t5wye9+CtShQroA3dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J5ZIUpf4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BFD640E019D;
	Fri,  5 Jul 2024 09:44:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rV0xTw0_VluY; Fri,  5 Jul 2024 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720172677; bh=nlMX/xEHcaDFMWQAf9/kZ4Lf/pqM1/eeNiwGBYDS+zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5ZIUpf4Cr6uDm2J7MpRSAqkue73CCSGhOwCOivzBE8sXPuVeleyAZDTGuWYXLj0w
	 KgXeH3NKEBbPgMX8ESE8tXmL6Oe9hLZBGr2c1JchCs9JG5wCHVZZEU/yvX++nd0a2L
	 Ow4sNDxlIKYgj23gpYUjCYhL1L9h8MHRfvzRfRVOoUOhZvvzfK6xYEcsBIcr2YdT+L
	 RmefkM1GfKznsGyUvgWFHTl8mcemXVsS31m7uA2BSi2+WE+hO4k8i0sj4ILAMbkmEO
	 Xl/sbKnZBbSR38h2k0n7GO95wN2vF/WAToPXhWIuHWBEfxT76/aHwA1MhG7NBwnmSA
	 e9fAxBivchmrsrlWfZoYYrMkqTkmsFwOM8Lw1oW+vIgMHce6KMQWHo7G1b0RcliQPk
	 a98IWhWb3hp3evy6y6zs37+nghlA6ut1xzQSDWmbW0iX0CuRPvnHFGQw/s+/Fx2AVE
	 LHRhBmv3ZDcYff3GLbwYVnE9K9jCtx2PZJyVioCQVk/4NVE8EXGEuM1kHSGHXrQ7S8
	 H16VW05JL9CJxjHLeyBgYNYNNuuNDGEIV6B16vfnz9mwkB6lk55L6ZU9xH6GX2JyCT
	 gMwxt+kli6N/VSvayVQbzYjE5Dvesm+ouKnVDawtpOhXxbbpx8Yo3BD3jsNe8cNAWT
	 a/7ct6AxYnLuQxF2q8PcF7Y4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF48440E0187;
	Fri,  5 Jul 2024 09:44:24 +0000 (UTC)
Date: Fri, 5 Jul 2024 11:44:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@intel.com,
	xin@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	peterz@infradead.org, nik.borisov@suse.com,
	houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Message-ID: <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
 <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>

On Thu, Jul 04, 2024 at 07:45:00PM -0700, H. Peter Anvin wrote:
> Except that that would be more cleanly spelled wrmsrns()... let's just
> abstract the whole thing away and let the user use wrmsrns() whenever
> serialization is not necessary.

Just don't make it more complex and unreadable than it has to be.

cpu_feature_enabled() already is patching things for optimal perf so even if
PeterZ prefers the alternative, I say it is ugly and, more importantly,
unnecessary.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

