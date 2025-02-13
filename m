Return-Path: <linux-kernel+bounces-512177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99493A33527
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC973A747D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14F158558;
	Thu, 13 Feb 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOHXeigN"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D72156C6F;
	Thu, 13 Feb 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412561; cv=none; b=J9q02C3tYcbqnQv/zSS0Us9aeEVj2JA0eu+esqHTGGXZAohfUZdXkd6PMUNNtH+gMq9aN6vVz3fd1+cTd4dKjjaIqYXIPihNOOfWkUe4CO/kt119d2IJ4foKPh7/vQSwD3qbhgChuNsHgcxAJ5cm9/JzQBTl96n21bauX1BB7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412561; c=relaxed/simple;
	bh=nS47DlaRDUQh8iykcHA+QsKrWOjDhkLjvofTGBu9D0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7zBSaOJgU9ZNEimBP+z59QMjbHqmVlJpxdfMvWMxP7SOTGTul+fACwAkww06YgKz8ZBoF0CWokWfC2sZecwWSBN3cHr6WBVi1yjU1FHKa9vf+KNRP2j56D6V6AuzybuCwPoxB+fbDgAUCjb92i3q2pTzC4ll5LQiDvr3yS12XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOHXeigN; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e46f491275so7390156d6.3;
        Wed, 12 Feb 2025 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412558; x=1740017358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJwmjznjyY0FbBsGwbEfQueE5DfCYZR8yX3zAlCe4RU=;
        b=nOHXeigN3squTVL16WFgPgFL9VqeyQmYbepysWCgP/EGHrBtYG1Qev/DHGhndApYg6
         G+nCAskfoNKL/WZeE7+t/oOFN1wmc1PBXGGADA+SP2UB8xtZX1K9r3DdGOk4RJaiN3Fi
         qcXlza2QwdR8YbSTZTVRxd2SyNa8hTGx2BJVgkZmzJEA4/WGGqX8caMuUrboQyEUFVSJ
         o1a4/SRL2IbHIpXC3h6cGkzQFtA5uzSKjiGQ4B0zxxctXNEJKzJpbmQWVm7ietpeyWhW
         A+pYvy97vW11Dv+C9m8GAzt3iWZKtbLDMTrj2/hGdWlj9WImxPxc5HFokPFiIZ9dpFGo
         HZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412558; x=1740017358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJwmjznjyY0FbBsGwbEfQueE5DfCYZR8yX3zAlCe4RU=;
        b=MB4yy7y1V5ydpTG4Cr1DXsgPnyZ/HEobZUxsZMypHlcZqrf0oISHSk+UuQ9zVQRRlR
         6eGbKq9wzxOnDLZFTg7bOCTtJ1Il9VDurho8vYRpT0JEqOyVbFl1kSDbIGWaq0jd1KdO
         SvrAnZUBbTuJIw8j50yNNoejKFHIaE9E4V6w76Rp2guQpriOlUceVfsunBVenxJJxmvs
         ZqrYCMhSqZmWEu13Ip+mCg+F4nS7NO9CFPfcUoVuRE8yuI665j29sBq7vku6wQDPB6rd
         s2PpIExhDF10ALVJY9aGflBo/GZnbb+8KXR1TyTFGUKwEcFYLbv3Dwz+e6aIdWH+gKcg
         P4vA==
X-Forwarded-Encrypted: i=1; AJvYcCWfjYOOZ2xF23WNMp2lFZFbbcfDnfnXwZWMvskUK+gu4ZOAOnNH40rOTnjCw8iGn2rScynFzHmn4xhP27Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWWbZ4KetNBOV1bpT2j8DupACJux7vC6RXN3l7k8bq4p8g0oU
	DU7a13lO51OldSc188oV4UmsOGwJRQ7XPm171PNEL7grOrWaRFtX
X-Gm-Gg: ASbGncuI8SSBbYao1N2dvcL0/gdQwahyZQbHW+BfSYhkO/57u0ILSUn/y73IpuMsF4I
	8r2KzCBjCCr3K0293wFgAm4PiTt1Kgl1O1k6DC3I/jyETadSUk1VOuDYAdNiUaofwycHaoZ62H+
	7WdtlLfd99jqZe0W0wwqpp5E4rpzPC0fSeuMcILEZDfL4TwUnx8tgJ1G/Ghqt1/HuqBI5yqoHOp
	mA9kx0lgcFt0VtbZtFBpDbHTEISPCGgAicTbT58Qt203rPJkXgLZMT4wFdR2vG1FdU=
X-Google-Smtp-Source: AGHT+IGmj+oM47tfcJcPNQ8fw1vpHd2JW2ApUYWw/rZfMQyrEUWN3vtTcOqHh/Zum1ZuC2b+S4ButA==
X-Received: by 2002:ad4:5ba8:0:b0:6e4:4484:f358 with SMTP id 6a1803df08f44-6e65c150e61mr36705926d6.33.1739412558648;
        Wed, 12 Feb 2025 18:09:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d7a3caesm2558026d6.54.2025.02.12.18.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:09:18 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/4] reset: simple: add support generic reset-simple device
Date: Thu, 13 Feb 2025 10:08:55 +0800
Message-ID: <20250213020900.745551-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213020900.745551-1-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for generic bit reset device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/reset/reset-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 276067839830..a24f8fcc6a06 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -148,6 +148,9 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "reset-simple-high" },
+	{ .compatible = "reset-simple-low",
+		.data = &reset_simple_active_low },
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
-- 
2.48.1


