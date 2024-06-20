Return-Path: <linux-kernel+bounces-223064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2894910D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8328865E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D21B47A0;
	Thu, 20 Jun 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLiWt73I"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFBB1B1500;
	Thu, 20 Jun 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901038; cv=none; b=qYPFLvEztbHbKgR66A1qG6/lVyFCcZQnCQyEy3pWrJzcUGrNzr1Ni+OW4IGdkoGXJIhvMWEfRW1CKWb7CwzZwaoAGqHtWFcghs6U8gdlRfvUux9zark9JhtyZJQ3/Wq4KUh0PtJZgkO0jDUj5M/Eas4Ioi4Pxxq+Wa0/et5+fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901038; c=relaxed/simple;
	bh=Z7wFmenBZTlsebiBGRtqRQxklYko51QR4XutUm2q4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofIopdqU7WxeVo/3QHanHXtCpr1THo4OWwvLKemRbiP+w8FiARUuTlNs4as0GqejTzpYUjj2Kq6nVZIESMR6FqUfKgadramxHlFqae28xX+xaeRDzZy7kH91358eeAcNueLOWPZHZrHNDB2iLk7+4kf6jpUFDjCLKDN7melFcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLiWt73I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1028705b3a.0;
        Thu, 20 Jun 2024 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718901036; x=1719505836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsyYBnBD4C+9cyxgt//5+wZQ+goYBnLsU/vC89c+kzo=;
        b=dLiWt73Io7czNu/I9bqXvv7IZQd4o/Q+bsDH8ROwvDCzettWN7pLFTivHmxtMD+6EH
         DthZNDIFukZ46Mwa1tlDRpqRFedATBUYKjDGWbjiQujiKTuHM/4zqtln6/wbeZezbwXk
         ln6yd6KhP75ADut8ifhFFlBnQf7aIJfU03tgLf8Ztlr6N3DcfV/ThBUUEROljyN9WqBk
         ajFbQIPhD1zogCkMylprTL3HpnIoUs9UDskDdEGJlQeJVU4i1CucnAMGmqDUo32ZLE2U
         HUkBP654TN4FDFwW4KDMNjFeS72Gjwo9GMKikB4YpPgpzDhIIMTxh32mG7X4IMSa6r+/
         0+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901036; x=1719505836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsyYBnBD4C+9cyxgt//5+wZQ+goYBnLsU/vC89c+kzo=;
        b=hhXUiWmcFviYu/89jhJ2pektm1xRw3G+Semj55DfjY3/wD/26eebWXLiqSyOV3MUds
         ZVnAfS2iGbTPtd2pP45U60cOGWOR8SzU/33m9KdtfWsSaLT5SIWoJTqbutomLfnk6M6A
         +xmzXOTnEGyrf3mO245uRpq5B7vfy+pkY+rBeuwYCoFGyM2QPSwmLjhAjLWXEcOn5Zas
         H7hu0PYqtfJwihyK3ZcW3BeU4Lec/q6Qk2x1Ybi34DF1JQFzeGmelKN4RMhX1e3YKNbo
         n2uTAOngGIklEJBT5MPyx3c0BTs1QalQt5qeHYH62p7odFHGDvzXlw68NGER0AcEbE+6
         hC1g==
X-Forwarded-Encrypted: i=1; AJvYcCV45THYnP16Y7M+nFwzs+b9GwB2CByd4JlZXWqpyW1E7P8qQZcN/Ck3FkjuVt642ThgYGslHTTtmz67zTHBNdjflwhCBCpdgOaJLTFetfAPl47FoDxPdO839v9TZQYC0tAc/cSZZZO6Fw==
X-Gm-Message-State: AOJu0YzpBhuQabPDsfZxVhb6uW8Q7UPrCouFxH6pFCYvVDnu7SnxzHvd
	Ct9JQY+lgn4ctB8JrYZUZZX4QdlO01hps+sdZj9X/QUI4pzvBHBPV3bV+A==
X-Google-Smtp-Source: AGHT+IGndCdN78CF73lLg0AoJ92l4TcuUZFfs+eZAg3UI09VK75VmrkOJNgBpK+jw/bXD4JUtOZVuw==
X-Received: by 2002:a05:6a20:a891:b0:1b8:d79:55f6 with SMTP id adf61e73a8af0-1bcbb40ee1dmr5691357637.25.1718901036424;
        Thu, 20 Jun 2024 09:30:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb67b29sm12936722b3a.141.2024.06.20.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:30:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Jun 2024 09:30:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v7 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
Message-ID: <2f15baba-68b5-4e99-bdb5-6d2e05b7688b@roeck-us.net>
References: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
 <1716962565-2084-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716962565-2084-3-git-send-email-hongxing.zhu@nxp.com>

On Wed, May 29, 2024 at 02:02:45PM +0800, Richard Zhu wrote:
> Add i.MX8QM HSIO PHY driver support.
> 
> i.MX8QM HSIO has three lane PHY instances, and can be bound to the
> following controllers in the different use cases listed in below table.
> - two lanes capable PCIEA controller.
> - one lane PCIEB controller.
> - AHCI SATA controller.
> 
> i.MX8QM HSIO PHYs support the following use cases.
> +----------------------------------------------------+
> |                               | Lane0| Lane1| Lane2|
> |-------------------------------|------|------|------|
> | use case 1: PCIEAX2SATA       | PCIEA| PCIEA| SATA |
> |-------------------------------|------|------|------|
> | use case 2: PCIEAX2PCIEB      | PCIEA| PCIEA| PCIEB|
> |-------------------------------|------|------|------|
> | use case 3: PCIEAPCIEBSATA    | PCIEA| PCIEB| SATA |
> +----------------------------------------------------+
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Building alpha:allmodconfig ... failed
--------------
Error log:
drivers/phy/freescale/phy-fsl-imx8qm-hsio.c: In function 'imx_hsio_set_mode':
drivers/phy/freescale/phy-fsl-imx8qm-hsio.c:459:15: error: implicit declaration of function 'FIELD_PREP'

Guenter

