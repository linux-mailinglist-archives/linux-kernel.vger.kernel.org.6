Return-Path: <linux-kernel+bounces-555588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F48CA5B9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DFD1714F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260221A45D;
	Tue, 11 Mar 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XjSy/IUj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F88221733
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678517; cv=none; b=k0BArUY8djVQIwt10YZkWfBNyEBeSzO2yWuSvWC8fa9roN2Z+gzPPvJoFVpjW6U2Ke7EMxE93hwWq+tU8dkyGcj4i2q+DIabohMOR9SabP3LBkE+oUh/xB6+dN3/ZaaO1qbhCDbDdGgoMUNvg81IXexhTxfLUZjSwaUvVEXGzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678517; c=relaxed/simple;
	bh=1mhdkSymoJXLbAOOj8O0e5gfxlvrmlEZXZNt3giyRYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8XNlCFCbnxAzQntooS2ncidv+wXv3RjaJIBOQ+IUwedHnaoFc18YyrqzHs9X/2mahYDWRq/o9ltMEWtBQfrFkaj7AOlnJ79e2IrgJxJIbDeD3F3Xns9SxyDFj6mqbiAJyLHBLa4Hss9IFQ8kOYzdPiw7LQrZBIQsvin9gQSnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XjSy/IUj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so7385953a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741678513; x=1742283313; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1mhdkSymoJXLbAOOj8O0e5gfxlvrmlEZXZNt3giyRYM=;
        b=XjSy/IUjFoRCIaDG0Bx4dxp5FWdCUFRm/nVF5gQlGCPGs8iwwct+/qGbh79UC2MLz3
         WM/RTVBlk/WL33wOpFgDU0Go0jRy1RZ5qpQR0Aw2TpWgx4BiKTdO73F+cWcjps5DpxF6
         UKIJLD2uxgXF4AvcMbUjA9oIHCStYoEqcUESeAfDlrETreku+bYISVjtUh707nxOg6M8
         ek2OTaXhdhCzOS6v+1d2nJc6jiBv26WmmK2CFHEl857JmKXHLz0MU8g1Xj//SEotUm+6
         pUENdB1p6h+0iwGcA2YajWAzaoufK9G50H4ySdjfMlCWZmKAmmmNs/pRIUQ+tu7ThOTm
         0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741678513; x=1742283313;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mhdkSymoJXLbAOOj8O0e5gfxlvrmlEZXZNt3giyRYM=;
        b=px62XewfQFAPb3gW5rJvv8WZwBbcLaoL1OcShbs4PrEwwwW3gMIZft+RogupgeyUeg
         nuJC5Hi248X2LQfuEyAeZzfPcP2X6Q8WVa4SJFi8k8d42MPtgfq29/ocY82tuyE9NWcM
         pUUK4FuPh/7oSCnQQViZ0d/69+n76A7ClzKKqJwBlKP6+dxBGgsarbV5Z0QHcKH8xCb7
         PlHWBIb3f+7AC8/6TEmtYvKuAITRGKuuij85XajcnH+k3UYWU7vnjCLRZuJUnK8Vtwjy
         UlluDbWFqhewI1DP9lNZO3/H3C+Wi+hnUXzjYvkE1Xevfc5THowxBKgxIsNISLpPVVvx
         Ko8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUutV887hSEcOD9xkeoyWk3kWe04WhpvBu7JbARgoEGNdcJiTiXMaI3TmmUZ6H3t6G+kEntC9UtJL94XkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29P0NpbDTWVncxIhF7bdpEdF51zLFiBwpXZ/flsq4hHs3VEHk
	/UGgkodRzREbfkOffrVPnPdJPyHgJq3QZ62i2WwW3NWWYBkQMNf0zK3j7HwMu1U=
X-Gm-Gg: ASbGncvMHv0a3oY0pzkndnsnD52uy+4xI8q1rKDSt1oTZTr2P5sIISQLmfbEwBr1LCE
	H7kF4pVVFySqmkY2y4KHRGxgfHSmCVTlQtcCr5rj1nl6oLBHzX+YsO1tLWaWOR/elWjNTvlnMgc
	PJp53VtHUycsOnmN4IFvZ9NaybB6vlg/r48TUKtVDd1UaxzpG4QJSz35M7azMpw6GWRnHFXSSmU
	q9MuT2EXIYEY71osOiyLd+TcV5gcrbdY3Rg1+JysPJ8Jxi2U67ViYAZixPDoQq4hMgKsRHhbIjv
	EJ4oH0MzFA0eYQhK/AQgUbt0qXy8h0asvVGtbpncoZKiEb2DsYWdRMyd3qwaf1LkG6JoaRy56xw
	YsGDH5lChsLRg16cG1hJE9zigggAJl8sxoUeDp+VhVZTGn+SoujQS5pIFYcXypBj5svk=
X-Google-Smtp-Source: AGHT+IGvm3HtbKUymTA/FtwZPwpY+ix1v4SXw4YlKtu9LDBt46FHoxqUD2ZoSyZ0AZpjtqN6iYDGtQ==
X-Received: by 2002:a17:907:2d12:b0:ac1:deb0:5c3e with SMTP id a640c23a62f3a-ac2b9de96a3mr282629466b.16.1741678512845;
        Tue, 11 Mar 2025 00:35:12 -0700 (PDT)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943945asm866456266b.22.2025.03.11.00.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 00:35:12 -0700 (PDT)
Message-ID: <78d2f36a-a2be-4fb6-8484-6fa0df50a419@suse.com>
Date: Tue, 11 Mar 2025 08:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/mcelog: Add __nonstring annotations for unterminated
 strings
To: Kees Cook <kees@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250310222234.work.473-kees@kernel.org>
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
In-Reply-To: <20250310222234.work.473-kees@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XBJjVsBfgWo0WeZkAToK60dU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XBJjVsBfgWo0WeZkAToK60dU
Content-Type: multipart/mixed; boundary="------------37w7aYirA0kQ6hIWxrjOTvI0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Message-ID: <78d2f36a-a2be-4fb6-8484-6fa0df50a419@suse.com>
Subject: Re: [PATCH] xen/mcelog: Add __nonstring annotations for unterminated
 strings
References: <20250310222234.work.473-kees@kernel.org>
In-Reply-To: <20250310222234.work.473-kees@kernel.org>

--------------37w7aYirA0kQ6hIWxrjOTvI0
Content-Type: multipart/mixed; boundary="------------0jA3M0zgWTTF0Vc2RtvHJILA"

--------------0jA3M0zgWTTF0Vc2RtvHJILA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDMuMjUgMjM6MjIsIEtlZXMgQ29vayB3cm90ZToNCj4gV2hlbiBhIGNoYXJhY3Rl
ciBhcnJheSB3aXRob3V0IGEgdGVybWluYXRpbmcgTlVMIGNoYXJhY3RlciBoYXMgYSBzdGF0
aWMNCj4gaW5pdGlhbGl6ZXIsIEdDQyAxNSdzIC1XdW50ZXJtaW5hdGVkLXN0cmluZy1pbml0
aWFsaXphdGlvbiB3aWxsIG9ubHkNCj4gd2FybiBpZiB0aGUgYXJyYXkgbGFja3MgdGhlICJu
b25zdHJpbmciIGF0dHJpYnV0ZVsxXS4gTWFyayB0aGUgYXJyYXlzDQo+IHdpdGggX19ub25z
dHJpbmcgdG8gYW5kIGNvcnJlY3RseSBpZGVudGlmeSB0aGUgY2hhciBhcnJheSBhcyAibm90
IGEgQw0KPiBzdHJpbmciIGFuZCB0aGVyZWJ5IGVsaW1pbmF0ZSB0aGUgd2FybmluZy4NCj4g
DQo+IExpbms6IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lk
PTExNzE3OCBbMV0NCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4g
Q2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4gQ2M6
IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4N
Cj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IEp1ZXJnZW4gR3Jv
c3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------0jA3M0zgWTTF0Vc2RtvHJILA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------0jA3M0zgWTTF0Vc2RtvHJILA--

--------------37w7aYirA0kQ6hIWxrjOTvI0--

--------------XBJjVsBfgWo0WeZkAToK60dU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfP568FAwAAAAAACgkQsN6d1ii/Ey+g
5wf/UstPh1Q1G6ZfNETvmwHQV5SmAtiXW7xg1foPF3jIcFKyRxbnh5LzOJV+dt6aYiTm8pHq65eM
3R4WKqAg7aDVLk05brMWflHlo79NRXHhdBEmFxRTWIysPvcUXv6W2RqYsV7izitN/qlYybh4nwU/
hQ9ajSBsQA72iUzc2MR4yrYYicOcmZg6fyaath6Y3jTOa9+GGMmv5lipgKEjkGc7zHaVllfqFO9Q
Jx9SgpiqtwA+rWzyjWG+Y8lSqOAKL9uFvOuVn09qeOWL5o/UIoywOzXkkcjldfqKLk1fIxvKHqNG
asotqrXb+ObMtiOga1bFWFJwf2KUbfL4rlcvzvfraQ==
=4O3N
-----END PGP SIGNATURE-----

--------------XBJjVsBfgWo0WeZkAToK60dU--

