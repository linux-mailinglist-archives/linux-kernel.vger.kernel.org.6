Return-Path: <linux-kernel+bounces-554620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D4A59A90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9C1625BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCDA22D4F4;
	Mon, 10 Mar 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qKYD+8+p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qKYD+8+p"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F0227BB5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622454; cv=none; b=Y2vpeRAl8jM1nG7MC/E0zmu40kutk5M5kfE4YbowvRk0vIDT07hWBnb9/TnIb7Cn8JvDSyhIPoLhA0FrQxVStBgSxjqKGWWEMAdXgYzG0/JGkXjtSyNa1acIZH7bjv1wJ6CFzrS/D2QcIDfNpKsg3khhb4b7CUtxiw09cPaLyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622454; c=relaxed/simple;
	bh=cwSFHK0DzRT9TRaASGNB5eh0Kgi007wJiEb76EWNLWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uArk5OQ483JrpwFmslIrxZOvnapYvsU4gZtP4oikmTiuEs6XB9wE/YohOqP0eP2HcuyrYzkaUzsAQN8Lb+k3tHO83Ygoruu3z+1FhlzF0OR6yRP6kSHxbjDbJtCC4GVn0vpZBWLo2gvrl8ZDGqp0jigAhstrDlJs8C/B5BD9CmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qKYD+8+p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qKYD+8+p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34C982116B;
	Mon, 10 Mar 2025 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741622451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cwSFHK0DzRT9TRaASGNB5eh0Kgi007wJiEb76EWNLWw=;
	b=qKYD+8+p9LBsIwmXNjKPneb6tJDj3Vc82AhRqQo3MLSGhdjryxW/Bcwfn1YWyyixO5QCkN
	I9vxi1oBkcbsdP6jtJUPmqSdhtOWjVWcYU46RZjtoyBw3EdGKGbK/r510EKz7t+Hm0kDiX
	9+OsB9UfJLiMfOFNCcJwlwZ4liOHEis=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qKYD+8+p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741622451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cwSFHK0DzRT9TRaASGNB5eh0Kgi007wJiEb76EWNLWw=;
	b=qKYD+8+p9LBsIwmXNjKPneb6tJDj3Vc82AhRqQo3MLSGhdjryxW/Bcwfn1YWyyixO5QCkN
	I9vxi1oBkcbsdP6jtJUPmqSdhtOWjVWcYU46RZjtoyBw3EdGKGbK/r510EKz7t+Hm0kDiX
	9+OsB9UfJLiMfOFNCcJwlwZ4liOHEis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF731399F;
	Mon, 10 Mar 2025 16:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0pxDLbIMz2eRVgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Mar 2025 16:00:50 +0000
Message-ID: <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>
Date: Mon, 10 Mar 2025 17:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Borislav Petkov <bp@alien8.de>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
References: <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
 <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
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
In-Reply-To: <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RnV6Ff8P8y8XDzvhVEkZkM3U"
X-Rspamd-Queue-Id: 34C982116B
X-Spam-Score: -5.41
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.41 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RnV6Ff8P8y8XDzvhVEkZkM3U
Content-Type: multipart/mixed; boundary="------------0pPHr0EhfEV9Eer3yt5YV7V7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
Message-ID: <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
 <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
In-Reply-To: <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>

--------------0pPHr0EhfEV9Eer3yt5YV7V7
Content-Type: multipart/mixed; boundary="------------BL2FGWzsxIf1zH0OAXcHc56E"

--------------BL2FGWzsxIf1zH0OAXcHc56E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDMuMjUgMTY6NTUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMTAsIDIwMjUgYXQgMDQ6NTI6MzdQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IC9zeXMva3ZtLyBtaWdodCBiZSBhIGdvb2QgZml0IHdoZW4gdXNpbmcgS1ZNPw0KPiAN
Cj4gV2hhdCBhcmUgd2UgZ29pbmcgdG8gZG8gd2hlbiBYZW4gcnVucyBjb2NvIGd1ZXN0cz8g
T3IgdGhlcmUncyBubyBzdWNoIGRhbmdlcg0KPiBpbiB0aGUgbmVhciBmdXR1cmU/DQoNClRo
ZXJlIGlzIHdvcmsgaW4gcHJvZ3Jlc3MgZm9yIFNFViBndWVzdHMgYXQgbGVhc3QuDQoNClNo
b3VsZG4ndCB0aGUgY29jbyByZWxhdGVkIGluZm9ybWF0aW9uIGJlIHRoZSBzYW1lIHJlZ2Fy
ZGxlc3Mgb2YgdGhlDQpoeXBlcnZpc29yIGJlbmVhdGg/IElPVzogZG8geW91IGVudmlzaW9u
IHRoZSBjb2RpbmcgZm9yIHBvcHVsYXRpbmcgdGhlDQpjb2NvIHJlbGF0ZWQgc3lzZnMgZ3Vl
c3Qgbm9kZXMgdG8gYmUgZGlmZmVyZW50IHdoZW4gcnVubmluZyBhcyBhIEtWTQ0Kb3IgYSBI
eXBlci1WIGd1ZXN0Pw0KDQoNCkp1ZXJnZW4NCg==
--------------BL2FGWzsxIf1zH0OAXcHc56E
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------BL2FGWzsxIf1zH0OAXcHc56E--

--------------0pPHr0EhfEV9Eer3yt5YV7V7--

--------------RnV6Ff8P8y8XDzvhVEkZkM3U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfPDLIFAwAAAAAACgkQsN6d1ii/Ey+H
WggAml/c5IBvaCHquuJX1eV1oYeH9lffIeM7w+UeU3lD1t4g5NdksCDQM+PieLX4rjREtclyGwQV
xBaGp/uHPNH2acSOkWmBQKCG3zgNiL0xqO2i/gELMWRwKNzkrShy8GWWjG5VMjXQBE7t3UDwbtek
qxlhUcSYdZutTua0tkmEWarPHqhtjaDGslBJEHldnIT2rdv5lPVWiviiY21JA7THhblQS2e6Y4zk
ffHV/PxJK9iRg3ykDMD78cZrKL0s3Y/yfFREInjMMNooZdUJlNBzihLkYLYgbB3s4OrHH7R4P2dF
92XndtJk12MXr6X+sYj/wfP9p48jhOV+VgUQfmz1Ig==
=+Cex
-----END PGP SIGNATURE-----

--------------RnV6Ff8P8y8XDzvhVEkZkM3U--

