Return-Path: <linux-kernel+bounces-330599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1071797A090
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EC0B20F37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C1149C57;
	Mon, 16 Sep 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SJ4uTYFX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467914E2ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487566; cv=none; b=eyhxOYxTxDF4dyjCUn2J80bRaNr1Tu/sYfAouoYyR5fooz0qJQ2AtSpQPxF+DNR8u/64ixt5wN2ZheFyE4K+0sO/4VvIDVDIULdWiH0I9tpHNSoaoKEgOo61X3Scr+suSiApqAsm1o3SteOjK5KZgwqrqLRKSb9tUIU+blCuyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487566; c=relaxed/simple;
	bh=iM6Elp/sm3jXr84spvTro9yvti0Z6xFLw//7YQzRUs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZDlwvVYFEyzUKmOpVB3BFyYA0bY6AdwYbIRhRY8BRpJ/wvYb1MEZd4Q0kYsVm+/IqYfbqOkT+H4s+n0jkadCvlMxIiimM9MVsKVe5t/Cb1dKzk/4N0iHP0zh6c1N/HXHTgLpcbq/2Rg+SYiLQhVpqryH1VgYprk5Fcr/FqTUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SJ4uTYFX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso43145175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726487563; x=1727092363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nnm0NJxECZsYKIxc66BOTbDGAWNLQfv5K6G4LcFfNA=;
        b=SJ4uTYFX0Zh2r1Vv45Q5qpWhroKBTnXtb6kbmHrYxALyKbX7Dgkw5toBv4jQAxN4fc
         9WWJwvD47I03nP36UNLHK2eYFVo8kmJqMLhGuysJ2hxqGy03mGiIdHeEjdfWX5Tvak2q
         smwz4tke9sZAJiVtXsfaWb8W2k9K8n/7+H0keWMOYlKGcpJOLupuTNr1AHa3545uHVox
         YRBCtnrec1XOOHzxbHe7cwC/Hwi2n0DIemUKyNZrc5rQnRf3wsFZYtF3n4gS513Al8ro
         yM+SqFwZ7hXQ+6fPfbHgbpM2yTUQwi0d0zBEL3pw7EKuckPfH/DtiJ0MMvGjhaJoP+d0
         4DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726487563; x=1727092363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nnm0NJxECZsYKIxc66BOTbDGAWNLQfv5K6G4LcFfNA=;
        b=HtHnxjgRn1P470F049mPZeEWeH3aAab/orm9iI9iGqJ0Dq5qhvXdofUNwHHR6JRyI7
         WPL/oxeYXHAnYK6KM0E8uQoC5TV9ILJ0kuFHtpKb7gsUwqIKSnM0tSuLQ0lrPmiji4ik
         0k31/1SWaisvTNPLban9Dl2+ZM5XNI3OsFoHU/K9K2sEdgeqHp1ivqwgRXs5sAuy679l
         LdPInrYY8uvbW6cuXoVmcGddNefyOjPnxbISkZKOeIMgm+XQxbxAUnEORMinT0U3pofr
         MHW6AI1iBdAnugOeUXL/TwcHKVwq88zrUFu9W4YLS4KtECr3AqohUCzeHSgclIawEbqw
         GRSg==
X-Forwarded-Encrypted: i=1; AJvYcCXWGNHWX9PgqzqTscXH63cPN2BnUluvVMJlwUh/vGhxOXW2cMFABSK53Z4WiX6/XGGVMQD4L3Ux5NiND8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXhiCyMQgSyB50MTt5qL/Up4rMSlou6OBM300J8vncKTyztdc
	VlQrilm/EuZMGWaM6oZu1yvkYixaDme4obXO0KSnroZoMIZmVz//MaPt/GvDcjQ=
X-Google-Smtp-Source: AGHT+IG+nB/JdmngCxxwK51J6HLRZl6BCx93nl5weA40RhBfhLNEyVA/mVGYlSIHIPjNtSUAWAfihA==
X-Received: by 2002:a05:600c:4709:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-42cdb59148emr112642275e9.30.1726487562944;
        Mon, 16 Sep 2024 04:52:42 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f068esm7128543f8f.3.2024.09.16.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:52:42 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:52:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add new ad7625 driver
Message-ID: <6f5sqahnu6nxmzzxfj56432eogjcgell7c5sth5c2arvekl4sx@ndf2tdl73glx>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
 <20240914182848.34edc5e3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxgr57ac724varkl"
Content-Disposition: inline
In-Reply-To: <20240914182848.34edc5e3@jic23-huawei>


--cxgr57ac724varkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jonathan,

On Sat, Sep 14, 2024 at 06:28:48PM +0100, Jonathan Cameron wrote:
> Uwe: From a quick look at [1], looks like you plan to queue that lot up
> after the merge window.  Would you mind doing an immutable branch for
> me to pull into IIO?

Yeah, I intend to put the changes that are necessary for Trevor's series
into next after the merge window closes. I'll let them cook a bit there
in case some issue pops up, but then I can create an immutable branch
for you of course.

Best regards
Uwe

--cxgr57ac724varkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmboHAYACgkQj4D7WH0S
/k502Qf9HWLuQ3QzDMRhm1T2ncwqa6goKIw+Re/Bc9REUzdTrbP12nnNzS4elX5L
qrrNMwWiIjR/r1wlUYEanG96TZ14Znfjh21TkCMfFbMXlH470Q2SyWmSuorltMPe
wqyYx221eZ1vJnDfHted0R/zZj14nGLoXS9hwYNDagPaQ0Qaxi6fvrqf82TU0MeW
gKI+FYp8Gx8Tx4XOVAnxVIUaEcPfEDlq7BpD39WqwsyvN2Iu3Cg4Gs67igZunYaZ
Lgyb90e4lVDOH3cqycTDE3zt6ZAczriM9Q3Sa+rDssSGx+hs9yBxPjtUEztywTKk
8A0QJgrIo+TVEbAule7yiCkyALxAiA==
=zCsY
-----END PGP SIGNATURE-----

--cxgr57ac724varkl--

