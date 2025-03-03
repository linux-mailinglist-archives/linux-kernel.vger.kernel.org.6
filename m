Return-Path: <linux-kernel+bounces-541555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348ABA4BE3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02E3174C91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70F1F8923;
	Mon,  3 Mar 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgEZDKtG"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512031F3BA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000638; cv=none; b=SycqatKLOSLPtu9YSA09IjURaOn+YmJ/oSM1LkYxNXCgEx+d42U6ngg9dYp7L08KYg/QQrRCQLY/nhbJW5/7t6vWRC86UGCZ91RZf7aFL0tHC1xqFZGGKlUHmMysbR7V0/8KQh4gMTSfs1w1oJYyqBUDlDog3qXa6ndQq27LWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000638; c=relaxed/simple;
	bh=cYRg/UtQ+QTjULJEROcLmWlBc1Hr8j1abFv9RUnzzAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqLYrM/sj+bTgo4V0rrHu7XcG1goPX8E/bfAG/NpLLXiyryD4gLfSY8UsPqaMa4igJ2JxDWFOk//aN8ZLvAYfHC6VjMpxV77ogwsqLZq3QoaQVUTrOa30eEk27Q83hJdbjMygVZ8jZfL66mu2rs3zMOyOrRe5jAVymUH0Qr5xaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgEZDKtG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0ade6036aso506082385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741000636; x=1741605436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eB+LhY6NNcyLq6FCMk8O4Y073ty4L6CdzDqfsuEgpeY=;
        b=RgEZDKtGv55CzjYH9SocgKALn6h0ZBO2NOMq3Kb1kE6w9iEyM5Q0DxWnM0jGcuZJ9M
         JG9ZcyNvKKU9Ry/e4KTyxtF1eGDM3ZDy3ekm0rOCHPocccG/F2FkVGxfYWDdhbMrrsoM
         YVWJ59jlDc/dHqiDP31ZZIhuV01LLazalVguiHvoV+IgSRIww6LxNtuDWJs1zynfT8oY
         QEnD6G5x65kZwQ3pqZDJk79LB7/sxb0C37aqqbxay3skHFJtE0IoT0EY7Bwv7tQI9acC
         pSqfmHdrkUKes/3IYvF8KaJxP9aOfIQTLv5cmbx4l3ZtBdRtIFAyOINdc+2MEyOLcjFr
         RJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000636; x=1741605436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eB+LhY6NNcyLq6FCMk8O4Y073ty4L6CdzDqfsuEgpeY=;
        b=SpvZR/baTOh6ZgFB+GtttuWLaokR3sOZTBcYU9ku5cSWrphOrnOXB7+RzD0aw8fsJp
         rVnzgDR9t4QVwC+jAB3dk4FA3gGB+g901kqi3JnhB8+GtMwbNL3qLG+JYJ4MnqIWOF8C
         RQT0xeznTDZEEmMu8PUQq4wyW90/wzeDh4G/1AL9ee4jJtvNXimtypDQHcLb2ctVfY9t
         0k0ldzGyJsXr+vQSol2V4MqRPodoGAJPzEFmIAV0ezxrCxscMbUiVQbo4N1WsQhZUJKn
         WQI2ox/MgD/jM4XjM5Z/ff0Lwjb8JJOjUhuIatM7qZMVS2HBu1rv+BHXKPzMa3GfMSap
         MkQw==
X-Gm-Message-State: AOJu0YymyiC/X///tbRRbWrzyt+TE71pFRV+5ziYUc6ENt10BXSAloPC
	SqinerDgTiagnlje1oMA5qlIldTEuAOThgti93Kjgc5jB04VEoMHYEhEJg==
X-Gm-Gg: ASbGncs0Itx51Su0GYFaYOlv8jiBRdzClJLZWGJl/nBPR9e1cr9EyPx7XsVYj8auVqi
	BMRhEFpWobEH8M36b7Z+xgBFBNPF19dPYCSOat4amKwfbeRYjGmQvSlP4/EBCGMCIOOyHMdKdTD
	GR0tfvf7Edm0qrCslfYRqZETDNyK/6mFMn1L6eJCUhqtRM9CiAFfaVPdD5peiDMaf88yf1A9Oky
	KgtCJSBiyQrgZ30ZjGX8dMzkygEhPxGWiPngoggnx4y0FwzfXEjJxYyrkxE4ChBjWL1g4RXCrfk
	oQsHW+Y41jj3GpJ2WQVJ
X-Google-Smtp-Source: AGHT+IExxBgO8Ucotj8ysaakDRBJ+gx6CiwxNw3F8tva7qbBLpnfOcN6RBjW/nocidB/DXegCw9ccA==
X-Received: by 2002:ad4:5002:0:b0:6e8:af23:b6f1 with SMTP id 6a1803df08f44-6e8af23b74emr84913546d6.10.1741000636169;
        Mon, 03 Mar 2025 03:17:16 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8972b9aa8sm52127166d6.0.2025.03.03.03.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:17:15 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller
Date: Mon,  3 Mar 2025 19:16:45 +0800
Message-ID: <20250303111648.1337543-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like Sophgo SG2042, SG2044 also uses an external interrupt controller
to handle MSI/MSI-X. It supports more interrupt and has a different
msi message address mapping.

The patch follows Chen Wang's patch for SG2042 MSI controller [1],
which is already merged into for-next.

[1]: https://lore.kernel.org/all/cover.1740535748.git.unicorn_wang@outlook.com/

Inochi Amaoto (2):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller
  irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller

 .../sophgo,sg2042-msi.yaml                    |  4 +-
 drivers/irqchip/irq-sg2042-msi.c              | 86 ++++++++++++++++++-
 2 files changed, 85 insertions(+), 5 deletions(-)

--
2.48.1


