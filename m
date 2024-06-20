Return-Path: <linux-kernel+bounces-223098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A086910D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6491C21DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB91B3721;
	Thu, 20 Jun 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3dGvHhj"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343017545;
	Thu, 20 Jun 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902401; cv=none; b=oO0wj8OxlDyXGBa4hs3MkByjXPej5ClffE8iPvxHGO8a7NdU9hlv3CWJGHa4TP41BQTGI4+lmiibalwlsnsQt7kexniC/XvxU7IeMPJ5IDTxwwfdXxARJuOVnSWsDQbgk824x7LoUJiKJcovtDoq1TpqvQJD088c6tERfeOy4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902401; c=relaxed/simple;
	bh=7AmTvR060R3Xb4pZV+tbl305NBdOBTN3BeShU8bb3iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmZlClsbStZrcMXJlqClt75I6MSn8+0aCYJoTNjpfrlDTiDgpRVBD+3qoQ1rMS5WCGjkC+TlmhZYI3VN8u9e7LLzuZskHLQSvNcPyIqSDGOpBSCfM3ihwULse7YqjIC36YY/lZB5E7Gr9G5zUvW9zz+GdRUTlZfBYW7uPAAiRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3dGvHhj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9d0354d8cso666705ad.2;
        Thu, 20 Jun 2024 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718902399; x=1719507199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AmTvR060R3Xb4pZV+tbl305NBdOBTN3BeShU8bb3iM=;
        b=T3dGvHhj3h8jfBxzbt1u3QsqoquhQTrUk8SHgpSW5D330zMeZT3NJorW1fEP8ay/4h
         X79yP50NZLXDz51Co4JxKq8i/Z5jsTXzjVJ2Np8neJDnA0GH5EJf5ZDEt0TXEoi9tZzp
         DI+fX/XqSwOaPtChimPZ1oOfQDFRMYCtP3uXfewNWocSyCBiOAhdJa3nmdySsA2Cemv7
         SNVUr2Nu+xG1mNA+6SaLFWMMJGWI3aLqhD+ZHjCt5RwUn4mqUhIYXbbtea1GG6NKb7lI
         dxbQd/kKCCYly4rda8/l1cw60PUdJCHg6prEqLEgwYnuEp7UN2ebwSgP9vJSRNua+72r
         GCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902399; x=1719507199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AmTvR060R3Xb4pZV+tbl305NBdOBTN3BeShU8bb3iM=;
        b=nHAx3PFMXP59OEBzg4RnxSL1Qm3dcpgGYjTlV7dGZ88HvMKTLK+E7RC+kenAt8JJA9
         sB1zNTdNcczRwblIRQnPhY3B6Y4mPmAgab9SDJVlqpYeF0kLd6c1EzNoWPbaQABj50R5
         bybw8cWko6L3ztC57mplrr0tu0+5vUoq41qUSBHz48FLBqHTx6j1ORVZdc6wvmgQcdJI
         zXahdMxOrjrJlS0etrZkh3bYaWNGIntssBdunL32jcc8fWzGoHDfQYLtasUzoLK7AV7X
         dCMyLbMkAdcLjCyn8GudGaXWmHGGC0bC7SY/wS1j6Eb74Bbupv92KPZB4yu3UkXVUR2W
         gPPA==
X-Forwarded-Encrypted: i=1; AJvYcCXXRPV5l7XT4J/08YIOFceWT612rK5lyCIGtZu+vmQWZyMuHy/kASahmCAm+ZmHRxIx/DZMXuJDx+QK1mOntm/Wm5U9NOaMv4myrQl0tuWj91dnRMOE8ymRUh9X1ofVKdrWB1fzLDv2hg==
X-Gm-Message-State: AOJu0Yy6H96b+yrZaJya+NdsXIfGpKhvuQwz5IrHf+NxbaBp3+ENJIAC
	2IdOE4/pqorfNGnZ5Psd1vR6hRdt8pLPVAbISnd3muWU5W2lM5HubcxZqsWYbmvaMse74GF/CtR
	FX2KcUF3kK8xY752VHGjAZdvWAJI=
X-Google-Smtp-Source: AGHT+IF/WclI9nxVPYbvTRGt5Ozim4FmlJxWK0XFHHvagUIq2drNW2Tk+Lnvy0cKdMs9XBclyq0RBzh5sfTQdRGOXDg=
X-Received: by 2002:a05:6a20:a12b:b0:1b4:e10c:62bd with SMTP id
 adf61e73a8af0-1bcbb3fd1cdmr6155893637.2.1718902399386; Thu, 20 Jun 2024
 09:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
 <1716962565-2084-3-git-send-email-hongxing.zhu@nxp.com> <2f15baba-68b5-4e99-bdb5-6d2e05b7688b@roeck-us.net>
In-Reply-To: <2f15baba-68b5-4e99-bdb5-6d2e05b7688b@roeck-us.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 20 Jun 2024 13:53:08 -0300
Message-ID: <CAOMZO5ApiFtRYB5gtzxQj53SLGu_64-J_owEt4MYzABM249qpw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, conor@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	frank.li@nxp.com, conor+dt@kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:39=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> Building alpha:allmodconfig ... failed
> --------------
> Error log:
> drivers/phy/freescale/phy-fsl-imx8qm-hsio.c: In function 'imx_hsio_set_mo=
de':
> drivers/phy/freescale/phy-fsl-imx8qm-hsio.c:459:15: error: implicit decla=
ration of function 'FIELD_PREP'

Nathan sent a fix for it and Vinod applied:

https://lore.kernel.org/linux-phy/171890153156.219744.4144352903595964774.b=
4-ty@kernel.org/

