Return-Path: <linux-kernel+bounces-333278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00897C649
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71A2281B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B61991B8;
	Thu, 19 Sep 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyIw5EWk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318581990C1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735986; cv=none; b=Ze/Jo4kPK1cSLS8snKFtPQ/xRiDl5l+tufPRjX4xwC261zUrhLC4VutTWtgiFdOut67A4xDlcnRzsliTeUMbII9qZ83WThLa27t2yg+cYaJaETlJHaJ4kxanA2T7ri1IqoaDiLOElhLQtuHx3/1lRaEZ3HUfeBZZWz4Rnd5kUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735986; c=relaxed/simple;
	bh=KXXXVOaStjkjtjFYBvHdl9l56tsx6I+SAZkMd3/Rp64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT1tfroRFz1FZUPAxxTmaJWJ5QQAYzBbBNuVjoT1JXur1yAHicK3PY2r1AyAcOxy0ifhQRR4nwQrDqlAO9EBKtALe0aVG9EWH8YkERp4ZM0SoqVnplAZ3NANCjsxjWpgYxGLau9bp713fegqjAVZteBm2MzwqTLNeIm75XGBCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyIw5EWk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53660856a21so524489e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726735983; x=1727340783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXXXVOaStjkjtjFYBvHdl9l56tsx6I+SAZkMd3/Rp64=;
        b=lyIw5EWkaYB8DuJe/hKLWliZnDoeT1yGwhpN3fLAxPw2DW61taKvKjpvh7u4NqFJlJ
         fsDHjDOPKdZ4PGxLfGBgzTq784w4/DlU4Xp0NWyH9PrAUYsCyLEmRiGTU9yD10bwj191
         OMcGCLrWtgN/LquVHIk2t/oR/VEBqIILSOV/ZHoXlCmJoFBMC0wVAZtar1ewoGVaAfQY
         tkweJk81lpp3oegGTJwi/opZamD1HidEoJS0BSr58GKb2nYJW8N23N94jCY3yUp2wdvd
         tu9Ps8dD5uA0QZv2xumEn1RJ55LOdd0P1jd6vGIJs+ontDtSh36dE4zd05FnDkTt6mG7
         hTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735983; x=1727340783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXXXVOaStjkjtjFYBvHdl9l56tsx6I+SAZkMd3/Rp64=;
        b=F/vZA1SL8U2P5NWxfPOqx5jeDOnejlTLTM+9fZG7GgNKIv2eT0fwx5LaSxZkf7+gCl
         DYJkMydZ6otgpH8dCXrDbMmTLbii0JOV9redukJwmbDBNuopshcwx9D6ZkbaSPkjsinC
         yw1sMPQFI2gFVSp7m1xjHg3V/VWaShf7VL0Sh8gtGODo487jJfxUlZKnP1Qzg7geAq7t
         EBDiO61Ipm/lLdTYUZzMFtbK6NmPMTzZrg57alqleWDNx2UwyOK5dTBIorZDDq4OdEQg
         NMs2FoFoQmNtpr8cFFbyBjRaArFHMQPNCM+4B7S/fKxHXSsTAA5iwkBJHYuUL3rEYDYT
         HRTg==
X-Gm-Message-State: AOJu0YzUte5BBjTZKhg5XPHaZ3SAknB7cM9V1z93KRXT8b2DvEZbAc6K
	RgE3WoViFz2eeDTlsicsk+ca4utP4Zd74BI6kWnRDXAD9MVwFLjbeszi/XGO
X-Google-Smtp-Source: AGHT+IF+hrgnRckzHf+HnoNKufelcSpbQeDJUihvwA5K0fDg2B3OG+tv0ErBZPRKVhbqTlhciMhK0Q==
X-Received: by 2002:a05:6512:12d1:b0:536:5827:8778 with SMTP id 2adb3069b0e04-5367ff3382bmr11100237e87.53.1726735982797;
        Thu, 19 Sep 2024 01:53:02 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b41a8sm1765235e87.252.2024.09.19.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:53:01 -0700 (PDT)
Date: Thu, 19 Sep 2024 10:52:58 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <Zuvmaq9-BddwM2Pc@gmail.com>
References: <20240918-da9052-v1-1-ce7e7024e48c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r7/2rueX74cQKBP8"
Content-Disposition: inline
In-Reply-To: <20240918-da9052-v1-1-ce7e7024e48c@gmail.com>


--r7/2rueX74cQKBP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 11:12:22AM +0200, Marcus Folkesson wrote:
> Actually, the LSB bit is set on write rather than read.
> Change it to avoid nasty things to happen.
>=20
Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9052-=
i2c driver")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--r7/2rueX74cQKBP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmbr5mQACgkQiIBOb1ld
UjJaGBAApI/GWa4b/HaBuCD2D9iGJwb8LcGgWl4Q5/CWxA+MbsF9fC1KQnk9MNgc
sBwCc5oYFK2Izev5UWU+Y/CFcoBpzkO4X1ZYyjpq2yM53jpnXNkFtAYeII4UPTVk
GHm4cVotmGdFPQsfUK0jAvTR1SJsPPJxJipeC077k3ZSla5BXSjhmNQ2vH17pqdT
K6fdl/qpOfZDnWfqDl1NPQU0/amn8HJvmemMoUh5cftJWpFcks5OnJcKhVGAhpXG
H8+5rI/MYxvHBkBVYi0+YKfiwActgI77F+JAh6UgZli7Gu1WiUrW/y9sD16mSaQe
Md1CdVVefuWnXZ9wXLHSCb9dLW0tVNuR53UQsVyAwpGjpJaNzFjhjUMOzg1w3Fro
HDtmvnFadsvP5CO4IPEemIkZv6mjEziKQUb0qI+TP0R+OS4Gh0zQ5CZG9KcME0JL
PjpXm2CfuGmmBvyR7WeGn2pvEHmr4QmAHeYJSpno/iF2qsVKrx0Hq1v9jE0uBGvi
ilcTn1MULkPptuKkHApblv2H1K3V6OtA4cY2DuybmxWFyFXMxLgFHx5uHS7GqQ7T
7ZOslZedOVellROAE9CAp7pa5fViobmW4AcLMz1s3Zf0I/e8BxTI1O51UnY5gbwT
Fqihf0XiancEhCXI2JjeLMpvIoPZ6U301/PUaGcVQpXfJbPdfhQ=
=4efv
-----END PGP SIGNATURE-----

--r7/2rueX74cQKBP8--

