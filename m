Return-Path: <linux-kernel+bounces-528395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4AEA41754
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17903A4634
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EF18B47D;
	Mon, 24 Feb 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZa83+ZE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252E1EB3E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385641; cv=none; b=ORcQhc4RhGfsvhOIkNPJH2Xrj52qc4BZtSTdDQpPs4OQAGmIm/CGK1JiLvGKeqFk0nmszhiTTXSaUlN7wuQx0rcc6jqA5zes9oNJKRLEQxKm3fV6lIn+UfXklAoNOqtRaI9Tf4MMtI0h6l9q+Q2O7Udtl1sS4cjtANJ+SRzZgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385641; c=relaxed/simple;
	bh=3kiQYSc7u4TFnHpLrP21wdBgbHRqURZ3/ARMS50S7Tk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b3Hq7xa7qs2mryUsmfqPN8R2Iwp6+jkT9C7YUCmrCQV9ERQw5MXuDf6a2eVG3H9QLK09VP8STbwSfVKITQtqXC5KW0mqpN1dSQIe1vhdowtJoWNmWVwmi4Bi0kd2BUanaiJDHFGk4hpb7eECuJ2XlOAyhz4oa9hYiCC8dYv8IxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZa83+ZE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439a2780b44so24480045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385638; x=1740990438; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPwKUCyf/7V0N3UkAoc4pb6yY6k4PgkGzITT0Z2EzJY=;
        b=hZa83+ZENfTSbyadmOb1t3kW0sWXSbC3UITSO7bXqv1zWFi4lMkgozqEbRndhQGGr4
         0jkv2NUsj0WokY6tQrweu3XUnqhrsEXc6cOKWybo5gFwgFWSX5JXWX6+CTAISuty2Juv
         WPfBqzlONFBFZq2y5BhsXIntkHkQkZhRFPBJnPWGqN7e+gRuO869hiXitTqUuu87VUMD
         vwueHzCnTFcPR+MIIZ/zeObcR+VoueCWXJmBakvdm89ZI7KGgJejc8JUjzwE77utEVYR
         wZvp5JW3a8f4e3EoArzygPgBDQc3XiT/7VjC+/5TlMyl/BFAI+JHBC3BSwvAxr7Jc16V
         G8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385638; x=1740990438;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPwKUCyf/7V0N3UkAoc4pb6yY6k4PgkGzITT0Z2EzJY=;
        b=nYGOg5VZb+BXoE920CbRuvZq276AjmRWOCykA6lkfeMo1ksxjT6tbR+qgOo+msA/6m
         hF8T5vS1Lqi02IDBmyC4Qe8bqgxtnw4CYsH2L1UwjwiNNaVbuRL7JsVcgB4xBlV8ujZF
         /h6Bc5Y4KuSuoriWh3r8L5osBedx+D8RlW3z4A+nWzU685DGaEq3hiKPpey9p1YT0P5f
         x0JenY+scUIQhPowPvfFIkMMg/umokVWVPKXqH+IWw0Po6WeL+/O/I4Yfda2pFuuhHEe
         dYuCn2UveHO0mDaGf0+mZqw0nXVVqX9vSEcvsUKjxhjNb0YitEU2KPlidMxAv+tML0zu
         9gxQ==
X-Gm-Message-State: AOJu0YykK/U5QnGqsTxk/W+fCcW5hkT+tEBiOOTcUUZQ+kJFAZKPxe5z
	3fqPxqBOqJjNBsFXE38pdguMMo6fYek19tvxmEosjN0vH9OOKnhGeTEGU63dJUY=
X-Gm-Gg: ASbGncvHGrGGmax6275uFFWoqqU0lbiK/hIvnFtBYDXqNJNxKjPJyoKB009XuePRNri
	MjNH05m3WUWBdQf0Vu51LUXPNTIOiJsw4PsFY7mJ0Ezqx653uk4sF2sQ49de/0ZFI9ucpF09doe
	0UXMPiCEJ6ndNiedrb87vTKju6NmUZcaONIMz6HpBRrxmrNlWJFVPDpYyoGlMR9hmTYXkmyR0ah
	SJOtWs7fNbbmTMUBtOOnxGbQfzMdhmm4zkVSWpPBsGV8o42+MSAQ5bXnRnbMTJirCHJvp8zXc4+
	63dnI+SoXJY8QfQecBM5ZjhVeIzxak0Ub+nqyt5p/OueFKglUaV+NLxeD6ehmUkUkjD6htGg508
	4sgSTng==
X-Google-Smtp-Source: AGHT+IFZpmeWZMLiJizbruosBVOrMARqcw+hUfdlCLl5oaK6tTZV9pLO/+UO4vO2YEN7Fky7yQqKfw==
X-Received: by 2002:a05:600c:3b1e:b0:439:9698:d703 with SMTP id 5b1f17b1804b1-439ae212960mr96823195e9.23.1740385637905;
        Mon, 24 Feb 2025 00:27:17 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:16 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/6] mailbox: core cleanup patches
Date: Mon, 24 Feb 2025 08:27:12 +0000
Message-Id: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAtvGcC/03MQQ6CMBCF4auQWTumUwXFlfcwLGqZwiRCTYsEQ
 3p3CyuX/0vet0LkIBzhVqwQeJYofsyhDwXY3owdo7S5QSt9Jq0Jh6dfcPhMvKDl9nSxVLlS1ZA
 P78BOlh17NLl7iZMP392eaVs3plSkr//MTKiQnKKqtqZ0Fd1fMprgjz500KSUfq04EdqlAAAA
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=1109;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=3kiQYSc7u4TFnHpLrP21wdBgbHRqURZ3/ARMS50S7Tk=;
 b=G7QSQrAVQ/J5Ayhsb1UhcxMoffjZ7DYEKJuLaPGycACf5zzBxj067AnNV1Gvbja/zOGaOvLTZ
 sE0sjzHmsuRB7RJspPKVNnJP0Gm10CtsAghPuJi5EWdNfvosCKX1rN4
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Here are few small cleanup patches that I made when working on the
exynos mailbox controller driver. It touches error codes, what the mutex
in the core protects and what header files are included.

Cheers,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (6):
      mailbox: use error ret code of of_parse_phandle_with_args()
      mailbox: don't protect of_parse_phandle_with_args with con_mutex
      mailbox: sort headers alphabetically
      mailbox: explicitly include <linux/bits.h>
      mailbox: remove unused header files
      MAINTAINERS: add mailbox API's tree type and location

 MAINTAINERS                        |  1 +
 drivers/mailbox/mailbox.c          | 23 ++++++++++-------------
 drivers/mailbox/mailbox.h          |  2 ++
 include/linux/mailbox_client.h     |  2 +-
 include/linux/mailbox_controller.h |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)
---
base-commit: 4783ce32b0806911287f35cc65b799876d6f9547
change-id: 20241221-mbox-mutex-ced37c16f509

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


