Return-Path: <linux-kernel+bounces-510153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F8A318ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13373AA078
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84172268FEA;
	Tue, 11 Feb 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+QqcKu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195A2710B9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313520; cv=none; b=YJ/ROM6JqYViMKIpV+C11vvZD8AUg2mqKVHmZWAZYllkQkVXCwHLvW00YNkoSifGJPznJ2FAEJqfXwyiZpen/5U393kZKthoeykcabNniovXsJnhM7swXvaomiRT0PGFE2pXA67GA/pXGadDBt7PRfAzRRtna31sbt9595lRk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313520; c=relaxed/simple;
	bh=Ofc2s4vpGmaMWWDhVsNL278lbhJ2c9yS4jHbTJwYQEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epkvrmR1iI1Zbh9uP3QZ69scAMhwoPV4J8EU75tKV8lye5pwWiVAn41hXVUy7mlrTxyDNolrQFJSZbuHkDod87qTjNctn9T8i8H/jVJS79t6O2+8juM3mWQt7r9C0lmKbIO4/eTldGWMfIeQeT0va91eiHboV1Go6iHNsqaMpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+QqcKu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC21C4CEDD;
	Tue, 11 Feb 2025 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739313519;
	bh=Ofc2s4vpGmaMWWDhVsNL278lbhJ2c9yS4jHbTJwYQEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+QqcKu65Hxy8ZpiQcNyxOWh3c4JoyrVYbYT18FNR21aa4Dky6LLDwiJHKCxn/AUW
	 vk0qPPisfryzy3e5VldC8LPKdqoexEmzQGtXQgSQc6Abc3+N9O1haEQjnv++d0UcgX
	 4Uu6qDbes4Zu6Nyz69ykyt3QTq7S2ShJmW7iW807nfw6Hka4EuAPiKwOln8vu6+wYS
	 J+9RynJtZEH73qarXaeygbeHajhj8nEU2NuJcv7oMSYhvllkQnILvyd+lxyTDPEjT2
	 0It7qE7QkY1/xUMy+JVDa0gIfo69LK5pgXhCZBz7myFcTfqtlc7ECvNDvMY92Fil+D
	 c8NVDjSNP2cJw==
Date: Tue, 11 Feb 2025 14:38:37 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 21/35] x86/bugs: Determine relevant vulnerabilities
 based on attack vector controls.
Message-ID: <20250211223837.44254vntc5tspirf@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-22-david.kaplan@amd.com>
 <20250211184130.2fl4jvdwd4e5y32a@jpoimboe>
 <20250211185400.vwu3tkqr4gc2r5tu@jpoimboe>
 <LV3PR12MB9265D7BF6446C2D84414E42C94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211203430.vvuf7aks3hrozv5b@jpoimboe>
 <LV3PR12MB9265E936344F123A5464D89794FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265E936344F123A5464D89794FD2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Tue, Feb 11, 2025 at 08:53:53PM +0000, Kaplan, David wrote:
> If I understand your proposal correctly, 'mitigate_disable_smt' means
> that the kernel may disable SMT if a vulnerability being mitigated
> requires it (yes?).  I wonder if that should be 'mitigate_smt' with a
> 3-way selection of:
> 
> 'on' (disable SMT if needed based on vulnerabilities)
> 'auto' (do not disable SMT but apply other existing SMT-based mitigations on relevant vulnerabilities)
> 'off' (do not apply any SMT related mitigations like STIBP)
> 
> And this would not be used when selecting whether to mitigate a bug, only in which mitigations are applied.
> 
> Thoughts?

Sounds good!

-- 
Josh

