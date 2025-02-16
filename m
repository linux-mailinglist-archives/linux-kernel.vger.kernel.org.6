Return-Path: <linux-kernel+bounces-516664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C766EA37585
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9C18925ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A919ABC3;
	Sun, 16 Feb 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trl6gmGW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1619AA63;
	Sun, 16 Feb 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722371; cv=none; b=bWlxfS9Cpr3weENl7jtc0qEMsmBR/j2hHZ7CPCuwYYCbjzUXGQ+fPAczQntzITS1KyWUWuw1c+DWSlDQZO1NOPVzPN0mnCRJ8nv7dP0kPG25Wj4r7ul8tC1ePDw2quZ1oXThoXIk8PIjcwwZBtdFALhojJHtqsSKjcW95LYhPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722371; c=relaxed/simple;
	bh=VndJDVg9YatuDmR2dyI0nsfazQ0pkBkZR0RUf3FJdaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dlIVOdu+4xSt/dsWk/T6nq/EyyvGA7wlqg8kNujwBdhE9kr7Bm26W0SuSATYdsoeFqQV/DC1oCYVBEPyP+5gB4soR5izgiZgWQwZ73y9Oe5feFpRWM+s/uOZ+M5Hi9cI1iKwXuZNEM3MSKFDTghf2oWWfTqyGNKa6B36ZVRHFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Trl6gmGW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb86beea8cso134735966b.1;
        Sun, 16 Feb 2025 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722368; x=1740327168; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhE6mCrV00cPqZ/38oymcaf0gt9DnlaLDtrpyaQqJ74=;
        b=Trl6gmGWKrfJ5AxFnBRdUXMxz9RwqSaFuGBlpIzpxwi0ome/tKTVqwdIhBGcc7DGnf
         OoN+kIMU59T57ljYugqlna6irpvaS4Izs9lUejpc8a7AFU1Bye2b7iVYxYX+am9wUTdf
         BtqTI01LAz5LtTipFBZYWfFoxclyfj0sRZx/V5eZfk2oT9nL0VCHIPBh7pWVnLMztrUc
         YTOvdHPydzmodx8XIqiZURPekYMui0GU8QS3e6xZThtzHCx1xI5WQfMXlIMuk71Qkiw0
         35JH1xPdir3Wpefe1AMbc3SXw1NgT0PNiqtDQk4s+HUWm1yKaYh/BHbNsi+Sy4DkyX09
         Vbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722368; x=1740327168;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhE6mCrV00cPqZ/38oymcaf0gt9DnlaLDtrpyaQqJ74=;
        b=NN5I3/2j1iU5NzcBd0GTRvKo+OgSW6nt8UaFz54W2e+1BYpWXhV5Xof0kJ83+xGr9t
         NGMjc3Xuu60o/o4lgP3ZuaKOYQpKc2Xl6uS3IjDSN+T6Tj0MTqG85jXPRtwQb5e48k3X
         UF8Um1XzZLNtRIjsSYzn3Quf5TD4kQGjTm4ig6ssNxErz8SvWpubgnv6PP9E1ocYqr1e
         x/2IyO7jiPqv2xI5BfWrT7VX8tMVEhDExNWvccNDNptMG3qCdpkzU/NxXE5U0wHHgpLO
         0kIlv7DJkF++mL1CzrmJasapjxJcyLugOH48B4jfbKKwMrmsqeRcDAvRud2NcrrNKIsk
         qWmA==
X-Forwarded-Encrypted: i=1; AJvYcCUcCb5Ii9xpQwmE7yK+KLMk40ayPwgJ/W31zJ3JJ1d1Ej2ojBAZ0Ju/i632uh/xSIXzZLcTvyh6FjjyFnG3@vger.kernel.org, AJvYcCVboNT/lmQIdqPD9oFM7zMSl+A483leZM6sqb28J+BTCApDl6xDWR+6Q74YmD5hmULN1fkUdK64r+jo@vger.kernel.org, AJvYcCXg4gJGYHMr7Ti3ZYPcd8vdpUh+/ZvnOOJoBmna++dxx5Yl6mzVcJ4L1UpXO3fmIjK/AgCHTJgKPx/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2whXFTftGwsnjFh32Z6kw3oOn41Gb2XdVpFvhEItpCdkyKvB
	DXgjhzAieNrJ9C4pe4U0z9RnkU/fik99ns5NKU+q3B4SNbygSZJm
X-Gm-Gg: ASbGnctUkte+xoLf8YvdIxf5YyVX9EQzDkdxeCrWz4aQZrDggCsmz0YMNVqXEw1mFAI
	LwxxGPWK9heyMtIcH0eTPv++U8iLbnZ2P9NuNB3D7VpILI8I/QYZQc3Mb+/Y9bpoNX4dSJR2LA4
	L3YgvGaxULiC0g5GXX23PIvP3cavcrcgfDNGmAURqGx1wzq1EDBGGK4CeIugWXmCgDmF25KqKl0
	uOcnJKeDiNa+ZMuTaJkVeB5JrkrOTTwgZrcnR+fWSZcolUReeVGyNuNLwZh4oNgfY9Mm4oXLEDk
	zxRPORStD7GFyvbG0xZYvruCYVlvYwWZd+8jW6qWUeJ0q581Zzgk8tp8mPmOPQ==
X-Google-Smtp-Source: AGHT+IFZcBKZLuTrREEZYbZmMiKOpoUUKwOcKCZKvMuw8VSt9sORJfi0sa4jUlG53lfdZrAamixDZA==
X-Received: by 2002:a17:907:86a1:b0:ab6:d7c5:124 with SMTP id a640c23a62f3a-abb710e1244mr665211766b.43.1739722368028;
        Sun, 16 Feb 2025 08:12:48 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm148463466b.161.2025.02.16.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:12:47 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [RFC PATCH 0/5] clk: bcm: kona: Add bus clock support and
 prerequisite clocks
Date: Sun, 16 Feb 2025 17:12:35 +0100
Message-Id: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMOsmcC/x3MQQqAIBBA0avErBuwoQi7SrQwm2ooNJQiEO+et
 HyL/xNEDsIRhipB4EeieFfQ1BXY3biNUZZiIEWdoobw8M7gfEe0p7cHtqR75tWwbhWU6Aq8yvs
 PxynnDyBk+yhgAAAA
X-Change-ID: 20250212-kona-bus-clock-4297eefae940
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>, Alex Elder <elder@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739722366; l=2902;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=VndJDVg9YatuDmR2dyI0nsfazQ0pkBkZR0RUf3FJdaw=;
 b=Aj+S95AdzH6PYfIDtw4X6UiHnfAMsJDxghiz26jTAILo8QEHe249qhRGIVa2VNP+NOEnLJVSk
 3z1CWVQtdVvDlCVsO9KrPJsafXQpZqtw2t9wNK8KgD1Aa9CR1AopV2R
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Introduce support for prerequisite clocks; this way we can
  make peripheral clocks automatically enable their corresponding
  bus clocks.

- Add matching bus clocks for BCM21664 peripheral clocks and update
  device tree bindings to match.

The prerequisite clock portion of this patchset is adapted from an
older attempt to add bus clocks[1], submitted by Alex Elder. I've
retained his authorship on that commit.

Notably, Alex's patchset moved clock initialization to the prepare
function. This seems to be incorrect; the prepare function gets called
before the enable function, but not before "set rate"/"set parent"
functions; thus, while clocks enabled fine, any configuration done
before they were first enabled was broken. I ignored that part of
the patchset and only kept the prerequisite clocks.

I would appreciate feedback on the prerequisite clock patch, hence
why this patchset is marked as RFC.

I wasn't able to find any other driver that does something like this,
so I'm not sure if it's correct (especially since I had to switch from
non-locking __clk_prepare and __clk_enable to the regular locking
versions, as the non-locking versions are no longer public - they
appear to have been replaced by clk_core counterparts, but those
functions are not exported anywhere AFAICT).

An alternative way to do this dependency would be to wrap every
component with a relevant bus clock in a "simple-pm-bus" node
with the bus clock in DT, but this seems rather unwieldy.

[1] https://lore.kernel.org/lkml/1402926007-4436-1-git-send-email-elder@linaro.org/

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Alex Elder (1):
      clk: bcm281xx: implement prerequisite clocks

Artur Weber (4):
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus clocks
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  18 ++-
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 +++--
 drivers/clk/bcm/clk-bcm21664.c                     | 107 ++++++++++++++++--
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         | 124 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.h                         |  30 ++++-
 include/dt-bindings/clock/bcm21664.h               |  19 +++-
 7 files changed, 411 insertions(+), 31 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


