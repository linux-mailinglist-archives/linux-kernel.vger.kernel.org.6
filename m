Return-Path: <linux-kernel+bounces-546716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82328A4FDF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A530816D011
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4F233737;
	Wed,  5 Mar 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NMRTnOIV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B212E3372
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175297; cv=none; b=dMDPvZXwDpy1D2BrAeJ/7j4GCQmian5Uj9ndWbVdfDJKxJRt76jpEPuoU6lyOhppzkmLPlSbj/YZrgnwMAR5WmQR6aFh0oZGyYsGGAajbaFlBUJZrSomhbW0PECG8MhxyR33hE/NKgniFRcrit1dIpfOVIT5GPuih2LG7Aw7Zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175297; c=relaxed/simple;
	bh=KcR4UvWjwNqPLQ8QN2L3XZ7Z9/BYt9nKigtezLUjCbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz54SEHTrYVRtd/5Ndg4DMGQ/IiVvqMdsLnWT4QmLftckLkWPJ9fAe3WUFWg1XMiIoGvoX32nZ80SEyONjfSv9/X7BjcE/ajdRIlDr9R43POLMMmgGYkzDb6yBsRvurESLBQ9Vv+X+BUQ7FLOArafCf3w6V4rwbZR8TTid/n8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NMRTnOIV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so8684592a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741175293; x=1741780093; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KcR4UvWjwNqPLQ8QN2L3XZ7Z9/BYt9nKigtezLUjCbM=;
        b=NMRTnOIVbTiRzttRt8jnnPO0wbvTBasjfxS31eBPdpVhGTZM+/mSBy7/G5EPGLnoc7
         0hqNc0pX0cQU/CkRrZ2YjSbEsSPEYxIMqJcQe2R2sjwzSWp8cBe9anMex0JxZhFPmoZy
         AHLyiqBGC3XhNIeNaSobtYCmHzU+YyRiXQ8MlPR+7wqpl56NGfnAdmdBqC19izUhbbFp
         RXrlRBieQ4GQorGiS5Enpdizwgb70ExCJIA9ao/jvnIITeZoesqh1ziaQoH1GA1Wpwfr
         /XAhSiC2A8F/QPgi+ukrCfCctPGGTRfY+vJbPpKFK+unWfbZNMnGUFQnVSy+15EqEpU8
         yA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741175293; x=1741780093;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcR4UvWjwNqPLQ8QN2L3XZ7Z9/BYt9nKigtezLUjCbM=;
        b=oRFyVKZtTPJOXgl2j5+T6JfXIKIUUojGuK+k+F4rXGrue4c4oK6aLFIRBDlU13irDP
         idrRNSSABKLb1/Uz8SeuQgVXdDrKk7dKJp1RMaZqXcFGqIFSYT2rUa7wJW4wxypylAbY
         dwQEfjVvU4ZUC5ICml7+mY0PLcBgU7Lr90hkzerBJJcD3MqJuQCfYRtBcd5HC5iSbsk3
         xBade+IWTd/CRBktY99Fr4HS5rijgMphBiW+8888zqT6MXRWqqo4/tYQ7b/eygSXNTrS
         jpGDm51n5oSVcCvcWiHyEfae9K9XAqRpFHnqhm5IeIOFvgUgilXNG/mTo0q7TOiOK7+o
         qK4w==
X-Forwarded-Encrypted: i=1; AJvYcCUhx50VykNLCU4Co3zjxksGP2J18leNPYEVFwTmwJPhEpJmeCeOvyabu1h+mVZNINDBApYJB3jMnaZQKb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYJVSSa3+/v1b93VxDDKtORG7Qa4SIcP+8nBhcG/hfKKXN7yn
	qowlZpQ36RwpeDLnRqiRPDBTkQaFcrlfFah6Fvmqrb7INQu94s1lKjQ9U+SMP4s=
X-Gm-Gg: ASbGncshvpg3A6Y1jBC1VCOHSHelv72f2h1dO7hP9V0dVZ9wjiyb6YUFx3EGJGOHs7d
	s9Jm3wx1NrjFhzi5MRelIV6t2ZtB6c3zJ+s9ql7qCyUSrABgnjIUojiLyq1DOZDciqtlu9uG7En
	hU/S+yw7/xQxfNz5M0hUqKE+Wm8G1HZ7mfyYfA6PydSCfAGWj6I6krWgjV2tcJ9eTO5b8TANES4
	h1YZmc+JolREbHR3FcG6eJQ5iWssqmr3nZaE4yIkA9zV6WKVYAO8BcjLhyAluvxBGHvqQ0Aoyiq
	j9O5SLf4PZXGdoiEsEpGheH+XRn9L5uyEtWHywwVUhvAvFYi4RAZ7avFg80pVTHfYQYTNJRDmo+
	1k0Uz1EgSar2oDLeHB59jU3/PRmqqpFq2NoEEJT7Vx+/530COeuMCgbTUPLD1Ex57+qE=
X-Google-Smtp-Source: AGHT+IHvx/yCrIcdVl7jCjWTWbFw62swC65fWvWesY9yyWaQQ+Hd4rHQRHb1Jjm2s1MHsOyTWIaqkw==
X-Received: by 2002:a05:6402:430f:b0:5dc:7fbe:72ff with SMTP id 4fb4d7f45d1cf-5e59f38570cmr2848990a12.2.1741175293121;
        Wed, 05 Mar 2025 03:48:13 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bc3d1a54sm13118a12.46.2025.03.05.03.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 03:48:12 -0800 (PST)
Message-ID: <b21842d7-0355-4630-b293-2d29b003918b@suse.com>
Date: Wed, 5 Mar 2025 12:48:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <d9a1a460-2982-429c-b29d-cf2483e9380a@suse.com>
 <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>
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
In-Reply-To: <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0vRYiIHyii2QHmr1X3NEr0DC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0vRYiIHyii2QHmr1X3NEr0DC
Content-Type: multipart/mixed; boundary="------------ClHA4MNuNapxO2HDNUIlgfEw";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Message-ID: <b21842d7-0355-4630-b293-2d29b003918b@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <d9a1a460-2982-429c-b29d-cf2483e9380a@suse.com>
 <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>
In-Reply-To: <20250305114132.GDZ8g4bNdM-I5OQd4B@fat_crate.local>

--------------ClHA4MNuNapxO2HDNUIlgfEw
Content-Type: multipart/mixed; boundary="------------n7pTQ3sRwgl0VAQAIhscLDvv"

--------------n7pTQ3sRwgl0VAQAIhscLDvv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDMuMjUgMTI6NDEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMDUsIDIwMjUgYXQgMTI6MzU6NTZQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRoZXJlIGlzIC9zeXMvaHlwZXJ2aXNvci8NCj4+DQo+PiBXaHkgZG9uJ3QgcHV0IGl0
IHRoZXJlPyBNYXliZSB1bmRlciAvc3lzL2h5cGVydmlzb3IvY29jby4NCj4gDQo+IEl0J3Mg
YSBndWVzdCBmZWF0dXJlcyB0aGluZy4NCj4gDQoNCkFuZD8NCg0KVW5kZXIgWGVuIHRoZXJl
IGlzIGUuZy4gL3N5cy9oeXBlcnZpc29yL2d1ZXN0X3R5cGUgd2hpY2ggc2hvd3MgaW4gd2hp
Y2gNCm1vZGUgdGhlIGd1ZXN0IGlzIHJ1bm5pbmcgKCJQViIgb3IgIkhWTSIpLg0KDQoNCkp1
ZXJnZW4NCg==
--------------n7pTQ3sRwgl0VAQAIhscLDvv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------n7pTQ3sRwgl0VAQAIhscLDvv--

--------------ClHA4MNuNapxO2HDNUIlgfEw--

--------------0vRYiIHyii2QHmr1X3NEr0DC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfIOfsFAwAAAAAACgkQsN6d1ii/Ey+E
QQf/cOeVg98hG8NSPFgtT353Wdajyu871n6gfGOVCGf8QI4H7MOgssIL20xX98jLGi8jg46/S0YT
Bvdzrxdyo0pl8DpM9HAXHOD6GBHhHi028Kf3joIXSljelUIIoS89tBCfAEJ3xLmi4w+IbWhoq1al
NrO9vdTh6Z2KugY6/MdYOdFrFuIuhvj/n0yi2sPwRY9dWhC28hg3b1YQbQK9FGFHPpqXNxVqs+uc
yDQjpqWaJxS+ve/SxCZ+fBBwt8vrHTo3wh66ANzA0u1Cg4sH7pHwkHJaBUC3qPS/63WKnr4QABdx
c059vv+ckv/vHCUwNPUEY3y5/WptNAOxwI9eM/jcdg==
=mAAp
-----END PGP SIGNATURE-----

--------------0vRYiIHyii2QHmr1X3NEr0DC--

