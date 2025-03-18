Return-Path: <linux-kernel+bounces-566103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA0A6732E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E3A1898F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E320B1E6;
	Tue, 18 Mar 2025 11:53:22 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF553204080
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298801; cv=none; b=uBssp0+04eQvd8Sa1JZySdENqJRHAsI+ZwJGtMWRTHiJUZ2rUN+jkfOQifKR7bh2FRE8ZoOphZzvnciPFIL0auZ1iYJJM9VMUxlH7UDwPZjIzkjH8ccelkg6hPiUXgvOLS44yv9I/ULf3OdSyWkRgvz2eBv8GEuJykI2L5BDtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298801; c=relaxed/simple;
	bh=7syGiKgIAXXSV84lhZ/Qa67C5kQb5aeWN4eRYL6scBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnuZsglQVtEHgqsDhPid/nGs+uycPrvTXg3Kqp5f8mRwtnlgdMSZc+xNStfy3+YLpS3L7n6H4Wl+hg4bCmnnXY6PchKPtyjv39uAQQEWGWBStnG3rWqc2e+3ZmTRi965sV/vBaJAs6tNaT2ngwNZkaMOb6iyzO41y5q3e1yfwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 161E721EC4;
	Tue, 18 Mar 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B76841379A;
	Tue, 18 Mar 2025 11:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lvVkKq1e2We3UgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 18 Mar 2025 11:53:17 +0000
Message-ID: <24826c2b-f1d2-408a-b8d1-63e1882b0fd0@suse.com>
Date: Tue, 18 Mar 2025 12:53:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: Nikolay Borisov <nik.borisov@suse.com>, dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com
References: <20250318113604.297726-1-nik.borisov@suse.com>
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
In-Reply-To: <20250318113604.297726-1-nik.borisov@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D6Dmtbxz1TIbL0A5nUtc6nuh"
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 161E721EC4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D6Dmtbxz1TIbL0A5nUtc6nuh
Content-Type: multipart/mixed; boundary="------------c0UTNkw5cqDR7fauQ0GHPW6D";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Nikolay Borisov <nik.borisov@suse.com>, dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com
Message-ID: <24826c2b-f1d2-408a-b8d1-63e1882b0fd0@suse.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
References: <20250318113604.297726-1-nik.borisov@suse.com>
In-Reply-To: <20250318113604.297726-1-nik.borisov@suse.com>

--------------c0UTNkw5cqDR7fauQ0GHPW6D
Content-Type: multipart/mixed; boundary="------------7Pi8rgYx88zPTb0JuCXGjFqS"

--------------7Pi8rgYx88zPTb0JuCXGjFqS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDMuMjUgMTI6MzYsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToNCj4gSWYgYSBwaWVj
ZSBvZiBtZW1vcnkgaXMgcmVhZCBmcm9tIC9kZXYvbWVtIHRoYXQgZmFsbHMgb3V0c2lkZSBv
ZiB0aGUNCj4gU3lzdGVtIFJhbSByZWdpb24gaS5lIGJpb3MgZGF0YSByZWdpb24gdGhlIGtl
cm5lbCBjcmVhdGVzIGEgc2hhcmVkDQo+IG1hcHBpbmcgdmlhIHhsYXRlX2Rldl9tZW1fcHRy
KCkgKHRoaXMgYmVoYXZpb3Igd2FzIGludHJvZHVjZWQgYnkNCj4gOWFhNmVhNjk4NTJjICgi
eDg2L3RkeDogTWFrZSBwYWdlcyBzaGFyZWQgaW4gaW9yZW1hcCgpIikuIFRoaXMgcmVzdWx0
cw0KPiBpbiBhIHJlZ2lvbiBoYXZpbmcgYm90aCBhIHNoYXJlZCBhbmQgYSBwcml2YXRlIG1h
cHBpbmcuDQo+IA0KPiBTdWJzZXF1ZW50IGFjY2Vzc2VzIHRvIHRoaXMgcmVnaW9uIHZpYSB0
aGUgcHJpdmF0ZSBtYXBwaW5nIGluZHVjZSBhDQo+IFNFUFQgdmlvbGF0aW9uIGFuZCBhIGNy
YXNoIG9mIHRoZSBWTU0uIEluIHRoaXMgcGFydGljdWxhciBjYXNlIHRoZQ0KPiBzY2VuYXJp
byB3YXMgYSB1c2Vyc3BhY2UgcHJvY2VzcyByZWFkaW5nIHNvbWV0aGluZyBmcm9tIHRoZSBi
aW9zIGRhdGENCj4gYXJlYSBhdCBhZGRyZXNzIDB4NDk3IHdoaWNoIGNyZWF0ZXMgYSBzaGFy
ZWQgbWFwcGluZywgYW5kIGEgZm9sbG93dXANCj4gcmVib290IGFjY2Vzc2luZyBfX3ZhKDB4
NDcyKSB3aGljaCBhY2Nlc3MgcGZuIDAgdmlhIHRoZSBwcml2YXRlIG1hcHBpbmcNCj4gY2F1
c2luZyBtYXloZW0uDQo+IA0KPiBGaXggdGhpcyBieSBzaW1wbHkgZm9yYmlkZGluZyBhY2Nl
c3MgdG8gL2Rldi9tZW0gd2hlbiBydW5uaW5nIGFzIGFuIFREWA0KPiBndWVzdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE5pa29sYXkgQm9yaXNvdiA8bmlrLmJvcmlzb3ZAc3VzZS5jb20+
DQo+IC0tLQ0KPiANCj4gU2VuZGluZyB0aGlzIG5vdyB0byBob3BlZnVsbHkgc3B1ciB1cCBk
aXNjdXNzaW9uIGFzIHRvIGhvdyB0byBoYW5kbGUgdGhlIGRlc2NyaWJlZA0KPiBzY2VuYXJp
by4gVGhpcyB3YXMgaGl0IG9uIHRoZSBHQ1AgY2xvdWQgYW5kIHdhcyBjYXVzaW5nIHRoZWly
IGh5cGVydmlzb3IgdG8gY3Jhc2guDQo+IA0KPiBJIGd1ZXNzIHRoZSBtb3N0IHByZXNzaW5n
IHF1ZXN0aW9uIGlzIHdoYXQgd2lsbCBiZSB0aGUgbW9zdCBzZW5zaWJsZSBhcHByb2FjaCB0
bw0KPiBlbGltaW5hdGUgc3VjaCBzaXR1YXRpb25zIGhhcHBlbmluZyBpbiB0aGUgZnV0dXJl
Og0KPiANCj4gMS4gU2hvdWxkIHdlIGZvcmJpZCBnZXR0aW5nIGEgZGVzY3JpcHRvciB0byAv
ZGV2L21lbSAodGhpcyBwYXRjaCkNCj4gMi4gU2tpcCBjcmVhdGluZyAvZGV2L21lbSBhbHRv
Z2V0aGVyMw0KPiAzLiBQb3NzaWJseSB0aW5rZXIgd2l0aCBpbnRlcm5hbHMgb2YgaW9yZW1h
cCB0byBlbnN1cmUgdGhhdCBubyBtZW1vcnkgd2hpY2ggaXMNCj4gYmFja2VkIGJ5IGt2bSBt
ZW1zbG90cyBpcyByZW1hcHBlZCBhcyBzaGFyZWQuDQo+IDQuIEVsaW1pbmF0ZSB0aGUgYWNj
ZXNzIHRvIDB4NDcyIGZyb20gdGhlIHg4NiByZWJvb3QgcGF0aCwgYWZ0ZXIgYWxsIHdlIGRv
bid0DQo+IHJlYWxseSBoYXZlIGEgcHJvcGVyIGJpb3MgYXQgdGhhdCBhZGRyZXNzLg0KPiA1
LiBTb21ldGhpbmcgZWxzZSA/DQoNCkkgdGhpbmsgYSBjcmFzaCBvZiB0aGUgVk1NIG11c3Qg
YmUgYXZvaWRlZCwgb3RoZXJ3aXNlIHdlIGhhdmUgYSBzZWN1cml0eQ0KaXNzdWUgZHVlIHRv
IG9uZSBURFggZ3Vlc3QgYmVpbmcgYWJsZSB0byBEb1MgdGhlIGNvbXBsZXRlIGhvc3QuDQoN
CkknZCByYXRoZXIgY3Jhc2ggdGhlIGd1ZXN0IGZvciB3aGljaCB0aGUgU0VQVCB2aW9sYXRp
b24gd2FzIGRldGVjdGVkIChpcw0KdGhpcyBwb3NzaWJsZT8gSWYgbm90LCBkb24ndCBhbGxv
dyBpdCB0byBydW4gYW55IGxvbmdlciBtYXliZT8pDQoNCg0KSnVlcmdlbg0K
--------------7Pi8rgYx88zPTb0JuCXGjFqS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------7Pi8rgYx88zPTb0JuCXGjFqS--

--------------c0UTNkw5cqDR7fauQ0GHPW6D--

--------------D6Dmtbxz1TIbL0A5nUtc6nuh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfZXq0FAwAAAAAACgkQsN6d1ii/Ey+/
ugf+IPPX96Pol0cMUC6+qOQwqaeiyYWfRzdQtDXr7JEHKV/D9KWHp9h7FFDw39OKkNY+aOalgb+/
c8vzy5e6QZ698wBkJguKZ3QmpUPDUyK3EZsU2H9D/pJxopHVVg0mflG/chV4gTlU6SbQV64CTg3z
0yC+k3vSm2pRgqSuQsyGIZLbmNJg4dva1IheMViPNvjAcYBSFQVwHOVk8zl0TSKrQW40ED3wXoQC
g39gSsZxmR8l9SLoc+IHJt3UXv7UkVs1fTgmlPZaagPQV1cmCJLiJWYo1tHeH3FRiYFS3SwCgbix
YRMbwHCp/HHdLBhP0iWfm1Csm25bGHBrFUC2ltQebA==
=/k0A
-----END PGP SIGNATURE-----

--------------D6Dmtbxz1TIbL0A5nUtc6nuh--

