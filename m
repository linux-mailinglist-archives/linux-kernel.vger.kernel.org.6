Return-Path: <linux-kernel+bounces-544459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0AA4E170
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38961884B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2327934B;
	Tue,  4 Mar 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgEZDKtG"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB22755E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098939; cv=fail; b=AAr1km3gnXv5LVFWDx6XtPAclRCwSAtivDDSRztJu1sAOQ+lJZK5mqdzl9CHIR1M+rdv9eTfdwF1E97l52NR1SaTsEyhys9vSfXIOty4tBVToFV8jGVx8QB/SqMDkTtHAMjz9vNN6jrAXlOIns7CJIaUyXW7MDe4F8joQDXbc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098939; c=relaxed/simple;
	bh=HVUyv28NQReHHPI1uHIauID9tj/bmXEQEv/wL9E2X04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcfgpxWIeulGn4bC/CcL7u1uKwGLDTBobAzZdxhHxWFsmCT7Fzs+dQmlS79OjUj7k+4TQ8BJZY4JSmFbx76BPfOGKvBajHEj9/JIhJGTM6FcFBR377/RYuhcuKpKZPrtfZsLRDq2+LJyShOEg7oXmyG45sVTU3V5LJCL0Ou1W7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgEZDKtG reason="signature verification failed"; arc=none smtp.client-ip=209.85.222.173; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id B6E7340CF12C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:35:36 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RgEZDKtG
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dTp0SNZzFwTX
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:33:50 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0D72B42739; Tue,  4 Mar 2025 17:33:35 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgEZDKtG
X-Envelope-From: <linux-kernel+bounces-541555-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgEZDKtG
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1DBB142685
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:15 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id E9D0C305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22ED188D924
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4F1F3BB0;
	Mon,  3 Mar 2025 11:17:21 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dTp0SNZzFwTX
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703631.30434@+uI5QVYp8HCdjPCZETG93A
X-ITU-MailScanner-SpamCheck: not spam

Like Sophgo SG2042, SG2044 also uses an external interrupt controller
to handle MSI/MSI-X. It supports more interrupt and has a different
msi message address mapping.

The patch follows Chen Wang's patch for SG2042 MSI controller [1],
which is already merged into for-next.

[1]: https://lore.kernel.org/all/cover.1740535748.git.unicorn_wang@outloo=
k.com/

Inochi Amaoto (2):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller
  irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller

 .../sophgo,sg2042-msi.yaml                    |  4 +-
 drivers/irqchip/irq-sg2042-msi.c              | 86 ++++++++++++++++++-
 2 files changed, 85 insertions(+), 5 deletions(-)

--
2.48.1



