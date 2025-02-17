Return-Path: <linux-kernel+bounces-518315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D561A38D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8241888B60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6901236A98;
	Mon, 17 Feb 2025 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOHL/NLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85C149C41
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823553; cv=none; b=fPf7EaoEO8zOeEIfEnPxKwrn6kV4roEC1m+eQzsxziYFYeMlq25xMufK9Z4eyRZdYzpnkyMHtRyORhEBtIK9bIfY3xtd1r9XeAMsVoUeVg2dxGX/QA7luFw9mGFLpZIMC5QypQoQVTPK1VhnftsXJl+Gh6bSQ8RCpStT6I0maKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823553; c=relaxed/simple;
	bh=vDJ8pRB/Q6DFIX5K/8i7KfCxR64ZIpaCUA0jL1aLzS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2NUPI7lK2U0+MeXFl024c8kIjWAYMwQCv8WWIS5F9dPT//yChtOr26oZz70kPNjww0Xl0k7AfGIt+h8QeTQtUxIrmw2ykSFXkU3Pf7NN5STR9pENjV2grvkJV49lg5QvJp30tucKspRXVzuAaI7UtzWZwLpQsM4QQwCnZn75uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOHL/NLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A6CC4CED1;
	Mon, 17 Feb 2025 20:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739823552;
	bh=vDJ8pRB/Q6DFIX5K/8i7KfCxR64ZIpaCUA0jL1aLzS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOHL/NLtTeDA4bBAKKGRpCIS9vecC24KZNfiIH2j7thBSWODDL6MhMXzrudOOUmpN
	 f/1LUgGf6f8n0pl5fNlZKJ41WPI8TQo+xf6EoZvjR/4/UysPrQrtZNFv4+BBFOHsOk
	 Wq+zuqLnqH+lNeoP76WQjL6dodI4kcMzs39Aq5oZCA+RvFAdSKesT5A96nacZA/K29
	 yY/6Hw86hJ3cwALswJNx3anKq8sXmjROuj9mmGTx5+eURS+Lw4Yj4bBqCt9FCyg69M
	 IUiFYRew9+xoYGK86e8eNzutyt2fv+NvJuwEeWl4uVy/GVA+srpJvCWz0R7EvMWdKx
	 82TGNvx60BdcQ==
Date: Mon, 17 Feb 2025 12:19:10 -0800
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
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Feb 17, 2025 at 05:33:24PM +0000, Kaplan, David wrote:
> So actually this doesn't quite work because the code in
> arch/x86/mm/pti.c has to call cpu_mitigate_attack_vector in order to
> check if PTI is required (it checks if user->kernel mitigations are
> needed).  That's the only use of the attack vectors outside of bugs.c.
> 
> The original code (using a function and WARN_ON_ONCE) can work, or I
> could perhaps create a pti-specific function in bugs.c that the pti
> code can query.  But right now I don't think there is any pti-related
> code in bugs.c at all.
> 
> Any suggestion?

Hm.  We *could* put the cpu_mitigate_attack_vector() macro in bugs.h and
make the array global (and possibly exported).  That way anybody could
call it, but it would still have the compile-time check.


However... should these not actually be arch-generic options, like
mitigations= already is?  It would make for a more consistent user
interface across arches.

They could even be integrated into the "mitigations=" interface.  The
options could be combined in any order (separated by commas):

  mitigations=user_kernel,user_user
  mitigations=guest_host,user_kernel
  ...etc...

And e.g., "mitigations=off" would simply disable all the vectors.

That would remove ambiguity created by combining mitigations= with
mitigate_* and would make it easier for all the current
cpu_mitigations_off() callers: only one global enable/disable interface
to call instead of two.  Any code calling cpu_mitigations_off() should
probably be calling something like cpu_mitigate_attack_vector() instead.

cpu_mitigations_off() and cpu_mitigations_auto_nosmt() could be
deprecated in favor of more vector-specific interfaces, and could be
removed once all the arches stop using them.  They could be gated by a
temporary ARCH_USES_MITIGATION_VECTORS option.  As could the per-vector
cmdline options.

Thoughts?

-- 
Josh

