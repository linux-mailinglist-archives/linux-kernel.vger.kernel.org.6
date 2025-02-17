Return-Path: <linux-kernel+bounces-518179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB2A38B06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0AF1890D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE0235377;
	Mon, 17 Feb 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4rfgfD0"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2117DE2D;
	Mon, 17 Feb 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815257; cv=none; b=HVEWkea7PjoyPw5Ovw/TCzS0i8SXDildDITAUGW480B6ieG1qM+nIlygyURMBunLVr8uIoWKi2SqNwwSGP6XQrP7OO1H3Renf+prttHokavyocmgxpxOK+8JZ/pGasQ9ZfgAMOUq8VXp/0NHH37ahnoT88a+RDCKuqPsTdIgHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815257; c=relaxed/simple;
	bh=urcYf+hafSwujxQocfjP58SOOxk20cRlWKDTutBlg0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is+np5s7gTk3YWJWl5F4Qnrz35ZmDcZ2nvu5TLbN/p08Lfi1sIkg/v3ws5Qo/4for5I6GJ3xK7znd439Ul/vzG9UsUZDZI4TLAmB2Ewr2b1FMlv7Q5PyYmGlE2HjXoztNwAYKapRw5K5oLFevwoQMhRiWre/1XK69U2842mMV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4rfgfD0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so901142f8f.0;
        Mon, 17 Feb 2025 10:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739815253; x=1740420053; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urcYf+hafSwujxQocfjP58SOOxk20cRlWKDTutBlg0Q=;
        b=D4rfgfD03qqb+OTIjDJ46kueEHCs9bQjYPFZNQNtKAjMUvL0J7hxBcSLgEJ1gYM7AC
         SdDLwIBJAGWwYGeLOI5pmPLNee/te6Z4bX3HebybKl3tY7d5OWR+naDVRLnZs1AxyS+Y
         uvWXsj9+u3SAg1F1be1GGf3YzD4RMZQDbX4hQa/9FLDTNbzTK1qfC4GWNRiJw5g5rOdr
         eQO4F1eL/dSC89Vqe2CV60OLVpgnmCAaWkLTPt8XsQEzd9hegNTM6lbjYfpaPVdA5+/e
         Z7DhbCMHera+D9J4Or2aBNiTJhOg0CJ6WJe7Lp9WlTbFHoiWnn3BrL2zdMDeiGgHfeyC
         8Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815253; x=1740420053;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urcYf+hafSwujxQocfjP58SOOxk20cRlWKDTutBlg0Q=;
        b=Np6OelTAj48bZAFDSuhYa8NYUPHFkKMfLqlwe43Z8fhDvlecYAhmrveHjDL6tGQTSQ
         lnxBE0VLqxN1oJBUZoVj6NDUi9eqgxZcid8SUPS1Oyb+tbzVrLZiXFSHX6rR/ceBNR4A
         05sMujcgGTMt02tf4xnmnAylQq+XLWeH6XuVngTT9QF7xmReX8aNme3Ivs4UA9qpZp4X
         iXq4fAU2X/hBCKlgESOOhYvTAHTtSYYgCI7nz28ozUDCD7aJkMASwKzq2n/yMzC5/d4j
         /ALJiIrQeuZ5keEdnvkgshCyzzQ9y9RWF0OhMe939M0xavkVzAZ73cr5AX7O8SFjgWbb
         Adbw==
X-Forwarded-Encrypted: i=1; AJvYcCWmMGa80ubbffr1TSI2pInEvR7vTuzywEvxVBqgwhxh5PKtsGBdkT59uT319Uo6eBwWN2wCBQuGzP4SOV3mcYY=@vger.kernel.org, AJvYcCWy8+9p+WCZYqVzRVid3IsAw7W8FETFmZ+HS82bBZ5MH1hUJYd37oGVwWjU2ihzSIm48hb6MktNSZVMFSJV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hu6yNB1vCiRSblgNYwLCW44Dmw/hTOLV2Owb+yBrer1SvQAM
	t6OXKW8qxKYlUsqXU4Ogvc36KwVzYhX5lDBB6ZOHybdBU4s9ifRIdRW5XU3kra8=
X-Gm-Gg: ASbGncv0vJD5/f/XdkrVsOFFlcIegZyfSIug66Kb68298LtLJ292mgCW+f8WBk4BwJa
	9Y9jW8dMM9/RGBraqsIw3V5d9GmR1+ho9TW1xwaDAvDpPlc8hjuNfALZa6xkiUOoCO8/xkCV4Fy
	Vb0c44lizgupDqF154bNuYvPGetOgdHtmLgoehbvw4eTLCNVH5Y5MB79ksKiWzjGMpa1+S4Gl8Z
	nuJNIoGSKg7nZza5POXxv5dFTQ7CXAdSsg4zkdSXtpoFMSvheuV7i+QHm1/QACJIfc2QKrSm7Xl
	syQ5/6g9ijsIprh0VmWk474Y
X-Google-Smtp-Source: AGHT+IEKy7PHjdP1Xtu2uWDglEHkL3R6oPDj5HfbGE5QjmbWYxBg/VMyRIrdmKGardVNoj+ZT+B9ug==
X-Received: by 2002:a05:6000:178e:b0:38f:3d41:3cc5 with SMTP id ffacd0b85a97d-38f3d50a57amr6194565f8f.34.1739815252800;
        Mon, 17 Feb 2025 10:00:52 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm13011133f8f.99.2025.02.17.10.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 10:00:51 -0800 (PST)
Message-ID: <08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
Date: Mon, 17 Feb 2025 18:00:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217170934.457266-1-colin.i.king@gmail.com>
 <Z7N4tLUpRA1EKfDm@casper.infradead.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <Z7N4tLUpRA1EKfDm@casper.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HvOrC8O5fEDpUaM3RdEwoTdG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HvOrC8O5fEDpUaM3RdEwoTdG
Content-Type: multipart/mixed; boundary="------------aE8iuhC04tDDTVO3XQCrVkN5";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
References: <20250217170934.457266-1-colin.i.king@gmail.com>
 <Z7N4tLUpRA1EKfDm@casper.infradead.org>
In-Reply-To: <Z7N4tLUpRA1EKfDm@casper.infradead.org>

--------------aE8iuhC04tDDTVO3XQCrVkN5
Content-Type: multipart/mixed; boundary="------------s9T0GgcbOvV8orYz0dCRkZPr"

--------------s9T0GgcbOvV8orYz0dCRkZPr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Zk9uIDE3LzAyLzIwMjUgMTc6NTgsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBNb24s
IEZlYiAxNywgMjAyNSBhdCAwNTowOTozNFBNICswMDAwLCBDb2xpbiBJYW4gS2luZyB3cm90
ZToNCj4+IEFkZGluZyBhbiB1bmxpa2VseSgpIGhpbnQgb24gdGhlIG1hc2tlZCBzdGFydCBj
b21wYXJpc29uIGVycm9yDQo+PiByZXR1cm4gcGF0aCBpbXByb3ZlcyBydW4tdGltZSBwZXJm
b3JtYW5jZSBvZiB0aGUgbWluY29yZSBzeXN0ZW0gY2FsbC4NCj4+DQo+PiBCZW5jaG1hcmtp
bmcgb24gYW4gaTktMTI5MDAgc2hvd3MgYW4gaW1wcm92ZW1lbnQgb2YgN25zIG9uIG1pbmNv
cmUgY2FsbHMNCj4+IG9uIGEgMjU2S0IgbW1hcCdkIHJlZ2lvbiB3aGVyZSA1MCUgb2YgdGhl
IHBhZ2VzIHdlIHJlc2lkZW50Lg0KPj4NCj4+IFJlc3VsdHMgYmFzZWQgb24gcnVubmluZyAy
MCB0ZXN0cyB3aXRoIHR1cmJvIGRpc2FibGVkICh0byByZWR1Y2UNCj4+IGNsb2NrIGZyZXEg
dHVyYm8gY2hhbmdlcyksIHdpdGggMTAgc2Vjb25kIHJ1biBwZXIgdGVzdCBhbmQgY29tcGFy
aW5nDQo+PiB0aGUgbnVtYmVyIG9mIG1pbmNvcmVzIGNhbGxzIHBlciBzZWNvbmQuIFRoZSAl
IHN0YW5kYXJkIGRldmlhdGlvbiBvZg0KPj4gdGhlIDIwIHRlc3RzIHdhcyB+MC4xMCUsIHNv
IHJlc3VsdHMgYXJlIHJlbGlhYmxlLg0KPiANCj4gSSB0aGluayB5b3UndmUgZWxpZGVkIF9q
dXN0XyBlbm91Z2ggaW5mb3JtYXRpb24gaGVyZSB0aGF0IG5vYm9keSBjYW4NCj4ganVkZ2Ug
d2hldGhlciB5b3VyIHN0YXRzIHNraWxscyBhcmUgYW55IGdvb2QgOy0pICBZb3UndmUgdG9s
ZCB1cyA3bnMNCj4gKHBlciBjYWxsLCBwcmVzdW1hYmx5KSBhbmQgeW91J3ZlIHRvbGQgdXMg
MC4xMCUgc3RhbmRhcmQgZGV2aWF0aW9uLA0KPiBidXQgeW91IGhhdmVuJ3QgdG9sZCB1cyBo
b3cgbG9uZyB0aGUgc3lzY2FsbCB0YWtlcywgc28gbm9ib2R5IGNhbiB0ZWxsDQo+IHdoZXRo
ZXIgN25zIGlzIHdpdGhpbiAwLjEwJSBvciBub3QgOy0pDQoNClVnaCwgbXkgYmFkLg0KDQpJ
bXByb3ZlbWVudCB3YXMgZnJvbSB+OTcwIGRvd24gdG8gOTYzIG5zLCBzbyBzbWFsbCB+MC43
JSBpbXByb3ZlbWVudC4NCg0KQ29saW4NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KPj4gLS0tDQo+PiAgIG1tL21p
bmNvcmUuYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL21tL21pbmNvcmUuYyBiL21tL21p
bmNvcmUuYw0KPj4gaW5kZXggZDZiZDE5ZTUyMGZjLi44MzJmMjlmNDY3NjcgMTAwNjQ0DQo+
PiAtLS0gYS9tbS9taW5jb3JlLmMNCj4+ICsrKyBiL21tL21pbmNvcmUuYw0KPj4gQEAgLTIz
OSw3ICsyMzksNyBAQCBTWVNDQUxMX0RFRklORTMobWluY29yZSwgdW5zaWduZWQgbG9uZywg
c3RhcnQsIHNpemVfdCwgbGVuLA0KPj4gICAJc3RhcnQgPSB1bnRhZ2dlZF9hZGRyKHN0YXJ0
KTsNCj4+ICAgDQo+PiAgIAkvKiBDaGVjayB0aGUgc3RhcnQgYWRkcmVzczogbmVlZHMgdG8g
YmUgcGFnZS1hbGlnbmVkLi4gKi8NCj4+IC0JaWYgKHN0YXJ0ICYgflBBR0VfTUFTSykNCj4+
ICsJaWYgKHVubGlrZWx5KHN0YXJ0ICYgflBBR0VfTUFTSykpDQo+PiAgIAkJcmV0dXJuIC1F
SU5WQUw7DQo+IA0KPiBXZSBtaWdodCBnZXQgZXZlbiBtb3JlIGFkdmFudGFnZSBieSBtb3Zp
bmcgdGhlIEVJTlZBTCB0ZXN0IGJlZm9yZQ0KPiB1bnRhZ2dlZF9hZGRyKCkgc2luY2Ugd2Ug
a25vdyB0aGF0IHRoZSB0YWdzIGFyZSBhbGwgaW4gdGhlIGhpZ2ggYml0cyBhbmQNCj4gd2Ug
ZG9uJ3QgbmVlZCB0byBoYXZlIHRoZSB0ZXN0IGJlIGRlcGVuZGVudCBvbiB0aGUgcHJldmlv
dXMgYXJpdGhtZXRpYy4NCg0K
--------------s9T0GgcbOvV8orYz0dCRkZPr
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

--------------s9T0GgcbOvV8orYz0dCRkZPr--

--------------aE8iuhC04tDDTVO3XQCrVkN5--

--------------HvOrC8O5fEDpUaM3RdEwoTdG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmezeTcFAwAAAAAACgkQaMKH38aoAibX
mA/+LS932nbzl77mhIUZhT+c2BTBhl9f3Er8Wo7K0ahjR6R42Nu+mBFjhFFGaEsOl72D+yXV1eX5
wcqkElINwoEf6uiNf/M4ZUzRMtr57c9JqBzMKAdvP0nbu85uRIEO5M1ALw5qqAO/jqxsReG7+uV/
1iJ9BMfhraO221aUC+dANmzrekBimmdM4fGNkIxAnc5Ohv6thxYA4CY6CsSEi8CL5AVJf9rFiPtZ
0Diw8YjTM/FgB9AMGPSvxo5u8JowbNKDOvXUyVBDJjFUBrPJT/ec+k4AFrdSqEBZaRoevYMA+nt4
Ds+vd7QiHEaSWwbT+BihB664jhNm4B352rdcXBp0XSh5ro7knONoayBmUWbQjmsF4sF1lxSdZtzi
0ypS3Oal/lQ/RAmRWXeUJzMMUn0d4y5FaryDa/fvnzL1bImrMGIGK4eP1RBAjXrrc4tsqaXrywtR
0UI49t5JYjryzRI00lrvVc553ESChrzY+tMaqAoaUQtNGPwwxWxjfqjSG0fsc7d5qgfdc/JnRRLb
6ZyJaAqEFGRLUfrcx02U0HC3/rulLhmY8zg8K/MAsPbFIOXvGOjBuLE40hj9MxmBCJq8KEkBgZXK
ubD2EsbXqPEmphXnhHZagPD4xz2TQ6jgZgAyM6Ihe2nuYD4FPyuELFywYWUjcv/GHeiHE0p9uVbf
Pq4=
=U+uq
-----END PGP SIGNATURE-----

--------------HvOrC8O5fEDpUaM3RdEwoTdG--

