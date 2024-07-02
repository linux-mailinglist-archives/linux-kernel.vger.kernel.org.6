Return-Path: <linux-kernel+bounces-237228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B124291EDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E162F1C22FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F22171BA;
	Tue,  2 Jul 2024 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekDsvfGk"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF814293
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893545; cv=none; b=bMnvdPJBIoSr+nAdBxZdjc0Lcz2jD+zEVd1G+MlCDG7F+ybmcNTKnFc/XGt2wkKkx06snTljWdxHu6L8+2SHZUGUODVU/k/8H9dykVrIRRQBRw8d3SSfPPs2UE/2Xl+itj01ERlKAfBm5wbsXVJB0AcpFxdT+rK36VSby9106wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893545; c=relaxed/simple;
	bh=ndND2X9vnV96MeAItWUYFsizr8uVKuVfd+fe4A3XHG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CaCXUfp/qoHP2puolDgN5V8A54q/yPmA6r2eowTdDhgs8S0Ad+BNeovWFWeRhxVA7zXfPkPo3/Gk6hVjfohhWyS1p+sK1zgc2SKCiYAVZ/y3S5fe/GOTBjitd/MKgupvTxJn3jRi/yjoq2JeJPjg9OehD4hzjmYeDS788K9Kozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekDsvfGk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso2175362a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719893542; x=1720498342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtBevkzdVcZvkprNbpCyepGhlW/xh6/7OZ0Nvs7yDQ0=;
        b=ekDsvfGkwL0OJfWXzy3APWP8/iFPNLbk7FXCIvxHfxfYyCfn/gq2fl9+1Ou1XyLcrv
         sjVXP8BpBRKrCDkwXqSbWSBSY5NqT+DdFwrHW2ihgaVnDnoyzrNiNXWxoCROLtl0U2mr
         /i7TFiqJA6si0I9kndpHojW4IsgXvn5nW3uH8PG05RRuMnK04iU/7pmEZQ3gpm8Eo8r6
         E+zrO4g6rL8yEDm8uVqJT+7kIziyQXBS/On1cZYggNbvg4L3sN/6ksIle4Eq8GhL45vA
         rXuO7/a/Ob9vP8LwUySq0WQMYnF/QlqGFi9IvmTvhtX4aM/l6yogD23AkmjiZOHBmzGx
         wRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719893542; x=1720498342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtBevkzdVcZvkprNbpCyepGhlW/xh6/7OZ0Nvs7yDQ0=;
        b=edBnsyxlGHi4Rjc3s9YzLeADYsVpJJc1zyyFIoykcZiBxVj+V3BrNQdYS/yUHPThWF
         n/yJ37Q64GT3L4CUdiWAYm+lTHerEW4CnVGdZt48kd/BvawN3MESkdIsJQgJWoU4OLmK
         qlkwNTX+qP4hD2cCC6DpLKsi37w3AYNUxTcGrMGC9Rrcg2Y3KCuKhsm+MO9xryqJxuBq
         hWWHSbrtBBrqXRfeFIkUlZ3XcarQ3MRkRCqt9KO+E6oeqgj/RgqRf9C1W/a8Pg3G92RT
         H6fnHjx5liR5dT8zRpW24ad1KJQiJghMHoZ+ttiEk/VMsK9ncZNtkr90QlHTXgIzG+ut
         HFPg==
X-Gm-Message-State: AOJu0YwJJuXkPss5I///0uN0kjMSce+2X3Lk88AvYSW37gVK3h4hyV3u
	QlG3UuKTKsDwTvC49HnUG8eDGIqOgImVOBTaFrU2k/8xt8PjX3mONXVrDQ==
X-Google-Smtp-Source: AGHT+IHWe8udlmSFgVceoXK70wRCR5cNgwV11GWDL1uB78Dydo8HPExOmn/JD2336v7nZWan18U+UA==
X-Received: by 2002:a17:90b:35d0:b0:2c9:371c:ea9 with SMTP id 98e67ed59e1d1-2c93d708d52mr4797609a91.21.1719893542329;
        Mon, 01 Jul 2024 21:12:22 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce43303sm7642295a91.17.2024.07.01.21.12.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2024 21:12:21 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] workqueue: Simple fix and cleanup for exclusive cpumasks
Date: Tue,  2 Jul 2024 12:14:54 +0800
Message-Id: <20240702041456.629328-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Simple fix and cleanup for the commit fe28f631fa94("workqueue:
Add workqueue_unbound_exclude_cpumask() to exclude CPUs from
wq_unbound_cpumask")

Lai Jiangshan (2):
  workqueue: Update cpumasks after only applying it successfully
  workqueue: Simplify goto statement

Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>

 kernel/workqueue.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.19.1.6.gb485710b


