Return-Path: <linux-kernel+bounces-434629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB329E6926
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B3C162EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7B1DF732;
	Fri,  6 Dec 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk4BXXGh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A518A6C6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474439; cv=none; b=C7rqk+fLr9ZRwucgt70qx/AuqJSTikwb4wFhygJt6zHP9jvRBTA3SCvzSOe8s5FZ94gp3FFV9eIVHU1cP+9j0yuM5Zq+i4tiubiZ0LSaDZuoXnf7zI6YdYajIeRi3XllR4JTLI1T12LPWDa7BhA8HxuieXk3uriWtES33LxoW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474439; c=relaxed/simple;
	bh=OkwL0QgGjHbpwOJvTu6jbAUyXPydHvv8mamPZjhsB+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVYwaPj/oNKp2R6LlpOLPBOHGcqC6g/ePwUrCWc5grI0w0L//UrI3ubn0SbeJiBZd06tM05wvXQ7PI6TYDwqRbj471kW3FH/6YND5VZd9s31K8rebkyUQKmUt0Xe5EULzRyLXcB2wcEK3CQFpKnL4/lm9n+h2E608yYMHrvlmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dk4BXXGh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e2baf3160so762764e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474435; x=1734079235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VUSVD5d4Al31C/uHXsnAW+QuZilX6JYMkj8nRl9R0w=;
        b=Dk4BXXGhjEnRv8zY08ah9CM4X9IMuvJjLOxUqfN5SQ4Aj87qJSydByKyplGeB7xJAN
         0GGEbAqTSE0p3MHnEPWY997Td32DoMrOXtbKpB0cjRR0XgF7S+5qIXoCsTe+lt/jTCI0
         McCKtaiSwSN43uGfGkN5wj3V9qgoi/KjSHBLfRk8+sz875KGLdR1fS/lePeyMX6p9oV+
         cs0MxXSxerM2NGSljltkjbVhHFuicF/g5ZuBEbCVCOZdZduEcfz+ocKMSfSSNXBEYSq/
         bK1y2uKlDpCkByGFnVdEBkX3VFoYewM48Mw4oVqiDkDu6o3+wFMfJmWAHIOlVXbugL35
         jN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474435; x=1734079235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VUSVD5d4Al31C/uHXsnAW+QuZilX6JYMkj8nRl9R0w=;
        b=vfxxL3Od8wcRlXyQBceH/IQcuH3adg6GT9vBkCQ+6Ns7PIapauBsqz2Jwm+rMm5uym
         ssjKe+L1HpIHv8NGywrnQqIufZ0oj9rcYSCB3QFuKY2IvDkBpumXs0Q/ZCslIdJlNT/O
         2TOU2x1Vvxhx4+O5TH70PjwbAll9E0C/FgOFdw0vWGBdi0NHSBDE9g+wvRd3Kr5KdsN/
         lrTVA7dIM+TTDQ/9NouQI7DqGyV5V2pcdy9HC3U519sveIL5d85rDBXjQc2CagK31N4w
         I1oRPFmtr1huhL3iOOMazgbjrYRvSFxeLWak/gpsGCK/uk6hPEhDDs7hBgCNvONs+vi5
         dTNA==
X-Forwarded-Encrypted: i=1; AJvYcCU4EdNnRoWZ2f7C4uYvh3mOlE4hyavN6PlZo6vkDGCHTeMqkrx07oA9fCSeophhDNebshS7wHTwTZ6jyMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSd1ihRrPQ06RGkjsdLjjsi7ctcMYefS5Y5Q+PzD+M8TULG6G
	FIdYLmHzJc3RAn4cM1sCRsqIKwJ6eavEOcSf9xQ4cc1Hj9KZdcPPsraiLfR/KO0=
X-Gm-Gg: ASbGncsqiGbh2+6kEX481Jin00m04kezfpGbo5+Vk0AYtlZEqKfO0cOg3OiHjVorHMO
	aTT1Ffn2sX+MgFR7SeXwkt2ygofK5rjWJZMR5nZIUd4FA0qbzA3R1OYVpR/+pyaxG9MwDA0mMnN
	LzpylpXIFslunn4F1iPOZdq98GflUDUhA5MwQzFjUPxErF2vIVtLwGw2ovY60qn9yi4BpDFw8js
	e2hmbnjWEfeo/vP2qkMUNMAkqEQ5I+R4ZQ426e/vsxY5Z9okgZSfjYpRwgedoq1YqqQV9iU0Tbj
	xo+SqG5zZLVrPj2THhbydhCx
X-Google-Smtp-Source: AGHT+IFpuj5t7B9JAnco0SLRdwKPzD3iDmQdoSabd9nUYzKXx43l+NudJrIm2FG0ufsZx+78hIKN8g==
X-Received: by 2002:a05:6512:e9c:b0:53e:1fb4:45cd with SMTP id 2adb3069b0e04-53e2c2eb652mr1210445e87.41.1733474435296;
        Fri, 06 Dec 2024 00:40:35 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229751c2sm440973e87.106.2024.12.06.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:40:33 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.13-rc2
Date: Fri,  6 Dec 2024 09:40:31 +0100
Message-ID: <20241206084031.119041-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.13-rc2. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc1

for you to fetch changes up to 2379fb937de5333991c567eefd7d11b98977d059:

  pmdomain: imx: gpcv2: Adjust delay after power up handshake (2024-12-02 17:09:26 +0100)

----------------------------------------------------------------
pmdomain core:
 - Fix a couple of memory-leaks during genpd init/remove

pmdomain providers:
 - imx: Adjust delay for gpcv2 to fix power up handshake
 - mediatek: Fix DT bindings by adding another nested power-domain layer

----------------------------------------------------------------
Fei Shao (1):
      dt-bindings: power: mediatek: Add another nested power-domain layer

Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Adjust delay after power up handshake

Ulf Hansson (2):
      pmdomain: core: Add missing put_device()
      pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails

 .../bindings/power/mediatek,power-controller.yaml  |  4 +++
 drivers/pmdomain/core.c                            | 37 ++++++++++++----------
 drivers/pmdomain/imx/gpcv2.c                       |  2 +-
 3 files changed, 25 insertions(+), 18 deletions(-)

