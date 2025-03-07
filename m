Return-Path: <linux-kernel+bounces-550212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7006A55CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EFE3B4766
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714C13D89D;
	Fri,  7 Mar 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi7VfpLq"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF1DDA9;
	Fri,  7 Mar 2025 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309616; cv=none; b=LAn+KhKEL4OEDNUZB2zjzVfZ+1gRyDylOr9Ixflw1KxwLDPfw1eW1+Rb6KR4W6imWz8voxsPcEiAxT95nPSFkWuIs6o6v+pqzX57Vfhf2ic94P758L8+y1KF7cpABEvBJbYGGpZ1ptZgHq5NOI5uNcxULaE43JJAvoXklMADKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309616; c=relaxed/simple;
	bh=XTOd/qM18P4xT2oWgKwRyBTQucEMFv6Q89AV3jPPlG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnSEDbakvzXSlKJ+HX8n6TxI8pkY1fgX4zq0M9zmHvLr+HHrQ2U/aj/d6+VjsdLQA0bXo7O8PSr7oHGpVoM54J5P97jfkBJyxEoUultX7yeV2pCzvHtl2tbXx0kJ6t+Km3agXEjMhc+X5bRkOeULcBs1aP87pwlqwFQZuT+rsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi7VfpLq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b63dfee1so153773285a.0;
        Thu, 06 Mar 2025 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309614; x=1741914414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y31B8wAfn3U31ylaKQUOW/SbJJh+BsVLwXk2uIata8=;
        b=hi7VfpLqCmXXwK2RyS9GGu340UHg0plwhuyYtQ3uPXDuMSCU/u+PriWQqaRpJhUrV9
         /ihyOxpiFUOkNPOuXqC+mXDmFfneBMBQ+NMCUgvlltxAhQt7H1yzXRLYARFeLAYJUvru
         2pkDMuVS9ht4Uno1UaYlFEMjIpLRtDU9eqhrf0VjNTHs53XIebLMU2q/D2zsARKA4qDH
         Y6m0qtYT3oTkRhZQb/xnX6iErJ+sSNQO3/14JSfGTuIJVZGR8bRXKyuoItcz8l18i/5T
         aOG4SI6cKW8t+3tf5wAD6nRzll3No1nj0FZE7GB6T0NdoZmxQ28p11H2T+TsA60ZSDST
         n8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309614; x=1741914414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y31B8wAfn3U31ylaKQUOW/SbJJh+BsVLwXk2uIata8=;
        b=Haf7vS2cK3U2eSuT+4ATGC0E5U6xgJf6Qh5C7kUqnhO9vAqbMJmzfygPlTIW9aHLMA
         XQ9dB/Ac4SLSG6aXUv2IGTooxITmqhCcvkCwbN+prN/9BVd63ph9sAm3NzNfv52tL/mU
         8es7n4R9dw+PsU9vau1iPTieolOCKe1Ep/Gdl0yfrDOrtci+XJNVFaD07ElH+7+sYmGW
         nAL2+7cC1jrBgxKtLnO5nspZYZrRaeNyCF/leh2BJ6CsnjbFcXilI049iZVggOCVl8Rg
         y6CUkBQz/S098h83JkVl9hI8nlg7tR41mbdH3wltHfEf/xU06Sw6asWVz3GrZnK/gcHh
         tXnA==
X-Forwarded-Encrypted: i=1; AJvYcCVkyyM+0+KDHIJXsf0GQS8q2Mu935eDoWfzKMXM2Gh34vLf2UAHTiR9WMbLwcr9XfhztFcIYzy9oYs2@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEh0SegGmlziwNlS3eGdOuKGMDRYGIVe1LGLglxUWGj4E/CHW
	Rm5+hb1XZO6H9AQwzVVObxcVYo42M1ZeuyEXkcDAOh9UZxrlIbwh
X-Gm-Gg: ASbGncvFVQ24V05j4FSsV6B+u09/qZVRYXyqx+vzu2GIbkvZk7PowDXp3ptuBKJvdgQ
	oYNTFeL+XQhMDw5W+S08zBUipSbNGM0fK8mpjXgf+h4QvEtqqb0FjojK8XtPW28SUhZ+Mgs4edv
	x2lgnsAJWVcftRLKP+v6MmGymZS3BlLRqyHZIsyjbYiKhGgn2Xtw1roK6+DdtTTY1/BLKpY9J6Z
	sTevSbYLAivYPLEidDXY5Sj+RMJexAumLLjST6qXWklE1BCq8ICbH3b9IOPouW0bJ/FQs5Iwidg
	w699QDqj3w4rXQe3K75Y
X-Google-Smtp-Source: AGHT+IE7cBzIFISSeK1KFa606PMHxR87/Uefy8XC3FEGeWg3bknF99yUyg3Mupnh9mYcrzl5yIrlfQ==
X-Received: by 2002:a05:620a:9007:b0:7c3:d3a1:6f43 with SMTP id af79cd13be357-7c4e61de208mr154630785a.57.1741309613859;
        Thu, 06 Mar 2025 17:06:53 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c47d66273bsm60577885a.69.2025.03.06.17.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:06:53 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller
Date: Fri,  7 Mar 2025 09:06:45 +0800
Message-ID: <20250307010649.422359-1-inochiama@gmail.com>
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

The patch follows tips:irq/drivers, which contains Chen Wang's
patch for SG2042 MSI controller [1].

[1]: https://lore.kernel.org/all/cover.1740535748.git.unicorn_wang@outlook.com/

Changed from v1:
- https://lore.kernel.org/all/20250303111648.1337543-1-inochiama@gmail.com/
1. patch 1: apply Conor's tag
2. patch 1: improve the bindings comments.
3. patch 2: rebased on tips:irq/drivers patch
4. patch 2: remove unused macro "SG2042_MAX_MSI_VECTOR"
5. patch 2: rename generic structure name to match sg204x.
6. patch 2: rename info field name to avoid misunderstanding.

Inochi Amaoto (2):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller
  irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller

 .../sophgo,sg2042-msi.yaml                    |   4 +-
 drivers/irqchip/irq-sg2042-msi.c              | 124 +++++++++++++++---
 2 files changed, 106 insertions(+), 22 deletions(-)

--
2.48.1


