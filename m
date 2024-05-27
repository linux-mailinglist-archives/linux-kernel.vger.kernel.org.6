Return-Path: <linux-kernel+bounces-190716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBC8D0195
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BA91F223C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1050A161B7C;
	Mon, 27 May 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHIOs7v1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887D161937
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816679; cv=none; b=IlU9hr/bhZPp/CsOqLfOiceBbX35iUVwpPUl6PAhwACQueylHHcX2/sT1LsI+Rs8jr5ERQU7ibiHt5KU0BT9rxFPSM2WPrHnsZgMg7/li5H2hIl4tIgat8GxEsFcbCpFNB6Rtfx15UeTNAk40pZ7L0uKlOrxKHCs/VJnsXdUfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816679; c=relaxed/simple;
	bh=0bAPcc4QCNlr+4EuKBEFKnNcwG+uRa5Y8WxJpg/YnzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9PWdAdu2vj86bn6cp2MEmIXZ17Cled1JLtF6lcbMluKLZxpwRNr6W6D4YunM468QUwVOuOAHToBqjDp32sosF3a72cboXc/rKf/h9cEgN/akfcdAeYPNfa9ONUaRYhcc60nY5WL5xF3HTwH2ZP1yXcCRwzqPKAAKJOF1rN2ih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHIOs7v1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df7c1a7d745so36031276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816677; x=1717421477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bAPcc4QCNlr+4EuKBEFKnNcwG+uRa5Y8WxJpg/YnzU=;
        b=rHIOs7v1Q3AlPrpALACt/4gAz2wtCrGoZ0JWBYsMoCvfBmHXlTggsRM1wnWboTB653
         flp8BxoUAPEDRAiRnUuWcpjwnj39WHzEbZ3qYtET73lc7luVhzZ7KHTGt5hgqbe/Dkur
         xeictGrsLDMzt04xQYF9BsdPypx88tqTnpCwYu62Otn1KIg9pFr1Ce8qL1DUmJMDa7Pv
         qve8/VllGrX/+yn7kUoC7rn06+ofOMoY8ehyyX8Df2B3rH4M+nm+bsxLGBOi3TTbkmhx
         n3QHWxNzlKWESyjRKlN2T8PHBiG7KJ/sWuxDWje05tXpZ3yq8AjopzYQM7E6lbihSGAl
         celQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816677; x=1717421477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bAPcc4QCNlr+4EuKBEFKnNcwG+uRa5Y8WxJpg/YnzU=;
        b=wJHVFCF2zq4pib42ObH5DyWp6tQfkqqVfRCIBntTEUsqOZKlABRJ1IkIAhA+fBKFzc
         +fR/MybjT3i1Zvw7wTCQNVCGv+iQcocuuN3dxr9DPWMCdPcxhNtOphb3XVE1QM2SCjwJ
         WM0V3Hh/HoQzUhXr64ROXFe3FxyGKvBx+rhNFLK2+4ieVZv7LFFHqaOFusdQkEzirux7
         yegNohPLGmFNWaIv6lakUJ4qec5zzGiEfMP+u1E5CnoheVbyljffynsPdSEf9nmbcNi1
         C6wGuMNB9kXtAMpiPno5uG5U5BnNALqvq1KNpNx/zatpapN0LJe+laPIVqfaIzRSCC7k
         Jblg==
X-Gm-Message-State: AOJu0YxvKIPmug1Mwv/yllEgEkpKnlU8S3e5z1Pxtz5tqMY/jgI013be
	B5Ot2gKkJKMxgZ5pGNANsIAGarCTyoWKOl9juFh2ySf0It3+92M3GONzUQ7HQuXM/HDqMMev8Tt
	Syl+qxDN/FtpTgCV+k1dAOnoFdbO887Yyerv32Q==
X-Google-Smtp-Source: AGHT+IH7k1gsPCg4bqWj2BQ7PDTGPlf8s7c3n3xklRl8yoee7b32jueZXgT6/t5NgvOv6Kou0UFBTdFoDCZDHUEPiaY=
X-Received: by 2002:a25:7208:0:b0:df4:d883:6975 with SMTP id
 3f1490d57ef6-df55e528b30mr9276064276.29.1716816676739; Mon, 27 May 2024
 06:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-11-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-11-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:31:06 +0200
Message-ID: <CACRpkdYwefauweP_1tkwRRGP7GXDvuoE7pd+OAs74DSuh1FOKg@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] misc: eeprom_93xx46: Convert to DEVICE_ATTR_WO()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

