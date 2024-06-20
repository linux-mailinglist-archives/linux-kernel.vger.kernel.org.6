Return-Path: <linux-kernel+bounces-222196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C512B90FE18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C8D1F23433
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FCE50288;
	Thu, 20 Jun 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K5PFuCu6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K5PFuCu6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D991803A;
	Thu, 20 Jun 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870244; cv=none; b=MGcPfeBBKuOuXvvriTG5ahWMSzzFjZQFUZUrbPVQqiosf7I9LGxH1snbyPAnR35Rts1bNfnRnhNZ/Ejt7j/BRK+Gc1JHu0NFaExl0QQk2Z+99+WRDxlZWR928HLb9rz1rvEhF7u/M8ofN/GTgGaqtfc0/lVt2GQhilcy7+lqusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870244; c=relaxed/simple;
	bh=QdCHL9KWsbPEb90G8JVZ2enGn0Xpgr5RnjJ7QhhvM5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6zJ0qEqdbVaU14m2O5JVgNIiGcYmqbjIFTWgAtPsm+4GDXrZ0Kw24wTeveeoMCcnd4WB3Y320KHNEk4SySwn+2tVxhOo8zBx/u27YpCG6djFSb8XIqTaJOdHxsVN6emmEXoqlY/cYpfed9q/BRen2ruv3YtJK0haJ4X/Xnf1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K5PFuCu6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K5PFuCu6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3699321A80;
	Thu, 20 Jun 2024 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718870241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QdCHL9KWsbPEb90G8JVZ2enGn0Xpgr5RnjJ7QhhvM5c=;
	b=K5PFuCu6Qj3yhuB1PL1Y6oRqB5Vuty84D1QPz/3kdgzKrXzL7Si0QE/Vu0c82L3RgRq+HO
	7rC8fe4/z6fOaDb0z2fxxxgvYK1isztDCgt/UJoyDKBuzQiZCbiRXFo2lX8wWUbkd8YHcz
	hFR1GoYlH2tMwuPZakta2vjGyZJG97E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718870241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QdCHL9KWsbPEb90G8JVZ2enGn0Xpgr5RnjJ7QhhvM5c=;
	b=K5PFuCu6Qj3yhuB1PL1Y6oRqB5Vuty84D1QPz/3kdgzKrXzL7Si0QE/Vu0c82L3RgRq+HO
	7rC8fe4/z6fOaDb0z2fxxxgvYK1isztDCgt/UJoyDKBuzQiZCbiRXFo2lX8wWUbkd8YHcz
	hFR1GoYlH2tMwuPZakta2vjGyZJG97E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B40313ACA;
	Thu, 20 Jun 2024 07:57:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kuVeAeHgc2YyVwAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 20 Jun 2024 07:57:21 +0000
Message-ID: <e0a4a1e7-a626-4bfd-973f-d27474bea142@suse.com>
Date: Thu, 20 Jun 2024 09:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-47581: xen/netback: don't queue unlimited number of
 packages
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024061916-CVE-2021-47581-1d34@gregkh>
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
In-Reply-To: <2024061916-CVE-2021-47581-1d34@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GCfutFWvGtfP7vGPSN6P90rW"
X-Spam-Score: -0.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.79 / 50.00];
	NEURAL_SPAM_LONG(3.38)[0.967];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.18)[-0.912];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GCfutFWvGtfP7vGPSN6P90rW
Content-Type: multipart/mixed; boundary="------------QOdIYtmdYmukA2Dc1StOKRIl";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <e0a4a1e7-a626-4bfd-973f-d27474bea142@suse.com>
Subject: Re: CVE-2021-47581: xen/netback: don't queue unlimited number of
 packages
References: <2024061916-CVE-2021-47581-1d34@gregkh>
In-Reply-To: <2024061916-CVE-2021-47581-1d34@gregkh>

--------------QOdIYtmdYmukA2Dc1StOKRIl
Content-Type: multipart/mixed; boundary="------------EIlwuFlDLvsTcRKcWsE5tPDA"

--------------EIlwuFlDLvsTcRKcWsE5tPDA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDYuMjQgMTY6NTQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gRGVzY3Jp
cHRpb24NCj4gPT09PT09PT09PT0NCj4gDQo+IEluIHRoZSBMaW51eCBrZXJuZWwsIHRoZSBm
b2xsb3dpbmcgdnVsbmVyYWJpbGl0eSBoYXMgYmVlbiByZXNvbHZlZDoNCj4gDQo+IHhlbi9u
ZXRiYWNrOiBkb24ndCBxdWV1ZSB1bmxpbWl0ZWQgbnVtYmVyIG9mIHBhY2thZ2VzDQo+IA0K
PiBJbiBjYXNlIGEgZ3Vlc3QgaXNuJ3QgY29uc3VtaW5nIGluY29taW5nIG5ldHdvcmsgdHJh
ZmZpYyBhcyBmYXN0IGFzIGl0DQo+IGlzIGNvbWluZyBpbiwgeGVuLW5ldGJhY2sgaXMgYnVm
ZmVyaW5nIG5ldHdvcmsgcGFja2FnZXMgaW4gdW5saW1pdGVkDQo+IG51bWJlcnMgdG9kYXku
IFRoaXMgY2FuIHJlc3VsdCBpbiBob3N0IE9PTSBzaXR1YXRpb25zLg0KPiANCj4gQ29tbWl0
IGY0OGRhOGIxNGQwNGNhOCAoInhlbi1uZXRiYWNrOiBmaXggdW5saW1pdGVkIGd1ZXN0IFJ4
IGludGVybmFsDQo+IHF1ZXVlIGFuZCBjYXJyaWVyIGZsYXBwaW5nIikgbWVhbnQgdG8gaW50
cm9kdWNlIGEgbWVjaGFuaXNtIHRvIGxpbWl0DQo+IHRoZSBhbW91bnQgb2YgYnVmZmVyZWQg
ZGF0YSBieSBzdG9wcGluZyB0aGUgVHggcXVldWUgd2hlbiByZWFjaGluZyB0aGUNCj4gZGF0
YSBsaW1pdCwgYnV0IHRoaXMgZG9lc24ndCB3b3JrIGZvciBjYXNlcyBsaWtlIFVEUC4NCj4g
DQo+IFdoZW4gaGl0dGluZyB0aGUgbGltaXQgZG9uJ3QgcXVldWUgZnVydGhlciBTS0JzLCBi
dXQgZHJvcCB0aGVtIGluc3RlYWQuDQo+IEluIG9yZGVyIHRvIGJlIGFibGUgdG8gdGVsbCBS
eCBwYWNrYWdlcyBoYXZlIGJlZW4gZHJvcHBlZCBpbmNyZW1lbnQgdGhlDQo+IHJ4X2Ryb3Bw
ZWQgc3RhdGlzdGljcyBjb3VudGVyIGluIHRoaXMgY2FzZS4NCj4gDQo+IEl0IHNob3VsZCBi
ZSBub3RlZCB0aGF0IHRoZSBvbGQgc29sdXRpb24gdG8gY29udGludWUgcXVldWVpbmcgU0tC
cyBoYWQNCj4gdGhlIGFkZGl0aW9uYWwgcHJvYmxlbSBvZiBhbiBvdmVyZmxvdyBvZiB0aGUg
MzItYml0IHJ4X3F1ZXVlX2xlbiB2YWx1ZQ0KPiB3b3VsZCByZXN1bHQgaW4gaW50ZXJtaXR0
ZW50IFR4IHF1ZXVlIGVuYWJsaW5nLg0KPiANCj4gVGhpcyBpcyBwYXJ0IG9mIFhTQS0zOTIN
Cj4gDQo+IFRoZSBMaW51eCBrZXJuZWwgQ1ZFIHRlYW0gaGFzIGFzc2lnbmVkIENWRS0yMDIx
LTQ3NTgxIHRvIHRoaXMgaXNzdWUuDQoNCldoZW4gaXNzdWluZyBYU0EtMzkyIHRoZSBYZW4g
c2VjdXJpdHkgdGVhbSBhbHJlYWR5IGFzc2lnbmVkIENWRS0yMDIxLTI4NzE1DQp0byB0aGlz
IGlzc3VlLg0KDQoNCkp1ZXJnZW4NCg==
--------------EIlwuFlDLvsTcRKcWsE5tPDA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------EIlwuFlDLvsTcRKcWsE5tPDA--

--------------QOdIYtmdYmukA2Dc1StOKRIl--

--------------GCfutFWvGtfP7vGPSN6P90rW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZz4OAFAwAAAAAACgkQsN6d1ii/Ey9F
7wf9HWqFg5+3n8cuIPoQDKeqog1zLckQGcc/rYlMxJaHbPqMZ4sdc3JtocxOu22Nwad356hJtyD1
jI2qYMMJjMa5Aw7/uPQmNCqeU5TbyQVTqKZ6pg6rg/alXRxEJrG6mCmCS64bSF0zqAhY7D4Ok6+j
ky20zbFDCGMR1Xf3PaklQ/kSzgE6BNlPIwmNBzllqUPsF/uJHRrMOU2zIvyrhN2G4lrJczIACzp1
5E+F2YVPOaEi4qGL80xWZGLVczMeJxwdwLiZnhafiw9zS/FDaHKIRx13rSqG/fxg8UNStd9uQk/z
ON2asjZaWmL8QcOfuUcCAJ4BlAwSgQztKhYNSV3odw==
=fexf
-----END PGP SIGNATURE-----

--------------GCfutFWvGtfP7vGPSN6P90rW--

