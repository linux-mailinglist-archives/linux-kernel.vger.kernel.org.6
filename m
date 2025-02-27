Return-Path: <linux-kernel+bounces-535949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D3A479AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56171885C54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E402229B05;
	Thu, 27 Feb 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixGhFSRH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D628F3;
	Thu, 27 Feb 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650377; cv=none; b=JkyVBPs9eJ9MDbKrFR7fG8V1HIHa2GZajjl2lKyC2ga1JqhI0QQsLs17dPJB5yN/7+eQfS3VkHG6wwkt1PHgK8RubBooHWuSxUw3Vs6wfuQTIUMhd9MhHPTH/PkImTO3Zcg2Qr7SVTpX1iht2wceJtpf3Pi7VnFRa4SACZ2xNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650377; c=relaxed/simple;
	bh=MHR4fuXyoKCUkeFjeQDlGS0UK2YdlcF+PrmkcV4l1ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/bNow2usB2cF9iyGKzJe2RhUyPy2+PV8XIuZgmCwgNoXmnpKUcPy/rCSO6uBD3Mng0MJsXWNQDMMf36pKOskeLJMf4XYfIIv24uRxGPl3OS99C+W+O49EE2m5zZvr5QR0QWJpChqX412JW5FP8JAAKmvjNxqYlTZuCRx8Tr2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixGhFSRH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394036c0efso4487575e9.2;
        Thu, 27 Feb 2025 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740650374; x=1741255174; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHR4fuXyoKCUkeFjeQDlGS0UK2YdlcF+PrmkcV4l1ck=;
        b=ixGhFSRHMUuN623XhEpM0Zat3VHck+btGEjEgns3Ywye1VTrGYPOzTCXqiTD8YoyhU
         p58n5N9Cw7W2dzF+g/vfv5dY/1RGaqdMPaBfORyJtqMpcbZBbj/b03GH5MUzUq3lDB23
         SQTgZWa6/SYxhijYVrUUeJHOOMYcomjnMjHpjNNf5x+YY2ZS2AiLx+XJ9NX9Ojdc+d0f
         LjObqe3bFXY+NM04ailAZt4jtP36As+vAG22fLhmNQBXDmXM82TPhWPOqLJ0nFxleQJX
         PWIkEEx/eykpH25LBsw+iq5pwx0rhWkiImXDO/2Ujz3ciIvxPtX+NJxS4HNJV3A2bC08
         NkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650374; x=1741255174;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHR4fuXyoKCUkeFjeQDlGS0UK2YdlcF+PrmkcV4l1ck=;
        b=UwZhu6+49upqct181GL/39FcDyQ0IWFHRgMgYB6hZErUVVbIc6lDW13Ghq4SfuYnOt
         ITIii+G/daY6LTkpSiQaq4rlkltMqHnHJB4xiyEz98D4pUuUletiTmi5Mc5KjRpYZWqB
         DM4SOKejRUzmYyKTbGOlpJqDtY3PfsNfUpP5C1lSBFsTlMcySIBsmFjqN6WVzK8kwj7w
         fghTTv3FheVAdL1L93NKkYDg+9bL0ExKcVVAlr7o09XoC973eWukyx03u9FMLiAbHAZG
         v5K53w6kgBFW/Y5E6+5ee9Pmvi39Kic0Rmqwb1/4UV2RERwzkg6ruZV3SOD9cEljvXiX
         stbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVofhggtlYeO+bNF6X3xzr6eu7bKqO5Esd1AaUtcnpx2BsZ1vSUG7G/ZeqbdMMn6zBOw7/bXwa5Xn7FLXKggro=@vger.kernel.org, AJvYcCXcHYwn0HIOqI5oDMSXMZjuzwiboSR2c6zEPv2SWulm7mM7wkBa9nFlfcHNq+xi5x0Q9xNS/+RUblleHRSu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJc+f/sbEpD4NTSGOHsFGrh5DvzMb5MO9D0umN5tbXo5CAMFvM
	LtS3b0jiDryCaGIc9ibXETyDffF61ih2DSPJELU4c6IALd/hlIRb
X-Gm-Gg: ASbGncudKU8XBPpq5ue0Ezf23lXM+4zxNSnfJ8WQixYGZE1YBOYro6VnQglF8aZVZq8
	aqQ4XmhXelHaKomQIt1jZJSF9EzrNBx1X/6pKyyn1A/GNJiJIswQkmenREXk5ymVOgWdaGHdZiY
	OaIzIpztpHD7XWB4v6x18DwtnxRtWsI04rQpbuZpK6EVQe2OzkfI3xZ2tOGIwpBUIho/UOuWTqd
	mWQwiiB6qpOM2MDMIIZVKSfC6mzrZ/ONMKfJ6co2BxrD3oqTF71gBhSL6OP2qBYE+FW89IGHyh2
	sYH0kmXo255eoF6GibiTrqn4A3XsT+ii6zU=
X-Google-Smtp-Source: AGHT+IFVFv8NYAALc9CIl1jxZwjixFpdc+qljJ4m4OsKVPyGk7x/awYsaNwyvEWE9bpQSppPJyck6w==
X-Received: by 2002:a05:600c:3c86:b0:439:9377:fa29 with SMTP id 5b1f17b1804b1-43ab903fe5bmr57463235e9.31.1740650374057;
        Thu, 27 Feb 2025 01:59:34 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.72])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43b736f990esm17803285e9.5.2025.02.27.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 01:59:33 -0800 (PST)
Message-ID: <ce34b982-490e-44dc-8071-c04d4fbcb0f1@gmail.com>
Date: Thu, 27 Feb 2025 09:58:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] scripts/sorttable: Fix resource leak on file
 pointer fp
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226224934.594983-1-colin.i.king@gmail.com>
 <a7857c72-89ec-406b-8d66-d9e95657a6e0@stanley.mountain>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <a7857c72-89ec-406b-8d66-d9e95657a6e0@stanley.mountain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------929dJ8BblS5EM9glAnFcua3l"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------929dJ8BblS5EM9glAnFcua3l
Content-Type: multipart/mixed; boundary="------------XnPYCH0kDlHqLqEkisD3GV05";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <ce34b982-490e-44dc-8071-c04d4fbcb0f1@gmail.com>
Subject: Re: [PATCH][next] scripts/sorttable: Fix resource leak on file
 pointer fp
References: <20250226224934.594983-1-colin.i.king@gmail.com>
 <a7857c72-89ec-406b-8d66-d9e95657a6e0@stanley.mountain>
In-Reply-To: <a7857c72-89ec-406b-8d66-d9e95657a6e0@stanley.mountain>

--------------XnPYCH0kDlHqLqEkisD3GV05
Content-Type: multipart/mixed; boundary="------------Sg2jfgOFVE2YsVwe0drjx0tt"

--------------Sg2jfgOFVE2YsVwe0drjx0tt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMDIvMjAyNSAwOTo1NywgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gT24gV2VkLCBG
ZWIgMjYsIDIwMjUgYXQgMTA6NDk6MzRQTSArMDAwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6
DQo+PiBUaGVyZSBpcyBhIHJlc291cmNlIGxlYWsgb24gZnAgb24gYW4gZXJyb3IgcmV0dXJu
IHBhdGggaW4gZnVuY3Rpb24NCj4+IHBhcnNlX3N5bWJvbHMgdGhhdCBjYXVzZXMgYSByZXNv
dXJjZSBsZWFrLiBGaXggdGhpcyBieSBhZGRpbmcgaW4NCj4+IHRoZSBtaXNzaW5nIGZjbG9z
ZS4NCj4+DQo+PiBGaXhlczogZWYzNzhjM2I4MjMzICgic2NyaXB0cy9zb3J0dGFibGU6IFpl
cm8gb3V0IHdlYWsgZnVuY3Rpb25zIGluIG1jb3VudF9sb2MgdGFibGUiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IA0K
PiBUaGlzIGlzIGluIHNjcmlwdHMvIHNvIGl0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4gIFdl
J3JlIGdvaW5nIHRvIGV4aXQNCj4gYW5kIHJlbGVhc2UgZXZlcnl0aGluZyBpbW1lZGlhdGVs
eSBlaXRoZXIgd2F5Lg0KDQpBY2suIFdvbid0IGZpeCB0aGVzZSBpc3N1ZXMgaW4gc2NyaXB0
cyBpbiBmdXR1cmUuDQoNCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCj4gDQoN
Cg==
--------------Sg2jfgOFVE2YsVwe0drjx0tt
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

--------------Sg2jfgOFVE2YsVwe0drjx0tt--

--------------XnPYCH0kDlHqLqEkisD3GV05--

--------------929dJ8BblS5EM9glAnFcua3l
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmfAN2IFAwAAAAAACgkQaMKH38aoAiZU
Bg/+JHLWihnkpWHvA8obA8AkcLeLYr/PtHbvjuPhOBIlFC75eLnNFQ8HB61nB9bv+mgaPOFLvPVl
TeXQ6afZYAie2nY5+jZpetoJ4UhcjNt6We7zfyM8KonSP8G/B+nwRn+ZR+hsyxiiwNnAlqeaWICY
rs8nH3Ltwp4mzJkDsv7RDpA8ARAvIAAG7MzHSd8nDkCoJ19XN1cazVtg9MBHuLQHbwz7472MICaf
RNx2O6JLT3+Hdbq5OdUhW6sc7hOW5S+LVHVIMizhkzy/rTjbLAhMaNZecpJ3EUnAUGQbFf+VZQm6
z95gr+/BBVTb+F4p0I3UMrm+3ceCPCaTiqlj8kDCX3H+zmX0iZbfHsriOM+sHLabx+x+G6Vjzuzv
/u9/h6V/e8EJ0EfaJHJCWG9TDPoXc2Wjr8X11ijUA1eCwCZk12IVNVPX59MlROcJSNhu6QAYvQ5G
S9JeQ8d8VFmrCEZJL1NIG1DE+A0kcQLvqyjTblJbcQUf1lSktp5Hf6R2WF+fxo/xbsRcjg1VtgFY
lDbf+9a/lTSqbbhsP6lnEAlzK8pKk8879Hk0rY8pWYJa5su+gWihuiwrdWWk4Sr3yVs7lpUxswUz
7yqVNaYmqDkD75obmpZx2pKMcmrQ5eRnLaLrWRLcxl1N0z1Jh79UHzvAYZ96cHc8rkXOy0KRc3/R
LzU=
=wzp5
-----END PGP SIGNATURE-----

--------------929dJ8BblS5EM9glAnFcua3l--

