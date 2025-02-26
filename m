Return-Path: <linux-kernel+bounces-534442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99FDA466DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB58A3AC59F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A621D3E5;
	Wed, 26 Feb 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA33+QYv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57831221F17
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588281; cv=none; b=UNt8ewRK50k6ri/Au5T0rq6GGQKvCgmg0dM8uuzxfQfHzhT2gdiTO4Gi0XGGSeUCZF8m+YQnnzORAay8SggcSa2PspBm/dNMs1qEsiv6kyCpTyNUzhL6xCGIvQIp6HYhKLSIOSu0q14pio/f2N3eAmBkPBTNKQ18Q/tjMnuVkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588281; c=relaxed/simple;
	bh=EAZCxfsdAbOo+Fr4fqypNUN33rmB2Bh/8eVrz3m4U6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDjY07Gr+FVJ9Y1TOZQLiZp3HxaxUPA507x40fm2YxcWAGPUbXNZ5O9593oy+ahUzqp+N37tm6STuhQRkJjiEoOPZKAMOiMk+yx38Kb+wAWr6CNUwRSxLNvqWu5FVb5gCaHCXD93r848Koh37wuF19FkoOCfYvakSBPIiDU9fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA33+QYv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso1396924866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740588277; x=1741193077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKCRcTLMZnIrHbEKuD43z5qHVVfLC3XXEk/6jO6k5Hw=;
        b=rA33+QYvoAoUG5FyuBT+AyU3gCaSEIrIQ8s56jqZnyp8OZbqm2xaIovbvJp60B1fgW
         tXfpnKgMDis7d8Jo3gxiUqtKQRsEVL5+zCyz4su3F+8WjSFnxhjEiupk2toADwt4IaF/
         rh1T78RP3RWNQUlP5UPVXiFPFqHvZ1BgEfx9K4/7rCqJugl9mzXKJRzAK54GUQZiVR6m
         Fnzf1Z1WpTJfwi1gad7gEIkpYMQ9rfiL3u5K3E989XlaTfqZEcZq6sTvLqzjeYpgrmRa
         Rskz7jkp14MDujwuVYO5HgFcYyTrzFSqPHyxl3PYqoV6H8EWnFXfTlBm3KtucV4Gnmy2
         LdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588277; x=1741193077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKCRcTLMZnIrHbEKuD43z5qHVVfLC3XXEk/6jO6k5Hw=;
        b=S2ZclgMr3IS1GmBFjtWh6TMltyeRWbW3q1aDNX/XMbsi37eGfwPXR7UEkkeZfwYJfW
         QwB1YdMgBxdnJXQxOV3Rl5fWtQDDMowFYtIrISFjp5spI/fzJH3jO4Mus2grAFVqXHq5
         4S0ds3cK+FQOwrstyP8/DMShevTTx4cG3JNgTH5RkNk5oZJ7wUEBjo2kz6EtGdaDVKMk
         gJZ3lwAfkQ5AA+t0bMBUlQ+rdYNFl+YVmHO/M11AFMUZ2FehJj8+uHulkM7fbu8DrMQB
         zpfer54T0zt76EgEDGKtVzhw/UR+oisyJEeBA0mmNvTAtSrrA3yWokczbVv1xpdVgmpG
         bzRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4dOzX2D1uKEcgCYafEP7ndpytzyk6eThf1A5TLUKNec010egkuRPX81TOJ9Ty/NP5oqzxwTqkF++NUho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvjsLTQnjp3G90aaZFZTvxaHfT0YhxsOOm7ZvXTcW8iOmatyp
	tAreQZurw9HzF6R3YdlhuDeoO2zfb/IN+yaPNKlZRf4QUuna7Mzdw8kS3n8DQeA=
X-Gm-Gg: ASbGncsNgFIAH2zY4tA8zE/vQLMBDNY6KkLg5BQtM3ddu3vtYFOuDP5sbCt14OHS46B
	8Q5+bCsCTF05qOsKL6mSb3hsU6Kzep27IsTuJfNXeeMzhE021jAVR+eMrsgvto3M1wOfW6/2Zrq
	jJQ4JMIYr7fz6zGMUF4v5P3zJJpM1ZMQ2ypNfb+Z6jppX0/zzWaIGAbYicHQFwZh/+m+ZNilmnW
	j28zLZDl0J/18b34ZJK5Kn951GTSD5WF+Ni7skvm30CJvrqDSbARUr8F3JZhDj00Ty3KljB7j9k
	srbOaN+UE738MAATEBTBoPRDzcjxpkMvtiHW1DqtSiU1aJxUr8B+F8ECCh565AfDuOSfHrw3YbN
	WEncqCboLvQ==
X-Google-Smtp-Source: AGHT+IFNAtJHyDKSHEKDSUw9B2zaIiFn3sdbmyXKXU0qKvllh5gJYoJgG6lFeV+RuUdWCGeQdROOSQ==
X-Received: by 2002:a17:906:32cb:b0:abf:2bb:13e5 with SMTP id a640c23a62f3a-abf02bb14cdmr109491666b.50.1740588277524;
        Wed, 26 Feb 2025 08:44:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm3058459a12.68.2025.02.26.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:44:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] support Linux reboot modes in syscon-reboot
Date: Wed, 26 Feb 2025 16:44:25 +0000
Message-Id: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOlEv2cC/42NQQ6CQAxFr0K6toaZyIiuvIdhMUCFJjo1LSESw
 t0dOYGrn/eT//4KRspkcC1WUJrZWFIGfyigG2MaCLnPDL70Vel9QFusk4RKrciUw2jCl/SEVQh
 VXbf16UwO8vyt9ODPrr43mUe2SXTZn2b3a/+Qzg5LvLjOtcG7ECLdnpyiylF0gGbbti+/QFR2w
 QAAAA==
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
Changes in v2:
- fix whitespace issues in binding
- Link to v1: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org

---
André Draszik (2):
      dt-bindings: reset: syscon-reboot: support reset modes
      power: reset: syscon-reboot: support different reset modes

 .../bindings/power/reset/syscon-reboot.yaml        | 74 ++++++++++++++++++
 drivers/power/reset/syscon-reboot.c                | 88 +++++++++++++++++++---
 2 files changed, 151 insertions(+), 11 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250226-syscon-reboot-reset-mode-566588b847e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


