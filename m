Return-Path: <linux-kernel+bounces-358574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20309980FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B092831D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED121C242B;
	Thu, 10 Oct 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="gTh1qXb0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDA1A0AEC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550195; cv=none; b=O4kqWlYvrUnuuul2ceact3EXxJRPlLlg7a2PRN7pz4Cqz2AhR10l+c0E5spCdxe2GTRR+geW55VCKuCuS6WLgWGtqMiOeOVA3uqH/RnEjtjWa9XYEFOndqL7aJhE1N7BUy0topU1bSxw+Tce6l8DeOQcim/8CgEvsQmx9PDJK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550195; c=relaxed/simple;
	bh=5THYtA6Ul1zB/gIz0q/iDk6Wh7FvjiYUgAPVCWiYgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnI8XRWShCsOnnDj6I7b9smgi9/0vZcl7iuq99Zuc8c9Bd0rCapJimWrf7EkfUl+e0qGb37gPAazZCcOkExpWO9XxC98P/wXSkXzeSyc5ZbIn2a7padpe470znpk/PFhWhPOj4Hee4+YwCIV3ZBNzg8XL6l9Ar7rm/dn1X4qoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=gTh1qXb0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso544422b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1728550193; x=1729154993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Is1+B0xT0DJgIJTfKwEPI2IKwOXoDmht2LJaO3sJfho=;
        b=gTh1qXb0PwyT/G404wZBgReJJKrnxPGNm2SPGpjV8JSrmAxZaaJWFAkAfi453zXmEG
         AXXsBPEpMgHLo0wWSOoV2b+3FA4ize1YziWwXnSsL4w9QN5uZkcdrjALqAkblOfxxB3G
         V21KGOJlh3XuCvWZ/1OKjy3s9qvYDNgNKXeUl21fODiDoWLruYqz1j/JGit3ZCD8Ro3k
         Xo+OkKTpZqbpv7F7tm3bECxJFEyex3LiY27kXRunVmJgmWR3cs3tIdonXxoT9z9RCivP
         imGQwr/3zZN4/TI6Ob2HhzlXQMlowFgu+ilB72iUhQM84Q3Og9IvAvVK4DB8bWFEgyVf
         AK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550193; x=1729154993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is1+B0xT0DJgIJTfKwEPI2IKwOXoDmht2LJaO3sJfho=;
        b=bbXJMT6Gd081AXthHOQmSt1GnCOp805a4JWDptpneExsxIe/m2JZBiYZG8/fG25Ch2
         Nj7O4wIwcwi7srrvAxxBGRf76lSluAo9ezwDzjhsTkQjw/ZoOQqdgxdlD0UrL1kZSxxW
         FXgwLaik+x6RE8ORDwzA6J/q9lumv6Px0doL0S51mY9lRBFLLA0CqVnZ+uTS4mN6/5Gq
         36WMYPxX2hGgYkrDEE4WKKl2I5EhRUX0f9YIF79tWKKAYkeEWMn6XHP+tKO4W6KRal3I
         TwUcFXbddZ0qnvsrU7KrXHlFw0Bmiqh3u4MbC+geQZe3sRlEQh54xap5MjB9sajGg27g
         Y2/w==
X-Forwarded-Encrypted: i=1; AJvYcCVEK0VpbA5BWtGvB2f/4+VAWJRB0ELp5YZeOpDPXgoLicKC6CyoK1wBadtDk3VXv52eP7yNvy1ZVH2FDN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWGvy7yrsHqHK3wWksnJjv/hm3DpTPJ6rULrx6BMWMGbqpFB6
	U1m1vAgSjC+Fepep3u06ya2NLIGGvbuzwFBOQgibmEjd0J2BPKv4kymaw7mh
X-Google-Smtp-Source: AGHT+IGPa2KzS1lQk4kWYWB2G7DITF2/zRVYF1XILyy1zdpz94E76tG3SElO3xiV5vLLITgefyRFiA==
X-Received: by 2002:a05:6a00:1a8e:b0:71d:fd03:f041 with SMTP id d2e1a72fcca58-71e26e5b7c0mr3828812b3a.2.1728550192957;
        Thu, 10 Oct 2024 01:49:52 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:beed:8ae1:b5d8:8b56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f53f8sm614141b3a.55.2024.10.10.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:49:52 -0700 (PDT)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 0/2] rtc: pcf8563: Switch to regmap APIs
Date: Thu, 10 Oct 2024 17:49:47 +0900
Message-ID: <20241010084949.3351182-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series switches the RTC pcf8563 driver from 
i2c_transfer methods to regmap APIs.

This series was tested with PCF8563 chip.

Nobuhiro Iwamatsu (2):
  rtc: pcf8563: Sort headers alphabetically
  rtc: pcf8563: Switch to regmap

 drivers/rtc/Kconfig       |   1 +
 drivers/rtc/rtc-pcf8563.c | 212 +++++++++++++++-----------------------
 2 files changed, 86 insertions(+), 127 deletions(-)

-- 
2.45.2


