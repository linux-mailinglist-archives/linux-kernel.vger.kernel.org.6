Return-Path: <linux-kernel+bounces-358429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8D997EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626FCB2287C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429001B533C;
	Thu, 10 Oct 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vp1yYag4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631C33E1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544693; cv=none; b=Hd2UjrESQB0Dnvu1sK/tnJA5hnRkEu7Wuz7hKiSlHY+EwsdSbLQ2eAnPz+UBkDk56knYIKjlMVBjCG/obegkWKIASt6GrjGqdyNbelyOQI8np2NR1LSbcxRbQIm/xoxTNWcdnSpyv8cuUlja+uNAZBll613gh36R7PkSl3QJf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544693; c=relaxed/simple;
	bh=cE1FtMmpoWPgu9bWFUiFF9jZ+S1aOqWKKWP0qaAdbg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBzI4cPwvpE9YifM96vZqAhd7bqK/ftUEHbAMHcHCBEpQ0R/PPIqpd2kcMzSJsm3DxtoPOMQxc2PVxYtc87IIJmFmmCAcbmpu4UjImUEuASU41vvFERM+J4fGafHyUvPqn08nqNCjY4QSB587cGO/sOh6GhWc5HTrW1jz7sDpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vp1yYag4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4ec26709so83600f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728544689; x=1729149489; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cE1FtMmpoWPgu9bWFUiFF9jZ+S1aOqWKKWP0qaAdbg4=;
        b=Vp1yYag4JFkx9txAJD057g/MyuFGwHzfH16UqAFFsYe2Ln76wXgjYRFm0sO1tuVByb
         xmDZe3nI5v8CUYyiq9ggXs5Mdol3jiW+ZYA2i3hMstzifySQfg9ZqsnhBnAeT1TzLszn
         a69Y70Rcia0CYNFvLzAw8JJ8abENueRkHPIKiPv2Q2xy35w6iDA3CkYAU2603movDLV8
         hNNxay/vRtF/KXREKN3x/fL0Ub0clAxkMEp5aOH45gb8zQmMQXJagiwmHLAGqigSwSZa
         lkDg1IUJo/5jtEE2eZtpzbYetXNM4LyP6ulgURgHTftxuHSfsLjLAWRCEexuVPpvhaZP
         s8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544689; x=1729149489;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cE1FtMmpoWPgu9bWFUiFF9jZ+S1aOqWKKWP0qaAdbg4=;
        b=w5H+UEEtOGHWVF3VkWiEzW3og7kTJd4loO9IJLoo8KbARWnb921w7hO5Sd6pDtNaHh
         QduD/YrmxTjq4oWCSRWck5pZ8b8dRWpFK8jh+YzCms/7TwrOzqx1EQ1kR9zxgP4gsaLO
         NcHrCtfiXLAXeqj4/UDJKsyMOtpcLEkaXnuMClypo3o/lsD2rQGCKaoz6e3EDggQbUC0
         GovH/uyI2pKrAQYl9q/3+SAw8YZDj5EdeHT0iRQn4NHAI+FuuhUYCN6KBWVRRg5omzCY
         l2RJLE8fy4K3n67EGr4smKUdvUWPsX8C2SuGECiwpN9KPPzf1EKB7d3e9vnZfeQQMa+i
         baEA==
X-Forwarded-Encrypted: i=1; AJvYcCX6eaItNUNFraewQAGitYShargEkLPQXHl4JXvwu4Rb4r9yJ/2Umg5zYm+GMotne0MjfJn7vRKehTMOBDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN11QZH9ijS/5v7dUSSTswHPm5dmQMIiBlb8voP+XijMn5A7oE
	n/PgDzZGCVzgGhnNELUrRQqr1wBl4I2BoypPPkphblWhC/1mPMvVFKPrJpBQEnU=
X-Google-Smtp-Source: AGHT+IGa2z//qImP0OaYFgEKlinENIk9TDYQVRIsLBtgSj/7t0rxGWIoqtYmwHSJ8nFfL0Jx3yODvQ==
X-Received: by 2002:adf:ead0:0:b0:37c:d4e6:b242 with SMTP id ffacd0b85a97d-37d3aacd959mr3188404f8f.53.1728544689101;
        Thu, 10 Oct 2024 00:18:09 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9c1sm689586f8f.68.2024.10.10.00.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 00:18:08 -0700 (PDT)
Message-ID: <ff3c00b1-b626-4de2-b797-8dd03c4d70f1@suse.com>
Date: Thu, 10 Oct 2024 09:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Jan Beulich <jbeulich@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
 <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
 <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
 <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
 <BL1PR12MB5849650F8CB4606143C403F1E7782@BL1PR12MB5849.namprd12.prod.outlook.com>
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
In-Reply-To: <BL1PR12MB5849650F8CB4606143C403F1E7782@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IA7tG5Sn58pMnWH7AQ7hW00A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IA7tG5Sn58pMnWH7AQ7hW00A
Content-Type: multipart/mixed; boundary="------------k7Cb2sSqbZE51fXBPjf3TZxY";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Jan Beulich <jbeulich@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
Message-ID: <ff3c00b1-b626-4de2-b797-8dd03c4d70f1@suse.com>
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
 <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
 <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
 <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
 <BL1PR12MB5849650F8CB4606143C403F1E7782@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849650F8CB4606143C403F1E7782@BL1PR12MB5849.namprd12.prod.outlook.com>
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

--------------k7Cb2sSqbZE51fXBPjf3TZxY
Content-Type: multipart/mixed; boundary="------------kCE0UpRxMdfh0PgEGVppVqBq"

--------------kCE0UpRxMdfh0PgEGVppVqBq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMTAuMjQgMDk6MDcsIENoZW4sIEppcWlhbiB3cm90ZToNCj4gT24gMjAyNC8xMC8x
MCAxMzozOSwgSsO8cmdlbiBHcm/DnyB3cm90ZToNCj4+IE9uIDEwLjEwLjI0IDAwOjQ2LCBT
dGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+Pj4gT24gV2VkLCA5IE9jdCAyMDI0LCBKYW4g
QmV1bGljaCB3cm90ZToNCj4+Pj4gT24gMDkuMTAuMjAyNCAwODoyMCwgSmlxaWFuIENoZW4g
d3JvdGU6DQo+Pj4+PiBDb21taXQgMmZhZTZiYjdiZTMyICgieGVuL3ByaXZjbWQ6IEFkZCBu
ZXcgc3lzY2FsbCB0byBnZXQgZ3NpIGZyb20gZGV2IikNCj4+Pj4+IGFkZHMgYSB3ZWFrIHJl
dmVyc2UgZGVwZW5kZW5jeSB0byB0aGUgY29uZmlnIFhFTl9QUklWQ01EIGRlZmluaXRpb24s
IGl0cw0KPj4+Pj4gcHVycG9zZSBpcyB0byBwYXNzIHRoZSBjb21iaW5hdGlvbiBvZiBjb21w
aWxhdGlvbiB0aGF0IENPTkZJR19YRU5fUFJJVkNNRD15DQo+Pj4+PiBhbmQgQ09ORklHX1hF
Tl9QQ0lERVZfQkFDS0VORD1tLCBiZWNhdXNlIGluIHRoYXQgY29tYmluYXRpb24sIHhlbi1w
Y2liYWNrDQo+Pj4+PiBpcyBjb21waWxlZCBhcyBhIG1vZHVsZSBidXQgeGVuLXByaXZjbWQg
aXMgYnVpbHQtaW4sIHNvIHhlbi1wcml2Y21kIGNhbid0DQo+Pj4+PiBmaW5kIHRoZSBpbXBs
ZW1lbnRhdGlvbiBvZiBwY2lzdHViX2dldF9nc2lfZnJvbV9zYmRmLg0KPj4+Pj4NCj4+Pj4+
IEJ1dCB0aGF0IGRlcGVuZGVuY3kgY2F1c2VzIHhlbi1wcml2Y21kIGNhbid0IGJlIGxvYWRl
ZCBvbiBkb21VLCBiZWNhdXNlDQo+Pj4+PiBkZXBlbmRlbnQgeGVuLXBjaWJhY2sgaXMgYWx3
YXlzIG5vdCBiZSBsb2FkZWQgc3VjY2Vzc2Z1bGx5IG9uIGRvbVUuDQo+Pj4+Pg0KPj4+Pj4g
VG8gc29sdmUgYWJvdmUgcHJvYmxlbSBhbmQgY292ZXIgb3JpZ2luYWwgY29tbWl0J3MgcmVx
dWlyZW1lbnQsIGp1c3QgcmVtb3ZlDQo+Pj4+PiB0aGF0IGRlcGVuZGVuY3ksIGJlY2F1c2Ug
dGhlIGNvZGUgIklTX1JFQUNIQUJMRShDT05GSUdfWEVOX1BDSURFVl9CQUNLRU5EKSINCj4+
Pj4+IG9mIG9yaWdpbmFsIGNvbW1pdCBpcyBlbm91Z2ggdG8gbWVldCB0aGUgcmVxdWlyZW1l
bnQuDQo+Pj4+Pg0KPj4+Pj4gRml4ZXM6IDJmYWU2YmI3YmUzMiAoInhlbi9wcml2Y21kOiBB
ZGQgbmV3IHN5c2NhbGwgdG8gZ2V0IGdzaSBmcm9tIGRldiIpDQo+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4NCj4+Pj4gVGhp
cyBsYWNrcyBhIFJlcG9ydGVkLWJ5Oi4NCj4+Pj4NCj4+Pj4+IC0tLSBhL2RyaXZlcnMveGVu
L0tjb25maWcNCj4+Pj4+ICsrKyBiL2RyaXZlcnMveGVuL0tjb25maWcNCj4+Pj4+IEBAIC0y
NjEsNyArMjYxLDYgQEAgY29uZmlnIFhFTl9TQ1NJX0JBQ0tFTkQNCj4+Pj4+ICDCoCBjb25m
aWcgWEVOX1BSSVZDTUQNCj4+Pj4+ICDCoMKgwqDCoMKgIHRyaXN0YXRlICJYZW4gaHlwZXJj
YWxsIHBhc3N0aHJvdWdoIGRyaXZlciINCj4+Pj4+ICDCoMKgwqDCoMKgIGRlcGVuZHMgb24g
WEVODQo+Pj4+PiAtwqDCoMKgIGltcGx5IFhFTl9QQ0lERVZfQkFDS0VORA0KPj4+Pj4gIMKg
wqDCoMKgwqAgZGVmYXVsdCBtDQo+Pj4+PiAgwqDCoMKgwqDCoCBoZWxwDQo+Pj4+PiAgwqDC
oMKgwqDCoMKgwqAgVGhlIGh5cGVyY2FsbCBwYXNzdGhyb3VnaCBkcml2ZXIgYWxsb3dzIHBy
aXZpbGVnZWQgdXNlciBwcm9ncmFtcyB0bw0KPj4+Pg0KPj4+PiBUaGUgcmVwb3J0IHdhc24n
dCBhYm91dCBhIGJ1aWxkIHByb2JsZW0sIGJ1dCBhIHJ1bnRpbWUgb25lLiBSZW1vdmluZyB0
aGUNCj4+Pj4gZGVwZW5kZW5jeSBoZXJlIGRvZXNuJ3QgY2hhbmdlIGFueXRoaW5nIGluIHRo
ZSBkZXBlbmRlbmN5IG9mIHhlbi1wcml2Y21kDQo+Pj4+IG9uIHhlbi1wY2liYWNrLCBhcyB0
aGUgdXNlIG9mIHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYoKSBjb250aW51ZXMgdG8NCj4+
Pj4gZXhpc3QuDQo+Pj4+DQo+Pj4+IENvbnNpZGVyIHRoZSBjYXNlIG9mIFhFTl9QQ0lERVZf
QkFDS0VORD1tIGFuZCBYRU5fUFJJVkNNRD1tLCB3aGljaA0KPj4+PiBJIGd1ZXNzIGlzIHdo
YXQgTWFyZWsgaXMgdXNpbmcgaW4gaGlzIGNvbmZpZy4gQm90aCBkcml2ZXJzIGFyZSBhdmFp
bGFibGUNCj4+Pj4gaW4gc3VjaCBhIGNvbmZpZ3VyYXRpb24sIHlldCBsb2FkaW5nIG9mIHhl
bi1wcml2Y21kIHRoZW4gcmVxdWlyZXMgdG8NCj4+Pj4gbG9hZCB4ZW4tcGNpYmFjayBmaXJz
dC4gQW5kIHRoYXQgbGF0dGVyIGxvYWQgYXR0ZW1wdCB3aWxsIGZhaWwgaW4gYSBEb21VLg0K
Pj4+PiBUaGUgdHdvIGRyaXZlcnMgc2ltcGx5IG1heSBub3QgaGF2ZSBhbnkgZGVwZW5kZW5j
eSBpbiBlaXRoZXIgZGlyZWN0aW9uLg0KPj4+DQo+Pj4gVGhlIGlkZWEgaXMgdGhhdCB0aGVy
ZSBzaG91bGQgYmUgbm8gaGFyZCBkZXBlbmRlbmN5IG9uDQo+Pj4gcGNpc3R1Yl9nZXRfZ3Np
X2Zyb21fc2JkZigpLiBJZiBpdCBpcyBhdmFpbGFibGUsIHRoZSBzZXJ2aWNlIHdpbGwgYmUN
Cj4+PiB1c2VkLCBvdGhlcndpc2UgYW4gZXJyb3Igd2lsbCBiZSByZXBvcnRlZC4NCj4+Pg0K
Pj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgSVNfUkVBQ0hBQkxFIGlzIGEgY29tcGlsZS10aW1l
IGNoZWNrLiBXaGF0IHdlIG5lZWQNCj4+PiBpcyBhIHJ1bnRpbWUgY2hlY2sgaW5zdGVhZC4g
TWF5YmUgc3ltYm9sX2dldCBvciB0cnlfbW9kdWxlX2dldCA/DQo+Pg0KPj4gVGhpcyBpcyBh
IHJhdGhlciBjbHVtc3kgc29sdXRpb24gSU1PLg0KPj4NCj4+IEknbSBzZWVpbmcgdGhlIGZv
bGxvd2luZyBzb2x1dGlvbnM6DQo+Pg0KPj4gMS4gRG9uJ3QgZmFpbCB0byB0byBsb2FkIHRo
ZSBwY2liYWNrIGRyaXZlciBpbiBhIERvbVUsIGJ1dCBvbmx5IGRpc2FibGUNCj4+ICDCoMKg
IGFueSBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IDIuIE1vdmUgdGhlIGRyaXZlcnMveGVuL3hl
bi1wY2liYWNrL3BjaV9zdHViLmMgZnVuY3Rpb25hbGl0eSBpbiBhIG1vZHVsZQ0KPj4gIMKg
wqAgb2YgaXRzIG93biwgYWxsb3dpbmcgdGhlIHByaXZjbWQgZHJpdmVyIHRvIGJlIGxvYWRl
ZCB3aXRob3V0IG5lZWRpbmcNCj4+ICDCoMKgIHRoZSByZXN0IG9mIHBjaWJhY2suDQo+Pg0K
Pj4gMy4gQWRkIGEgaG9vayB0byBlLmcuIGRyaXZlcnMveGVuL3BjaS5jIGluc3RlYWQgZm9y
IGNhbGxpbmcgb2YNCj4+ICDCoMKgIHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYoKSBkaXJl
Y3RseS4gcGNpYmFjayBjb3VsZCByZWdpc3RlciB0aGUgcmVhbA0KPj4gIMKgwqAgY2FsbCBh
ZGRyZXNzLiBJZiBwY2liYWNrIGlzbid0IGxvYWRlZCwgdGhlIGhvb2sgY2FuIHJldHVybiBh
biBlcnJvci4NCj4+ICDCoMKgIFRoaXMgd291bGQgcmVtb3ZlIHRoZSBleHBsaWNpdCBkZXBl
bmRlbmN5IG9mIHByaXZjbWQgb24gcGNpYmFjay4NCj4+DQo+PiBJJ2QgcHJlZmVyIHRoZSAz
cmQgdmFyaWFudC4NCj4gVGhhbmtzLCBJIHdpbGwgc2VuZCBjaGFuZ2VzIGluIHYyIHNvb24u
DQo+IEFuZCBJIHByZWZlciB0byBhZGQgdGhlIGhvb2sgaW4gZHJpdmVycy94ZW4vYWNwaS5j
DQoNCkFncmVlZC4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------kCE0UpRxMdfh0PgEGVppVqBq
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------kCE0UpRxMdfh0PgEGVppVqBq--

--------------k7Cb2sSqbZE51fXBPjf3TZxY--

--------------IA7tG5Sn58pMnWH7AQ7hW00A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmcHf7AFAwAAAAAACgkQsN6d1ii/Ey9d
rgf+PGIvFmJcTWvFDg7DtPr5q8nPOJQbmlGO41E1H37PJMwvHoma4EJ5zPXVIM745qc5BTUFr6wz
VYP711tX2aJaTWcPm6n+KfIH/sWHjQN/PoPAC+eIXw4T3CQIIylzeL3igdtg2aLiTiPHXymbiTuj
sE6qOkdZRriEteZ5OsBIo+i0uL0vN+x80dmbQjryoGN6rmqfzTbkT7zj5SvOTb6yVwvzWzJlVyl9
s4OCoD1asmRLIkqScJBszn2cSVQ0BU76VcVb7EHKu1pikuXSYpStKasv+sEXgV3g024GVAhlj5xX
sJHd1lfHOFvqP2WaOVBfR8bOhsKK56EeR0Fw4pHU6g==
=BCPR
-----END PGP SIGNATURE-----

--------------IA7tG5Sn58pMnWH7AQ7hW00A--

