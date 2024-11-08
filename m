Return-Path: <linux-kernel+bounces-402507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07E9C2879
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2206AB222FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612B1F756F;
	Fri,  8 Nov 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkvKrRtG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA01E231C;
	Fri,  8 Nov 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110270; cv=none; b=ZBTVSLP4nispGVLhg1omJcUObKaIgseb7o2EqiEwqA3nLkzw/NqxhmWmVFMa1Y7AFt81ujcLG5+//Fr5QZgSBrQbkSOe0N9gprpGZHesMDqaUuQ41JIxGefW5wWPinldTplEgvCfqrbM/Ps08zmYehqyU0jD3Yswb4CDotY1DQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110270; c=relaxed/simple;
	bh=5MygCCliXOQIPYExnAgpq36Qgh4XXuyOqtJQoNoZ5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2qZiFqPatsEMmD2UM+fIr+dj75KJN6sgZgXaSWkyTphNgAhOpzvHx1AdI/2rTXEPRG80vWrwhZz90Eq2q0RL0ksWm9YxokRnKU45d4ZXDcyfeDXFW+9Eoz3Q5JY2dpHtjBTsrrmZmL4FwJ9Iu08cp2wicRZ8oJ6RE67Af4cqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkvKrRtG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caccadbeeso29927055ad.2;
        Fri, 08 Nov 2024 15:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731110268; x=1731715068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uq/HleutbBsgjDYtAH2w9gnQgvSfXJu8kVx54tjEWPs=;
        b=ZkvKrRtGkyy7CdSlZYZTZd6D5xvfiRvAJp2hHIgoGNVSGXT+DX9shbMqJej8FG7cEs
         0QcCPv5Y+JznhwLt89zZGiLRVvrNiw0jo9BbyuWwbd9kcfyFaorUjEIPtu7cSpCX5B0s
         l4VSBDsJDwGYFHbiXRbxZs2NxaRLapjfn3eaHQOi/9ZAGNtRGBw/pzYbf0JxM9dYIbWq
         24w6xJcLUetFJTo/a4MlZRfu7wyMf/ion/ceLZU4c0wIxC95uXNcOo7TtKErGbKcPMGk
         dYjhkRfPeI/4YkOR8cjX5dxQIjLwe4okRlWbftJT9xO3yvuyXKMDVx8oiugk62vWr/cv
         +big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110268; x=1731715068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq/HleutbBsgjDYtAH2w9gnQgvSfXJu8kVx54tjEWPs=;
        b=C+Aobu2+2sc1/52Zx9wFsUnVEI9t5QsnTW6Xp9BpfKQYKK0qPaMcVjS+Sw9Fk/G7ZU
         VZd+AsdlRUA+82J7ITIds7fGu3h7NrRH/Lo0vlaS2qmj5eRFvvqril4Ak+b70xBy38uO
         jV8dO7GgYBVnNj8n5p2b9FzhLJaVPqk6ICeO+3qbqxe9S18WAbkLk1MfiTbtmMOZFpba
         9CIjLaSLOPXTv4xR/rND5lG2KBLtrIAKrgGmckp71wjCnekrg+qYkL6T8vJHjuDdUvyC
         heF26s/QQuE8TNQ048iqQnvFjFmAIqkx/2pN/ts6vXUVEhpOu7WVeOyLrbrjjeweHF0I
         lnDw==
X-Forwarded-Encrypted: i=1; AJvYcCVrCp9dwydWG63H4Nypob98x2aOF7HhX4fqc7JIqTfnoB4QLh7MUitcBK2XFp5i7VSSIy3oao44Cm4=@vger.kernel.org, AJvYcCWaWBbz9OTIJ3WEgbNKl7kBfQ0WvogcaFuMypgxw48MEHEVVJRSMFDMvP9/ZGuENQA7Le2RoBnpVZa8ltc=@vger.kernel.org, AJvYcCWpvFGAMPa8hqdStKTY8NFQ27gSnoYMsDiWO7XLgBogZwUCkuhvMosAddfex/ym8pJZUNEKVDBZMd6kFDcH@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHH+UL6BWDFvBIvKhmDHFXFLB+xkuMo7XYKO9YycQkR17FADz
	voM5YI4yG6l9/Ani/2RCYmzmfmXtiZ5GxcoazQYItPIx9nT71M0y
X-Google-Smtp-Source: AGHT+IHsqYMoJaZR7DEU7+RH7csowchtdMKT8eN0fEPfCSshXzgwgvSMaWsCEdbws5SrloYWRHxKNA==
X-Received: by 2002:a17:902:db0a:b0:20b:70b4:69d8 with SMTP id d9443c01a7336-2118359ae3cmr54561975ad.37.1731110267757;
        Fri, 08 Nov 2024 15:57:47 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6938csm36445735ad.229.2024.11.08.15.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 15:57:45 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CDD1541F52F8; Sat, 09 Nov 2024 06:57:40 +0700 (WIB)
Date: Sat, 9 Nov 2024 06:57:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abhinav Saxena <xandfury@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: Fix typos in sch5627 and max31827
Message-ID: <Zy6ldOPnnl5ocf6V@archie.me>
References: <20241108212201.144482-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8KwVmF4c1EsaXBVK"
Content-Disposition: inline
In-Reply-To: <20241108212201.144482-1-xandfury@gmail.com>


--8KwVmF4c1EsaXBVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 02:22:01PM -0700, Abhinav Saxena wrote:
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31=
827.rst
> index 9c11a9518c67..6cc5088b26b7 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -136,7 +136,7 @@ PEC Support
> =20
>  When reading a register value, the PEC byte is computed and sent by the =
chip.
> =20
> -PEC on word data transaction respresents a signifcant increase in bandwi=
tdh
> +PEC on word data transaction represents a significant increase in bandwi=
dth
>  usage (+33% for both write and reads) in normal conditions.
> =20
>  Since this operation implies there will be an extra delay to each
> diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch562=
7.rst
> index 8639dff234fc..5f521c6e90ab 100644
> --- a/Documentation/hwmon/sch5627.rst
> +++ b/Documentation/hwmon/sch5627.rst
> @@ -39,7 +39,7 @@ Controlling fan speed
>  ---------------------
> =20
>  The SCH5627 allows for partially controlling the fan speed. If a tempera=
ture
> -channel excedes tempX_max, all fans are forced to maximum speed. The sam=
e is not
> +channel exceeds tempX_max, all fans are forced to maximum speed. The sam=
e is not
>  true for tempX_crit, presumably some other measures to cool down the sys=
tem are
>  take in this case.
>  In which way the value of fanX_min affects the fan speed is currently un=
known.

Looks OK, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--8KwVmF4c1EsaXBVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy6lcAAKCRD2uYlJVVFO
oyqwAQDDPN2bC6IWGqOVlsjF9FqVbpegaenlIOkDCdTywIVMVAD/aLzSDrWOH9PV
Mnp0H17MyQPDx5DN+4UDoroJMn27LQE=
=i2CI
-----END PGP SIGNATURE-----

--8KwVmF4c1EsaXBVK--

