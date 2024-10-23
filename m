Return-Path: <linux-kernel+bounces-378095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9559ACB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A6283F74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA81C1AA9;
	Wed, 23 Oct 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VDwdfnPg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912D1BC07E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690179; cv=none; b=QGDdj0uo3zJc0GUhbRHnVo0+dMCtR1mkhz3wvAlw1e3w8GjxZhJvvZLiBK38CawOKmq/hiT+qcrrZh3imFBvkCHtB+w71AeeZjt2WxOQIZf9c7bzD7BGDeYv+uwHRlgYEcbc83tFpn1wkcHVT2n1v08on977F3i3+rLq10xyvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690179; c=relaxed/simple;
	bh=aN7qz/p2yFFjWdhvlvJcw0UJXrJvejxwLpb3F/G3N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyk49kKP/FsyGsjXBIBBXy0gBWYZzvhns7JnZVAok8oSfWaLqaHi7psReg+gx6P+WMBpO1zAqLvFNop+euBX41g/wpobGBjbEyFn7qlDR7m7k4Q8zt1ue7BfL2gVByXpwy6J8sD7uCAlTfGxKTo+S6eAJ/HGFDqniTqB28ydVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VDwdfnPg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d495d217bso6524920f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690176; x=1730294976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=VDwdfnPgrP4gqOxubfA0SR0XDvjMs+7XYwtl1c9yHY7gsfZnudTFQ1iJhAulZhclj/
         XJkeWMrDcrym0BrwA2ajPCvTwXXnYMqV7yLZH7x0tzsFHE4K/mm8qdqbPZM9Qk0gJ2P9
         tTSNaKHrbc9xmTGdqbYToYoQsYMWm8D5xGpImxqKYQfB9xS4JTNNc2bZXkTw3wJIan75
         LmbTuouZ4KLFq/2uXnEKiFZYw5RBzwCagUQXUDUxFRDPsoIZ1IpIXsUprxrDO41gpese
         xUxCFVQYgMyl6pdP5v0PdB5YXUeKPmBmesZ3eNYJQvc4Dpaawk4SXWH9V58Mu3Sryelz
         Ogbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690176; x=1730294976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=olLbdaEC4dx2dWPuI2K4uiIwf/ZdH1jI6dp1JrWU6BVaVNMQoAuQDr+Jl0NORK1Fbe
         K+zsa/7ARENPagHt/JDelCnS73B6jOieXCIHNqK+fNqDy3pqaTjyYIxULgrYPjymslVf
         ssI3zWgxS+YUVMM2NIqOhsglcXzn6rZ6PSksdyEYA/z7D2GEjFOsKx6AXr/wTx5uYSOt
         j5FIuTxPqkkVeQZoMF8h/aQazwC7ECMe3ymVNbP+O6zLBlxFy0Kfky25CkAx/PC0rWiI
         DxX40L10diaUxFLtHPnNIjSs+5ysAKM4jQWXx67BV2Uh54+gQdn+/n9Vcwd+LDd8fejj
         ykPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV123GDAIDIOFa0kd1bWl5qOPm/PGeygtRxLajXiokRynvlIyQ7FDUuTfDsYMWv5UJL5zn2rMYbCVXgk/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzrk+EbCm3e20JKOLh63pS4G7Air2uoigAQYND4i9y6mf6Hat
	u6AOvXChExIqZR6UZ1ietaqDBrhtPOKR/InPcaji5cw0wK1IlkAeH5HPtP3rWhg=
X-Google-Smtp-Source: AGHT+IHqZNaihzROUm5dl1UtiJlMamDilk3Qqw2uaiF6gCH1kBkI4rqjSi2iek7CuoB3F2rkvDG/wA==
X-Received: by 2002:a5d:4e8e:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-37efcf9308cmr1948521f8f.59.1729690175878;
        Wed, 23 Oct 2024 06:29:35 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 35/37] bloblist: Fix use of uninitialized variable
Date: Wed, 23 Oct 2024 15:20:18 +0200
Message-ID: <20241023132116.970117-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2


