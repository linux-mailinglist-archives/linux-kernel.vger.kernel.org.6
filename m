Return-Path: <linux-kernel+bounces-185187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB78CB1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3801C21895
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A4142E72;
	Tue, 21 May 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxR3ekxe"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53D1FBB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306886; cv=none; b=UadF3C0SfdyNgsJbklzu7uPuqXhM9ql+xRP0Fdbb+ICrFQks9czjqnxLp5qV/qDw4pG/twoJpEExIQ5mDzKX+lGn9OyAkKXPlEU/+E+uXp13gyvm5Zsw0ZtlIG/fFAzboyDyR5iuQxcrTPrbL7ytQMwkTSCPEY0NTNtuKFJS8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306886; c=relaxed/simple;
	bh=AiXhl+jmsYbdHbEFZT7LAvSQHtIWlCw+MOjvgufVS9w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HQ8I+OiL512ro0AMp7ZQw2IjlKdpkRO1m35JLLeNBF8N5R5JEzNzCbUkuMPFpKYw8/MpcXmqHNqy9AgaQCrvlRZiJDwD700FQPifJZUI0USQvjzIlm19UTaEP45/oXYm5Q0xHZLr5JFnWdiq3gsPeB+hn26FeC/nXndyk1FgXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxR3ekxe; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47f158ca5a7so1075206137.1;
        Tue, 21 May 2024 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306884; x=1716911684; darn=vger.kernel.org;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiXhl+jmsYbdHbEFZT7LAvSQHtIWlCw+MOjvgufVS9w=;
        b=PxR3ekxexQjrRfRkDm3vEy/KZBiNnxlP+e8KZX0hKcOa8wbfszGrY9LOjeOWwtgdJw
         2rrClAkuou3Untekm8fPQSaYClHkNDnpG8pa14LkzH8mKg7eWk0t2QE+8PJes2fmYuPt
         L5gkJygtjv4M3sMH6el21K0IRIykkiu537SIw33khhou4qGxxHA4+azC94Mdx4BfyZKs
         lYrfo36gDoJo+xA9gJqfTA+dC4KfbEb4YORZKjbiDQvCTs0g2HcO8g6+hyiqxnqBx3qy
         XWlm8qFmUX/6+4WapOakWsqBkbCbaLTnQzrP/vdk4bY8X/zowu6ESz7W6tlWVK8jVa++
         trAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306884; x=1716911684;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AiXhl+jmsYbdHbEFZT7LAvSQHtIWlCw+MOjvgufVS9w=;
        b=vHxRTUclAgxmYylD8QZZ5FXoYbYFH6mTgzD8SbBUh9SPcOO/0k3dRNYLwLPUq2xZsG
         cGiT6vUtyInkJFGiKR7vdGAYR0W23/nogUPxTFI7sVGtG8CQqfLB3sPqwVct+stoy6ql
         PugqIOwwPnPcNYluaK8hzf55dOU7W9cRouBhgGzguqbXmTkHTqKMMr3tpnG9eGZCi9ti
         VzcD9dDUNrFPlEkVw/X9LUODD8FKAjWJhxqG5/6rzrMaj8qA0U/5DWsd6t/+kLiMeI/Q
         A122DdQ8aSK8ILfR35LOXV47/ly11zNrlcBXLFWLjqPgUn71lswnBkmIgiffBz5/sXfz
         m1dA==
X-Gm-Message-State: AOJu0YyCGPfOrZvKQsm6SThii7oVzSF70wOTvD/EPDuY/HHlDwfbRfPc
	hA8ez24tEhz7dnAwczZ6kvW2PXd9QSTgUccqo0zaG32kE6k16aVlq9iT1Mxy
X-Google-Smtp-Source: AGHT+IFi6GYmteqnyHMTvFe8cNm2LvqsI+vXb4HRxux2iOC4v0MYBjSr0guBRNh7A1T6NNn98xuAlw==
X-Received: by 2002:a05:6102:512a:b0:47f:1798:f9f8 with SMTP id ada2fe7eead31-48077dcd421mr31334790137.11.1716306883685;
        Tue, 21 May 2024 08:54:43 -0700 (PDT)
Received: from [192.168.1.213] (syn-142-197-127-150.res.spectrum.com. [142.197.127.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f8ff9eae05sm3583696241.1.2024.05.21.08.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:54:42 -0700 (PDT)
Message-ID: <d7003b6e-b8e3-41c4-9e6e-2b9abd0c5572@gmail.com>
Date: Tue, 21 May 2024 11:54:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, io-uring@vger.kernel.or
Cc: regressions@vger.kernel.org
From: Andrew Udvare <audvare@gmail.com>
Subject: BUG: ETXTBSY when running Yarn (Node) since af5d68f
Autocrypt: addr=audvare@gmail.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bO0M03Lx8fpbbaWM0zTAkKZ0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bO0M03Lx8fpbbaWM0zTAkKZ0
Content-Type: multipart/mixed; boundary="------------SPJ2GA7F6USBenznfUEj6Ezw";
 protected-headers="v1"
From: Andrew Udvare <audvare@gmail.com>
To: linux-kernel@vger.kernel.org, io-uring@vger.kernel.or
Cc: regressions@vger.kernel.org
Message-ID: <d7003b6e-b8e3-41c4-9e6e-2b9abd0c5572@gmail.com>
Subject: BUG: ETXTBSY when running Yarn (Node) since af5d68f

--------------SPJ2GA7F6USBenznfUEj6Ezw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxl
L2xpbnV4LmdpdC9jb21taXQvP2lkPWFmNWQ2OGY4ODkyZjhlZThmMTM3NjQ4Yjc5Y2ViMmFi
YzE1M2ExOWINCg0KU2luY2UgdGhlIGFib3ZlIGNvbW1pdCBwcmVzZW50IGluIDYuOSssIE5v
ZGUgcnVubmluZyBhIFlhcm4gaW5zdGFsbGF0aW9uIA0KdGhhdCBleGVjdXRlcyBhIHN1YnBy
b2Nlc3MgYWx3YXlzIHNob3dzIHRoZSBmb2xsb3dpbmc6DQoNCi90ZXN0ICMgeWFybiAtLW9m
ZmxpbmUgaW5zdGFsbA0KeWFybiBpbnN0YWxsIHYxLjIyLjIyDQp3YXJuaW5nIHBhY2thZ2Uu
anNvbjogInRlc3QiIGlzIGFsc28gdGhlIG5hbWUgb2YgYSBub2RlIGNvcmUgbW9kdWxlDQp3
YXJuaW5nIHRlc3RAMS4wLjA6ICJ0ZXN0IiBpcyBhbHNvIHRoZSBuYW1lIG9mIGEgbm9kZSBj
b3JlIG1vZHVsZQ0KWzEvNF0gUmVzb2x2aW5nIHBhY2thZ2VzLi4uDQpbMi80XSBGZXRjaGlu
ZyBwYWNrYWdlcy4uLg0KWzMvNF0gTGlua2luZyBkZXBlbmRlbmNpZXMuLi4NCls0LzRdIEJ1
aWxkaW5nIGZyZXNoIHBhY2thZ2VzLi4uDQplcnJvciAvdGVzdC9ub2RlX21vZHVsZXMvc255
azogQ29tbWFuZCBmYWlsZWQuDQpFeGl0IGNvZGU6IDEyNg0KQ29tbWFuZDogbm9kZSB3cmFw
cGVyX2Rpc3QvYm9vdHN0cmFwLmpzIGV4ZWMNCkFyZ3VtZW50czoNCkRpcmVjdG9yeTogL3Rl
c3Qvbm9kZV9tb2R1bGVzL3NueWsNCk91dHB1dDoNCi9iaW4vc2g6IG5vZGU6IFRleHQgZmls
ZSBidXN5DQoNClRoZSBjb21taXQgd2FzIGZvdW5kIGJ5IGJpc2VjdGlvbiB3aXRoIGEgc2lt
cGxlIGluaXRyYW1mcyB0aGF0IGp1c3QgcnVucyANCid5YXJuIC0tb2ZmbGluZSBpbnN0YWxs
JyB3aXRoIGEgdGVzdCBwcm9qZWN0IGFuZCBjYWNoZWQgWWFybiBwYWNrYWdlcy4NCg0KVG8g
cmVwcm9kdWNlOg0KDQpucG0gaW5zdGFsbCAtZyB5YXJuDQpta2RpciB0ZXN0DQpjZCB0ZXN0
DQpjYXQgPiBwYWNrYWdlLmpzb24gPDxFT0YNCnsNCiAgICJuYW1lIjogInRlc3QiLA0KICAg
InZlcnNpb24iOiAiMS4wLjAiLA0KICAgIm1haW4iOiAiaW5kZXguanMiLA0KICAgImxpY2Vu
c2UiOiAiTUlUIiwNCiAgICJkZXBlbmRlbmNpZXMiOiB7DQogICAgICJzbnlrIjogIl4xLjEy
OTEuMCINCiAgIH0NCn0NCkVPRg0KeWFybiBpbnN0YWxsDQoNCk1vZGVybiBZYXJuIHdpbGwg
Z2l2ZSB0aGUgc2FtZSByZXN1bHQgYnV0IHdpdGggc2xpZ2h0bHkgZGlmZmVyZW50IG91dHB1
dC4NCg0KVGhpcyBhbHNvIGFwcGVhcnMgdG8gYWZmZWN0IG5vZGUtZ3lwOiANCmh0dHBzOi8v
Z2l0aHViLmNvbS9ub2RlanMvbm9kZS9pc3N1ZXMvNTMwNTENCg0KU2VlIGFsc286IGh0dHBz
Oi8vYnVncy5nZW50b28ub3JnLzkzMTk0Mg0KDQotLQ0KQW5kcmV3DQo=

--------------SPJ2GA7F6USBenznfUEj6Ezw--

--------------bO0M03Lx8fpbbaWM0zTAkKZ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEYK9084jvT0kxwI44Gv2a/BIMJt0FAmZMw8EFAwAAAAAACgkQGv2a/BIMJt3T
MRAAoD+P6r/qrddoketH9eGknPK5pmlog4hcJDKzgRWijR4lW9siNxYZJ/Wb/VCHfNPYXzJqzUSf
a2Ouwz6neLQbAsIGsyII6HVxcWBUOq3pUWW+4/NUs7HX38nTbx3wt+gU/tlPle/3I4XmdUweZ7+J
hLWqs/aMet2lXejdk2h3EpH9HdPn40dZmIBer5WXXkEVZ2aQqzDzIJTL0q8rQNvfDfyufeKwBfGl
PVEMC7Zlchb4BznUj+bz8wAuwA7Cuy0I3V59q4dn0SkM3A24i2NXUDc/Tl8aFo/v+e+FG0lyYiYd
l8uvVLh2mDe02ojs//oxabonIZ8FJLRcUAWgmLGSckC3BeG2zNy8mzjj811uaLoPiGR9kYkHu6hL
VzIqgZEa4+JpwCj02I1mwN/3BP6LXaNgzmxUP0vj8yXK1O3NQNHa5oT39RPbJaildB0JYon48Yv0
RfEhK8hozDcxrwTNjWLGbyp5irqVWRhea8LDvD/z41tuza7FgEcPDSo/C+EjPIFFbD0Pdety5UPD
d+sQmr9xu/SM46uAkXLLW/q/N/gbhMz5lnN1P43XhDraMG7sfOeH08kBroajvdQzqQ3g732aan84
yolqwwQXL4S6rQfl+nCJiU1d9KM3E2kq8flfc8NReSo14Vh9IZtJdbu1oUzJmd435J88fDdcJvoG
Dn8=
=cwlE
-----END PGP SIGNATURE-----

--------------bO0M03Lx8fpbbaWM0zTAkKZ0--

