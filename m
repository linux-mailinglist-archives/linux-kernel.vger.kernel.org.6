Return-Path: <linux-kernel+bounces-387945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89409B584D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A84B218AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B74C92;
	Wed, 30 Oct 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDypYLKv"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD71C36
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247022; cv=none; b=dBJHuvT7pszPU75s/OrWBWKhFnXpRXMx7IeyHhECjxCrVqvC3rWJxst4CHvLiidNCb6SjMiojS6KKpK66KISpVGrvrI7TJe7PmYw8VtJ+hkv1NyjBPv6FCehA/XaK6/Q57ohGiSvp+0k8v2353iEJ0iO/Afhz1dpIfXU4tN9nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247022; c=relaxed/simple;
	bh=Um1BBdzOLBgVZV7AowBomIclS2RaECeu9YVyftjDJds=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T8YoiB7QaOKO2gPCjnD4m/BV/KNOaA+8Yxy76S8biYNaKxlgcnrz4CTUgN0W7SzVB6xsUBDMlMGa6tawd2KSmUnsmLDxXE0PVNFvIkzFh2S3iUxzEa3t5SArDw4y33LGKVjptRWXfy+A5mI/TEGmpD5sS+SuA9E6/cQL4+N7Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDypYLKv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e74900866so4580869b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730247018; x=1730851818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx2ZtyUjWj7/jT4VUlObZ/DUJ3gJnbsgf2IN8Ct+yA8=;
        b=zDypYLKv0Lw8h4o4n+tUvBG+M+AVoI9Xn07hegrTI4zKvYmqKEcbqX12uJamzrcVjk
         iVWDkZk+ivk+oLSKz+d9RYZa+FsZzVbe6N5mwO80lXaWc7Z1GNuqmK1qXhVnv5/XZePa
         TDbDjGb632Ep9wb1cv+T68E879wzDSYhNv/aWpOD1Jm37YFgxMTIBHcQlLHE6E+SRHlN
         4kXRX8tRau1+WJOpsPFXf6Jc2wWGZ2+I1ziU4mtYKOvcs0MZKr7TmB6j1MzpAIUe6KHn
         4MY2UvuHFkz1Yc0sPKxFiKEnka7Qyx50z4M04IqYvlggfyMT98xIfHupUnWrxxzHdrx0
         cYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247018; x=1730851818;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx2ZtyUjWj7/jT4VUlObZ/DUJ3gJnbsgf2IN8Ct+yA8=;
        b=kU6pAh9MWCd6+YE0nU+Mz5gCuqr/9EnKTobWT3NMSCNl4Ny0uDw2dNw/NbMiwy/v4m
         33QWrz9Eey6IyVoztrCGqWzbptTVAj/6670/1fVdwTxRMxGykOcISqfZEud+5NhBpwbL
         fI0cH24sR94HxCQTg0REK6xKEfQNd2AXXM1Bspdrc4/sQDrEhTjUOOu57EAT1Nj6+pUA
         Mxas5R6pfBpNv8QJEYbcG/zmsNTUVqet9r4ji8NaF6RU2M5YgNB4qDrzqWW/wsC9G1rj
         QPSSSHsfJKmVu3T6oSPjp22o1sTM46m0xo0OxWvj9WLGtJ5MbD8Crlv83bb9yQcCHAKT
         yYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpfMMvn6CfJBPkV8dRgt0YYA5VS39lMTiO8ThOUhxBTRH/8qDvGj29ZGQyURM/H5v16AGq45XY+myhpKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicPSj6reiHJ249erz8ab+R5nY8EubYTCb265g7XU3DE5HuPnj
	gLvtT4dyQGAd64cqjRr2z8zuY+G3DA+nnhW3h3xT4bC0A4r2mWpJbdudSK4bF9I=
X-Google-Smtp-Source: AGHT+IHUR50UflND4vAKgFx9zaRoDHs1Th9JVXI+GeYW6r8aL6K4pUKlg3OJSUCPF0WTXr9SGTSHqQ==
X-Received: by 2002:a05:6a00:3d0d:b0:71d:ee1b:c851 with SMTP id d2e1a72fcca58-72062f13bd9mr21012618b3a.7.1730247018424;
        Tue, 29 Oct 2024 17:10:18 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8176627b3a.33.2024.10.29.17.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:10:17 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi, 
 Roger Quadros <rogerq@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20241018214842.275194-1-andreas@kemnade.info>
References: <20241018214842.275194-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: ti/omap: omap3-gta04a5: add Bluetooth
Message-Id: <173024701720.1375433.423261408152684119.b4-ty@baylibre.com>
Date: Tue, 29 Oct 2024 17:10:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 18 Oct 2024 23:48:42 +0200, Andreas Kemnade wrote:
> The GTA04A5 model has a wl1837 WLAN/Bluetooth combo chip, add
> it.
> 
> 

Applied, thanks!

[1/1] ARM: ti/omap: omap3-gta04a5: add Bluetooth
      commit: d61ceb5a520162e1f321369a6aeeea28eecab6c4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


