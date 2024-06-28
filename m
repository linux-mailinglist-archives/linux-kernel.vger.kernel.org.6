Return-Path: <linux-kernel+bounces-233763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716391BCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680A9282E40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1D155747;
	Fri, 28 Jun 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8pAmTUF"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A67FF;
	Fri, 28 Jun 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571591; cv=none; b=c94e99fRWlbdSX8YEGc4+fS19civWj2HjbbZDZ4aJiMe7/nFX4NXSrjoIFXizgpdbaVT1JlKysS+K2c+l39O6f+s9+Hzfpa8u35GjLbCXWhdw9WcrNq6kgub4/AeK+ue9PCfIl/+6wudMRDpthcGE8+I1ZIxpD/BLO2rXFk4ZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571591; c=relaxed/simple;
	bh=c6QoyFA9ADx1gLHzH0Fs1PQsrqu8LB1FKRLPrvNXZbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1MBCb7LO2W9odB+I3bw+0D2kAqWLWHMND7dgkC8qKgoxE5lZPC8ws3JGXUQI+IAzY7LuJAghfjMwMq7Uni4ccubX/kO76/GtGRzaHwzkwyrGnN/Wbh7DVoEI/5i5sWb2vogfa3kuiJ/M8t93wODkAGjzt2hQEM+T7zXyHFkPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8pAmTUF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso295843a12.3;
        Fri, 28 Jun 2024 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719571589; x=1720176389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYBiaqmHhwOqCZ7OFoximhfKm+TupOADl4NgyIMy5+s=;
        b=W8pAmTUFv31uw7sOA5pFPUHvQO+iv0wPymSaMXDqSniC16wVNLKESye5AaRR6fPmBu
         fTbZFTkHsHRbZftftWtb7z34nv1wYy7abAF8fyLirbTtFwgMI9+2aEElOJXZm2rHJn9E
         taAvEePMYKkZYRVxZyFO4kQxGfFHEto6AcNvEtX+gmYEc4ermsbimtqW5h0NaIClIcsJ
         1VKmRLFj7UwGjBq6E09aHzqKMvWMEez2yGkIcvh7jbiAKwqVn4pQxH9kUW6DAI/EMuVl
         CygEoxv4aPfDqjxaoQb6EoE+Dtm5eP3OWPJ54L4N+VqLUiokbXDDhev343VXRpBZtgHk
         mjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719571589; x=1720176389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYBiaqmHhwOqCZ7OFoximhfKm+TupOADl4NgyIMy5+s=;
        b=KaN0g/ASFenrjvEzF5/gSXJKstyN3iB80A+bT8KaavgDLnI/KvbQbbY6Qrpv9TJ/IC
         N+OeNcS2N7a41ZGaLUhmup33I4kIRRLlEqEl+WRW1NmijVBfCwCEKPwTt9i3WtjzzsZT
         jvcbkgIMOb88IJdPkB6nbhhbQcjhlbEQwXHXsV+/Mx4KpOFXQPI1XlgL4EsZC37UjNtA
         2muCsAe2g7PqeCIPOfqmEIAn7olpVNBELRYlcAFaAtZ3u379c3XYY1I26J4kygZwddHR
         Q/MmeKmaGymrm+lS5hO53OgZWQIktQc9s8oGV7fRxAklgIKg5jiWpk2ccqZHPc5cdUYg
         R9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPJQM6JPARvnFzGZEgumsurQRgxj+PWMYcD124rnPMh4BrJ7hHupiCBi4JPi41S0XVrDR1di5AAhQncg1o70xk9eEzbo42a8jhj3xG1NHueRdpUUtyP2LB2pTQ3E+vw+Hoj3C3LKGJ
X-Gm-Message-State: AOJu0YzOXz9z67wDfJ8UJt/pkxYkvxFFW9KbZtmu+rbQWo+saRBdRaQV
	2KgRnb52dg++BPcMI78qHabVo1tLWxpsnpHyH6AAelzC846DPCtF
X-Google-Smtp-Source: AGHT+IGx6SuIilwAWmhuNyghVvvr/9oosciV10FkHb+UhKExkhbhWHwsGT0A9YwqLEJ90v4iJr8utA==
X-Received: by 2002:a17:90b:4f41:b0:2c9:3562:dd32 with SMTP id 98e67ed59e1d1-2c93562ddadmr134915a91.24.1719571588851;
        Fri, 28 Jun 2024 03:46:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-95-11-209.ap-northeast-1.compute.amazonaws.com. [54.95.11.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce53c01sm1295417a91.22.2024.06.28.03.46.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 03:46:28 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cppcoffee@gmail.com
Subject: [PATCH] usb: usbip: remove unnecessary cmd variable
Date: Fri, 28 Jun 2024 18:46:16 +0800
Message-Id: <20240628104616.16441-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two redundant if conditions that can be simplified to directly use pdu->u.cmd_submit.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 drivers/usb/usbip/usbip_common.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da125..74a01a265 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -568,17 +568,9 @@ static void correct_endian_ret_unlink(struct usbip_header_ret_unlink *pdu,
 
 void usbip_header_correct_endian(struct usbip_header *pdu, int send)
 {
-	__u32 cmd = 0;
-
-	if (send)
-		cmd = pdu->base.command;
-
 	correct_endian_basic(&pdu->base, send);
 
-	if (!send)
-		cmd = pdu->base.command;
-
-	switch (cmd) {
+	switch (pdu->base.command) {
 	case USBIP_CMD_SUBMIT:
 		correct_endian_cmd_submit(&pdu->u.cmd_submit, send);
 		break;
-- 
2.34.1


