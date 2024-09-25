Return-Path: <linux-kernel+bounces-338307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F5985633
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9992873B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F215A87C;
	Wed, 25 Sep 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DF1X+3lX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FC1537B9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255848; cv=none; b=KHRaDW+u0YJKdi4/WC448sWkqeUTVAfgvXdVEKJwuhEkc84+XsfhB205iReSCZupPb/TD5gTmyWvy4b+LD1nwMzrYWEsBqLNXK58sSH/BLYZ+7eErsNBuoTlKi2jDRzkRWteCVmhI/7qIQzYIBYpFogfyLQbY60cB0glDwl9Lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255848; c=relaxed/simple;
	bh=LZsx/ZimTdbI7YyoogEaIqDwLv4sfbyZH4YsysYqMeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTfAkgaseXLbQD0apn2wICjT8oH6r5H3sUDY7m4WRkrb7HkCx6fRSpYAo2QcTtE8YPQ3XmVi0SIqb757m3AJNVdvx596OpHXkHCCl/fDrPOYJ7Xa5IO2bowjpbwlApGPdiXW2cLf/02slPd5rD/7fSEgkdc83PPrEngjwAldg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DF1X+3lX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so899178066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727255844; x=1727860644; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZsx/ZimTdbI7YyoogEaIqDwLv4sfbyZH4YsysYqMeQ=;
        b=DF1X+3lXtcIuB+0DmD4x+FhHlVLidjr7dg9sOdF4M9P71x+iaCGnY9xt8tSf1D6f9H
         miOR4C5jKZ7D3oOkA7psJ47b0ZcG8nfMXwB2X2B4vlh3jIUoBUB0fsgsf78CnQGxN4uR
         uOcG5syq6jqLKw7yHbPtX4ERAOZ1gvFuKph2TJhpEuw8mps3KROs0z1oWnG1QmtfYfAL
         TmDzzYuaOVglpn612gl8XLb3eytRwTXX/kJE/642jg3vEaabMa5FpG1bJ11Ko7saoZG6
         OcJhLk7nSFPONbtUZmsl/7JXXvYMVRQ8/GB2Vbqo19L4BgP2Yz6qmdblVWrFjZg6aNX5
         ZYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727255844; x=1727860644;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZsx/ZimTdbI7YyoogEaIqDwLv4sfbyZH4YsysYqMeQ=;
        b=bPKxiapil28M/utTJlwhGvfh1x9YigDV1ILEXDnKBaWuIidtOyylg7FWrx5E+iij5B
         4ZnimEJaKjomFMWZrrUgoEbbu+NiOoEpILbffvy9dM/qqpAJKt9BzQgQ3qVRn4NabvU/
         WVX7dIK4PBVXCGdmTNzFEitURSsCVBLuXQRgymsd4JZdTuqHKYXOE73Jp0dEKJauzVuQ
         ECNtNIP3dWEAaYNPPIXMSVmUkH2maSiDIIdZ7MP1npUfNXFcdU2Z0D94i1/5sgzDoppm
         beUIvaWa0Tr2c14g7c74TOCyWiWxMFY69AKxEyfLh8J86yX0ltdS67xKBtl6xU/s53tN
         35NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3YgdlrpinbmlSHL1LMOLIjX9O53ktB/9QOO/BzTWmpIlrzcwichc+D2krGgtJlHDAkMfvKRxWFBpYgxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJmXKdOSQcs5hmlax5PIAe8DAcC+xpZQx5tWoodkM39qFlpNx
	vNXY4ZxP9TeASdQK3S1V6ecDmavZofjUxDCXlyLeNGEapUIPhto8aAVqVb9XFbk=
X-Google-Smtp-Source: AGHT+IGVAffGlS6cntTxycI68gexJ12lyOZHjad+x6JJDFrgrTmDQQnSDMIt925RIXgOnhlp6D3rSg==
X-Received: by 2002:a17:906:bc15:b0:a86:f960:411d with SMTP id a640c23a62f3a-a93a0322a4dmr175509466b.2.1727255844100;
        Wed, 25 Sep 2024 02:17:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3429csm187348566b.36.2024.09.25.02.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 02:17:23 -0700 (PDT)
Message-ID: <52a2b2f3-ecdc-45fa-afcf-c4d6e2b1dd0c@suse.com>
Date: Wed, 25 Sep 2024 11:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen/acpi: upload power and performance related data
 from a PVH dom0
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
References: <20240916205009.52887-1-jason.andryuk@amd.com>
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
In-Reply-To: <20240916205009.52887-1-jason.andryuk@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7WWOom9pRJLp3Efn8O6hX17X"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7WWOom9pRJLp3Efn8O6hX17X
Content-Type: multipart/mixed; boundary="------------moj0HbhWt2HjiCuIiBx1Bl64";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jason Andryuk <jason.andryuk@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <52a2b2f3-ecdc-45fa-afcf-c4d6e2b1dd0c@suse.com>
Subject: Re: [PATCH v2] xen/acpi: upload power and performance related data
 from a PVH dom0
References: <20240916205009.52887-1-jason.andryuk@amd.com>
In-Reply-To: <20240916205009.52887-1-jason.andryuk@amd.com>

--------------moj0HbhWt2HjiCuIiBx1Bl64
Content-Type: multipart/mixed; boundary="------------2xxO8zEIJbSb0OG4CCPkmPRR"

--------------2xxO8zEIJbSb0OG4CCPkmPRR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjQgMjI6NTAsIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IEZyb206IFJvZ2Vy
IFBhdSBNb25uZSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQo+IA0KPiBXaGVuIHJ1bm5pbmcg
YXMgYSBQVkggZG9tMCB0aGUgQUNQSSBNQURUIGlzIGNyYWZ0ZWQgYnkgWGVuIGluIG9yZGVy
IHRvDQo+IHJlcG9ydCB0aGUgY29ycmVjdCBudW1iZXJzIG9mIHZDUFVzIHRoYXQgZG9tMCBo
YXMsIHNvIHRoZSBob3N0IE1BRFQgaXMNCj4gbm90IHByb3ZpZGVkIHRvIGRvbTAuICBUaGlz
IGNyZWF0ZXMgaXNzdWVzIHdoZW4gcGFyc2luZyB0aGUgcG93ZXIgYW5kDQo+IHBlcmZvcm1h
bmNlIHJlbGF0ZWQgZGF0YSBmcm9tIEFDUEkgZHluYW1pYyB0YWJsZXMsIGFzIHRoZSBBQ1BJ
DQo+IFByb2Nlc3NvciBVSURzIGZvdW5kIG9uIHRoZSBkeW5hbWljIGNvZGUgYXJlIGxpa2Vs
eSB0byBub3QgbWF0Y2ggdGhlDQo+IG9uZXMgY3JhZnRlZCBieSBYZW4gaW4gdGhlIGRvbTAg
TUFEVC4NCj4gDQo+IFhlbiB3b3VsZCByZWx5IG9uIExpbnV4IGhhdmluZyBmaWxsZWQgYXQg
bGVhc3QgdGhlIHBvd2VyIGFuZA0KPiBwZXJmb3JtYW5jZSByZWxhdGVkIGRhdGEgb2YgdGhl
IHZDUFVzIG9uIHRoZSBzeXN0ZW0sIGFuZCB3b3VsZCBjbG9uZQ0KPiB0aGF0IGluZm9ybWF0
aW9uIGluIG9yZGVyIHRvIHNldHVwIHRoZSByZW1haW5pbmcgcENQVXMgb24gdGhlIHN5c3Rl
bQ0KPiBpZiBkb20wIHZDUFVzIDwgcENQVXMuICBIb3dldmVyIHdoZW4gcnVubmluZyBhcyBQ
VkggZG9tMCBpdCdzIGxpa2VseQ0KPiB0aGF0IG5vbmUgb2YgZG9tMCBDUFVzIHdpbGwgaGF2
ZSB0aGUgcG93ZXIgYW5kIHBlcmZvcm1hbmNlIGRhdGENCj4gZmlsbGVkLCBhbmQgaGVuY2Ug
dGhlIFhlbiBBQ1BJIFByb2Nlc3NvciBkcml2ZXIgbmVlZHMgdG8gZmV0Y2ggdGhhdA0KPiBp
bmZvcm1hdGlvbiBieSBpdHNlbGYuDQo+IA0KPiBJbiBvcmRlciB0byBkbyBzbyBjb3JyZWN0
bHksIGludHJvZHVjZSBhIG5ldyBoZWxwZXIgdG8gZmV0Y2ggdGhlIF9DU1QNCj4gZGF0YSB3
aXRob3V0IHRha2luZyBpbnRvIGFjY291bnQgdGhlIHN5c3RlbSBjYXBhYmlsaXRpZXMgZnJv
bSB0aGUNCj4gQ1BVSUQgb3V0cHV0LCBhcyB0aGUgY2FwYWJpbGl0aWVzIHJlcG9ydGVkIHRv
IGRvbTAgaW4gQ1BVSUQgbWlnaHQgYmUNCj4gZGlmZmVyZW50IGZyb20gdGhlIG9uZXMgb24g
dGhlIGhvc3QuDQo+IA0KPiBOb3RlIHRoYXQgdGhlIG5ld2x5IGludHJvZHVjZWQgY29kZSB3
aWxsIG9ubHkgZmV0Y2ggdGhlIF9DU1QsIF9QU1MsDQo+IF9QUEMgYW5kIF9QQ1QgZnJvbSBh
IHNpbmdsZSBDUFUsIGFuZCBjbG9uZSB0aGF0IGluZm9ybWF0aW9uIGZvciBhbGwgdGhlDQo+
IG90aGVyIFByb2Nlc3NvcnMuICBUaGlzIHdvbid0IHdvcmsgb24gYW4gaGV0ZXJvZ2VuZW91
cyBzeXN0ZW0gd2l0aA0KPiBQcm9jZXNzb3JzIGhhdmluZyBkaWZmZXJlbnQgcG93ZXIgYW5k
IHBlcmZvcm1hbmNlIHJlbGF0ZWQgZGF0YSBiZXR3ZWVuDQo+IHRoZW0uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSmFzb24gQW5kcnl1ayA8amFzb24uYW5kcnl1a0BhbWQuY29tPg0K
PiAtLS0NCj4gdjI6DQo+IEFkZCBzZWNvbmQgYnVmZmVyIGZvciBfQ1NULiAgQ2FsbCB3YXMg
ZmFpbGluZyB3aXRoDQo+IEFFX0JVRkZFUl9PVkVSRkxPVygweDAwMGIpDQo+IA0KPiBSdW5u
aW5nIGEgUFZIIERvbTAgb24gQU1ELCBJIG5lZWRlZCB0aGlzIHYyIGNoYW5nZSB0byBnZXQg
dGhlIEMtU3RhdGUNCj4gaW5mb3JtYXRpb24gdXBsb2FkZWQuDQo+IA0KPiAtLS0NCj4gICBk
cml2ZXJzL3hlbi9wY3B1LmMgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAgIGRyaXZlcnMv
eGVuL3hlbi1hY3BpLXByb2Nlc3Nvci5jIHwgMjMwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gICBpbmNsdWRlL3hlbi94ZW4uaCAgICAgICAgICAgICAgICB8ICAgMiAr
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjE2IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3BjcHUuYyBiL2RyaXZlcnMv
eGVuL3BjcHUuYw0KPiBpbmRleCBjNjNmMzE3ZTNkZjMuLmRjOWYyYzE0YmY2MiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy94ZW4vcGNwdS5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL3BjcHUu
Yw0KDQouLi4NCg0KPiBAQCAtMzU0LDI0ICs1MTEsNDQgQEAgcmVhZF9hY3BpX2lkKGFjcGlf
aGFuZGxlIGhhbmRsZSwgdTMyIGx2bCwgdm9pZCAqY29udGV4dCwgdm9pZCAqKnJ2KQ0KPiAg
IAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJuIEFFX09LOw0KPiAgIAl9DQo+IC0JaWYgKGludmFs
aWRfcGh5c19jcHVpZChhY3BpX2dldF9waHlzX2lkKGhhbmRsZSwNCj4gLQkJCQkJCWFjcGlf
dHlwZSA9PSBBQ1BJX1RZUEVfREVWSUNFLA0KPiAtCQkJCQkJYWNwaV9pZCkpKSB7DQo+ICsN
Cj4gKwlpZiAoIXhlbl9wcm9jZXNzb3JfcHJlc2VudChhY3BpX2lkKSkgew0KPiAgIAkJcHJf
ZGVidWcoIkNQVSB3aXRoIEFDUEkgSUQgJXUgaXMgdW5hdmFpbGFibGVcbiIsIGFjcGlfaWQp
Ow0KPiAgIAkJcmV0dXJuIEFFX09LOw0KPiAgIAl9DQo+IC0JLyogVGhlcmUgYXJlIG1vcmUg
QUNQSSBQcm9jZXNzb3Igb2JqZWN0cyB0aGFuIGluIHgyQVBJQyBvciBNQURULg0KPiAtCSAq
IFRoaXMgY2FuIGhhcHBlbiB3aXRoIGluY29ycmVjdCBBQ1BJIFNTRFQgZGVjbGVyYXRpb25z
LiAqLw0KPiAtCWlmIChhY3BpX2lkID49IG5yX2FjcGlfYml0cykgew0KPiAtCQlwcl9kZWJ1
ZygibWF4IGFjcGkgaWQgJXUsIHRyeWluZyB0byBzZXQgJXVcbiIsDQo+IC0JCQkgbnJfYWNw
aV9iaXRzIC0gMSwgYWNwaV9pZCk7DQo+IC0JCXJldHVybiBBRV9PSzsNCj4gLQl9DQo+ICsN
Cj4gICAJLyogT0ssIFRoZXJlIGlzIGEgQUNQSSBQcm9jZXNzb3Igb2JqZWN0ICovDQo+ICAg
CV9fc2V0X2JpdChhY3BpX2lkLCBhY3BpX2lkX3ByZXNlbnQpOw0KPiAgIA0KPiAgIAlwcl9k
ZWJ1ZygiQUNQSSBDUFUldSB3LyBQQkxLOjB4JWx4XG4iLCBhY3BpX2lkLCAodW5zaWduZWQg
bG9uZylwYmxrKTsNCj4gICANCj4gKwlpZiAoIXByX2luaXRpYWxpemVkKSB7DQo+ICsJCXN0
cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIgPSBjb250ZXh0Ow0KPiArCQlpbnQgcmM7DQo+ICsN
Cj4gKwkJLyoNCj4gKwkJICogVGhlcmUncyBubyBDUFUgb24gdGhlIHN5c3RlbSB0aGF0IGhh
cyBhbnkgcGVyZm9ybWFuY2Ugb3INCj4gKwkJICogcG93ZXIgcmVsYXRlZCBkYXRhLCBpbml0
aWFsaXplIGFsbCB0aGUgcmVxdWlyZWQgZmllbGRzIGJ5DQo+ICsJCSAqIGZldGNoaW5nIHRo
YXQgaW5mbyBoZXJlLg0KPiArCQkgKg0KPiArCQkgKiBOb3RlIHN1Y2ggaW5mb3JtYXRpb24g
aXMgb25seSBmZXRjaGVkIG9uY2UsIGFuZCB0aGVuIHJldXNlZA0KPiArCQkgKiBmb3IgYWxs
IHBDUFVzLiAgVGhpcyB3b24ndCB3b3JrIG9uIGhldGVyb2dlbmVvdXMgc3lzdGVtcw0KPiAr
CQkgKiB3aXRoIGRpZmZlcmVudCBDeCBhbmIvb3IgUHggc3RhdGVzIGJldHdlZW4gQ1BVcy4N
Cj4gKwkJICovDQo+ICsNCj4gKwkJcHItPmhhbmRsZSA9IGhhbmRsZTsNCj4gKw0KPiArCQly
YyA9IGFjcGlfcHJvY2Vzc29yX2dldF9wZXJmb3JtYW5jZV9pbmZvKHByKTsNCj4gKwkJaWYg
KHJjKQ0KPiArCQkJcHJfZGVidWcoIkFDUEkgQ1BVJXUgZmFpbGVkIHRvIGdldCBwZXJmb3Jt
YW5jZSBkYXRhXG4iLA0KPiArCQkJCSBhY3BpX2lkKTsNCg0KSXMgaXQgcmVhbGx5IG5vcm1h
bCB0byBnZXQgYSBmYWlsdXJlIGhlcmU/IFNob3VsZG4ndCB0aGUgcmVhY3Rpb24NCmJlIGEg
bGl0dGxlIGJpdCBtb3JlIHZpc2libGUgaW4gdGhpcyBjYXNlPw0KDQpBbmQgY2FuIHlvdSBq
dXN0IGNvbnRpbnVlIHByb2Nlc3Npbmc/DQoNCj4gKwkJcmMgPSB4ZW5fYWNwaV9wcm9jZXNz
b3JfZXZhbHVhdGVfY3N0KGhhbmRsZSwgJnByLT5wb3dlcik7DQo+ICsJCWlmIChyYykNCj4g
KwkJCXByX2RlYnVnKCJBQ1BJIENQVSV1IGZhaWxlZCB0byBnZXQgX0NTVCBkYXRhXG4iLCBh
Y3BpX2lkKTsNCg0KU2FtZSBhZ2Fpbi4gSXMgcHJfZGVidWcoKSBlbm91Z2g/DQoNCg0KSnVl
cmdlbg0K
--------------2xxO8zEIJbSb0OG4CCPkmPRR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------2xxO8zEIJbSb0OG4CCPkmPRR--

--------------moj0HbhWt2HjiCuIiBx1Bl64--

--------------7WWOom9pRJLp3Efn8O6hX17X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbz1SMFAwAAAAAACgkQsN6d1ii/Ey/4
NQf/WYgmX+pmqzbkXCPjvYHOuqIkRXJD0hEhz42poVoW4ZEDi2y7xSqVvq7ojvJKQJAE5udUe7YH
VwgL+7j4Nx+kOA/KR0FfvEvcT/MgQH/SrYdWtW4N7Pxcqr0CDPzdeGSNZoVhwoVPt6nC51uBIvH/
/BYjgXKWS8sjcLHZQRFvYI+PMXmbZpy+Pmjetsdn+eZEL+at95G8g4iHUDpHrgojO1VxEnLXRA0q
B+JYeBXUh1apSAk1fHBC4R+qB/VBzbFwtZJAI5ScfXwbwmFfZedSNbdPL7cj2md7MQ0dxlTMscv3
zqRdTa7NWdK2osi/ZIh2+K9JTThn+NsZdfKKTdA0/g==
=4k4/
-----END PGP SIGNATURE-----

--------------7WWOom9pRJLp3Efn8O6hX17X--

