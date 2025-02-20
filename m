Return-Path: <linux-kernel+bounces-523651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACF5A3D9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B228189E648
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752831F3B91;
	Thu, 20 Feb 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SjZ+KiG+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC113FD86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053880; cv=none; b=rq4UojhdhIDdnvvWxqEtq6rIXLRa1iBpjUxU2QA4WmiJuy2rpzrqc8B88QkHWF2CGFU41sDhVv9ttj6r6XRlAyCYJwHHqoV5ok3ynhi3FX0yMUeJiCd4lYsjJDTWJPjTcHPKrkSFGc9pP2ihxbFyJGUnXfwsX6uLG0L90TkkEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053880; c=relaxed/simple;
	bh=ovInfsJ96+xONzJYIftLY8ItKnYcVc+4SXbTYAmQao8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmYDDVnpP+fkBRMZsIvSBcsJmIhofJbGLiCHWnqxjow8UT/xm8pDzqTnE6WdNmNEaXWRsnJUpX1rNTVi7/NAeiBofJCwzxRANGXMJWQ5n+BvaljgIqYeQPIMlk3ncpKeIV+V3UcCeCcx2E505K4d3G60fcGd8XvnhLQ9083Gzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SjZ+KiG+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e6028214so16490325ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740053878; x=1740658678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mhxc0Zvns6Yn1JJtRPi3TJJp5srNdU12f0u9NFGaDA=;
        b=SjZ+KiG+85PWwNTuFGrqjAvwy002TYPYJWUiMSawMdMnB1+5PITTJvks6tIMBrEvbb
         wT4uX8sdYwMM5jua464yjhOIJn6MCPdj4uptitZtazjIp5ebEbwD1op3z8ConAI4gXsE
         WNJY49wb+xWUTve6pvzjQvwgu7mRQkPErqadiebR3Gazu8dbZ3qkGptA5ESGJWoVQ++7
         akmK+NyAJcY7yUO8fokZ/d6D/Z2L6aEUvxIxtUfNE4akqdBa4xVXOTpnofBRGz1GdYqF
         ZTGVssazxVwB0QsTs1Ak4HL/WHlQYyh92LSeOE/PecG4dmGDlB//DgcLLy89IYN2LrQf
         sPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053878; x=1740658678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mhxc0Zvns6Yn1JJtRPi3TJJp5srNdU12f0u9NFGaDA=;
        b=QJ0oik2FHZAwHdEZydD6tQLF45t+eHKV0VYXALU/Bt4uC4RNVnNE4DqlLN745oMM80
         bsMbjKsj0Z1qV/eEUxOBSEy4PMsgvUz1BC/wreIOOpNuLUoA8oJdsF2/euW+6bivOi4R
         8IpeV7oPVLdSBS7rGV7KaILOtsFRPd4f+Iyt9xU2o0C6bOMCvG8SrWWQzOXfiwl+Ltnk
         LxzJA/1fykcWMgfQdc0TsVcOW0A0Dk0ruwd9X+45tKxL97SOx7M5Q0S0f08MPDweXvOj
         1Boq0E0DrTU/uVLXjBmvAveZEMlzrmVlnQDQvZKQC04f1TNihzosYmZD1SGkHq5JibZ4
         idvA==
X-Forwarded-Encrypted: i=1; AJvYcCVaJrzRfctix8xO/079EBAwE6w+/AQpB22UM+lg1u7YIgrjG++k6qsGhxQ1bHshNALi59ivHpKralwISuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRM9hllVrv5jPRc5s92QXVXGaxKpWT4ya4ELo9/LHpu3loDNV
	JZI6qJX40DvuIT7o/MF7LzFu2k+CuDISzUezMCVOEcOk9mHGIWKeNHsaBzkznwg=
X-Gm-Gg: ASbGncvLC8s0mQ+yexs3r2/SIXHxEZYRsK/9pLHkcCAFVONILVp7V/oAz7Hx0+dDQU6
	MsefIXdc5Wtsd2s2/ZpGIIR/mu8NMcURdFFVFXVIRHR/11rV41YDrgM+XMOk3nmoRnHsSXYzu4N
	QB0F6/yJ3J9k02IQvqYuxqyUNdCXRXrCe/OPDMG7eMghpAVpA7ccERxZtjiUtrGDZpf8lUWQdIx
	9kNFk3qfvy516NrpN7wQXSdmMAFE8sB8hzo15HBIiZbccRLv8veYIyu98KHGMYBQumZCufzHyYX
	09SCC2EWTCPaCDG2O6l9l28m/d52Gvb3hsODmBh7Qn/Kfiqvew==
X-Google-Smtp-Source: AGHT+IGDJ50LQRWaa3WO9QsRF4eufVt9fyhtOZXwrn91dXqUgW/zlEdNiAcm4tKuEZGfurYEc02gAQ==
X-Received: by 2002:a17:902:e806:b0:21f:81f4:21b8 with SMTP id d9443c01a7336-221906a6c10mr37088815ad.50.1740053878554;
        Thu, 20 Feb 2025 04:17:58 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221040434d9sm87773895ad.196.2025.02.20.04.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 04:17:58 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v4 0/2] Fix dwc_pcie pmu driver issues
Date: Thu, 20 Feb 2025 20:17:14 +0800
Message-Id: <20250220121716.50324-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
Only sent the patch titled "fix duplicate pci_dev devices".

v2:
1. New patch: "fix the incorrect reference count".
2. The "fix duplicate pci_dev devices" change is made in two places:
One is to remove the modification of the PMU name. The other is to change
"for_each_pci_dev" to "pci_get_domain_bus_and_slot".

v3:
patch[1]: Remove the logic of "fixing the reference count".
patch[2]: When pr_err, also output the sbdf.

v4:
patch[2]: Restore "platform_dwc_pcie" to "dwc_pcie_pmu".


Yunhui Cui (2):
  perf/dwc_pcie: fix some unreleased resources
  perf/dwc_pcie: fix duplicate pci_dev devices

 drivers/perf/dwc_pcie_pmu.c | 51 ++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.39.2


