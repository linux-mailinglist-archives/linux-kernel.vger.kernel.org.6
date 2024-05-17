Return-Path: <linux-kernel+bounces-182222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE58C8840
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271AC281A97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FF8BE7;
	Fri, 17 May 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PpNnz19Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PpNnz19Y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BE79EA
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957089; cv=none; b=lCjsNSlskEWMHZi/hsk2BdwU77iWokEcm/cf7mLbmuqwKilVbt8HXqBPfJ3H/OjTtvd3DKJ22Pf8RlIEQyDRgwd9EYGAB5moZi256n5I+k45yEgcFY9eXbyBzRmGOmWwiKas8tVI19roRheODQTD+16l3wShR8HHzy3q0Fx37P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957089; c=relaxed/simple;
	bh=qXlhpnSQo4Yta6PYLDAuM78FWR18eYetR5pk7ir6sZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2LdshRRBgQOFma0xOD0sXB4Kvc1aemmPOKGQzeNkGF1MYeqYENA+4X9CeIgT0ZVba9HLBS9xMWtq1GRxncpJOy7xx1I/GgPAM2oEh+DQ3kpjvmNeABfyqSjcYkgNJk/WBxmVAqJiNVRtKGnpkKI/uGtGKsgz/rlv86JQMSFb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PpNnz19Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PpNnz19Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 222E13755F;
	Fri, 17 May 2024 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715957086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qXlhpnSQo4Yta6PYLDAuM78FWR18eYetR5pk7ir6sZM=;
	b=PpNnz19Y1KQtWPHfjRi+Jp4e7TibYY86M8vWrpQ8kG2MLDT0DvTj0d5tyP7giTUiN7qn56
	eCWglPhMs0WPfviov0QcaQ+DffzNlp2aNXwEceeoWyyXvOPLDkPmbP9JUe7aNfGJKg2trr
	N+1TB/mIBz6VUnZnI1TkGhavVg70xV8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715957086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qXlhpnSQo4Yta6PYLDAuM78FWR18eYetR5pk7ir6sZM=;
	b=PpNnz19Y1KQtWPHfjRi+Jp4e7TibYY86M8vWrpQ8kG2MLDT0DvTj0d5tyP7giTUiN7qn56
	eCWglPhMs0WPfviov0QcaQ+DffzNlp2aNXwEceeoWyyXvOPLDkPmbP9JUe7aNfGJKg2trr
	N+1TB/mIBz6VUnZnI1TkGhavVg70xV8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD47F13942;
	Fri, 17 May 2024 14:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d1aQMF1tR2YZRQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 17 May 2024 14:44:45 +0000
Message-ID: <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
Date: Fri, 17 May 2024 16:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
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
In-Reply-To: <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U01Ii1vaf2f58pLpq4QqIpD4"
X-Spam-Flag: NO
X-Spam-Score: -5.19
X-Spam-Level: 
X-Spamd-Result: default: False [-5.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U01Ii1vaf2f58pLpq4QqIpD4
Content-Type: multipart/mixed; boundary="------------140NpknsPueMmPLVOQnxJSsw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
In-Reply-To: <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>

--------------140NpknsPueMmPLVOQnxJSsw
Content-Type: multipart/mixed; boundary="------------tmx0PgGFHrXp2ws2H0Ct56vf"

--------------tmx0PgGFHrXp2ws2H0Ct56vf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjQgMTY6MzksIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMTcsIDIwMjQgYXQgMDQ6MDg6MDNQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IE9uIDE3LjA1LjI0IDE1OjU1LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gT24gRnJpLCBNYXkgMTcsIDIwMjQgYXQgMDI6MTQ6NTBQTSArMDIwMCwgSnVlcmdlbiBH
cm9zcyB3cm90ZToNCj4+Pj4gV2hpbGUgdGVzdGluZyBURFggaG9zdCBzdXBwb3J0IHBhdGNo
ZXMsIGEgY3Jhc2ggb2YgdGhlIGhvc3QgaGFzIGJlZW4NCj4+Pj4gb2JzZXJ2ZWQgYSBmZXcg
aW5zdHJ1Y3Rpb25zIGFmdGVyIGRvaW5nIGEgc2VhbWNhbGwuIFJlYXNvbiB3YXMgYQ0KPj4+
PiBjbG9iYmVyZWQgJXJicCAoc2V0IHRvIDApLCB3aGljaCBvY2N1cnJlZCBpbiBzcGl0ZSBv
ZiB0aGUgVERYIG1vZHVsZQ0KPj4+PiBvZmZlcmluZyB0aGUgZmVhdHVyZSBOT1QgdG8gbW9k
aWZ5ICVyYnAgYWNyb3NzIFREWCBtb2R1bGUgY2FsbHMuDQo+Pj4+DQo+Pj4+IEluIG9yZGVy
IG5vdCBoYXZpbmcgdG8gYnVpbGQgdGhlIGhvc3Qga2VybmVsIHdpdGggQ09ORklHX0ZSQU1F
X1BPSU5URVIsDQo+Pj4+IHNhdmUgJXJicCBhY3Jvc3MgYSBzZWFtY2FsbC90ZGNhbGwuDQo+
Pj4NCj4+PiBUaGVyZSdzIGEgZmVhdHVyZSBpbiBURFggbW9kdWxlIDEuNSB0aGF0IHByZXZl
bnRzIFJCUCBtb2RpZmljYXRpb24gYWNyb3NzDQo+Pj4gVERILlZQLkVOVEVSIFNFQU1DQUxM
LiBTZWUgTk9fUkJQX01PRCBpbiBURFggTW9kdWxlIDEuNSBBQkkgc3BlYy4NCj4+Pg0KPj4+
IEkgdGhpbmsgaXQgaGFzIHRvIGJlIGVuYWJsZWQgZm9yIGFsbCBURHMgYW5kIFREWCBtb2R1
bGVzIHRoYXQgZG9uJ3QNCj4+PiBzdXBwb3J0IGl0IG5lZWQgdG8gYmUgcmVqZWN0ZWQuDQo+
Pj4NCj4+DQo+PiBZZXMsIEkga25vdy4gSSdtIHVzaW5nIHRoZSBwYXRjaCBzZXJpZXM6DQo+
Pg0KPj4gICAgW1BBVENIIHYxOSAwMDAvMTMwXSBLVk0gVERYIGJhc2ljIGZlYXR1cmUgc3Vw
cG9ydA0KPj4NCj4+IHdoaWNoIEkgdGhpbmsgZG9lcyBleGFjdGx5IHRoYXQgKHNlZSBzZXR1
cF90ZHBhcmFtcygpIGFuZCB0ZHhfbW9kdWxlX3NldHVwKCkpLg0KPiANCj4gTG9va3MgbGlr
ZSB0aGUgY2hlY2sgaXMgYnJva2VuOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzQ2bWg1aGluc3Y1bXVwMng3anY0aXUyZmxveG1ham8yaWdyeGIzaGFydTNjZ2p1a2Jn
QHY0NG5zcGpvem00aC8NCj4gDQo+PiBOZXZlcnRoZWxlc3MgdGhlIGNsb2JiZXJpbmcgaGFw
cGVuZWQsIGFuZCBzYXZpbmcvcmVzdG9yaW5nICVyYnAgbWFkZSB0aGUNCj4+IGlzc3VlIHRv
IGdvIGF3YXkuIEkgc3VzcGVjdCB0aGVyZSBpcyBhIHBhdGggbGVmdCBzdGlsbCBjbG9iYmVy
aW5nICVyYnAuDQo+IA0KPiBXaGF0IGlzIHlvdXIgVERYIG1vZHVsZSB2ZXJzaW9uPyBNeSBn
dWVzcyBpcyB0aGF0IE5PTV9SQlBfTU9EIGlzIG5vdA0KPiBzdXBwb3J0ZWQgYnkgaXQgYW5k
IGdpdmVuIHRoYXQgdGhlIGNoZWNrIGlzIGJyb2tlbiBub2JvZHkgZW5mb3JjZXMgaXQuDQoN
Ckp1c3QgYW5vdGhlciBkYXRhIHBvaW50OiBCZWZvcmUgdXNpbmcgdGhpcyBtYWNoaW5lIEkg
d2FzIHRlc3Rpbmcgb24NCmFub3RoZXIgb25lIHdpdGggb2xkZXIgZmlybXdhcmUuIFRoYXQg
b25lIHJlYWxseSBkaWRuJ3Qgc3VwcG9ydCBOT01fUkJQX01PRA0KYW5kIEkgbmVlZGVkIHRv
IGJ1aWxkIHRoZSBrZXJuZWwgd2l0aCBDT05GSUdfRlJBTUVfUE9JTlRFUiBlbmFibGVkIHRv
IGdldA0KcGFzdCB0aGUgY2hlY2sgeW91IGFyZSBtZW50aW9uaW5nIGFib3ZlLg0KDQoNCkp1
ZXJnZW4NCg==
--------------tmx0PgGFHrXp2ws2H0Ct56vf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------tmx0PgGFHrXp2ws2H0Ct56vf--

--------------140NpknsPueMmPLVOQnxJSsw--

--------------U01Ii1vaf2f58pLpq4QqIpD4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZHbV0FAwAAAAAACgkQsN6d1ii/Ey/4
AAf+K86L3su9bl0FPIwPaISdUAzg17w+gepE5t2UEBNk61m5qRBXn7pmyNjCHjXYn+DMhPdgRULj
EPif129t7ix1bSC1wfkgF9gmxCi+adVnWc5O/tKHQ/NEKbRM6QBX1iZD4regHDj5rk7jleInN0TI
YBVfOw53iaWSmjob7P+5afyd2/cHQ414o70z0nfE1WRURKIa66m8429fpq8DWWv/e38BNoJgnIuM
7e2S4bcLpW33TOTrNdQvACu9cGM6sysMIiSY/lp4zF70q4Gto6Che5V8gNAzdzRdQQqsq0uA+v/r
Aa2xVAHGykEeyAlTY/kggkXOQmuuuHfwfK1Hyn820g==
=BV1o
-----END PGP SIGNATURE-----

--------------U01Ii1vaf2f58pLpq4QqIpD4--

