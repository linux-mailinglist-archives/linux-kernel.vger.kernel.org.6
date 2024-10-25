Return-Path: <linux-kernel+bounces-380972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF829AF86E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EA1C20F24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B11B0F3F;
	Fri, 25 Oct 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fSAgYMAN"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709218C93B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828003; cv=none; b=C7k8AKTDM8Mp8mYmLnDTIiuculK+TE12K5Tzf6vYH8WsLZrF+iABfuT4hGYQXH81bghjADKmIJQbqZ4cn2FiIrcGtlg5WYOFTdWnvqmwb2aRL95d2jDkRShbCknvH9XelJnjy0gTdx0N1QzoX524o7oC2MNssACFxwJk3iKhh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828003; c=relaxed/simple;
	bh=uN+h/2QOVy21qT00CBb5lHlMvu4nek7Mn5Xk8HQsCAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQkIOvJmz20yoQGW1tshj4mEXIGdS5Yp8vj6EQ65X9SjA83AJWc7LA6sq7vQ2ozZUdhA7xMRtK0OhCMPfrv5KDTw+JozdZHYOONXT7OHDiE7N75Jb13TDGadizVe/Mb4okOQjanQP4Mx1i/b8al6zlH+naX986E+F4OnUIXd0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fSAgYMAN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2884e6ed0daso725505fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729828000; x=1730432800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMGNMPKqK0lqYmlnV0QWsKywIGZPhuT56WcMR+va1mE=;
        b=fSAgYMANET+yodJMHRaxDtCYUc/ANWU08V6fOCK5eNzr3U3i6ZCab/8JmPhDPHj8Kf
         P7UiuBHeIEaVBTbqHQi+/v8oj5PPAXgeOGvsJh+wmLwaDRM5u4uNiYx3z7bx6pDQYMfy
         HCgkvajbVPznnHat5PHfiDB3gz2jfVdazlvIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828000; x=1730432800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMGNMPKqK0lqYmlnV0QWsKywIGZPhuT56WcMR+va1mE=;
        b=gOvA9mJRXGS9WsaMA53jCu45egtxMzmDkFNmlFhnio4doCfD0cdsZytsmRYUKQU4Pn
         UktHY5VsIvphW8T7dgnl6qbRMHq/dBCA5Vd7GNu3s0ncbTlxKgpy11tQdkAkrWd2iMV/
         sgqcKOFq217eQ0IX8XE431tNFivL1Vr1cvLAQf8zw9SexDjvSAOmwNpf+cLBE8HseCxO
         SdMjQfDr9aQ6ZtaK5k8pxBmygCe170h3VG4fSaOs+TUVzpksmIUriJ7ScwoRIO6cykUa
         Nk98k9KIwSYDEsqpRc/7gOoORLmB8UswbLijYz0MV677861nXHO9nWLdgTtQa95sCnVf
         PF9A==
X-Forwarded-Encrypted: i=1; AJvYcCWr48nL0N0m0c/ijhbgf2+3TURw/fOZJJktGBU1akOPfhRwi34ecYSYjbngi0wSa4aG4vpd4AeZDEd8Nys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPixLOIgunRhaEtm7uG/uNkOagmu/qTx58fLh9MVO3fsNJeeGr
	8icb8FGl7QjSKOGoN6RyiBXOrSqG72m3mOImdkdblsErPrqwVeOfjBcVLtr0cA==
X-Google-Smtp-Source: AGHT+IHDIYmYDbKr3TnetPaMtGRq8ardDGQ9JsK2iH5M3t/dOsDwaez9uiJIYdobzDxCAzmJmupW0A==
X-Received: by 2002:a05:6870:648c:b0:277:7147:26ff with SMTP id 586e51a60fabf-28ced448ademr4272377fac.35.1729827999827;
        Thu, 24 Oct 2024 20:46:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c7f5:2aa6:333b:bb6d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696bbbsm185197a12.49.2024.10.24.20.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/3] media: venus: close() fixes
Date: Fri, 25 Oct 2024 12:46:11 +0900
Message-ID: <20241025034629.660047-1-senozhatsky@chromium.org>
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

v2->v3:
-- factored out common close() code (Bryan)

Sergey Senozhatsky (3):
  media: venus: fix enc/dec destruction order
  media: venus: sync with threaded IRQ during inst destruction
  media: venus: factor out inst destruction routine

 drivers/media/platform/qcom/venus/core.c      | 25 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 ++
 drivers/media/platform/qcom/venus/vdec.c      | 11 +-------
 drivers/media/platform/qcom/venus/vdec.h      |  7 +++++-
 .../media/platform/qcom/venus/vdec_ctrls.c    |  6 -----
 drivers/media/platform/qcom/venus/venc.c      | 12 +--------
 6 files changed, 35 insertions(+), 28 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


