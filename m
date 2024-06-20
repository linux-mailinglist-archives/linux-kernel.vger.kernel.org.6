Return-Path: <linux-kernel+bounces-222194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0090FE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B01C20D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0334D8A9;
	Thu, 20 Jun 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fh9CNAXv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FSTOZOiD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E891803A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870110; cv=none; b=pdE+ZWDEaRO8dYEC+prxmONFB+dyqYIPAuITJM6TRDTEtw28rXxrrYYCUBBzuFFdw8sQpWq6jKPsR3qCyezmTEVT1DoIiKVN9PCgas9/g7P45nZ/44/zFUCgt/n/JSxUX1xWGkemsVT77tXfK5tYo1J6LSVTN6/tKpOYYMqVH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870110; c=relaxed/simple;
	bh=1TSP5q7ngbzE358uRk00SmTHWf4jFBl86EZWwZexN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RitjR1JWBRVmLTR1OMEgXcs9IDbMmrgeo5zROREl1xQm3FB2l7KTmhgm7+Mc8/w+pGM36mGybAJX+aOxM6aKEbDFr8jDJaIanQp3wuAvYaSKrD1i2mt/Q6FPmG4gCgkEKn9ibegluWvcXZq7LMfkA0NY3/rm/p8YIEMGE9XmU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fh9CNAXv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FSTOZOiD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D88D321A2D;
	Thu, 20 Jun 2024 07:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718870107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1TSP5q7ngbzE358uRk00SmTHWf4jFBl86EZWwZexN40=;
	b=Fh9CNAXvomrMs3hrAWjL5L+uXstdMQmXoVaGkOU0iRErwJDVoLt8GDeGvKFdekNtEFdPwR
	ffF/U4axZadoZZRUQ52h+2f+/bjR0Gy3gjmx0UQxSkgF8HK8SaLSNViypSv4OjyGFTjz+g
	IjTpVoDoTQhb1tm4779NWLpb4RmpQig=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FSTOZOiD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718870106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1TSP5q7ngbzE358uRk00SmTHWf4jFBl86EZWwZexN40=;
	b=FSTOZOiDW+ogUN/48u0PiOh3P48Rkhg6LbMNzUT+0va5fm18vBNhXAg4oRbbAO+IfBawGk
	z0wN37eSkwaxuUQOdpJQvnu6qQNnXVqmo1U06MaW3e5SKfaeF1jR/MGa+v5IAog3RR5Bv0
	cFaFbZZ9v3DxHD2+9vVVo4ZhhNqsC44=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E4613AC1;
	Thu, 20 Jun 2024 07:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C1kFJ1rgc2ZTVgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 20 Jun 2024 07:55:06 +0000
Message-ID: <e7b8ecd4-400e-4af9-bb73-339aa57c3b59@suse.com>
Date: Thu, 20 Jun 2024 09:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-47575: xen/console: harden hvc_xen against event channel
 storms
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "security@xenproject.org" <security@xenproject.org>
References: <2024061914-CVE-2021-47575-a011@gregkh>
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
In-Reply-To: <2024061914-CVE-2021-47575-a011@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6wB5F71K5N0v0FYtSDTKrYiL"
X-Rspamd-Queue-Id: D88D321A2D
X-Spam-Score: -7.38
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-7.38 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-0.98)[-0.984];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6wB5F71K5N0v0FYtSDTKrYiL
Content-Type: multipart/mixed; boundary="------------fCklgzjebK6O0Qf6y2En9DsP";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "security@xenproject.org" <security@xenproject.org>
Message-ID: <e7b8ecd4-400e-4af9-bb73-339aa57c3b59@suse.com>
Subject: Re: CVE-2021-47575: xen/console: harden hvc_xen against event channel
 storms
References: <2024061914-CVE-2021-47575-a011@gregkh>
In-Reply-To: <2024061914-CVE-2021-47575-a011@gregkh>

--------------fCklgzjebK6O0Qf6y2En9DsP
Content-Type: multipart/mixed; boundary="------------dkArWSrYhxW88ct20fn5EoNL"

--------------dkArWSrYhxW88ct20fn5EoNL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDYuMjQgMTY6NTQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gRGVzY3Jp
cHRpb24NCj4gPT09PT09PT09PT0NCj4gDQo+IEluIHRoZSBMaW51eCBrZXJuZWwsIHRoZSBm
b2xsb3dpbmcgdnVsbmVyYWJpbGl0eSBoYXMgYmVlbiByZXNvbHZlZDoNCj4gDQo+IHhlbi9j
b25zb2xlOiBoYXJkZW4gaHZjX3hlbiBhZ2FpbnN0IGV2ZW50IGNoYW5uZWwgc3Rvcm1zDQo+
IA0KPiBUaGUgWGVuIGNvbnNvbGUgZHJpdmVyIGlzIHN0aWxsIHZ1bG5lcmFibGUgZm9yIGFu
IGF0dGFjayB2aWEgZXhjZXNzaXZlDQo+IG51bWJlciBvZiBldmVudHMgc2VudCBieSB0aGUg
YmFja2VuZC4gRml4IHRoYXQgYnkgdXNpbmcgYSBsYXRlZW9pIGV2ZW50DQo+IGNoYW5uZWwu
DQo+IA0KPiBGb3IgdGhlIG5vcm1hbCBkb21VIGluaXRpYWwgY29uc29sZSB0aGlzIHJlcXVp
cmVzIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCj4gYmluZF9ldnRjaG5fdG9faXJxX2xhdGVlb2ko
KSBhcyB0aGVyZSBpcyBubyB4ZW5idXMgZGV2aWNlIGF2YWlsYWJsZQ0KPiBhdCB0aGUgdGlt
ZSB0aGUgZXZlbnQgY2hhbm5lbCBpcyBib3VuZCB0byB0aGUgaXJxLg0KPiANCj4gQXMgdGhl
IGRlY2lzaW9uIHdoZXRoZXIgYW4gaW50ZXJydXB0IHdhcyBzcHVyaW91cyBvciBub3QgcmVx
dWlyZXMgdG8NCj4gdGVzdCBmb3IgYnl0ZXMgaGF2aW5nIGJlZW4gcmVhZCBmcm9tIHRoZSBi
YWNrZW5kLCBtb3ZlIHNlbmRpbmcgdGhlDQo+IGV2ZW50IGludG8gdGhlIGlmIHN0YXRlbWVu
dCwgYXMgc2VuZGluZyBhbiBldmVudCB3aXRob3V0IGhhdmluZyBmb3VuZA0KPiBhbnkgYnl0
ZXMgdG8gYmUgcmVhZCBpcyBtYWtpbmcgbm8gc2Vuc2UgYXQgYWxsLg0KPiANCj4gVGhpcyBp
cyBwYXJ0IG9mIFhTQS0zOTENCg0KV2hlbiBpc3N1aW5nIFhTQS0zOTEgdGhlIFhlbiBzZWN1
cml0eSB0ZWFtIGFscmVhZHkgYXNzaWduZWQgQ1ZFLTIwMjEtMjg3MTMNCnRvIHRoaXMgaXNz
dWUuDQoNCg0KSnVlcmdlbg0K
--------------dkArWSrYhxW88ct20fn5EoNL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dkArWSrYhxW88ct20fn5EoNL--

--------------fCklgzjebK6O0Qf6y2En9DsP--

--------------6wB5F71K5N0v0FYtSDTKrYiL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZz4FoFAwAAAAAACgkQsN6d1ii/Ey95
8Qf+LJObnJgMzgUgi8PVTDozP7hEeO+dMCBmIOOgdPe7dj996JV6krUdoZdCyhSBz/l8EwdFFyYn
zU78LJp4YeC1BczS+olIKQBt7TQwHYTqCoKc7of8nhKKObA+w0RWvV/SjFtI56EjqLxAwdpdyUT4
2YtPrUpM2gT85WsUbVY6JfwT3rzk/CxXtTjVKhmGix339NqeQfQaMyqY16zdrbBnOEuxHe9Fp9ej
EoigDcaNsm3k4WNL67wdxwn44JNGSVqJmLRdYdSEceFU6iZz55E274jEz2R0mcLSd7qqhsk0qkyQ
zVCQUgj0Y/C10IgkeqjATLCa78wsVabuqYCkJxcvMw==
=hFit
-----END PGP SIGNATURE-----

--------------6wB5F71K5N0v0FYtSDTKrYiL--

