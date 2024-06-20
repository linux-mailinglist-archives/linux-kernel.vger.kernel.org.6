Return-Path: <linux-kernel+bounces-223648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF8C911606
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E59282B20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C814E2E9;
	Thu, 20 Jun 2024 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkozrszK"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF81422B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924128; cv=none; b=uGGSsn+hIjD+ZUXzZABqsFVl2i6X5WRyJ6UOthFpLHHdnOd7ZzNp3Ch7mCFvgFsGxMEjz0ThBK2ap/W0lrlSvbWgcwP2StAOwiEo0SI5Jw2NSFUA1vT/JFfZysU7NFuydO2xcEKM7ab5mQW74Z9fHZVWszhPn8Fg8DandZ4+B+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924128; c=relaxed/simple;
	bh=NGDUIv34hYFZN854eluh2DVe78KwRqnWAHRvdoMY1uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ISx2ZJE1kI81jAxv3Pmf/r00nHBuBEu4Z4hFc7YKhDlL8T6hS5qXUMLnpRWCPY3rjXzJlRwTqMsg1H3tNMRk6cX4hOzM3bJTtRZ4VrhK5WcPggHJ0alTdbzYrsL2Asltkm0rQxoY6JpdeHz0Eb83xwLRzm85jiNfr5m1VBLUXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkozrszK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so14239281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718924123; x=1719528923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J93Wdu3UHX/SH5BNBWL2XcVx8HcjEhvK9ORDAnvlEtw=;
        b=OkozrszKoRjSreGKNRbLnnKrMe2B6bghPT+ZdV/vXuFULgsfKeWjJCS7y4/RJU77EP
         v0oB8eMnUji+HGTl2u0vRNZcl70mQun6vekwarfmFQKjw03RI1tVqaphIacIdPZQyMtg
         GBuiSOmTaS+pZTtVeBH+26n32tB3KVc+9xlznI6+3KVTGPiBHJBdSsA1HztLQpkJ2/ci
         IPhN4JG/dAMh6RE5L3UdocPCcZft/qiVkMNwZ6kR/w8F+crNX6odDnc06cF37d3YxHiT
         84/IFzAnKGQ/dTefNrw5Z7tBbM7+uSFuhRWZlTfaaJKcPEzqwKw/Dn2MXho9dnfddBFh
         9+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924123; x=1719528923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J93Wdu3UHX/SH5BNBWL2XcVx8HcjEhvK9ORDAnvlEtw=;
        b=xQCczCxzSwR3DDt9h1B0dn8SK3kT5Kiq9XHln1Fvv4wlrmbGtJu4Zrpi7BFEiuNYc5
         c70kEKL9rO62C+pVruEnD49DWgerOOY89DmRi46z5MLG07trFWeJoGoMzgr7gPWhDXrz
         L8FJfug+IyixziuBNxCPrJWmEA0MkPrUUVFe1wBJ3v4Qaj6Uv1ySctLybeUPoSwbF1Uz
         ChfbYP+XeOI824cJu3fQ28O6IJPgsTzzJbXANQpLRXvapqbkMzK1ZT6boZ/BhEMmqC+n
         8UrU1F/hVhD1bxi8ZcNFiTOoSKpAjBGyJv0cHQ6ZMGP7prhaIlUH34BDn00niKiwkNor
         3gcg==
X-Forwarded-Encrypted: i=1; AJvYcCV81QaFkuX/6GK/l1on1o8bWpCPmGYD/LozSwAfFgI6HrFPS7e5WY7rfkL1dtA2t1VSuCzDASd+yjS5hw87LzOIWWHNT3JzmsrC/Pam
X-Gm-Message-State: AOJu0YxTHL5ip/1PwIw0ZhvEqQuZG4EyezyGRtnZ1e0n/2rszJ4M/0Gh
	g4WZoVgqhpsHukImeZ5wu9O7kH4Pgp/8+v+kAupoimEWQpjWAWYi07SAHJpgEIA=
X-Google-Smtp-Source: AGHT+IFQN2Bt5zqFFKMUGCJsgkrAaABWB+x6UZRmiYHHZjBZGwfUjSSQ4U5Pk9vdJM+yd1sxDvObTg==
X-Received: by 2002:a2e:9d4d:0:b0:2ec:4d89:795e with SMTP id 38308e7fff4ca-2ec4d897aebmr1580681fa.17.1718924123126;
        Thu, 20 Jun 2024 15:55:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60126fsm510461fa.20.2024.06.20.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:55:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/7] usb: typec: ucsi: rework glue driver interface
Date: Fri, 21 Jun 2024 01:55:19 +0300
Message-Id: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFezdGYC/3WNQQ7CIBBFr9LMWgxFINaV9zBdEDq0Ew2YoVZNw
 93Funb5XvLfXyEjE2Y4NSswLpQpxQpq14CfXBxR0FAZlFRaGmXEw2cSjM/EV0FxRg7OozAhKGV
 1sA491O2dMdBr6176yhPlOfF7u1nar/0VrTz8KS6tkKLrnB2M1h798Xyj6DjtE4/Ql1I+KdSRW
 7sAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NGDUIv34hYFZN854eluh2DVe78KwRqnWAHRvdoMY1uA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1rJ5sgVx7PFb4ZH8FW6nmSoUlXRFZdQykv9LNKyS2nzd
 In+nXqdjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZiI/G72vyLrNm+y3WNfvX+J
 yH0Hv1Jm72qJtYxG+9z8b7P4zXMPCN1ifTS9V7vhWs05oSV7FT4pi5x8tSTLxNuFuWnGUc3P8X5
 f+O53/Nm8K9v9yMdzEV1tsvsFxXeUnXgoeUxH9ayX95sdhnzfFngsf7Enl1+xa/HPWNOQY0+88m
 /ZdvVXPSxgXJnWvy3F19gsQGZjOJPO5+4bgoeaAzI/hGd6f79333f6o+rL8vb17QFiPfPj/RTSf
 3u88Fp+70iRv+jX+b90uU8usWlWOfGPTUNv17t6VeuT0lufb+o3tfzpf/ljVdKCjhn7fTS5JSzW
 nM/6No37w5cTb1n6Snbw2U1+ZTrdcPEepakWcyW1ck3yAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The interface between UCSI and the glue driver is very low-level. It
allows reading the UCSI data from any offset (but in reality the UCSI
driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
is to be done by the glue driver (which already resulted in several
similar-but-slightly different implementations). It leaves no place to
optimize the write-read-read sequence for the command execution (which
might be beneficial for some of the drivers), etc.

The patchseries attempts to restructure the UCSI glue driver interface
in order to provide sensible operations instead of a low-level read /
write calls.

If this approach is found to be acceptable, I plan to further rework the
command interface, moving reading CCI and MESSAGE_IN to the common
control code, which should simplify driver's implementation and remove
necessity to split quirks between sync_control and read_message_in e.g.
as implemented in the ucsi_ccg.c.

Note, the series was tested only on the ucsi_glink platforms. Further
testing is appreciated.

Depends: [1], [2]

[1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/

[2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Dropped the RFC prefix
- Rebased on top of the fixed STM32 patch
- Included the pending Yoga C630 driver into the cleanup.
- Link to v1: https://lore.kernel.org/r/20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org

---
Dmitry Baryshkov (7):
      usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
      usb: typec: ucsi: simplify command sending API
      usb: typec: ucsi: split read operation
      usb: typec: ucsi: rework command execution functions
      usb: typec: ucsi: inline ucsi_read_message_in
      usb: typec: ucsi: extract common code for command handling
      usb: typec: ucsi: reorder operations in ucsi_run_command()

 drivers/usb/typec/ucsi/ucsi.c           | 215 +++++++++++++++++---------------
 drivers/usb/typec/ucsi/ucsi.h           |  26 ++--
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 100 +++++++--------
 drivers/usb/typec/ucsi/ucsi_ccg.c       | 103 +++++++--------
 drivers/usb/typec/ucsi/ucsi_glink.c     |  74 ++++-------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  79 ++++--------
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 104 +++++----------
 7 files changed, 309 insertions(+), 392 deletions(-)
---
base-commit: f0dbf09a40c8100a895f675d619db5ed1f58f7ac
change-id: 20240525-ucsi-rework-interface-5ff2264f6aec

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


