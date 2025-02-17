Return-Path: <linux-kernel+bounces-510986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29676A3247C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CD5169424
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275020E33E;
	Wed, 12 Feb 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/t3ysDu"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C020D50F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358687; cv=none; b=ltgOQZPKy3RHg9nJg+cayCIdjNeJL1w5QfKdowU9AUaf9jFf9TwJYCxL+EXGEjYNQpVRDK4A2MaZVW0i2/IAHFS4feA4iGhCnNOGHgjhKAOC01tEPQWtr05wZg+Df1qdnnQB1Om7SMUfNwqtcZykgn5XA+CPUO7gErmRtBsKidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358687; c=relaxed/simple;
	bh=1qkKFaMka4B2D8P7AN6cVZ5mTLxCqhwubFloG/acTCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+bXdYrWGqE62oTH3gx/uN8WrLqxxuD5ktCd7jMevsbrxC20v/Hj+iaaseKc91Zd1+LBcOCgTuaZevX9YgIOcWKYudX165EZUuuBVM/d0V5Dw0JDk9gNylgw5o918KxXvEsBrQyzAaM3ioPjON5DvefPM8lmaI5EjkFpZ0ousSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/t3ysDu; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so7634869a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739358683; x=1739963483; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1qkKFaMka4B2D8P7AN6cVZ5mTLxCqhwubFloG/acTCE=;
        b=e/t3ysDuKvbzXbQyg/55m4FuJKk7axO2bX/V9foP8ZvwRYort4osCX0ahwlSoh6cDO
         UEsMDxMAzBl9/QdS5Nuw8TzFuXQrEa0SgfghAKeT9oSdqE/hAll0AXi7Ia9ToFvYbkTB
         OcB2GgXGCOsWYW2pWPc2FK1Z3dcxtTMdPNVVpetGHRT8qZ4Iwnys4iRoDKB++W5DzhR7
         zJJ7Is5jxvw/ZmRuv9sMHK2IJFFnM01ZVlEer6mA0AFLm9oxMAsjUhAcPOxlwBcwfZ2O
         j+hf06w/vYpms4QZJKkZnAphBUupd5EPmJoPxDF34dVPQ6j7/LEqzL68m3EZoRORYZYZ
         p3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358683; x=1739963483;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qkKFaMka4B2D8P7AN6cVZ5mTLxCqhwubFloG/acTCE=;
        b=fdQXHpmkfMmoDnfLwbEiUQvQs5S4EOGf5iSoxjfuE2jtwkPUOnQU55OSW97gF1j+PH
         mc9incx6k3aKU//adIXlKXQTjCfrRVgdxXk/ewGbnWVOm6xQVjahpG7/78N9fLmpSxPA
         S3cQWoBFwAD+qLGOaj+U4V8EocA8WUdej1F7dMWOvDNtY/idhA9FzXVUXbaccKaj3wT5
         5aq5FrCChq0ZNdwM+jJTX1QW1oW/ipK2V84/Z59JwrHJEAxQ1PM+fkS1NzIdA8rQSZad
         ltlKgVANriRrWsZtADsX1+toarDAToUR+QfJ1yDDUh8jt+oa/F/iLwUrQqQV59adqCY5
         suQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWRWW7IqRwNbuXT8Y4KD+8qulw2ghHT/JgAthpQayikxdd6z6et0m07SKXMSnrDf40lWdFSExUbB8UDwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOGeU1fceImiV+pLEctne6mPGb1MbqlAY9VLRNVBdWaXmPtrG
	V4ZGz2YJQ59gaj0OtGy37E0qPEspPtQZHU9Oyhf3sB7rHuADDlq+S+6XfIdvplc=
X-Gm-Gg: ASbGncvJ35p/wIL+OAi38VpXgDUqOJAG03+qpXRWIDI7lo/FclkhpRSU67IhnhBmcDR
	W2A0dGbvsT01iX+DaTKEBP1d4EtJ3BTD9QjFAcWfo4tg1hNtzp4NlKIOfsiCd4wNUlvqFa8oO4S
	uh10ivU9bCW13CeyF+awTxbxXpmAiOO+zv2uAOvOPNW761kVWPS2LzoU9eVFLnstojzasvzyuPQ
	snrjrRicrPZlaf70GrP1cEmGE994Wq4vUdfmaZEu+Al3Mn3QMsbLtBWKZbKdCKsC6lpezaq+yXM
	aESqMfSgbxBwpJ2oU1v0Vmjia3YnJG2x3N04xmLgch45WF6iZLNycgBVtiIAU9CNE+6hJkL93A+
	ulkA0s62WwqYpaEjF4EfsaWU9CC1rMJFkHAjc+A==
X-Google-Smtp-Source: AGHT+IGp1XmhEe7bFYBwJckVwwuH8YHzgzt1G4MGHFa1Wp7fm4ZV4RFYSUK+60nzA3y9C4xdtwEyWQ==
X-Received: by 2002:a05:6402:40c1:b0:5dc:d913:f89e with SMTP id 4fb4d7f45d1cf-5deade0b204mr2387262a12.22.1739358683283;
        Wed, 12 Feb 2025 03:11:23 -0800 (PST)
Received: from ?IPV6:2003:e5:8714:500:2aea:6ec9:1d88:c1ef? (p200300e5871405002aea6ec91d88c1ef.dip0.t-ipconnect.de. [2003:e5:8714:500:2aea:6ec9:1d88:c1ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de62512da4sm7569845a12.81.2025.02.12.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:11:22 -0800 (PST)
Message-ID: <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
Date: Wed, 12 Feb 2025 12:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all
 cases
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-3-jgross@suse.com>
 <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
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
In-Reply-To: <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------T0V8pYgiTd1fxp8HhqGKc2mh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------T0V8pYgiTd1fxp8HhqGKc2mh
Content-Type: multipart/mixed; boundary="------------a04EqXeNz0kYSi0WJAEccu6Z";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux.dev
Message-ID: <ce7320b6-68f3-43b1-8812-3a5bbd75c9c6@suse.com>
Subject: Re: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all
 cases
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-3-jgross@suse.com>
 <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
In-Reply-To: <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
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

--------------a04EqXeNz0kYSi0WJAEccu6Z
Content-Type: multipart/mixed; boundary="------------00ZtQIvLOpTNF0T4lhqryuc6"

--------------00ZtQIvLOpTNF0T4lhqryuc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDIuMjUgMDg6MzgsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMS4wMi4yMDI1
IDEzOjA0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gSW4gY2FzZSB4ZW5fc3dpb3RsYl9h
bGxvY19jb2hlcmVudCgpIG5lZWRlZCB0byBjcmVhdGUgYSBjb250aWd1b3VzDQo+PiByZWdp
b24gb25seSBmb3Igb3RoZXIgcmVhc29uIHRoYW4gdGhlIG1lbW9yeSBub3QgYmVpbmcgY29t
cGxpYW50IHdpdGgNCj4+IHRoZSBkZXZpY2UncyBETUEgbWFzaywgdGhlcmUgaXMgbm8gcmVh
c29uIHdoeSB0aGlzIGNvbnRpZ3VvdXMgcmVnaW9uDQo+PiBzaG91bGQgYmUgZGVzdHJveWVk
IGJ5IHhlbl9zd2lvdGxiX2ZyZWVfY29oZXJlbnQoKSBsYXRlci4gRGVzdHJveWluZw0KPj4g
dGhpcyByZWdpb24gc2hvdWxkIGJlIGRvbmUgb25seSwgaWYgdGhlIG1lbW9yeSBvZiB0aGUg
cmVnaW9uIHdhcw0KPj4gYWxsb2NhdGVkIHdpdGggbW9yZSBzdHJpbmdlbnQgcGxhY2VtZW50
IHJlcXVpcmVtZW50cyB0aGFuIHRoZSBtZW1vcnkNCj4+IGl0IGRpZCByZXBsYWNlLg0KPiAN
Cj4gSSdtIG5vdCBjb252aW5jZWQgb2YgdGhpczogRXZlbiB0aGUgbWVyZSBwcm9wZXJ0eSBv
ZiBiZWluZyBjb250aWd1b3VzDQo+IG1heSBhbHJlYWR5IGJlIGVub3VnaCB0byB3YXJyYW50
IGZyZWVpbmcgd2hlbiBwb3NzaWJsZS4gVGhlIGh5cGVydmlzb3INCj4gbWF5IG5vdCBoYXZl
IHRoYXQgbWFueSBjb250aWd1b3VzIGFyZWFzIGF2YWlsYWJsZS4gVGhlIGJpZ2dlciB0aGUN
Cj4gY2h1bmssIHRoZSBtb3JlIGltcG9ydGFudCB0byBnaXZlIGl0IGJhY2sgb25jZSBubyBs
b25nZXIgbmVlZGVkIGluDQo+IHRoaXMgc2hhcGUuDQoNClJlYWxseT8gV2hlbiBjcmVhdGlu
ZyBhIGRvbWFpbiBYZW4gdHJpZXMgdG8gdXNlIEdCIHBhZ2VzIGFuZCAyTUIgcGFnZXMgYXMN
Cm11Y2ggYXMgcG9zc2libGUuIFdoeSB3b3VsZCB0aGlzIHNwZWNpYWwgY2FzZSBoZXJlIGhh
dmUgbW9yZSByZXN0cmljdGlvbnM/DQoNCj4gUGx1cyBhbHNvIHRha2UgaW50byBhY2NvdW50
IGhvdyBYZW4gYmVoYXZlcyBoZXJlOiBJdCBzcGVjaWZpY2FsbHkgdHJpZXMNCj4gdG8gaG9s
ZCBiYWNrLCBkdXJpbmcgYm9vdCwgbG93ZXIgYWRkcmVzc2VkIG1lbW9yeSB0byBsYXRlciBz
YXRpc2Z5IHN1Y2gNCj4gcmVxdWVzdHMuIEhlbmNlIGV2ZW4gaWYgeW91IGRvbid0IGFzayBm
b3IgYWRkcmVzcyByZXN0cmljdGVkIG1lbW9yeSwNCj4geW91IG1heSBnZXQgYmFjayBzdWNo
LiBZb3UnZCBuZWVkIHRvIGNvbXBhcmUgaW5wdXQgYW5kIG91dHB1dCBhZGRyZXNzZXMsDQo+
IG5vdCBpbnB1dCBhZGRyZXNzZXMgYW5kIHJlcXVlc3RlZCByZXN0cmljdGlvbiB0byBhbGxl
dmlhdGUgdGhpcy4NCg0KRmFpciBlbm91Z2guDQoNCj4gDQo+PiAtLS0gYS9hcmNoL3g4Ni94
ZW4vbW11X3B2LmMNCj4+ICsrKyBiL2FyY2gveDg2L3hlbi9tbXVfcHYuYw0KPj4gQEAgLTIy
MDgsMTkgKzIyMDgsMjIgQEAgdm9pZCBfX2luaXQgeGVuX2luaXRfbW11X29wcyh2b2lkKQ0K
Pj4gICBzdGF0aWMgdW5zaWduZWQgbG9uZyBkaXNjb250aWdfZnJhbWVzWzE8PE1BWF9DT05U
SUdfT1JERVJdOw0KPj4gICANCj4+ICAgI2RlZmluZSBWT0lEX1BURSAobWZuX3B0ZSgwLCBf
X3BncHJvdCgwKSkpDQo+PiAtc3RhdGljIHZvaWQgeGVuX3phcF9wZm5fcmFuZ2UodW5zaWdu
ZWQgbG9uZyB2YWRkciwgdW5zaWduZWQgaW50IG9yZGVyLA0KPj4gLQkJCQl1bnNpZ25lZCBs
b25nICppbl9mcmFtZXMsDQo+PiAtCQkJCXVuc2lnbmVkIGxvbmcgKm91dF9mcmFtZXMpDQo+
PiArc3RhdGljIGludCB4ZW5femFwX3Bmbl9yYW5nZSh1bnNpZ25lZCBsb25nIHZhZGRyLCB1
bnNpZ25lZCBpbnQgb3JkZXIsDQo+PiArCQkJICAgICB1bnNpZ25lZCBsb25nICppbl9mcmFt
ZXMsDQo+PiArCQkJICAgICB1bnNpZ25lZCBsb25nICpvdXRfZnJhbWVzKQ0KPj4gICB7DQo+
PiAgIAlpbnQgaTsNCj4+ICsJdTY0IGFkZHJlc3NfYml0cyA9IDA7DQo+IA0KPiBGaXJzdCBJ
IHdhcyBpbmNsaW5lZCB0byBzdWdnZXN0IHRvIHVzZSBwYWRkcl90IGhlcmUsIGJ1dCAuLi4N
Cj4gDQo+PiAgIAlzdHJ1Y3QgbXVsdGljYWxsX3NwYWNlIG1jczsNCj4+ICAgDQo+PiAgIAl4
ZW5fbWNfYmF0Y2goKTsNCj4+ICAgCWZvciAoaSA9IDA7IGkgPCAoMVVMPDxvcmRlcik7IGkr
KywgdmFkZHIgKz0gUEFHRV9TSVpFKSB7DQo+PiAgIAkJbWNzID0gX194ZW5fbWNfZW50cnko
MCk7DQo+PiAgIA0KPj4gLQkJaWYgKGluX2ZyYW1lcykNCj4+ICsJCWlmIChpbl9mcmFtZXMp
IHsNCj4+ICAgCQkJaW5fZnJhbWVzW2ldID0gdmlydF90b19tZm4oKHZvaWQgKil2YWRkcik7
DQo+PiArCQkJYWRkcmVzc19iaXRzIHw9IGluX2ZyYW1lc1tpXSA8PCBQQUdFX1NISUZUOw0K
PiANCj4gLi4uIHdoeSBkbyBhIHNoaWZ0IG9uIGV2ZXJ5IGxvb3AgaXRlcmF0aW9uIHdoZW4g
eW91IGNhbiAuLi4NCj4gDQo+PiArCQl9DQo+PiAgIA0KPj4gICAJCU1VTFRJX3VwZGF0ZV92
YV9tYXBwaW5nKG1jcy5tYywgdmFkZHIsIFZPSURfUFRFLCAwKTsNCj4+ICAgCQlfX3NldF9w
aHlzX3RvX21hY2hpbmUodmlydF90b19wZm4oKHZvaWQgKil2YWRkciksIElOVkFMSURfUDJN
X0VOVFJZKTsNCj4+IEBAIC0yMjI5LDYgKzIyMzIsOCBAQCBzdGF0aWMgdm9pZCB4ZW5femFw
X3Bmbl9yYW5nZSh1bnNpZ25lZCBsb25nIHZhZGRyLCB1bnNpZ25lZCBpbnQgb3JkZXIsDQo+
PiAgIAkJCW91dF9mcmFtZXNbaV0gPSB2aXJ0X3RvX3Bmbigodm9pZCAqKXZhZGRyKTsNCj4+
ICAgCX0NCj4+ICAgCXhlbl9tY19pc3N1ZSgwKTsNCj4+ICsNCj4+ICsJcmV0dXJuIGZsczY0
KGFkZHJlc3NfYml0cyk7DQo+IA0KPiAuLi4gc2ltcGx5IGFkZCBpbiBQQUdFX1NISUZUIGhl
cmUsIG9uY2U/DQoNClRydWUuDQoNCj4gDQo+PiBAQCAtMjMyMSw3ICsyMzI2LDggQEAgc3Rh
dGljIGludCB4ZW5fZXhjaGFuZ2VfbWVtb3J5KHVuc2lnbmVkIGxvbmcgZXh0ZW50c19pbiwg
dW5zaWduZWQgaW50IG9yZGVyX2luLA0KPj4gICANCj4+ICAgaW50IHhlbl9jcmVhdGVfY29u
dGlndW91c19yZWdpb24ocGh5c19hZGRyX3QgcHN0YXJ0LCB1bnNpZ25lZCBpbnQgb3JkZXIs
DQo+PiAgIAkJCQkgdW5zaWduZWQgaW50IGFkZHJlc3NfYml0cywNCj4+IC0JCQkJIGRtYV9h
ZGRyX3QgKmRtYV9oYW5kbGUpDQo+PiArCQkJCSBkbWFfYWRkcl90ICpkbWFfaGFuZGxlLA0K
Pj4gKwkJCQkgdW5zaWduZWQgaW50ICphZGRyZXNzX2JpdHNfaW4pDQo+PiAgIHsNCj4+ICAg
CXVuc2lnbmVkIGxvbmcgKmluX2ZyYW1lcyA9IGRpc2NvbnRpZ19mcmFtZXMsIG91dF9mcmFt
ZTsNCj4+ICAgCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KPj4gQEAgLTIzMzYsNyArMjM0Miw3
IEBAIGludCB4ZW5fY3JlYXRlX2NvbnRpZ3VvdXNfcmVnaW9uKHBoeXNfYWRkcl90IHBzdGFy
dCwgdW5zaWduZWQgaW50IG9yZGVyLA0KPj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJnhlbl9y
ZXNlcnZhdGlvbl9sb2NrLCBmbGFncyk7DQo+PiAgIA0KPj4gICAJLyogMS4gWmFwIGN1cnJl
bnQgUFRFcywgcmVtZW1iZXJpbmcgTUZOcy4gKi8NCj4+IC0JeGVuX3phcF9wZm5fcmFuZ2Uo
dnN0YXJ0LCBvcmRlciwgaW5fZnJhbWVzLCBOVUxMKTsNCj4+ICsJKmFkZHJlc3NfYml0c19p
biA9IHhlbl96YXBfcGZuX3JhbmdlKHZzdGFydCwgb3JkZXIsIGluX2ZyYW1lcywgTlVMTCk7
DQo+IA0KPiBOaXQ6IENvbnZlcnRpbmcgcGxhaW4gaW50IHRvIHVuc2lnbmVkIGludCwgd2hl
biB0aGVyZSdzIG5vIHJlYWwgcmVhc29uDQo+IHRvIGRvIGFueSBjb252ZXJzaW9uLiBTaW5j
ZSB4ZW5femFwX3Bmbl9yYW5nZSgpIGNhbid0IHJldHVybiBhIG5lZ2F0aXZlDQo+IHZhbHVl
IGZvciB0aGUgY2FsbGVyIGNhcmluZyBhYm91dCB0aGUgcmV0dXJuIHZhbHVlICh5ZXQgbW9y
ZSBvYnZpb3VzbHkNCj4gc28gd2l0aCB0aGUgc3VnZ2VzdGVkIGFkanVzdG1lbnQsIGFuZCB0
aGVuIHRydWUgZm9yIGJvdGggY2FsbGVycyksIHRoZQ0KPiBmdW5jdGlvbiBjb3VsZCBlYXNp
bHkgcmV0dXJuIHVuc2lnbmVkIGludC4NCg0KV2lsbCBjaGFuZ2UgdGhhdC4NCg0KDQpKdWVy
Z2VuDQo=
--------------00ZtQIvLOpTNF0T4lhqryuc6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------00ZtQIvLOpTNF0T4lhqryuc6--

--------------a04EqXeNz0kYSi0WJAEccu6Z--

--------------T0V8pYgiTd1fxp8HhqGKc2mh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmesgdoFAwAAAAAACgkQsN6d1ii/Ey9P
5Qf/QNcDFZkg+EKV3cbYUfb7UtB+T5lgIRtmob44g/TUtbkQPGnub7oNFC0Sggrydw5pIMDTwcx9
827GmDYg6HCgUgChZ8alKwXNcfOIMmlhI9Hm3iRo3d0xboYD5jaoFT3+Gze9kUvwX0csJ1mW8tWC
k+bmgF3UVN03hSdhlS5H93tb27OHaJDrTNRy477kfYS+djJyvnZAtGwLO/T++45gcrBK65M7Ap6Y
9FM9/S5jxdlofpfz6y3vLqnVzJc2lunZspXTF6eM0isZ3TTCAA1zaA3cznImkB5MmxdnYECi1pFN
HKi6Ygpex4xj3qUOT45cHYq+lu33EySYeUmPNa+/3w==
=AFS7
-----END PGP SIGNATURE-----

--------------T0V8pYgiTd1fxp8HhqGKc2mh--

