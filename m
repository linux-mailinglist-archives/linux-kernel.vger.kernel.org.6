Return-Path: <linux-kernel+bounces-213479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D59075D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7EB1F24EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A14148858;
	Thu, 13 Jun 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoLv6s6P"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CC1487E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290646; cv=none; b=ee0FKU83tQTzH+RuJ+sAtt2S7bpTmXP9EISkiJ+XRI11GP3Tbd3HKVWsBMDHcLeaG4UVqoldX2Tp4zP71pSNai36Hq4xEgeLgoMveMGsjx/vbPkeAdqvaBCYUJr3jTGjVK56SngFsrnaXD98459VC+FWoNloOcwNQuBRUWP2lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290646; c=relaxed/simple;
	bh=ztEBEYUvN8W9C3s9grN7UDSArbz1+K1DMUkWy5CfjbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gUKjI0JeLGH+kkn2hiIweNzK2oowB1C5eMOL7yaOmRuxhuhRGe7BTs4NwpbdwQqCfLbwcjXtuCYG3QmhBNQPK9ERD97b1aQGZIf8a7i3YTQkiBhfveLo/DRAsvvdVUkeXbpcRjitdAhHmwvyDZ62R22VyVDNt2du00i1PQmlWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoLv6s6P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f24fabb81so1080454f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718290642; x=1718895442; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdtYNgy1Eoag48EtdY4innsDV2xuYmsi6ZNPkKm7vAw=;
        b=hoLv6s6PJVpwASjzG4WSBgdCwIfaZN0ywWvQkSUxHhBQJM+I/3ifz5NvyHmFZaQrKC
         6pdDe7sPaZhXG9D+cCR32EoqJfc/wWcayrqiuapgCiSVv30AhbnA2jcnCjcEPj9Qp4Dd
         arcIzCNP63daohCvrqxhPkc5/7RRvE7cWmzSeWt+YWwCZ1voT1TbxfB18qu0ysGoEnqz
         NOy4as2tLbVnlmMgd/493HgUF07eo1VrHbKunv42lE2iPtLDnm3JGj9yjfi5NJcOrwga
         uBHggJiMcgKk0MNkkXP2Y4kqBuZMvyL6R2MlE2GfhvVDAn77RMPhYGpu5RBwVTUDOu17
         PoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290642; x=1718895442;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdtYNgy1Eoag48EtdY4innsDV2xuYmsi6ZNPkKm7vAw=;
        b=a/V6Edpby0xebF4jXq+FbtHUhOQ2wuy+VAfKTfxlqzWjm1HC/2iKCmP5nPsqDqry/D
         oR7dJh1hlvf4CwlqJZ1KNLRHWr3/tSljC9KevaU+tCOo4kCdmoRVYOMrjiQkA1+sz4PT
         JSHZr6YPAxqrvzzEo4b4W5rgClxJD2DlyyGLUmzCxMFOTv2YF+UuOEE3WzoOswJkVQxH
         Ip9aUYPrMd+jLpB34WdDghA4yYBdtd336iF6okiviui4vYBudSfdwcORmjTipHqRjeuQ
         YzVTTHllABxjm/zc3l+JZydOPcAVc4TMfjb3+rUvDml1gMQcd4S7QvgRmTfAAk87Uuqg
         1ktA==
X-Forwarded-Encrypted: i=1; AJvYcCWMaDRVflEOzO4BuaxRiByTK6T8tmC01V1883havdggg/oqaSE7uCacnHSDt7Wt7Oe6q/qx1ZTCcZQ2BzgwEU80nnbt44gIHpVyvWq9
X-Gm-Message-State: AOJu0Yx7RV1G/czBw1wgEZk+I1GyiMT5XkqLeP99TZSi9I3yVRrXGK/5
	+sL0j/dQP2GVaRLAuNXw84IvpH9GfnblAbyLIzBRClbbU8cTdEY9w3JIo1o9YO9W5uRtEloG3Wp
	Q
X-Google-Smtp-Source: AGHT+IGMM5bbKSiWJ9MgOPUnHS7fxvtm6uc1tX3KL/EFOXy9L0LkLo2crOP/bMRoJVvj1JYSHaoMAQ==
X-Received: by 2002:a5d:6248:0:b0:35f:122d:a589 with SMTP id ffacd0b85a97d-35fe1c0a0acmr3372578f8f.40.1718290642153;
        Thu, 13 Jun 2024 07:57:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d78sm28715485e9.25.2024.06.13.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:57:21 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:57:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Sibi Sankar <quic_sibis@quicinc.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Add mailing list for SCMI drivers
Message-ID: <a9706e17-09ad-4304-828d-c0987befc8f7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We have created a new mailing list specific to SCMI. Add it to the
MAINTAINERS file.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Sudeep, this would normally go through your tree I believe?

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e04f583780c5..71301cd51359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21885,6 +21885,7 @@ F:	drivers/mfd/syscon.c
 SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
 M:	Sudeep Holla <sudeep.holla@arm.com>
 R:	Cristian Marussi <cristian.marussi@arm.com>
+L:	arm-scmi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/arm,sc[mp]i.yaml
-- 
2.43.0


