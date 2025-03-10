Return-Path: <linux-kernel+bounces-554645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E862FA59ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FADB3A8192
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEA22FDE6;
	Mon, 10 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W8DzYBvP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FD22D4DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623839; cv=none; b=hmV9dpokz7IEIjf2MJw/sq+Bg+1KBbNiOPztwYtFwVnv+AGB3aKcMPaQx/q+b8Djqtqj8LAid1iUUfcJ9zj/y41m4DDPcyYLsY2/SOORK26SpyeBahMK14nZw+WJ56BWsTTYEsHcVT2bEk+YTNKYBTBnaJpt5eMB8+0DgHV60yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623839; c=relaxed/simple;
	bh=08OCvmCsZb6nCHnYXm1uLt8wiPzdpy+Gh82Mv5a8wHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btePhpcoqgiYz/B8JYlXupXRzRv2x7fP4J+LgZhUA1fp5sC+6+lPn8BvesRQwj6DEwamojteRGh3MZ7WirP9YsOUwr0s05S3/Lp+LtTViEmqyGZDMaCw+lK1JpUW/y3X4Pe7xcCI523yOAL4Pz7ITTIRUv6Afdduv3kjyFfcEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W8DzYBvP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so98206166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741623835; x=1742228635; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=08OCvmCsZb6nCHnYXm1uLt8wiPzdpy+Gh82Mv5a8wHs=;
        b=W8DzYBvP8SZmQSlrxnjGRhUH6I9tsCZZ88TjV1wpmybkhrHCUWh+UrAXmVYknEkmiW
         Ak8yfv/jP1PcUFbUmIeVG0CzqIy4QV2ZcdHA543K4lnYqlOKbE0RlT1uzX0U8Qo2DxC3
         9Ewpd9R+kHlmLKhmLF6eqUh3r1RZxqHzLSAXLMV3EEdVz1Q5e9faAjD3KkwfyvPrJ3zT
         uK1maCVUXtzKwgblKutXbS4fFF5LmSqCNAmcjvITwuWCgoP5blosVeLPVECiAl2RsIvr
         jOu7YIeGaoLwXb/9oLkQLKtwSPI7jW0gnU6Tn6MrbZYHx3u3cYcRG56Yq/bXEPkPKdJm
         XodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623835; x=1742228635;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08OCvmCsZb6nCHnYXm1uLt8wiPzdpy+Gh82Mv5a8wHs=;
        b=MAnx81fM78LoMyBGTGivOW3vwHVadGYS9jiQaYv2bU5ES/ce2dhBTOgauSFMbUlOes
         TfUe7vviEU7efCbxIwjL63OcqkK4eKmPvQa6VGxH8t84qOcvybNudF5Iu2Wos1FNN026
         ijluRlCkNBjgN89qQd+/D3bxpaEII/u2mVq46gcXP+I0rTjkDwcSWr+XPmWKJ4Vg2px3
         TVxoOCgXHpRL2cFC2+6S9XsQK9+OnZ4lhqvSZbS/xK9Lr1JZ42opQY1Pd6YTxrYHtFKK
         /vmJ2Myn49q2BVxVivWXt6OPIQ3GnMF2JIPtXWs2p1UFZHyT1k/HNzHB4c9O2fn3niWo
         BEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj++MKISTwwWtMyUa0ycya9Hu4oHeQPLW35sCmSXYPTyWF/7wCUq4zJaD5AJ6rqfSTqVpBH+Z/9yK+ECw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWbiJYVuNn/hIX/1QXUqUes/hSeFXtjvD6/GZzvK+8+dq/IFC
	mGz7pDqWtNGZxMOs0kiavL2sOLqlWsb5yuXoGDwyBvbi6fLTxSa767S/AMbJ+z4=
X-Gm-Gg: ASbGncsAThGyS+DLmVc8/9VgTe1sHnQLA+E5gXcV30omD1OYObNw4ZlYOBGyTZsj8kS
	39+Nf7NWv+EjXYfGR8idgcM27ryORZjaTzyKpytOUAl/aI4wuM0FLcrv2oJfPaSb008oMGltrGz
	dKeNgyQn8X8oDJ1Bo4cVAAVw0JRjjHwGyK+/Oay1WGR175g3bqy3CLLubLudl3xU7+vX2pL1G6y
	q+jZ+XWj2lwryKwx16g7AQP21dMhngXokJl0n8hdHkvtdPUKTy+KjOc7w+EO5pvwoo7UbsYcbPi
	euIOxQhjoPPL+WFnyUFzivhp3/jfP+Lr7uMDBQ2utLEEH1CFCJWM0xC1yoNqArpuKao/n2hPKE/
	Xlu7w2uoi8k+/erzLgQehn+hQOr4ScuaN2zrzVmtSx8ng9+K8IKR5PCMsAWR+KgE6zHI=
X-Google-Smtp-Source: AGHT+IE8gU//V7LxjYxJuX7HHSyaDSGLCgGK05xVlF4GtN+YdfECk00dx5lsaznCJVDY9fNUmkUS9g==
X-Received: by 2002:a17:907:9816:b0:abf:44bd:8326 with SMTP id a640c23a62f3a-ac2b9dea082mr23696466b.17.1741623835355;
        Mon, 10 Mar 2025 09:23:55 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239439a1esm774307966b.7.2025.03.10.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 09:23:55 -0700 (PDT)
Message-ID: <0087e5f2-0fb5-4dd0-a3f2-c6e1dc192877@suse.com>
Date: Mon, 10 Mar 2025 17:23:53 +0100
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
References: <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
 <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
 <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>
 <20250310160600.GUZ88N6Pod4P8eX1xE@fat_crate.local>
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
In-Reply-To: <20250310160600.GUZ88N6Pod4P8eX1xE@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jWZR8I9zS3FHQsOIdahf1hOJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jWZR8I9zS3FHQsOIdahf1hOJ
Content-Type: multipart/mixed; boundary="------------vf4FzMM9q0dUHbry13h1hLpr";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
Message-ID: <0087e5f2-0fb5-4dd0-a3f2-c6e1dc192877@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
 <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
 <b79ee8b1-768b-4c25-a665-453c23cf9b6f@suse.com>
 <20250310160600.GUZ88N6Pod4P8eX1xE@fat_crate.local>
In-Reply-To: <20250310160600.GUZ88N6Pod4P8eX1xE@fat_crate.local>

--------------vf4FzMM9q0dUHbry13h1hLpr
Content-Type: multipart/mixed; boundary="------------RMi0wCbiGpLGo140UpxC0n9a"

--------------RMi0wCbiGpLGo140UpxC0n9a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDMuMjUgMTc6MDYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMTAsIDIwMjUgYXQgMDU6MDA6NTBQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRoZXJlIGlzIHdvcmsgaW4gcHJvZ3Jlc3MgZm9yIFNFViBndWVzdHMgYXQgbGVhc3Qu
DQo+IA0KPiBOaWNlLg0KPiAgIA0KPj4gU2hvdWxkbid0IHRoZSBjb2NvIHJlbGF0ZWQgaW5m
b3JtYXRpb24gYmUgdGhlIHNhbWUgcmVnYXJkbGVzcyBvZiB0aGUNCj4+IGh5cGVydmlzb3Ig
YmVuZWF0aD8NCj4gDQo+IFJpZ2h0LCBidXQuLi4NCj4gDQo+PiBJT1c6IGRvIHlvdSBlbnZp
c2lvbiB0aGUgY29kaW5nIGZvciBwb3B1bGF0aW5nIHRoZSBjb2NvIHJlbGF0ZWQgc3lzZnMg
Z3Vlc3QNCj4+IG5vZGVzIHRvIGJlIGRpZmZlcmVudCB3aGVuIHJ1bm5pbmcgYXMgYSBLVk0g
b3IgYSBIeXBlci1WIGd1ZXN0Pw0KPiANCj4gLi4uIGlmIHlvdSBoYXZlIHNvbWUgY29jbyB0
b29scyB3aGljaCBuZWVkIHRvIHJlYWQgb3V0IEhWIGluZm8gLSBmb3Igd2hhdGV2ZXINCj4g
cmVhc29uIC0gdGhlbiB0aGV5J2xsIGhhdmUgdG8gZG86DQo+IA0KPiAJaWYgKEhWID09IEtW
TSkNCj4gCQlyZWFkIC9zeXMva3ZtDQo+IAllbHNlIGlmIChIViA9PSBYZW4pDQo+IAkJcmVh
ZCAvc3lzL3hlbg0KPiAJZWxzZQ0KPiAJCS4uLg0KPiANCj4gd2hpY2ggd2UgbWlnaHQgc2F2
ZSB0aGVtIHVwZnJvbnQuLi4NCg0KSW4gY2FzZSB0aGVyZSBpcyB0aGUgbmVlZCBmb3Igc3Vj
aCBpbmZvcm1hdGlvbiBpbiBhIGd1ZXN0IChhbmQgaXQgY2FuIG9ubHkNCmJlIGluIGEgZ3Vl
c3QsIGFzIGV2ZXJ5IExpbnV4IHVuZGVyIFhlbiBpcyBhIGd1ZXN0LCBzYW1lIGFwcGxpZXMg
dG8gSHlwZXItVg0KYW5kIFZNV2FyZSksIHRoZSBpbmZvcm1hdGlvbiBzaG91bGQgYmUgdW5k
ZXIgL3N5cy9oeXBlcnZpc29yLg0KDQpJZiBMaW51eCBzdXBwb3J0cyBydW5uaW5nIGFzIGEg
aHlwZXJ2aXNvciB1c2luZyBzb21ldGhpbmcgZGlmZmVyZW50IHRoYW4gS1ZNDQp0aGVuIHdl
IHNob3VsZCBhZGQgc29tZXRoaW5nIGxpa2UgL3N5cy92aXJ0LXBsYXRmb3JtIGZvciBzdWNo
IGRhdGEuDQoNCg0KSnVlcmdlbg0KDQo=
--------------RMi0wCbiGpLGo140UpxC0n9a
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

--------------RMi0wCbiGpLGo140UpxC0n9a--

--------------vf4FzMM9q0dUHbry13h1hLpr--

--------------jWZR8I9zS3FHQsOIdahf1hOJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfPEhoFAwAAAAAACgkQsN6d1ii/Ey/R
0wf/Q+dC5uvgQUIxKahqbgQ9x6xCWMh3d87dbEdXyW1FwQMel+n16zcvwlvqXHixnshcf0KMTHl+
blpi8cMGpGXyOlPmUHl8qJifAybuQ0DEgvdHTEB2OMy9p1fWzQKPcR4n20D4lSVnbkQp6k5Uv2Ee
iM0X+lBYVuDWB3yda703d7L0924P0OiQWjT7Rz1GGRLBQi3N30kPzofcI3XTICyJecLQwtaS5f5x
u8RRDpqhspp3WQ1Peoo1Z7V82JcUoe7i7RmtCUfJfAqJxUt1EOGm54XQ9C/Si0MRRmoWE8ufU2lE
sGIDSs773hdBEd16sgBtTDKmirzpVg7t1caug7DyDw==
=fsUR
-----END PGP SIGNATURE-----

--------------jWZR8I9zS3FHQsOIdahf1hOJ--

