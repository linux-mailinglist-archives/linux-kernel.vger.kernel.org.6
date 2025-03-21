Return-Path: <linux-kernel+bounces-571743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631EA6C1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FC3AFB06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4322E3E8;
	Fri, 21 Mar 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwVfVYWZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F11DE884
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578654; cv=none; b=rJ7ukeTGO6MkL2xP0mjejkM0CjYRJglDQZBm3SU7MaFyLN+G3tD4EQsB6BVCotPKBIcIALg1irV8GTP1d5uzWEzJEpr6TDCPPuV1dZEHpWPvQx2IccYxsV0IP4Jl34SQlpp7G9nVajQJ9Gfc6G1TrTtcUoAWfLLGmoDSPhxWGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578654; c=relaxed/simple;
	bh=kuDJiYrASrg17oWfxRa+UXDWPQLL2nZttWFPUbMBMvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XqVVOcC936xjst5I9g3jwik1NPPg3y+j/3BsFvebsITjq2om3mlhi9iY2eSMJ+P6ly5fBJYfox/0zIqTvUgozJsCQbHp8A8dcY15nsP6lbcSiBD3EQo0gvd4JC+cNoAmOxjXgZUtIKmht9tWq4utfTUfc86jZUvDwluDyfQdLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwVfVYWZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so3588076a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578652; x=1743183452; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIY5k7jRtzkaMHM23LwZQbgKSFYkNE5bEn5Jv/DROwA=;
        b=bwVfVYWZld82RLb9KSCkzCzGsQIpCRz7+nuaKdun/GjTxSkCliraxDqsyioHhbYpfk
         9A83zA04UZQJVq2UlWQxn6OmgE/ChsZK1m+PcuIEYan0Tqic+u3tL6JGOGtkQeBgpuv3
         xea7o30qENE1j1B29tPfOMrE3orCNcEFd1MKHS+pyb2zo2GLuTnET4GKoItq248WSh31
         ZfTY6bQCqLXRrh9UIX0QGN4u+ShbXEeG9kTTVs6eHFomH/6Ko/CIDskwapDmDwxsOwmq
         m+sfAXaZ+lEv9vWNH5E8sFZQakJsFCP+Z/GO4mQaI+p0wvG5k34rej0IY5boijTZQ+4b
         ciug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578652; x=1743183452;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIY5k7jRtzkaMHM23LwZQbgKSFYkNE5bEn5Jv/DROwA=;
        b=s6GL7Ubhky+Ji6lCaV+LKQ8amBh9twd7JzJC0CnKYMMk4Ee+TnKl7aVNTuNTTHSzlE
         YAtu7s2ql83+VXYLefUxvA55kZ4QgMxhBX7X8TR8qFz/18sgVi/UbchS/AqZIIeiGUp3
         D8AEGSeN4MEv3Qn/PLHs/rQRJiSdT5GYlJVoT/Xvy7oLTkMd0xC0hJPQp7Ey1b7zMDcS
         3BskvKCWpjLyLAn9S9zjYNVA+SLfDpd8rGkYbbNQsHf2KVbzDYnyro1TQZm0hk80LIB7
         DdhD3098XUSPYRV+nCdUo+3wtSkGrSzs5WV777iyYFVLldsAjHBiDMv2N8/0+oxUXFCm
         8DLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2kHUr9GdI4+mUjuZBTeIUuA5/6c0UZiP6zHsP8zrfoDB4vNuVrzCz2R0gzBRM7rsxyzjDLqz3LqQkPaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFht4VQ8ZdICvyj6A84f2ZcodByq0cLEwa4OGf7kkALdWlSGKd
	moiEwNcnGk8KXZhhn8v8DC3vyeTp/+r3z2QTuY90Dp8qg6ThyrmKPQuRcZ2PK2YdkQa13ZmPoYK
	MrTLY+OMfKL1clzXDfHIh/Q==
X-Google-Smtp-Source: AGHT+IE7r52beD3Ab1/77IHPkao7u16u+m0qxZHCccy5P9AkxUY4reihApSQ91Wq7XViRQXL1VyGvF83vZYuIuNbfw==
X-Received: from pjj14.prod.google.com ([2002:a17:90b:554e:b0:2f5:63a:4513])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2707:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3030fefe3e4mr6880939a91.29.1742578652393;
 Fri, 21 Mar 2025 10:37:32 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:24 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-2-souravpanda@google.com>
Subject: [RFC PATCH 1/6] mm: introduce SELECTIVE_KSM KConfig
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Gate the partitioned and synchronous features of SELECTIVE_KSM behind
a KConfig. This shall prevent vanilla KSM's background thread from
stepping over SELECTIVE_KSM.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 mm/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..f9873002414c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -783,6 +783,17 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config SELECTIVE_KSM
+	bool "Enable Selective KSM for page merging"
+	depends on KSM
+	help
+	  Enable Synchronous and Partitioned KSM for page merging. There is
+	  no background scanning. Instead, userspace specifies the pid
+	  and address range to have merged. The partitioning aspect divides
+	  the merge space into security domains. Merging of pages only takes
+	  place within a partition, improving security. Furthermore, trees
+	  in each partitioning becomes smaller, improving CPU efficiency.
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
-- 
2.49.0.395.g12beb8f557-goog


