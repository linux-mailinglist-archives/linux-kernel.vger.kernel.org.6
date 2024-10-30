Return-Path: <linux-kernel+bounces-388595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7F9B61E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00C61C21D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F91EBFFB;
	Wed, 30 Oct 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OvK3Dip+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A791EB9EB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287891; cv=none; b=n8RZDpluSbWvyeqHVn4cnead7FzzjIe9rcZG230mxrfh936iaJEpfvNqUHqPI5m/nH5eMuK+YftLWaAORL32UBw1itIhwxGaEWy/+BujAyHyRuM9KZnNXvwa8ttlvZUq1qyfuiYRMdNRaxOJE9gHI5OtAD6mON7VseXqk2VNSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287891; c=relaxed/simple;
	bh=pTc9dgUU97gW674Tfxc1+Q/iYxetyqCwOoD/eO4yqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Coe1jGoByE6Egg1+6Pc1kcPDZVsUhOlz9fQnndhwivdRb9ZDr3n8TUGVHe+FWYQBelmUtQdqEZjqnF7BTnjpTh8OPFShi0Wu17gVRy5aLPBJjhj9IiclomVHPKFy/lZKy86afui0HmNj38r5Z/VpC+ygYo8991SEhQ70ahzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OvK3Dip+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65F5C40E0219;
	Wed, 30 Oct 2024 11:31:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q5LWoPUdiOpA; Wed, 30 Oct 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730287876; bh=/rPgRmjYbXWEjZCU0NovrlZpZ3/iWCSfnrohOhQm1lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvK3Dip+OAWthc7F2h9PuJkdZbkPUoxNC7D5E2k/a87lM7CmqTtH/qSoYruMR0zX1
	 B3FaINjoqTYzIzxLQ9FF2Hy0G07pk5jwq4V7GrVjXnJUDqd87S8n3jVtRTQv1gssXb
	 gcxxyMJXc3E7pVLxIpS58J8nESdEqPYOOGy5RR0SzdJ/cwlYDfhmLjF8h9/QZkwvR0
	 5IvTosJ1s3clX9thvoVeynodC+t+0wbQm6GPk8tPC9g8zTPOj4zFze2MiX5PVApi7j
	 ZnXdjs/SmnWooIkeApWjgz42KnnL5qK6+I0cwerP7aoGX+Lp2CTz9PabXzwfEf/bac
	 4kzT2y3VZPcGs6ooKINQQlO1GqNlvzwjRBgbCzlkrgyxCJwtvwkDLyu8bVGuL4VHL3
	 78SFRDicRzmvJsldIIY4ivs+3V/ct+lU7y6sf7SBfJEuyqhQQx9xFSVASIMAA7OYBN
	 zutThgt8vv1J562z1zo5GBvIUZ9k4e77hp5gYNqtsdxsU0SXrK69ZSZjx/3jduqp4n
	 V0D6qxAa0EPoaXFvorgZ99QLTH9Og4aq/xV+h7iIagmuMpUKRHyfep1rMgiZufxSTG
	 en8szzEjGwxQRWxKqD6lh6O2qfEkn+PoB20708wEywfSdPGJ7fZoLQ4VgT4H7dcxtg
	 WcbcgQu/HW7ITZVy37M7Loz0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D1E240E0191;
	Wed, 30 Oct 2024 11:31:06 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:31:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com, dyoung@redhat.com, daniel.kiper@oracle.com,
	noodles@fb.com, lijiang@redhat.com, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <20241030113100.GCZyIY9KgKX2pHK7GV@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>

On Tue, Oct 29, 2024 at 06:23:06PM -0700, Andrew Morton wrote:
> So can I suggest a resend please?

Andrew, you can ignore. It is on my radar now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

