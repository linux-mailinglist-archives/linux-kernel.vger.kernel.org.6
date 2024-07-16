Return-Path: <linux-kernel+bounces-254294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFA933185
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EAC1F25315
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FF1ABCBF;
	Tue, 16 Jul 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0+rNVyF"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18591AB913;
	Tue, 16 Jul 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156359; cv=none; b=GVxD8ZFcdI0df2wosBOxmWT5CRt4SHALPYYXFXYpcAuJF3C/WwBYeSv77QX/ebCM1V1CJAgi2TqJnrJRykfJer05e+kAm2HFar9YkeXuhgX1aPlXyq98TDIksUDVAaGyWpSV+vWyvMgFzvm3OtD1FM5xsfE9B9BLTR4XIdyfjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156359; c=relaxed/simple;
	bh=a9VDp0JxfwFaUs6P03HBzP4MVDWbWcJdL6+oQY7SWZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaMmFGOcpWxtDEip3GRqLNsl95xyw5JemVdrFerfR0IKrTRegi6ayNW/pri8EO7dWr5AObE1gea08l+yJmgto/uqj2RKWFx41faWFqvo+vc/AKFiPN3ipmGCyi3+JRsbLf8CntcKNda1pzi0ZQBywYN2znBvKgfonjDEdJ52Guk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0+rNVyF; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8076cee8607so4724739f.1;
        Tue, 16 Jul 2024 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156356; x=1721761156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNQhk3CU61T+AcfVcUeB9pjaIkKdAz26cxffCe7xJQA=;
        b=J0+rNVyFglt9pPRH4Mb4wCHZAXXbDHrsAMKTz2BNFrlS0akkasEYv3M6xOG1iIR6qq
         LAuXwDo7MGJNAU+mPjk+JJaKThiXZrIlNmEoJInfzMQNC9ixMbqlabMBWLDwDCiczn4G
         DkvqjdO/YV+RanblajbxD3GVoe/Lz7XUpOoYIlaS7OSysPwst/bph01MxUwtt61a+TwH
         U6Gbucocuo+lwKVvyLtUwSCbF5ZojX9/UQHnTQHzNo6d2dH63aaPG4Uj+eWz4hZP9HWi
         8UOsnIVPUbvzaMF/tZQax3zfJf1dg7jQxNYEpBt0MoG2AqP0nnzm21wCaQBCN8xhcGgJ
         Ceew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156356; x=1721761156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNQhk3CU61T+AcfVcUeB9pjaIkKdAz26cxffCe7xJQA=;
        b=W8kK70BmizzrWhM3n1ohIQPSJYDro5RPoxzNF2f2rjVtBAzXlgHi1O2mGp83PgIrFB
         /NQNmq+FpA9pw8DVctIObp8D9k6w1ar9beiOHwotTfbW4nKjY3WTFEXXtwBvB3q9xzrG
         eoa198vSTK8k8x6KUM9Fg4rrqbxn8c22mTtUzYN6Va09VVctMh/l250JDJ8xUoE9R+sJ
         yDT2GFIgyIxfmV03vMuoFOBm8nc9lozoYn2mzeTiulgyN0+qmBNPiVN9r2/WwFN/b05g
         VaeK4UnpIA5X19Qw66aPOLVqajlOs/A1QZwuMpzV8Bpqf5lXdTSxGZfR2Q3w1JV5cQ9l
         j5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXYWypwU35qpeQUH4SfFYe3yRHMBC1csmcWRkp7b17NmNfwXXvu/3OYSZ4YwrGsxua9kvjZPmS6oqK5rpUXOaHP4SRZxya3HL12
X-Gm-Message-State: AOJu0YyEX+oD7MYjDamSYQsMPcTDLCPNye3kPj5aTOk3SmBIzXevqWNT
	Y1J5eNvtiuWpbXwZhFCN40kucWKhH9/e53zhzFF3jijEp941hC/xXpIeN5/h
X-Google-Smtp-Source: AGHT+IERqs2wFcp6BuPJMtdrHm6x9C6aaXku1vgcCPBJMhxnTRyvGKpPaEvovr34nmjY1Lv8JYbY2Q==
X-Received: by 2002:a05:6602:26d5:b0:806:31ee:132 with SMTP id ca18e2360f4ac-816c2eef653mr47483039f.4.1721156356447;
        Tue, 16 Jul 2024 11:59:16 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 40/54] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Tue, 16 Jul 2024 12:57:52 -0600
Message-ID: <20240716185806.1572048-41-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 1d8fa07572c5..69cb580ca9d1 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -34,6 +34,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.45.2


