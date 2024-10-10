Return-Path: <linux-kernel+bounces-358431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F259B997F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3161C2398A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657D1D0F52;
	Thu, 10 Oct 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2LcMlw/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405591CFEC9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544880; cv=none; b=NNN2bzl/M141ifTZoL0GPbHFPF0lymBvqDs2Ft3splTI+7GtKPq/EomIdCvAw9gGdRQGWXXWtoqnLN+C81HHCX4H19TZuP6y4QHpDTG4xkB7tbZXt82VobgZUBljtqhfa9Pk7ZJv96BCg448pM7TNlZuon3emZO5P+I+oIDYzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544880; c=relaxed/simple;
	bh=AyCaBo0i4SYiCwcTDSqqgbpx2rzD5YQm6GeqNW55qBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac5n8AU85SqKe5tVhgNX8YQQbOmH4070hoTtm9EwZ9mBdMJe3johjFNeNaTcYj15WeOu5g34cTO0fswvkCXQPwMrkL5IeMTuWlJo2iSKV9rEDFJaSq3TG1q6vrESa+hsnG6YmtRcYKgVyued+5as0KOoh03ncMW/RRxYNdfayWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C2LcMlw/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3ecad390so910943f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728544876; x=1729149676; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AyCaBo0i4SYiCwcTDSqqgbpx2rzD5YQm6GeqNW55qBc=;
        b=C2LcMlw/Plb5DHbMwRtDD6ctyGg0xPsPJitIfkO9VflJ9syVb+dWIKyxriS9b/M0bF
         P77udmDHd10dBUyZ7l3afVXC6FVn3tHIZ08ruvpterWZzZk7L/457+2F0vsL6F3FQfjz
         TqOMk4vJGM1CNb+1GqivCLD+WhJ03mss2PIzFSJTK4m2WzFDrSF6wMllEBQmHUHSEOJF
         1IEf1BXS0bIyjMM/YE5gFFZbdLyBtWk7HbMUiyfoUGKmdG4mJTuVl0fw/j1PaE00ZDCK
         mSyHDFwTPIhkCTpHqoOqBinZT6VpSqn7bQj2r+IPHl/3zRBxpsRzThJSgT5w3ou+1H2w
         7+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544876; x=1729149676;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyCaBo0i4SYiCwcTDSqqgbpx2rzD5YQm6GeqNW55qBc=;
        b=QWS0QaQHxTtSNcGeVXdcwPcuzgFICmJ/f7s3euAk8IlrCwEU3l8uwKL2Ru7JTBteBN
         NDKK/svxLoF6Ohsy4aGFZhCOE+W6iNIOz9kQHjux8+YuH2BCe2Ww27ETy9BAKjz+rH54
         pYFCtT7teYzwUO4ZXg842mQByoAdKP3wxphMtXjSefrF+sep5L+eFg42lbOXmPAPySpB
         wNCWLk1CVHJ1K0k94GWldLKKTad971NF7g/TKXUx4UYyYdy91COygF6/L9cb0ZyO826t
         EW5QPPpDVcckb/2kF9cOg1E3evpezbyFuc9lhitlvdA8kr8jhd3KtK1YBgCRrANPdorL
         wGBw==
X-Forwarded-Encrypted: i=1; AJvYcCX6MImn/THHPcXKiwksEHvNsTuWJEe18EowqzREW2cE+idmQOmwI51lSvZIujkNOiYNc/eTljcBjQdNb5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvFEPZrIjjzgXdpZ+u3Hsp374WpYRY4p6q6h4Y8PPj8quOc7q
	eyIDzp+Ga9AR4RfsyRg5uVoh7lD9A3tPc+sWxIJ4Bi5Jzc6XekUNsm4HuC/voeE=
X-Google-Smtp-Source: AGHT+IGJeEuId0pkeYDcpcQ8p5zK0MIMdhuzCEkqAKRSkr3wHWM5w4dbP/wcjOKp97W+FuvkXlVnYg==
X-Received: by 2002:a5d:6502:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d481749f6mr1930588f8f.11.1728544876293;
        Thu, 10 Oct 2024 00:21:16 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd8asm7142005e9.16.2024.10.10.00.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 00:21:16 -0700 (PDT)
Message-ID: <720cda23-d34d-4e66-804e-cc7b48d9dc55@suse.com>
Date: Thu, 10 Oct 2024 09:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
To: Jan Beulich <jbeulich@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
 <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
 <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
 <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
 <756dc3d5-48fd-429f-a5eb-6cb8e99dfe6f@suse.com>
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
In-Reply-To: <756dc3d5-48fd-429f-a5eb-6cb8e99dfe6f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NIXChMZCYHNuRrQNqXIfsuAv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NIXChMZCYHNuRrQNqXIfsuAv
Content-Type: multipart/mixed; boundary="------------HWnIr4BTx00tYzMNDMlOZdty";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
Message-ID: <720cda23-d34d-4e66-804e-cc7b48d9dc55@suse.com>
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
 <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
 <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
 <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
 <756dc3d5-48fd-429f-a5eb-6cb8e99dfe6f@suse.com>
In-Reply-To: <756dc3d5-48fd-429f-a5eb-6cb8e99dfe6f@suse.com>
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

--------------HWnIr4BTx00tYzMNDMlOZdty
Content-Type: multipart/mixed; boundary="------------TbMDtIXHoCIrUQZoWvb5i00P"

--------------TbMDtIXHoCIrUQZoWvb5i00P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMTAuMjQgMDk6MDEsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMC4xMC4yMDI0
IDA3OjM5LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMTAuMTAuMjQgMDA6NDYsIFN0
ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBXZWQsIDkgT2N0IDIwMjQsIEphbiBC
ZXVsaWNoIHdyb3RlOg0KPj4+PiBPbiAwOS4xMC4yMDI0IDA4OjIwLCBKaXFpYW4gQ2hlbiB3
cm90ZToNCj4+Pj4+IENvbW1pdCAyZmFlNmJiN2JlMzIgKCJ4ZW4vcHJpdmNtZDogQWRkIG5l
dyBzeXNjYWxsIHRvIGdldCBnc2kgZnJvbSBkZXYiKQ0KPj4+Pj4gYWRkcyBhIHdlYWsgcmV2
ZXJzZSBkZXBlbmRlbmN5IHRvIHRoZSBjb25maWcgWEVOX1BSSVZDTUQgZGVmaW5pdGlvbiwg
aXRzDQo+Pj4+PiBwdXJwb3NlIGlzIHRvIHBhc3MgdGhlIGNvbWJpbmF0aW9uIG9mIGNvbXBp
bGF0aW9uIHRoYXQgQ09ORklHX1hFTl9QUklWQ01EPXkNCj4+Pj4+IGFuZCBDT05GSUdfWEVO
X1BDSURFVl9CQUNLRU5EPW0sIGJlY2F1c2UgaW4gdGhhdCBjb21iaW5hdGlvbiwgeGVuLXBj
aWJhY2sNCj4+Pj4+IGlzIGNvbXBpbGVkIGFzIGEgbW9kdWxlIGJ1dCB4ZW4tcHJpdmNtZCBp
cyBidWlsdC1pbiwgc28geGVuLXByaXZjbWQgY2FuJ3QNCj4+Pj4+IGZpbmQgdGhlIGltcGxl
bWVudGF0aW9uIG9mIHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYuDQo+Pj4+Pg0KPj4+Pj4g
QnV0IHRoYXQgZGVwZW5kZW5jeSBjYXVzZXMgeGVuLXByaXZjbWQgY2FuJ3QgYmUgbG9hZGVk
IG9uIGRvbVUsIGJlY2F1c2UNCj4+Pj4+IGRlcGVuZGVudCB4ZW4tcGNpYmFjayBpcyBhbHdh
eXMgbm90IGJlIGxvYWRlZCBzdWNjZXNzZnVsbHkgb24gZG9tVS4NCj4+Pj4+DQo+Pj4+PiBU
byBzb2x2ZSBhYm92ZSBwcm9ibGVtIGFuZCBjb3ZlciBvcmlnaW5hbCBjb21taXQncyByZXF1
aXJlbWVudCwganVzdCByZW1vdmUNCj4+Pj4+IHRoYXQgZGVwZW5kZW5jeSwgYmVjYXVzZSB0
aGUgY29kZSAiSVNfUkVBQ0hBQkxFKENPTkZJR19YRU5fUENJREVWX0JBQ0tFTkQpIg0KPj4+
Pj4gb2Ygb3JpZ2luYWwgY29tbWl0IGlzIGVub3VnaCB0byBtZWV0IHRoZSByZXF1aXJlbWVu
dC4NCj4+Pj4+DQo+Pj4+PiBGaXhlczogMmZhZTZiYjdiZTMyICgieGVuL3ByaXZjbWQ6IEFk
ZCBuZXcgc3lzY2FsbCB0byBnZXQgZ3NpIGZyb20gZGV2IikNCj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+Pg0KPj4+PiBUaGlz
IGxhY2tzIGEgUmVwb3J0ZWQtYnk6Lg0KPj4+Pg0KPj4+Pj4gLS0tIGEvZHJpdmVycy94ZW4v
S2NvbmZpZw0KPj4+Pj4gKysrIGIvZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4+Pj4gQEAgLTI2
MSw3ICsyNjEsNiBAQCBjb25maWcgWEVOX1NDU0lfQkFDS0VORA0KPj4+Pj4gICAgY29uZmln
IFhFTl9QUklWQ01EDQo+Pj4+PiAgICAJdHJpc3RhdGUgIlhlbiBoeXBlcmNhbGwgcGFzc3Ro
cm91Z2ggZHJpdmVyIg0KPj4+Pj4gICAgCWRlcGVuZHMgb24gWEVODQo+Pj4+PiAtCWltcGx5
IFhFTl9QQ0lERVZfQkFDS0VORA0KPj4+Pj4gICAgCWRlZmF1bHQgbQ0KPj4+Pj4gICAgCWhl
bHANCj4+Pj4+ICAgIAkgIFRoZSBoeXBlcmNhbGwgcGFzc3Rocm91Z2ggZHJpdmVyIGFsbG93
cyBwcml2aWxlZ2VkIHVzZXIgcHJvZ3JhbXMgdG8NCj4+Pj4NCj4+Pj4gVGhlIHJlcG9ydCB3
YXNuJ3QgYWJvdXQgYSBidWlsZCBwcm9ibGVtLCBidXQgYSBydW50aW1lIG9uZS4gUmVtb3Zp
bmcgdGhlDQo+Pj4+IGRlcGVuZGVuY3kgaGVyZSBkb2Vzbid0IGNoYW5nZSBhbnl0aGluZyBp
biB0aGUgZGVwZW5kZW5jeSBvZiB4ZW4tcHJpdmNtZA0KPj4+PiBvbiB4ZW4tcGNpYmFjaywg
YXMgdGhlIHVzZSBvZiBwY2lzdHViX2dldF9nc2lfZnJvbV9zYmRmKCkgY29udGludWVzIHRv
DQo+Pj4+IGV4aXN0Lg0KPj4+Pg0KPj4+PiBDb25zaWRlciB0aGUgY2FzZSBvZiBYRU5fUENJ
REVWX0JBQ0tFTkQ9bSBhbmQgWEVOX1BSSVZDTUQ9bSwgd2hpY2gNCj4+Pj4gSSBndWVzcyBp
cyB3aGF0IE1hcmVrIGlzIHVzaW5nIGluIGhpcyBjb25maWcuIEJvdGggZHJpdmVycyBhcmUg
YXZhaWxhYmxlDQo+Pj4+IGluIHN1Y2ggYSBjb25maWd1cmF0aW9uLCB5ZXQgbG9hZGluZyBv
ZiB4ZW4tcHJpdmNtZCB0aGVuIHJlcXVpcmVzIHRvDQo+Pj4+IGxvYWQgeGVuLXBjaWJhY2sg
Zmlyc3QuIEFuZCB0aGF0IGxhdHRlciBsb2FkIGF0dGVtcHQgd2lsbCBmYWlsIGluIGEgRG9t
VS4NCj4+Pj4gVGhlIHR3byBkcml2ZXJzIHNpbXBseSBtYXkgbm90IGhhdmUgYW55IGRlcGVu
ZGVuY3kgaW4gZWl0aGVyIGRpcmVjdGlvbi4NCj4+Pg0KPj4+IFRoZSBpZGVhIGlzIHRoYXQg
dGhlcmUgc2hvdWxkIGJlIG5vIGhhcmQgZGVwZW5kZW5jeSBvbg0KPj4+IHBjaXN0dWJfZ2V0
X2dzaV9mcm9tX3NiZGYoKS4gSWYgaXQgaXMgYXZhaWxhYmxlLCB0aGUgc2VydmljZSB3aWxs
IGJlDQo+Pj4gdXNlZCwgb3RoZXJ3aXNlIGFuIGVycm9yIHdpbGwgYmUgcmVwb3J0ZWQuDQo+
Pj4NCj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IElTX1JFQUNIQUJMRSBpcyBhIGNvbXBpbGUt
dGltZSBjaGVjay4gV2hhdCB3ZSBuZWVkDQo+Pj4gaXMgYSBydW50aW1lIGNoZWNrIGluc3Rl
YWQuIE1heWJlIHN5bWJvbF9nZXQgb3IgdHJ5X21vZHVsZV9nZXQgPw0KPj4NCj4+IFRoaXMg
aXMgYSByYXRoZXIgY2x1bXN5IHNvbHV0aW9uIElNTy4NCj4+DQo+PiBJJ20gc2VlaW5nIHRo
ZSBmb2xsb3dpbmcgc29sdXRpb25zOg0KPj4NCj4+IDEuIERvbid0IGZhaWwgdG8gdG8gbG9h
ZCB0aGUgcGNpYmFjayBkcml2ZXIgaW4gYSBEb21VLCBidXQgb25seSBkaXNhYmxlDQo+PiAg
ICAgIGFueSBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IDIuIE1vdmUgdGhlIGRyaXZlcnMveGVu
L3hlbi1wY2liYWNrL3BjaV9zdHViLmMgZnVuY3Rpb25hbGl0eSBpbiBhIG1vZHVsZQ0KPj4g
ICAgICBvZiBpdHMgb3duLCBhbGxvd2luZyB0aGUgcHJpdmNtZCBkcml2ZXIgdG8gYmUgbG9h
ZGVkIHdpdGhvdXQgbmVlZGluZw0KPj4gICAgICB0aGUgcmVzdCBvZiBwY2liYWNrLg0KPj4N
Cj4+IDMuIEFkZCBhIGhvb2sgdG8gZS5nLiBkcml2ZXJzL3hlbi9wY2kuYyBpbnN0ZWFkIGZv
ciBjYWxsaW5nIG9mDQo+PiAgICAgIHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYoKSBkaXJl
Y3RseS4gcGNpYmFjayBjb3VsZCByZWdpc3RlciB0aGUgcmVhbA0KPj4gICAgICBjYWxsIGFk
ZHJlc3MuIElmIHBjaWJhY2sgaXNuJ3QgbG9hZGVkLCB0aGUgaG9vayBjYW4gcmV0dXJuIGFu
IGVycm9yLg0KPj4gICAgICBUaGlzIHdvdWxkIHJlbW92ZSB0aGUgZXhwbGljaXQgZGVwZW5k
ZW5jeSBvZiBwcml2Y21kIG9uIHBjaWJhY2suDQo+Pg0KPj4gSSdkIHByZWZlciB0aGUgM3Jk
IHZhcmlhbnQuDQo+IA0KPiBTYW1lIGhlcmUgLSBvcmRlciBvZiBwcmVmZXJlbmNlIGJhY2t3
YXJkcyBpbiB0aGUgc2V0IHByZXNlbnRlZCBhYm92ZS4NCj4gSW4gdGhlIG1lYW50aW1lIHRo
ZSBvcmlnaW5hbCBjaGFuZ2UgbWF5IHNpbXBseSBuZWVkIHJldmVydGluZz8NCg0KTm8sIEkg
ZG9uJ3QgdGhpbmsgc28uIFRoZSBicmVha2FnZSB3YXMgaW50cm9kdWNlZCBpbiA2LjEyIGFu
ZCB3ZQ0KYXJlIHN0aWxsIGluIHRoZSA2LjEyIHJjIHBoYXNlLg0KDQpTdGFuZGFyZCBYZW4g
c2V0dXBzIGFyZSBydW5uaW5nIGp1c3QgZmluZSwgaXRzIGp1c3QgdGhlIFF1YmVzIHVzZQ0K
Y2FzZSB3aGljaCBpcyBicm9rZW4uIEhhdmluZyBhIGZpeCBpbiA2LjEyIHNob3VsZCBiZSBl
bm91Z2guDQoNCg0KSnVlcmdlbg0K
--------------TbMDtIXHoCIrUQZoWvb5i00P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------TbMDtIXHoCIrUQZoWvb5i00P--

--------------HWnIr4BTx00tYzMNDMlOZdty--

--------------NIXChMZCYHNuRrQNqXIfsuAv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmcHgGsFAwAAAAAACgkQsN6d1ii/Ey86
jwf8CQTaWJOyyssHTmn+R+O15SjRwBI38rrNU+9pcXTWTSyBwPJyAi/d2IDL9DgPTXjZ/Ek9PyjY
AEUwmFtIU4aa8m9pFCdqhBe43nEojY5HQNZuyq4QQmql2nTSEo9xtmiVZQrXCdERkVO8AEpau7xX
DjVsMDWRbUkewOVk+y1ZD2+5ryvWkRAgLS2iqTzRgfrVuMnQqCcLQdFLm3sWjVUWUCOcea4yNBC4
nZpIS5BlK5d+mGjIvnm6ErpboCvSIo6/9gQ8pr7SSwZ1d6S4Gs8oSSggDYCpuaqsptoWp/A5IhWt
I++BDk3bwdd7wVtU3/MTLNYRgdVwfvL2wZE7CCzCYg==
=zMnq
-----END PGP SIGNATURE-----

--------------NIXChMZCYHNuRrQNqXIfsuAv--

