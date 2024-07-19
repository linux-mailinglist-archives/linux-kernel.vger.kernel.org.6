Return-Path: <linux-kernel+bounces-257290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E09377FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC80B21B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911113C679;
	Fri, 19 Jul 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="a24pV2PV"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6313212B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721393464; cv=none; b=Uh1+vAKwrUzDfyt8MQoVbvBsaNADB5z4CzsvP10Jpj7f3BM84ZqT7l/c0gI32EWl/9TO9nQ3aYkrTZir6vp8FNg/u12xBBNJmEllUAHCrtPRLBR3ViDdfq4l4pJi9IDto82OX3J/LiqFEdZeVD/MINtCLLyHJTx8FFOflTwb0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721393464; c=relaxed/simple;
	bh=xXt0N6VYWW8YPDnvrImicbI1rr1ol5K85y/byXpzfDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ux01VEoffYO2+0+lRAfaeHZKlCS2g+VWK3821x41bvLf+kDZkDyCZzWdp0uDYKPL8/o6xqrfF57AoTkNxHJBST2gqlgP4ni8A4wwnpkhIXbgeY+ai04M55zfvN9kzuNhKNVIfpmz2oJNaTHyZ8W1HhquDjMf50MA2ARZdU4mWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=a24pV2PV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684407b2deso605350f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721393460; x=1721998260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnW+QtOY6ZtIr/UeldkQWe3PjOOS9VeTPtLph4J8Lws=;
        b=a24pV2PVV+UXvd+8TSIIAwN2n6BzSq+hS2kY7FYcuo45sq1Lw7l2foOI+k70cUzJjC
         gixjDRUymUVa/F8GQFcxMVJ6RNrzRDccDw3EX3fNGSGTv85MomSSNRMfCMnXKBdbdGJ9
         WizVISKmBC7UNJNrAuPv7EYYDC9KnpIIV3zYmyAMF1mjF5zmq4FgyJH35+Sun7Me6xdK
         hURoj9YSWZzKfk/MjcMpQYPjfuHJXM3GWiyMtFHj72uHooQxyiKNULkECMESxv7+5mvV
         Ksgokq48qSYyxwnJ4wWAi+OmsxE1vPHrk2pp5zVGehd3QM9NEcxdGgSKsMWBsI91+Svp
         9ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721393460; x=1721998260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnW+QtOY6ZtIr/UeldkQWe3PjOOS9VeTPtLph4J8Lws=;
        b=nRcPRCTkKzvwgeJk7IdytwYkYckcJqgOYMYQPAO4nbxnERRkwIiiK2Fk3V9vfy+bKn
         KUcFqdW8ciZXxSRPsOoMBcE0XUJvTZg2SMBYxbxO/zmUCBEqPzy+hC8xajrwn5e9yKpt
         Q+KLUpnOEfeghCW1deg7jnSKKeYNxz5JQdmqw2Z4PGZ+Ljgn3vyJo5TvakXq9wYZdjLf
         mSUsWl74mITw5/3hDQQydhobpNtUHtMJ0pKWLa1YaDSNse1U4IUai/fkhmoGwnbX3cn4
         dav+x3luHK5Uv/utd0J3wWGsvt6LgNLJ63VGlp6VFkqMpwYAIAZsYsjPP0EjQwItod2C
         ZPvg==
X-Forwarded-Encrypted: i=1; AJvYcCX//4AkjpGi/7DYBxZsAz/utFXHEFcXLTF8GkXpZUeU6oBIFAGgpkIuSFhexpCEB+rUvNw5IbFyVjhbi1KkVlhKMABu/Djak5G+fK98
X-Gm-Message-State: AOJu0YwJLIlDOteS4QLYEujbdh0fdH2AknrD2pz4x7k1H8cv8UfqVBUy
	wmFvi1IoBjMNJnoyLuPMSm2PjwB1gwAXp1v3qRyz5mp3dx9KGpf5j3DYSEuTGSQ=
X-Google-Smtp-Source: AGHT+IFtGBLg+/5tPGgRE0///9QUX0tULII5KY2w4QbcK+acLl1/ohPlPdg1KivOMZFgPNhfWnb1xQ==
X-Received: by 2002:a5d:4a4a:0:b0:368:504d:c3a4 with SMTP id ffacd0b85a97d-368504dc3e8mr3502992f8f.17.1721393460404;
        Fri, 19 Jul 2024 05:51:00 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2911486sm21217445e9.0.2024.07.19.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 05:51:00 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH v4 0/2] iio: humidity: Add support for en210 sensor family
Date: Fri, 19 Jul 2024 13:50:52 +0100
Message-Id: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxhmmYC/3WOyw6DIBBFf8WwLgYHWx+r/kfTheKApBEsoLEx/
 nupprt2Nbk3J+fOSjw6jZ7UyUocztpra2LITwkRfWMUUt3FTIBBzgpWUTQesoWWEs6cVZd4kUR
 4dCj1sotu9yM7fE7RF46StI1HKuww6FAnwSqHinzIXvtg3Wv/YIYdPcYy9h2bgTLa8EIAsKxsm
 biGHpW13YhGTdqkwqbTY7fN/LeBR0OOXLZCQlPI9o9h27Y33ls3BhMBAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721393458; l=2884;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=xXt0N6VYWW8YPDnvrImicbI1rr1ol5K85y/byXpzfDs=;
 b=g76wwo273v1rT/N4jDr1SzfoGlzmpqfRcCocFBorbKggtLml3otPxVQCEqMA2N0OTgsnF7KHO
 BwZ6bckW/WvDlgEFzXvgAhlw51QYYVm+dFqeRyeNytUzN4N/1qS4VGU
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>

changelog v1 -> v2:
sciosense,ens21x.yaml: Add supply to documentation
sciosense,ens21x.yaml: Add fallback to compatible strings
ens21x.c: Move i2c_device_id next to of_device_id
ens21x.c: Use i2c_of_match_device() instead of of_match_device()

Many thanks for taking the time to review my patch.

Thanks,
Josh

---
changelog v2 -> v3:
sciosense,ens21x.yaml: Update yaml to match dt_binding_check

- Link to V1: https://lore.kernel.org/all/20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk/
- Link to v2: https://lore.kernel.org/r/20240710-ens21x-v2-0-a37c22018b0c@thegoodpenguin.co.uk

---
Many thanks for the feedback on the driver.

Changes in v4:
- rename ens21x.c -> ens210.c
- rename sciosense,ens21x.yaml -> sciosense,ens210.yaml
- General: Changed wildcard ens21x to ens210 to avoid wildcards
- Kconfig: added crc7 as a dependency
- Kconfig: remove extra blank lines
- ens210.c: Moved constants to inline
- ens210.c: Created ens210 chip info to handle chip specific conversion
- ens210.c: Added documentation for mutex
- ens210.c: Fixed sparse complaints from kernel bot
- ens210.c: Changed htonl to cpu_to_be32
- ens210.c: Renamed dev_data -> ens210_data
- ens210.c: changed of_match to i2c
- ens210.c: Added return check for i2c write
- ens210.c: Removed switch for conversion check, use chip_info instead
- ens210.c: Removed unnecessary retry loop
- ens210.c: Convert read to u8[3] type
- ens210.c: Ensure 'correct' path is inline, use early returns to break
    for errors
- ens210.c: Changed mutex to scoped_guard
- ens210.c: Changed part id mismatch to dev_info from dev_err and removed
    return
- ens210.c: Moved name from id->name to chip_info
- ens210.c: Changed data field to be chip_info rather than enum
- ens210.c: Formatting fixes (consistent spacing, extra line break at end
    removed)

- Link to v3: https://lore.kernel.org/r/20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk

---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

 .../bindings/iio/humidity/sciosense,ens210.yaml    |  55 ++++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens210.c                      | 341 +++++++++++++++++++++
 4 files changed, 408 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>


