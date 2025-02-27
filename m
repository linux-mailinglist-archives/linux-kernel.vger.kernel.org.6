Return-Path: <linux-kernel+bounces-536699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDFA4831F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBA9169066
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF026BD8F;
	Thu, 27 Feb 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D/S5g08A"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECC26B956
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670650; cv=none; b=KePsLXIAQTiJ6aCh/jOCh0IJO48/rSzbCv7aVHgdko3U0aUYnbTuMiBs0t41l5Hqj8r4hj+VSf3ubhNaKJ1052hm5KG5u1vL/QdxLcwKdzx2M6Em9NJJhyDpQnYgQIWG+1TGKyLxQ4EnJXQj8HIXrelBJETHHZAWkONINM2QIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670650; c=relaxed/simple;
	bh=YSfOedZsS9fhkjfavHE8j9CyTUQjpp15uxo4izlmrDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4YQlI5IvUMGzzJPFCEUl84lp4DiziWsq8YzxBqx2tnPf0/lbEvniWAwrX7mcctHmD16uTmj4QexOP98rvj2xf+dK9et+y7P2m9z1DoJgfsSahZtl1iUUApO/vWPKHitar0bOXt/eHii/LDFo1XXaV2DrGUSqHS0Ov0oahRgQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D/S5g08A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE60740E021F;
	Thu, 27 Feb 2025 15:37:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BmXz8mYpK-Ca; Thu, 27 Feb 2025 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740670642; bh=Ey3zLxzeuLgTN8qAiZwyTCIfqo8HvA69W8Yppkcokpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/S5g08Ag75qocSsLSue27WY9xHHy1nICitRVwd19Sp3vjVSgfPh5K5sR6Pp3Stu1
	 9L6m/jP30oR6lClR8SlLuaqImzea/GCFnKtUMDrXDCHLO6hhhpItPwYczRhP4ADla3
	 HsfiLlWcJYJPynZzbnsPKmOwDts8+BEKwKcarrrRdnSYvTHK1IC8xxYnPTLzVOOUZk
	 pxx1Sq2BFQPxr+Px1Nwk15geYqvIv6ffw3ssXiF+JpAjDI8Oj+DVZCU+TTFw7XMt1f
	 MqdUV68VQwRMMWnTfFjJnMe8ANKHtrA3rm2SLhG4MnFOocwEEX9RSLIsRCHH+E87xM
	 FAnYwV8Mq7nravewKgdf3JLFrPJr+0IcSr9C661PkNwZ7o+jChY7lkjszE6j4Grr2z
	 ZZVLeqJw6GsqfVh3NM1BVcDDQjKUN6pTaPcmsLRAjpvqMDh1CyBPo5h7m8aPqb/+ts
	 NUv+N02ezdp6sQ0wx4qzUftbohg5syZooCR+Ok0Ww6XL+ZBKYIzWtyp1gPe7emE8Fn
	 RyUubiPe6+CKw7jcYoYGn/ENEjWs+8gnfu9EFUN9gjZLOFqL6xHR9HasptjtloSC7x
	 /GAP5i4d04gN2OB31qgVM/HsydaWsroUePpuE1GSuJv/Kk+/QkLfk/wLOUmYExIBId
	 XOfOvIU2JTnhhqMX9tZwehkE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B28440E01A3;
	Thu, 27 Feb 2025 15:37:12 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:37:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227153707.GGZ8CGoyaSgX6FkVWY@fat_crate.local>
References: <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
 <LV3PR12MB92651F3CE777A3723B61835594CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92651F3CE777A3723B61835594CD2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Feb 27, 2025 at 03:22:08PM +0000, Kaplan, David wrote:
> In this case, I think it is clearer to say
> mitigations=auto;no_guest_guest
> 
> That way, the admin is explicitly saying they don't want certain protection.
> This seems much harder to mess up.

So if we want to protect *only* against malicious VMs, the cmdline should be

mitigations:off;no_guest_guest

off being the policy to disable the other vectors because admin wants to have
her performance back.

Right?

Which then makes this one:

mitigations=off;guest_host

equivalent.

Uff.

> My argument is it's probably better to err on the side of security.

Probably. As you can realize, I'm playing the devil's advocate in all this
so that we can see how we feel about it.

> To me this seems like an unlikely use case, so maybe it's ok to be a bit more verbose.

Right, that use case is for benchmarkers. :)

> Ok, I can add that to the series.

Thx.

> But there's already an 'auto,nosmt' option.  So I thought we wanted to leave
> that alone and use it as the base.

There's that. And "nosmt" is actually the cross-thread attack vector.

I guess what we should do here is to leave "auto,nosmt" alone and use
"cross_thread" for the attack vector and not allow "nosmt" in the new
mitigations specification scheme.

IOW, the set of the attack vectors will be:

list_of_vectors = {user_kernel, user_user, guest_host, guest_guest,
cross_thread }

Or the no_ versions of them respectively.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

