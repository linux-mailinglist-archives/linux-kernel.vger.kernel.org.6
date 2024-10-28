Return-Path: <linux-kernel+bounces-384043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA249B2390
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68AE28205B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDD188938;
	Mon, 28 Oct 2024 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XCmbdrT3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D134161
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086778; cv=none; b=k1rA/rGicZjdrBp74jy84QG9n8P6D+KKWjf4ykDRujGvhGEbEcDJgytBXJq3qnU+CJXRCrOHh3unIxLvostYAlDDDdw2woXu1ZWdk39LnwsamgBif/wkgw7utavnuTJITuzP9lQhKSzk5IfG6wYEn81RUjPCXqG/Ehi9DwTMc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086778; c=relaxed/simple;
	bh=zf03nR63oUi9aIQcnTxeMplp8aLVBVNxqpkRqOwZrzs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PLFfwYY9vTNfHx+I/9BgLKbeft/7ucadTfKtriFHBtmokwyt0BlJW0i61qC5GRDzmXmDqAK59wdcdFoX9ifbl1GpbHz0/zUCDx4T3Gqyft7H/oXOSSkjOYd7xwh2vyl3vu/kJR9tl7lZ5lfb87cDk0cy9dmlNGADyBwxxg+Fves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XCmbdrT3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2826188a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730086776; x=1730691576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBmgyqeKJRCn5Gf659C9Da/WJZdShhgowczCYBYs4bI=;
        b=XCmbdrT3wLxU9xVyb75W5gsAJPMbX4BBAeyqhEwrUslLMEhyJwlkFaBvJqj9q0pmeV
         am5A38dz082uzyfh0gv2Rpkc9rOXSSRJluk1eDhT6E6AdFldiiEqv9pBGzNarv0lkAzg
         8bqiKi7/L+v4ABgq132gL40su/f4UiBnheJUHbg34HtTvHptUp9lUG55QKyNQDe6gv3I
         ydnTJUc7QnMlHP2B3mALlO0wisbDJTDZxUJhUtlhoIhkEyNaGiXUmGH82In9E8Thc6HB
         E9xvRkZlSdGiOf3LHFA9LQ9Y5KmyPrG7IVt69t8pTG0gZ5qD/duIAU+RELimOr25ceFO
         Szgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086776; x=1730691576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBmgyqeKJRCn5Gf659C9Da/WJZdShhgowczCYBYs4bI=;
        b=nDZCc1GXABIpn6yqqVfMOieXOy2hHRw/Bmd6LWyJlVWV0mX0+B1nS9A1fZ46lbswd2
         IGwHbzN9CuG/lap09F2s1ZHDyCo17Hc0axmV1gE3VyzblOiftvVvCsN6mNS7Jd26psmL
         2OuJylKkWHr7jAHj+8w01DGGI+Fpba5qQlKZ3FzSbNibXuJl5zr7u8vw1bsjaTkxX6Ix
         hzUKyFlicZeeoVTBne5xhWMi4ss7KCjFTl5GmCiC4vFMpOPnHOA3wkf655X2eURa0QRq
         HCJAAJL4RF1N8JxN6Au9M42Y8P4BaaHCK626T+15FIowXl6A6mfZ3e3izCDDr1NI9w3L
         piJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcF96GmIuddcSHgFoIG/4j/J6bAv6nOUpydEo79Q9hFQzLpwjDkmcRYbWFyIkLII0Q0JfUsG/8i35ZKj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ6GP+WduIhsen5FC1em1k71wLE8OqHwgOfY0gy4lxJKPo6oZ
	OyDQMrJTIynn+tsMH7dk7ffEYLXWaLZhOf6OuS8cEYhk+poj7nryx2zvvyedmNQ=
X-Google-Smtp-Source: AGHT+IH453sffjIwvItRxxv3mspXtf+xzFnYsZ51wevVQNfZjTNz0DmZquqPZegSnXNUg/j6R7elmQ==
X-Received: by 2002:a17:90b:224b:b0:2e2:d7db:41fa with SMTP id 98e67ed59e1d1-2e8f11d1e8emr9087013a91.33.1730086775647;
        Sun, 27 Oct 2024 20:39:35 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e340e544sm5961888a91.0.2024.10.27.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:39:35 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Support SSTC while PM operations
Date: Mon, 28 Oct 2024 11:39:24 +0800
Message-Id: <20241028033928.223218-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cpu is going to be hotplug, stop the stimecmp to prevent pending
interrupt.
When the cpu is going to be suspended, save the stimecmp before entering
the suspend state and restore it in the resume path.

changes in v3:
1. Update the commit description
2. Remove csr_read/write_hi_lo from the previous patch
Link: https://lore.kernel.org/lkml/20240926065422.226518-1-nick.hu@sifive.com/T/

changes in v2:
1. Add csr_read/write_hi_lo operations
2. Apply the suggestion from Anup.
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u

Nick Hu (2):
  riscv: Add stimecmp save and restore
  clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug

 arch/riscv/include/asm/suspend.h  |  4 ++++
 arch/riscv/kernel/suspend.c       | 14 ++++++++++++++
 drivers/clocksource/timer-riscv.c |  6 ++++++
 3 files changed, 24 insertions(+)

-- 
2.34.1


