Return-Path: <linux-kernel+bounces-411980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C189D01F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1165B22E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7511185;
	Sun, 17 Nov 2024 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr8xe93i"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E2F4ED
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731815110; cv=none; b=AG44WYkiJFjnLWyZLKr2ORs85HKQN+LwxogA7V8P/s+U5+T3YBiop5NC/mWoBbvFAzGUPcouKjz67dLvUvShdi04f4HCFgF74Lm/BFS3D1KpdtwaJHamc5Dl5DAJx9m/JASg3hr58LmKpL3PkX4vZ+g3EsN5FM9GF38ZGJ4JWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731815110; c=relaxed/simple;
	bh=TL3G7tjTicGdMHd/A0F2GrypgDVRQwHM+dHZn+wZ/8Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JvVToQOeWTL3ADqTD652LIcBm/KsUuA7OT+g950SskMBZbaUE20VYok+7mwQI4G9AxzlhLaV1ehJAMJW6eqD+Wql+bVN4V+GoVDz5aZEl3jTPt++SIjhtJ8PBXVEw1spGC3sL1upczJD8kcD+FYLwavz+wMNCwtlQY5Y8aF1Vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr8xe93i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382376fcc4fso418714f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731815106; x=1732419906; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TL3G7tjTicGdMHd/A0F2GrypgDVRQwHM+dHZn+wZ/8Q=;
        b=hr8xe93iYB8963jcvdvAv273aoZ+psrDCFvOrAOAkg6xuUvUl85eLxFeK0dMsXlHtP
         PCHbeyQGT5tyiPJZECO+4nkjlzANyHopUvonAtEaxO2vtlMjHqmvzCCR2vcPAs9ipA0r
         +ia+mt4Qc+Kh1Ua3HvQGYiYZl5qfQNKy9yQfVIOENPstkIB974zh85sKw7I3I/L0B+bL
         HToy1pezeabUhbuB4xXX7jxXxyYaibJsU709LWvdZJywqYsTKqd1Kz3qXosatadIf4b5
         IS68dW26AQAc0djTT2WgaS9R4v8XEilMKGtDmfs5SRg/9yvaBpvdyyuAwMlnzrMVP0XI
         tv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731815106; x=1732419906;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL3G7tjTicGdMHd/A0F2GrypgDVRQwHM+dHZn+wZ/8Q=;
        b=EI9cWSzB8+ij1CpNpzusUbawACeRnVii4FUmBFSEugW1+s5TxxLpYtGWDVQXeTYyT5
         zXrFZe6vncbgjnpHeFgoRu2s445+L7ymVC/eNWvgEsVJqVdbnTtrRjmcB2e2URQl6cxn
         ObMapuzwO5pd/37CIBJrIkMhEOoGt7CsGHzEUPreD1b9sHyRniOK2hwECGhRc2mneT38
         ebe8QAssp25KmwGSpTwnZRUrMLj5aIpKiF2X31ll5kfz2jcvLQuNtX3ZkHlJZ/R83y8s
         OoRgmHnY5vkN6w+7ENvyUk15+Qc6rqZSSWACwCWTprTskKVZIR8RZKEkHh5oidtY7Apm
         RlAg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQJZ5es7/auvSs7XEgOqZ4V4kzPmDLPEbR5Z8XlhK8oBZ/RmkP5GdHMm165Hc6P97Guu6Zlk9wMzb4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDHysch2EGljItzHQxrVR+rji+FA+PtwCnMK9zkTgjR/rxsYA
	Kg56odjBBanLwh2ujCKp6auPiKzfY6cx/+ObCJVrTz7ENvFvMTBk
X-Google-Smtp-Source: AGHT+IEjbL5U1WgRsAJhyMwl7tHBccvdcqRa0UXTqHAl9hV5Yt2QGY1JueOB76pZitwVzsmS7yVYnQ==
X-Received: by 2002:a05:6000:1866:b0:382:51f:6371 with SMTP id ffacd0b85a97d-3822590480dmr6013784f8f.15.1731815106093;
        Sat, 16 Nov 2024 19:45:06 -0800 (PST)
Received: from [10.137.0.17] (89-39-107-195.hosted-by-worldstream.net. [89.39.107.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823e5f7429sm1699996f8f.93.2024.11.16.19.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 19:45:04 -0800 (PST)
Message-ID: <d0bf2d2a-0cdd-40a7-8be6-74d60a42ea90@gmail.com>
Date: Sun, 17 Nov 2024 09:14:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernelnewbies@kernelnewbies.org, kherbst@redhat.com, lyude@redhat.com,
 dakr@redhat.com, airlied@gmail.com, daniel@ffwll.ch, airlied@redhat.com,
 ttabi@nvidia.com, kees@kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Krishna Deshpande <krishna.desh2@gmail.com>
Subject: Bug: Nouveau failed to boot on 6.11
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1eHw8hWuh7ikVg0ocyw8U4An"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1eHw8hWuh7ikVg0ocyw8U4An
Content-Type: multipart/mixed; boundary="------------Gz4TdCjmqEDxTKWq6UIoERcw";
 protected-headers="v1"
From: Krishna Deshpande <krishna.desh2@gmail.com>
To: kernelnewbies@kernelnewbies.org, kherbst@redhat.com, lyude@redhat.com,
 dakr@redhat.com, airlied@gmail.com, daniel@ffwll.ch, airlied@redhat.com,
 ttabi@nvidia.com, kees@kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <d0bf2d2a-0cdd-40a7-8be6-74d60a42ea90@gmail.com>
Subject: Bug: Nouveau failed to boot on 6.11

--------------Gz4TdCjmqEDxTKWq6UIoERcw
Content-Type: multipart/mixed; boundary="------------43eaLh8sEs4bfDFRrIL9lJJ8"

--------------43eaLh8sEs4bfDFRrIL9lJJ8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQWxsLA0KDQoNCkknbSBnZXR0aW5nIHRoaXMgZXJyb3Igb24gdjYuMTEgZnJvbSBMaW51
cycgdHJlZS4gQW55IGhlbHAgd291bGQgYmUgDQphcHByZWNpYXRlZC4NCg0KDQpbwqDCoMKg
IDUuMjc3NzA5XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogc2VjMihnc3ApOiBtYm94IDAwMDAw
MDBiIDAwMDAwMDBmDQpbwqDCoMKgIDUuMjc3NzEyXSBub3V2ZWF1IDAwMDA6MDE6MDAuMDog
c2VjMihnc3ApOmJvb3Rlci1sb2FkOiBib290IGZhaWxlZDogLTUNClvCoMKgwqAgNS4yNzc3
MjhdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KW8KgwqDCoCA1LjI3
NzcyOV0gV0FSTklORzogQ1BVOiA2IFBJRDogNTMzIGF0IA0KZHJpdmVycy9ncHUvZHJtL25v
dXZlYXUvbnZrbS9zdWJkZXYvZ3NwL3I1MzUuYzoyNDA5IA0KcjUzNV9nc3BfaW5pdCsweDhj
LzB4YmQwIFtub3V2ZWF1XQ0KW8KgwqDCoCA1LjI3Nzg1OF0gTW9kdWxlcyBsaW5rZWQgaW46
IG52bWUgbnZtZV9jb3JlIG52bWVfYXV0aCBpOTE1KCspIA0Kbm91dmVhdSgrKSBjcmN0MTBk
aWZfcGNsbXVsIGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgcG9seXZhbF9jbG11bG5pIA0K
cG9seXZhbF9nZW5lcmljIG14bV93bWkgZHJtX3R0bV9oZWxwZXIgZ3B1X3NjaGVkIGRybV9n
cHV2bSBkcm1fZXhlYyANCmRybV9idWRkeSBpMmNfYWxnb19iaXQgZ2hhc2hfY2xtdWxuaV9p
bnRlbCB0dG0gc2hhNTEyX3Nzc2UzIA0KZHJtX2Rpc3BsYXlfaGVscGVyIHhoY2lfcGNpIHNo
YTI1Nl9zc3NlMyB4aGNpX3BjaV9yZW5lc2FzIGhpZF9tdWx0aXRvdWNoIA0Kc2hhMV9zc3Nl
MyBzZXJpb19yYXcgeGhjaV9oY2Qgdm1kIGNlYyBpMmNfaGlkX2FjcGkgaTJjX2hpZCB2aWRl
byB3bWkgDQpwaW5jdHJsX3RpZ2VybGFrZSB4ZW5fYWNwaV9wcm9jZXNzb3IgeGVuX3ByaXZj
bWQgeGVuX3BjaWJhY2sgeGVuX2Jsa2JhY2sgDQp4ZW5fZ250YWxsb2MgeGVuX2dudGRldiB4
ZW5fZXZ0Y2huIHNjc2lfZGhfcmRhYyBzY3NpX2RoX2VtYyBzY3NpX2RoX2FsdWEgDQp1aW5w
dXQgZG1fbXVsdGlwYXRoDQpbwqDCoMKgIDUuMjc3ODgwXSBDUFU6IDYgVUlEOiAwIFBJRDog
NTMzIENvbW06ICh1ZGV2LXdvcmtlcikgTm90IHRhaW50ZWQgDQo2LjExLjAtdGVzdC0xLnF1
YmVzLmZjMzcueDg2XzY0KyAjMTMNClvCoMKgwqAgNS4yNzc4ODJdIEhhcmR3YXJlIG5hbWU6
IE1pY3JvLVN0YXIgSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4gUHVsc2UgDQpHTDY2IDExVUdL
L01TLTE1ODEsIEJJT1MgRTE1ODFJTVMuMzEzIDA3LzA2LzIwMjMNClvCoMKgwqAgNS4yNzc4
ODNdIFJJUDogZTAzMDpyNTM1X2dzcF9pbml0KzB4OGMvMHhiZDAgW25vdXZlYXVdDQpbwqDC
oMKgIDUuMjc3OTcyXSBDb2RlOiAyNCA0MCA0OCA4ZCA0YyAyNCAzYyA0OCA4OSBlZSA2YSAw
MCA0OSA4ZCBiZCBiMCAwNCANCjAwIDAwIDRjIDhkIDQ0IDI0IDQ4IGU4IDkxIGUyIGZhIGZm
IDQxIDU4IDg1IGMwIDQxIDg5IGM2IDBmIDg0IDkzIDAwIDAwIA0KMDAgPDBmPiAwYiA0OSA4
MyBiZCBjMCAwNyAwMCAwMCAwMCA3NSAzMiA0OCA4YiA0NCAyNCA0OCA2NSA0OCAyYiAwNCAy
NQ0KW8KgwqDCoCA1LjI3Nzk3M10gUlNQOiBlMDJiOmZmZmZjOTAwNDExODc2NTAgRUZMQUdT
OiAwMDAxMDI4Mg0KW8KgwqDCoCA1LjI3Nzk3NV0gUkFYOiAwMDAwMDAwMGZmZmZmZmZiIFJC
WDogZmZmZjg4ODExMjA1NTAwOCBSQ1g6IA0KMDAwMDAwMDAwMDAwMDAyNw0KW8KgwqDCoCA1
LjI3Nzk3Nl0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZjg4ODExMjA1NTAwOCBS
REk6IA0KZmZmZjg4ODEwMWY5NzhlOA0KW8KgwqDCoCA1LjI3Nzk3N10gUkJQOiBmZmZmODg4
MTEyMDU1MDA4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IA0KMDAwMDAwMDA4MmY1MGEw
MA0KW8KgwqDCoCA1LjI3Nzk3OF0gUjEwOiBmZmZmZmZmZjgxY2ZjODE5IFIxMTogMDAwMDAw
MDAwMDAwMDAwMCBSMTI6IA0KZmZmZjg4ODExMjA1NTA0MA0KW8KgwqDCoCA1LjI3Nzk3OF0g
UjEzOiBmZmZmODg4MTEyMDU1MDAwIFIxNDogMDAwMDAwMDBmZmZmZmZmYiBSMTU6IA0KZmZm
Zjg4ODExMjA1NTAwOA0KW8KgwqDCoCA1LjI3Nzk4NV0gRlM6wqAgMDAwMDdkMDllYmM5MzBj
MCgwMDAwKSBHUzpmZmZmODg4MTkyNTAwMDAwKDAwMDApIA0Ka25sR1M6MDAwMDAwMDAwMDAw
MDAwMA0KW8KgwqDCoCA1LjI3Nzk4Nl0gQ1M6wqAgZTAzMCBEUzogMDAwMCBFUzogMDAwMCBD
UjA6IDAwMDAwMDAwODAwNTAwMzMNClvCoMKgwqAgNS4yNzc5ODddIENSMjogMDAwMDc5ODJj
YWY4ODk0MiBDUjM6IDAwMDAwMDAxMGU2NTYwMDAgQ1I0OiANCjAwMDAwMDAwMDAwNTA2NjAN
ClvCoMKgwqAgNS4yNzc5OTJdIENhbGwgVHJhY2U6DQpbwqDCoMKgIDUuMjc3OTk0XcKgIDxU
QVNLPg0KW8KgwqDCoCA1LjI3Nzk5NV3CoCA/IHI1MzVfZ3NwX2luaXQrMHg4Yy8weGJkMCBb
bm91dmVhdV0NClvCoMKgwqAgNS4yNzgwNzhdwqAgPyBfX3dhcm4uY29sZCsweDhlLzB4ZTgN
ClvCoMKgwqAgNS4yNzgwODFdwqAgPyByNTM1X2dzcF9pbml0KzB4OGMvMHhiZDAgW25vdXZl
YXVdDQpbwqDCoMKgIDUuMjc4MTYwXcKgID8gcmVwb3J0X2J1ZysweGZmLzB4MTQwDQpbwqDC
oMKgIDUuMjc4MTYzXcKgID8gaGFuZGxlX2J1ZysweDNjLzB4ODANClvCoMKgwqAgNS4yNzgx
NjVdwqAgPyBleGNfaW52YWxpZF9vcCsweDE3LzB4NzANClvCoMKgwqAgNS4yNzgxNjZdwqAg
PyBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwDQpbwqDCoMKgIDUuMjc4MTY5XcKgID8g
cjUzNV9nc3BfaW5pdCsweDhjLzB4YmQwIFtub3V2ZWF1XQ0KW8KgwqDCoCA1LjI3ODI0Nl3C
oCBudmttX3N1YmRldl9pbml0XysweDQ5LzB4OTAgW25vdXZlYXVdDQpbwqDCoMKgIDUuMjc4
MzI0XcKgID8gbnZrbV9pbnRyX3JlYXJtKzB4YzQvMHgxYzAgW25vdXZlYXVdDQpbwqDCoMKg
IDUuMjc4Mzk3XcKgIG52a21fc3ViZGV2X2luaXQrMHg0OC8weDYwIFtub3V2ZWF1XQ0KW8Kg
wqDCoCA1LjI3ODQ3MF3CoCBudmttX2RldmljZV9pbml0KzB4MTZiLzB4MWYwIFtub3V2ZWF1
XQ0KW8KgwqDCoCA1LjI3ODU4MF3CoCBudmttX3VkZXZpY2VfaW5pdCsweDQ3LzB4NzAgW25v
dXZlYXVdDQpbwqDCoMKgIDUuMjc4NjkwXcKgIG52a21fb2JqZWN0X2luaXQrMHgzZS8weDEy
MCBbbm91dmVhdV0NClvCoMKgwqAgNS4yNzg3NjhdwqAgbnZrbV9pb2N0bF9uZXcrMHgxODMv
MHgyNTAgW25vdXZlYXVdDQpbwqDCoMKgIDUuMjc4ODQzXcKgID8gX19wZnhfbnZrbV9jbGll
bnRfY2hpbGRfbmV3KzB4MTAvMHgxMCBbbm91dmVhdV0NClvCoMKgwqAgNS4yNzg5MTRdwqAg
PyBfX3BmeF9udmttX3VkZXZpY2VfbmV3KzB4MTAvMHgxMCBbbm91dmVhdV0NClvCoMKgwqAg
NS4yNzkwMTNdwqAgbnZrbV9pb2N0bCsweGU0LzB4MWUwIFtub3V2ZWF1XQ0KW8KgwqDCoCA1
LjI3OTA4NF3CoCBudmlmX29iamVjdF9jdG9yKzB4MTM0LzB4MWIwIFtub3V2ZWF1XQ0KW8Kg
wqDCoCA1LjI3OTE1NV3CoCBudmlmX2RldmljZV9jdG9yKzB4MjMvMHg3MCBbbm91dmVhdV0N
ClvCoMKgwqAgNS4yNzkyMjRdwqAgbm91dmVhdV9jbGlfaW5pdCsweDE2NC8weDU3MCBbbm91
dmVhdV0NClvCoMKgwqAgNS4yNzkzMzBdwqAgPyBfX2ttYWxsb2NfY2FjaGVfbm9wcm9mKzB4
MTQyLzB4MzAwDQpbwqDCoMKgIDUuMjc5MzMzXcKgIG5vdXZlYXVfZHJtX2RldmljZV9pbml0
KzB4YjcvMHg4OTAgW25vdXZlYXVdDQpbwqDCoMKgIDUuMjc5NDMwXcKgID8gcGNpX3VwZGF0
ZV9jdXJyZW50X3N0YXRlKzB4NzAvMHhhMA0KW8KgwqDCoCA1LjI3OTQzMl3CoCBub3V2ZWF1
X2RybV9wcm9iZSsweDEyOS8weDIyMCBbbm91dmVhdV0NClvCoMKgwqAgNS4yNzk1MjFdwqAg
PyBycG1fcmVzdW1lKzB4MzAyLzB4NmUwDQpbwqDCoMKgIDUuMjc5NTI0XcKgIGxvY2FsX3Bj
aV9wcm9iZSsweDQyLzB4OTANClvCoMKgwqAgNS4yNzk1MjZdwqAgcGNpX2RldmljZV9wcm9i
ZSsweGMxLzB4MmEwDQpbwqDCoMKgIDUuMjc5NTI4XcKgIHJlYWxseV9wcm9iZSsweGRiLzB4
MzQwDQpbwqDCoMKgIDUuMjc5NTMwXcKgID8gcG1fcnVudGltZV9iYXJyaWVyKzB4NTQvMHg5
MA0KW8KgwqDCoCA1LjI3OTUzMl3CoCA/IF9fcGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4
MTANClvCoMKgwqAgNS4yNzk1MzRdwqAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzgvMHgx
MTANClvCoMKgwqAgNS4yNzk1MzZdwqAgZHJpdmVyX3Byb2JlX2RldmljZSsweDFmLzB4YTAN
ClvCoMKgwqAgNS4yNzk1MzhdwqAgX19kcml2ZXJfYXR0YWNoKzB4YmEvMHgxYzANClvCoMKg
wqAgNS4yNzk1NDFdwqAgYnVzX2Zvcl9lYWNoX2RldisweDhjLzB4ZTANClvCoMKgwqAgNS4y
Nzk1NDNdwqAgYnVzX2FkZF9kcml2ZXIrMHgxMzQvMHgyMjANClvCoMKgwqAgNS4yNzk1NDVd
wqAgZHJpdmVyX3JlZ2lzdGVyKzB4NzIvMHhkMA0KW8KgwqDCoCA1LjI3OTU0Nl3CoCA/IF9f
cGZ4X25vdXZlYXVfZHJtX2luaXQrMHgxMC8weDEwIFtub3V2ZWF1XQ0KW8KgwqDCoCA1LjI3
OTYyMl3CoCBkb19vbmVfaW5pdGNhbGwrMHg1OC8weDJmMA0KW8KgwqDCoCA1LjI3OTYyNl3C
oCBkb19pbml0X21vZHVsZSsweDgyLzB4MjQwDQpbwqDCoMKgIDUuMjc5NjI4XcKgIGluaXRf
bW9kdWxlX2Zyb21fZmlsZSsweDg2LzB4YzANClvCoMKgwqAgNS4yNzk2MzBdwqAgaWRlbXBv
dGVudF9pbml0X21vZHVsZSsweDEyMS8weDMyMA0KW8KgwqDCoCA1LjI3OTYzM13CoCBfX3g2
NF9zeXNfZmluaXRfbW9kdWxlKzB4NWUvMHhiMA0KW8KgwqDCoCA1LjI3OTYzNF3CoCBkb19z
eXNjYWxsXzY0KzB4ODIvMHgxNjANClvCoMKgwqAgNS4yNzk2MzddwqAgPyBfX2RvX3N5c19u
ZXdmc3RhdGF0KzB4NGIvMHg4MA0KW8KgwqDCoCA1LjI3OTYzOV3CoCA/IHN5c2NhbGxfZXhp
dF90b191c2VyX21vZGVfcHJlcGFyZSsweDE0OS8weDE3MA0KW8KgwqDCoCA1LjI3OTY0Ml3C
oCA/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHgxNS8weDIyMA0KW8KgwqDCoCA1LjI3
OTY0NF3CoCA/IGRvX3N5c2NhbGxfNjQrMHg4ZS8weDE2MA0KW8KgwqDCoCA1LjI3OTY0NV3C
oCA/IGRvX3N5c2NhbGxfNjQrMHg4ZS8weDE2MA0KW8KgwqDCoCA1LjI3OTY0N13CoCA/IGRv
X3N5c2NhbGxfNjQrMHg4ZS8weDE2MA0KW8KgwqDCoCA1LjI3OTY0OF3CoCA/IGRvX3N5c2Nh
bGxfNjQrMHg4ZS8weDE2MA0KW8KgwqDCoCA1LjI3OTY1MF3CoCA/IGNsZWFyX2JoYl9sb29w
KzB4MjUvMHg4MA0KW8KgwqDCoCA1LjI3OTY1Ml3CoCA/IGNsZWFyX2JoYl9sb29wKzB4MjUv
MHg4MA0KW8KgwqDCoCA1LjI3OTY1NF3CoCA/IGNsZWFyX2JoYl9sb29wKzB4MjUvMHg4MA0K
W8KgwqDCoCA1LjI3OTY1Nl3CoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3
Ni8weDdlDQpbwqDCoMKgIDUuMjc5NjU4XSBSSVA6IDAwMzM6MHg3ZDA5ZWM3NWI5Y2QNClvC
oMKgwqAgNS4yNzk2NjBdIENvZGU6IDVkIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAw
IDAwIDkwIGYzIDBmIDFlIGZhIA0KNDggODkgZjggNDggODkgZjcgNDggODkgZDYgNDggODkg
Y2EgNGQgODkgYzIgNGQgODkgYzggNGMgOGIgNGMgMjQgMDggMGYgDQowNSA8NDg+IDNkIDAx
IGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIDMzIGU0IDBjIDAwIGY3IGQ4IDY0IDg5IDAx
IDQ4DQpbwqDCoMKgIDUuMjc5NjYxXSBSU1A6IDAwMmI6MDAwMDdmZmU0NGZjM2FkOCBFRkxB
R1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiANCjAwMDAwMDAwMDAwMDAxMzkNClvCoMKgwqAgNS4y
Nzk2NjJdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA2MGM0ZGY5MjYzYjAgUkNY
OiANCjAwMDA3ZDA5ZWM3NWI5Y2QNClvCoMKgwqAgNS4yNzk2NjNdIFJEWDogMDAwMDAwMDAw
MDAwMDAwMCBSU0k6IDAwMDA3ZDA5ZWM4YTM0NTMgUkRJOiANCjAwMDAwMDAwMDAwMDAwMTQN
ClvCoMKgwqAgNS4yNzk2NjRdIFJCUDogMDAwMDdkMDllYzhhMzQ1MyBSMDg6IDAwMDAwMDAw
MDAwMDAwMDAgUjA5OiANCjAwMDA3ZmZlNDRmYzNjMDANClvCoMKgwqAgNS4yNzk2NjVdIFIx
MDogMDAwMDAwMDAwMDAwMDAxNCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiANCjAwMDAw
MDAwMDAwMjAwMDANClvCoMKgwqAgNS4yNzk2NjZdIFIxMzogMDAwMDYwYzRkZjkyNjlmMCBS
MTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiANCjAwMDA2MGM0ZGY5MmE1ODANClvCoMKgwqAg
NS4yNzk2NjddwqAgPC9UQVNLPg0KW8KgwqDCoCA1LjI3OTY2N10gLS0tWyBlbmQgdHJhY2Ug
MDAwMDAwMDAwMDAwMDAwMCBdLS0tDQpbwqDCoMKgIDUuMjc5NjcwXSBub3V2ZWF1IDAwMDA6
MDE6MDAuMDogZ3NwOiBpbml0IGZhaWxlZCwgLTUNClvCoMKgwqAgNS4yNzk2ODNdIG5vdXZl
YXUgMDAwMDowMTowMC4wOiBpbml0IGZhaWxlZCB3aXRoIC01DQpbwqDCoMKgIDUuMjc5Njg1
XSBub3V2ZWF1OiBEUk0tbWFzdGVyOjAwMDAwMDAwOjAwMDAwMDgwOiBpbml0IGZhaWxlZCB3
aXRoIC01DQpbwqDCoMKgIDUuMjc5Njg4XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogRFJNLW1h
c3RlcjogRGV2aWNlIGFsbG9jYXRpb24gDQpmYWlsZWQ6IC01DQpbwqDCoMKgIDUuMjk2MzY4
XSBub3V2ZWF1IDAwMDA6MDE6MDAuMDogcHJvYmUgd2l0aCBkcml2ZXIgbm91dmVhdSBmYWls
ZWQgDQp3aXRoIGVycm9yIC01DQoNCg0KVGhhbmtzLA0KDQpLcmlzaG5hDQoNCg==
--------------43eaLh8sEs4bfDFRrIL9lJJ8
Content-Type: application/pgp-keys; name="OpenPGP_0xCF412C4448F859FE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xCF412C4448F859FE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZzlYsRYJKwYBBAHaRw8BAQdAIA8Li6YvI1sW0IZqYoARlmSGCnIXz6RV5+YP
g583G6HNK0tyaXNobmEgRGVzaHBhbmRlIDxrcmlzaG5hLmRlc2gyQGdtYWlsLmNv
bT7CmQQTFgoAQRYhBE5gcXZcGFv0v08NIs9BLERI+Fn+BQJnOVixAhsDBQkJZgGA
BQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEM9BLERI+Fn+GDUBAK4q5xCV
ViOnCnd3nFdp6g0x49ULCvfmO+UuTbCQXv9eAQDdERtdLwvD5Za+zTLLRs4EMKjV
KBDEIj74cbG2dCc8Bs44BGc5WLESCisGAQQBl1UBBQEBB0BfrlfInVdEWu+Lpv8h
+VFLYmVP3NtnK/8b39KExm2vfQMBCAfCfgQYFgoAJhYhBE5gcXZcGFv0v08NIs9B
LERI+Fn+BQJnOVixAhsMBQkJZgGAAAoJEM9BLERI+Fn+WG8BAMx/ogri2dPHTR7l
hqeVTXljHFhxds+WLJweHlW/Dzs+APsHIoBiw1Edh4zbkR5OLLBREHbEorX3WXsT
je0cJxEvCg=3D=3D
=3DjQgQ
-----END PGP PUBLIC KEY BLOCK-----

--------------43eaLh8sEs4bfDFRrIL9lJJ8--

--------------Gz4TdCjmqEDxTKWq6UIoERcw--

--------------1eHw8hWuh7ikVg0ocyw8U4An
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQROYHF2XBhb9L9PDSLPQSxESPhZ/gUCZzlmuwAKCRDPQSxESPhZ
/rmgAP0Qx+k3iEMsTQ1sWEWwKj+wpt1NxWULZMVel8jmCd8zrgEAyi3x6HPbgMPZ
DRKur1hdIfgk9Sd11Jz+IF6Do3pYnQk=
=2cTm
-----END PGP SIGNATURE-----

--------------1eHw8hWuh7ikVg0ocyw8U4An--

