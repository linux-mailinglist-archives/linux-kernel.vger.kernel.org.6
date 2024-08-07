Return-Path: <linux-kernel+bounces-278279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11294AE36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C28D1C21A68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D13137776;
	Wed,  7 Aug 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXxSgf1f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IAZwAJN2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A52209B;
	Wed,  7 Aug 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048389; cv=none; b=NeZ99ixIDkNqhYuTOTZMIAPDi/bUdkDcz/vxPLlQ3Fj0ue8vriGIeUJ14zskll+OGlPSxHZSAx66SFT9HhtACUPR6M5LjidHgoA+BeYS7bEgwEz9ahWCQ7la8ieYiCNTLX4v9BH1Hll0w5c6z7sWQD2+GdjNUw8ZZQ00Ivl4v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048389; c=relaxed/simple;
	bh=QcaoM3knCrcyCzNjVhMc1BR/aHxtXeyzabBB7jGj+GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOX/vzgPG401+VoMfBAon5wAIoCF917EiaRMLzI2ohnaye/t4XM9zyPCIlZcC6ugfIubBCGWdLc9AEwnpFg0QgNKO8yHlVKGxaWjLJFkXbztfvth5CSPCtilkENc+z9lY59qS1Q8JFgRzzyLkONw6IAU708NePPvElAm29B2pSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXxSgf1f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IAZwAJN2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723048380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D4xZeauwBUzmOsESqLrF3sQCklkSjK5aSbTXbcdoDU=;
	b=IXxSgf1fQ2whPtmoVVG3jOz2Y6gMqFkh4KyI3YbZ/K1fjACh9ZycnYtaFjfcuCDagX4tX3
	GJwXQhgs9llVOoN6zD0T4Jq2fJvy38Dwsega8ruQrux4dB/ICug/0mmJW1fsIhfGimiRH2
	0jgbfpNCJZPgKU4hrquEyB3UNFx5f/gv2KZ/1US4y10Lmy5H4EizwZ2cc8Y3X6wmJ8phfg
	VcfDcV8eJw9JWv54GftW5qvfzPmw7igvvp69LFb2NMxPT77Nw51OwIjHtXBNZ/N5uA8Cui
	TVzwFPgFpk/UAvepaoFBgBZubmoMD1IGAbdzueKUkLdYAtJj+0UWPfrvMRiQ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723048380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7D4xZeauwBUzmOsESqLrF3sQCklkSjK5aSbTXbcdoDU=;
	b=IAZwAJN2npsOtAU417nhztzJSj8xyeFS+PBQmZ6Rvk/eXXfdX7G40mpGVWyTtEw/XQwrrD
	dLopzQR3uHGaUiBA==
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
 yanjiewtw@gmail.com, babu.moger@amd.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v6 04/22] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
In-Reply-To: <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
 <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
Date: Wed, 07 Aug 2024 18:33:00 +0200
Message-ID: <87ikwc2szn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 17:00, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1

This one wants to be in the database too

Thanks,

        tglx

