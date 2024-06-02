Return-Path: <linux-kernel+bounces-198474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702138D790E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600021C20AD7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02DC7E59A;
	Sun,  2 Jun 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivb2tEn/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338787604F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370701; cv=none; b=H6AT7MSm/7ktl6X/MwIFQ1IevnaVWUoQsD37dk5v+i3TkET+IfZiDh5CksxbgfSr7RXSzel9coyXapQV1XPFVlRAE0Lx11grXJQsLdDICeD0whgZsr1sxmLRQJesvQZu/zn4EgisBhsp8wFHUiOzI93rMib3Q69QUYtIxYyTVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370701; c=relaxed/simple;
	bh=gBMQdnHYBqt0Cz6vbwrln0vxA5FTa/0tj8FaEe/b0zs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XfoFtK4RuQAM2csiFYcd9/yQBh1I1ekd7WdIc++B1j23vV3Hu9aHOFvewX1hhqFNjDuQaEaghxHe/d8QPaWQNbZ0jJaqtNOY1Saoy31nesL4KF/uW9A4mrAPXExXpCbVs8cB/Mw45o3zWQ44TcwF2EhdSr3y3dCfpDy+dJF+n7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivb2tEn/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b78ef397bso3654770e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717370697; x=1717975497; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9GW/P8HNtUj4gAsXICqtNm+UsqGq0aT7yVz6HhJrHSA=;
        b=ivb2tEn/f0eXQd4WM9F2WmETh5+xEYQUj4Dqacb9CKGak5IaTROJB8kUWCgpv9v1gI
         3DjAZoK/qdwYAW0KFWwVixZE9xEYoQYKHrHW2FoFBJOjH2HagT2RYdofjWSodgOH98eE
         ugy53o9QTnM2sPOjmeviM/QB+7NVGefyBxq6Gpfn8ee2qDc1PbjDYhHO0YOoy9+cUy/k
         eaxVr0TubZnAlXciCpUlUPj5O8cTSwdVzfz7H1aUzmv/phKLqpcNCu3aevsrAM1fxTsd
         psBfP6IjU264ipomR7T5neiSLm3tkO6shc3LoTynIvqwv9ErsYPAsbJ/f1MKJPbkE+y8
         CQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370697; x=1717975497;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GW/P8HNtUj4gAsXICqtNm+UsqGq0aT7yVz6HhJrHSA=;
        b=jsI/8hT26p2imYo7/PH8tL4jXXOIr5EOU+bV4jPv9msQVWcuwBcSuX5gl/FzPObBtl
         FAnU+3Z0uBOMlsuOnAwWHuYYKmZzC9TBphdiSo7bkd/jehv1HlzJoFD4j455bTWMFhAU
         yeGxBU4Wk3a7Qqs+5JiDu4czQxnoFyczOMB8/gP+HU8s2zdI3dj9lFPz//3iqwCcUh/Y
         nX8OUebJqnB5PLNkAAuJObT0KHbyxY6B0UxXvDNw5jKkrei1lRKRp2O2b4v6Ym1FAsl+
         +NQ3b3FFrMCxHBkWM7DgDZovAT64MJLEdbQlc6vk/dXxGqD1ftH/n+HOvIjr1BYOlVtK
         lEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXXoEwZmL1Sn2Yu32Y7gx/u5cbhsEJBwiRuoqXNYoM0zHo57OU405gHF7B+ttLRKRBtSgQ+UR6+sHY07ZRBrFZXphMoSygcEOiHvrS9
X-Gm-Message-State: AOJu0Yxgc7umWYzMg2stU/ZAoDZ7mXA4xVVsUOAIqWfmc/3TElliDyoT
	aRk3100e6aUd3e94Mgobe4zrACCwRBxqvOyZGWQY3PZDZhE1YiqeCxuXTt6Er6JPPvHKuWDbYnW
	/
X-Google-Smtp-Source: AGHT+IFObhCSI9ATwzqYvUqFHXDu4y0kBGo1nJVdLLy4L1+PoQcx3K73d/nUhKyCvcqieX4Kw6RrLw==
X-Received: by 2002:ac2:4889:0:b0:51f:8df0:fbf1 with SMTP id 2adb3069b0e04-52b7e350b53mr2917997e87.30.1717370696998;
        Sun, 02 Jun 2024 16:24:56 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b959008aasm392369e87.269.2024.06.02.16.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:24:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH RFC 0/7] usb: typec: ucsi: rework glue driver interface
Date: Mon, 03 Jun 2024 02:24:53 +0300
Message-Id: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEX/XGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNT3dLk4kzdotTy/KJs3cy8ktSitMTkVF3TtDQjIzOTNLPE1GQloN6
 CotS0zAqwudFKQW7OSrG1tQAdoJOsbAAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gBMQdnHYBqt0Cz6vbwrln0vxA5FTa/0tj8FaEe/b0zs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXP9GP5gxL64nLA9ixHwOAFBfXBDUwb3IytFr9
 MzqXPncK2KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlz/RgAKCRCLPIo+Aiko
 1QMtB/9Ey2KOkOoXQtrK3z40/JUfDsmj8HhHIM+2tx5HLtM3vh51/enSM0NG8/7joFYK3odgHCr
 Qog87gI4VxOkkiZ2uolgr+BS+iYg9qCg9l5KwpUqE3pDu3mYNHlId+ZWojI23jfAAffFI0VHuRQ
 jbehKAnAkH+8sY9knuzynaOHFpu4qwJO5dHUcEIrfEUP/rSaiL4z/1jJopD3q1uajUH1SBAOwLG
 OXf4RS3IsMDMVGMa0s0X+u3vuhy2itfvTF5Njhb47z4yvz4IAe8xFlq7k9d5y/G85oy70S6Clwp
 ozyuGd4VH5nNmhlUka6xJw3tBeUIsue8TLMONydFvPfh1hL9
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

[1] https://lore.kernel.org/linux-usb/20240521151109.3078775-1-fabrice.gasnier@foss.st.com/

[2] https://lore.kernel.org/linux-usb/20240531104653.1303519-1-heikki.krogerus@linux.intel.com/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (7):
      usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
      usb: typec: ucsi: simplify command sending API
      usb: typec: ucsi: split read operation
      usb: typec: ucsi: rework command execution functions
      usb: typec: ucsi: inline ucsi_read_message_in
      usb: typec: ucsi: extract common code for command handling
      usb: typec: ucsi: reorder operations in ucsi_run_command()

 drivers/usb/typec/ucsi/ucsi.c         | 215 ++++++++++++++++++----------------
 drivers/usb/typec/ucsi/ucsi.h         |  26 ++--
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 100 ++++++++--------
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 103 +++++++---------
 drivers/usb/typec/ucsi/ucsi_glink.c   |  74 ++++--------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c |  79 +++++--------
 6 files changed, 277 insertions(+), 320 deletions(-)
---
base-commit: 975aa2136eebb8c7c716ac2d24d9bfdb002f87fd
change-id: 20240525-ucsi-rework-interface-5ff2264f6aec

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


