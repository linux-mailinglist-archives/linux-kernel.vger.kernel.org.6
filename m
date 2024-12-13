Return-Path: <linux-kernel+bounces-445188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CB79F1273
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7971163067
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FE1E3DC3;
	Fri, 13 Dec 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y+901lgb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE91E2844
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108307; cv=none; b=LMmLw1W84CAE/Ot1hD6t2G1PycbsSfRhWiZEN6WgQvcaq8pO5fUa0WwhwbZaEcmaSUyK+S6c7E2oZV93DyCFQ0U6eKM2f6CyYGqv5lnQ7071Lr4UcUOvpGgZVYX02Hvogt4mi6aQRNW5ZWgBZ+jljqYsim/rFP58jkXTIAZmgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108307; c=relaxed/simple;
	bh=T/GytS+4PmeDHSc8Yokbu88dnVT2T9R2mcNeRjKO2XE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l56KedkMjBwmwroTWWaKPXNSrpJFH5D7ad2HacIkjsauSrPFp/sAum8Wv93sJRyU1GGQOzdelr1Q5WBBk57g4TPM+7k+/NtzQB6Xaw+75M7JM/c36y5z4PW1WkiebT/HXaGjYcLHQijmr28ASP1/UoYVZ/Sh9StGbcprzeGL7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y+901lgb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so19716575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734108304; x=1734713104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj059QNAy2kL/ZdSBcjvPNmyNAKgw00EKL6UseZCU10=;
        b=y+901lgb5DHirR39aO7fApA0QGWWCrOo8H8j6VM9MMpuHAjy/4j3jyZpzc2gr0ab9m
         h5Nl97z23MjomrSGidluvszuPpfpcgXQY+u60zZiWxOq0H3AFv/B45+9JHcPIHJe4+fQ
         cBM4xqFxAHO/S3vYWIrJXtEMdsH1kaRWKZIQ5colXqFH1aQWu/J8pyY25Mbl+iXFAZ4z
         ZT1no3zxGuhmCWIE4lQxOA4VH8Sp8P9cI3Xvzwg7zYVhh5sFlDU9IoIxjFZjjcyqEg/e
         MvTFrngDECyWUjTzsH1vYhxz0wmFqtSemMw3diyryBessbnlK41aFerY/DshDiYSrwQO
         2PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108304; x=1734713104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj059QNAy2kL/ZdSBcjvPNmyNAKgw00EKL6UseZCU10=;
        b=AuXR/87vzezLfHNvyhMs1Egt8Lvvud0PwpWrU8Wb2dgU93dmf6HpSfYVCs8k5y521g
         tIcjekp8kDQquVGPOZRM6bOpRtlihqrlMAnUShkh1/R5PTCTnCgVPGLE2gW5WoYjDU28
         upH70BdCkTHVRfPwluQdKEc//pFVteF8Wyh4VyEmc1x4TTgn65aq8QZ0w/UCs0EwTKaR
         TT/H9bOopQhjPv0SmBHHrTL2Cdo4pFJTxQ2Ft3HymdE2ROhsO9CoUsPKcCuA2A0k3Ute
         CuPJQV+EaAEJrA8X7iBRCDk37S1xo403AnbFI5PBlRE/ZspVSyc4kA1kSTQ1zcCj80MS
         LNcw==
X-Forwarded-Encrypted: i=1; AJvYcCUbPMlQp662nszyS2tC/L0TVonR8fqRtf0GPbd8E1trbqMP9fJZvDy8Fx6ORz1Ul/grN5lHpZigydMMo4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGQ4S3E9At4G0VUYiD/K4Y+9n8W1qjna2EEQIZ4WtRnuI6j0p
	AYY7la0JNfB5eMUxt5syTfaYETzQYosK3IVU+4MxqSzMxJFh6TWumGx7pcSGwOlZEnutfloE+68
	+xcY=
X-Gm-Gg: ASbGncuvaaTl71MKPgd5gX2Y/Udc+och2f6jeIDHSg74/qTi96dstbQuDw8KsRDIOvt
	euQJN+SekxeVC9AMXM0Ex/vFJPnDAG5NOtuf4YK50n1wd4uzJDkLVqE/3nxGSZxjP/+XhSzvb7x
	vgycgnSr7Am8N51MLdpdP0Zy/rYc2u0+x2Ua4g4SN5mNx/xnR+Ae6cuD5WoffmHOx1+RoyRBfQo
	XVSm/f/1BCMQmGBBrrJGDSh7YD+XW6+BLes3obzNgXJc8sRof+FjBw=
X-Google-Smtp-Source: AGHT+IGnLdKdpE/QYD952czjZlkXlMjWgso2ZS4RMAZDJZtkXDd4A3mxRp2mElniWLwu/q4tdGMNaQ==
X-Received: by 2002:a17:903:2445:b0:216:5e6e:68ae with SMTP id d9443c01a7336-21892a028a8mr48630185ad.31.1734108303961;
        Fri, 13 Dec 2024 08:45:03 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21653b0d4f5sm85404995ad.70.2024.12.13.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:45:03 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: rogerq@kernel.org, tony@atomide.com, krzk@kernel.org, linux@treblig.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211214227.107980-1-linux@treblig.org>
References: <20241211214227.107980-1-linux@treblig.org>
Subject: Re: [PATCH v2] memory: omap-gpmc: deadcode a pair of functions
Message-Id: <173410830317.3067997.3764368773601763146.b4-ty@baylibre.com>
Date: Fri, 13 Dec 2024 08:45:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8


On Wed, 11 Dec 2024 21:42:27 +0000, linux@treblig.org wrote:
> gpmc_get_client_irq() last use was removed by
> commit ac28e47ccc3f ("ARM: OMAP2+: Remove legacy gpmc-nand.c")
> 
> gpmc_ticks_to_ns() last use was removed by
> commit 2514830b8b8c ("ARM: OMAP2+: Remove gpmc-onenand")
> 
> Remove them.
> 
> [...]

Applied, thanks!

[1/1] memory: omap-gpmc: deadcode a pair of functions
      commit: 56d96fc5539003a95b8ab631a4ebb5d1b0a24885

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


