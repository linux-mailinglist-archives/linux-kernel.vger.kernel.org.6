Return-Path: <linux-kernel+bounces-364120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A391299CB55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD03B26779
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833D1C303A;
	Mon, 14 Oct 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Y3qjK5Nd"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44C1C3022
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911594; cv=none; b=Vi1FEXuGe+/9dfgS8f7czrEeui9KtuZ7hPrJ0S+g3jr9GkW1iGi+C2cx4OhezkyMD+yW5EietgeOiA7Sh8PBwJXXLah9fTVJrNACXQxc5lFWU3YZgUc7nk2uSipsrpM36XncNa1/2iHu7ntDPyNqZKslzurKS7swYg9T07PIf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911594; c=relaxed/simple;
	bh=aN7qz/p2yFFjWdhvlvJcw0UJXrJvejxwLpb3F/G3N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL8lKJ+qN+DegoX8W2CkMZuaLPDNorYya6bCXyPVDxUGFiPM6wnxdUFAE6hi3LsvAe5L3uwwLBsMkVBm1NvznhlpxEDwOz4GA37JxJkdrDZIUfSkp9AVp0i7syOMR/Y3hULH64dMzwh8QLJ6fUSvYgg0P4p6pRq7spbeYg8NouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Y3qjK5Nd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so41569825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911591; x=1729516391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=Y3qjK5Ndi/rnZTcQ5KRPfcLbwYzXIlqACZT8il93X6JlB5R1H5NwIz3ulweibpKT19
         NhYQyqpDrcGrLNxbGHCH95MX9sEDbUnPFS65NbBvDWNIg+vLUkRNprNU1uRYdURBHLW9
         Rtnd45FaPFluiDa40GyqBbuk3JGfSO3IdNdqm7LB1STYRyGc6d9DDLi9XdSvj8fhATL+
         H5lr1H58YPOG9a/G3panvXbTpQcBbJavArc8AZSBvB05F+kTv4XMB4/C9aXTw/1+W05j
         OoJ7DEdXjDTuErrtNHjQ6VDrziDm0AIrYQqxH0vbYIsH6nADUgLM1YhiiJz0x9hha0hI
         I0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911591; x=1729516391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=XJxgpdQM7iPqgjZUHZdqsboI7vxs0zO+ZyTP8lxybsiUGaxrJh6FaLVVZMAg2qDkYz
         gi/9FLS7NW9B0ViMLy7qEMIDL1qjG65g5dFWx83j8rsWHEpV3eS5XRMLWGgz3Za8nUfy
         kRbe8L5OU7hYwZqCyw9jJdSAq2pWgZjJ719AWuN2bHrSCvlzeG1LkiU33ykbDcid+N57
         zjOXiG5m+QYZtn0e0WGMrqyeWIn2JzrLcnZz1PLq3fUK59b1mneWfCqYZjzQUQj66sGt
         l5VDFGLA37tuVT3HZUffs7oAwlZW5bfv2JvFfFqHhtjrRtNqpHYzPAFHEhsOCeC9HlOw
         LGDg==
X-Forwarded-Encrypted: i=1; AJvYcCVf/o40oNTucnKnLiRuM7ASj1UfwiKo/msx5fzIHKubhw55dR102u5EI91Wst6sGydwPKIhG1zmrGYJqgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ABRwz+Mfr9o/dxvlXBFFAb8a4QpFgQoa7SfDqur23oSwS+ds
	EIrJ6SKJf62M2JeFC+IjFAI0kKhKVBPKKRtPrjvwpKKIbRFQCL0Qi0ih4vZWfd0=
X-Google-Smtp-Source: AGHT+IHOoYlvcJQ1pnE65pzpw5C0GkcYdH9az4L45bbIkQ5nmWMsFzKU2Vv84I9vMO9ZCIXC0xd/FQ==
X-Received: by 2002:a05:600c:3588:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-4311ded3f5fmr110753755e9.13.1728911591199;
        Mon, 14 Oct 2024 06:13:11 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:13:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 35/37] bloblist: Fix use of uninitialized variable
Date: Mon, 14 Oct 2024 15:10:51 +0200
Message-ID: <20241014131152.267405-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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


