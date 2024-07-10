Return-Path: <linux-kernel+bounces-247766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49992D444
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF35A1C22733
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12B19346A;
	Wed, 10 Jul 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pStlYLo2"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91538FA0;
	Wed, 10 Jul 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622063; cv=none; b=PFYlC/6Aa+D/CEAxA9+fhH2REQQVRZPtvMYLocHbDZaPLH24g//QEojjVmpngvMcOLb3wiI5AqE5fIAUdHoh+W2iUIF5CjtycM3jkCnRaPko701bmSHtASg1S3dTkW1N+z/DHvxWJtgkD6vuV5NLTpVo0aKzp6YHMLJsNcjZJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622063; c=relaxed/simple;
	bh=K+LGB86ywzCtdkH0UoRCHTGWEXsnmmCtiTK+UHcIU6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHdDgqrSMKtGw+ZEUU4W8LlLhLrfyrxBf/f+XO1A9YEChV7ErT9Oc/y75kDkK7kDlHgDDBeTLEiv/DjUFXD7COOV9QjYMoGi+FsLRMYTDYLoaFigBzAsBrMZE9VYDAoYAUlVnHTL6E38zFCm73B0UObwVeNtnjT52Q4AOPkb9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pStlYLo2; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GAM6y8fnj0Euu5w+krZO4tj7MaXUS23Xc1S4ib+0mIk=; b=pStlYLo2/DPDeFYt364zdbEe48
	QjopVVMc9xErJvDb/64k7JYtL631EN5KqkTc0fZKgmiRTlogv9dO9VK6j1iUNKKYbtpVncaWch17n
	bnFEScNpCK74BzRzqV40P218HqcXDYx5pi0ftMN1e0ERaEg7VP/STkBoWopB3eW1RjJQHaMCXX4vw
	SAnP4yuATGEReB4DmufkoK6Y7L8Ril0Gs7T95SQKYZiCC/fow6R4FGAAruCmuanvfmo80/gq1oeGx
	rNeJzRUJ75ZfDPRP4YoTsGvMALE3zOtXh6kUDy6B35XHmHrVAFT1yp8sMa3pRHWBOJvsZMDmOaxiN
	LgtRTFEg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRYOW-000LnL-US; Wed, 10 Jul 2024 16:34:08 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRYOV-000GU1-10;
	Wed, 10 Jul 2024 16:34:08 +0200
From: Esben Haabendal <esben@geanix.com>
To: Erez <erezgeva2@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Jaime Liao
 <jaimeliao@mxic.com.tw>,  leoyu@mxic.com.tw,  Alvin Zhou
 <alvinzhou@mxic.com.tw>,  Julien Su <juliensu@mxic.com.tw>,  Erez Geva
 <erezgeva@nwtime.org>,  linux-mtd@lists.infradead.org,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  devicetree@vger.kernel.org,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
In-Reply-To: <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
	(Erez's message of "Wed, 3 Jul 2024 10:23:16 +0200")
References: <20240629103914.161530-1-erezgeva@nwtime.org>
	<20240629103914.161530-4-erezgeva@nwtime.org>
	<1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org>
	<CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
	<CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
	<1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
	<CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
	<3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
	<CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
	<9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
	<CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
Date: Wed, 10 Jul 2024 16:34:07 +0200
Message-ID: <875xtd48ps.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27332/Wed Jul 10 10:36:46 2024)

Erez <erezgeva2@gmail.com> writes:

> On Wed, 3 Jul 2024 at 09:12, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> On 7/3/24 12:16 AM, Erez wrote:
>>> On Tue, 2 Jul 2024 at 07:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>
>>> The table below uses fixed width characters.
>>>
>>> ID      Part.         Size              Status          SFDP status
>>> according to spec.
>>>                                                         New chip with
>>> SFDP for EOL
>>> c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
>>> c22532  MX25U2033E    SZ_256K =  2Mb    EOL
>>> c22013  MX25L4005A    SZ_512K =  4Mb    EOL
>>> c22533  MX25U4035     SZ_512K =  4Mb    EOL
>>> c22534  MX25U8035     SZ_1M   =  8Mb    EOL
>>> c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
>>> c29e16  MX25L3255E    SZ_4M   =  32Mb   EOL
>>> c22017  MX25L6405D    SZ_8M   =  64Mb   EOL
>>> c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
>>> c22538  MX25U12835F   SZ_16M  =  128Mb  EOL
>>> c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
>>> c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
>>> c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
>>> c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
>>> c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
>>> c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
>>> c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
>>> c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
>>> c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
>>> c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
>>> c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
>>> c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
>>> c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
>>> c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
>>> c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!
>>>
>>> EOL     End of Life
>>> PROD    Normal Production
>>> NO_REC  Not recommend for new design
>>>
>>>
>>
>> not sure what you want me to do with these.
>
> That we can read SFDP for all chips from Macronix.
> Only old chips before 2010 do not have SFDP.

So, should we try and identify new chips (with SFDP) that re-use the ID of all the
above mentioned EOL chips that does not have SFDP?

As I read the communication from Macronix, then we should expect new
chips re-using the ID for all of them. It is just a matter of digging.

/Esben

