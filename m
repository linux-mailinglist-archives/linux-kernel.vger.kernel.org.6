Return-Path: <linux-kernel+bounces-545275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63437A4EB8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A858E2D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9852620DC;
	Tue,  4 Mar 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dkrR2ZmI"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3E25DB16
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110930; cv=pass; b=Iux4H6dlEdzVq5iotul4PRwgCIaOlnHIT2Wo4OQCQNg9w+x7vVpWh8oyQO8sboTxesd3EFjP64VzaAoKZYsZFHDWcwUXvZENMa3aqz1Y/DKjBod8xTxNNCMH0h6tMIn+o+tuhtE13cEaH7FNr2G27yAUXKExF20VFU18B6w0SMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110930; c=relaxed/simple;
	bh=e7YFdy4OM9A15RQd6ls1JCXYVTnu6t3HPIYubF1hUoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrWVkqaan8zCIOfq8cHmIndohAdwO2ZXvy1KnewSifl4Hi40+GJoXtOOiUXNyC1LRH7CK8UlqfzsDLGY+5OdouzDCXCYyRQKTXKqM03+NnK8QZ1JmtpQuRzV35xj/HB/2NPziS5LDj1ir6jdiaYyjbbvlJwp4/rh4U5XlOTzcRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dkrR2ZmI; arc=none smtp.client-ip=209.85.208.46; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 95C5C4089531
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:55:26 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dkrR2ZmI
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fQV4Ry0zFyg9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:16:02 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id F38344272B; Tue,  4 Mar 2025 18:16:01 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dkrR2ZmI
X-Envelope-From: <linux-kernel+bounces-541118-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dkrR2ZmI
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 610DB42B7D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:05:43 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C34E23064C0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:05:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317ED3B1074
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69241EF091;
	Mon,  3 Mar 2025 08:05:11 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030B1E3762
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989107; cv=none; b=psym83iYYTmpqq11S7UaDQkygYvaT4TXrliFn/HUFFB23E+X6zSQPZ7MDReVUcJ/Mu/oAkB8HzZNt6/5tRI1G0SMxu1Ek6Z81xAn1p3mWp5XdYhuwMlOHhyMSTkO3OMWMaUdLCW6yxFfeqL42cfnsLPR1MrmpeaArCtev2ICbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989107; c=relaxed/simple;
	bh=e7YFdy4OM9A15RQd6ls1JCXYVTnu6t3HPIYubF1hUoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/+3UDeIlGAn+DD+/uE16SDIrJi4aNHXJcLI0BERuvxuDU4TV8/ZqsoptHao0+JKbyoJM+763QsDUQtgSNv3GsHV3d8eTOgVpe+T+RzGIfyS1yZuwinEgC90g8oECw92qxG6TfykNVSv9n1JQeVXZtNQyo56ZJZD7vPNbyxGPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dkrR2ZmI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso5553519a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740989104; x=1741593904; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7YFdy4OM9A15RQd6ls1JCXYVTnu6t3HPIYubF1hUoc=;
        b=dkrR2ZmIC5oqsxsCDMgz8cSnBN9xa5qI6NLAAZB13GBe3KlF3zHL5dMw5eORdtshSb
         rYjJn1lS3Qg2vt2Xvyu/AjDREsUhVCuPlXvLWBh3XgKXAECWWdoVnPadArlZR9wJneim
         awYpI9XMUGSYPVBH39jvTOQ58Rj9kvBh5UizX7L946SgvtxfXObzEabv8x7fV4iHp1wQ
         iCu8r9Flnq8POKzGQFumgy45Rs9MXUWgee+cfd2vUIteCilP/P6aOxBoXKk/LZ/WDcwr
         0ol0sjhlkx1W919i1HGL8AFEbbGyLXoWKhMuJNdQdPYNUwjCGwpOMX/RIKyBn+KwHrt2
         oI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989104; x=1741593904;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7YFdy4OM9A15RQd6ls1JCXYVTnu6t3HPIYubF1hUoc=;
        b=Z49fAZwCDqLqz+6SZVfkk7+l817E1SnowNM/f0jVcagAA0STa4+lNDx/ff0c3wsBVD
         bb250QHwO245nR5AxDZxu6Em96ncW4+7OqwVtjyWHyX/TWLUW/u9rYcrmLNJ9+SqbVy3
         VXNPrx0HbrIrjpAzWwaVCV46WHXBC5d0a9RuSuFjUfo0frseFS/ZalIEslmhopXvAbt9
         jQukm0DapmfIeHO+UU8traAuTAvc4K6Q4p8CYNW0aW1t10V8LdcRmv+xflDT5hjo/nas
         pj6e/vprf3ih1iUj1NAJNVcO0qelsDk+H85h6Es/uoE5tnfz4fA/Pi604wTf5HMwfcBW
         5UiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQVlpa5cLursW9UA5K1n8P3Xb6DN152nY+y7zi/fZf0NgCPnYiM7fld/q4/w9QJ363TKLG1Y7EEJTGbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWtv91dT3Q8nlD+gY/XxoOYMAtp7wUXlpaQl6DVA0xtSPpDRB
	CUrr2Z0kI7Z4Q7vfFKite5R16KbOFRkqutffJroH8v0g7LS0oN7Kd4pN6Srdmu0=
X-Gm-Gg: ASbGncvNYiimOTHdKLC6AP59zq5kw+aOfXVp2iUIWdw5WCMy0POpeV7EONgvxjcqUm1
	VKuIzagWHYCerQlwR7g2e2rz2BfI2Kbp+By1CEuWP8aLXdI16TUyV673xJBoVRtj6r6doWoayaa
	5VTA9SaDkN0GVzRny3QHjRWMaoxwefJ7eLzvFifWy7/aMMlf5e72//3J0aVW/WkDDHNa4kea/y2
	TIr5RicMoHt2fimKw3oXy9mvjEV56vZ+aneIpnVkUuP6U6lS9v7JaEPNjhbMDWnzV2eoANSM5/W
	R3P1Jq7jd5HxVGx9v0dP5EpFbxgxt4u08lCwOM6t0IoxaqEykxFyxDoElMNoUsvCqpD8ZPWodNt
	6dg7XLWPBlYQlh4L6tWryDfxvsSihE15CmqHit5Qk4T6fxVnpDbcxc5UMXZggP6Oh1Ps=
X-Google-Smtp-Source: AGHT+IHcteq8GJcA8egMxaE5GGFglgzZBN9V1TA9C24nX4sefqjtCREuJ3pc8X4tFi3POadG8HfMXw==
X-Received: by 2002:a05:6402:278f:b0:5e4:ce6e:3887 with SMTP id 4fb4d7f45d1cf-5e4d6acd5c5mr11620652a12.4.1740989103604;
        Mon, 03 Mar 2025 00:05:03 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb66fbsm6485778a12.37.2025.03.03.00.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:05:03 -0800 (PST)
Message-ID: <1b8c935c-fe5d-48e4-b46b-82ef78618ef6@suse.com>
Date: Mon, 3 Mar 2025 09:05:01 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/paravirt: Remove unused paravirt_disable_iospace
To: linux@treblig.org, ajay.kaher@broadcom.com,
 alexey.amakhalov@broadcom.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20250303004441.250451-1-linux@treblig.org>
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
In-Reply-To: <20250303004441.250451-1-linux@treblig.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0f4h4UJBEa8ZRUTvIWdJfvAd"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fQV4Ry0zFyg9
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715637.18378@EDE2XiDP7upQCr2D/Pq9Aw
X-ITU-MailScanner-SpamCheck: not spam

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0f4h4UJBEa8ZRUTvIWdJfvAd
Content-Type: multipart/mixed; boundary="------------lTofNPbEBMnK4h30uldLeIct";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: linux@treblig.org, ajay.kaher@broadcom.com,
 alexey.amakhalov@broadcom.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Message-ID: <1b8c935c-fe5d-48e4-b46b-82ef78618ef6@suse.com>
Subject: Re: [PATCH v2] x86/paravirt: Remove unused paravirt_disable_iospace
References: <20250303004441.250451-1-linux@treblig.org>
In-Reply-To: <20250303004441.250451-1-linux@treblig.org>

--------------lTofNPbEBMnK4h30uldLeIct
Content-Type: multipart/mixed; boundary="------------uXnkxPatSum4tNecaMFawSs8"

--------------uXnkxPatSum4tNecaMFawSs8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDMuMjUgMDE6NDQsIGxpbnV4QHRyZWJsaWcub3JnIHdyb3RlOg0KPiBGcm9tOiAi
RHIuIERhdmlkIEFsYW4gR2lsYmVydCIgPGxpbnV4QHRyZWJsaWcub3JnPg0KPiANCj4gVGhl
IGxhc3QgdXNlIG9mIHBhcmF2aXJ0X2Rpc2FibGVfaW9zcGFjZSgpIHdhcyByZW1vdmVkIGlu
IDIwMTUgYnkNCj4gY29tbWl0IGQxYzI5NDY1YjhhNSAoImxndWVzdDogZG9uJ3QgZGlzYWJs
ZSBpb3NwYWNlLiIpDQo+IA0KPiBSZW1vdmUgaXQuDQo+IA0KPiBOb3RlIHRoZSBjb21tZW50
IGFib3ZlIGl0IGFib3V0ICdlbnRyeS5TJyBpcyB1bnJlbGF0ZWQgdG8gdGhpcw0KPiBidXQg
c3RheWVkIHdoZW4gaW50ZXJ2ZW5pbmcgY29kZSBnb3QgZGVsZXRlZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGxpbnV4QHRyZWJsaWcub3JnPg0K
DQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1
ZXJnZW4NCg==
--------------uXnkxPatSum4tNecaMFawSs8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------uXnkxPatSum4tNecaMFawSs8--

--------------lTofNPbEBMnK4h30uldLeIct--

--------------0f4h4UJBEa8ZRUTvIWdJfvAd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfFYq4FAwAAAAAACgkQsN6d1ii/Ey+Z
3Af9FzD1wn/1GgJIvaua64shVpZpZIRdku4XwkFIp3/dy+GjhCp/N3Z/rYlu7imqsiLWmAR/wW4e
IiFpriOU9scDqGkCCuukYwjLEUfzGqT+JB770xYjPio1hpf/t81bMxv2dGFvkRb6XkSsarl3NLHg
djgj0RH4taBFxU3dUAboPGrX0RdXrYqwQcxPQy0UMxOQPg11J25mMm9qTr5K6eSirjqts6yMrwGp
lbaF1YjySxm9qxSPuTrLd8HAl0hmjpkfmdH1WryV5uyp1KKiXEndtplSNnNRDcbesvYMWUugOOnA
a922fGYAPsXkQYrkqfhz+bg7bhYr9JhKhZDk5NXeOg==
=8vNW
-----END PGP SIGNATURE-----

--------------0f4h4UJBEa8ZRUTvIWdJfvAd--


