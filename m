Return-Path: <linux-kernel+bounces-352133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8215991AA2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB0DB21CED
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00015ECD5;
	Sat,  5 Oct 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2RUdT99"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E518E1F
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160490; cv=none; b=kuPckup+Sv6AGegZcP+9wqpF0tJpsgmXns+soQdXCxscSWj1M9mxYsGsiPedFln7wr2BD8YEBhb9/8nxWhbTSo51KlpVtl11kU061ro4NILp2y6ZVZz6dSmK79mrxEdThQeln8V5hztdoCF7zLFNYzHEK46EZI3oTzF53bVxjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160490; c=relaxed/simple;
	bh=WPSFRzpQmXyTM3z6ZSuzbrHr4kiT7ZJ23YAnn18iKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRW9oEo9kIYvW151jF5wDLooBvxBUCOJ532MdwDr8TuyrUV9g0ZigDpnVZ9NCvo/n+3POI6aYicEh59mhwOVV45WUxIVmGeQa+VBCYjob/U2EL7GtTND7R+zrJadgfzS2MfjtP52Ef3/w3237gQ5RdC1xJqSQ34iLabZ3nrBLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2RUdT99; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso41483425e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160487; x=1728765287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFt5tBfdZec46McMVPfu4D/j5Q/aM8HZT4ZihSPJdl4=;
        b=g2RUdT99EGryZvUW+Gekl6J1CDTddJNmoqVlKRwDsC5rTdcUw2Yw/U2VFJpSZwtLfd
         QB8YXFIiSSUS3HFasoVPAfWLm4fXrRIXmiJmWGQU8W1y0M27ZE3V3SIkoDWb3Vp8jXUd
         oUMxWmgMh1VQcPQAvrcb58oDjfCu1vmWE+1b9eeuYugDxP/CR22sDE84qfIbJ4wPbJA3
         nr6n0lgji3m8KBp5MF2PF1G4/hah18JGEjgn7iJLLYBlm410oNsZe7knlcahnAtIrZVm
         XFUx90TsO38AAYZIoROk3KBApjBZEJi2d8fjZOkMhfb2qdQRco1UK6qwJXAe2FbKsy9M
         lTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160487; x=1728765287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFt5tBfdZec46McMVPfu4D/j5Q/aM8HZT4ZihSPJdl4=;
        b=Wu5FZxflsSIKjOtBvsNFrXTgoWNxRLz9G+D4Q90t+1i6woCF2Zm9fJ8kCNsV2fAuY1
         hwCnxXBDm+wZTtrCEEo4z+gXH9RnZStf46GrIcoK3KxIK7Yk4GtBKx2GURkFE29w8GgG
         9oomr2uQJHMtYQFnyYh/zsWc5tsU13DDXRl2MPn9wf4/y/KFSYFdUdreKS7RpBZGHgDc
         L+wQiLnVVobaRbZb2beL1Ke/q5k1wr0AxnA8WLXe/+qP+OMgVrehoIM5svfR/ysxiPLN
         ilpfNqNjNIfsGhVKl7sW/iX4mgIhPAu82Lj1vyQnWJX94Okm6bWMSVdQ8OxvPl3PWmWP
         g51w==
X-Forwarded-Encrypted: i=1; AJvYcCVikvzRMNP6ngSyfSf+cWjHBSkE4FAZ0JIkA0Ju9lwVZR0Tfxu/3CTtRcTal/HTX19mtf4VC5GFxgx/6sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBQsG0sgQmKyOu/ymlGrZQZaYpkwVpzqStdkzIeIOjy9Lwd0F
	pmrYuycTa5l3RxU/FjbSVJcsAA1gfGbinUKvJj/nM81C0OQyEpP9
X-Google-Smtp-Source: AGHT+IHJocbNMS5V788ycKbIuwDiIww8RvJ5MqZhv9rYA70SB31uX71x8JPNo9xRwpDYAwArbr21Ug==
X-Received: by 2002:a05:600c:3c9c:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42f85aa98ddmr68081755e9.13.1728160487165;
        Sat, 05 Oct 2024 13:34:47 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:46 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 00/15] staging: rtl8723bs: Remove function pointers starting with hal_init
Date: Sat,  5 Oct 2024 22:33:43 +0200
Message-ID: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointers and replace them with function names to increase
readability.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (15):
  staging: rtl8723bs: Remove function pointer hal_init
  staging: rtl8723bs: Remove function pointer hal_deinit
  staging: rtl8723bs: Remove function pointer free_hal_data
  staging: rtl8723bs: Remove function pointer init_xmit_priv
  staging: rtl8723bs: Remove function pointer free_xmit_priv
  staging: rtl8723bs: Remove function pointer init_recv_priv
  staging: rtl8723bs: Remove function pointer free_recv_priv
  staging: rtl8723bs: Remove function pointer dm_init
  staging: rtl8723bs: Remove function pointer dm_deinit
  staging: rtl8723bs: Remove function pointer read_chip_version
  staging: rtl8723bs: Remove function pointer init_default_value
  staging: rtl8723bs: Remove function pointer intf_chip_configure
  staging: rtl8723bs: Remove function pointer read_adapter_info
  staging: rtl8723bs: Remove function pointer enable_interrupt
  staging: rtl8723bs: Remove function pointer disable_interrupt

 drivers/staging/rtl8723bs/hal/hal_intf.c      | 46 ++++++-------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 +----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 25 ++--------
 drivers/staging/rtl8723bs/include/hal_intf.h  | 23 ----------
 .../staging/rtl8723bs/include/rtl8723b_recv.h |  5 ++
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |  2 +
 6 files changed, 26 insertions(+), 87 deletions(-)

-- 
2.43.0


