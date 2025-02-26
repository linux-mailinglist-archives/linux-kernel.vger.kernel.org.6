Return-Path: <linux-kernel+bounces-533296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F017FA457F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F5C16FD10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276846426;
	Wed, 26 Feb 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IyIGe6RC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IyIGe6RC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AB258CD5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557999; cv=none; b=iN7/VSwfCEQmY6us23SxGt0SSSq6lqKEAStMkxKUYxfc1LWjnrkX6rQxSI+uk9DpoYMlmRwykmhnF1sl3XycPznsdSLykjvS4TDc+JZ25WLY95Ok4wMP0XuMerlAWc2ejKEQvE6L5jyPjwomrk3GQzxreFAb0XZzzBqg7t3Qm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557999; c=relaxed/simple;
	bh=pdFTx9Utnn8Ns0I/KdElHF6KwP0tz6YUM+4/41wqpXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJo/Yl1Pxcff2ttDrhcRw6Au5HOg0vMWKTav68Rsr4N1A5vE9w1Sfiu5evcquXOuHqWo/Uc7+E9FORrKXfFzXUCFVmpIZkvNSqy5Wai3pk2DGW2XcWFBl3QdfcZ51rjEfYkwXadWmn6UeLtajXW4LZv6DG7aFA9uZ9f1AAteTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IyIGe6RC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IyIGe6RC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6524021193;
	Wed, 26 Feb 2025 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740557995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pdFTx9Utnn8Ns0I/KdElHF6KwP0tz6YUM+4/41wqpXo=;
	b=IyIGe6RCoHAIdRGR+KNGLi3BPRwPZayA4QBARpcJV2vpSZUCyBdyQvydghaBsBc6eLeWJP
	4dcXUcPRIwKH/QF8blHLNlbPb728ok4ILFbtX2Mlb0bJEux5ZId3ASgIXWchwix/nrhy+B
	IxOZN1PlxZc1QRcl5tFvmitfaxez9SI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IyIGe6RC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740557995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pdFTx9Utnn8Ns0I/KdElHF6KwP0tz6YUM+4/41wqpXo=;
	b=IyIGe6RCoHAIdRGR+KNGLi3BPRwPZayA4QBARpcJV2vpSZUCyBdyQvydghaBsBc6eLeWJP
	4dcXUcPRIwKH/QF8blHLNlbPb728ok4ILFbtX2Mlb0bJEux5ZId3ASgIXWchwix/nrhy+B
	IxOZN1PlxZc1QRcl5tFvmitfaxez9SI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 415981377F;
	Wed, 26 Feb 2025 08:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SVVxDqvOvmeAQwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 26 Feb 2025 08:19:55 +0000
Message-ID: <92847496-bd4b-4d40-9ca5-b3c0751aa176@suse.com>
Date: Wed, 26 Feb 2025 09:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2022-49181: xen: fix is_xen_pmu()
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2025022614-CVE-2022-49181-8181@gregkh>
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
In-Reply-To: <2025022614-CVE-2022-49181-8181@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m66hoEUTEqeSW058q2zvTyDx"
X-Rspamd-Queue-Id: 6524021193
X-Spam-Level: 
X-Spamd-Result: default: False [-5.41 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.41
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------m66hoEUTEqeSW058q2zvTyDx
Content-Type: multipart/mixed; boundary="------------Rw0jdop3t4s5XqJjjZhqcVqB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <92847496-bd4b-4d40-9ca5-b3c0751aa176@suse.com>
Subject: Re: CVE-2022-49181: xen: fix is_xen_pmu()
References: <2025022614-CVE-2022-49181-8181@gregkh>
In-Reply-To: <2025022614-CVE-2022-49181-8181@gregkh>

--------------Rw0jdop3t4s5XqJjjZhqcVqB
Content-Type: multipart/mixed; boundary="------------ZfKLo96N5IoCeVphdUbn0DhK"

--------------ZfKLo96N5IoCeVphdUbn0DhK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDIuMjUgMDI6NTYsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gRGVzY3Jp
cHRpb24NCj4gPT09PT09PT09PT0NCj4gDQo+IEluIHRoZSBMaW51eCBrZXJuZWwsIHRoZSBm
b2xsb3dpbmcgdnVsbmVyYWJpbGl0eSBoYXMgYmVlbiByZXNvbHZlZDoNCj4gDQo+IHhlbjog
Zml4IGlzX3hlbl9wbXUoKQ0KPiANCj4gaXNfeGVuX3BtdSgpIGlzIHRha2luZyB0aGUgY3B1
IG51bWJlciBhcyBwYXJhbWV0ZXIsIGJ1dCBpdCBpcyBub3QgdXNpbmcNCj4gaXQuIEluc3Rl
YWQgaXQganVzdCB0ZXN0cyB3aGV0aGVyIHRoZSBYZW4gUE1VIGluaXRpYWxpemF0aW9uIG9u
IHRoZQ0KPiBjdXJyZW50IGNwdSBkaWQgc3VjY2VlZC4gQXMgdGhpcyB0ZXN0IGlzIGRvbmUg
YnkgY2hlY2tpbmcgYSBwZXJjcHUNCj4gcG9pbnRlciwgcHJlZW1wdGlvbiBuZWVkcyB0byBi
ZSBkaXNhYmxlZCBpbiBvcmRlciB0byBhdm9pZCBzd2l0Y2hpbmcNCj4gdGhlIGNwdSB3aGls
ZSBkb2luZyB0aGUgdGVzdC4gV2hpbGUgcmVzdW1pbmcgZnJvbSBzdXNwZW5kKCkgdGhpcyBz
ZWVtcw0KPiBub3QgdG8gYmUgdGhlIGNhc2U6DQo+IA0KPiBbICAgODguMDgyNzUxXSBBQ1BJ
OiBQTTogTG93LWxldmVsIHJlc3VtZSBjb21wbGV0ZQ0KPiBbICAgODguMDg3OTMzXSBBQ1BJ
OiBFQzogRUMgc3RhcnRlZA0KPiBbICAgODguMDkxNDY0XSBBQ1BJOiBQTTogUmVzdG9yaW5n
IHBsYXRmb3JtIE5WUyBtZW1vcnkNCj4gWyAgIDg4LjA5NzE2Nl0geGVuX2FjcGlfcHJvY2Vz
c29yOiBVcGxvYWRpbmcgWGVuIHByb2Nlc3NvciBQTSBpbmZvDQo+IFsgICA4OC4xMDM4NTBd
IEVuYWJsaW5nIG5vbi1ib290IENQVXMgLi4uDQo+IFsgICA4OC4xMDgxMjhdIGluc3RhbGxp
bmcgWGVuIHRpbWVyIGZvciBDUFUgMQ0KPiBbICAgODguMTEyNzYzXSBCVUc6IHVzaW5nIHNt
cF9wcm9jZXNzb3JfaWQoKSBpbiBwcmVlbXB0aWJsZSBbMDAwMDAwMDBdIGNvZGU6IHN5c3Rl
bWQtc2xlZXAvNzEzOA0KPiBbICAgODguMTIyMjU2XSBjYWxsZXIgaXMgaXNfeGVuX3BtdSsw
eDEyLzB4MzANCj4gWyAgIDg4LjEyNjkzN10gQ1BVOiAwIFBJRDogNzEzOCBDb21tOiBzeXN0
ZW1kLXNsZWVwIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA1LjE2LjEzLTIuZmMzMi5x
dWJlcy54ODZfNjQgIzENCj4gWyAgIDg4LjEzNzkzOV0gSGFyZHdhcmUgbmFtZTogU3RhciBM
YWJzIFN0YXJCb29rL1N0YXJCb29rLCBCSU9TIDcuOTcgMDMvMjEvMjAyMg0KPiBbICAgODgu
MTQ1OTMwXSBDYWxsIFRyYWNlOg0KPiBbICAgODguMTQ4NzU3XSAgPFRBU0s+DQo+IFsgICA4
OC4xNTExOTNdICBkdW1wX3N0YWNrX2x2bCsweDQ4LzB4NWUNCj4gWyAgIDg4LjE1NTM4MV0g
IGNoZWNrX3ByZWVtcHRpb25fZGlzYWJsZWQrMHhkZS8weGUwDQo+IFsgICA4OC4xNjA2NDFd
ICBpc194ZW5fcG11KzB4MTIvMHgzMA0KPiBbICAgODguMTY0NDQxXSAgeGVuX3NtcF9pbnRy
X2luaXRfcHYrMHg3NS8weDEwMA0KPiANCj4gRml4IHRoYXQgYnkgcmVwbGFjaW5nIGlzX3hl
bl9wbXUoKSBieSBhIHNpbXBsZSBib29sZWFuIHZhcmlhYmxlIHdoaWNoDQo+IHJlZmxlY3Rz
IHRoZSBYZW4gUE1VIGluaXRpYWxpemF0aW9uIHN0YXRlIG9uIGNwdSAwLg0KPiANCj4gTW9k
aWZ5IHhlbl9wbXVfaW5pdCgpIHRvIHJldHVybiBlYXJseSBpbiBjYXNlIGl0IGlzIGJlaW5n
IGNhbGxlZCBmb3IgYQ0KPiBjcHUgb3RoZXIgdGhhbiBjcHUgMCBhbmQgdGhlIGJvb2xlYW4g
dmFyaWFibGUgbm90IGJlaW5nIHNldC4NCg0KUGxlYXNlIHJldm9rZSB0aGlzIENWRS4gVGhl
IGJ1ZyBjYW4gaGFwcGVuIG9ubHkgaWYgcnVubmluZyBhcyBhIFhlbiBQVg0KZ3Vlc3QgQU5E
IGlmIHRoZSAidnBtdSIgZmVhdHVyZSBoYXMgYmVlbiBlbmFibGVkIGluIHRoZSBYZW4gaHlw
ZXJ2aXNvci4NClJ1bm5pbmcgd2l0aCAidnBtdSIgZW5hYmxlZCBpcyBOT1Qgc2VjdXJpdHkg
c3VwcG9ydGVkIGJ5IFhlbiwgc28gdGhpcw0KcG90ZW50aWFsIGNyYXNoIGlzIGJ5IGRlZmlu
aXRpb24gbm90IGEgc2VjdXJpdHkgaXNzdWUuDQoNCg0KSnVlcmdlbg0K
--------------ZfKLo96N5IoCeVphdUbn0DhK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ZfKLo96N5IoCeVphdUbn0DhK--

--------------Rw0jdop3t4s5XqJjjZhqcVqB--

--------------m66hoEUTEqeSW058q2zvTyDx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAme+zqoFAwAAAAAACgkQsN6d1ii/Ey9+
mgf+IuHOgm5Lktz2W16XsKkIu00rhgJVI7R0k+R4HhMhiQSYqzJp8EBrHF4zzkvsbc4Q3G5ZHVhW
ac6vFAVCUDlXG/xpAWIQeFsrXETVoR4BfcT6dmEBWkO4Zo77cY2kiOJssJgINnbqtoIjG9rVA8+W
QZmvyWl4OGXyrKOk6yjR1ux0bIFUTKdWiOWzTD1lpe2uLBWxhKPHlRz05DkxR1Fr0hO6Gxx3sCpn
5pKd9gv+DNAiv2KC/c+/R4vW61ZoPya/fIGCg4Af9ZZNwf0jiC7UcZY3vVgMRvWJ1c6WjFEPDhh2
iWUiPfYL7qaESd1CpTNWCE4iLCAJd+RTdv/EF2zx0g==
=aFYa
-----END PGP SIGNATURE-----

--------------m66hoEUTEqeSW058q2zvTyDx--

