Return-Path: <linux-kernel+bounces-435903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C29E7E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7116D0E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B95FB8D;
	Sat,  7 Dec 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih3D2Gpv"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9151A270
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733550735; cv=none; b=fNs+4prnQkcsvguWT4Tum02GvaJpOF6Hm8aCKIm/iL1N8wD7CMkRGN9qY8QR+LxQbdeITpt3rypX0ykl9tKITiPBVhMYREBAqBiaxmv0I42+0SqHfcUnRz5Ytg49P5pTPt/9C72UOJyCT7czZR4vkIwc4qSX0LXpMl6Kmroowqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733550735; c=relaxed/simple;
	bh=0FM9srz/QgrdixQmzQvfRg/ckQemKOXP7hM6wSYyw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXM+TumKbunYRBcD08K4D09Xh/75MF11muYoU6GFYIjHTAwVNC0W3985S2CNx43ZSgKVqIhXozulAwLzT/QyoqI7VfI7r++/G4SS7QZR9IwUUNCWPFQARCWf9rYcKDCc54KsL75e+OrCK+LY0AX1Oh59sRNEAr4LyTeU4b9skEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih3D2Gpv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2179229a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 21:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733550734; x=1734155534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FM9srz/QgrdixQmzQvfRg/ckQemKOXP7hM6wSYyw5k=;
        b=Ih3D2Gpvve215g+RHUQ+v0oHpN/f6WvTu8mvhK7VYLmexU4NSZ2Kw4qRQcTsiPeOW7
         vY0+OFzUhrc0lJMgEPGfrBZ9KS0nvUXnl6SDZs+QJ16ywtw7hmWvaJwlpN73yjUj6gQc
         KLaRNDGu1hOWKUiyv7pKnhDrGX9w8e6hQbRhJS6JX7PR0rtlAXoGPqslqVfEuvdr315C
         BvZNIah6Q9KUXJWrFdhwf2alozufTeAUwvTh9dwPmYj3YPUQCyvQ6Mn3Crwvou/wISH0
         MjECdh8EwK413pgbjl30KkrJtHquZyB/ZkQEvZJRUBYGK8i89eJjvj4suhPlYivXOacz
         bQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733550734; x=1734155534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FM9srz/QgrdixQmzQvfRg/ckQemKOXP7hM6wSYyw5k=;
        b=iSieRCa5mAUmM1ALYimgTGuiy72wUHILoJrum0r3LCCm/OPo6RpjXmarB50/VXFVtl
         3W+Zp1dfn37NEv8nl9QwyyotemeMD39A5Fy2hiIyvkcvtx70bL+yTS7HU2NnnKTM2A1m
         74cQT3ixJUeRadfTWPryV74zFPccxeYIPUUnIf1c135/vJSZyiRMvD6mDywK9a9pK8EO
         6MitFsfjVHhUTa5aRQjbKD+dTLFplObEx62/7X2WaWKT88a+NW/AZZHnmBAxRNOJudDu
         9bBnQae7zLhSxVFxJNfA3Ugx5jr/S9bIO1sujpMcQKAb+EluhDqiGVuldWDCvyMZ93tM
         cDpw==
X-Gm-Message-State: AOJu0YzB638zuSMQpFtAEkanOHhVmv5wAG5LJb1qQzbKNpe0vVDxXlmd
	MtKjTD62CM8MpqH23UGdVdORr0IuvSY9c8s3f5AfaFrZxUtONGn0
X-Gm-Gg: ASbGncvqAw94Gtg8jfnOF0lMbfIGWhMz5KRztP39w2whHAXQYFltfT0sMt4Jelneash
	+sXmNuvzxsfT4Nu/QpCEgFC8Js/xGb4rEEEBkepxiYJDSOl1Li7aMFKdQeT9fkRvpPujwe/mUvo
	+I968u6hlUMLQ5sJx133y4lUFgZm8auivClLWdLozzawRExUVNNSQ4ntZF/UjlDWRLDedXQEus7
	lYuVYiMdUXNv6ZJfb503CCwMW9+LwIcFWL8FW4ry+VTs8yhPw==
X-Google-Smtp-Source: AGHT+IHwQ6WOOnaN6G7vBY90oGbLgh/9U7n18PbMAmQ9jBl1NozBNwfcNOU4u/ki/etqkxFDgxn3zg==
X-Received: by 2002:a17:90b:3a48:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2ef69e12847mr8511268a91.11.1733550733536;
        Fri, 06 Dec 2024 21:52:13 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b03sm6530425a91.38.2024.12.06.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 21:52:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1A3414630038; Sat, 07 Dec 2024 12:52:06 +0700 (WIB)
Date: Sat, 7 Dec 2024 12:52:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Message-ID: <Z1PihReuTF3Gx5K6@archie.me>
References: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iLNBBf4HmemCN1hw"
Content-Disposition: inline
In-Reply-To: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>


--iLNBBf4HmemCN1hw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 02:46:19PM -0800, Charlie Jenkins wrote:
> Albert is not an active maintainer and his inbox rejects all emails.
> Remove him from the maintainer's list to put an end to everybody who
> interacts with the riscv linux mailing list from getting spammed with
> rejection emails.

I didn't get bounce message on my spam folder when sending to Albert,
though.

BTW, have you contact him off-band, confirming that he no longer wants
to maintain?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iLNBBf4HmemCN1hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ1PibwAKCRD2uYlJVVFO
o+5oAP4jYdfVjpvxdgksoGfeT21R8gMOOMDkjQeSkhvQSPAEaAD/Zv2ZnBe5vKSo
xaXWuaFtE7t4dnTEl6popwfQ6KhkBgM=
=bC26
-----END PGP SIGNATURE-----

--iLNBBf4HmemCN1hw--

