Return-Path: <linux-kernel+bounces-379243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195F9ADBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD064283FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E07189911;
	Thu, 24 Oct 2024 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FXjCmVbA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638117DFFA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750697; cv=none; b=VFfOwvdtYcShArbaiUIEXZ8mDNAC8S/qz15sBez91SD9e5pjA1UaioMoQxc6Mw+lgF+3qDmkbPaQRmeVDIQe2OlJ9c7ap9bsfpiEXEfg+UZQW/H1ast1NPGfSKkq8qvfnP9REBW/v3127HENLv5FHqxDvbyMhQ4P5wHLMSafOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750697; c=relaxed/simple;
	bh=xvHXD7Sxf6tgti9Zh3HY02O9Z5oWaluA27USkHsd2Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhY0ev6EEC+qYkvrOcB6BraB5rdHBIqIkTwc8dKNVWL2jmxNGw4bmUTXYoE0TfohbHwytGcSFODpAp4P5tdWZlPx1cIgrxy0u92yymsujexReoh2edPOV11Yi2mqnGQoDAOOtGSXxL5dd9HLK3/K1+L5jLfIaZMJJUjYt+cCynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FXjCmVbA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cceb8d8b4so2766515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729750695; x=1730355495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0+q1MIaFTnyGhakBrCeGviCLva9CPSQoA7IMbCsTXI=;
        b=FXjCmVbAEh4eFftiP5Oibi6fi2tP2WUQQ0vmLMKBYRfo90lucOD3XEAAt1Fp4goiUx
         0LY85szTxDUxWalyaWaVJoRyfKP5nbbgpoGCAO1RDSJ/gI0bdymkABsuOsXauw7BwpBH
         pMtPwOUJvzGWk9vMwUdZnJ3fdPiNwp6vG3uow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750695; x=1730355495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0+q1MIaFTnyGhakBrCeGviCLva9CPSQoA7IMbCsTXI=;
        b=X87k9kgHt2u4kHpGh94faytMG8bSS0CaquIBdHyenrcha83pwazUooypivcAygtNXL
         2X2fNf/G4kpYgyHBraEAi2k4/fH9kEoEVgY/a59mkxE6EINDi4R1Jpj0tYe7PgrVCFT0
         y0uRqFjNA35NkSIhT4gHyh2Ug5DO3M1SNBIcqBvETz+JSQ+FYOd7e16qbqk9SMw35hIh
         WCxb+4jkKXNOoyzIH3wxoI7ROno6Y5Nt7QpryOmg0zMVV2EDLP2BGSkH2Sax93MlyQMw
         +zTWqnDn/T6IV93Q9lTDoTJXs+28WAWHSLUImguXFJMZENl/DlV4uIDvcGUyZR+aGKqG
         PI5A==
X-Forwarded-Encrypted: i=1; AJvYcCVlgn8+0Hyp3h3N5sLD3AKaYtA5iT/me1JK7R1woRRFMHozI/b38VKVNG2J0FD1z/Rq5yx+NlCK971vBTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWK/f6t6VDBEGbMxh+U5skNuq/s7ppgWJEEJ9rr59vPJHjNXfD
	1ZeGtdAcGHseDk4tZ0cLi4zQVCMNWSB/udUtc6X88riZlTzkX1/iNSWPnF+14Q==
X-Google-Smtp-Source: AGHT+IFQxFviGHeiXxtOVNTLZO+cDk9rC6vusoMFJo9C+wrYXhIN6FRh/awN02p4XAP532k2jtjZBg==
X-Received: by 2002:a17:902:c403:b0:20c:7e99:3df2 with SMTP id d9443c01a7336-20fb89bccb2mr17836175ad.23.1729750694988;
        Wed, 23 Oct 2024 23:18:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:9422:d958:f749:9a30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd561sm66418885ad.179.2024.10.23.23.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:18:14 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/2] media: venus: close() fixes
Date: Thu, 24 Oct 2024 15:16:56 +0900
Message-ID: <20241024061809.400260-1-senozhatsky@chromium.org>
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

v1->v2:
-- reworked 0002, as its v1 made no sense whatsoever
-- use synchronize_irq() (Tomasz)

Sergey Senozhatsky (2):
  media: venus: fix enc/dec destruction order
  media: venus: sync with threaded IRQ during inst destruction

 drivers/media/platform/qcom/venus/vdec.c | 19 +++++++++++++++----
 drivers/media/platform/qcom/venus/venc.c | 18 ++++++++++++++----
 2 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


