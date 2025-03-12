Return-Path: <linux-kernel+bounces-557099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C1DA5D3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B2F1744E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F703182D7;
	Wed, 12 Mar 2025 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXH1yE2/"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5E1CF96
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738889; cv=none; b=it+QbjNZu8IjzfX2HyQZNRid6109ATl8zppy3IZo5SlufbeE05jLMw+1vtTB36VDaog8y3O9OOxC/Jb6sKuDvLvO9Gx16aiDQYi2fGFrY1xt/WrS/CJ+OKf0LRgMdu9v359FUpl/f2mV4bm+NAhba6WJKVGqTV2vcRSdUxxLpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738889; c=relaxed/simple;
	bh=e608xdJeqBKKdGNq0v7LWmeQ6DQjWhBH7FxgELGlglQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWO+wsBjMPSzCehm+OOCbWkz0rLrB4M02hP7DSC6bAnUeEvnnupCFycmWjB/gJmxSZBdJiq7+ad2bv3C/DhFyISOcQggp+nhUG1qqcapQisi0TUeG6ME92k8yrDej78PLNZUWatT9SHp26C33jm+XSAul69W5cZiv8s3AVaxV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CXH1yE2/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5b736b3fcso809528a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738886; x=1742343686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=CXH1yE2/Yl07OH3aRArU2m+/IjBVe/+zr9zByRPaEbjedAoCDIfGAh0DoVSWOCofmb
         a4NdZsHY6r3NhHdFvW/0bGXNQOgQWNrJcT7Z8+tp5RRoDmSXJM+z4jeZRM7DfdY6JWnr
         EahK7rbvE1eD2tdj7kNS1WzhO4SfxplcYj89w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738886; x=1742343686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5xe36OxoXeIkbizVHSnBn4NRndqdFCX6+LlkAnxrvI=;
        b=jmkwYXLLdPUn4AR2fYZLSGsBmbQfQ+NVBCW9qrqZliACesutacwW9i0hpTRMcIdM6o
         8hjiYRxDoJ7zHJxLFhDgrFmJpUCOYu1nkWbJlqMv2L4Wa8td0QqniX74i88gKvDbYXPj
         /epG35+DEqEXWY0qv15baEp4GAihOBDSScRq79kQNc4TEIW4YG5gx+VD4Tr+87qhb/jL
         bi1kNAdkvGEOiAJJVwAyB9dMzaC9sUeTQx8zZ4cHT83b36QN2H0wRtrH8MtjGaEpFTqD
         7+9TY1sL+NWxoHuuRtDGEVlPplmWwsTbL/2qlyxuFyqxjUadzLxkZza6g59uJaqM3Xlb
         SR4Q==
X-Gm-Message-State: AOJu0YxmecCr61jkpALu0fPUELgltW+gz6GzkH9MRIpxnaf1bq/lYmv9
	0svLCnwycm5rJOfrlyXJIO+IvgaKp6YInTQ0Qym6T/QU6SZxDJUlyK12Hw8QMQ==
X-Gm-Gg: ASbGncuoLjjxnn2nHNQSWwvnqAFTHssaCFU1nQbtt13f6ey0vazTarEOoQKQ7eL9s1c
	tJtUvQXl1b70mokLMZxbPEzqsHJOapHj/BCYc52TbAA9yrR1nHjBqWCOaysacKOdWc9JBJGce69
	nfk7izX+8r2GGTHhXXOviDsxqdOsfx4RFGUhy3X7yPfGcYu20MTGOlVmBbChh4l81lCMSQUcHbi
	7pQblB8y0BndJmUZX6i9YFBzUbomLFWnL7yRYesaKP4nbI8XuYoxa3XxTW8/PDE6YwpYQpnEdAa
	q0ayixy/UotoEksPFmWUlFyHn1XsZsIT6RNR5l/PB0KMhP+lxRtMJpt4/0jO9usEGYel29jexz7
	o
X-Google-Smtp-Source: AGHT+IHtp8ouTXVsgTp2SJJgz2rGEBY4ebI7QJXVPc63NR9EJfuX37UqlqudFu1bAKoYDI0sugwhXA==
X-Received: by 2002:a17:907:6ea1:b0:abf:6b30:7a83 with SMTP id a640c23a62f3a-ac2b9ef11e6mr297381266b.13.1741738886472;
        Tue, 11 Mar 2025 17:21:26 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:25 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Date: Wed, 12 Mar 2025 00:21:17 +0000
Message-ID: <20250312002117.2556240-3-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312002117.2556240-1-jeffxu@google.com>
References: <20250312002117.2556240-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Initially, when mseal was introduced in 6.10, semantically, when a VMA
within the specified address range is sealed, the mprotect will be rejected,
leaving all of VMA unmodified. However, adding an extra loop to check the mseal
flag for every VMA slows things down a bit, therefore in 6.12, this issue was
solved by removing can_modify_mm and checking each VMA’s mseal flag directly
without an extra loop [1]. This is a semantic change, i.e. partial update is
allowed, VMAs can be updated until a sealed VMA is found.

The new semantic also means, we could allow mprotect on a sealed VMA if the new
attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
impacts for applications that want to seal a particular mapping. Doing this also
has no security impact.

[1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mprotect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2c..a24d23967aa5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
-	if (!can_modify_vma(vma))
-		return -EPERM;
-
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
 	}
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	/*
 	 * Do PROT_NONE PFN permission checks here when we can still
 	 * bail out without undoing a lot of state. This is a rather
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


