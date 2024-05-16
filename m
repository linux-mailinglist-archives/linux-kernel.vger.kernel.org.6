Return-Path: <linux-kernel+bounces-181287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3088C7A01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09941F2250B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FFB14D6E9;
	Thu, 16 May 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5uUj/P4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FC14E2EF;
	Thu, 16 May 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875399; cv=none; b=oBRPN2ULpqjVPKsCHRDz3kWX+NWEQsSYflRGdhqAsN3qx2xLVt/DbKIjZA8X0eXmMwVFhHYoYKBwmkGyKy/hf3yimTllpH+JhPbiqPt8877OO4jl6iwG7ow7m7AODfM73hh9HGGEe3NhEnBs1qsPHSfiKClV7rHxXM1aQZGMCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875399; c=relaxed/simple;
	bh=I2HxkgYxcy+MWDcGiUKLXiPl4ji8qHCK6XMx7iOMO2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RFFAoyuOMfEB6RHX1gT2y5pQaKUj7qDyLJI1WDhvcuy2imsjVpC6AY506YiwIi33G9QljJzCtr+EuXGrmO6wMPDCBorjFhay9oDC/Ys/5zSBDWoCj7KlMO1/t3rczX6czvwhKtSVz0BdPvzKBfs3kzBDkap+OsANNLOCcp829gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5uUj/P4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59ad12efe3so161034266b.3;
        Thu, 16 May 2024 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715875396; x=1716480196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2UlXLlotwfBEqJl5RyF1BB7i1PhDgWjZZExNzHpicY=;
        b=R5uUj/P4hzFDSx4egN6EwgjuJUPY4x8h/9KbQjIXJEHVaEVe+xxwNJ6lHMTh5VjRQB
         4tyaCZRRJ/Wqvi7Xh0ypvzNuFPRfPitsJYq9h6mZTeEiiDdnopgpFLymw+dIK3cKZRkr
         rau2G0tvCS8zS3yTO8AU3wmiyi4qIVTOjCCxbb5SH+FcLjnk3cqPYlqGU70AxostcE6v
         n2uuLLxb6okMnpBbx/x6jXUiAv9+SdA8C/9JAJCGlRahsXiz+ZXZdlaPrsbiuUbgpZiG
         pEJa16I1gYnFGEr+RxqhB47wJftUXl9+1/p5VXmmkO2eDCOm6Y0yhSDeNOjsu6lgZe0b
         ygBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875396; x=1716480196;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2UlXLlotwfBEqJl5RyF1BB7i1PhDgWjZZExNzHpicY=;
        b=tmI9aYCOVwKh4okCYEsI5VuejUr3H3L2YxT+tSWtK7VOc/TG2cg0USAFWF+zXGfjTR
         pPM3dPuvugZhu2wcNMmzQXqY0jMZxiLDq1XBRcQd805SejWXjUC0aGi1KhdgyYrDOvcW
         1XqhJ/wpUjArXtlJ9V/VWHOvvB/b7lHo0tmDLtZk5u19y4DzOMwGZjvvGiQkTS0Zv+Oj
         jcNBNvRiGaSDETAPZ8tovnsQoAPbzlsplLePRih/+ZBDBWmkmuzA0+zJiLLTpwaYuqiP
         aQclPiLDZDgJAPSTq8fq4qKH7510BNakw9ioEselfJ7pds/o3sOffmJCG+2qzhvVS6FN
         C0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWV/j1YmB9EQNd6z8aHeTIFTv0e8Q9aSJaak2hWl+VBT6/yEJozO1qq2FsODJsjbZb3QLPVOFURJPQePINC8dMMJuSNIjVmBOVBOUle4n3XOBOJTHJTtw0u3SioahJnf1o+aK/qYrP8PQ==
X-Gm-Message-State: AOJu0YyKrZpnv6OXmU4hDtirdACRzVa0kqX+3El9gkNMYv5OCbfqf5OY
	CEhptunVLepyGS1ny3/5LtSkd12L5LUt7SsamZHetY5A6dSIfKy+
X-Google-Smtp-Source: AGHT+IGUmF1po0i4xBr81rQ2OeOh8QF45K6Bg7Kx7HO+pT8V6cPBtdynozaaidZkQFVmKBx8d0YJ3Q==
X-Received: by 2002:a50:8d06:0:b0:572:7d75:a70e with SMTP id 4fb4d7f45d1cf-5734d5d0208mr17338442a12.25.1715875395933;
        Thu, 16 May 2024 09:03:15 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6casm10560431a12.29.2024.05.16.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:03:15 -0700 (PDT)
Date: Thu, 16 May 2024 18:03:14 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
Message-ID: <66462e42bebfe_15e553703c@njaxe.notmuch>
In-Reply-To: <20240516154800.125284-1-matteomartelli3@gmail.com>
References: <20240516154800.125284-1-matteomartelli3@gmail.com>
Subject: Re: [PATCH v2 0/2] ASoC: codecs: add support for everest-semi es8311
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matteo Martelli wrote:
>  .../bindings/sound/everest,es8311.yaml        |  52 +
>  sound/soc/codecs/Kconfig                      |   4 +
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/es8311.c                     | 970 ++++++++++++++++++
>  sound/soc/codecs/es8311.h                     | 162 +++
>  5 files changed, 1190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml
>  create mode 100644 sound/soc/codecs/es8311.c
>  create mode 100644 sound/soc/codecs/es8311.h

This is the wrong diffstat from previous patch v1, sorry for that.

Here's the correct diffstat:

 .../bindings/sound/everest,es8316.yaml        |   7 +-
 sound/soc/codecs/Kconfig                      |   4 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es8311.c                     | 970 ++++++++++++++++++
 sound/soc/codecs/es8311.h                     | 162 +++
 5 files changed, 1143 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/es8311.c
 create mode 100644 sound/soc/codecs/es8311.h

Best regards,
Matteo Martelli

