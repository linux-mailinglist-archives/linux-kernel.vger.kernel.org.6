Return-Path: <linux-kernel+bounces-536030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B7A47AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BACC188FB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3822A4D8;
	Thu, 27 Feb 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+ECPPpM"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E3229B28
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653201; cv=none; b=LviSWLVLMtFS1KQdvOo9pm+fHp0Q706hDjOBxLPXTI3E5Zsu3hnUPql53JK1DtxRpL1ozqBiLko/Mu4gqVuK9P0kqsDkDubLMVLbk0FgCy3+PeCZKRcLRYahOykReT6KryujujZRfU/eYueofybuTxp3XbFBFlrfdo45xa4vn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653201; c=relaxed/simple;
	bh=GXcqDaM4iJxo1UFq2CVb2sA3L38nmHx73YWAlmx+a5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YygoULTJGpY31PTv63yNLCtbxEG/D5eqf1nAi1iDYIU3r9BFJr2v1G4bnTjrJbdnikzZxY5rgEmxpTiK45RdZ3iQReL2nfKgFOZUTdpe+OtFjBi4VjpDv/0HXKD41UrVeF6SjQZTBhK7dbNDiZ6VdJ86m2FRlZQ3FgNQAVE4SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+ECPPpM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so867044a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653197; x=1741257997; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPVgA06tyH3i4HM0WlziuIUTUmSh+HZPXchXbJCW9Ic=;
        b=A+ECPPpM8hZmiEDwIbyF6B1jM08fqsa/lwyaigz7uWhLLQAWoawEMMQXIEVY0PHwO6
         IrHEUtdWqwzC50+hrTKUQ2+ZLfV+pfq9YCo5hB1UvMII4VboDbd3ITw7gs4zC5JRa+gS
         OQzaRHLXoQ9tTWNLgP0EBaGjiBxnuenZUuXphdbkG39/zTSssXBy8d9qlz7R0sQwOkd6
         3nHIcPhjOqZPtApsoAe0AmeV7ql83BCk/XY1VEinJJrXwDkQy3Y5T/67tkINZAXlTMMw
         zIutG8o2ufYAuOGyYJpg9+P87zB52nUApHi07S9L3846J+0XmARTgnEeB9u+IPxOJ963
         SVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653197; x=1741257997;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPVgA06tyH3i4HM0WlziuIUTUmSh+HZPXchXbJCW9Ic=;
        b=c+NR6mJ+PKGobqGR1s92pegc40fIWR1xmHlzUjPzJqXAsT+RsEQ9b2n7FZVAl/5ff3
         SJERYwWGleT4PHkg/wyHtHK+GbidiMcr0z9Pz2dutrqEX5wP6QtAtxawtIURJjvlxTkU
         K7qNXZhTMN3jcmzaNoGagIreFqp6mh72cTkcJRBPIE303whgyEXcAGLFH738EPWfuaho
         lyY9N0B3z+7gQdflbjdQl2XT4Z3LGjTE2UocqwpX8Q99YoQsOTCLJAXTMosqhAM5gLTz
         Abcmav7BnPqb/e63Lf64jUHS6d4lDHXuKtrNps/XPQbKC5A7E3t3C7y+dGalh2bArGUL
         kiLg==
X-Forwarded-Encrypted: i=1; AJvYcCUcX5pKp42WQRG1QL5dfXiS8NWkZBhB90I+/+jCMndAhkQ9D/86NaqCNTu80LKPLvBlvRLAgFDg960AU3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLuPTAsSYKye5bJWi7Fys4fpfJ73qGJ0QWH4jF04LH2FZJ71t
	Ckqvw0LZJNpOVWbg+uwNi6YvQuCeXRShfWym8eSEgo8YjokhX+Azc82fHsM5MCYnxVop28LXVnu
	9kjg=
X-Gm-Gg: ASbGncsuyBJhG+pF32DgeknTeSGSBIy2iFAf/qDDsd0Y865/z1JvqppE3KaHeXxCqzK
	VF4ewCmDP180nyDAH8Gtakvkp471iGYRyKYCnNGKKu+3vI/j8It/oBTH48b2Va098BfuXV2fQdu
	m2nHvxlI6ZHaD57VrqcCDosCEGZkMPM6T0zJl8XhqkkdBbU4u2qIcl20Ic+QSuRasHZqi+QCV3C
	OoRNt7zGzz0hdnGsJYsVnqVUQPakZUVmm1EOvKrqD9+qIw/4pgr58zbu30632AnQrzesrnEhkRE
	CqouIqe7qr8g1f2SbGVs4lpNd9ImyEkAfNvsrfYbVS6WmhNm4bZ+iWvFKtRoVM3LNk6iIkS9qZC
	u5I78i+GHiA==
X-Google-Smtp-Source: AGHT+IGloWH6a/M1sg9S+wwEb1NJ4jTuvK9J/b5oBXRjCHdZJoqFRptrBcSe7FBusglyJvCFgwIZTw==
X-Received: by 2002:a05:6402:4604:b0:5e0:7cc4:ec57 with SMTP id 4fb4d7f45d1cf-5e44bb37281mr23479228a12.31.1740653197543;
        Thu, 27 Feb 2025 02:46:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5ad8sm901032a12.34.2025.02.27.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:46:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] support Linux reboot modes in syscon-reboot
Date: Thu, 27 Feb 2025 10:46:12 +0000
Message-Id: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHRCwGcC/43NwQ6CMAyA4VchPTuzFRnTk+9hPDAosERXs5FFQ
 nh3BzdvnJq/Sb8uECk4inArFgiUXHTsc5SnAtqx8QMJ1+UGlFhJRC3iHFv2IpBlnvKINIk3dyQ
 qrStjrLnUpCCffwL17rvTj2fu0cWJw7x/SmrbHkCTElJcVausRqV1Q/eX803gM4cBNjXhUQmz1
 BtpjC5raW39J63r+gOQeAXtCwEAAA==
X-Change-ID: 20250226-syscon-reboot-reset-mode-566588b847e1
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series teaches syscon-reboot some of Linux' different reboot
modes.

Linux supports a couple different reboot modes, but syscon-reboot
doesn't distinguish between them and issues the same syscon register
write irrespective of the reboot mode requested by the kernel.

This is a problem when platforms want to do a cold reboot most of the
time, which could e.g. wipe RAM etc, but also want to support rebooting
while keeping RAM contents in certain cases.

One example of such a platform is Google Pixel.

DTs can now specify the existing properties prefixed with one of the
Linux reboot modes. All the changes to support this are optional and
opt-in, platforms that don't, or don't specify a register/value/mask
pair for a specific mode will behave just as before.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- support <reset-mode>-reg in driver, not just in binding, doh...
- correctly parse <reset-mode>-offset
- add a comment for all the BUILD_BUG_ON() checks
- Link to v2: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org

Changes in v2:
- fix whitespace issues in binding
- Link to v1: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org

---
André Draszik (2):
      dt-bindings: reset: syscon-reboot: support reset modes
      power: reset: syscon-reboot: support different reset modes

 .../bindings/power/reset/syscon-reboot.yaml        | 74 +++++++++++++++++
 drivers/power/reset/syscon-reboot.c                | 96 +++++++++++++++++++---
 2 files changed, 159 insertions(+), 11 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250226-syscon-reboot-reset-mode-566588b847e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


