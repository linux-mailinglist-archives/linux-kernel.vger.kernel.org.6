Return-Path: <linux-kernel+bounces-533205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB2A456DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0633A3B86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53E26B097;
	Wed, 26 Feb 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HuGdARcG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HuGdARcG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC8153BE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555810; cv=none; b=CP+yxcVwy6nYDhVsZR0rmm6bPCV2HvGLNIvTRJdMq79ckHkEe1rLOcUT56CeyGnHlSztPTNIDaEjlvL7yzNdwlOdUqmc+HiboBsGw5MXC6zQm9xkt0I+9KLNQU6oVtCZgGYsIb+LR2OmuJO/jFJp184N7lV8HMJuCYBSouhgm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555810; c=relaxed/simple;
	bh=bdnSC1sSUfIFkHel6sOgOV7h7aZPRtPV1j/RdtbgHrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTuFK4QlNkq4HgxJyLkqARyY0gS7m7f0CusZzp2ZL9AaQ9Ms7mCC483h92mQw/CNJ7oSfeQlHMhcAqIHdt1ET7qEYVs9OPmfScI3qnebiG+8T5NFLXHtIp+N6Uexq/ciThKB76xoXmidujDjbdQz+bfpLL/VLaxJb+0YJOZ14Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HuGdARcG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HuGdARcG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1952D1F387;
	Wed, 26 Feb 2025 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740555807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bdnSC1sSUfIFkHel6sOgOV7h7aZPRtPV1j/RdtbgHrg=;
	b=HuGdARcGOXEmzaD4v/WmEKN25RWzdkQR9loXMPvmTvVdx07DIu85VT45QtyfLn8Hz3TU2h
	+3fZ6Q+aOBmZ4ZIcUSz75X46suejLvAXAPSrBSteOqV6ZHr6lcNPFzuXmvzmjIKp/HKkJs
	VsxL+Y1buctEMNvouyj17UH+g9lFt68=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HuGdARcG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740555807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bdnSC1sSUfIFkHel6sOgOV7h7aZPRtPV1j/RdtbgHrg=;
	b=HuGdARcGOXEmzaD4v/WmEKN25RWzdkQR9loXMPvmTvVdx07DIu85VT45QtyfLn8Hz3TU2h
	+3fZ6Q+aOBmZ4ZIcUSz75X46suejLvAXAPSrBSteOqV6ZHr6lcNPFzuXmvzmjIKp/HKkJs
	VsxL+Y1buctEMNvouyj17UH+g9lFt68=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA83B13A53;
	Wed, 26 Feb 2025 07:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fSENx7GvmekNwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 26 Feb 2025 07:43:26 +0000
Message-ID: <68bb3ad7-521d-4518-8b98-835b57f17455@suse.com>
Date: Wed, 26 Feb 2025 08:43:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2022-49689: xen-blkfront: Handle NULL gendisk
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2025022627-CVE-2022-49689-06fb@gregkh>
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
In-Reply-To: <2025022627-CVE-2022-49689-06fb@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Po3f1dWbN0eoKqi3cExz0F0D"
X-Rspamd-Queue-Id: 1952D1F387
X-Spam-Score: -5.41
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.41 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Po3f1dWbN0eoKqi3cExz0F0D
Content-Type: multipart/mixed; boundary="------------ZiH0xVcFrWmWiVq1pM7McYYN";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <68bb3ad7-521d-4518-8b98-835b57f17455@suse.com>
Subject: Re: CVE-2022-49689: xen-blkfront: Handle NULL gendisk
References: <2025022627-CVE-2022-49689-06fb@gregkh>
In-Reply-To: <2025022627-CVE-2022-49689-06fb@gregkh>

--------------ZiH0xVcFrWmWiVq1pM7McYYN
Content-Type: multipart/mixed; boundary="------------OqXAVik8b1FWhSyKmTIe0xSn"

--------------OqXAVik8b1FWhSyKmTIe0xSn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDIuMjUgMDM6MjQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gRGVzY3Jp
cHRpb24NCj4gPT09PT09PT09PT0NCj4gDQo+IEluIHRoZSBMaW51eCBrZXJuZWwsIHRoZSBm
b2xsb3dpbmcgdnVsbmVyYWJpbGl0eSBoYXMgYmVlbiByZXNvbHZlZDoNCj4gDQo+IHhlbi1i
bGtmcm9udDogSGFuZGxlIE5VTEwgZ2VuZGlzaw0KPiANCj4gV2hlbiBhIFZCRCBpcyBub3Qg
ZnVsbHkgY3JlYXRlZCBhbmQgdGhlbiBjbG9zZWQsIHRoZSBrZXJuZWwgY2FuIGhhdmUgYQ0K
PiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2U6DQo+IA0KPiBUaGUgcmVwcm9kdWNlciBpcyB0
cml2aWFsOg0KPiANCj4gW3VzZXJAZG9tMCB+XSQgc3VkbyB4bCBibG9jay1hdHRhY2ggd29y
ayBiYWNrZW5kPXN5cy11c2IgdmRldj14dmRpIHRhcmdldD0vZGV2L3Nkeg0KPiBbdXNlckBk
b20wIH5dJCB4bCBibG9jay1saXN0IHdvcmsNCj4gVmRldiAgQkUgIGhhbmRsZSBzdGF0ZSBl
dnQtY2ggcmluZy1yZWYgQkUtcGF0aA0KPiA1MTcxMiAwICAgMjQxICAgIDQgICAgIC0xICAg
ICAtMSAgICAgICAvbG9jYWwvZG9tYWluLzAvYmFja2VuZC92YmQvMjQxLzUxNzEyDQo+IDUx
NzI4IDAgICAyNDEgICAgNCAgICAgLTEgICAgIC0xICAgICAgIC9sb2NhbC9kb21haW4vMC9i
YWNrZW5kL3ZiZC8yNDEvNTE3MjgNCj4gNTE3NDQgMCAgIDI0MSAgICA0ICAgICAtMSAgICAg
LTEgICAgICAgL2xvY2FsL2RvbWFpbi8wL2JhY2tlbmQvdmJkLzI0MS81MTc0NA0KPiA1MTc2
MCAwICAgMjQxICAgIDQgICAgIC0xICAgICAtMSAgICAgICAvbG9jYWwvZG9tYWluLzAvYmFj
a2VuZC92YmQvMjQxLzUxNzYwDQo+IDUxODQwIDMgICAyNDEgICAgMyAgICAgLTEgICAgIC0x
ICAgICAgIC9sb2NhbC9kb21haW4vMy9iYWNrZW5kL3ZiZC8yNDEvNTE4NDANCj4gICAgICAg
ICAgICAgICAgICAgXiBub3RlIHN0YXRlLCB0aGUgL2Rldi9zZHogZG9lc24ndCBleGlzdCBp
biB0aGUgYmFja2VuZA0KPiANCj4gW3VzZXJAZG9tMCB+XSQgc3VkbyB4bCBibG9jay1kZXRh
Y2ggd29yayB4dmRpDQoNClBsZWFzZSByZXZva2UgdGhpcyBDVkUuIEFzIHRoZSByZXByb2R1
Y2VyIHJlY2lwZSBpcyBjbGVhcmx5IHNob3dpbmcsIHRoZQ0KYnVnIGNhbiBiZSB0cmlnZ2Vy
ZWQgYnkgaG9zdCBhZG1pbiBhY3Rpb25zIG9ubHkuIFRoZXJlIGlzIG5vIHdheSBhbiB1bnBy
aXZpbGVnZWQNCnVzZXIgb24gdGhlIGhvc3Qgb3IgaW4gdGhlIGd1ZXN0IGNvdWxkIHRyaWdn
ZXIgdGhlIGlzc3VlLg0KDQoNCkp1ZXJnZW4NCg==
--------------OqXAVik8b1FWhSyKmTIe0xSn
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------OqXAVik8b1FWhSyKmTIe0xSn--

--------------ZiH0xVcFrWmWiVq1pM7McYYN--

--------------Po3f1dWbN0eoKqi3cExz0F0D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAme+xh4FAwAAAAAACgkQsN6d1ii/Ey8W
Mwf/Y+WFaMcW1ZqhysujX463UXatslunES0SjGZLKPJk8Xl5koXiU6VPWg+ZANEyclmPNJlFnfXz
2C5C7LVctPlRGScxd272oWjKM26QD+Y3MVWhs7tEdMkR1EmHN8dwM4xHxhYsqC/DXJB08TkRUfz8
IzwTtPnV+TmINRugmkR/3KFFY0B+7Pq0ZtO5HfpVSnTSjulv1RMw0IcMoUguoc1T+t27kfqVjQS8
nv5LshCLLALX+40Lxg4u07PES47a7Rn1g++GB0Df0A1Qcpwt5TcxESa12/e1eSDGLVYZvuqo01lR
L80DY9I/32sa3QEush1rkOwuhAeBciwoY03LLkT7WA==
=TN55
-----END PGP SIGNATURE-----

--------------Po3f1dWbN0eoKqi3cExz0F0D--

