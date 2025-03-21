Return-Path: <linux-kernel+bounces-571242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B88A6BAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC487A899C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094E22A4FA;
	Fri, 21 Mar 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgfXzf9q"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C57228CBE;
	Fri, 21 Mar 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560783; cv=none; b=AvhDtTCFrnVshjrlJxHrNymWH+e/C2DTxPai0hSa0uYjqG05ilVU37vGzNKkcCc0sjAMV74ZVq+H8bzuk6pBg+jR6Q54O2uu+ZE1X8d2wWUcwS72ZNk+Tr/uEKIWOCGn9ak5t7GOMvBKi4NxGjRZXk+PjgWDu76NsLybzOzs+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560783; c=relaxed/simple;
	bh=em4EuCTpFlT7jMcqX+J6loUrFSzpSMvlouV1cDV8ssU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4vlM1wlOF5HworCuLhnKH6Aecmrd7r2SBxoGk0PDshPJBhQoyat4fw7aPhKWhJZ5lo4ippt/RUX/4lw76plZXILG1s6bUNItdOkIMLhRteHngbyz3hv7tUZeLa+ecT29B+2pwXJhIVx7E84LWXFD3w42LAa9IqFfLEghf7rKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgfXzf9q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224019ad9edso45758845ad.1;
        Fri, 21 Mar 2025 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560781; x=1743165581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+j7ZByvLSkPBbGZ8e37EOuRyaPsfVXExUNogWzc3E=;
        b=JgfXzf9qi/pIzI8LQkOezhtctiL+ra1khq3q/IeVTuZylV2viS1DrtBMf+XDhTDELc
         +UxaHA6hP+Mh0GadsFk5AF/k4xfIaG8iHX/sXarJI7FC6Eg4h7x/tMpfYMC/wBTcetoy
         NvdnMF+i6qVTg7Q8/V0+dqMMwMtLd6ueY7nQFPMokDsiS4qEqMShZZGMqk9qTUpOv8v1
         8OaYlZ7d2gwW/kAjYWbyqMxlsNyzT+6hAALNu4dsGIf/fXsmpqtzg3v4VThCGzZsNYfY
         b0vkMLud+W2zFs/Xb1zNF9z3yGj/MZsHvK87nHItS1vZHXN3s++HBC7smtRB+8iY4pgm
         y+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560781; x=1743165581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX+j7ZByvLSkPBbGZ8e37EOuRyaPsfVXExUNogWzc3E=;
        b=h+hG42p50AlpGpcMELI5YJk2HUPdpBziiGfixS/algAM/3O6RFUjR3PltyKd2O/bdi
         R+qeFY5i2hwEMPYEYHr2lh5g3b7R9lk+otm/WqUi85O9USQSjAFzb0F7AoUn6dcXhTpe
         GenNYj0g9maKymO4JlOYvVk8TDeRW1TQoEAmAwM5BkGZRFLHa7sOYbnlBAGS7gUEk2oo
         VYJIPmWzkduVNkIE9ZYsCgJ0dUw245QyQkFB9suQlmWqpiXKCBbRU+Tt3IvS6V2Gu5Eq
         bcUwnLDehxW+qIoOvgyptehZuTlr1PRmknB3k+J+O7Nh6Muje3oxu9XC4HZ1Q9B8gfAP
         HJjw==
X-Forwarded-Encrypted: i=1; AJvYcCVlOLUJ2YZBoPjWa1j8dcsiKcX2yMldp+iqaPuXe4gEUNMsMupsT32aGVN9zjz7vSLiK5q20OZdA2OoI5AA@vger.kernel.org, AJvYcCX0hcYkfQFbVZHoiIZy6X/k6BoQ+BIe6icCfFMhOBTPthy4blIbU/jnxKE+aEGzHfOmgal6rEqN/3E7@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcyykMauuoO5Bs7WuRluLINGvtElo7xUTHrn9PBAa3JKXn2Jq
	pr9IFfGNJEL+FO5yRkv22xGg7Ua1es1tti03/KvHnKrOPSXhI7/H
X-Gm-Gg: ASbGncsS7FMq9l3vbLWCrbx66bVSaIe+IWFfGktjkGsFH6iQVf7tzzltQOFfMiKsIk0
	Y5Ezr/doedbrH1GNGb99UWbtY6XVp9zu8iDSkokwlSCrT96oD3rD23jjp69d0a+i/8JZgXOCAXP
	cgNPRqutRVVsJl8GhLdZ6aPz2nNRgy+fEbCpEEykMnc6h8TCS7zYxHDiKj6RKHIBOFyQZw8lXvn
	KjcF3UxrsXvRidD54Th62qH7qJapifYiA9k3mrdDYfceQUS+OTd3xgMe/Hd3XhUU0aXVy2HOTUe
	CaG4V61Y1ZU75jRtRRwQoeTSJvfAiC2DGVJ41DVfA454SZ/ZgBHjdyVe7tD0HbjLp0pqH4k3F5z
	IgUm8fXn23QDXMqfInZwIL0+TNvw3ocITy3s3jdQ1y52WPr7jORbjskJMSe0=
X-Google-Smtp-Source: AGHT+IHId0CD+P7qvQUeVHlIxcs9d9bWCjTq4tyT+oN5nat9T4lYmUbkwkbTDc4O4exXD2ol31Q6kw==
X-Received: by 2002:a05:6a21:6e03:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fe43437119mr6748664637.36.1742560780747;
        Fri, 21 Mar 2025 05:39:40 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c90sm1815432b3a.51.2025.03.21.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:39:40 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH v5 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Fri, 21 Mar 2025 20:37:29 +0800
Message-Id: <20250321123731.1373596-1-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

Jason Hsu (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1399 +++++++++++++++++
 3 files changed, 1401 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts


base-commit: b3ee1e4609512dfff642a96b34d7e5dfcdc92d05
-- 
2.34.1


