Return-Path: <linux-kernel+bounces-387883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACB9B572B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85AE2848B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6020C001;
	Tue, 29 Oct 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PFiC9ELJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908820B201
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245449; cv=none; b=WTeVE/QLLLRGgSBe1culqUqDw7lvBw4Y3sAkjtqkNsQi8fNBrCM4PUf2UqzsqHuanDnl1Zry21zZ9EIdUSHvMicxhzhc+K9A5TwzZZcmd6lsgiH5jnRFFfHhz9ENS1ZMndD/z+tblsTdiBVbs6S53CyftgxMz23rN2GTPBIcmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245449; c=relaxed/simple;
	bh=ysyVo0n5FvDl2lFjAzreUSoTNfvC5B1zkPO87Gt5vhE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bkjN2RK8VPSm1rnd9ovGUj9BBAzjurPJqwo0M5P2XdXwaIRXcaP4zxRU6hbsUj1TiuzUQABh5ViZX54LUbZeNy/d+FVy6G9DDQY3pWiP1QqVpmFeE6mOol0aEl3kDVycleRTMieRUUr1QEvBuXvs7E9d1xML1dK1Y3Jf9XgzkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PFiC9ELJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso268528a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730245446; x=1730850246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igJJeog43E/zfN61FrtJEPhQv110hxetbVpL1KXxqXE=;
        b=PFiC9ELJgfL+AzOwg1D1Nj9y1beHINUc6koJEFFonmoCnH/BaeZSUY86c6Lay5RZDr
         HAzpm2qzpD4iZ3QByEXSYAUamynmePIgSQO3O5I041JA/jj5N6vp/72//g9ZrDlb3GuQ
         KKetea6TPb1XL0CQF+2eFgk4shR1Gm5JvoGXkFoV+YpFg/HwnZZfNUz3p3iipQdHCvvJ
         HH+DyDYMjWFKaq/muKAdVRgp1vOvIVevw5++Wh/u6Z6yTr3O04QXb+hFXqyJW34ZsqR4
         hy2sm2hTAkTJf55szXxfLQYMMyKEpOIbKTj5BseDK79qVNWW+mJkZoWdYfI1Stv6IifG
         Gezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245446; x=1730850246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igJJeog43E/zfN61FrtJEPhQv110hxetbVpL1KXxqXE=;
        b=IjdGFDEvfjEEh42POSZq0BEMOj0d6rrlT5zbiwy06aUpxVC0VDo07zmvcu8apFj3dG
         uAy80hQRkwJZttwfm2vOKLCv13Md6hVXnRZKFySt6ePJviwxIRFZ/wcXthAX/S9R/Pve
         49UHGycoYJV9VHSnNS1U3L53AXgbPkiguLX/BdUmPLH/utB7dfIdZRJVQl4xQ4cBaIHA
         3Y9wtwUGfUvRSMci90idxbM6BMwNsU9eg7PZ6bpdHcfo63UR+YIoeJ0wU2yRYvWDKhuO
         6E5E01teHn/yLmwCFT/P5Jpn1SSgotngWhQIGC6Tdizki7TRP7gD7W5VcGeDdp4YgDVD
         zheQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyyAWCpzWFJ0/ugPoDAjcbEqxs6L2bEpeZcJexPWe/vvKfhD8MV9b9dZZzChZNVZuLUVGytwgA8mjppxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsuqgixinMu7j+S5CJLS/PToujJiZDsy/CKWNk3wZ3y8hm2FO
	bgEuhh+sCjQu0UMB2pGZnolX64NKITLfnHLUn7wgJLhiPBrESN0TfeBB7hhUuoHRc3TN3apIdat
	ON3k=
X-Google-Smtp-Source: AGHT+IEtGLy8A0+FtzyHgXO/orCTN0LXYfjYWute/5tFYb2ns9hvuTiQzl4BZqgnmD2XcibkujilHw==
X-Received: by 2002:a05:6a20:6a10:b0:1d4:f7e9:172a with SMTP id adf61e73a8af0-1db7ff61c9dmr597015637.23.1730245446276;
        Tue, 29 Oct 2024 16:44:06 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791dde3sm8167490b3a.29.2024.10.29.16.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:05 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20241025164622.431146-1-andreas@kemnade.info>
References: <20241025164622.431146-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: dts: ti/omap: dra7: fix redundant clock divider
 definition
Message-Id: <173024544474.1258780.10487507771077792076.b4-ty@baylibre.com>
Date: Tue, 29 Oct 2024 16:44:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 25 Oct 2024 18:46:22 +0200, Andreas Kemnade wrote:
> Clock specifies ti,dividers as well as ti,max-div. That is in this case
> redundant and not allowed by schema. Both specify possible dividers of
> 1 or 2. Remove redundant definition.
> 
> 

Applied, thanks!

[1/1] ARM: dts: ti/omap: dra7: fix redundant clock divider definition
      commit: d0bdd8bb7f35a2b4434a3ef665f9cfc3aba886c7

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


