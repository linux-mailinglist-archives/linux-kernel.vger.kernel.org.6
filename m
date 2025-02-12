Return-Path: <linux-kernel+bounces-510967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B628A32436
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C07516889D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61AA209F44;
	Wed, 12 Feb 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F76rIGzT"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630C1F4299
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358269; cv=none; b=kEmXVLV+lg0n12N+5rsForNbyNegm1y68qYo895+77keediuqSa6HoqwA0W0nGGYo6lP8/0Vpe8ahmWPDnhPf+uqlQhh6e1DcC/uQmumuqjHKSLhPW0GOYaAWbyL3lFfZDhHfo02psRl8/c8QThW4LiZcVgvj/ryNTGXAnNciMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358269; c=relaxed/simple;
	bh=W1dlGHxCQbRS0uYSerDMSpI2w1rSU1kndDeoEazJDww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7rHh3lqVu925GemiMCYEClX67YJXnig1gpC5qmHvURdIGLgm1OcldSPXT08IZCodOXSh3DLTpiMwOHTthAK1CkhjWhwNldmiOqTY+3WgHyh1RIPFC6bZfTM6Iw88w0sfL78fbHYSg5pb35oYmI4Y/O37Mzgr6XWwIVIqhjuSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F76rIGzT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd91c313bso2074658f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739358266; x=1739963066; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1dlGHxCQbRS0uYSerDMSpI2w1rSU1kndDeoEazJDww=;
        b=F76rIGzTVhJYdzYKmUDxsHC6Sk6PdVfp+qQjQFq6IS+U40eV0VN5m/pgbfIWgVuBF0
         w8eYhA12MnQi5+RNridBDj8Yn6VcKlYCw6a89VGAX4a1u+hCZDqjcRxevvJhsPt9adQc
         yk4/SkCHrO9lRvaJgOmX6H5clb78Qh8XwyIHFizxQrUosvU/P4ZJQjFD3S2r67rIFPO2
         MP+g+tlONWDb2pgILgjEc+B1p+NAoZmjfOVrrE6gIIjfndxoqTdQNNGnJCNotvVoRrag
         XpWiLONl37mvCc4yZZMb+Qc5fGe0dPeJBB1N7+6t22C5ID470ZYn/RpPwFEvWQ5IAlA7
         wvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358266; x=1739963066;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1dlGHxCQbRS0uYSerDMSpI2w1rSU1kndDeoEazJDww=;
        b=mWUavRSwd4r3ARDp4t7cTddldoKfL3A7tW8EnNaVgmJ1IUvUfoL/3YObhCeIsEJWV4
         iQnuU5Iq9sI3u0r6gtzfBz36Km5DeWJQ51TYG6zaOMK5+eQxEmvbJBTZzPDWwSeA7L4v
         fnzY2qjHCi/Z1vQWYmGJ3SinCRXIyz7Wvit/AhNEtSI+iBPPloQPY8k1C9aqAoXZ7TvS
         YEjJjvubX1+Rf0+9bq+SWeX+8cHRnZcPVdcfY/DvCGTH1+FMMdn4b9Ie4/UH/H1ohN4t
         Hs/JINUuG/Gh18E1oX6YSaTTq/4UUrpW0eoVozy/suK7FdIR8DnQmOI7iWlpiLYpsiJk
         qJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6fAR9I8Fw0DLZHy9p3LQnYfUSWD0kswkmYVs+WkvwBrb94aEZ2rjgR9ej8CkzTS2EiYEnE9mEmK+UyuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+VpOkrGMi7mLcdVJ0/of9Gw/2DWvaIOS7Uvb0Zik89sx1gww
	b795l3HJPCp0k88tNUfhp4n/0ePzlX7gE3zmmUEcW/bDL+zTjzY2/Aa08ZNDl48=
X-Gm-Gg: ASbGncu4ALCiy4lGR9tJyqYnWP+5lavqAVfcQC+wLAYGYxQXWC7kla1nsuc0KE16+OK
	HDrYtZ6NfgG5EaKUPZjuixHidEg8AHzjkHMzRyJOPfuZupmqUvcfCQtDgzkzc4KRDmVY3PTYmQx
	Z9ItGxZrXLbauYc+oVoja3gzOfhrJCkAa4fb2+FNIdXC6hSN/7p8ruA9KkAZp0giWbVPQY2IvDK
	RpGgmfSSfCcjVDpzN2wOfegxJgUXMhvJOkYC7Y1FM1ZiqikibZtSahiJsPMjkiGkEeZ3hNf5F3T
	Kc+pmlWGRxrcA2glXwzB4vpovXeMH5fvqGkunCE6B1QY5QqknqnuVNHzfJUMRiHfhINsAuM/bTJ
	mvTjgm3VnoNMrUjpR4HKXrrb/s8YQAIcr+dVABA==
X-Google-Smtp-Source: AGHT+IEV3LceUhlJZevV3XSLTkc5PdO981bVL7+QH8DsCH7ZiHwizJ5uYyA7Coj7xe6Azd4NSjigzg==
X-Received: by 2002:a5d:6da4:0:b0:385:e17a:ce61 with SMTP id ffacd0b85a97d-38dea605267mr2044963f8f.53.1739358265968;
        Wed, 12 Feb 2025 03:04:25 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm17340834f8f.90.2025.02.12.03.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:04:25 -0800 (PST)
Message-ID: <f6822b63-ebda-4134-b91e-b189006d072a@suse.com>
Date: Wed, 12 Feb 2025 12:04:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xen/swiotlb: relax alignment requirements
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-2-jgross@suse.com>
 <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
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
In-Reply-To: <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZmYW6lsGiLacWZAkMhxxj0vd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZmYW6lsGiLacWZAkMhxxj0vd
Content-Type: multipart/mixed; boundary="------------7LxECW4oYiLRoqHgKD7xD2zq";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Message-ID: <f6822b63-ebda-4134-b91e-b189006d072a@suse.com>
Subject: Re: [PATCH 1/2] xen/swiotlb: relax alignment requirements
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-2-jgross@suse.com>
 <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
In-Reply-To: <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
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

--------------7LxECW4oYiLRoqHgKD7xD2zq
Content-Type: multipart/mixed; boundary="------------nLntjFo3rp3bHtu0VCMr60Tz"

--------------nLntjFo3rp3bHtu0VCMr60Tz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDIuMjUgMDc6NTMsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMS4wMi4yMDI1
IDEzOjA0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gV2hlbiBtYXBwaW5nIGEgYnVmZmVy
IGZvciBETUEgdmlhIC5tYXBfcGFnZSBvciAubWFwX3NnIERNQSBvcGVyYXRpb25zLA0KPj4g
dGhlcmUgaXMgbm8gbmVlZCB0byBjaGVjayB0aGUgbWFjaGluZSBmcmFtZXMgdG8gYmUgYWxp
Z25lZCBhY2NvcmRpbmcNCj4+IHRvIHRoZSBtYXBwZWQgYXJlYXMgc2l6ZS4gQWxsIHdoYXQg
aXMgbmVlZGVkIGluIHRoZXNlIGNhc2VzIGlzIHRoYXQgdGhlDQo+PiBidWZmZXIgaXMgY29u
dGlndW91cyBhdCBtYWNoaW5lIGxldmVsLg0KPiANCj4gSXMgdGhpcyByZWFsbHkgdHJ1ZSBp
biBhbGwgY2FzZXM/IENhbid0IGUuZy4gY29tcG91bmQgcGFnZXMgbWFrZSBpdCBoZXJlLA0K
PiB3aXRoIHRoZSBjYWxsZXIgdGhlbiBzdGlsbCBiZWluZyBwZXJtaXR0ZWQgdG8gYXNzdW1l
IGhpZ2hlciB0aGFuIHBhZ2UNCj4gYWxpZ25tZW50PyBBbGlnbm1lbnQgY2hlY2tpbmcgaW4g
eGVuX3N3aW90bGJfbWFwX3BhZ2UoKSB3b3VsZCBwZXJoYXBzDQo+IG5lZWQgZG9pbmcgd2l0
aCB0aGUgYmFzZSBhZGRyZXNzIG9mIHRoZSBpbmNvbWluZyBwYWdlLCBpLmUuIGV4Y2x1ZGlu
Zw0KPiB0aGUgaW5jb21pbmcgb2Zmc2V0Lg0KDQpUaGUgRE1BIGludGVyZmFjZXMgaW4gcXVl
c3Rpb24gKC5tYXBfcGFnZSBhbmQgLm1hcF9zZykgYXJlIGV4cGxpY2l0bHkNCmRlc2lnbmVk
IGZvciBETUEgc3RyZWFtaW5nIG1vZGUuIEkgZG9uJ3QgdGhpbmsgc3RyZWFtaW5nIG1vZGUg
cmVxdWlyZXMgYQ0Kc3BlY2lhbCBwYWdlIGFsaWdubWVudC4NCg0KDQpKdWVyZ2VuDQo=
--------------nLntjFo3rp3bHtu0VCMr60Tz
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------nLntjFo3rp3bHtu0VCMr60Tz--

--------------7LxECW4oYiLRoqHgKD7xD2zq--

--------------ZmYW6lsGiLacWZAkMhxxj0vd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmesgDgFAwAAAAAACgkQsN6d1ii/Ey+z
6Qf/UX+Bm2CFCmD/3J96Ci3ilP1XFLCKdppNTba/LrgPKLNdbEizBGI7gm4D/eVKzHFj7S1Mgy4D
msUT7kaLdjoUyy1oE9K0BNCtJPEVx6ZV6iz20iA1oiri3z7RI1/FmH3BTORjzJ4q8698iwrWQ7IR
GAr2BKkDb8XAgTbG0bmhoXbJoRorupWsa2mEegMUIlZL0d6bPRvlOnhH1+E8UjGFJtgJBDerCWtq
r+XdVSHtFcqJeJhpk6I/9mmR9PuFTGdMllWvPEG92E8BCQzG5whvcAaTjciRTr0N1kkMIk/dwXXg
UXt2PduePw/v9KXfe711fbg/heONqXlezKDk96naXQ==
=5mP+
-----END PGP SIGNATURE-----

--------------ZmYW6lsGiLacWZAkMhxxj0vd--

