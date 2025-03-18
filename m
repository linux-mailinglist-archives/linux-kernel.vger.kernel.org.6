Return-Path: <linux-kernel+bounces-565492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30EA6697D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1F19A07AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4988F1D90C5;
	Tue, 18 Mar 2025 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMsoR/SP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958C1CD214
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276214; cv=none; b=Saec2aGbzqJ5wL89ra1EYH0lgKdDbaPsZDh5spABgzZoRAERYyXbGr6zFGE9oUvL3f0VCakoai79UhJQeHy8cdCYqvSOd/hJh2MeHR/aZVtqX9qkbhQIxOBrMHDZ5IuJ7iVasPFYzaCj1gLBWvfTzyyTYmBx9YKobm3Y78219j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276214; c=relaxed/simple;
	bh=2LA+Y8RVFhP75zD1DZGhcUh4uKDs+UbDTmTf+Wc1f5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrcEUd+AJuOQ9Ec20gmVcUBdwk265Vs9O67D3O6uxHRqv2udo6mr9z6i4Iik0QQaSMUQb7hx2ZrNaIKiD37Xy69XoKTEOLPhkhQ6y2CjF8AqFqCsrc1YiUYP3UFbfqvIIfPQKI/5SU42fImuznowWeIsTiYp96SS9DqcFz7y2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMsoR/SP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225a28a511eso86561425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276212; x=1742881012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rhPbDd0rp/+eHjWfo/oyKCU6wF9P8ggGmtlZyVMevo=;
        b=QMsoR/SPkdmOeuOlkWQA37men82uRH++JogTkwFvc3Zv+28R0HcoCY0DZZNJvTQxCL
         W/IBiDXcVJ6tN/oXi+cFSrVw2lZlBwW9lHH1xv/eHP9GRQxDdOedeQjFuyfEu5of9lny
         85u6+JCJVEqgaBcr081prMkJwL9tNidny+fu+dhieEwM13pry2EBq2E1gHvDW5BPbsiV
         lohyOfDUyzNRz88uyEgGZZf4ztuN9SJakHikQFopmNana6svv95zcLyUXhccmLBIS5pO
         86Lrtbp1Nw+B8SFxQzPC8D/7WINXMwQ+5+01WRtVr+gqeghsX2K6tq6BWkQusUuU5mp7
         Db0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276212; x=1742881012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rhPbDd0rp/+eHjWfo/oyKCU6wF9P8ggGmtlZyVMevo=;
        b=OjBXIxlPt318ElT1ligW4pfq8li01ml6APFXVYpYz/tlaV4i81eY2YByy222eWzAuO
         QJKs4e5JsN2PnCAb0cmUmsM50bYtpeenf3xWpOf6vjj8Fkq4tcFV2Gj/VIZKh//+aYUo
         nFL5H82ev9hJ8A3wGODJJEyPcEMc41c9IHAVKZArwedEIBPreGykuzf/VrgAM6FJrWXu
         J3dxs1k1uGuOYiP7D7ZV4QaDzV1cagXyuBWQTFXEhGcudvAM6YoEjt7Pqis+eFHZYzb9
         gc4YZyvXglj1MrnSoZZTTpVmFnVLWEmo/dg366LXEq8f4/y4IvvmTtR0aSHNQxdZPTlC
         QSSg==
X-Gm-Message-State: AOJu0YwR3an8aYZ6uvSq60Nx0fG1eX0QbTlovpmcKQOA7+Sxk9MSW3e6
	7FMvzd0kj+FvyFpI7TF2u+wT7u5JV6P3A2pbMZrnTbpn7HLev+XJvXzUHkvN
X-Gm-Gg: ASbGncsGABFVK9HC9QiADQRNJbyzE6CijCvNnpV1F19ly//iHKEG0fj2PHeHOn0CAm4
	QFlQ3wonOdtQGLeCQu5a0hU6dApzAUACYlv7P9su/w2Prp1cmQnxJ9Xu71UO/lEzcJaFO6JN86T
	R9Vx2Gz0nkvrfjgc+0lwGTu3LGrMMPQ5UmhNq0AdZCAWlDlSAYQe3jfRnvwjPUrP/PJfbi+KUNH
	sajI2JOqN01oZrKdPyVttIhjEe5a56WMBAl4Ax7JE+K7KEI1pH0Gve7vfXiPj4Cqc0EpqG3RAg9
	jSZ8/pF1BwCx7vSif/hUcCZPNwhFr4uFTd6ZVJXUWK8/nPh0AGAHAkYj8fYm8HvlzA==
X-Google-Smtp-Source: AGHT+IEQ5Xvf+rbEz83j21PmQVZJa1tTQ+KrF/RyhHQ1rBe5bD51Nx04dUVCxZ5zSSVIrBohADEJzg==
X-Received: by 2002:a17:902:ef48:b0:221:85:f384 with SMTP id d9443c01a7336-225e0a3fbc1mr197525795ad.16.1742276212613;
        Mon, 17 Mar 2025 22:36:52 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:dc02:2d2e:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f09sm85299905ad.133.2025.03.17.22.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:36:52 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	stable@kernel.org
Subject: [PATCH v2 2/3] i3c: master: svc: Use readsb helper for reading MDB
Date: Tue, 18 Mar 2025 13:36:05 +0800
Message-Id: <20250318053606.3087121-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318053606.3087121-1-yschu@nuvoton.com>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The target can send the MDB byte followed by additional data bytes.
The readl on MRDATAB reads one actual byte, but the readsl advances
the destination pointer by 4 bytes. This causes the subsequent payload
to be copied to wrong position in the destination buffer.

Cc: stable@kernel.org
Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a72ba5a7edd4..57b9dec6b5a8 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -425,7 +425,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
-		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
+		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
-- 
2.34.1


