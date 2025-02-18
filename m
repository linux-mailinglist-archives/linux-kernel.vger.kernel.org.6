Return-Path: <linux-kernel+bounces-519603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264DA39E82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13607A428F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B026A0A0;
	Tue, 18 Feb 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvx8BLpQ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF320269CF0;
	Tue, 18 Feb 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888213; cv=none; b=L/LSnMuPiZUHykYRtmsQyZHc+QxdzbWNwuA81GYgPAxLIsVZQaXzPZaVY/ExuWvsYRhws+5io8YDV25cgeyY6AL9i4YJSgGygEkNIAiXzZ5q+zYP3QY6EHYf0Fttk1dzr37HXXp5QUlOoHBqgdFeRCAe5QpOzxU0eJMRBB52MOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888213; c=relaxed/simple;
	bh=50NIuGYsukzJAUYD8eK1C1nq8G9+tcgDGYEPNa1tQrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4hX5Q4oMEiq8BL25XEzmKZeHnlnZopAxLXM0IQC6MI4RcjrZq2HDloY3jvRuShX9cJuEbYQdwVZBPMjoJO4UxY4EQ9y12mtB2bQUq+n5tLg6Xtz6CLBB1ccCxtAyYoh9a7hhHZleLGWoi1iNvyLk/rit0ieajFrl6wYD1KIPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvx8BLpQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so3233914f8f.3;
        Tue, 18 Feb 2025 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888210; x=1740493010; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50NIuGYsukzJAUYD8eK1C1nq8G9+tcgDGYEPNa1tQrI=;
        b=Rvx8BLpQE+4+zKBCw0aox0jYeJ0XO4cEq2IwqS83+tXbRl+MwFbx1ISEzCjJHcX6Yn
         /9SXO3q0edjqif6dZv2IqNT6dsq8rfl0W8NoEMZAh1luq+NR4X5uRSa/aw44RMGmt88g
         uudbMsDDJ3N+ZQty4FPHIVOjbmEmAnjItOww9XF5XJPHFkBEzVlyJkR/G45DqZ5XIPLe
         bxZ0pOZC8evi9jLSltHShgYRtp78f+9A9YRTkrOS+d7sFTRM/adDhS1cbdZ+mJHIjd/G
         nkWGG1i4GoZjaHCobYKHzDSCR3ghi67jH1wlVw3nsNJZQiWhpOGdZULqhygaZ/jSFcxI
         UIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888210; x=1740493010;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50NIuGYsukzJAUYD8eK1C1nq8G9+tcgDGYEPNa1tQrI=;
        b=IsLupoQOWjSUCEeeMDN8MArwPQiLKRGQhzlcPxbtSPkZ9vu+aRfUJ7m0uZv2ScPoau
         QLNH/O2Yywrm0a4rQ+8QLB5O3sWcQ/XMDfPybc2mpRCnT0WcK0LYcV/tPT/dwXD0oGz1
         J+V7w8x+0jtnvrnrErwTG6FtIgQBX/vmb6UyTV/XgOWS2BbQDZwTlLa3qirY5wcTncwv
         KnjDMiosAKAgTTU/2EdyFhUWTcozUXrfTMvd/ypLbdnAa9TGsflW4NwEt+oz8SXcsvdB
         y1ueRkpSeuV9RBj1xFqIGNPF0wYt0VV6/a54hX7uvGf9LN139HpJDHRmgOLgn68cKFZP
         2G5A==
X-Forwarded-Encrypted: i=1; AJvYcCVF6nz0fE/f49KBrFb4sWXy7SJxbmcWqX66wwXYNSWHFxkqlrLGli+24bkjGBAHb9196//X8DcKv5mwu6zG@vger.kernel.org, AJvYcCXvTilw0O5m1BW8R5lM+EyX1duOp8IUTSNNVfdVnt3XhT2PNhdSE1ayRehCfIRwSNSEUPw/j/Om0ZEi4rQc+8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xMZRXMEikCVc094T0yeRqgPCSH+HY1vucv76ccPNQZp0GRnc
	PaX9SRGzcl9vxYZid4WQNh7QnbIdb1gDwABkq213kMqcmDbF3NoE
X-Gm-Gg: ASbGncvVbojzLzj/9kLXGS1XXSFWpyAzVictyEYDu866d/cqWrRxnsn6ieIetI0I/m/
	kq+YncGT2n0CVegDMgrQ+rBK57EUCPbWv1vQQ2v+HQItFO+jqiWU1RGKgsPVJtm81mdpMJteC8t
	YkBnM6BWXOZDUo0aCB7sTZWWwdfrgpr9W6xr6iEEXylErMlOJodsxcfLvRNAJ9r91Y/tprmYA0K
	1rGqrkbBSxfk8Zkyrpe11qGzYw+70L/CsgBFJTUzb49GWJdJvlYXRPZrs6dVSVMvskK5omEnkKy
	i2De0g6ZvRQWu90GOS5XnG5u
X-Google-Smtp-Source: AGHT+IF5Q56619c64DVm6Lc6xYq/hX88mffqFfQ6EBdN7wy+U9o6qqNutZJZ7ABwWjBrGIMyCedHOA==
X-Received: by 2002:a5d:59ab:0:b0:38d:eb33:7be6 with SMTP id ffacd0b85a97d-38f33f105admr9892773f8f.4.1739888209329;
        Tue, 18 Feb 2025 06:16:49 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259f8121sm14926832f8f.88.2025.02.18.06.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:16:48 -0800 (PST)
Message-ID: <cbb812ea-4585-4777-aaae-3dcdcd0bd8d9@gmail.com>
Date: Tue, 18 Feb 2025 14:16:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217170934.457266-1-colin.i.king@gmail.com>
 <Z7N4tLUpRA1EKfDm@casper.infradead.org>
 <08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
 <20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------snwLW0G9wiDsfSdc8JHnJ38q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------snwLW0G9wiDsfSdc8JHnJ38q
Content-Type: multipart/mixed; boundary="------------oQ6h5JSs59uvHsJHifiThZAo";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <cbb812ea-4585-4777-aaae-3dcdcd0bd8d9@gmail.com>
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
References: <20250217170934.457266-1-colin.i.king@gmail.com>
 <Z7N4tLUpRA1EKfDm@casper.infradead.org>
 <08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
 <20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>
In-Reply-To: <20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>

--------------oQ6h5JSs59uvHsJHifiThZAo
Content-Type: multipart/mixed; boundary="------------71kVAc104mG7PsqDnyAtafwH"

--------------71kVAc104mG7PsqDnyAtafwH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTgvMDIvMjAyNSAwMzoxMywgQW5kcmV3IE1vcnRvbiB3cm90ZToNCj4gT24gTW9uLCAx
NyBGZWIgMjAyNSAxODowMDoyMiArMDAwMCAiQ29saW4gS2luZyAoZ21haWwpIiA8Y29saW4u
aS5raW5nQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gZk9uIDE3LzAyLzIwMjUgMTc6NTgs
IE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4+IE9uIE1vbiwgRmViIDE3LCAyMDI1IGF0IDA1
OjA5OjM0UE0gKzAwMDAsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPj4+PiBBZGRpbmcgYW4g
dW5saWtlbHkoKSBoaW50IG9uIHRoZSBtYXNrZWQgc3RhcnQgY29tcGFyaXNvbiBlcnJvcg0K
Pj4+PiByZXR1cm4gcGF0aCBpbXByb3ZlcyBydW4tdGltZSBwZXJmb3JtYW5jZSBvZiB0aGUg
bWluY29yZSBzeXN0ZW0gY2FsbC4NCj4+Pj4NCj4+Pj4gQmVuY2htYXJraW5nIG9uIGFuIGk5
LTEyOTAwIHNob3dzIGFuIGltcHJvdmVtZW50IG9mIDducyBvbiBtaW5jb3JlIGNhbGxzDQo+
Pj4+IG9uIGEgMjU2S0IgbW1hcCdkIHJlZ2lvbiB3aGVyZSA1MCUgb2YgdGhlIHBhZ2VzIHdl
IHJlc2lkZW50Lg0KPj4+Pg0KPj4+PiBSZXN1bHRzIGJhc2VkIG9uIHJ1bm5pbmcgMjAgdGVz
dHMgd2l0aCB0dXJibyBkaXNhYmxlZCAodG8gcmVkdWNlDQo+Pj4+IGNsb2NrIGZyZXEgdHVy
Ym8gY2hhbmdlcyksIHdpdGggMTAgc2Vjb25kIHJ1biBwZXIgdGVzdCBhbmQgY29tcGFyaW5n
DQo+Pj4+IHRoZSBudW1iZXIgb2YgbWluY29yZXMgY2FsbHMgcGVyIHNlY29uZC4gVGhlICUg
c3RhbmRhcmQgZGV2aWF0aW9uIG9mDQo+Pj4+IHRoZSAyMCB0ZXN0cyB3YXMgfjAuMTAlLCBz
byByZXN1bHRzIGFyZSByZWxpYWJsZS4NCj4+Pg0KPj4+IEkgdGhpbmsgeW91J3ZlIGVsaWRl
ZCBfanVzdF8gZW5vdWdoIGluZm9ybWF0aW9uIGhlcmUgdGhhdCBub2JvZHkgY2FuDQo+Pj4g
anVkZ2Ugd2hldGhlciB5b3VyIHN0YXRzIHNraWxscyBhcmUgYW55IGdvb2QgOy0pICBZb3Un
dmUgdG9sZCB1cyA3bnMNCj4+PiAocGVyIGNhbGwsIHByZXN1bWFibHkpIGFuZCB5b3UndmUg
dG9sZCB1cyAwLjEwJSBzdGFuZGFyZCBkZXZpYXRpb24sDQo+Pj4gYnV0IHlvdSBoYXZlbid0
IHRvbGQgdXMgaG93IGxvbmcgdGhlIHN5c2NhbGwgdGFrZXMsIHNvIG5vYm9keSBjYW4gdGVs
bA0KPj4+IHdoZXRoZXIgN25zIGlzIHdpdGhpbiAwLjEwJSBvciBub3QgOy0pDQo+Pg0KPj4g
VWdoLCBteSBiYWQuDQo+Pg0KPj4gSW1wcm92ZW1lbnQgd2FzIGZyb20gfjk3MCBkb3duIHRv
IDk2MyBucywgc28gc21hbGwgfjAuNyUgaW1wcm92ZW1lbnQuDQo+Pg0KPiANCj4gSXQgYWN0
dWFsbHkgZG9lc24ndCBjaGFuZ2UgdGhlIGdlbmVyYXRlZCBjb2RlOg0KDQpJJ3ZlIGNvbXBh
cmUgdGhlIGdlbmVyYXRlZCB4ODYgb2JqZWN0IGNvZGUgdXNpbmcgZ2NjIDE0LjIuMSAyMDI0
MDkxMiANCihGZWRvcmEgNDEpIGFuZCAxNC4yLjAgKERlYmlhbiAxNC4yLjAtMTcpLCAxNC4y
LjEgMjAyNTAyMTEgKENsZWFyIExpbnV4KSANCmFuZCBJIGdldCBkaWZmZXJlbmNlcyBpbiB0
aGUgZ2VuZXJhdGVkIG9iamVjdCBjb2RlIGNvbXBhcmluZyBvbGQgYW5kIA0KbmV3LCBhbmQg
dGhlIGltcHJvdmVtZW50IG9uIENsZWFyTGludXggaXMgbW9yZSBzaWduaWZpY2FudCB0b28g
YmVjYXVzZSANCml0IHVzZXMgLU8zLiBTbyBJJ20gY29uZmlkZW50IHRoZSBjaGFuZ2UgaXMg
Z2VuZXJhdGluZyBpbXByb3ZlZCBvYmplY3QgY29kZS4NCg0KDQo+IA0KPiBocDI6L3Vzci9z
cmMvMjU+IGRpZmYgLXUgbW0vbWluY29yZS5sc3Qub2xkIG1tL21pbmNvcmUubHN0DQo+IC0t
LSBtbS9taW5jb3JlLmxzdC5vbGQJMjAyNS0wMi0xNyAxOToxMTozNC4wOTM3Mjc0MTEgLTA4
MDANCj4gKysrIG1tL21pbmNvcmUubHN0CTIwMjUtMDItMTcgMTk6MTI6NTkuNzk3MDA5MDU2
IC0wODAwDQo+IEBAIC0xNTYzLDcgKzE1NjMsNyBAQA0KPiAgIAlzdGFydCA9IHVudGFnZ2Vk
X2FkZHIoc3RhcnQpOw0KPiAgIA0KPiAgIAkvKiBDaGVjayB0aGUgc3RhcnQgYWRkcmVzczog
bmVlZHMgdG8gYmUgcGFnZS1hbGlnbmVkLi4gKi8NCj4gLQlpZiAoc3RhcnQgJiB+UEFHRV9N
QVNLKQ0KPiArCWlmICh1bmxpa2VseShzdGFydCAmIH5QQUdFX01BU0spKQ0KPiAgICAgICAg
YjI3OgkzMSBmZiAgICAgICAgICAgICAgICAJeG9yICAgICVlZGksJWVkaQ0KPiAgIAlhc20g
KEFMVEVSTkFUSVZFKCIiLA0KPiAgICAgICAgYjI5Ogk5MCAgICAgICAgICAgICAgICAgICAJ
bm9wDQoNCg==
--------------71kVAc104mG7PsqDnyAtafwH
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------71kVAc104mG7PsqDnyAtafwH--

--------------oQ6h5JSs59uvHsJHifiThZAo--

--------------snwLW0G9wiDsfSdc8JHnJ38q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAme0ljQFAwAAAAAACgkQaMKH38aoAiZs
kg/+Mlj/v7gS4fM4rP1IwB1eFTPFHJrfps3FI3L4F1dkzCZQoJpboevN7jScFn6jHlPjorjZRaUc
+SQFMfWgy7Y3SDxDhgiJhHONS3ZHe6X6aa6l23NuMtnyeCDXdRM2+ukqMXcsVdhqP2UDtOSKzBWc
oikN8ftKGvA8DjOyw5VvElpfgvLkwbAQQqylw3P8bxFbAnzgkLc1DLAO9JMKEhkm7p25VX2Itwld
NqaT8Znn1Kcj4fSegsgeqgy3F52aNYx18C78uOa3ktsg4cy5a9Ybj/OUdJKkDYce7hZDzwsSWFkq
E7n4zP0OGiYRb+AUvYlGfD3eublrwAYkGo3+7UNUpP/DN1EQ7ApGPzx2AN7oD1p8sghPejZNIt5j
r2QzEFme8dGLod4zJMny0yaKWZHtniN0qcY9o+qFsy5ZgmsWGrOxwjMyn6G7HIJkfhRNhI6utXZj
1RGcv43ozlCexGwPhZG6HJt2i039b3++U2BB+7YEB1Y9lPTl0h2I0AlpkawaKTXp5a9poQYRYGFc
UCzq2L2N6Da4UV6O6IHw59ASxY5u2LGBU3GivFyDykGKNnBGjJcuIStF+dszKcBsIDPtd0WYXpMm
FiWvAKG5sNqq5yTJirW9EMIaAIJgOvZJ/BhYNzC8wnZrm0uUvHoDTgXFRXFjYszKX+COLupvtm4y
OfI=
=qNXv
-----END PGP SIGNATURE-----

--------------snwLW0G9wiDsfSdc8JHnJ38q--

