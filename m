Return-Path: <linux-kernel+bounces-555878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304AA5BDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2FD18990B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F222DFA5;
	Tue, 11 Mar 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aU7uUUhz"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6B231A24
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688549; cv=none; b=EcM+VQrspEr49eQttRioA0trWzuNRB0MXq1wtOynUmArB5X+pHN77ctIznpAwDfdkD21lRspgyAcxfDthqtv3hAAcQp5yjt2n+7c46Z6odqoKHD4g0fpHvbkvD2TdPVwMJS4WGZ7VgoL8GHIPjUXJZoH385wKKBBMisToh2qqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688549; c=relaxed/simple;
	bh=77jctooFYB1vPJu2H9UPc3UNpn4ZfW0U4ODsj8AlOf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChIMFKk5iJv7pHQXs3yR2A8RHpkuWQFXdeFuZeWd6nusSkatJ2Lcx/wxfcmwOkznYkS0I5j3rvPtPpze+0wTk8DP5AFybU3hET4wsIdqXRNIhCbUXc64SWYRAUHvYXkr1qkI7faO6cc7m+wFpbdf3KDidci/g+dcNkoSQuVGFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aU7uUUhz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so873744566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741688545; x=1742293345; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=77jctooFYB1vPJu2H9UPc3UNpn4ZfW0U4ODsj8AlOf4=;
        b=aU7uUUhzFrtwWuihQNad2PynkBKO51IMndImrrDdlRFNG/o/wel/W3M8LSlGqz4VEx
         Jb37t4kKcjN8atJSlsaXPEmk7tgQJqzwiho1ZrVsi0uP+jvRXED6iiK7/aFnV98EkoXh
         TXqh4VKEp5GkxY4GTOCna8/HBb2ALf/KS5sRhrSRiKcAik2fu34qXxkaMrelQ/7dNv1j
         rX3DxpG83eLkiLfm/lIohaScBGtsjJSu+J5/JtPEAQL2e3jKZeoU6WzX85o5ori86OX0
         6n5sERcoJMvFpybQu71tXr1jS+10tycLsyLWfDo6xVqaoqZaI1BjTMYmekcXI6HjLm0f
         hvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688545; x=1742293345;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77jctooFYB1vPJu2H9UPc3UNpn4ZfW0U4ODsj8AlOf4=;
        b=fKVuy/ztD0maJZfd2xo/86cHGxzMrRi5S4bw/9ADeQctAahC7v3GWKhw+goAhkIQPC
         75tCzX9ALJ2OpfS9lnyMPiUZOVyKrcBWX7gwy0rPyVIo7lbJMoyG8v8zpnFWLFeeldCa
         RkjIcHBNHRCHqn2imX0+/qnN4RBR7fUBAWmIDf2tGgbty8aVHDMsvI0ODPCzhPS7NWzE
         BEcE6+3T0EGyb1PNe1EoN7duPIXF17DPjmPwoR/wA0FHufS6tDxIBaUCR96rvvPlrMwI
         c9knm0Q86tJ7XffWo5ABAHs+bm4UOljbcCD0WkmNBJJi5xEZwyNJGI6MZk3GRc2FFUL/
         OcWg==
X-Forwarded-Encrypted: i=1; AJvYcCWRLtPwbwBMo4Q3M3VLHUnT3/V5QBXLEzd/PxSW99VOI6IhjFWzrIrsTt5dpjvfDEwQdeJtvyWMh7lUA4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd4IW6B0UwM1058SNnS6D2pWNUOVL6pRHFlD0k1RcvhnQaHMh
	KEVS/hG5DUI+GAOVv2qLCQ1sQ2Uwt/CxUyyU6oRiL2bpDb5zLzM2ZoGmuDppWhw=
X-Gm-Gg: ASbGncuolLp3vQc/W6j549nMwNJce7Go9Im1f0UucDCjI1uKdrMRBc4uW40b8otMice
	8X+uTqBkRH7+VO4qvbvuvzd3mrKSKMibyrTHlMFniPgdTJHPJPrpRxhCDGb2FqHknxEcN/jTZBS
	jirmMdxwprkBqKE5gNXH+gaRdf4a46S0Y1SK9DNzr6kXLjU1YhN21/qeO+DFhVajM80RclEy1bi
	Zvy7JolsGdpgNg1eHZTBWgeKkrx4aVhql46SUgA2oKcXnzEELEk/L58c2aN9box2NB6jP34pQ2z
	1j+67IjLuL39nh62wcvpWLPUEdARnKvqgDD1Vj4xaPvyN+/iKe/dGd32T0EhcSmpu0cY+VY2L77
	FSMt0WqMsov2g6OHUHYTYYGkiqQmBVH7wvLrAfMSov5HmzsSNwhPQT46s4o5h5NHr9wM=
X-Google-Smtp-Source: AGHT+IFkajSBrL3sM36OZZuirxfE+1+/ADoWdfIt3u3xnLyUlK6uj4Im967ehKItMMX3a/Y3g7gWKQ==
X-Received: by 2002:a17:907:9691:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ac252a886dbmr1801442766b.15.1741688544733;
        Tue, 11 Mar 2025 03:22:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac283e4d50csm491873366b.175.2025.03.11.03.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:22:24 -0700 (PDT)
Message-ID: <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
Date: Tue, 11 Mar 2025 11:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com
References: <Z86-3n1-MArVLM9Z@8bytes.org> <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org> <Z9AFyG7798M4VNJQ@suse.de>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <Z9AFyG7798M4VNJQ@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NdIqaGdx2s0YrVnn3UE90mRv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NdIqaGdx2s0YrVnn3UE90mRv
Content-Type: multipart/mixed; boundary="------------k64L6Vm0IlIMZ6ZI0VXIRzRd";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com
Message-ID: <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <Z86-3n1-MArVLM9Z@8bytes.org> <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org> <Z9AFyG7798M4VNJQ@suse.de>
In-Reply-To: <Z9AFyG7798M4VNJQ@suse.de>

--------------k64L6Vm0IlIMZ6ZI0VXIRzRd
Content-Type: multipart/mixed; boundary="------------IST720nDLyAoEAeyht4t8v8O"

--------------IST720nDLyAoEAeyht4t8v8O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDMuMjUgMTA6NDMsIEpvZXJnIFJvZWRlbCB3cm90ZToNCj4gT24gTW9uLCBNYXIg
MTAsIDIwMjUgYXQgMDQ6NDM6NTlQTSArMDEwMCwgQWxleGV5IEdsYWRrb3Ygd3JvdGU6DQo+
PiBJZiBpbiB0aGUgL3N5cy9oeXBlcnZpc29yIHdlIGhhdmUgaW5mb3JtYXRpb24gZm9yIGd1
ZXN0IChmb3IgcnVubmluZyB1bmRlcg0KPj4gYSBoeXBlcnZpc29yKSwgd2hlcmUgZG8geW91
IHByb3Bvc2UgdG8gcHV0IHRoZSBpbmZvcm1hdGlvbiBmb3IgdGhlDQo+PiBob3N0LXNpZGUg
KGZvciBydW5uaW5nIGFzIGEgaHlwZXJ2aXNvcikgPw0KPiANCj4gT2theSwgc28gbGV0J3Mg
bm90IG1peCB0aGluZ3MgdXAgdG9vIG11Y2ggaGVyZS4gVGhlIG9ubHkgKHVwc3RyZWFtKSBj
YXNlDQo+IHdoZXJlIExpbnV4IF9pc18gdGhlIGh5cGVydmlzb3IgaXMgd2hlbiBydW5uaW5n
IEtWTSBndWVzdHMuIFdoYXQNCj4gaW5mb3JtYXRpb24gbmVlZHMgdG8gYmUgcHJvdmlkZWQg
Zm9yIHRoaXMgY2FzZSBpbiBTWVNGUyB0aGF0IGlzIG5vdA0KPiBhbHJlYWR5IHByb3ZpZGVk
IGVsc2V3aGVyZSwgZS5nLiBieSB0aGUgS1ZNIG1vZHVsZXMgb3IsIGluIGNhc2Ugb2YgU0VW
LA0KPiBieSAvZGV2L3Nldj8gV2hhdCBkb2VzIEludGVsIGV4cG9zZSBmb3IgVERYPw0KPiAN
Cj4gQmFjayB0byB0aGUgZ3Vlc3Qtc2lkZSwgSSBhZ3JlZSB3aXRoIGludHJvZHVjaW5nIGEg
bmV3IGRpcmVjdG9yeSBpbg0KPiBTWVNGUyB3aXRoIHN1Yi1kaXJlY3RvcmllcyBmb3IgZWFj
aCBkZXRlY3RlZCBoeXBlcnZpc29yLiBUbyBtYXhpbWlzZQ0KPiBjb25mdXNpb24sIGl0IGNh
biBiZSBjYWxsZWQgJy9zeXMvaHlwZXJ2aXNvcnMvJywgb3IganVzdCAvc3lzL2d1ZXN0LyAo
YXMNCj4gQm9yaXMgc3VnZ2VzdGVkKS4NCg0KSSBjYW4gbGl2ZSB3aXRoIHRoYXQsIGFzIGxv
bmcgYXMgd2UgbWFrZSBpdCBwb3NzaWJsZSB0byBtYWtlIGUuZy4NCi9zeXMvZ3Vlc3QveGVu
IGEgbGluayB0byAvc3lzL2h5cGVydmlzb3IgKGlmIHhlbiBpcyB0aGUgaHlwZXJ2aXNvcg0K
dGhlIGd1ZXN0IGlzIGRpcmVjdGx5IHJ1bm5pbmcgb24pLiBUaGlzIG1lYW5zIHRoYXQgL3N5
cy9ndWVzdC8qL3R5cGUNCnNob3VsZCBub3QgY29uZmxpY3Qgd2l0aCAvc3lzL2h5cGVydmlz
b3IvdHlwZS4NCg0KDQpKdWVyZ2VuDQo=
--------------IST720nDLyAoEAeyht4t8v8O
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------IST720nDLyAoEAeyht4t8v8O--

--------------k64L6Vm0IlIMZ6ZI0VXIRzRd--

--------------NdIqaGdx2s0YrVnn3UE90mRv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfQDt8FAwAAAAAACgkQsN6d1ii/Ey8W
Lgf+JnoaQQT219Vgqsdhj4XuGVVB2bLhxDnxMD8nDnlv/iIQaOBeG4UZNc5Cf9cVi3fTKAntnVC3
LKhi9TvSzDiYJD+B++0RlO6acMInnWensXftYL5CSir6Moym34QQiJq6X4CHZu9pteUXADft9WGo
olQ7PFJoGrbP+OPYF0WWd29PpOqSdjhuezUA6dzQgNHwicGfT4KE9Z+8MoWbfZhVhukr58EkYeR7
WZqeXS3PW+cditQ1laTiP9ImX2Ui7Irv78OZdCXlWdZgAKyqMyGtr4s4Ob2ThZ8VLXPvNcV6flgC
bYTZMjm3ATsV3buqGWjlHDK2EuymUe3JHcXUY94kQw==
=H+xc
-----END PGP SIGNATURE-----

--------------NdIqaGdx2s0YrVnn3UE90mRv--

