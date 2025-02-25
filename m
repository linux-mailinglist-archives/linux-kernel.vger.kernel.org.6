Return-Path: <linux-kernel+bounces-532542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B18A44F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F927A6FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8920F070;
	Tue, 25 Feb 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbTKdhgB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D19CD0B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519661; cv=none; b=ZokMPQ8njiuzd0/fodHNn7U4+HwBT53x3/Om9uNxh9ggylN24OfzyqyfwZgbSfu1Oqa6oj8zAwRCFYjFL8wL+cL3CuHx07+6W5YnvwHeGrjJqkpgakAcvF9ycPB8tiyzAke5I0XdWIgjn21pIiEImtjscEL6EaE95ftJCkXYDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519661; c=relaxed/simple;
	bh=TTFhILZuU7YMXmq/GC/pL5WE91vTaK1wCbPcGuVH+Nw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V6YzCZoHQBXB7vx/tVwWgSwyEQ1+ew4j6+BiQ48RAnjaexMiKZFwWfzUvynlu+4XfuyiudPgubBfSEi7EhXrxYITn5OKlhjAUWoKl/Nf5zQuTvl3VL7sWWQ+6v7lde+c5eolCexqWgrgg5TO5w5MdtRLRu3rja6kxv3jqMBEo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbTKdhgB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so447216a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740519658; x=1741124458; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HbvDsd1KOYjbtMs1KVyUzdJhm6xtnacCrV2VmD17PM=;
        b=hbTKdhgB1JhwPa+rEvSaAztHUeNy2VA22OEFpxa4fu3sPcRcGmG6tgigeCE6ebm6c2
         RVRTCsX1HQ+Ov8PyU+hlV64oNYDmSla5SDaseBLR+NoPFf9LbpzLeWXfd94EvH46gLVv
         r/urRu/fyjopwHtke0zftJFL0Pqa80CBYdSjebT0JuI70ZcZweOVAnvR6ogkVGbzhaZr
         54Ru0dgKnRm/xqboRd0y2hhI86RIpXXCdk3msRIcz9D3FCiWbGJYXaSw+Xmf0NRNRr5u
         2V5tWYgJRBhfPbYAiBBO3+kfqxyog5KmW3GurVu58VIfllaq0eo4ohqhqd8as1aH09vS
         AR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519658; x=1741124458;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HbvDsd1KOYjbtMs1KVyUzdJhm6xtnacCrV2VmD17PM=;
        b=tbCA3ZrdrQ3X9K2yjLbFpAnxlYV+oTR3ausPRbVoVG1gZbunUEuPXCX4i6TIq9tgX0
         ZiRSDbdu0sIDf4br74S3604OAFOf2Du1iyDVhHtVSndPZAQrB8DKZciGUPrCDV2ngdkd
         x/sfEDofe367SlHC9fFBbErdZzajdVyGNDy1Mem2yVeMjcurbS+qA5nBxpXRYgmxOlUn
         bRY2GZUBrx/AXtXRt/Xaw+/td+0ygs7vIjVPHgkiMKFGbkKvYN+fQEBfR5RaqxFjbWBi
         DugVdWV8bcicaJWOhPoOgPAVKXGQxjrHXY27dcQEfgR5WOxZMNZseujikO2QvlrTsRoi
         +o6g==
X-Gm-Message-State: AOJu0YzuOEOHRhMcjdVHd3n16U9lwT54G1fYEuimm6W07Ev0bjN4MbRc
	QfpjUvh4RV70hP2DUcNlFcLBMawrmG2BwmZtrhHe/9eii3mBWmvvWK4CHyBEtlodLEpjnp3ZKly
	C2jtPh2LIKHmKwRb0JPi6lGY8EqwvQ0l5n/Mmxw==
X-Gm-Gg: ASbGnctCPKtDaVO+w6blim3M9xYxJ04NqPnDtzw7YQdMfMiI6ZwQ8k0CeypSDIaGFfK
	f9awnp+NWqWMeztazb0diVQFgf0WfGzSd34SIw30z1MOIp+3o4uRjA4O3TMgQwA+KiR7olXLYC/
	4tqNU8u2oo
X-Google-Smtp-Source: AGHT+IEVXnp8P5pf27arL4DfDdGGopw35k5GaVo5tLDgCqsq0fXIaoW6FgKlwFBO5XjIeNUMP2Pex+SrisfWVzEnv98=
X-Received: by 2002:a05:6402:1d4f:b0:5de:d932:a54c with SMTP id
 4fb4d7f45d1cf-5e0a1200077mr26084778a12.2.1740519657554; Tue, 25 Feb 2025
 13:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: C Larbi <pkl2000us@gmail.com>
Date: Tue, 25 Feb 2025 21:40:46 +0000
X-Gm-Features: AWEUYZkMltlHomdoIcxYY_U591edWTmnJ3tQtswQH_3dgbfTjHnKHNJtP4VTZ30
Message-ID: <CANVomh-u7pvk69FTfSbYGSoq5ZVnVMeDW3wQBYWUx4XPq64mmA@mail.gmail.com>
Subject: [PATCH] pinctrl / gpio bcm2835
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A patch to remove redundant call to gpiochip_remove().
I am a beginner, and this line of code really confused me as i was
expecting an initial call to gpiochip_add_data()

From 675aac08dbd0c20c43ab8def39141c33b06cd7ba Mon Sep 17 00:00:00 2001
From: cerezo <cerezo.larbi@outlook.com>
Date: Tue, 25 Feb 2025 20:30:13 +0000
Subject: [PATCH] Remove unneccesary call to gpiochip_remove

---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index cc1fe0555e19..5e31a5704fcc 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1348,7 +1348,6 @@ static int bcm2835_pinctrl_probe(struct
platform_device *pdev)
  pc->pctl_desc = *pdata->pctl_desc;
  pc->pctl_dev = devm_pinctrl_register(dev, &pc->pctl_desc, pc);
  if (IS_ERR(pc->pctl_dev)) {
- gpiochip_remove(&pc->gpio_chip);
  return PTR_ERR(pc->pctl_dev);
  }

