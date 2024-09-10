Return-Path: <linux-kernel+bounces-323183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A718997390D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26528B219D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C885192B62;
	Tue, 10 Sep 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KcH6NVgB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE61EEE9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976155; cv=none; b=g04c9xOPzO9iIuNE89oj7TNq7UHZe2ykbilERm+2PHpw0rrd7r82HYBbTkOCnBUI46xCi3O1Ov/5FR7DO9Ky478zUDrpJ/vlV1Y0gJDckdCOOjx9+L3yC1QvmwD4ojGahXcc2+jAquq1u7FYA4812bwZVeCmbi8CyWxFaloq8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976155; c=relaxed/simple;
	bh=0LoIftrOHBTW4CrP1J5bb2jmbdEPTRwxD1ZYyVTiLpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHaLbL4GR4xwXc8qJdGx+WejvXFzP04qpBztMiry3Oy91vPIxww2y/jrGAmFE1Z1xgMTo6WsTqzy4LeJXnOTyqYd7rGfhdt9iX/31FjsecOdi3VpyT+fTesm1+ZFOymtNaIP2OPfZOLnYIW+65QWCyQ9aLRC1zb6sXI/8nziKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KcH6NVgB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so516733366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725976152; x=1726580952; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LoIftrOHBTW4CrP1J5bb2jmbdEPTRwxD1ZYyVTiLpA=;
        b=KcH6NVgBy7OG2THPT5Q5HUZYgmYOqVKKSGAFwMg3BS0XMCvATNpxitCZFTNWHsOL2q
         mfJi+L1PktEZ0wJGRQcpK2Pw9H3WcWm3/kQZlcjgT1xfg+wG9gbaN5UZaLJ/I5gIN8lQ
         h8LoLcqW4/maYW41BoNEMSgQoyFr9no8rGWgmMz7ZFBytVTRt5xoMHat/Rwb0r26DDmx
         rSguaL1xzKhLABhMCYWBRJj1/pmexmTpDiUVbwo0rSTUCUNN3/yex+ah7POSQbIqwIlZ
         Um1kkomQEmzC5HP9qKJPRphW6Ue4uNtyCUnEufrSApN2nwLfUNdjUB3XoRdWFMmKY2YP
         oQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725976152; x=1726580952;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LoIftrOHBTW4CrP1J5bb2jmbdEPTRwxD1ZYyVTiLpA=;
        b=UbQbN8hPmlyXG0th0O2xS/DoF6FscPPsMK3ZFNMnf0qPu+QG7UYFvJu3dxjJGYbsKJ
         AjC1UcWSTWow+fTKGBUd7Z29ioDudV3pMF4/Yqnhix84hnv6WlgLp2ULwAGSxnscqfn5
         gDUz/75PYgVi3M5ofA6plvCGd4ofzMNMHUkat7/ah9aNnPTXfmAM8YkWwv3QW61TcFjm
         GAOdENlJ61Mlu3UfxJkh7f3hBPPMSYFyiVSQWlmBRxWHkI2708fyATErPBBuY5LD20u4
         QleEpNkw3TzPz8PunZLSCDqIUSa0WlkpjLM/9ej95sR3BWFff6+QbwDQeyCoHGsmxToa
         z52w==
X-Forwarded-Encrypted: i=1; AJvYcCVdPVkcEdUkdUAbG2/Qn6btt1Delt0kaYfGxxF2cQpERQzIB8iXHj81V+KhAC/TMFSorI07PPvMvAx9+TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IkXAzT4XUCWNy68dfExsZ3FJSxLamuFnONlxLJqT3hmhqN9K
	DnYSrE1p1v7UTPcJsBLmMcZHWoZ3NUcP259rTuIYiNc3OUBTLrRAEQjgZZhk+kQ=
X-Google-Smtp-Source: AGHT+IE0c4/lrn0axjjGwaH3ZOXGkEPaNctmG1XT06pFU0lmXNoq02xR9lae8DqfthvvzyAR8YT9Bw==
X-Received: by 2002:a17:907:2d88:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a8ffada217amr81582066b.45.1725976150665;
        Tue, 10 Sep 2024 06:49:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e71sm482295466b.139.2024.09.10.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:49:10 -0700 (PDT)
Message-ID: <033ad52d-f8b7-4dc1-9ddf-09d18eb7f915@suse.com>
Date: Tue, 10 Sep 2024 15:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] xen/xenbus: Convert to use ERR_CAST()
To: Shen Lichuan <shenlichuan@vivo.com>, sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240829084710.30312-1-shenlichuan@vivo.com>
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
In-Reply-To: <20240829084710.30312-1-shenlichuan@vivo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bLlOD100f6T9RScpzqhJImQH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bLlOD100f6T9RScpzqhJImQH
Content-Type: multipart/mixed; boundary="------------rRI2YqotK34HnVQKRF6ie0vU";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Shen Lichuan <shenlichuan@vivo.com>, sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Message-ID: <033ad52d-f8b7-4dc1-9ddf-09d18eb7f915@suse.com>
Subject: Re: [PATCH v1] xen/xenbus: Convert to use ERR_CAST()
References: <20240829084710.30312-1-shenlichuan@vivo.com>
In-Reply-To: <20240829084710.30312-1-shenlichuan@vivo.com>

--------------rRI2YqotK34HnVQKRF6ie0vU
Content-Type: multipart/mixed; boundary="------------HhA0Rv1XbYth7PeT1tZZTKc4"

--------------HhA0Rv1XbYth7PeT1tZZTKc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDguMjQgMTA6NDcsIFNoZW4gTGljaHVhbiB3cm90ZToNCj4gVXNlIEVSUl9DQVNU
KCkgYXMgaXQgaXMgZGVzaWduZWQgZm9yIGNhc3RpbmcgYW4gZXJyb3IgcG9pbnRlciB0bw0K
PiBhbm90aGVyIHR5cGUuDQo+IA0KPiBUaGlzIG1hY3JvIHV0aWxpemVzIHRoZSBfX2ZvcmNl
IGFuZCBfX211c3RfY2hlY2sgbW9kaWZpZXJzLCB3aGljaCBpbnN0cnVjdA0KPiB0aGUgY29t
cGlsZXIgdG8gdmVyaWZ5IGZvciBlcnJvcnMgYXQgdGhlIGxvY2F0aW9ucyB3aGVyZSBpdCBp
cyBlbXBsb3llZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoZW4gTGljaHVhbiA8c2hlbmxp
Y2h1YW5Adml2by5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NA
c3VzZS5jb20+DQoNCg0KSnVlcmdlbg0KDQo=
--------------HhA0Rv1XbYth7PeT1tZZTKc4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------HhA0Rv1XbYth7PeT1tZZTKc4--

--------------rRI2YqotK34HnVQKRF6ie0vU--

--------------bLlOD100f6T9RScpzqhJImQH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbgTlUFAwAAAAAACgkQsN6d1ii/Ey8a
pgf/QgIh5XIe4UlM/z8E+ngOtf8U9ZsSzB6BKfcw9W0Cn3W3h9dUqS8bXq8YtVtW6rsqRdKJKTF7
V1MVGeKd8QL5ZKIm2Hi4eFoO53F9NyDGbIiiguyAH+YmMAYs0BKbW/ZGvCQjDjvGWFCtWvGdQs0E
FnjGxyfpcqCwwD78emJt46TOcNYxH0P0VdqY9pJhJioTntL4S5X338LfwdZgSgH5M3LgNXTr2qel
zVHTYt7JB73FH5YFVgowYRqHja/8HIDu48At6I05RTd1ioSql6gzZcHmcZXytYc4iwDJ3QpmK+te
LIvFU1JVUzla6d+rsX6RWCslVG2ai9ky9N0ak7WIRQ==
=/1s2
-----END PGP SIGNATURE-----

--------------bLlOD100f6T9RScpzqhJImQH--

