Return-Path: <linux-kernel+bounces-383035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA19B1665
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DF0B21B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B61CCB2D;
	Sat, 26 Oct 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7b/THSr"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7B217F5E;
	Sat, 26 Oct 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933731; cv=none; b=dNrQBQAIWT2AHbIKdZN9XpR87VacaPM7u1UBYkd2D16pS8CbDxcTeX+vUXerVBx29QVfLTGsKX0L7ScXZARwg/UBeXyDR9PNrYWVPryBvRUfftJlyYQipwLd22xkc/8g8mWIVm3TcZ7+422Y/vQfB3sliKfgnM1NVLm+Hq+NZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933731; c=relaxed/simple;
	bh=RSN9ic9K/Ut+YDWJ2FWRiKaKIHsNfnpXRZOz7BrfrY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LsD1OhggC5S0OAl81NOoXZae/0Zh/EkVkn7g+srGZymqyTvll1p6QAJtM+f9YCtV0/s/2GfmzTiD/KvufUIoKWLnc0mgZkcGmagln8kmaHyOI8un4ZQXrLCFQ4hYfs/Zmqk0MxBWsFE3IVLy9m5bFZd+iE1IvvFKzvlfuyIiIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7b/THSr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a4031f69fso376494366b.0;
        Sat, 26 Oct 2024 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729933728; x=1730538528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCIJLuA6muWOiLwe3bt6iFWGsmI+thbuxm3D0I6OTuk=;
        b=I7b/THSr1q5gvTH89kLRygzMwfFuhpiVqUKwCxAmOekWDz6jCXU0NloMeUXKa8Y50j
         1Gf7qWBBzWSIPDVh9W7wjhcizhbhFMLwEzm6UfnxnWLugBlyfkZPFVRVUqrRJ0Ff9M4T
         vYTUobxL6ZEAQFDt930HTwxL7ib+jMpqLx7192EOIf2YgxUwXHoiqeD0G+NQZyQAOqZq
         3Mt2JYOPk+gtqXpTvpe1hwE/asAkgBybKqiQSRbgzqbIyut24LBnLmVAoiFOK2WvEiKS
         4HnpAflBuNrkr/bUVlwXkx7ztFer40dX6OS8kzUAIrJ7LPs+wfP+QGg8wuI4YJYaHt7m
         q0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729933728; x=1730538528;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCIJLuA6muWOiLwe3bt6iFWGsmI+thbuxm3D0I6OTuk=;
        b=dorJ6CYZUmofa0kjRqrNjHarhIxwpRR92hxwRebMxpzisbmTLgfaap6/ZEwmuKvKCZ
         2BiKvPoXKwf++S3WyNqDBDjBfRtadusMIjzNepSeEHlP2CMpkeBSwn+QDuLaKHOTzdfY
         jK91BkYF72qQmLlANyWb4w6tYcBCzTnkedUyf5LYkkO1Jlokc64br3oxZwpCmd/H82hG
         wIrWYOLHqeJVplaw+NlAC3gita7+InJ/Qg2qAqgz7ldPxGfx2CZco02gtsreO6p397SH
         v5DjEGCH6mHY0od8Fzr0a092bzcSuMh5uw8QaBfkdwnXvuP/1FkukHjXQ6fziU+ptjpQ
         bASg==
X-Forwarded-Encrypted: i=1; AJvYcCUoUifriEjAYyoh7bMg9E3mbT1atIR6V8hPAFXeIwQFYQ6RNBcNOMtBlDIfig1UUqkHwFxmv+xDDDv/ZpT/@vger.kernel.org, AJvYcCVgBCDvtyQbF2rOqMeTZdWZAF1m7Lkl1odngItOy8G8Z8gCDRLh9KewQf69FmCJigHvOiVrn2Qr9UHy@vger.kernel.org
X-Gm-Message-State: AOJu0YxmKVSKm+xJnfyTscxRrAYbqTTWJm7Ex4J98BLOvh/tpIGhWPat
	R/WxlFyMPSJ+/QBYcbt2glR5vhfbZuqyVZNpB+h5Eh3V6TaG4L3k
X-Google-Smtp-Source: AGHT+IFiTArWsZ7bqEuvvcec5QUqM9skKob+qZCDa0gSJUMRL9sVcXzYmbvYEFPqlUdOJSgY16dNKQ==
X-Received: by 2002:a17:907:94c1:b0:a99:ffef:aec5 with SMTP id a640c23a62f3a-a9de5d774d0mr139759266b.23.1729933727678;
        Sat, 26 Oct 2024 02:08:47 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.chello.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a9b30c7ae0bsm154063666b.156.2024.10.26.02.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 02:08:47 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Subject: [PATCH 0/2] Add support for LTC2971 power manager
Date: Sat, 26 Oct 2024 11:08:43 +0200
Message-Id: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuxHGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3cSUFN2ckmQjS3NDXcMkE0vjtBQjwyQzEyWgjoKi1LTMCrBp0bG
 1tQAo1tbdXQAAAA==
X-Change-ID: 20240930-add-ltc2971-1b493fd21b64
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2

This series introduces support for LTC2971 power manager.
The LTC2971 is similiar to already supported LTC2972 in terms of the
number of channels and the register set, it differs however in
the supported voltage range.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
Patryk Biel (2):
      hwmon: pmbus: Add support for ltc2971
      dt-bindings: hwmon: Add ltc2971 bindings

 .../devicetree/bindings/hwmon/lltc,ltc2978.yaml    |  2 ++
 drivers/hwmon/pmbus/ltc2978.c                      | 34 ++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20240930-add-ltc2971-1b493fd21b64

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>


