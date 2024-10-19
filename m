Return-Path: <linux-kernel+bounces-372921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C229A4F45
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D55E1F21661
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F8187849;
	Sat, 19 Oct 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPg/0Mfr"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE213C8E2;
	Sat, 19 Oct 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352450; cv=none; b=cvz7VJewf04uagE2Xre0911fguyH4mp2Kz5HwNvBimDE3FWAH09LLTw9Jo/ZZWH5jk8Xlrcu4bqHoxiTSc/mingSc5DG8CIMMiYriUrld/ONYbkEWPDHgjnV1BIlDCzqeinEpOhnkyvPg7DCHDam1R+TITGwAqkphxVUFJ2Ofzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352450; c=relaxed/simple;
	bh=EQTF4yPETJ4ZfWpwkClS9KnPHJFZCEQHNFzT0ldZ/y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RrAinIXm9XDdqPNiRysQv/YAaxTJke3viNFTxOf9n6CotACyxo4uVywbUPlJ1zRzLgrpkj1rguJFYhNgGllYW4xoLfXHU1lLFUQYc+Mi2w0WR53YES9ap7cgfL04BUlfMhqIvDhq/YAgMHDPKlFmW2O/J5cQbyT4p5wawEcUVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPg/0Mfr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so2398048a91.0;
        Sat, 19 Oct 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729352448; x=1729957248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4Uv5hiIJcl+gNtdMTw9XcqP383LUWg/Fi53HakEUK8=;
        b=aPg/0MfrooCqICJ33GvEN4WZ9QOK471Dt7MH5rSvO6y5uNASLKv1R0xbkB1fQLYUOm
         XoBBk3dUPC7Sura4a+QcbwvrIszo7DNw/SNt/p6PXxez51DexBoDhiVyhVVN5Dmm8HIE
         P6XBRjhJn9RgiDYIyWtMY4Fc4jnr9ONxcADt2uh4UBNzAjcBD14BNH8vBuszjUTdXZwJ
         c4CO6xoVRoArUkqLjtNl6Fo0zX4ZONIgVm7raj4YXJyVKo9zO+lAsYClbM5YWlNk3ajG
         Qbof50vq+p76FUFpiMjwQS45YATxmHMzuJm4Faa6kZx2V5LjalqMG1axVUZJDaFzkf5g
         GRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352448; x=1729957248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4Uv5hiIJcl+gNtdMTw9XcqP383LUWg/Fi53HakEUK8=;
        b=GYj30FNyrdw0Z7HOP9xCFd1Tbz1edqMGr6oHZFwJm19UHxKIFLt7CLx8f218hWyaTP
         RD3ZnyAPPp15DXec0KwUmY5dmMWJZbNQZ8LRKjeNGKr/0EOfXdRLgI2iuUE5X4fWDUYy
         U90HTB31CwNpROLUcZPnnX3hDSB+BUi/a1dP4cSyBR5adX086KqoxS2lot0ehZbVyFB0
         H/9qvO0ytc5jJh9AqHArygaZgneAkeakBH30MEhQ7qqGd/VvofHOOuUC5sxTaFWBScn3
         ZsAcD8M0mEBa9I8/d545Jl+YkHa8enxUig4WQDGY+CVCoZlD8mtjyTxLS3f9T6a2sXiZ
         DHaA==
X-Forwarded-Encrypted: i=1; AJvYcCVNN0/o3L/xhmagM/ACtg7hJCeW8G1Q0wMXtZbWaKuty29oL5TxCzEM4RR5hGB/EUtYiDzxR7NiXd7E@vger.kernel.org, AJvYcCVhJ3cTqfcNicI6QMJAJfQ0ys9VbmKUQMKnwmozBhl/SP3XFIZ6iH44z/4MBE4i+uQJzSKyDCzti1+8CuYD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZqtnhrZEkVsFguQJ4fnAUa6M14mJp9/x9g0KGhdYB3Ah+qAY
	I9sFjHwrrQZNwtY8jyhbOPXlgssLFjmA7LG9dSA1tkyvBmE1dj18
X-Google-Smtp-Source: AGHT+IGhk0FG86WurYfMXZNeljpSB0B3Oz4w5ASHYB7zv2mdsaskKxbpVa2mFWbnRTW+0JWqsFE7lA==
X-Received: by 2002:a17:90b:180a:b0:2e1:d5c9:1bc4 with SMTP id 98e67ed59e1d1-2e5616db895mr7136223a91.7.1729352447712;
        Sat, 19 Oct 2024 08:40:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7ade96sm2781319a91.1.2024.10.19.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:40:47 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ipmi: ssif_bmc: Add GPIO-based alert mechanism
Date: Sat, 19 Oct 2024 23:38:03 +0800
Message-Id: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvSE2cC/x3MSwqAMAwA0atI1gYaESFeRVz4STUgrTQiQvHuF
 pdvMZPBJKkY9FWGJLeaxlBAdQXLPoVNUNdiaFzTkiNGM/U4HZIu3E6NhjQzd84z00xQsjOJ1+d
 fDuP7fhcLy6piAAAA
To: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729352444; l=777;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EQTF4yPETJ4ZfWpwkClS9KnPHJFZCEQHNFzT0ldZ/y8=;
 b=5Ky9PMTmDt6rvmU+APztMZkBKIMX3ijrMEiHKEjnlPWr8qdbsVHesGVYPdUAP/STOfiaELYmf
 me9rIymaM0sBohuMdekmL+b3m9a7JM2gEVBeHcPhHFD/vYvx8witA7w
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series introduces a GPIO-based alert mechanism in the SSIF
BMC driver. It allows the BMC to notify the host when a response is
ready, improving communication efficiency between the BMC and host.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Cosmo Chou (1):
      ipmi: ssif_bmc: add GPIO-based alert mechanism

Potin Lai (1):
      bindings: ipmi: Add alert GPIO enhancement for SSIF BMC driver

 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml |  7 +++++++
 drivers/char/ipmi/ssif_bmc.c                         | 15 +++++++++++++++
 2 files changed, 22 insertions(+)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-ssif-alert-gpios-1b9960f991b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


