Return-Path: <linux-kernel+bounces-543216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765EA4D2DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292103ADE0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD31F461C;
	Tue,  4 Mar 2025 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UxX88En5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929E1F419B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065164; cv=none; b=qIadYRwYXG2KfErCWbP7cOzSJPosX2erXhlZXXoLayurrblQto/fJmRMeJzZPL8OZJy2zaBnmd+cAt/Lz5BcWCz7F4O35gs+84oHi0M45Tcj0fq1zRTcNgVqXMunE9b2d+jjjbBOqm8Uhu/hAf3X5hmI+Ha3LZHn6nplYoBQgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065164; c=relaxed/simple;
	bh=UqUkulJfTVPYICuXTQxco+AaAjH3mu1LKhMq3BX2eug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHruLLtsHrid8xsgAfRCGmNVp/2gzLukIq6+bsZ3GJCXFvAHWe8UJDtuZ2POTbMrUFfZYF0OMzZNjgjd8ZyLzvNrQtUqPnA2mpTfVoe0wg1IrYQ60sK7Zu99EhmHUJffx32odGUUepo4Z3za+TV3ylMwRWnjfKCASXMtPTVVygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UxX88En5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2926307f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741065159; x=1741669959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGDcVLShV6h0jC9uhBpDDw55f7EzHOwouXG7Rkj3oio=;
        b=UxX88En5/JVC86Bfv+hP+AzyCvDLAMmLuWZVx5830AmfOoC/Pvb08otHAfaqzRxdj0
         XULFwsV4smVtwixD3vdSL7if3ZgzkHEWHsJJCBrREivybn7S0d8rlxFEZBlcmrnT8w4+
         u/KhdFqZqs2Np0EbwyqD2N3Hi2zRjtuGrDxu6w/UbzAPojSjnSJ/zEVWjVRpS0ZVH7IK
         Wo3NnUyJbdz+9a4NNh+KiKvHIGyis0l9FVl9K7nhPugYFxf5VslojmJmxS4dDYvhjlKG
         +6dzeLrrd2A2UCMpj54hCi9mxrGtRo0nUJAvPGFclpl9qBNVehmQdaOsgT07vrdul5Fu
         zXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741065159; x=1741669959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGDcVLShV6h0jC9uhBpDDw55f7EzHOwouXG7Rkj3oio=;
        b=mKenZKlOJYnkOy5ZU/gidn4lWPMe0y/drgDoj7zqkf1BQgbwao7QRbesZd5RbaVVXA
         1EX4JZLWAArMeeQG+ZWVojik2jH0EYN7J1dzCEx7vs4VGxBChsagGX7wciNaJnt24nXM
         PYlvi/1XY5H6mbqbScsBnhG932xghdMDjgx/XweR3wci5OvK0tIgotZiHNOB2EmZ5Efk
         fX7ryb5/N7x18LbZIVFCcVZnc64CYKi83s3W5IlVil8NnlJjZyqUdiAkFkr4FRgQeHvn
         Ji7JE2NjlIDsDeMaokMovpen7cHBgQHuTsc8WUGEpLClIDnz8HrdJ2ZSHr66Agt3HyPd
         rNGw==
X-Forwarded-Encrypted: i=1; AJvYcCUyKxwvMM/K09MMhSoFZguDUsY1GOctdWeR7Qp+fVvqTij51qYLePOfhc14Pppei+Xb5aavwKaSUU28ijg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCe2e1k/Y5oeP9MrlzrnfdnXuOGt0UbYTGkK0QsUAITIodOIRt
	zq2aaQpYjYlayX8or5ny378+dab2W54cFVEy4ImIXhFno8ii2Mdrc2ReX3Fwyq4=
X-Gm-Gg: ASbGncvgKXZ5rnqfQZM6sigawtrUsYvujKyGy9h2gsuSOEoIpu6/F7hUe+3eF4/tIRV
	bDptLyp9YdrXNCWbzHWfWC0wuXB/rAz5SZ1tcQwIof0IRVAIe2a1fW2YxU21wRfg8nsCi/6uyHe
	m2MtLhidF4+mSocIAp4TXo+YfcMXpxp7F0GwHMNwh0IiXK4ZMUDkxneGo7jzTvQjzA1dW0SK0j6
	JDPtfz8fsIq4Vt0+LB/lmQqZpzae4i8JbfaJpPzOdWQldgSvDvY8NqvWn2IuuuZPobCVeU401mW
	bzMZ3gzp9FTV3PrYuBYOxBOIvWhZ84Bvw3XsonOPQgdafAfCiRWw3UzZUtgrdozIQodBYn6Hfcl
	ah0T3sdOUNEEKvaY=
X-Google-Smtp-Source: AGHT+IHrd9PqX/DjlI9fj4DBpZmmZUNi2fJ1f/erG72uoIjwSjUT4MZjUG1DX4gjTr54ZGluOrADMQ==
X-Received: by 2002:a05:6000:2112:b0:38f:6149:9235 with SMTP id ffacd0b85a97d-390ec7cba70mr13509775f8f.16.1741065158423;
        Mon, 03 Mar 2025 21:12:38 -0800 (PST)
Received: from localhost (lfbn-nic-1-357-249.w90-116.abo.wanadoo.fr. [90.116.189.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm16679767f8f.55.2025.03.03.21.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 21:12:37 -0800 (PST)
Date: Tue, 4 Mar 2025 06:12:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yihang Li <liyihang9@huawei.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	Jason Yan <yanaijie@huawei.com>, Igor Pylypiv <ipylypiv@google.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi: remove incorrect ACPI_PTR annotations
Message-ID: <h7oh3uhuvmulmqkxi5x73bnkmgkodjxemabiqwkrqu3jmbxu2e@p2pmhpxh6nxl>
References: <20250225163637.4169300-1-arnd@kernel.org>
 <49419ea6-5535-3612-c1c4-5ac58f2bc012@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hem4h7lf6bcgapu"
Content-Disposition: inline
In-Reply-To: <49419ea6-5535-3612-c1c4-5ac58f2bc012@huawei.com>


--3hem4h7lf6bcgapu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] scsi: hisi: remove incorrect ACPI_PTR annotations
MIME-Version: 1.0

Hello,

On Wed, Feb 26, 2025 at 11:23:18AM +0800, Yihang Li wrote:
> On 2025/2/26 0:36, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > Building with W=3D1 shows a warning about sas_v2_acpi_match being unuse=
d when
> > CONFIG_OF is disabled:
> >=20
> >     drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3635:36: error: unused varia=
ble 'sas_v2_acpi_match' [-Werror,-Wunused-const-variable]
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Looks good. So Reviewed-by: Yihang Li <liyihang9@huawei.com>

If you put your Reviewed-by tag in a separate line, the tooling that
most maintainers use pick it up automatically. Martin applied your patch
(currently as commit 7a9c0476d4073e742f474e71feeef4f54add4bc9 in
https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git 6.15/scsi-stag=
ing
) indeed without your tag.

Best regards
Uwe

--3hem4h7lf6bcgapu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfGi8AACgkQj4D7WH0S
/k6uTwf/bL2OxbnKrLPCyCJoJ83Z//yLDsboI8SAvxeHxQEkwAj81Xuyp2fdSEnk
M9idgLnnXAh4RE3Xt0OUGm7wpC6s6+tfLQQzgS1GcSm8Zo2JSXtjR12T4FRx2tLK
IxVnJ+ALuaEtgPV5aitknIwsEds9QNKZz4BIrxQ7YRD+Li4U7gJ4iavzRk35WK5t
rA6b2v3g3qJAO9Oe4IPGh0TIjyc28J6ALo4U0IA0C5DwNB+JcyGeLGc1ZkApJxot
xLlQTlI0jZtNCxn006Q39TcWIwjb28zp73JCuWSg7nSQddF80oN54kRrRRq4SmSh
Hx1QG/MpSok55aMOI+2+Nv90RuCn8w==
=5tCd
-----END PGP SIGNATURE-----

--3hem4h7lf6bcgapu--

