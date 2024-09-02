Return-Path: <linux-kernel+bounces-311460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78937968986
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4661C22E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BF13C9C7;
	Mon,  2 Sep 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvERYK8F"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEF2101A2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286212; cv=none; b=TB9BAgCMA/N6gfygQrL/JLDxJ1yFCRdFQzdIInkAj9Q/f0ir7zTD7gJ2dhucog1y4O9jTNmLT9S4XkQf9pQegU/auVErKjaTvVO3hDAskTtNIDb0XfRggBktI3gInxVaiaoXvvISfbz3njczZL4cQdQtnO6O2QPjiwi+CifdeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286212; c=relaxed/simple;
	bh=DsOMs1ZrpJrMLYNW7N3Xcep2Eqxy5G2ZJZUdLEvlpLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MxgfqEsf0tDXNHsAQs3GJX0yBZrWQcM6yR1nLbo5299DFVgKwX9uYWo9Avt5ev7Z7+bU2HSprTc9a5iWSteePi993LycY/ooCzjiI1My+aiNkjeXIcqKoVNR+/mVUliTfvoViVOaoqvVcKfPaXu5vXyRiPttvI4VQmhNzy3Agl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mvERYK8F; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5353d0b7463so7202317e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286209; x=1725891009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3AmvLCT53A8wlNYowQc253KqOftoNfFrep2KZLTV9o=;
        b=mvERYK8FPw66K06udrfjXQMh66ytJ3/Edtsde4T/TOifkt/FoeXxd2+QnM0i9puhJ/
         wo9y/WSiP5FXhwTpYoSYoQo+9M4SGsxniLnNX4THQLsB1/9fCbmrvjRw6yuJkK2jy1YW
         7QhQT6RhUpB/Tq4OYEYr8LdwbsK9io22ZoCohkGA1sI6eFidixvjXTnQvz2q4eYqfSon
         j9f15rUkBObtX54QXp6v9FfvWWIPbI+xfd4G5FIraPYWfb7Qbhhih/YpYLWl5+5BIq2W
         a68gfo1KabUhbDJaiyaSX35AR4dsEc6eppyzwdMUIehXUU5vDKHv9wlYvWfYs9JeJIbP
         N31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286209; x=1725891009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3AmvLCT53A8wlNYowQc253KqOftoNfFrep2KZLTV9o=;
        b=diTq6rsfXuC4ZQ9lGkuPLJAAyGbD3w7ugWN4a3IBfxNnuJ8ozKVT+YlUppSTRdNuS9
         iXZACcThv5fXg13/qzIjV6cVKf3I4dfB6oNqsmVSVMQN0W0r26lZhQXl9GSwL5nXCWdc
         GH1gEkoDlpCSK404UE5Gy4+OS+978tX4S9geRdnGXN/84hGT0cBgBpsAfHEA0RyNfJ/h
         GyYp5/e1KLSREaOuEnbE3hoa2bnm23a2TlwSOfCgmSO3rAkksbrF7rQHBKxVA1O4OzwY
         9ucPDui/XJKnfK891baIGgaenIdEVFnGEo5mAkUV7gERi2zz/XPQrgo7DdYlVsHGA1iR
         e4EA==
X-Gm-Message-State: AOJu0Yy/1y5OhVCJgSmb1ztePDvOhwgYc5SZfQHA2jJzmg9AJ5WtRj98
	iVZG/e3V+8IN+JTPkTrr6Jga3jLVF0h3HMJuB7nOrVl+EqV+0sUEl+1XjMWpMRk=
X-Google-Smtp-Source: AGHT+IFrWjzaGdWFN1sg3i+CvfgQnGm8jGthZIPH9DwvS0WCQtGJCWycQXSWQ/3bLdjEn0DT422LuQ==
X-Received: by 2002:a05:6512:1191:b0:532:ec7d:9c67 with SMTP id 2adb3069b0e04-53546bde0cemr9107086e87.47.1725286208565;
        Mon, 02 Sep 2024 07:10:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm561716066b.150.2024.09.02.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:10:07 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: patches for 6.12
Date: Mon,  2 Sep 2024 15:10:00 +0100
Message-Id: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in slimbus for 6.12 that includes
- cleanups in variable names
- generate the proper MODULE_ALIAS() from MODULE_DEVICE_TABLE(slim, )

Can you please queue them up for 6.12.

Thanks,
Srini

Masahiro Yamada (1):
  slimbus: generate MODULE_ALIAS() from MODULE_DEVICE_TABLE()

Wolfram Sang (3):
  slimbus: messaging: use 'time_left' variable with
    wait_for_completion_timeout()
  slimbus: qcom-ctrl: use 'time_left' variable with
    wait_for_completion_timeout()
  slimbus: qcom-ngd-ctrl: use 'time_left' variable with
    wait_for_completion_timeout()

 drivers/slimbus/messaging.c       |  9 +++++----
 drivers/slimbus/qcom-ctrl.c       |  7 ++++---
 drivers/slimbus/qcom-ngd-ctrl.c   | 29 ++++++++++++++++-------------
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 11 +++++++++++
 5 files changed, 40 insertions(+), 20 deletions(-)

-- 
2.25.1


