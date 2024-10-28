Return-Path: <linux-kernel+bounces-384017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869CB9B2345
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D331B21AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9118734F;
	Mon, 28 Oct 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkJUmXlv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B09170A0C;
	Mon, 28 Oct 2024 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084049; cv=none; b=sFxR/jaMc31TyTOIgggM/faVLTQGlhrsxexnn6lLL6QbaR+Kjtnmnxady5InoAUbZHmI4iI0t+s9KaPtxZC64PpDUSN3yNbDz25X4F19y6ZjeGqlyIrwjMilFk6a7104ZsYF6JGxPcTeCdfFLPunGi0dLd2QEl90yAbxvnou7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084049; c=relaxed/simple;
	bh=ZJMKmgq6L7ZP0J12jS74Bb4cUt7oYIhZjiw67GhhulQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+6Eg+xhnlUtRR1kP8tNQc1dGvNMt8gtAovZGVwVB00XuRcZGi3UFVe0lN0CqkH1mni8FKEbQGx9shAoHMj/wlaafk90Cz/1nZKZTstzDb4oFd0VvBFWfmrlPo05pnEIfKnTHG2vvwVwe19tcRNAyHxzz+xzWjWl8NPBgL/joeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkJUmXlv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e74900866so2823562b3a.1;
        Sun, 27 Oct 2024 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084046; x=1730688846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9alU2Pa3x7JzdKopofVpdYd8dJ3oROCcLusOTYEezk=;
        b=gkJUmXlvDwoQpcaR+nmmMwD+9cmBpuEo8zwhJz4HjJJQdqgkLEYxsjMZrc/c7qI/Aj
         qtho2+vD8KcSxc1wCJpC1dhGPWb/JdDpE99W2TC/12pqVrvmHCJgqpnA5pmsiobM4zJm
         3dyUKKZUH/ueqMV5vWuCypaOOF1pcEXlLKk31CZJ8WM1Ivfi/WL41saAn6BqorTPOPSu
         Vpsf9jMse51fwvjG5bk09D3FytJps+rQWR9Bp+vKtQJ8Cr0HCJJaxWRulvn1ZtF3SDDj
         j4ck3WAOX5dxr2q8icoKfK9A90qNqcRAcIku2DFk/C//W/eJxQh104HrJ+6oiP3/DGtp
         O+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084046; x=1730688846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9alU2Pa3x7JzdKopofVpdYd8dJ3oROCcLusOTYEezk=;
        b=AwS0LApoui+eTPXuASHz9h23GQR2CEGIjFqrdLGWZx/+xsFDxwXEx3yj16D3QdQkFE
         9hNBFDZobafgK3qfIm6pXFuQW+uJ0Z6zqQwHSt5jtdALVCGvQuPsu85h8HJFZD+KAWin
         sje5PAKjIAe1AgYjKT3vO9lYmG1o2qulBjJyMG4RXOw7bWof5Re6RbE2PQPUh0ZsATq4
         3md1aw7nreEa7eR8Zixt8b/DRnPOP32vdEcw89tffb3DdCi9syCNBYT84g2Zr8bi5BIw
         HOfF4ayp0U2xKMH364OQO9oAhIe01Y2bLnUpQBcpecIc7Gq/QmYGKY/2rpLpWJB1Z4K7
         00hg==
X-Forwarded-Encrypted: i=1; AJvYcCVvvylaABy5PsBDYIFHlJQqlV1pH83QEi5zjIrsniKVYF4m9Dr4x6jvXpg5pTusHW3Q7mVmxTiPUiVq/dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCGp2AT0fU08aujceP48ydHFwWqPxk0l2KpBEBcNKYDXShaL5
	CB8iYr+/1OXh50B6Mn6rzz4v/7S/j8SA9rz/m6BMxVSy5rB/tIiw
X-Google-Smtp-Source: AGHT+IEn/pq378394aX4DVPd8PbaT+OyHUPHWbnDgxkZmIHxWhM7MbX4JeUAeFqYX8gOOLsPE5Ae1w==
X-Received: by 2002:a05:6a20:c998:b0:1d5:1354:5256 with SMTP id adf61e73a8af0-1d9a84d9806mr9121413637.39.1730084046300;
        Sun, 27 Oct 2024 19:54:06 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:54:05 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH v2 0/5] xhci: Some improvement for Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:32 +0800
Message-Id: <20241028025337.6372-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add patch 1 to combine two if statements for Etron xHCI host in
xhci_pci_quirks():
  xhci: Combine two if statements for Etron xHCI host

Add patch 5 to prevent the xHCI driver from printing a "Transfer
event TRB DMA ptr not part of current TD" error message when an
error is detected while processing an one-TRB isoc TD:
  xhci: Correct handling of one-TRB isoc TD on Etron xHCI host

In fact, these problems are unlikely to occur on other host
controllers, so adding XHCI_ETRON_HOST quirk flag to invoke
these workarounds:
  xhci: Don't issue Reset Device command to Etron xHCI host
  xhci: Fix control transfer error on Etron xHCI host
  xhci: Correct handling of one-TRB isoc TD on Etron xHCI host

Apply XHCI_NO_SOFT_RETRY quirk flag to disable Soft Retry:
  xhci: Don't perform Soft Retry for Etron xHCI host

---
Changes in v2:
- Modify commit message
- Remove XHCI_NO_RESET_DEVICE/XHCI_NO_BREAK_CTRL_TD quirk flag
- Add XHCI_ETRON_HOST quirk flag, thanks for the suggestion by Michal
- Check device speed before invoking the workaround
- Add (xhci: Combine two if statements for Etron xHCI host)
- Add (xhci: Correct handling of one-TRB isoc TD on Etron xHCI host)
- Link to v1: https://lore.kernel.org/all/20240911051716.6572-4-ki.chiang65@gmail.com

Kuangyi Chiang (5):
  xhci: Combine two if statements for Etron xHCI host
  xhci: Don't issue Reset Device command to Etron xHCI host
  xhci: Fix control transfer error on Etron xHCI host
  xhci: Don't perform Soft Retry for Etron xHCI host
  xhci: Correct handling of one-TRB isoc TD on Etron xHCI host

 drivers/usb/host/xhci-pci.c  | 10 ++++-----
 drivers/usb/host/xhci-ring.c | 40 ++++++++++++++++++++++++++----------
 drivers/usb/host/xhci.c      | 19 +++++++++++++++++
 drivers/usb/host/xhci.h      |  3 ++-
 4 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.25.1


