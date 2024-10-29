Return-Path: <linux-kernel+bounces-387869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8FA9B5708
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FB41C20F58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934320B211;
	Tue, 29 Oct 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zlEOiyBI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0D205125
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244925; cv=none; b=lWUYECpuI9m+StXpeBT55NZKjw11Kd/E9wZwcN4YXsvFNhoPg9/vCC6pqdUv7F5KK+jvYrZvK/XUhgMWI8VKe2gGkk9WUP6VOwKS8QUsILljINEFGb5UPI6mtqeCjXVhEITk+zueZ1iW+VxkqSBcULtwky6s7qMoSYE7hiPnE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244925; c=relaxed/simple;
	bh=dkInJiy2PBliCY0aq+a3ScB8fzx4PnLNym9BwLfQynU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5Ix7Sa+ltPGAGmZ+LUtTfUSK42dY6TqtmeC7QG1PWmjzd+PO40Dw7yK2BBnFlVBs1k4Vrx0chnezZf4RQ9YWe4jfji9jd4I5HySAmpy3eP1bhMCzWELYGBLPNGtRZAkqS6QEySpe2hrKNJcgxtXdFTeQQMfwtg7OMMlQ2wiYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zlEOiyBI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7203c74e696so4399896b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730244923; x=1730849723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuC93Wp/k34096m4FNfcl7QdGtm3HPvDqEomN2Uuvys=;
        b=zlEOiyBIqGy+jBBFRfxGxGfH60kKaYNxTZ/munm8X8ZieVf0+7jbtjUUgrW7x4i6hb
         ZOyXUPrOtZtdTf+vYIILLI4qmDZ06z5SjZsiXSZ7RSnJWbfcnsrEBZp5/0rAqpHPcbpE
         7lTvfJ7HdY/r+OE29H6drliEnf2yFjYWnxNsC5QoESzknTdJ7539cWs5oqnz95QeNIEf
         oPBA6KWiGUjoqme2iwrQYhU1ULcPW0NyeQyTFu2r19XhDy6748mLw8kb+7OjkI/+2ARb
         5ppXmZUNgTTXVMIQCYxuW5/7PxKHdRNv3hc9MBatjT9fpL2awsomBhNXs7EGEq+oAM/+
         BKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244923; x=1730849723;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuC93Wp/k34096m4FNfcl7QdGtm3HPvDqEomN2Uuvys=;
        b=XYPHgHsHZVT34imPvPGJMlwtQBiTgni4CP1isoKDaNlnkc7BhLVVFBhLJB8GK1uFCq
         pN6ouT3mfoioQ+6ahMSBXjJbUxl4x1UVfvU145L/aSCx3PjT97vEbJ+KfBMrgAFFt37i
         gcSPllUQnImnegpFB8O5zNgF6N0hkPLCpb54xWbW3xaYotPnPxZ01tAdVtuFEEYF7TLq
         5G5AeRgYn1sR5E/fluIbbxe+thvSYj4zIQlOhNyqVpUqxZ4bsMGk4UUwHAzynOzjTnBg
         YUQnDAM8NutEp2s46552O7i+WJbDNT/kgm+yd2VB1JWU9I9FY82VnH0cAeZ7WLbUNzPw
         amtQ==
X-Gm-Message-State: AOJu0YzAskqHJswOoy54r/tbPiJu47tssF+Oj+6uQ3MKX3oQcWQ4PMu+
	fhi/ZUR13GfUIDLIa3sTA3zM5UKgF7zzLfdxeRCp5c/Wby5sPW3fXHVpOT8n8Qg=
X-Google-Smtp-Source: AGHT+IEg8cGYug/egvhXAj5QGE9Z0f2pGnwuXP0ECo+RYa5HgVgF8z+rufzIs9vVD0U8Lqbxtb8L5w==
X-Received: by 2002:a05:6a20:d74d:b0:1d9:cc2:2c00 with SMTP id adf61e73a8af0-1d9a83c9ff4mr18135785637.14.1730244922844;
        Tue, 29 Oct 2024 16:35:22 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc869c596sm8096291a12.54.2024.10.29.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:35:22 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 rogerq@kernel.org, linux-omap@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, tony@atomide.com, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 aaro.koskinen@iki.fi, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20241010122957.85164-1-andreas@kemnade.info>
References: <20241010122957.85164-1-andreas@kemnade.info>
Subject: Re: [PATCH v2 0/4] ARM: dts: omap: omap4-epson-embt2ws: misc gpio
 definitions
Message-Id: <173024492215.1248872.10940829053391150955.b4-ty@baylibre.com>
Date: Tue, 29 Oct 2024 16:35:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Thu, 10 Oct 2024 14:29:53 +0200, Andreas Kemnade wrote:
> Bring the system into a more defined state and do not rely
> on things being initialized by bootloader.
> 
> Changes in V2:
> - better comment strange GPIOs
> - proper names for regulator nodes
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: omap: omap4-epson-embt2ws: define GPIO regulators
      commit: c14655b6dffd9ca93276f630d2c9a5973711d33b
[2/4] ARM: dts: omap: omap4-epson-embt2ws: wire up regulators
      commit: e84bc0f34f708f3c58e5268cb53f451af97fe1d3
[3/4] ARM: dts: omap: omap4-epson-embt2ws: add unknown gpio outputs
      commit: b5a041ea0bfb2eb8ab5e19f61e2772faa8110a2d
[4/4] ARM: dts: omap: omap4-epson-embt2ws: add GPIO expander
      commit: 0b96b3f1d01486e836d01d18c2f8e3f01b046cb5

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


