Return-Path: <linux-kernel+bounces-371409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C19A3AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299062897EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB160201009;
	Fri, 18 Oct 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cmcB5yv4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C8200CB8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245557; cv=none; b=Hx1s9Ljmr219WzITp6UD3X80Z/EvMebgSyQG9aUqDLjUS3Dv+vLZggG8XVfxx5LOIVlqXVn1fS8RQnAkXBCXCX8tWgCPd+KqRDGSVXzmOykjqnYe5Xs5c8fkbCeWvHmb7FWAGqaX3YG/wSU2hCoCOyC4cHE3XH7/8DNyaKuok6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245557; c=relaxed/simple;
	bh=4rqjNImrHSaZ2A+eBwfHKQRTUfZ0zzYSU9zXimlEN9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfkkuDcLUFPeZg/0El88jyfR2QkETMgrblSVJXND21lDGnZTEWKup+HpC4VS4/71lNl1msmnSNk0pwafwwmUXgMAfk2MQpBJWyHkib1tjlPxC21wvUaI79R0Hf1oNziqn86bN7QBc71HMaUfTf+wjwrRu3ranKX1lxW/ClnWpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cmcB5yv4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9fd6dae47so2151178a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729245553; x=1729850353; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rqjNImrHSaZ2A+eBwfHKQRTUfZ0zzYSU9zXimlEN9Y=;
        b=cmcB5yv4DFKJHfCx9eHDHFAdnRQduAlqgIT1EpfwEWM4Cq1ghD7zNLpOWqgHvJY2Is
         QvNzUfnH5tvmvgMJJHa4YdZGeVKPKwraxW1khX734aT12DQ/nLnPCF2+Dyxu4X52wjAF
         WCoqEJQxoLEA2YoakcLymFIMmdY+BidZxcQvpX+eIGaxzf2Du9d+dhgIodZd8G9SCSEo
         mzEvK9NgJPunR4aTB6dQ0YAXcwOGWIr8tPLOE1ZfpHaB5JzZKoZboym8835kMw9Sb3ap
         3b4dg9wmTlswFeyAyiWleKH68CxZ3zyzJyCRdqVno1ZRKrRyX68Qk9QECWGaQzJIpfUM
         zVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245553; x=1729850353;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rqjNImrHSaZ2A+eBwfHKQRTUfZ0zzYSU9zXimlEN9Y=;
        b=r/TPrr1yMo73LZaV8kGJL3HCMQqHCjtCuy5G0cpvqOm7tLn+AC9RIzt8Pe+JLnjLhO
         SgizF6pWPIN9MlvXX7r2a1vTgpaESDtLli/I286FQ8TK+LDkmayKmIpV5xYhnJvfspKp
         7PdTVWz4RyWYPJ4NomcBpgjvQPO+aLq8/LP2n+W522htjbDQK0cyQKzydcXQG5vPMqtw
         92WLFUSB2NXXfXBHqys4WX3+04Wt5GOmINRXmBBX7KNdERGbSKyivzbZCCmGPz031Jnt
         sauaGg3gehA1sndFIBEpo0DDKejxvsU8Zjqd7UkptfR7VddNogAN8HGaCcnmhGavBbNY
         KSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxxp5yepO0kLOOX9d6vyT660dz4s/sh3iWNB6RHXvz8zpIvTsZY5QOAKl6OpcpYx4QkU8eCf51wABiLxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/+m4TqSJTeDmWrup3Sb5++2qQOucNX8FYtgrF4m25+IA0vSc
	BU+/9wtBTp9HtEhJDnpc8oJ0zWxVx3RwxA9L4nrUfWXVW74wVGsZY7AMb5Kwp74=
X-Google-Smtp-Source: AGHT+IE6/oaz3Cowp8yQ0wdd0YPB7iS5/TLsQm8EmObTB4MGX187ObsFNLt7Mf1m25k8pC5NZ8c2eQ==
X-Received: by 2002:a17:907:8f16:b0:a9a:11f5:8cd9 with SMTP id a640c23a62f3a-a9a69ca372dmr121338366b.56.1729245553061;
        Fri, 18 Oct 2024 02:59:13 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:8700:db3b:60ed:e8b9:cd28? (p200300e587148700db3b60ede8b9cd28.dip0.t-ipconnect.de. [2003:e5:8714:8700:db3b:60ed:e8b9:cd28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ae6394sm72592166b.84.2024.10.18.02.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 02:59:12 -0700 (PDT)
Message-ID: <c46981c8-e7d9-48f6-937f-5e8059114208@suse.com>
Date: Fri, 18 Oct 2024 11:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] xen: Remove dependency between pciback and privcmd
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <20241012084537.1543059-1-Jiqian.Chen@amd.com>
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
In-Reply-To: <20241012084537.1543059-1-Jiqian.Chen@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AmPFckrNgvwwbduhaYh8qahR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AmPFckrNgvwwbduhaYh8qahR
Content-Type: multipart/mixed; boundary="------------Ce1NOyyNmelfgX6ZLDWQaQxN";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <c46981c8-e7d9-48f6-937f-5e8059114208@suse.com>
Subject: Re: [PATCH v4] xen: Remove dependency between pciback and privcmd
References: <20241012084537.1543059-1-Jiqian.Chen@amd.com>
In-Reply-To: <20241012084537.1543059-1-Jiqian.Chen@amd.com>

--------------Ce1NOyyNmelfgX6ZLDWQaQxN
Content-Type: multipart/mixed; boundary="------------pj1s4fBFEZDt0TOUWOFV3jlC"

--------------pj1s4fBFEZDt0TOUWOFV3jlC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMTAuMjQgMTA6NDUsIEppcWlhbiBDaGVuIHdyb3RlOg0KPiBDb21taXQgMmZhZTZi
YjdiZTMyICgieGVuL3ByaXZjbWQ6IEFkZCBuZXcgc3lzY2FsbCB0byBnZXQgZ3NpIGZyb20g
ZGV2IikNCj4gYWRkcyBhIHdlYWsgcmV2ZXJzZSBkZXBlbmRlbmN5IHRvIHRoZSBjb25maWcg
WEVOX1BSSVZDTUQgZGVmaW5pdGlvbiwgdGhhdA0KPiBkZXBlbmRlbmN5IGNhdXNlcyB4ZW4t
cHJpdmNtZCBjYW4ndCBiZSBsb2FkZWQgb24gZG9tVSwgYmVjYXVzZSBkZXBlbmRlbnQNCj4g
eGVuLXBjaWJhY2sgaXNuJ3QgYWx3YXlzIGJlIGxvYWRlZCBzdWNjZXNzZnVsbHkgb24gZG9t
VS4NCj4gDQo+IFRvIHNvbHZlIGFib3ZlIHByb2JsZW0sIHJlbW92ZSB0aGF0IGRlcGVuZGVu
Y3ksIGFuZCBkbyBub3QgY2FsbA0KPiBwY2lzdHViX2dldF9nc2lfZnJvbV9zYmRmKCkgZGly
ZWN0bHksIGluc3RlYWQgYWRkIGEgaG9vayBpbg0KPiBkcml2ZXJzL3hlbi9hcGNpLmMsIHhl
bi1wY2liYWNrIHJlZ2lzdGVyIHRoZSByZWFsIGNhbGwgZnVuY3Rpb24sIHRoZW4gaW4NCj4g
cHJpdmNtZF9pb2N0bF9wY2lkZXZfZ2V0X2dzaSBjYWxsIHRoYXQgaG9vay4NCj4gDQo+IEZp
eGVzOiAyZmFlNmJiN2JlMzIgKCJ4ZW4vcHJpdmNtZDogQWRkIG5ldyBzeXNjYWxsIHRvIGdl
dCBnc2kgZnJvbSBkZXYiKQ0KPiBSZXBvcnRlZC1ieTogTWFyZWsgTWFyY3p5a293c2tpLUfD
s3JlY2tpIDxtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------pj1s4fBFEZDt0TOUWOFV3jlC
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------pj1s4fBFEZDt0TOUWOFV3jlC--

--------------Ce1NOyyNmelfgX6ZLDWQaQxN--

--------------AmPFckrNgvwwbduhaYh8qahR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmcSMXAFAwAAAAAACgkQsN6d1ii/Ey+h
rQf/W/FjhT9zrxkOAN9UuDMjD0vzF0e41ptS9YFlrjdWeJvDZJsPCjQNXvSdAWMOrTlqRORXw+HP
D9n2WnI6CDTTYjQeY01ehsMCil9M7F5u3bXN7k0Am+bDao1g19XKmTA4LvhGX3RpyRNkbwwowkOr
nRm9dcczcHbQi8lkhlePgdqTvhYT5LxA9Rah5gjv0th0hJZVGTLb9jEVSBwfi0HrK7OrHW3jCZrD
885z7o/jnJVs5m6jXy8fRnIr5ZD2ahhFZ/MiVfOuGRyeBSVVOG84DQ6iVRMEMDxtbm8n2Uj6QnKr
LfMmFhDYGRv3WTa30NfVQZeweqDetVUnXN9MVHmOCw==
=Avxp
-----END PGP SIGNATURE-----

--------------AmPFckrNgvwwbduhaYh8qahR--

