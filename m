Return-Path: <linux-kernel+bounces-182315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D98C8996
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C129B21B21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC012F591;
	Fri, 17 May 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eIuOnZWe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eIuOnZWe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1345A116
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960895; cv=none; b=Gm5eoyI0Tw2Lm5nSXmv7zBgu8/fU599naDMCWoH6Aktxat8SmUs2BsER3u/GoZDyg7N5A6OJwInM4YiGZkHOWOQgzd0hO7WWG/miWC7zA50snYoT9mlRihjJJui8u5ngt9r4exRckY5tp6JRRMA/rJe3PJSf4ghMh6Y+Vxw0IVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960895; c=relaxed/simple;
	bh=3a8gwMpyImpAACMqUpKLBBDceBnjD6mN5bcubXEfmuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtRxRcFPPx5ePpwNbmFLlLRvVJIe+A7dkcmErXvI0QNkB+6Wx0wBZBvJNl2ERovhLrb0VjUS+pnJTnmwIn/BjW+y3vW3W13apoy5kdYDYyc0Mv/8j7EMNSU6nYdgBGUWjRan8exNyg5RRDKjSzSaYlu3wIWzuT08rdJlKPQwYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eIuOnZWe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eIuOnZWe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41817222B6;
	Fri, 17 May 2024 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715960892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3a8gwMpyImpAACMqUpKLBBDceBnjD6mN5bcubXEfmuY=;
	b=eIuOnZWezpElp+9adahoFa6Yn3ihdkHQHMsZj6B/SQCpMnHG8yL1IWtrdOuGMS9rb5im76
	VSCoLLWTPvGWPdlv81Z2W8hICYlvo+cCWYa0jE2V3wWt05M/2UrCS7RLeodq6TIirM7LqU
	0d3CIWOchS95L53dKjr8v/bMwyL2AhY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715960892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3a8gwMpyImpAACMqUpKLBBDceBnjD6mN5bcubXEfmuY=;
	b=eIuOnZWezpElp+9adahoFa6Yn3ihdkHQHMsZj6B/SQCpMnHG8yL1IWtrdOuGMS9rb5im76
	VSCoLLWTPvGWPdlv81Z2W8hICYlvo+cCWYa0jE2V3wWt05M/2UrCS7RLeodq6TIirM7LqU
	0d3CIWOchS95L53dKjr8v/bMwyL2AhY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D939A13991;
	Fri, 17 May 2024 15:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6NJAMzt8R2avbwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 17 May 2024 15:48:11 +0000
Message-ID: <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
Date: Fri, 17 May 2024 17:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------c2NaTpwZZM0yGUWHaquZBFX0"
X-Spam-Flag: NO
X-Spam-Score: -6.19
X-Spam-Level: 
X-Spamd-Result: default: False [-6.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------c2NaTpwZZM0yGUWHaquZBFX0
Content-Type: multipart/mixed; boundary="------------erFAakPskxNTB5HCQeZPUutK";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
In-Reply-To: <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>

--------------erFAakPskxNTB5HCQeZPUutK
Content-Type: multipart/mixed; boundary="------------YR6FaWJz3FyecSZ6uRKrI6ua"

--------------YR6FaWJz3FyecSZ6uRKrI6ua
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjQgMTc6NDMsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiA1LzE3LzI0IDA4
OjI3LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMTcuMDUuMjQgMTc6MTYsIERhdmUg
SGFuc2VuIHdyb3RlOg0KPj4+IE9uIDUvMTcvMjQgMDc6NDQsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4+IEp1c3QgYW5vdGhlciBkYXRhIHBvaW50OiBCZWZvcmUgdXNpbmcgdGhpcyBt
YWNoaW5lIEkgd2FzIHRlc3Rpbmcgb24NCj4+Pj4gYW5vdGhlciBvbmUgd2l0aCBvbGRlciBm
aXJtd2FyZS4gVGhhdCBvbmUgcmVhbGx5IGRpZG4ndCBzdXBwb3J0DQo+Pj4+IE5PTV9SQlBf
TU9EDQo+Pj4+IGFuZCBJIG5lZWRlZCB0byBidWlsZCB0aGUga2VybmVsIHdpdGggQ09ORklH
X0ZSQU1FX1BPSU5URVIgZW5hYmxlZCB0bw0KPj4+PiBnZXQNCj4+Pj4gcGFzdCB0aGUgY2hl
Y2sgeW91IGFyZSBtZW50aW9uaW5nIGFib3ZlLg0KPj4+DQo+Pj4gRm9yIGFsbCBpbnRlbnRz
IGFuZCBwdXJwb3NlcywgdGhlIG1vZHVsZXMgdGhhdCBpbnRlbnRpb25hbGx5IGNsb2JiZXIg
UkJQDQo+Pj4gZG9uJ3Qgc3VwcG9ydCBMaW51eC4gSWYgYnVnZ3kgbW9kdWxlcyBhcmUgYWNj
aWRlbnRhbGx5IGNsb2JiZXJpbmcgUkJQLA0KPj4+IHdlIGNhbiBkZWJhdGUgaG93IG11Y2gg
dGhlIGtlcm5lbCBzaG91bGQgYmVuZCBvdmVyIHRvIGFjY29tbW9kYXRlIHRoZW0sDQo+Pj4g
YnV0IG15IHByZWZlcmVuY2Ugd291bGQgYmUgdG8gaWdub3JlIHRoZW0uDQo+Pj4NCj4+PiBJ
J2QgbXVjaCByYXRoZXIgcHV0IGEgZGVueSBsaXN0IGluIHRoZSBrZXJuZWwgdGhhbiB0cnkg
dG8gdG9sZXJhdGUgUkJQDQo+Pj4gY2xvYmJlcmluZyB1bml2ZXJzYWxseS4NCj4+DQo+PiBX
b3VsZCB5b3UgYmUgZmluZSB3aXRoIGFkZGluZyBhIG5ldyBYODZfRkVBVFVSRSAob3IgQlVH
PykgYWxsb3dpbmcNCj4+IHRvIHN3aXRjaCBSQlAgc2F2ZS9yZXN0b3JlIHZpYSBBTFRFUk5B
VElWRSwgY29udHJvbGxlZCBieSBhIGNvbW1hbmQNCj4+IGxpbmUgb3B0aW9uPw0KPj4NCj4+
IE9yIG1heWJlIGJ5IGFkZGluZyBhIG5ldyBDT05GSUdfVERYX01PRFVMRV9DQU5fQ0xPQkJF
Ul9SQlAgKHByb2JhYmx5DQo+PiB1c2luZyBhIHNob3J0ZXIgbmFtZSkgb3B0aW9uPw0KPiAN
Cj4gQXMgYSBsYXN0IHJlc29ydCBtYXliZS4NCj4gDQo+PiBUQkggSSdtIHNsaWdodGx5IHB1
enpsZWQgdGhhdCB0aGUgZmlybXdhcmUgSSdtIHVzaW5nIGNvdWxkIG1ha2UgaXQNCj4+IG91
dHNpZGUgSW50ZWwuIEknbSBmZWFyaW5nIHRoaXMgbWlnaHQgaGFwcGVuIGFnYWluLg0KPiAN
Cj4gWW91J3JlIHB1enpsZWQgdGhhdCB0aGUgZmlybXdhcmUgaXMgZWl0aGVyIG9sZCBidWdn
eSBvciBib3RoPyBIdWguDQo+IA0KPiBJbnRlbCBzaGlwcyBhbGwga2luZHMgb2YgY3Jhenkg
cHJlLXByb2R1Y3Rpb24gc3R1ZmYgYXMgZGV2ZWxvcG1lbnQNCj4gcGxhdGZvcm1zLiBMZXQn
cyBtYWtlIHN1cmUgd2Uga25vdyB3aGF0IHlvdSd2ZSBnb3QgYmVmb3JlIHdlIGdvIHRlYXJp
bmcNCj4gdXAgbWFpbmxpbmUgZm9yIGl0Lg0KPiANCj4gQmVjYXVzZSBpZiB0aGUgb3B0aW9u
cyBhcmU6DQo+IA0KPiAgIDEuIE1haW50YWluIGNvZGUgaW4gbWFpbmxpbmUgdW50aWwgdGhl
IGRheSBJIGRpZV5XcmV0aXJlDQo+IA0KPiBvcg0KPiANCj4gICAyLiBHZXQgSsO8cmdlbiBh
IEJJT1MgdXBkYXRlIHNvIGhlIHN0b3BzIHNlbmRpbmcgcGF0Y2hlcw0KPiANCj4gLi4gaXQn
cyBraW5kYSBhbiBlYXN5IGNob2ljZS4gOykNCj4gDQoNCjotKQ0KDQpJcyB0aGUgQklPUyB2
ZXJzaW9uIHByaW50ZWQgYXQgYm9vdCBlbm91Z2ggdG8gc2VlIHdoYXQgSSBoYXZlPw0KDQpb
ICAgIDAuMDAwMDAwXSBETUk6IEludGVsIENvcnBvcmF0aW9uIEQ1MEROUC9ENTBETlAsIEJJ
T1MgDQpTRTVDNzQxMS44NkIuOTUzNS5EMDQuMjMxMjI3MDUxOCAxMi8yNy8yMDIzDQoNCg0K
SnVlcmdlbg0K
--------------YR6FaWJz3FyecSZ6uRKrI6ua
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------YR6FaWJz3FyecSZ6uRKrI6ua--

--------------erFAakPskxNTB5HCQeZPUutK--

--------------c2NaTpwZZM0yGUWHaquZBFX0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZHfDsFAwAAAAAACgkQsN6d1ii/Ey/4
ZAf+Jz9Qu8GYUkJ1Zj95OzBk661f6BKeJIaUDxAF+PWrDzN2akeNhj5pUMGgep7A9Oh7aCGZeRg9
NnhLPUf9yyoqmoGMFk/THWBSwDZa2rSxlMkMtf/OiF1qNguYoff31aZKkONSMfguFDqWiDFKTYiv
PR4qB7MgEbPRiVZ0vPkjOIQV848l4P6hZ9eWLVVsd8cVfEHkjKrJl1J2np2WsKHYfj96yIGcSdx4
xhJlE/Xx2F9ST2UafGMxGA+iBWMLRK5JEhkExPbxFuczW7a8t15X1RyNQlOHyHi4FknLUEWlPeKF
ahEH8KRDpwAzE+7hrb0nruTyJZ5aju2pFYgQjTClXQ==
=34IO
-----END PGP SIGNATURE-----

--------------c2NaTpwZZM0yGUWHaquZBFX0--

