Return-Path: <linux-kernel+bounces-210913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00B5904A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C539281731
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC863770D;
	Wed, 12 Jun 2024 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af+vj6BW"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE22C697;
	Wed, 12 Jun 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166913; cv=none; b=ZuwWALIrAIsHZMQdSbFc4H70G5ios1zVr1/e6ClLwMOaT71xxA4cU66ftmys1/wE93Phme7apqqM+nyJ0jshiY9vbuyWi8pylwKdHkZeCAsKg//2U1b5mVf/a9YWERamyw+l/yeph92BEOqs03WYM0xyvQh2Hps0eqZYxR27P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166913; c=relaxed/simple;
	bh=ue26OFhLv6t999/EBCasyGcLCXckFy5Jpdpv06rKJCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGTQBr6plde5noO278VwJ0J3m7P2Lobgz1VfnBj2OgtBI6qMfhkiX5iKTwdHxGWFRGKNBBYeyGXC2piTDOBAazMhtKw6U0F/1AGUumdW6PSMX6ufStTm5Ov9lS/0pfuDWX2+qg0VX+Z8ll1O/P06PLO0SXXGA4V0u1+xNk7MibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af+vj6BW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f980c89db8so2054358a34.1;
        Tue, 11 Jun 2024 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718166911; x=1718771711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBAtrRw3IsjVN4466JhOY7FCejNziv5PE0AxDPMJel4=;
        b=Af+vj6BWjOTqzrDpE6qVJXrdXZhuZcjIzne4gCIc4cQmzrbF14Cd34wkbqlyFDz6+V
         QFaGAu+p6OOJGzJTLX8huPjh2UJNpUYrZs8TzW7twU3QkgBy1swAa/DQFJeVBmI3uH9X
         Ndossblgcij+D6hnm+WGuTzqQ81L9xFdJsaY9JTKEEOS5P7TWgZBXoiHsHpecv9/XrdL
         gDGCO2KEWM3nH6zvPpihUlo4uN0sENlkFs2o0TxdarRcTH9Lj35QGdhkrMQ9spae9g+q
         XAaTI8mAPtvW4lCvJioDAso+ddR8j7QezIV72eDC8ozq/JpMHDZQEjC2xCDj6RW+nwa1
         JkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166911; x=1718771711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBAtrRw3IsjVN4466JhOY7FCejNziv5PE0AxDPMJel4=;
        b=VBTHjGTc103+r/dNQ0d/UmTkFoUvaWyKFbVlR5Ba+4iyYqc4hfiD10UOjn+1AL/7dA
         azq7/V0UfXPz86qq/GquhVB1lmO9XmnvuGtSV0ipjaH5VAbMKRFjusnSuoSokSBkQkpB
         zJT4AMQNNhxmou8yCgDFi6iAVZb1KNGz5sAXugg+Xh48rU3UTStNqQxBmM/0NEVGMo5/
         4yIFjyr3qsifhRdppNRIz4TvPJGntgkWP1aCYuK34wk2vEJThfvQcl66NJRxF32VlP24
         1oIoQSTSBvROLz+tvvc1H2PJaCDeZ0sSDql+d1Tk2yCqaTdkw+71zlT5Pd07fiNRP75q
         tguA==
X-Forwarded-Encrypted: i=1; AJvYcCWhAujZ6D+vDltTpl821Azxf+M7yE1phUQubsrrCnS9XJuuTukrfX03RcoCl2/1/iutMpUh1x/ToYwCAzvoNyRfpF63URW44pqI//7OU5siuTZ+ROuzlHIlWYbROmSlltY9DN37iNvtUw==
X-Gm-Message-State: AOJu0YzK4HMZQl7gnXO/2ftS1Gju4Jj2bQZsId2sPTuWfFq3SvAI0HkT
	4iqD3YYy3JQUxYj5XFRkQ9J/QjSFc2IDsoJT8akSq4PtDwl/q6CU
X-Google-Smtp-Source: AGHT+IEkBZAViksldFhdGgOs9b8r6qLPy8cm7BY0Le7mrdkX1xXzmFBIocpy1+EtnriZdKxr01utIg==
X-Received: by 2002:a9d:64cd:0:b0:6f9:60e4:5312 with SMTP id 46e09a7af769-6fa1bf86359mr721799a34.21.1718166910686;
        Tue, 11 Jun 2024 21:35:10 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de276061e3sm9021275a12.80.2024.06.11.21.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:35:10 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Corey Minyard <minyard@acm.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quan Nguyen <quan@os.amperecomputing.com>
Cc: openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrick Williams <patrick@stwcx.xyz>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/2] ipmi: ssif_bmc: support skipping ARM SBMR bootprogress response
Date: Wed, 12 Jun 2024 12:32:55 +0800
Message-Id: <20240612043255.1849007-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
References: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In ARM SBMR document, the host can chosse to not read back the response of
“Send Boot Progress Code” command.

To avoid SSIF being in a wrong state due to host not read back the
response, add the implementation of "arm-sbmr,skip-bootprogress-response"
property for skipping the response of "Send Boot Progress Code" command
from userspace.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/char/ipmi/ssif_bmc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index 56346fb328727..3386a8bd18afd 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -39,6 +39,11 @@
 #define SSIF_IPMI_MULTIPART_READ_START          0x3
 #define SSIF_IPMI_MULTIPART_READ_MIDDLE         0x9
 
+#define GET_NETFN(netfn_lun)                    ((netfn_lun >> 2) & 0xfe)
+#define IPMI_GROUP_EXT_NETFN                    0x2C
+#define IPMI_SBMR_GROUP                         0xAE
+#define IPMI_SBMR_BOOTPROGRESS_CMD              0x02
+
 /*
  * IPMI 2.0 Spec, section 12.7 SSIF Timing,
  * Request-to-Response Time is T6max(250ms) - T1max(20ms) - 3ms = 227ms
@@ -102,6 +107,8 @@ struct ssif_bmc_ctx {
 	struct ssif_part_buffer part_buf;
 	struct ipmi_ssif_msg    response;
 	struct ipmi_ssif_msg    request;
+	/* Flag to skip response of Send Boot Progress Code */
+	bool                    skip_bootprogress_resp;
 };
 
 static inline struct ssif_bmc_ctx *to_ssif_bmc(struct file *file)
@@ -187,6 +194,20 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 		return -EINVAL;
 
 	spin_lock_irqsave(&ssif_bmc->lock, flags);
+	if (ssif_bmc->skip_bootprogress_resp &&
+	    GET_NETFN(msg.payload[0]) == IPMI_GROUP_EXT_NETFN &&
+	    msg.payload[1] == IPMI_SBMR_BOOTPROGRESS_CMD &&
+	    msg.payload[3] == IPMI_SBMR_GROUP) {
+		if (ssif_bmc->response_timer_inited) {
+			del_timer(&ssif_bmc->response_timer);
+			ssif_bmc->response_timer_inited = false;
+		}
+		ssif_bmc->busy = false;
+		memset(&ssif_bmc->request, 0, sizeof(struct ipmi_ssif_msg));
+		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
+		return count;
+	}
+
 	while (ssif_bmc->response_in_progress) {
 		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
 		if (file->f_flags & O_NONBLOCK)
@@ -806,6 +827,10 @@ static int ssif_bmc_probe(struct i2c_client *client)
 	if (!ssif_bmc)
 		return -ENOMEM;
 
+	if (of_property_read_bool(client->dev.of_node,
+				  "arm-sbmr,skip-bootprogress-response"))
+		ssif_bmc->skip_bootprogress_resp = true;
+
 	spin_lock_init(&ssif_bmc->lock);
 
 	init_waitqueue_head(&ssif_bmc->wait_queue);
-- 
2.31.1


