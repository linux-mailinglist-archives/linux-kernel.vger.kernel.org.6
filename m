Return-Path: <linux-kernel+bounces-250921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FF92FEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5249C1F22189
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDE176250;
	Fri, 12 Jul 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GBm0CJTS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB317624C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802070; cv=none; b=SQzss0i4/zRHDYosigw5fxiFnLRkSIAjCtK5GB2X8hzrsqY3PSAmbOjy2x2WVbbZZisu8Eb1KriiKF5YBXVyYKJcRe1V0Z91BuTA2MWEpc2D3gLVcRkplYcf1RcvPKjjmBkgmu5XidmAOYo9onLzEQ8FQiQo5k61D+4/cybOnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802070; c=relaxed/simple;
	bh=Ko5ApnctGqxTLJF9SLd3BZfsxJs9G8s9AyRIX4oqdd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3N7g6M3CNhUbIlPgE9yv1J9edVTHcC5/gZJ0rdpRx8g5EynJ1Cf4zpgE2jgc0oHnW0khLg1O7Rsggp2XleW9+OqUfRjXW/k1AsH3TtQEGLSVXang7NF+wrg/7VDnwjCyNrnfdyWQYYEzNqRi9m4OQEvouWZ8rqNBVF5tY3Wu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GBm0CJTS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso303680066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720802067; x=1721406867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko5ApnctGqxTLJF9SLd3BZfsxJs9G8s9AyRIX4oqdd4=;
        b=GBm0CJTSNo3w4jJgRJOiuN05cn4tZ1/XgRS3faGJBoGFR7yAyEYeqVGKJG3vs9DixU
         mwxYQAOEfVTGfBX4iIdqzgd4PWsQAdWDRfN6iogDgeAqa8sskG9e4pBeVKv8CpkFKcKu
         nRZtBozHZPkUARnijkHjKbd0hC76PBkdMjUtf8VWa5cRyuPBqvombQvBIC83gRyfii4V
         iNCny+DNRraPh3MM8txIUZdJ6tzCb5SPcmqqpamnS0gbZ7ShD8uqP1gv38NIqppaAEIa
         BghHRhIvTIIdA9vIJJXheH/X4D0OKXW71TNFdVLhGZDW5hJ3jK5iPzkvYrsAQKY+gnE3
         LU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802067; x=1721406867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko5ApnctGqxTLJF9SLd3BZfsxJs9G8s9AyRIX4oqdd4=;
        b=R85SdiEtj74V0eIQIWs+PMq71Uet/I9zKqEEyy5WMwOZm6pTm9Xe3zzyTSmCeNGXar
         qOf8Rs8dJQILBZx/TqRh4sm3mW8E4zU0tAs3uTxRpHyz2zSUOvDjmMYP0Pf9zdHRRoFd
         Sa8RAEwjYxgFb4y1fAj/vBDlgBntYaXSul+AUEo6Fb85s81SJZDlhPuecyFb48R8nv6L
         AvTAYhyAW8NS7rvfakgf7ttH/E/WRJuj7FiJpCpV6kbUfLcCTqdTqGoCPFCKtCNK8kyc
         eQz5Lt7B6xu0rtnjaw2HiBe+vVnM0cJbvNBWqkWa/p0poJp41Ca5yvAmkV80rxryHguF
         DeMA==
X-Forwarded-Encrypted: i=1; AJvYcCWirIRUttkVhdpndhp9GbJ1hC3C6hm+JF2bXXv2JgFpQnDh+yxiuNCnZ/T26fO8quYWj+WKqzcbzrUF3w3Pji65ggTnbaq16ytw3QIr
X-Gm-Message-State: AOJu0Yz3EMLFEfIMugHSumhlL73v03RGBChLXp5vTRTH1D6WHFycVMl4
	4/kbvigJsDCfNfkvL8VbezO4DQkuzX1sJoOnheY0w2UvETuO4ZlPzQU0dW24n1E=
X-Google-Smtp-Source: AGHT+IFIkSLn+xMw/ggbyUGVHPR8oXe4gw9aACxLjgf3iesFhHrqTH2XCriTFDtXu1o/lJmDVUkazw==
X-Received: by 2002:a17:906:39d6:b0:a72:9963:eb8e with SMTP id a640c23a62f3a-a780b6b307emr658574666b.28.1720802067472;
        Fri, 12 Jul 2024 09:34:27 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc6c0sm359609866b.44.2024.07.12.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:34:27 -0700 (PDT)
Date: Fri, 12 Jul 2024 18:34:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kernel test robot <lkp@intel.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com, 
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Message-ID: <xqniwjyz7jrf2vb46uql5eag6fttgybzbg36laqmfarplmxu6a@bgdksqe5dq6f>
References: <20240711234614.3104839-4-chris.packham@alliedtelesis.co.nz>
 <202407122021.YFqdjjQS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvbasbsoovfjy5qv"
Content-Disposition: inline
In-Reply-To: <202407122021.YFqdjjQS-lkp@intel.com>


--uvbasbsoovfjy5qv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Fri, Jul 12, 2024 at 08:45:52PM +0800, kernel test robot wrote:
> >> ERROR: modpost: "__udivdi3" [drivers/hwmon/adt7475.ko] undefined!

FTR, this happens if you use a long division using plain /. You have to
use on of the helper functions for that.

Best regards
Uwe

--uvbasbsoovfjy5qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaRWw8ACgkQj4D7WH0S
/k5Sjgf9En6EDzoXQtBhmc4s/93+KbRCAlhxs/MIhtH1wfGU2SInNC6Bzzi7TW1l
z1/4LG4VW0QIru/jNxRZWC+ko1Y1aboC/ZpBDeHKsLl4drbzivFSg13dEL2xv/dS
+QuuW3BFKf/iaMBL/o1BSga0zLTwJabS0CaWWrtv+SokR0lkzFG7bDnMjECGyvg3
BymdnZMJSS0gutvVumXYrj3WXMM1vaVxDgB9g4Eliqnt99mRqoKt79V1fuJac1pd
tdqn6QWKRUnePqLaTMe2bKdYXIrzERZIFWFATlUeQ858I0F8a1Zjdik9HMVM/UGz
SW9L1yZzboDZhwHzxM+KryaI9xspyA==
=nT91
-----END PGP SIGNATURE-----

--uvbasbsoovfjy5qv--

