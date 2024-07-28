Return-Path: <linux-kernel+bounces-264565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30693E525
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C57B217A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEFA3D0C5;
	Sun, 28 Jul 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B005eqKS"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C154AEE6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170869; cv=none; b=VI0BaH39OVXNgUL3RonYa3Ctv7wdjtjNWWu9WrulZKK9jG4sPg8xMK4nFF7MiNsfxWN3rKB6XppGoFGhOX/J7ZmA8X/Zpu5InW7cWDUBWX5yXAYD6e/8JXov8CC/xeEnWJehNLmD7FWpoXXIgxPFjkymTpHD/Fzkh24NivtuErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170869; c=relaxed/simple;
	bh=jQsVlvUMaaYWMGPZI1Gdttyg2TqvYy5qPOD9yDMknEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klruTQZKUw4IUQS+Iwvg+uymanTYDGkb6qqPBacPk8GaMfWCCZTo25KuQ2Uix/1/JfMDfpo1O7MV8qxIDagmSrZP8MG35WD+DkiY/cwZQ+tQJ0apQhqpXwOSyKcFeiAVhiWKFdHHHcQcdsuoJef0Rs/ecLHuVEIM9hOnZW8Ptes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B005eqKS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so4106361a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722170866; x=1722775666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rTe6IbeoM1Sj9LYDiw9wEqY7/bJWvFvBhTNPVxZYKw=;
        b=B005eqKSUc2tneLk430B8CRNrPRvvA86H3XZuuUaVEz6TKvkX4goKWfYHz//Qc4T4Y
         /+i+Cqc9hjDOuOz8IBfpygGkJpCVdPhuf18x0BvWvTmaQZ055E9W396Vx1SXSbI2vjtA
         Ie2qrfq+9IqGlZxTjXwwVxpITSt1mnvwXy0z0TvS7cKUzKos1grMFvDPCVv4rN5uSC3m
         Pz1OFS6Rc/xDYqhIF++2/ysQTukpKWMGBYF+hWg2PLmo3XkqsKUZPgZYblcuaiOECk7w
         c8+cwxq5jIXGUqa6HTDp7Zs0a1+2ap6kFXpdjLAsMsdyAeQ6nGaIvSNjVavueBafSC3+
         Utgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722170866; x=1722775666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rTe6IbeoM1Sj9LYDiw9wEqY7/bJWvFvBhTNPVxZYKw=;
        b=AwGg6X67/T8j5Enjbzajh9aFQgsXLvOl4fj4mCWdeucV628fVC9yXC0ZrHO6UiDDva
         dHPVMJGBWKALbwDqigBhFhwcoSTjOpyfcQKazKjp2izPUAKJSwYiHBjRtocHEy2LSzw4
         w/dnV+r1aCYoQ2sBb48viBetvHkPxmfvcMYjSE76OJZXFBkLHTeXgrwQoESBK3OaeaCF
         idZkSPaI3csW1nhDiYNmX4mxsH71KcIpaFsw135m0XEnWCt57zyjfTnHV++pEpXdVMXi
         Cep9SwIZmFMDKLm3l/+KV0Sd+zu2x2oZG+PAoVsOUcV9yawpVO871vpvKTZFlzuOHknC
         Kfow==
X-Forwarded-Encrypted: i=1; AJvYcCUMFHl5uYuYMt5AVR3lxHl7wXweXlNI74Lqif1HcX5XZVcvMbTFS0r/DJ4zaO8Sx+APTRaHOAFMysd7bQYjgivXfQoknVYm5WBUZvCG
X-Gm-Message-State: AOJu0YybxkaYrjNJa2/We2/O33iAzgRl4i+2fmU0MouhPCoTJUqCbDaz
	hf5Cz+7LTOobBeBq3Hy1fAIUsquwYkXzBVC7vckZz7eN7N6Sr/Jm
X-Google-Smtp-Source: AGHT+IFUjiSzp8/lFhIVP7/rcKcmnBPnJsRtdp8cT700sScn7ZMzY8JZZVX4IE2+b4NoGEpyaWtKeA==
X-Received: by 2002:a17:907:7244:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7d4013de15mr362438666b.66.1722170866492;
        Sun, 28 Jul 2024 05:47:46 -0700 (PDT)
Received: from Slimbook.lan (134-248-201-31.ftth.glasoperator.nl. [31.201.248.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d3cbsm381125166b.182.2024.07.28.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 05:47:46 -0700 (PDT)
From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	hdegoede@redhat.com
Cc: mripard@kernel.org,
	luke@ljones.dev,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Subject: [PATCH RESEND 0/2] drm: panel-orientation-quirks: Add quirks for AYN loki zero/max
Date: Sun, 28 Jul 2024 14:47:29 +0200
Message-ID: <20240728124731.168452-1-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add orientation quirks for AYN loki devices:
- Ayn Loki Zero
- Ayn Loki Max

The quirks have been tested by the JELOS team and ChimeraOS
who have been patching their own kernel. This has been
confirmed working by users in the ChimeraOS discord
servers.

Since there are additional Ayn Loki devices I have
made separate matches for the devices.

Bouke Sybren Haarsma (2):
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Max

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
-- 
2.45.2


