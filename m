Return-Path: <linux-kernel+bounces-395117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875B89BB8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA71B1C20E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A41BC9EE;
	Mon,  4 Nov 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP1UK1zR"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754111B393D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733558; cv=none; b=pzeRfvp3CWBifFIzgbgDjpYjxIRjMOKHO1ZZRmZyTtu/bkvJTU9m4dpjrPT4E7o4QO6bDUY1ErqsQsjphtIXGRpdgIXSYwmyyJodI+vADNV79OPmIR79MghPGJoP0Q3r8OvocIJ1Jgbv/EoBjhWFJvOb2qIL/nYmZ6zYYrDw0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733558; c=relaxed/simple;
	bh=lJnlbzmXVqlLqfTEUo4hipL02rvhlo4IWLnIv0ynAmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj3swAOvY4mZzBtCBW/hCj7WLGAP+kMRcemiVclrBkvIPdGAuxrH2NtydO7s5/lq1PiPxAhtLGb/+X6j4lu8UUkbB/yJEQC53hlZzDInyd3qCTPOPdEHPkYkHD0p9XD7liiFbjh3lj+hVombhE9aOTMqfJwRmdYAUIdG36DV8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP1UK1zR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0c40849cso775449366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733553; x=1731338353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aro9OUStezfsQZPeIj/Ne7cRaEIjiTc3bwg4jYU0Gw=;
        b=KP1UK1zRbizw/W6Za6RHKeVOkcDdi359b3J4yALut7jKyq3Bz8wxBsuhk3oNcWjRni
         e24T4ABTnbtXT/Sa/ZKeYS9Ic12bPBOU/UGxz3f0atxW0PoRDd5dlSvaf78W6hbdU9qu
         wihTifqwHB2cBttHDHKfPQAAZJCNcrmIPzVtN3cN9ZoddvWFRTaf8ApufiFNE+qt1J1O
         IY5IjOm9YBljx30Z7viJCgfaPTmAmNiUSIaenKHEDS/37ELpr/gREIGGNkF8HECIb1kT
         FuW/UHjDuU+PH4aYpNOADYsbgBA5zYq37p0iS9+/8olxgGe2kLQd8Srhwdxkz/wdln7c
         31Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733553; x=1731338353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aro9OUStezfsQZPeIj/Ne7cRaEIjiTc3bwg4jYU0Gw=;
        b=Skd/TUY+Zv8GvHGBBCnLVPKxm9y3mCM9d0XoppUU8ljqjV3g+O9V4lTMzvEMRoA0sT
         g2Pvb1E2iID28wkdOeGsyFM08zHE6Mk7DbFW7VsoHwKtWufHhRcopnGMPc2TtUiPZpzC
         CTjzTcOjBbWR+ld7Jf8+vSNklaQUXNLwbg9WgrUSCITrDPCbWaBfqyFgLKspfnhkN/7y
         at9uv6S4b3XtaCCwe62wH46xeu+nbhgb7lYUCudDbJUqIQy+W1z9c+O3SlUZCRaZLMml
         jv+qimH82SyKMa8q1+M3zcTDOFVOJscsby8XEpY2EDs6Hb+y/YvhlhV3zeL8sYfRO0if
         N7nw==
X-Forwarded-Encrypted: i=1; AJvYcCWjNNpU5QuWbn6mPlJfxtqO/6i8QSU4O/78Dv5N9wMGPzeTE2Facnb/Kg7L6NUs6xOqzT/v9PhTsBGCeB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++Bdq/o4khpmRaOR8ewMgAdDW5gB+2/+of4Ka9BvEWRiOYexC
	w7C/dA9kBcpyiSzyoEACBMG1jERmjkVOd1aZlIdKLBEdxDZzOEiy
X-Google-Smtp-Source: AGHT+IGoCjugzBNZ9blMebQOdJ4kj1DH6U3z9PdFMFa2Ijhiel4nNGrTQle/9BJ/FDmPSMcK/veztA==
X-Received: by 2002:a17:907:1c1d:b0:a9a:f53:a5c6 with SMTP id a640c23a62f3a-a9e3a7f468fmr1963722466b.65.1730733552584;
        Mon, 04 Nov 2024 07:19:12 -0800 (PST)
Received: from partp-nb (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e8e6esm569618766b.94.2024.11.04.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:19:12 -0800 (PST)
Date: Mon, 4 Nov 2024 16:19:10 +0100
From: Parth Pancholi <parth105105@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: macronix: enable dual and quad read for
 MX25U25635F
Message-ID: <Zyjl7k3brYYcLD5H@partp-nb>
References: <20241024114021.17567-1-parth105105@gmail.com>
 <f4a5e5a4-9a0d-4b3c-8fe3-80e684fff758@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4a5e5a4-9a0d-4b3c-8fe3-80e684fff758@linaro.org>

On Tue, Oct 29, 2024 at 07:33:01AM +0000, Tudor Ambarus wrote:
> 
> 
> On 10/24/24 12:40 PM, Parth Pancholi wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > The MX25U25635F supports dual and quad read operations. Set the
> > corresponding flags to enable these features in accordance with
> > the hardware capabilities. This change also enables dual and quad
> > read operations on the MX25U25645G, which shares the same ID and
> > has a superset of the functionality provided by the MX25U25635F.
> > 
> > Link: https://www.macronix.com/Lists/Datasheet/Attachments/8663/MX25U25635F,%201.8V,%20256Mb,%20v1.5.pdf
> 
> Looks like the flash defines SFDP tables "Table 13. Parameter Table (0):
> JEDEC Flash Parameter Tables".
> 
> We have some minimum testing requirements, please see them on
> https://docs.kernel.org/driver-api/mtd/spi-nor.html
> 
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> > index ea6be95e75a5..be55558c8ad0 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -129,7 +129,7 @@ static const struct flash_info macronix_nor_parts[] = {
> >  		.id = SNOR_ID(0xc2, 0x25, 0x39),
> >  		.name = "mx25u25635f",
> >  		.size = SZ_32M,
> 
> if we want to switch to SFDP initialized params then we can remove the size
> 
> > -		.no_sfdp_flags = SECT_4K,
> > +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> 
> and this line as well.
> 
> >  		.fixup_flags = SPI_NOR_4B_OPCODES,
> 
> If the flash defines the 4bait table (I don't see it in datasheet
> though), then this line as well. We may remove the entire entry and rely
> solely on the generic flash driver.
> 
> >  	}, {
> >  		.id = SNOR_ID(0xc2, 0x25, 0x3a),

Thank you for the review, Tudor.
I performed a quick test on the mx25u25645g (sharing the same ID as
mx25u25635f) connected at TI AM69 device’s QSPI, removing the
mx25u25635f entry to rely exclusively on the generic flash driver
as suggested. So far, I did not see issue. I’ll perform additional
tests and submit v2 with the mx25u25635f entry removed, along with
minimal test logs.

Parth P

