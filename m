Return-Path: <linux-kernel+bounces-536539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D10A480BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A625E3A9915
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDD233D7B;
	Thu, 27 Feb 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D1QqMFlR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08B22FF42
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665365; cv=none; b=cv2KofgvKZijasQVNtzet+noDD92oKQfq/AQYoV1Anz7IZw5kZlX2NyxKP5WAUtuZBQ3ZPza8wSUW5ql6ar+6vxBuuv7PcC+kV6r3kQsddaeplwBmwyQfIdxi7Xpt/p0H1m5rQN3C/JdmRE6RpO1gK5ez/Y1HbeZnggGRbpTTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665365; c=relaxed/simple;
	bh=Hi9Mp1AAFllqGxKPspf+DsegSpFTi2IJ/amGPL0yNPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEq6C7aZslqRcofYdpMsmC74qPbujCQdxNn2WIX8UjIXckmc8SYbfTypQEGiZKK2njM5GEG7IexE5BJVEnZuFhlAM9nxtY8R6IfIXPM0jbNl2/tHmYLlK1A6ViNMQNd0dq11CRmqnBJoK6/ETTvjBQa9ckWjeEYuJfNo74Qnceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D1QqMFlR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 792AF40E01AE;
	Thu, 27 Feb 2025 14:09:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8eFN3L3CQT5n; Thu, 27 Feb 2025 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740665355; bh=vDJ9tdc/hxyj77FADptJ382wj95JHb7D2GO1rnAYVw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1QqMFlRqBv/tH/KZowRMIp0v+3AaY4+kJNjDO7tX+inzTCi4igDNZdbmqJpi8p1S
	 +ZsgKvQ4HUfCl/IJGAW+xRNUHHIU5elddzrKnVDVquC2+iL4RFRapQFda2w6bwvehZ
	 gOjxFdfNQNckiRXsr4CXB5xG7Qq6QpAvsO0P2Jw0jBSlX6WnoWkzaNWl6+Y7gjpsOK
	 h+qDVGKsLJWPjG7UtKVymnD6J+nwOQKB/ERO4XZUTqRL5q6tD1SgIHpnn+Jcd2wYgt
	 kJ2gmfA1gSUagJsjWEmsL76uSG/hiJ7tlenuGhqmGRY4ktfDah25f9eSr5dftppf2L
	 1IEonQakVYH//0rDc1zKZAP5fXCQuYbSk3zvx7QePxxUwDmd9q1+mkm7cqYgcCNG+s
	 eaHlzU0kxN+EL8elMZhP5zOKZ8Y846rMGVHkKyvTANDOzVe2v4tCs7m9IZaM+CCzeK
	 beugyq+rmGEEJz+Y8puJgUfh8bd+LGisnxW30Fn+eFt9V3GU7ZoIQ9NiB56micCh0L
	 Iwp6keHwnb0Hz1bE5Cep1+Z0HV62qR7gQ+ajainr/5/4n/KpBKbcbG89PpeuCYr91Q
	 KNv4uB7gglYH8kU8vsBqaiBu21/xtPy0MIEL7mMsJLW+PRsJbNufaKYMzfUbo9hREY
	 lnMkgepF0VTVPGhpo/kwsCoQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D5EF40E01A3;
	Thu, 27 Feb 2025 14:09:05 +0000 (UTC)
Date: Thu, 27 Feb 2025 15:08:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
References: <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227034813.booxbhxnff66dnqx@desk>

On Wed, Feb 26, 2025 at 07:50:38PM -0800, Pawan Gupta wrote:
> Thats fair. I certainly don't want to be adding new option if we are
> willing to live with some minor quirks with auto,nosmt.
> 
> Like, should the order in which nosmt appears after =auto matter? IOW,
> "=auto,no_foo,nosmt" would be equivalent to "=auto,nosmt,no_foo"? I believe
> they should be treated the same.

Yes, they should be. The order within a single mitigations=<string> shouldn't
matter.

> So as to treat nosmt as any other attack vector, CPU_MITIGATIONS_AUTO_NOSMT
> should go away. I am thinking we can modify cpu_mitigations_auto_nosmt() to
> check for smt attack vector:

Looks like we're calling it an attack vector if I look at the cross-thread
section in the documentation patch:

https://lore.kernel.org/r/20250108202515.385902-20-david.kaplan@amd.com

So I guess the cmdline format should be something like:

mitigations=<global_vector_policy>;<list_of_vectors>

More concretely:

mitigations=(on|off|auto);((no)_<vector>)?

Btw, it probably would be better to split the global policy and the vectors
with ';' instead of ',' for an additional clarity and ease of parsing.

Before this goes out of hand with bikeshedding: please think about what
configurations we want to support and why and then design the command line
syntax - not the other way around.

I'm still not fully sold on the negative vector options. Although it sure does
save typing.

With my user hat on: If I have to do "no_user_kernel" then I probably need to
go look what else is there. Do I want it, need it? Dunno. Maybe.

If I do

mitigations=;no_user_kernel

then yeah, that would basically set everything else to "auto" and disable
user_kernel.

David still wants to warn if there's no global option supplied like "auto" but
we can simply assume it is meant "auto" but warn. This is the most intuitive
thing to do IMO.

And when it comes to warning about nonsensical options - yap, we should do so
when parsing.

A couple more random examples as food for bikeshedding:

mitigation=auto;nosmt,user_user	- running untrusted user stuff, prevent user
apps from attacking each-other, kernel protections are default

mitigations=off;guest_host - running untrusted VMs, protect host from them

mitigations=off;guest_host,guest_guest,cross_thread - cloud provider settings

Same thing with negative options should probably be

mitigations=;no_user_kernel,no_user_user

Hmm, I dunno: being able to specify the same thing in two different ways is
calling for trouble. I think we should keep it simple and do positive options
first and then consider negative if really really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

