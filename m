Return-Path: <linux-kernel+bounces-186260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45398CC1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D71F21F38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BD13DDB9;
	Wed, 22 May 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx0qrPKI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BBA3F;
	Wed, 22 May 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383455; cv=none; b=b6S377mtWfl+2HDHNAiDc80k4vQLPJMX7pQ1BfvRQwlodxICiTpZKy6K306IyNp2WFvOV0gWoEU2uheQqY+HthLOnDLSqnOIZstQDxdF25bejyg6AvxQNIxNYud8zdHnDtobq2uBwUKurh4GGan4k2FZmnlFnm9LM66iC+v6PVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383455; c=relaxed/simple;
	bh=QIoSfw5jrfadGwiHGVoAZwD4ecmqRL/M0iBU/ztdM2Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osac2DPM4MT+FONU0lDmsQ5RLiEBksGJUTVPm4x9n6p+uasIX1GXRpDEd7PgMooKXZYLukV/3i6tr3XPztdJ585AZBVAXdmrwkrpwbIJNKGjHRYtCHb/rOulYsFFcFmf6RcLn34k3WZT9DByG4ryVaKOIU8IgZNIaVj5TdGU9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx0qrPKI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a621cb07d8fso129389966b.2;
        Wed, 22 May 2024 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716383452; x=1716988252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIoSfw5jrfadGwiHGVoAZwD4ecmqRL/M0iBU/ztdM2Y=;
        b=Zx0qrPKItXnkCGeUEEQFk6HqYvoTeilX5hMxR1djTA1vd3n9rLIuTqNEHrsQ8EqZLY
         QepKQsZhKLd5ZPYCeNmoYR6y93cl4tcqH/lHKyKtKz1+I5CLjes01nhAihEWbUj1chpa
         t1Iu3iTApmNKjtmRTI9OYAyxDA5fLMHJbbVpaULOrEx7O3fdo1GmqnksqL1hwx7FrB8O
         9qhInTX4lqXWwzH86wU5fBO5Up0mX8P0yQiqLW+3jozVlypJnNgvXjVtvF/t+pp5ZJev
         MlDgRmeTQpe2tyGmrjJgp+kW52l/S4N64Her8ppZWPgfQSpo5vr3jtjJAkgiNMDFS/6K
         ks7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383452; x=1716988252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIoSfw5jrfadGwiHGVoAZwD4ecmqRL/M0iBU/ztdM2Y=;
        b=m3nCWPiCTQhmbchVqvC4qvluvvyiVBIkgN2v+Ea2pKb5NV24JY8lpjVD3tbg2LYhnH
         KcGajVyz5otxzHh4ydbN96gGXcD3Tj/rKO90oqPrZ8G+Ct/ajKq+5RSHeFitJQBNyULK
         /58ylCRVSkubWS8NHikWz5uyRMLR9asefXViCWWa5vSbk1NTRSTxTdoyt2Oxue8r19sZ
         EOOzBIrYw7OCVifnJgxcblsTZtmhEwQg0Wcj6E/Kdf728ObG8tkAayggHmkSt/xq4xUs
         idWA+p4hAlsA4LTWvtv9d6er8brCftFh/WO2K41fzGuX72wPr4uJgmMRTcIYpXeJ3JHc
         HcHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7loLPeGWQykyQb7mYyNpsB+PtIIeYtn57wgZjR3t+Og4AByxS3zsHL/jvmti4sVfQFpv6czGY2BdNIT0kWeyZ+ceaNi7XPRd4Ma2BGIAWnKkAtvv3HF/hADFc18APJDoOriWIXpJVCkCCasNU4LniAZ8K8p35+e30ME7EsxRayYDcqkc=
X-Gm-Message-State: AOJu0YzbGd2Y1tcPSYw2wnTjefd0pT/hFVrRCyf0Eijh4DdPGTMpk2Ys
	rAVwyxerDHrF+Eh47aZ3chsZNoPQYvp5WXad+/HVAmHMsqrjbR83
X-Google-Smtp-Source: AGHT+IF0tfMdJB6JvHldeKfNvAasprxJCIW/kd3y7x4jEs5+gCg5XRkdkBcMoK073jzyDqM3N9hz/Q==
X-Received: by 2002:a17:906:b805:b0:a59:9c58:763f with SMTP id a640c23a62f3a-a6228083959mr156240666b.39.1716383452001;
        Wed, 22 May 2024 06:10:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17fdesm1779829966b.220.2024.05.22.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:10:51 -0700 (PDT)
Message-ID: <1c1519649f9c99ad73854b70efe286d68d200029.camel@gmail.com>
Subject: Re: [PATCH 2/2] drivers: hwmon: max31827: Add debugfs support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 22 May 2024 15:10:51 +0200
In-Reply-To: <20240522123923.22320-3-radu.sabau@analog.com>
References: <20240522123923.22320-1-radu.sabau@analog.com>
	 <20240522123923.22320-3-radu.sabau@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 15:39 +0300, Radu Sabau wrote:
> Add debugfs support by creating directory in sys-fs which includes
> debugfs specific files used for configuring the device by
> preference.
>=20
> Signed-off-b: Radu Sabau <radu.sabau@analog.com>
> ---
> =C2=A0Documentation/hwmon/max31827.rst |=C2=A0 25 ++++
> =C2=A0drivers/hwmon/max31827.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 202 ++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 225 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31=
827.rst
> index 9c11a9518c67..940310be6075 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -142,3 +142,28 @@ usage (+33% for both write and reads) in normal cond=
itions.
> =C2=A0Since this operation implies there will be an extra delay to each
> =C2=A0transaction, PEC can be disabled or enabled through sysfs.
> =C2=A0Just write 1=C2=A0 to the "pec" file for enabling PEC and 0 for dis=
abling it.
> +
> +DebugFs entries
> +---------------
> +
> +The chip also has a configuration register where each bit stands for a s=
pecific
> +functionality to be configured. Hence as one would like to have access t=
o these
> +features, we give access to them in debugfs.
> +
> +.. warning:: The debugfs interface is subject to change without notice
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 and is only available when the kernel is compiled with
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ``CONFIG_DEBUG_FS`` defined.
> +
> +``/sys/kernel/debug/max31827/``
> +contains the following attributes:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +alarm_polarity=C2=A0 Write 1 for ALARM pin active state is low, 0 otherw=
ise
> +comp_int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Set to 1 if OT and UT=
 status bits are in interrupt mode
> +fault_queue=C2=A0=C2=A0=C2=A0=C2=A0 Number of consecutive temperature fa=
ults until OT and UT faults
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 are indicated in status bits
> +pec_error=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Set to 1 if PEC Enable bit=
 is set, 0 otherwise
> +resolution=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2-bit value that select the con=
version resolution, please see
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 datasheet for corresponding values
> +timeout=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Write 1 do disab=
le bus timeout, 0 otherwise

From the description, the above really don't look like they belong into a d=
ebug
interface...

- Nuno S=C3=A1
>=20


