Return-Path: <linux-kernel+bounces-297165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2595B401
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF440B2300C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72A1C93C9;
	Thu, 22 Aug 2024 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BJjes7Jz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56B23774
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326686; cv=none; b=s/TreYOWX4vxlT6LtT49HetMbBYvpbDED89p3KTPSJ0qmePuiXgsZaJkTIVdLYcU50npoOyCrYM3YoYodQ2mAT4Ew7jt5R9dv0pZe0R2fXDdI6OwDC7wQ3nxVGfc9W1bfh4vicS0LlowDWJIZ0gwDHNCwFToDcsQyitZ8AdMH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326686; c=relaxed/simple;
	bh=sJdmQAnQ+WjHgnIh8xPxFiV5NCA+OBzJFv7tQkP4VUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaZBZaaze9V+0K8stYuSvqEubcxoTbBJWa63rmiH6kw3vE3ruJHQ4gKOksrSLBn1kDryxcJdRxl1tJG5W2JhI6jTnPhYH6xuhgLCIELLJHB9DxnvVvpD/KJBfVpOfPMtR+nDzRI+RWw8C54fM5jY7NK189RWkmuTscrxSI8FNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BJjes7Jz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso910833a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724326683; x=1724931483; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJdmQAnQ+WjHgnIh8xPxFiV5NCA+OBzJFv7tQkP4VUs=;
        b=BJjes7JzqRx0baa1+pGUOa157U8hczhoig3J/78j4AHOeE7QyJ6FbmFJbHt1nqzZzX
         WVzGYJXwZowVH3Q/SjBnBaAkW4M/SRaOFiUvL6XMEECexSnOzf4g8EAO9uogFZ2dj7h4
         wc0iSZwqDnpj3D66cnPBE9JrhDAscGxEzG4m3GMqO6jcqc0ENA5EJW9Pj2ypERqYMq1A
         489tFzhsHRr6V48RWrO9zffEweM/r7Sn0z0yl7RX+G3faXgXwyTX4ilFhn3D8zQKZQMN
         +x6QW1wymnSH+1bQ79PCkdn1KSMuumjWUL9AAV8RgoZ0FiJlWEDHp/ZP7gCohkv+rlcw
         Ov9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326683; x=1724931483;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJdmQAnQ+WjHgnIh8xPxFiV5NCA+OBzJFv7tQkP4VUs=;
        b=lYHY0bvEW+wcpy59BeUgO7qPi+jhqr8J9XYAyykiif2krVd3ZtfgbPInuWlnPerIBj
         lg0LpH0QAJYQwAj6Hb0XlXXCfmDDjycXoBf4LHHohL1w4BnJOgxXwPiYhzshB9SmKibd
         WOb//d1B73s7QDoSBQKHxl+Gdtdr2rWXv8JaUM/APH497QBHWylFl6ZqPLDjNrUuKQj0
         +6ZiYsHwE+zDXGEDxF+EA8PQJw9CQ+ZdNotNKOQk/NJ7Svo8xvzV6aP3Oq/hMmzkXzC7
         dmrTIc7mlOqD+SjXenCUHAfPmzO7E3yMiKC75la//503jfpWeMJs/2NjE/R7DphTOhMa
         Li7A==
X-Forwarded-Encrypted: i=1; AJvYcCXTwfSsGAUdUQl6YJcmAn2Q+PfwbH7PWYPOX/tLeIyQV1mChveOdWCvYnIdiBhPE6Eek1drlDUCJzz9gsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWEvEAqDuOB5OEotfr3biGLOhVbLckDN/wHSI666ezzwHPb/H
	hJl+EEBgHVzNzluTcN2Dh/FgDgBHQKmBHwP2EzMId8DbvFjse4xfEOgEQGKk64U=
X-Google-Smtp-Source: AGHT+IEEAPDNQM8QynTgzdLRChgmNngee/anGeB9xOhx5eDJffpAiK39fnVrLvhh95vVtman9bl6Rg==
X-Received: by 2002:a05:6402:42cf:b0:57c:a422:677b with SMTP id 4fb4d7f45d1cf-5bf1f0a3dadmr4101519a12.8.1724326682029;
        Thu, 22 Aug 2024 04:38:02 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb0bdsm824811a12.37.2024.08.22.04.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 04:38:01 -0700 (PDT)
Message-ID: <e6095474-5000-410b-95b3-c0eeaf092042@suse.com>
Date: Thu, 22 Aug 2024 13:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] xen: move max_pfn in xen_memory_setup() out of
 function scope
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-5-jgross@suse.com>
 <b9556863-1536-4310-8005-f92e8948356c@suse.com>
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
In-Reply-To: <b9556863-1536-4310-8005-f92e8948356c@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NqhL8iUBds9zY3LNAUCVnaGy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NqhL8iUBds9zY3LNAUCVnaGy
Content-Type: multipart/mixed; boundary="------------wzC2blJaBzKnJO4Y4FUmdHf0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Message-ID: <e6095474-5000-410b-95b3-c0eeaf092042@suse.com>
Subject: Re: [PATCH v2 4/7] xen: move max_pfn in xen_memory_setup() out of
 function scope
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-5-jgross@suse.com>
 <b9556863-1536-4310-8005-f92e8948356c@suse.com>
In-Reply-To: <b9556863-1536-4310-8005-f92e8948356c@suse.com>
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

--------------wzC2blJaBzKnJO4Y4FUmdHf0
Content-Type: multipart/mixed; boundary="------------dxO4Bp0027Ss3LyctKwRJ0vD"

--------------dxO4Bp0027Ss3LyctKwRJ0vD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDguMjQgMTA6NDQsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyMC4wOC4yMDI0
IDEwOjIwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gSW5zdGVhZCBvZiBoYXZpbmcgbWF4
X3BmbiBhcyBhIGxvY2FsIHZhcmlhYmxlIG9mIHhlbl9tZW1vcnlfc2V0dXAoKSwNCj4+IG1h
a2UgaXQgYSBzdGF0aWMgdmFyaWFibGUgaW4gc2V0dXAuYyBpbnN0ZWFkLiBUaGlzIGF2b2lk
cyBoYXZpbmcgdG8NCj4+IHBhc3MgaXQgdG8gc3ViZnVuY3Rpb25zLCB3aGljaCB3aWxsIGJl
IG5lZWRlZCBpbiBtb3JlIGNhc2VzIGluIGZ1dHVyZS4NCj4+DQo+PiBSZW5hbWUgaXQgdG8g
aW5pX25yX3BhZ2VzLCBhcyB0aGUgdmFsdWUgZGVub3RlcyB0aGUgY3VycmVudGx5IHVzYWJs
ZQ0KPj4gbnVtYmVyIG9mIG1lbW9yeSBwYWdlcyBhcyBwYXNzZWQgZnJvbSB0aGUgaHlwZXJ2
aXNvciBhdCBib290IHRpbWUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KPj4gVGVzdGVkLWJ5OiBNYXJlayBNYXJjenlrb3dza2kt
R8OzcmVja2kgPG1hcm1hcmVrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+DQo+IA0KPiBSZXZp
ZXdlZC1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQHN1c2UuY29tPg0KPiANCj4gSSB3b25k
ZXIgdGhvdWdoIHdoeSAuLi4NCj4gDQo+PiBAQCAtNzEyLDkgKzcxMyw5IEBAIGNoYXIgKiBf
X2luaXQgeGVuX21lbW9yeV9zZXR1cCh2b2lkKQ0KPj4gICAJaW50IG9wOw0KPj4gICANCj4+
ICAgCXhlbl9wYXJzZV81MTJnYigpOw0KPj4gLQltYXhfcGZuID0geGVuX2dldF9wYWdlc19s
aW1pdCgpOw0KPj4gLQltYXhfcGZuID0gbWluKG1heF9wZm4sIHhlbl9zdGFydF9pbmZvLT5u
cl9wYWdlcyk7DQo+PiAtCW1lbV9lbmQgPSBQRk5fUEhZUyhtYXhfcGZuKTsNCj4+ICsJaW5p
X25yX3BhZ2VzID0geGVuX2dldF9wYWdlc19saW1pdCgpOw0KPj4gKwlpbmlfbnJfcGFnZXMg
PSBtaW4oaW5pX25yX3BhZ2VzLCB4ZW5fc3RhcnRfaW5mby0+bnJfcGFnZXMpOw0KPiANCj4g
Li4uIHRoaXMgY2FuJ3QgYmUganVzdA0KPiANCj4gCWluaV9ucl9wYWdlcyA9IG1pbih4ZW5f
Z2V0X3BhZ2VzX2xpbWl0KCksIHhlbl9zdGFydF9pbmZvLT5ucl9wYWdlcyk7DQoNCkkganVz
dCBkaWQgYSBtZWNoYW5pY2FsIGNoYW5nZSBmb3IgYWxsIHVzZXMgb2YgbWF4X3Bmbi4NCg0K
SSBhZ3JlZSB0aGF0IHlvdXIgc3VnZ2VzdGlvbiBpcyBhbiBpbXByb3ZlbWVudCwgc28gSSds
bCBtb2RpZnkgdGhlDQpjb2RlLg0KDQoNCkp1ZXJnZW4NCg0K
--------------dxO4Bp0027Ss3LyctKwRJ0vD
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dxO4Bp0027Ss3LyctKwRJ0vD--

--------------wzC2blJaBzKnJO4Y4FUmdHf0--

--------------NqhL8iUBds9zY3LNAUCVnaGy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmbHIxgFAwAAAAAACgkQsN6d1ii/Ey8Q
bAf/UX/4UYiZGWLLExUMGhZ+o7wu/C+KnP8TCv09jKrI3O8Pe3ha/5iXuElbqTEiVYOHAboHlqbL
3Gy2GN8lOri7qr0QDVWvqB9tfW1vKsiH2qJHqvSb1DTjed6q7877fUj1Gnoz8HgECeRzfhs9b9JD
URLpB/JigCy0JMBNKSpyCcuuW4g7NP9hkc5B4hc25Jvfaq3v1T5oaFWLm0QnDWTe2QUdH+X6ibJa
9qWfQkGuXzYu0ccZSrZn3AG1zimiAMzeNdJvO2t72JrEMRBYqKLMWmC7Vke33syC4KtI0Az21Pv1
FIUqPrvvHF3L4ERUSsDGk1btpDe5OPOl4JrXsGeedg==
=TOAm
-----END PGP SIGNATURE-----

--------------NqhL8iUBds9zY3LNAUCVnaGy--

