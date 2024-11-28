Return-Path: <linux-kernel+bounces-424475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B133D9DB4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925C41674FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A4155C8A;
	Thu, 28 Nov 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SLTyLWuV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF94C2FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786287; cv=none; b=rkpouUqJfNa0NbMZhMT3lnQ1iQhsluoy/uk1EoNiOfNCDMuelwczWaTfyvMZoQ96fHDsNUytQBRqZwmrSBOojv22QJIOzp9klLn3hAN7tFNoD2MR7PI7iPfFWG3AMFHSDBlukRvg44UCGwi5yrHBE+qQBYKkt53Yk/ugCsa1hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786287; c=relaxed/simple;
	bh=XYJmj2ZBJEqyCpXhcCfMly0PL5UW68XxSuLKkFe7GrQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Nyy/nOGPomk+Dm2t2KcnnlzOR9GmSCCMFf0tg4cfu/kwb2rIFJxYyM4al6bhyf0HPxwqqXGa5PfkQiGUa/M0+gW+rYc9+dx6V0JFT4kgbCGoEB0wmObn27Flk+kSjfuNrm2pTgdabjvuac0z/SYqcVCBV04274PMCZmvkSHfNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SLTyLWuV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 67AA440E021C;
	Thu, 28 Nov 2024 09:31:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z5oQadumwx87; Thu, 28 Nov 2024 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732786269; bh=s9Nyj0EEp8a7Jv8U0vwQ4By12yuoNaRSaB/Otd3NiXU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SLTyLWuVVaTXXyr/hkeqcPpA3MYe0167t9sFY03Iq9TvKa8c0sjXXDSoj50H68o43
	 SONz2t8FJowRjQAUkjCq+c2JWr3gN/ejxlOtNBZMQAC/KkKApzv/jeu8UO0aGUvMZc
	 wSkfRs+303rkL6p6N1N0hUNAJaGf3J0KV2DUJQwIWBKq/cprzVYj4sYACryR2VheQp
	 iuH9ceDPZ7e5hdOq8oQA6FBON+8aWrEghcAm1grhGP//2EGh2g/i0wTFVlmRm75mFJ
	 7a/3etDCznznrBiyNiy30P9JjmeB8M00jy82CnKeE0lEm4SlYfCoLWhhiLtkLdt+ud
	 /cTsDcRC5Ub3KCv9bHIaxuJawEShVuHyOfZFBdFmqK5sHAvx+BBumFxVzIkVSqERBV
	 DviOxqOPJo+g/8DVvbxFEFJku9i5UwDMPJ/IQHZcibE1xCQx+Mi+tsn7ERjZMh9XIu
	 AC83D1zpglrVlJXN1+UQw2eIqx4kf6Phc+hpIbksRTP8ky54jnYtidbDJN0q3MjJUC
	 H3uq8PtdrFAuYfFEE3kFLUSVaXBHi5f4iYKFxZhgVsIl5LBN5gBWgBpOTXIx+FO4pE
	 b2UhFxhL1T7wRB8T75mzdRq0DPZvSQlTFdBaKkAoSVn4/vDPCmgP2nKWgfQ2iQAy1H
	 z46LsMYxmJwHqIhDoajGKISE=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:207:9418:a901:6eac:9c56:4a8d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13CCD40E01D6;
	Thu, 28 Nov 2024 09:30:50 +0000 (UTC)
Date: Thu, 28 Nov 2024 10:30:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
CC: Andreas Herrmann <aherrmann@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Len Brown <len.brown@intel.com>, Radu Rendec <rrendec@redhat.com>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Huang Ying <ying.huang@intel.com>,
 Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] x86/cacheinfo: Set the number of leaves per CPU
User-Agent: K-9 Mail for Android
In-Reply-To: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
Message-ID: <1C6C4601-9478-4020-B4A7-47017E9A57F2@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 28, 2024 1:22:45 AM GMT+01:00, Ricardo Neri <ricardo=2Eneri-cal=
deron@linux=2Eintel=2Ecom> wrote:
>Changes since v7:
> * Merged patches 2/3 into one=2E (Borislav)
> * Dropped wrapper functions for ci_cpu_cacheinfo=2E (Borislav)
> * Check for zero cache leaves in init_cache_level() for x86=2E
>   (Borislav)
> * Removed an ugly line break=2E (Borislav)
>
>Changes since v6:
>  * Merged patches 1 and 2 into one=2E (Borislav)
>  * Fixed an formatting issue in allocate_cache_info()=2E (Borislav)

I don't think you should keep the tags after those changes=2E=2E=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

