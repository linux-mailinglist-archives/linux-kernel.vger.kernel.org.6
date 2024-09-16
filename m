Return-Path: <linux-kernel+bounces-330309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB601979C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660861F236EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E4813B5AF;
	Mon, 16 Sep 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VTg9Q/J/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6F256D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473935; cv=none; b=a326KA7AJXuH+MBd0aVOwHh3MGCS1i06rFUY7JeQ5rIVfMkx/AKkN4uCZJTAaWU37pg8aXOKZpPqXpz2bI6pZi5eJ/0Iau7jbE7PLp7b2S0bPxuucrV1YEVQyfMUsRZOje95XeQ5Q5FzX0qQRkubV7okeL2eEWbc877IldDM14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473935; c=relaxed/simple;
	bh=/KJbDQO8uUIVEF7hFjTLVCGL5q3ZnTP9mHtdr55srzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aE2omzZTcq07qDWjp6z+jMFjV+/28qzsv0wG0t1JkIqkdhiwcIqMqEEGWCDfgAlP/eLrJ3DPSQwUWx9r9wFwnv9FsyMZovQLuEdEGq20TagzR7hSLYDdDpY/xjSieTTphWtsx4N7th4RUXeD8xKR5rTJpE/Cb5s9SjOiSCAoiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VTg9Q/J/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d4093722bso585961966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726473931; x=1727078731; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/KJbDQO8uUIVEF7hFjTLVCGL5q3ZnTP9mHtdr55srzQ=;
        b=VTg9Q/J/YEWrd6z61iSCT29dACtbT6KfqTVycULioGxdeISwgBQBC/H9KHjIG29H7Y
         LjY+BTuH7neL0MLp5DOPOQSyBccDUcFeSUHMAoS8vcyEqG8569tzKD1FXmi9w8/EeqJU
         JGngBHNehA9kmxBct31xZKOpCEpZDVNNsIuY2VJtG1pKuy6sFZJRBCObiLgM/roK8m5T
         fxe31cxFvUWgqPqM569DWhZ2mp/XBu7Kzj1eKRvlRcFkDCjEO7HRzkm19RH64Wfu0qca
         BDhgMTMzpkTZKJgKFwmHmKXf0yZ+NR4lWnQrK6suTSFBYycq0GmqK0wXGverhfRbacqe
         YZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473931; x=1727078731;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KJbDQO8uUIVEF7hFjTLVCGL5q3ZnTP9mHtdr55srzQ=;
        b=NTkqVjIk4zHwafQLQJApTIdUtu0Jrr9ZxpSY0FJc6lKMYFyeBjRV1KTBHN4cKxXiOX
         d6Pb+MmdOrFVNZ2TxuErOdRkGhkF7yaytYuHgUCZZJ5CE1xuX2kCOWBkoNH/qGq/6SSQ
         BIQbYw0u9qJ77d3PN2YaW4WkVvaZ56fkqBWI5TB93gYhZQYdPbfK545A+11pDhi+otew
         7mMXlIJE187Fb61mFM0QwY2s8Y0FFjqlMLXi6LBsn8vCy5UHJN9FmMBKw5RV8WkKDdF+
         ItHpkn1fiUyQ4pII6ubVJx2S0ny+ILv3O3EIOBP8E3tRii91Xvy0YhU/kwle2F7oh1mp
         UqGA==
X-Forwarded-Encrypted: i=1; AJvYcCVIMpNlt2FvckxKCqbrYuz3n1/6sYIyLOtzJTCBH0odquWX8jaqY/2es5YAKFF9CS0+fjcQdwhvhLFmGG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMzSCCe35VjdZLhOBGZz5v6bRpqNePzZwLubXLW8K9LDp7on8
	ylTSoYQ5gFKpXSZk4VAKnUqscwOdUR3shlMrCax55KOzpY+3AliM3/KRVCRvWXA=
X-Google-Smtp-Source: AGHT+IHWqiYppXd+B3s7+awqBPqzOCm+2eQHRc84WN9eeWWHxKwfmFb/M7rP3LuC1l+9Volsh11AEw==
X-Received: by 2002:a17:907:efc6:b0:a86:9c71:ec93 with SMTP id a640c23a62f3a-a9029438edemr1472722766b.24.1726473930291;
        Mon, 16 Sep 2024 01:05:30 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f44fasm275538066b.79.2024.09.16.01.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 01:05:30 -0700 (PDT)
Message-ID: <36f2bee7-f4d4-4e1e-9a68-cd7a5210eb1a@suse.com>
Date: Mon, 16 Sep 2024 10:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] xen/swiotlb: fix allocated size
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-3-jgross@suse.com>
 <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
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
In-Reply-To: <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hJewHrES50GIzppl4G9zcljf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hJewHrES50GIzppl4G9zcljf
Content-Type: multipart/mixed; boundary="------------Yl0lQ9LJFoUhiapj1tkCpSfR";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Message-ID: <36f2bee7-f4d4-4e1e-9a68-cd7a5210eb1a@suse.com>
Subject: Re: [PATCH v2 2/2] xen/swiotlb: fix allocated size
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-3-jgross@suse.com>
 <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
In-Reply-To: <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
Autocrypt-Gossip: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJ3BBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AAIQkQoDSui/t3IH4WIQQ+pJkfkcoLMCa4X6CgNK6L+3cgfgn7AJ9DmMd0SMJE
 ePbc7/m22D2v04iu7ACffXTdZQhNl557tJuDXZSBxDmW/tLOwU0EWTecRBAIAIK5OMKMU5R2
 Lk2bbjgX7vyQuCFFyKf9rC/4itNwhYWFSlKzVj3WJBDsoi2KvPm7AI+XB6NIkNAkshL5C0kd
 pcNd5Xo0jRR5/WE/bT7LyrJ0OJWS/qUit5eNNvsO+SxGAk28KRa1ieVLeZi9D03NL0+HIAtZ
 tecfqwgl3Y72UpLUyt+r7LQhcI/XR5IUUaD4C/chB4Vq2QkDKO7Q8+2HJOrFIjiVli4lU+Sf
 OBp64m//Y1xys++Z4ODoKh7tkh5DxiO3QBHG7bHK0CSQsJ6XUvPVYubAuy1XfSDzSeSBl//C
 v78Fclb+gi9GWidSTG/4hsEzd1fY5XwCZG/XJJY9M/sAAwUH/09Ar9W2U1Qm+DwZeP2ii3Ou
 14Z9VlVVPhcEmR/AFykL9dw/OV2O/7cdi52+l00reUu6Nd4Dl8s4f5n8b1YFzmkVVIyhwjvU
 jxtPyUgDOt6DRa+RaDlXZZmxQyWcMv2anAgYWGVszeB8Myzsw8y7xhBEVV1S+1KloCzw4V8Z
 DSJrcsZlyMDoiTb7FyqxwQnM0f6qHxWbmOOnbzJmBqpNpFuDcz/4xNsymJylm6oXiucHQBAP
 Xb/cE1YNHpuaH4SRhIxwQilCYEznWowQphNAbJtEKOmcocY7EbSt8VjXTzmYENkIfkrHRyXQ
 dUm5AoL51XZljkCqNwrADGkTvkwsWSvCSQQYEQIACQUCWTecRAIbDAAKCRCgNK6L+3cgfuef
 AJ9wlZQNQUp0KwEf8Tl37RmcxCL4bQCcC5alCSMzUBJ5DBIcR4BY+CyQFAs=

--------------Yl0lQ9LJFoUhiapj1tkCpSfR
Content-Type: multipart/mixed; boundary="------------8VbxQznwabjvDPCeeRZEo7wR"

--------------8VbxQznwabjvDPCeeRZEo7wR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjQgMDk6NTksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxNi4wOS4yMDI0
IDA4OjQ3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gVGhlIGFsbG9jYXRlZCBzaXplIGlu
IHhlbl9zd2lvdGxiX2FsbG9jX2NvaGVyZW50KCkgYW5kDQo+PiB4ZW5fc3dpb3RsYl9mcmVl
X2NvaGVyZW50KCkgaXMgY2FsY3VsYXRlZCB3cm9uZyBmb3IgdGhlIGNhc2Ugb2YNCj4+IFhF
Tl9QQUdFX1NJWkUgbm90IG1hdGNoaW5nIFBBR0VfU0laRS4gRml4IHRoYXQuDQo+Pg0KPj4g
Rml4ZXM6IDcyNTBmNDIyZGEwNCAoInhlbi1zd2lvdGxiOiB1c2UgYWN0dWFsbHkgYWxsb2Nh
dGVkIHNpemUgb24gY2hlY2sgcGh5c2ljYWwgY29udGludW91cyIpDQo+PiBSZXBvcnRlZC1i
eTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQHN1c2UuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEph
biBCZXVsaWNoIDxqYmV1bGljaEBzdXNlLmNvbT4NCj4gDQo+PiAtLS0gYS9kcml2ZXJzL3hl
bi9zd2lvdGxiLXhlbi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jDQo+
PiBAQCAtMTQ3LDcgKzE0Nyw3IEBAIHhlbl9zd2lvdGxiX2FsbG9jX2NvaGVyZW50KHN0cnVj
dCBkZXZpY2UgKmRldiwgc2l6ZV90IHNpemUsDQo+PiAgIAl2b2lkICpyZXQ7DQo+PiAgIA0K
Pj4gICAJLyogQWxpZ24gdGhlIGFsbG9jYXRpb24gdG8gdGhlIFhlbiBwYWdlIHNpemUgKi8N
Cj4+IC0Jc2l6ZSA9IDFVTCA8PCAob3JkZXIgKyBYRU5fUEFHRV9TSElGVCk7DQo+PiArCXNp
emUgPSBBTElHTihzaXplLCBYRU5fUEFHRV9TSVpFKTsNCj4gDQo+IFRoZSB3YXkgeW91J3Jl
IGRvaW5nIGl0IGhhcyBmdXJ0aGVyIHBvc2l0aXZlIGVmZmVjdHMsIGFzIHRoZSBzaXplDQo+
IGlzIG5vdyBhbHNvIG5vIGxvbmdlciBuZWVkbGVzc2x5IG92ZXItYWxpZ25lZC4gTWF5IHdh
bnQgbWVudGlvbmluZw0KPiBpbiB0aGUgZGVzY3JpcHRpb24uIEhvcGUgb2YgY291cnNlIGlz
IHRoYXQgbm8tb25lIGNhbWUgdG8gcmVseSBvbg0KPiB0aGUgdXAtdG8tbmV4dC1wb3dlci1v
Zi0yIGFsbG9jYXRpb24gYW55d2hlcmUgKHdoaWNoIG9mIGNvdXJzZQ0KPiB3b3VsZCBiZSBh
IGJ1ZyB0aGVyZSwgeWV0IG1pZ2h0IGVuZCBpbiBhIHBlcmNlaXZlZCByZWdyZXNzaW9uKS4N
Cg0KUXVpdGUgdW5saWtlbHkgSU1ITywgYXMgdGhpcyBpcyBhIFhlbi1vbmx5IGJlaGF2aW9y
LiBJJ20gbm90IGF3YXJlIG9mDQphbnkgaGFyZHdhcmUgdXNlZCB3aXRoIFhlbiBvbmx5LiBT
byBmb3IgYSByZWdyZXNzaW9uIHRvIGhhcHBlbiB0aGUgZHJpdmVyDQphbGxvY2F0aW5nIERN
QSBtZW1vcnkgd291bGQgbmVlZCB0byBoYXZlIGEgWGVuLXNwZWNpZmljIGhhbmRsaW5nIHJl
bHlpbmcNCm9uIHRoZSBoaWdoZXIgYWxpZ25tZW50Lg0KDQoNCkp1ZXJnZW4NCg==
--------------8VbxQznwabjvDPCeeRZEo7wR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------8VbxQznwabjvDPCeeRZEo7wR--

--------------Yl0lQ9LJFoUhiapj1tkCpSfR--

--------------hJewHrES50GIzppl4G9zcljf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbn5skFAwAAAAAACgkQsN6d1ii/Ey9o
Jgf/TLakFUOBMThxQ1bldaLkPgQF1JUOI5R2xkslmK+XSC+J4Raudwo9YtYY9VUrW4wvP3bjRQDx
FKd2cIDDHhYXBiQU2vCGV2ssksPbwZmzHqj4E4nuSUChXfjIDOsiQdNLZnIF0aKaujdYWIQ8NgxH
JStE/pX4l3Wnp2+Soos/Qx0uA7/Trniy8lYY4K4Rer0CfYZkmWZg1QLbcnPYvqVVqta7Zv0iq4tQ
BlsZF+vQ0gsN5vw0Gaj7pPFqi+An0P9ZKf1Pvyneaeloje4cjnKqPVTIgMBvmJfAcKB2B2Cr3Bf2
H1LwxoCzqxVnP/HR7yaQcBDYNek+U4caP7viHsPpOg==
=a7W8
-----END PGP SIGNATURE-----

--------------hJewHrES50GIzppl4G9zcljf--

