Return-Path: <linux-kernel+bounces-536954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF2A4865B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D1C161755
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59101D935C;
	Thu, 27 Feb 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FSqc/RyO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DC1C701B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676066; cv=none; b=LZLZOIXRvPE1XeE8lh3zC12mDc94YcME9S3t/JaptifefzWWrlhnS40r+0fJrsWroEojqQy75w1cIppsueRMyURvNEgeu47F55HVcwcJoUsYDiEPBjjBloXL8uh9qDgjWYfE+wTBWkJZIZjPyras1jI/DQQR+yBgZyVyjNIeR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676066; c=relaxed/simple;
	bh=2O/u1bFf9Heyfj2EoNbG6PzfaNpoLsFDvDSjeQaIG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAz9UVJU98z+S5XMfZ+qG+cYWUMHb6t24P+75cSs+9YM1kTBu/3ECqCNggZPnMnK2TxyvZvr4vCTS6zJDzCSPvfp4dtv+7M1fpOyJHjEzWxO30ZLRvDbRK93xo8EbRh748xXFuxhuH9eo9tHfKNnCaDWcRsErLHIu98FJKJeW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FSqc/RyO reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 408C640E0202;
	Thu, 27 Feb 2025 17:07:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K4NvPX3oZn3e; Thu, 27 Feb 2025 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740676056; bh=dUnYz/T1Sxb6t0WLMN3+kAlC/8p5FxhjazdgMVb/Pjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSqc/RyOIlQLzklu1KIJSjVSJkpUAkJ+ooTeFh8rZ+TgT7gCFtFpvvxDYjmRQ6Qdu
	 9olySFuMBbEIE9RQG0JexwTVVEIc+R/0TzEXzscQZWc01BOM6Mw1rnXqrVesQ/hMKy
	 Jo03u1gmp95BFtuhUdwdKe7R/WuX9gDNks7QUKMPpkRte58OW6Nd2udMt7S9X2MAfE
	 wxX5UatpiNTLEeiYMd4Q4WtoonVq5jMAhi9jEtfIJ/AZ45V86cofbiEJfr7zAmpgQq
	 7AviuxOOGN78qw8IDLIb7qTOcAD4d888eUZKMQqcsxu0EMClI/Avv3vpvuzFqNbClD
	 HxUPx+Cy5y47zNpmiXfUu8jIRQtjzFqufs7T6G9ctrngd/IgcKVoyl9IKosNt+V3Ek
	 Scaa+pT4EbBZTcHxDY7aR1HgkPjeIEDphzXGLNLAMHwels2Db716//ibbWNZY6ywud
	 zu5VlQvZdDFeeB873dVf6x66uhJJszVZAX/gvXrC8z1LmzVchdyGgwqHB293oGDQog
	 2N36NveN0KWGxjld3pL6QyJm5xcpZAWQHjVFmXtHIl0DzCNPhaL86Y29kyEJJk9ouS
	 cNVBGtkFaua7vMYBRCArsp1wHJ4WjYdMjkRZZ6umXqY7IC/LIJfHOGkwzPmmfqGvKS
	 vYQcSl/jrZXGIpjAGuurCvoU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 073AE40E01A3;
	Thu, 27 Feb 2025 17:07:25 +0000 (UTC)
Date: Thu, 27 Feb 2025 18:07:19 +0100
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
Message-ID: <20250227170719.GIZ8CbxzfGBD02B1Y4@fat_crate.local>
References: <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
 <LV3PR12MB92651F3CE777A3723B61835594CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227153707.GGZ8CGoyaSgX6FkVWY@fat_crate.local>
 <LV3PR12MB9265078444D6B1B4258849FB94CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265078444D6B1B4258849FB94CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 04:05:08PM +0000, Kaplan, David wrote:
> No.  It should be 'mitigations=3Dauto;no_user_kernel,no_user_user'
>=20
> (And maybe add 'no_guest_guest' if they don=E2=80=99t care about the ma=
licious VMs attacking each other)

Doh, ofc, I meant that. :-P

mitigations=3Doff;no_guest_guest

is a non-sensical config: "disable all and then disable guest_guest
additionally". Doh.

> Right, the question is do we support both opt-in and opt-out forms.  We=
 can.
> We could also start by only supporting opt-out form.

We probably should put this to a vote. I think supporting both will cause
a lot of confusion but starting with one set and then maybe adding the ot=
her
one later, if really needed, is what we could start with.

> As mentioned earlier in the thread, SMT really needs a tristate of:
> 1. All SMT mitigations including potentially disabling SMT
> 2. All SMT mitigations but excluding the possibility of disabling SMT (=
current default)
> 3. No SMT mitigations (not even things like STIBP)
>=20
> There are various ways to encode that in the command line options.  'au=
to,nosmt' is already #1.  And just 'auto' is currently #2.
>=20
> We could then add 'no_cross_thread' to support #3.  I think that was th=
e latest proposal.

No objections here.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

