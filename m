Return-Path: <linux-kernel+bounces-182173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037298C87BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA36284902
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A005A4FF;
	Fri, 17 May 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QDjp4AgT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QDjp4AgT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300058119
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954887; cv=none; b=iTcHH+kB8ICHwX+oqRda8Q41qqh4NSSSdNRXO898MRL6Uy/Hq/9LEmCutpEuJU6KwGwHUhhUT8qH0EQ8+VZ2zSu1/1QoFiTRqvNZMiMS23MbCt6/SRr5kJZIdlOthANvQbOYMmgnwdYw7fXqALRbahSY9taGvveZ7XS6DIoXp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954887; c=relaxed/simple;
	bh=ZVNjW+cI8mSwE20fMPjq+cBcff4M0bs+H1QjaX9FJOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZFZy9AlEkMFez2Uh5lnVEGecyMuL3LYP6F/HYcXSOc5FAGRec9wPeGV00bS1L2J7AtQ2W0n1Px4S9MAJJFgP1Mdy7njhW65zoT0C4ZE2rwYMwS7mVN1U88FyQnAlkLsA7abzipnq2UxL5/jePfVUDc8Pp0+pMp9GxQ+8F+iJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QDjp4AgT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QDjp4AgT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60F6F5D440;
	Fri, 17 May 2024 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715954884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZVNjW+cI8mSwE20fMPjq+cBcff4M0bs+H1QjaX9FJOg=;
	b=QDjp4AgTIl6UZ2cvBGn/ibuMbI//l7WHbwoDJRT/mNrA0An/gno0y/EIgPIDcJi0QFfaoL
	PrKInOyDu/AMU9xE50Y+O1vOD55967+zwcDl5A02n5K6RcYAxPlKjCrnI6VPXAR7ndjKK5
	MVrFCf2wfaSBWPh3p3MYHMVnZp8ctgQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715954884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZVNjW+cI8mSwE20fMPjq+cBcff4M0bs+H1QjaX9FJOg=;
	b=QDjp4AgTIl6UZ2cvBGn/ibuMbI//l7WHbwoDJRT/mNrA0An/gno0y/EIgPIDcJi0QFfaoL
	PrKInOyDu/AMU9xE50Y+O1vOD55967+zwcDl5A02n5K6RcYAxPlKjCrnI6VPXAR7ndjKK5
	MVrFCf2wfaSBWPh3p3MYHMVnZp8ctgQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1898213942;
	Fri, 17 May 2024 14:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sX0iBMRkR2ZCEAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 17 May 2024 14:08:04 +0000
Message-ID: <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
Date: Fri, 17 May 2024 16:08:03 +0200
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
In-Reply-To: <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gXiJyEuVi0vHir2yLceJq3vs"
X-Spam-Flag: NO
X-Spam-Score: -5.19
X-Spam-Level: 
X-Spamd-Result: default: False [-5.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
--------------gXiJyEuVi0vHir2yLceJq3vs
Content-Type: multipart/mixed; boundary="------------zvA94lUjzg0YOBR4bqS92vZQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
In-Reply-To: <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>

--------------zvA94lUjzg0YOBR4bqS92vZQ
Content-Type: multipart/mixed; boundary="------------7jW40ockSBPNTlniyOaWunWI"

--------------7jW40ockSBPNTlniyOaWunWI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjQgMTU6NTUsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMTcsIDIwMjQgYXQgMDI6MTQ6NTBQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IFdoaWxlIHRlc3RpbmcgVERYIGhvc3Qgc3VwcG9ydCBwYXRjaGVzLCBhIGNyYXNo
IG9mIHRoZSBob3N0IGhhcyBiZWVuDQo+PiBvYnNlcnZlZCBhIGZldyBpbnN0cnVjdGlvbnMg
YWZ0ZXIgZG9pbmcgYSBzZWFtY2FsbC4gUmVhc29uIHdhcyBhDQo+PiBjbG9iYmVyZWQgJXJi
cCAoc2V0IHRvIDApLCB3aGljaCBvY2N1cnJlZCBpbiBzcGl0ZSBvZiB0aGUgVERYIG1vZHVs
ZQ0KPj4gb2ZmZXJpbmcgdGhlIGZlYXR1cmUgTk9UIHRvIG1vZGlmeSAlcmJwIGFjcm9zcyBU
RFggbW9kdWxlIGNhbGxzLg0KPj4NCj4+IEluIG9yZGVyIG5vdCBoYXZpbmcgdG8gYnVpbGQg
dGhlIGhvc3Qga2VybmVsIHdpdGggQ09ORklHX0ZSQU1FX1BPSU5URVIsDQo+PiBzYXZlICVy
YnAgYWNyb3NzIGEgc2VhbWNhbGwvdGRjYWxsLg0KPiANCj4gVGhlcmUncyBhIGZlYXR1cmUg
aW4gVERYIG1vZHVsZSAxLjUgdGhhdCBwcmV2ZW50cyBSQlAgbW9kaWZpY2F0aW9uIGFjcm9z
cw0KPiBUREguVlAuRU5URVIgU0VBTUNBTEwuIFNlZSBOT19SQlBfTU9EIGluIFREWCBNb2R1
bGUgMS41IEFCSSBzcGVjLg0KPiANCj4gSSB0aGluayBpdCBoYXMgdG8gYmUgZW5hYmxlZCBm
b3IgYWxsIFREcyBhbmQgVERYIG1vZHVsZXMgdGhhdCBkb24ndA0KPiBzdXBwb3J0IGl0IG5l
ZWQgdG8gYmUgcmVqZWN0ZWQuDQo+IA0KDQpZZXMsIEkga25vdy4gSSdtIHVzaW5nIHRoZSBw
YXRjaCBzZXJpZXM6DQoNCiAgIFtQQVRDSCB2MTkgMDAwLzEzMF0gS1ZNIFREWCBiYXNpYyBm
ZWF0dXJlIHN1cHBvcnQNCg0Kd2hpY2ggSSB0aGluayBkb2VzIGV4YWN0bHkgdGhhdCAoc2Vl
IHNldHVwX3RkcGFyYW1zKCkgYW5kIHRkeF9tb2R1bGVfc2V0dXAoKSkuDQoNCk5ldmVydGhl
bGVzcyB0aGUgY2xvYmJlcmluZyBoYXBwZW5lZCwgYW5kIHNhdmluZy9yZXN0b3JpbmcgJXJi
cCBtYWRlIHRoZQ0KaXNzdWUgdG8gZ28gYXdheS4gSSBzdXNwZWN0IHRoZXJlIGlzIGEgcGF0
aCBsZWZ0IHN0aWxsIGNsb2JiZXJpbmcgJXJicC4NCg0KSSB3YXMgdGVzdGluZyBvbiBhbiBF
bWVyYWxkIFJhcGlkcyBzeXN0ZW06DQoNCiMgbHNjcHUNCkFyY2hpdGVjdHVyZTogICAgICAg
ICAgICAgeDg2XzY0DQogICBDUFUgb3AtbW9kZShzKTogICAgICAgICAzMi1iaXQsIDY0LWJp
dA0KICAgQWRkcmVzcyBzaXplczogICAgICAgICAgNDcgYml0cyBwaHlzaWNhbCwgNTcgYml0
cyB2aXJ0dWFsDQogICBCeXRlIE9yZGVyOiAgICAgICAgICAgICBMaXR0bGUgRW5kaWFuDQpD
UFUocyk6ICAgICAgICAgICAgICAgICAgIDI1Ng0KICAgT24tbGluZSBDUFUocykgbGlzdDog
ICAgMC0yNTUNClZlbmRvciBJRDogICAgICAgICAgICAgICAgR2VudWluZUludGVsDQogICBC
SU9TIFZlbmRvciBJRDogICAgICAgICBJbnRlbChSKSBDb3Jwb3JhdGlvbg0KICAgTW9kZWwg
bmFtZTogICAgICAgICAgICAgSU5URUwoUikgWEVPTihSKSBQTEFUSU5VTSA4NTkyKw0KICAg
ICBCSU9TIE1vZGVsIG5hbWU6ICAgICAgSU5URUwoUikgWEVPTihSKSBQTEFUSU5VTSA4NTky
KyAgQ1BVIEAgMS45R0h6DQogICAgIEJJT1MgQ1BVIGZhbWlseTogICAgICAxNzkNCiAgICAg
Q1BVIGZhbWlseTogICAgICAgICAgIDYNCiAgICAgTW9kZWw6ICAgICAgICAgICAgICAgIDIw
Nw0KICAgICBUaHJlYWQocykgcGVyIGNvcmU6ICAgMg0KICAgICBDb3JlKHMpIHBlciBzb2Nr
ZXQ6ICAgNjQNCiAgICAgU29ja2V0KHMpOiAgICAgICAgICAgIDINCiAgICAgU3RlcHBpbmc6
ICAgICAgICAgICAgIDINCi4uLg0KDQpCSU9TIHZlcnNpb24gYXMgcHJpbnRlZCBkdXJpbmcg
Ym9vdDoNCg0KWyAgICAwLjAwMDAwMF0gRE1JOiBJbnRlbCBDb3Jwb3JhdGlvbiBENTBETlAv
RDUwRE5QLCBCSU9TIA0KU0U1Qzc0MTEuODZCLjk1MzUuRDA0LjIzMTIyNzA1MTggMTIvMjcv
MjAyMw0KDQoNCkp1ZXJnZW4NCg==
--------------7jW40ockSBPNTlniyOaWunWI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------7jW40ockSBPNTlniyOaWunWI--

--------------zvA94lUjzg0YOBR4bqS92vZQ--

--------------gXiJyEuVi0vHir2yLceJq3vs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZHZMMFAwAAAAAACgkQsN6d1ii/Ey92
ogf/RJY/uE/zrRcidrf0kw+CQP8x5RGpS85Y6EH1SsVgRi692gpOPxh/fK3ECIXtM61u+bGa1TdP
Oy/GHuAOvOoKWZNAsew4DmAeHapmUOPU9k7+NyOO0xDBugQWBnZlMAo72Ne3N6MKsLMrNPmyYP+L
0RsGXMIV0HJGjXIOeWcJBDyqFSwrvCqVcOaPLYR2z1+/nrkvqdJctETfExkiA4H/4HkrwOQIQ0Hu
Lvofj3/5vHKt7l/aSfo+p7CG5jre1q9YctjDL7zAdsyme2uXUQbEV92xBNTPgzVUBSHQOf/ZADlM
bRUDjEpzJjXEbtgH3DK4Wfh5oIHWJ7bdnc8DX0zSag==
=ojFO
-----END PGP SIGNATURE-----

--------------gXiJyEuVi0vHir2yLceJq3vs--

