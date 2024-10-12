Return-Path: <linux-kernel+bounces-362205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3399B218
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD61C216D4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA0145B27;
	Sat, 12 Oct 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q+l1O9Bf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB813E8AE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721697; cv=none; b=QqGNjnIseaW/SaMgLzemmJtYamer0e1Mou8mXoyxq3XR8aQkcnSsSC+ZR37lWCia0JWXAV/ydpa0j+qa/kCqU+hA755ykfiCKA8nNZnMAzQX4Ns5Z9rELxng3yhbbQ+SAz4xxucHGTkwyOMxi31sLgzEXNj/4V/eiQ+hkln90v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721697; c=relaxed/simple;
	bh=4J8ofNBT+jlUTF2l15uYi7Npqa/12p42Lw5bSB4TPvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6xL8UuU5pQEtXl4gg7OYmsfu40TCNWdI7beDCQLMwdSTtEV+r/SI4ZofNBkS0ey+Cx4hlA80x8hk96OFH8C4MDcrWYX/yIcLniWpxuXZ96m805UuRp59cUHXIVGzQTc0hQ65Ykd23/JPXfRN0f2clqdETVQSG5KG/wLqbYmKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q+l1O9Bf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so968392f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728721693; x=1729326493; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4J8ofNBT+jlUTF2l15uYi7Npqa/12p42Lw5bSB4TPvg=;
        b=Q+l1O9Bf2+vbvKB+T72A4SXnCU0Ygbri6oyjgnODKjTiDk8/fogzdfoO+4/qZmoDGN
         DWbZ11iWWSf6ZCygYPxJfG7wdLhizrLryLmoE5WGKdZ+zfe21MsjI0YOi9tTCEX0VBc1
         x9p8D2toTPKx7diCxw47vtA06pDWpqEfT24mk72Wktu7DONbMCrPKAOJIx8t3sE0vMKE
         CeP98m12R84glyjB5hjbiSN/N1WsJbejIraLD1ineiVXzwnfe9rTQ4GfTRSelAaMmodp
         Knq1cmvNQkkRx9dHq0MEMr8T8XES/Dvl3LIdwbOKWLzOFkYCUopDTHrBeqBfLYW7orv0
         Rbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728721693; x=1729326493;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J8ofNBT+jlUTF2l15uYi7Npqa/12p42Lw5bSB4TPvg=;
        b=L0iCs/Cjp1E2k9mhAmHmT1okK2mtjaYGhteN3Cqe/xdZEuKjksp/f1VjcUyx0SeZVa
         UQprPhFJZlp5t0Q3IppF2ntqeipCWlkIE9kL++2AUh6RA7mRBlzFd1ffbUrZKigWHvgj
         4HH6b2l8joJM3zhAS0MBlA5dnjwTEjaanMuOC7xus3+wkT5d7B/G+0RiXCxofMJcnNjf
         aF3cUj3w2KmAMNinFdzCywyn40/KRV7f6p5sZQW7s3rUX+4KA4TlngWtzskHwdUL5saO
         iqXk4IBqg7rTXgjHN9qdFyEI0K9ArnDD1eS7n+fhZYWigJMOTW/XcEHrYphbO8jBFhYg
         z5HA==
X-Forwarded-Encrypted: i=1; AJvYcCX/veaTw/NjyYGJQxCy2WLjeB+paU7EXrlbXG175/f4ey/sbYOSy0A46Dkt3YEwWTk/FOg7cg6+lkqzdKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGsvwJeoz7KlsIVYz2xffNDMoEoDi4sYUzFS+3m57U1BFwhyK
	KRdERzNKiSBCOirYOe3VpKf0PzRKQgIocu/BXnNs4ktOoKbbPKVDIeZdE9jyGOs=
X-Google-Smtp-Source: AGHT+IH4wmwASKqEo/IHfuhAp3IcVLIY4vvlxJmhAuBe1EmgXjZItVS6Ltly6r0gI3XA0sLSpmAYqQ==
X-Received: by 2002:a5d:5351:0:b0:37d:4870:dedf with SMTP id ffacd0b85a97d-37d551d3fc5mr3784657f8f.19.1728721692943;
        Sat, 12 Oct 2024 01:28:12 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7f2c1esm5729802f8f.109.2024.10.12.01.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 01:28:12 -0700 (PDT)
Message-ID: <894abb0c-5ff4-4f86-9ecd-2e44907a39e9@suse.com>
Date: Sat, 12 Oct 2024 10:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xen: Remove dependency between pciback and privcmd
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <20241011034227.1278144-1-Jiqian.Chen@amd.com>
 <e6938fd7-2cb8-412f-b3e3-1943eeb271d8@suse.com>
 <BL1PR12MB58499172314E76D9A9278746E77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB5849C20650902FE3935BEC2AE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <075ce655-e871-4a3d-a550-7363bc4a165f@suse.com>
 <BL1PR12MB5849B929E9D01076059C739DE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
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
In-Reply-To: <BL1PR12MB5849B929E9D01076059C739DE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CL0FgEzEZsRg8nAKKN4UUTJ0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CL0FgEzEZsRg8nAKKN4UUTJ0
Content-Type: multipart/mixed; boundary="------------lL0TMuz20RbslIt9gxK27WO1";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <894abb0c-5ff4-4f86-9ecd-2e44907a39e9@suse.com>
Subject: Re: [PATCH v3] xen: Remove dependency between pciback and privcmd
References: <20241011034227.1278144-1-Jiqian.Chen@amd.com>
 <e6938fd7-2cb8-412f-b3e3-1943eeb271d8@suse.com>
 <BL1PR12MB58499172314E76D9A9278746E77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB5849C20650902FE3935BEC2AE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <075ce655-e871-4a3d-a550-7363bc4a165f@suse.com>
 <BL1PR12MB5849B929E9D01076059C739DE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849B929E9D01076059C739DE77A2@BL1PR12MB5849.namprd12.prod.outlook.com>

--------------lL0TMuz20RbslIt9gxK27WO1
Content-Type: multipart/mixed; boundary="------------mxVcTNCWp075btDOFJhwH1J0"

--------------mxVcTNCWp075btDOFJhwH1J0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMTAuMjQgMDg6NTAsIENoZW4sIEppcWlhbiB3cm90ZToNCj4gT24gMjAyNC8xMC8x
MiAxMzo0OCwgSsO8cmdlbiBHcm/DnyB3cm90ZToNCj4+IE9uIDEyLjEwLjI0IDA0OjM2LCBD
aGVuLCBKaXFpYW4gd3JvdGU6DQo+Pj4gT24gMjAyNC8xMC8xMiAxMDoyMiwgQ2hlbiwgSmlx
aWFuIHdyb3RlOg0KPj4+PiBPbiAyMDI0LzEwLzExIDIwOjA2LCBKdWVyZ2VuIEdyb3NzIHdy
b3RlOg0KPj4+Pj4gT24gMTEuMTAuMjQgMDU6NDIsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4+
Pj4+IENvbW1pdCAyZmFlNmJiN2JlMzIgKCJ4ZW4vcHJpdmNtZDogQWRkIG5ldyBzeXNjYWxs
IHRvIGdldCBnc2kgZnJvbSBkZXYiKQ0KPj4+Pj4+IGFkZHMgYSB3ZWFrIHJldmVyc2UgZGVw
ZW5kZW5jeSB0byB0aGUgY29uZmlnIFhFTl9QUklWQ01EIGRlZmluaXRpb24sIHRoYXQNCj4+
Pj4+PiBkZXBlbmRlbmN5IGNhdXNlcyB4ZW4tcHJpdmNtZCBjYW4ndCBiZSBsb2FkZWQgb24g
ZG9tVSwgYmVjYXVzZSBkZXBlbmRlbnQNCj4+Pj4+PiB4ZW4tcGNpYmFjayBpc24ndCBhbHdh
eXMgYmUgbG9hZGVkIHN1Y2Nlc3NmdWxseSBvbiBkb21VLg0KPj4+Pj4+DQo+Pj4+Pj4gVG8g
c29sdmUgYWJvdmUgcHJvYmxlbSwgcmVtb3ZlIHRoYXQgZGVwZW5kZW5jeSwgYW5kIGRvIG5v
dCBjYWxsDQo+Pj4+Pj4gcGNpc3R1Yl9nZXRfZ3NpX2Zyb21fc2JkZigpIGRpcmVjdGx5LCBp
bnN0ZWFkIGFkZCBhIGhvb2sgaW4NCj4+Pj4+PiBkcml2ZXJzL3hlbi9hcGNpLmMsIHhlbi1w
Y2liYWNrIHJlZ2lzdGVyIHRoZSByZWFsIGNhbGwgZnVuY3Rpb24sIHRoZW4gaW4NCj4+Pj4+
PiBwcml2Y21kX2lvY3RsX3BjaWRldl9nZXRfZ3NpIGNhbGwgdGhhdCBob29rLg0KPj4+Pj4+
DQo+Pj4+Pj4gRml4ZXM6IDJmYWU2YmI3YmUzMiAoInhlbi9wcml2Y21kOiBBZGQgbmV3IHN5
c2NhbGwgdG8gZ2V0IGdzaSBmcm9tIGRldiIpDQo+Pj4+Pj4gUmVwb3J0ZWQtYnk6IE1hcmVr
IE1hcmN6eWtvd3NraS1Hw7NyZWNraSA8bWFybWFyZWtAaW52aXNpYmxldGhpbmdzbGFiLmNv
bT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1k
LmNvbT4NCj4+Pj4+DQo+Pj4+PiBVbmZvcnR1bmF0ZWx5IEknbSBzZWVpbmcgYSBidWlsZCBi
cmVha2FnZSBmb3IgdGhlIDMyLWJpdCB4ODYgYnVpbGQuDQo+Pj4gQ291bGQgeW91IHBsZWFz
ZSBhdHRhY2ggdGhlIGxpbmsgb3Igc3RlcHM/DQo+Pj4gVGhlbiBJIGNhbiByZXByb2R1Y2Ug
aXQsIGFuZCB2YWxpZGF0ZSBpdCBsb2NhbGx5IHdpdGggbmV3IGNoYW5nZXMuDQo+Pg0KPj4g
SSdtIHVzaW5nIHRoZSBhdHRhY2hlZCBrZXJuZWwgY29uZmlnLg0KPiBUaGFua3MsIEkgY2Fu
IHJlcHJvZHVjZSB0aGUgMzItYml0IGJ1aWxkIGVycm9yIGxvY2FsbHkuDQo+IEFuZCB0aGlz
ICJBZGQgc3R1YnMgZm9yIHhlbl9hY3BpX3JlZ2lzdGVyX2dldF9nc2lfZnVuYyBhbmQgeGVu
X2FjcGlfZ2V0X2dzaV9mcm9tX3NiZGYgd2hlbiAiIUNPTkZJR19YRU5fRE9NMCIgaW4gYWNw
aS5oLCBsaWtlIHRoZSBvdGhlciBmdW5jdGlvbnMgaW4gdGhhdCBmaWxlIGRvLiIgY2FuIGZp
eCBpdC4NCj4gSXMgaXQgb2theT8NCg0KRmluZSB3aXRoIG1lLg0KDQoNCkp1ZXJnZW4NCg0K

--------------mxVcTNCWp075btDOFJhwH1J0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------mxVcTNCWp075btDOFJhwH1J0--

--------------lL0TMuz20RbslIt9gxK27WO1--

--------------CL0FgEzEZsRg8nAKKN4UUTJ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmcKMxsFAwAAAAAACgkQsN6d1ii/Ey8Y
RQf/bCfxdHN7w9BDH+qs+M7S5nnNGbLp/sfuzJC3Z17ZpylvzkIhylp6olmd5OQyXc+jHAgb3VGp
vZfVSxfnH2UxS5MPSVY2Swpq6U8lEltccSDmS8FjPpCduTdMjq3Yt35vNo4qsgipSrOUg4rA5vHK
cMU4RIaMpg23+x1L6FXJ23+cgD/a+KfzB4YlxQlrf8sD2tO4PvN/lKzPGtOsDQ0spGZZGtW+7YcE
Wk749oGZaxj/DomWAIZhx7Z93MpKNFk0BJftGBANx/3JRdssb+p3oGM13G1/NBvOfY5MmUibx3Ed
F1aSnvZcH2iTeI1So1q9ZXqlDpPWJmGRS+3syKRQSw==
=mm+3
-----END PGP SIGNATURE-----

--------------CL0FgEzEZsRg8nAKKN4UUTJ0--

