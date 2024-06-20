Return-Path: <linux-kernel+bounces-223868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E869119B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B282F28535F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770E12D1FD;
	Fri, 21 Jun 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNGDy+SY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71575EA4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945209; cv=none; b=sK1QEv54fXKF9cHFYmkTq6AeHHr7O5hcOKlUy46j/PVd5xsLPOuuc8Vto0vCnkWPgTHy2f8zlYHaPlrB6A7A2OtFkM3el/Jb9RNcVKkFU4Yb/0yOTD8qRRBCc+CZEbJasq0bFvCya0/wEjMHEcVj0gusDDYKJ51ejVHWRWhlmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945209; c=relaxed/simple;
	bh=JJC/I3O5GRXPoKzRW7Nu/QuO8UBu1K3iC2+TCvjJz8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyGc2c2G9FU4doVBwLpsCOM0LDIYRH6OICUWb/yNxe6NjOtQnO5Cfv194qps47BiZnCIxPRtkcZmneoQeyFfgyOsFg1EadMyPiVVe1jhA9n5sFzkzWE3xhmc8/VNSz2N5KQMq1W3xUy/1FzTqBybov5V/yYmBRDhcIs696APvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eNGDy+SY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f862f7c7edso13640955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718945207; x=1719550007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVr9D+4ZKCK2Oqgxnc0hRFyswNHBf7kcjS5sJf1/BeQ=;
        b=eNGDy+SYGc9vHZJZWUXH9bxmcKAm9yThYyDBS8YCBnGUtXsV6cQ3pciWIwP9QmYCnq
         VgujbUlrEWqCLmG80WebATRcS5cDWCvbhTC9cVbPrHEDVCCDFCGvBVgcLHHAXwPHdC+r
         R2WK7AEJS7C7u38Nq8ddoWl2NhTnc6OCR/OPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718945207; x=1719550007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVr9D+4ZKCK2Oqgxnc0hRFyswNHBf7kcjS5sJf1/BeQ=;
        b=Qdvz1/6KwqzFO5iMa+fAgrHBHP0c7uGpUJPiztGkU6z3KakqLamoZssho83lren/Ou
         JxmfoxaKtHva1BomrUi3yhegP9w/RQr/1DBBEaylXzhjFcggwKuT7oMUyf9JpRWWshpI
         koNoj541AHP3Lb1ehP6jahYpyEUvn6t5cmqqZdc9JK6EWrYHrppkHMlRnZgeYvTqpseP
         Ey3s5iXVozQX+oWyUPBLdnYSvNj3wtig1aGdnqXRmhhyYrChGunOscj+kgvp58Y/23pl
         QNBYnGE7zueaalQtMQdggfp+fWYtrV1qSxRm+Cioo+dHxCPXKbZi87urztR5Ir09RF3A
         1OFA==
X-Forwarded-Encrypted: i=1; AJvYcCVAM97bf7aa28gnC+2ER99sGLjSCTCM3BsKn8kynuW8A3g1tzy8fF+ZrFx6THjb+t6cvWLTcodgOw5H0rdTw9449EBlt5eI2NOyw//l
X-Gm-Message-State: AOJu0YyiCzKdlOjOg3TjzWYD4bKiHEGspqdKN//a93/SsWjWBV+P7v+l
	5ir4l3xMH7h2zebjsph8r11y4Eb0X+wnT5CeUmd9MPy2VPx8/zPp+Iil5i0XKQ==
X-Google-Smtp-Source: AGHT+IFs/CgRUv0OLU87fXdJupgE65QELm3r/SYFBgPsk4QhHbCW0ldgmGnj5XaE3T27hhupEXL4bw==
X-Received: by 2002:a17:903:11ce:b0:1f4:b859:cb60 with SMTP id d9443c01a7336-1f9aa396f5amr80206435ad.10.1718945206711;
        Thu, 20 Jun 2024 21:46:46 -0700 (PDT)
Received: from mstaudt.tok.corp.google.com ([2401:fa00:8f:203:3c9:e095:f93c:9c3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb5aa5sm4780755ad.271.2024.06.20.21.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 21:46:46 -0700 (PDT)
From: Max Staudt <mstaudt@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Max Staudt <mstaudt@chromium.org>
Subject: Fixing IPU3 IMGU warnings due to extraneous calls to s_stream()
Date: Thu, 20 Jun 2024 23:45:40 +0900
Message-ID: <20240620145820.3910239-1-mstaudt@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear IPU3 driver maintainers,

The Intel IPU3 IMGU driver no longer shuts down cleanly since v6.7,
because vb2 now complains if s_stream() is called multiple times on
the same object:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=009905ec50433259c05f474251000b040098564e

This series attempts to fix this, but needs a review from someone more
intimate with IPU3 and its driver. Could you please have a look at this?


Thanks for your feedback,

Max


 [PATCH v1 1/3] staging: media: ipu3: Drop superfluous check in
 [PATCH v1 2/3] staging: media: ipu3: Return buffers outside of
 [PATCH v1 3/3] staging: media: ipu3: Stop streaming in inverse order

