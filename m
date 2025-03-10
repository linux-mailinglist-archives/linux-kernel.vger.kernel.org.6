Return-Path: <linux-kernel+bounces-554567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6046DA59A03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDB618852E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23ED22B5AB;
	Mon, 10 Mar 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xn2VbaIE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B62206BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620794; cv=none; b=tP8A22B22l4qejvnox4FxDNx6l7v7Ov+vbPHd4zDhF5HpzXzgeoLBYowwLRjj8LKuHrwB0CtH+DGaCHdrf+e0Tk+pCLT5RojGOhcx/JhiHphtGOdbF1kia6xNtS5eaMsD4/aOQz2L565YhymxnkYHfiWuTurfFFEoHAu212fcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620794; c=relaxed/simple;
	bh=iSTEhSv4sNUs/PAhtIl57/j2n/YChBM3thjt0BLtJYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkT+D0C9C6BGUJBwSJ3E+JDSG77Lvj8rdd6wKk9qmVEWLtg/05d4RNslvM5E67ykosoEa+ceNsVyl7jwTDkPjwQIhlvyp0RT9NY324cMn9Zzw8Z/kseAJ5PpHLOvIgZBqSbhxa9khtmgFP0nZDstQL+YeJVqYSEz3jd31z3iXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xn2VbaIE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391211ea598so2479818f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741620790; x=1742225590; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iSTEhSv4sNUs/PAhtIl57/j2n/YChBM3thjt0BLtJYg=;
        b=Xn2VbaIEpByybjS5bU8zA4VP0Bkdy4z3EyzE+7kQtaZOoSnGkJEU+pMfr6QUDo7cRf
         t3VYSpmMeieqWC/buT3GQfX9y17MvnqctBJr9ywp/0pCV2ZPwbkW/qFqOA305waTUAfK
         m7Ue0L+R4wZjPHnveYm2fThtHFO1fLIj6C5rHJKqMPRmI8lB/kYgwuVI67aMwDmuLd5R
         R1PTeMXXJ4+J4dZ1ZuzEuOxL/0FN/kGDN6DmT3gaI2/bRjqptkfDsLekVP2YYla8iLFx
         FgLxFeyTpPJ1M88MyDhYOPUgndngSsWj9/E8+Us6r7EadzWG2bcZf5sB4r69ipCxVHnY
         YWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620790; x=1742225590;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSTEhSv4sNUs/PAhtIl57/j2n/YChBM3thjt0BLtJYg=;
        b=cBWMgSNq25BeVDnSrf1zsGO96XXRMll4geyyKqiWYWfsmpDzBgovPGDltJa/K4rCYi
         mM0kHqagl90JLIvMddIhsxENV3k5q6fr2HdhazzdDog5xsABR1ldmUCFajniNwOuti62
         qmsJTtYv26JnhcqPWcWSpEhhfiIus/pdRY2JqPcLvyJY9DYRCOXsUgKf0jyQCGDpI4MK
         /q6cKjn6EPbVysXJKJSmTo7FvdIB51+906I0SzDMIEvmDYngcZ4Bg5tr4NPM8UotffOu
         5TKPIq5mIJo9evd5/2qdKdZXfEmfgKJ1KLltt3M1w5xmg0jehdwaKj0biguQu7v3lB6o
         lJNA==
X-Forwarded-Encrypted: i=1; AJvYcCV52kQiK/gOyaFZorSyvM2n5Ju4y90JV83hDv4d5LRKeUMTcu8sMra6SAKd6+5+2pP82CBVEobek/ESAVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPKft/8Ja+UDcTK5RjQ+Y0U1nHh02S/V2P4cR7jlUEljj61oO
	Q6iYN9DIhpKqxqQ//DAGMhNjgjHkhai2Gl52T+SbUQZbweMzjiVrrzvn2VGzaek=
X-Gm-Gg: ASbGncuH1Mdu140hFiKC+81TRXxCtWO8mGuoCbiycdmmFlQxA8qlXRm3Ik4CHKvuHFU
	FlBwePcfPO5R9WwEycNNq5KuNErDZhC6t0bc9kK58C8hgDViTofFetSGam7AYRCFAuQ64o7crkH
	efmezOp9Pg5ZZIOGwuIVJy+gKgrwrqmzhC6ygkxng6v6fdFrRlW/IUUU+446n6dSyjRoCaW4YGn
	I9zDk4nTOe3czKxkGVhoZsfCjvXtxEs/LuFGO39XriqJTCMTIWNZJaMhI7takMSLLkUICnna1Yt
	YL3w7c2zlCjD6Te4PGbPQVXrunL354x0egHiGUa/pHPgc72avnahtUrkAbmX4oIeZiZgsUlZwYL
	0GLWLfBUwLGrpCzLk24nv2h50tgCdGL/YxBeB9DeH1QMIAHwwfHlF0GPTL1FLHZ9diXSDOFCFqq
	Ol/g==
X-Google-Smtp-Source: AGHT+IEPZKGGmq0ChLirV9Lav8PsWN7JjPPlvJ4fEWaIco8QPHDuY6+1rgpeNYJBaZNaXdor20fD4w==
X-Received: by 2002:a05:6000:460f:b0:391:4389:f363 with SMTP id ffacd0b85a97d-3914389f896mr6063315f8f.21.1741620790152;
        Mon, 10 Mar 2025 08:33:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103f41sm15060478f8f.85.2025.03.10.08.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:33:09 -0700 (PDT)
Message-ID: <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
Date: Mon, 10 Mar 2025 16:33:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Borislav Petkov <bp@alien8.de>, Alexey Gladkov <legion@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
References: <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org> <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org> <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
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
In-Reply-To: <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d39ZxTjPy5hCN0OkEQkdMbVz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d39ZxTjPy5hCN0OkEQkdMbVz
Content-Type: multipart/mixed; boundary="------------sF0Am0vADdY4HocO5kn3gR0k";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Alexey Gladkov <legion@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
Message-ID: <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org> <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org> <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
In-Reply-To: <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>

--------------sF0Am0vADdY4HocO5kn3gR0k
Content-Type: multipart/mixed; boundary="------------ZNAqE8nqDhXBtodBNiOKB92Q"

--------------ZNAqE8nqDhXBtodBNiOKB92Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDMuMjUgMTY6MTEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMTAsIDIwMjUgYXQgMDM6NTA6MDlQTSArMDEwMCwgQWxleGV5IEdsYWRrb3Ygd3JvdGU6
DQo+PiBBbSBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgeW91IGFuZCBKb2VyZyBhcmUg
cHJvcG9zaW5nDQo+Pg0KPj4gL3N5cy9ndWVzdC90ZHgvLi4uDQo+PiAvc3lzL2d1ZXN0L3Nl
di8uLi4NCj4+DQo+PiA/DQo+Pg0KPj4gV2hpY2ggcGF0aCB0byB1c2UgZm9yIHRoZSBob3N0
IHNpZGUgPw0KPj4NCj4+IEZvciBndWVzdDogL3N5cy9jb2NvL2d1ZXN0L3t0ZHgsc2V2fS8u
Li4NCj4+IEZvciBob3N0OiAgL3N5cy9jb2NvL2hvc3Qve3RkeCxzZXZ9Ly4uLg0KPj4NCj4+
IE1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBhZGQgdGhlICJjb2NvIiBzdWJkaXJlY3Rv
cnkgb3Igc29tZXRoaW5nIGxpa2UNCj4+IHRoYXQgPw0KPiANCj4gSG1tLCBzbyB3ZSBjYW4g
ZG8NCj4gDQo+IC9zeXMvZ3Vlc3QNCj4gDQo+IGFuZCBleHRlbmQNCj4gDQo+IC9zeXMvaHlw
ZXJ2aXNvcg0KPiANCj4gT3Igd2UgY2FuIGRvIHdoYXQgeW91J3JlIHN1Z2dlc3RpbmcuDQo+
IA0KPiBJZiB3ZSBkbyAvc3lzL2NvY28vaG9zdCwgdGhlbiB3ZSdsbCBoYXZlIHR3byBkaWZm
ZXJlbnQgcGxhY2VzIHRvIHJlYWQgSFYgaW5mby4NCj4gDQo+IE9yIHdlIGNhbiBzdGljayAq
ZXZlcnl0aGluZyogY29jbyBuZWVkcyBpbg0KPiANCj4gL3N5cy9jb2NvL3tzZXYsdGR4fQ0K
PiANCj4gYnV0IHRoZW4gaXQgaXMgY29jby1zcGVjaWZpYyBhbmQgaWYgb3RoZXIgZ3Vlc3Qg
dHlwZXMgd2FudCB0byBwdXQgc3R1ZmYgaW4NCj4gc3lzZnMsIGl0J2xsIGdldCB1Z2x5Lg0K
PiANCj4gU28gSSBndWVzcyBoYXZpbmcNCj4gDQo+IC9zeXMvZ3Vlc3QNCj4gYW5kDQo+IC9z
eXMvaHlwZXJ2aXNvcg0KPiANCj4ga2luZGEga2VlcHMgaXQgYWxsIGNsZWFuLCBoaWVyYXJj
aHktd2lzZS4uLg0KPiANCj4gUmlnaHQ/DQoNCktpbmQgb2YuDQoNCi9zeXMvaHlwZXJ2aXNv
ciBpcyBtZWFudCB0byBwcm92aWRlIGRhdGEgZm9yIHJ1bm5pbmcgdW5kZXIgYSBoeXBlcnZp
c29yLg0KDQpJdCBpcyBOT1QgbWVhbnQgdG8gcHJvdmlkZSBkYXRhIGZvciBydW5uaW5nIGFz
IGEgaHlwZXJ2aXNvci4NCg0KU28gZmFyIHdoZW4gcnVubmluZyBlaXRoZXIgdW5kZXIgWGVu
IG9yIHVuZGVyIHovVk0gL3N5cy9oeXBlcnZpc29yIGlzIGJlaW5nDQpwb3B1bGF0ZWQuDQoN
CkknbSBub3QgZmVlbGluZyByZWFsbHkgc3Ryb25nIGhlcmUuIEkganVzdCB3YW50IHRvIHN0
YXRlIHRoZSBzdGF0dXMgcXVvLg0KDQoNCkp1ZXJnZW4NCg==
--------------ZNAqE8nqDhXBtodBNiOKB92Q
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ZNAqE8nqDhXBtodBNiOKB92Q--

--------------sF0Am0vADdY4HocO5kn3gR0k--

--------------d39ZxTjPy5hCN0OkEQkdMbVz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfPBjQFAwAAAAAACgkQsN6d1ii/Ey+j
UAf9EuD89MVth+XUwQBzRQoLrIukLbudBi3ZQCCd8IdLnLkj2E0jyTG88taeMVCHCCR5zEigimvJ
52gjb4FPLMIQ1PaV3V69QoX9CtM9Q7dCdnQo8ldlnQ5sO/GtnILKmX3opKiFcnPmUc2KnU+PlZZN
NXrS4Ahg96+Phgal1VMAScU7FLsyYOXuOafV4GvQHlSyIrbnLs6g9Fp8QNAR3ULfuqTrfXJ1+O7/
6nTX4i5Y84ixZQq0a/Pi7khNdVaYeKmk+UBeWgICcIVziuH9y88v50SvzmgJWllCNkFH3F2pLX3B
CQTog2L8TXtU31Gvu/YZ8FDxT4obnSalfD27I+1gUA==
=zDEg
-----END PGP SIGNATURE-----

--------------d39ZxTjPy5hCN0OkEQkdMbVz--

