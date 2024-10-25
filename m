Return-Path: <linux-kernel+bounces-381522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9219B0079
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3521B1F21F40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B61EF081;
	Fri, 25 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="auVTtDDT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6451D90B4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853476; cv=none; b=Eyefzbz3/OraUXiYDY2mgs/g7zVgB7z2q3rbiCu600Ex7iKneBCtRNUJs4RwR69/M96vr8xS5j0RmtZVvQnLdas/xpjEME/6bkZmL77PF/WV+NdWFQj656raLm8GuNuBN5tIdekFYCfZGl2ygeXy0P8cd8vPzFNAzoom8r/efd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853476; c=relaxed/simple;
	bh=SgfN217wiW0ngwkvZqWpWi0XYY+z2I+WplJDCTvPZ4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYHH+RXJOF7XU6gplsugocrOZC+dVIRkLD2M2QEyfvWDnxN6RCcTo1XHEMtdSiFFULsMzV1RsCOcrh4tYlfycCN3fA4G35AIftGD3Jap/u/jGKDPMORijoIx+wC7Pc7lCk50QYg1CkwzauyBsJzupM5IQU5et4qKfYqn0Mu8afc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=auVTtDDT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ce65c8e13so14644775ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853473; x=1730458273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbGIK5yiKqa3T/S+Q1n71HBSd3T2s6s0+kJr3t8PUD0=;
        b=auVTtDDT/MsrCu9xVGmsg2KYzslWe1bfr09PnZAO3hv9Hfh+dn/+jcSL2698tIcxAB
         XReZWOUIBBmoZfVJQpLVGpHO/yf0kKkKbghEtArMqdAOi8L8//5rLQ2yfTtjTuEGcymJ
         g5Hl5NZNTuF5E28cT05CXFKwEiSQjdsciUqPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853473; x=1730458273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbGIK5yiKqa3T/S+Q1n71HBSd3T2s6s0+kJr3t8PUD0=;
        b=ruywfBLt9DaOdPaPAPVaf8mKXUcrs1cGkJQvtbyOsSyYbNPjd7hKgPWzgRTEuT1G+x
         +IcXUbQQTq4MUJ0J7RRoMMAWYA5wD4yl2rp1gezAXwCuNzwPXR5whGe0zP6y2TDYmTzP
         NksNzjxEYQ4k93SxLYOt2pl8uQKO9DID16JUvCa+vrSKRewDquovGJ5k0qWt9hDt/QmY
         P3vGZitRSLQQOmWltCx4jmxT3meb03sCmg3KmIYDDxC2660rWNfPbKjoIeD/1g09Dj8z
         O9KP/Z3YvpNyYaDjbE80SC2zO20MVGqOc2ZUZPRuB3JOZDQo8PJ4yc/n8ZcMIpZL/CrG
         x9jg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZYik+ApKUwy8lisUayKFK2fTBfUxbRZ67F3pP4gQUEi8IsjBzE7KGPZlr+x+LhS+7MbcAQeLPebeRzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zjwQ9r4iIygP3ilO731BB/OugJr62wKtMOMf/qnptbqAa7xk
	hISYmJC7WJRgnz2gtXyd0Nd5PT15EIZLCL0pdhPiDJRDpecmOPlyLawwx5oJ+A==
X-Google-Smtp-Source: AGHT+IFbhBwuu9+pwYn7L9yN5+DIj8UKK9XGyWuwW3fKpksbAHz+ZnTk96qEHLqbLJ1urWYSfFRVJQ==
X-Received: by 2002:a17:902:ec8d:b0:20c:dd71:c94f with SMTP id d9443c01a7336-20fa9ea09bdmr105461235ad.41.1729853473542;
        Fri, 25 Oct 2024 03:51:13 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:bd37:bccf:f3e:a9ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc030809sm7326755ad.227.2024.10.25.03.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:51:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/3] media: venus: close() fixes
Date: Fri, 25 Oct 2024 19:50:36 +0900
Message-ID: <20241025105104.723764-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for venus driver close() handling
(both enc and dec).

v3->v4:
-- removed vdec_ctrl_deinit() (Dikshita)

Sergey Senozhatsky (3):
  media: venus: fix enc/dec destruction order
  media: venus: sync with threaded IRQ during inst destruction
  media: venus: factor out inst destruction routine

 drivers/media/platform/qcom/venus/core.c      | 25 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 ++
 drivers/media/platform/qcom/venus/vdec.c      | 13 ++--------
 drivers/media/platform/qcom/venus/vdec.h      |  1 -
 .../media/platform/qcom/venus/vdec_ctrls.c    |  6 -----
 drivers/media/platform/qcom/venus/venc.c      | 12 +--------
 6 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


