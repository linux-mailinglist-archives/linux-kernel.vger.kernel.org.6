Return-Path: <linux-kernel+bounces-561185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A35A60E81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D4E3A694C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1811F03C7;
	Fri, 14 Mar 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wi9A2jQ1"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D61F236B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947279; cv=none; b=kOvzCDGzFM0CS71jZg7HVA6AOlO/oXQgzsV6DhR22nVQFZJPkLWt4+tpVdgwErd/fkONo7mqg9F0a692v2ztTVj9TW4Cca6RHeNIES0GjX+2ULJxj/084kLlKOmhkZ5uQhUQgE8aLox1tFU+9wY3+kHU66GGtwRUJHiinC29haQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947279; c=relaxed/simple;
	bh=KJJ6fPVwM15OWOjpGD1m539FVGRzH5c2a+G7+GXZ0aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoiHev5Us4sdCxT+BKvvCVeiqjfrZBjAe/tmXyCERGq060gM/fGJXRqaLVAbAUxO7z5rojV1R9hcUrhU4h9HyhaheuxBGBf0BwjmiMPJWzSSahvsv5/W1HYruS4mnHrl7fm1rFwQhOjKkQJdQwIjzl3mrgC1Mj5neskrcP5Bs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wi9A2jQ1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso5398534a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741947276; x=1742552076; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJJ6fPVwM15OWOjpGD1m539FVGRzH5c2a+G7+GXZ0aU=;
        b=Wi9A2jQ17FLghuuKDY6rSGpjcSZb6I2tQA1btUSNEoveSWFYOAlDEO+y7UzmH8kcLk
         5Cp2GloZzZ4J0amdwwavod9HtbhnmRVsWqTXFVK9WiaxE5wlswyNac0O/kuLtcIdO/th
         CtCuOAu+K0AI0kZvqNxIXxYKI6Eyy33OFj5MO89WqZByr0S+9GJHIkw/JoCyiGlcYFL1
         PKPVsRY7ob4st42WvYZ0pamr5QvD2gJdfqiVd/wYb/1uiA4R0/WNJR+Zv7Jy2sOJClkZ
         n1CU4RVUoE2PEALZpTcxlpE5miMYORU5W1+HnyOVPwrY99btFnK9rYoypthcVhcgxVRR
         fkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947276; x=1742552076;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJJ6fPVwM15OWOjpGD1m539FVGRzH5c2a+G7+GXZ0aU=;
        b=UdrJoIzpHlf2+uuw3tp1bGtKcWcXOK0HFKTN4t4/K5siN1ae50nuNOlSR0UDYC1MXC
         7T6jw8HBzq+g1q70QyO9PPGxppu3rmzJSjYit08hWg2uH3T051F5I1/qUlVxb2/wggXz
         9H4oDAC+El8w5uVapLFVUNbgQ2mRsyzHZ1wiRDZMw43Gpp0+8kIGZE6V8LwYs4x1NNez
         hM+na6sb+EvCQw7n2FlPQhF4ZqlJAVLxS0Qn7AfHrKssKCZio97T14Nn0QZMqz9McJYV
         iyZg4Uj8o9SY/HrJDQ40SXtetWxAmS+0e4iyIdPtL1Kf1dlLfRMhYP7JCA6LYM9i5sXd
         egnw==
X-Gm-Message-State: AOJu0Yx91DBRpbBNCbh24xkvQcfuJRKVYRmpkypB8IA0DTfrBGeyZTLd
	NiTTp3hW9Th9gHcrl80yW4z8msl+FjHw10v0SJeyrjOO14HLgoq5t3k5En7oeD4=
X-Gm-Gg: ASbGncsSc3EKiA/pTfsdR6CIIN1boxHbO7nw7dErqClut3WdZOOFnAZnGzbmNHyvQsg
	xXXmeolFo52WKGm/dB1I8SYAkblQkvs0b4g0w8L4jEgpXFUBzKNFcvEwSPph7inP+eefEL6QStP
	KaykiD1NtwHMD8wvUOX6TAcADswUrD4IWuBKGCCrpAZb2BLrVsJyJWscTkTiHFbBqHn4AJVymJJ
	wj5HVfrLls2EnzhtchPrKksW5WtvPZoGzADfbjffocVDeEJ5yFJvY8Dp2e4OF0C6XEaXsuGXOv/
	7ZhaYDvUwGl9crj9CSorcw738qWyI9RGzK3z9nZ+NeGhHtEmVY6K5kabgG42OSiv3TQtkyT1hmf
	eYrmG2+lY7dDjKqb0yfmSNp0+s/gs4xp5dEUEMcch3uDBaj4whOybY/rNcEKAT0Q3w/0=
X-Google-Smtp-Source: AGHT+IGrnmM39wYi4gCRAcld43nmOa77QuZBOY2nU6j9dxGAGNYsbjEsHkqCzeDhCRxSXg9fCvKfrg==
X-Received: by 2002:a05:6402:34d1:b0:5e4:d27a:d868 with SMTP id 4fb4d7f45d1cf-5e814839ec8mr6537137a12.0.1741947275565;
        Fri, 14 Mar 2025 03:14:35 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe1f6sm1738030a12.77.2025.03.14.03.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:14:35 -0700 (PDT)
Message-ID: <eccb68b1-ae34-4576-8f98-2cd9b2b2de0b@suse.com>
Date: Fri, 14 Mar 2025 11:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific
 code files
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Brian Gerst <brgerst@gmail.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
References: <20250313182236.655724-2-brgerst@gmail.com>
 <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
 <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com> <Z9QACrqCIxcZuY0U@gmail.com>
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
In-Reply-To: <Z9QACrqCIxcZuY0U@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MpucqMB7AGFAz5lXohxlB6wO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MpucqMB7AGFAz5lXohxlB6wO
Content-Type: multipart/mixed; boundary="------------907SwLbUGg8002oo4oRRStHo";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Brian Gerst <brgerst@gmail.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Message-ID: <eccb68b1-ae34-4576-8f98-2cd9b2b2de0b@suse.com>
Subject: Re: [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific
 code files
References: <20250313182236.655724-2-brgerst@gmail.com>
 <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
 <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com> <Z9QACrqCIxcZuY0U@gmail.com>
In-Reply-To: <Z9QACrqCIxcZuY0U@gmail.com>

--------------907SwLbUGg8002oo4oRRStHo
Content-Type: multipart/mixed; boundary="------------3Xc1mp00qYFtth6ifKOnT2K0"

--------------3Xc1mp00qYFtth6ifKOnT2K0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDMuMjUgMTE6MDgsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKw7xyZ2Vu
IEdyb8OfIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDE0LjAzLjI1IDEw
OjQ3LCB0aXAtYm90MiBmb3IgQnJpYW4gR2Vyc3Qgd3JvdGU6DQo+Pj4gVGhlIGZvbGxvd2lu
ZyBjb21taXQgaGFzIGJlZW4gbWVyZ2VkIGludG8gdGhlIHg4Ni9jcHUgYnJhbmNoIG9mIHRp
cDoNCj4+Pg0KPj4+IENvbW1pdC1JRDogICAgIDgyN2RjMmUzNjE3MmU5NzhkNmIxYzcwMWIw
NGJlZTU2ODgxZjU0YmYNCj4+PiBHaXR3ZWI6ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3RpcC84MjdkYzJlMzYxNzJlOTc4ZDZiMWM3MDFiMDRiZWU1Njg4MWY1NGJmDQo+Pj4g
QXV0aG9yOiAgICAgICAgQnJpYW4gR2Vyc3QgPGJyZ2Vyc3RAZ21haWwuY29tPg0KPj4+IEF1
dGhvckRhdGU6ICAgIFRodSwgMTMgTWFyIDIwMjUgMTQ6MjI6MzIgLTA0OjAwDQo+Pj4gQ29t
bWl0dGVyOiAgICAgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQo+Pj4gQ29tbWl0
dGVyRGF0ZTogRnJpLCAxNCBNYXIgMjAyNSAxMDozMjo1MSArMDE6MDANCj4+Pg0KPj4+IHg4
Ni94ZW46IE1vdmUgWGVuIHVwY2FsbCBoYW5kbGVyIHRvIFhlbiBzcGVjaWZpYyBjb2RlIGZp
bGVzDQo+Pj4NCj4+PiBNb3ZlIHRoZSB1cGNhbGwgaGFuZGxlciB0byBYZW4tc3BlY2lmaWMg
ZmlsZXMuDQo+Pj4NCj4+PiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQo+Pj4gUmV2aWV3ZWQt
Ynk6IFNvaGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5jb20+DQo+Pj4gQ2M6IEFuZHkg
THV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPj4+IENjOiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQo+Pj4gQ2M6IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29t
Pg0KPj4+IENjOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5v
cmc+DQo+Pj4gQ2M6IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KPj4+
IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMTMxODIyMzYuNjU1NzI0
LTItYnJnZXJzdEBnbWFpbC5jb20NCj4+DQo+PiBXaHkgZG8gSSBldmVuIHJlcXVlc3QgY2hh
bmdlcyBpZiBzdWNoIGEgcmVxdWVzdCBpcyBiZWluZyBpZ25vcmVkPw0KPiANCj4gSSBtaXNz
ZWQgeW91ciBtYWlsLCBzb3JyeS4NCj4gDQo+PiBQbGVhc2Ugbm90ZSB0aGF0IG15IHJlcXVl
c3Qgd2Fzbid0IGFib3V0IHNvbWV0aGluZyB3aGljaCBzaG91bGQgYmUNCj4+IGhhbmRsZWQg
aW4gYSBmb2xsb3d1cCBwYXRjaC4gSSB3YXMgYXNraW5nIHRvIE5PVCBtb3ZlIHRoZSBjb2Rl
IGludG8NCj4+IG11bHRpcGxlIGZpbGVzLCBidXQgdG8ga2VlcCBpdCBpbiBvbmUgZmlsZSBh
cyBpdCB3YXMgb3JpZ2luYWxseS4NCj4gDQo+IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB0aGlz
IGNvZGUgbG9va3MgYmV0dGVyIGluIGVubGlnaHRlbl9wdi5jLCBidXQNCj4gdGhlcmUncyBu
byByZWFzb24gdG8ga2VlcCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYywgYWdyZWVkPw0KDQpB
YnNvbHV0ZWx5Lg0KDQo+IA0KPiBJJ3ZlIHJvbGxlZCBiYWNrIHRoZXNlIGNoYW5nZXMgYW5k
IHdpbGwgd2FpdCBmb3IgLXYyLg0KDQpUaGFua3MNCg0KDQpKdWVyZ2VuDQo=
--------------3Xc1mp00qYFtth6ifKOnT2K0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------3Xc1mp00qYFtth6ifKOnT2K0--

--------------907SwLbUGg8002oo4oRRStHo--

--------------MpucqMB7AGFAz5lXohxlB6wO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfUAYoFAwAAAAAACgkQsN6d1ii/Ey81
cgf+Izsd/BP1o69W9uUO+kyr6Qt6Z78JtIN/OPPd+ymt63VpubwEuiE4hfRkqbOehdBJWorkLK38
8kX9vqR8tXk1Nn3N4z7aAxrIkaKLfCE6ax3Aqf63sjWeWMMxNTBJKPkpka59Qd3fYo7xvzalejdC
hoiuu7e+0MD9nQ4I135606tZD/6h6ZOg9sKvlp9VOmv4mJ+nj7YXEzyZmdVS4kTBZOMD5FRs5nuY
d6cE5wmSzShav10UUzkRfI+HkKTMkrtS6OkZ5jGENM8+LWVrR146yGLci9ujuThMHB3qiBY8n3TM
q6SKC6TTmd8JnVI8j+w2xke5lzeg0eQlIR4wpmXXTQ==
=VXLe
-----END PGP SIGNATURE-----

--------------MpucqMB7AGFAz5lXohxlB6wO--

