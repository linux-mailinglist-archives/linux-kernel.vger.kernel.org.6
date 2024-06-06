Return-Path: <linux-kernel+bounces-204826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD88FF3F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076F41F28622
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E641991D2;
	Thu,  6 Jun 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8Ckb8dK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560538DC7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695659; cv=none; b=ciCO0AffJMTMqfMZyH4tG2u4B+0ITLB1tFDhjKgXdZg2PHkMdny1njbCwRshXm4/3TAHY2XAAuV+/yjlz3gAhxCOo86HpIvtrtJ1BBzHaATzUUIA8MQqqwd0i7hpcUbfyyUm535YuCJSZRQDmNNTGFlvnfMUBrXRVUhdJmad2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695659; c=relaxed/simple;
	bh=vPMN4+EuzAzMrkCd7/l/7R4dqNlDszNDo/wobQVjlgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY3G3UUuUoWruPBsMaK3+OEl92qu+gDO3L2ZVc6WZzfdVWJOpe6CGOnlVbArYiRpdTHQP51hOq0TEHIXEPplqQ94jRvbEfgdKUtabPO5cDume59UnEGjEziY6WuXHGFjS3wD70mODHUMapPjQtPViKl+e5oPvHJBxHX6lOlPedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m8Ckb8dK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f67fa9cd73so17472165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717695657; x=1718300457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=786yOwwqWC8f8WKdqMq1eZssf/oeUFi1VZZ4ZRDSieg=;
        b=m8Ckb8dKBpTK2SIA91Svo/7Is+1qdG+BdxA2cT4oIQ5XFqoRZIu9NBqRixVQmPpAwi
         viLexgY+SRCVg0Voqz1C0N9VLODwJZVwG4p7eHn1U8kS/+OgjTRJk/1azYQpMId7MD9+
         oTkr8EuonLANu3V3YjoAKWgLR1A/CyDM08egg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695657; x=1718300457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=786yOwwqWC8f8WKdqMq1eZssf/oeUFi1VZZ4ZRDSieg=;
        b=mzGI3y4jeXGkuf83Q3ugqy9r/oI2NigyPQe0Kp1jeE0iNaD3RZtQoefleV3X7+n9Da
         KZTuR676LFaTm8kHws/kJ3tobZjn+myYZaGK8bndb/HEAyivOj5LCPohsrpaoDfuBEfp
         Oq1Hi0z3tlSRnjmzqUTxegVOptIFtRMxBViUBnVlxjEKzGzreOJ/WKcmyFGuEfqzNlHS
         OoI4qk5gg9VjFcqmQ4206dEh/IuzYUTwE77635Jn6BfAlJ0bHy5KHn/L4i0ftBnQAy5r
         odeaey1GiNZ/Utx6SsmcD4HgeAe2b7yayMaXSrd0ZQfaF0R2OkPR2q4CKXOzQw3S+or+
         Q4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXIhDXSOhE/UUFcS5GjQdwHsDfNgpEEZLWyvNhHjAtQ0Tge6sS4RkyrwHtV2RDZP9bvFb60beIexPjSqysujNu4WfF6+XoxMIVkWFd1
X-Gm-Message-State: AOJu0YwHqeFn08S67h2SjVFg+H9bx54NiejZpFdFcXnBBhbU+D51iDFv
	xO205Y6uCvMnfuhPgwkJ7ALC5+3nPDA4iCLsNtWJouMrn35+3hOiU+C3P1R8fA==
X-Google-Smtp-Source: AGHT+IFnCZ/+uAkMhQhcfFVpNxKI1wIEiKMNJnnfuVBXtku06HzN8UdFZeDTkBwQBfpqdm24q50dNA==
X-Received: by 2002:a17:903:2286:b0:1f6:a572:86ab with SMTP id d9443c01a7336-1f6d0151b7amr5291325ad.15.1717695656830;
        Thu, 06 Jun 2024 10:40:56 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:3fe9:f321:712c:442f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7fd937sm17776515ad.285.2024.06.06.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:40:56 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bleung@chromium.org,
	groeck@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	pmalani@chromium.org,
	swboyd@chromium.org,
	hverkuil-cisco@xs4all.nl,
	rekanorman@chromium.org,
	abhishekpandit@google.com,
	pholla@chromium.org,
	chingkang@chromium.org,
	lma@chromium.org,
	Daisuke Nojiri <dnojiri@chromium.org>
Subject: [PATCH 0/3 v4] Add cros-ec-keyboard v3.0
Date: Thu,  6 Jun 2024 10:40:39 -0700
Message-ID: <20240606174052.245034-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240604005354.2294468-1-dnojiri@chromium.org>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a support for cros-ec-keyboard v3.0, which uses a
reorganized and larger keyboard matrix thus also requires a protocol update.

---
Changes in v4:
 - Change subject line: ARM:... to dt-bindings:...
 - Add description about keyboard matrix v3.0.
 - Add cover letter.

---
Changes in v3:
 - Remove CROS_KBD_V30 in Kconfig and macros conditionally set in
   cros-ec-keyboard.dtsi.

---
Changes in v2:
 - Separate cros_ec_commands.h from cros_ec_proto.{c.h}.
 - Remove Change-Id, TEST=, BUG= lines.

Daisuke Nojiri (3):
  platform/chrome: Add struct ec_response_get_next_event_v3
  platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
  dt-bindings: cros-ec-keyboard: Add keyboard matrix v3.0

 drivers/platform/chrome/cros_ec_proto.c       |  27 +++--
 include/dt-bindings/input/cros-ec-keyboard.h  | 104 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  34 ++++++
 include/linux/platform_data/cros_ec_proto.h   |   2 +-
 4 files changed, 157 insertions(+), 10 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


