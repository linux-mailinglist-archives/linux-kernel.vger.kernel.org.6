Return-Path: <linux-kernel+bounces-569039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8DA69DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7C87B0BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A31E834E;
	Thu, 20 Mar 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trJaNCwi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED91E570B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435772; cv=none; b=CQ/+5MwsPpYU7ZKSHMAAyg0hpC9o1Z724qKDx+OrTIxxrfQlGCtu1Nd6sFGf25OO09Z/m/kPRyi6YW+lBaRzdH2Icvi1IsGfcAVMIuWR0StmWQy7fuN7KqedrBEbre7nd7qR6ixpVC4sPpMo7ow3Xdq4RgLXbzbzX9Uuy1brqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435772; c=relaxed/simple;
	bh=7oZEWfUMoqXZIdbIu3x88udCPkEeHCGdOzdraE/jqeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kHdmH1fEvYWgBRMdX9XiGs0P/y4PYSTK4Yz6rimwxL3ODXIk/ZQ9TDQtwvFA5334Tubyd6N6Ji1SMOC9lhLDYP52W3u1HfBbZhxbHt8SnMML8XZ220cO85io3ESk0ZuWccgcNtuj9rbb68FSAgI4wBjrPVh5AIWkf7wjd2aPRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trJaNCwi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22650077995so5170245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435770; x=1743040570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yL5b2WTU5WHGZETUIu4ND+tiGH8mntIZf0oxmIMUMA=;
        b=trJaNCwiCRNMJ0q8wlwQAtrfaIwhO/5YpwxIDHIB3sUkH8Ix+DviASWJIZzz3qsBxf
         mYU46vQfCs5O7ajvr1YKO16SGoUXTTMQ21hesajdv9Lkyg/bTgOy+wwrifYCiAVJ4D+v
         Giqo2X30ZPXp6g57fTSjO33Ddag7T4jiNx2Op2pLWrhfIZQzgovCIA21BuTUmFHsushj
         LbPNe8ZtdrS8WZCDs4OvPm8YV904B3d9i0af7ab3eBMdPg3by/73I2jvpg7xsECan/mT
         ZlnYBgKNXDSqur8MRz4eaTm1Gw/FLLNz0AkmiCEoQPcvlztYjemlSxh0H5tFnHDrC6IL
         MASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435770; x=1743040570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yL5b2WTU5WHGZETUIu4ND+tiGH8mntIZf0oxmIMUMA=;
        b=VVrNmbrZ5cx6UwBGvVLv8uF2AuZwMOphjICQDNS74HsWAMXgF5P0S+GNLabO0O98rc
         1Q+xuvBm8bXC98mPb6ymDZZ5refw3TEBCXNTwiWEqKx4TcUnTTPX7++OMOcEFmoG7ed3
         hPZ/TUcd0+M2FH1tF6Q7MmeWNDyEhwLJSGKF3kQMgQwAX9nIbxC5X/N/tS7hyCnbd3k0
         WfTkAPDJM7riy+7JeNqUKZnNrj+c3CUX+JeCcbrFIpI6t6pLUbwJLTLYa7nYxLfyPp7p
         3KlrqqAgDSXzIVUxXjaSgyZkJ+d6OeSbMMmgnBx2LQwAJbZXS61lwbECbsqPh3vww5aO
         NVgw==
X-Gm-Message-State: AOJu0YzRVPdx13pybkKcy6uKPioMYXUcALxHMT+isOVCoB7AEeiNGQ05
	VC5qEn/ZLHsBL0Qd1SoFyMDaVVtY3wFF8Z+47nF16cXid8b2sdT1KybmfTf0dH3JF4q8MgjesGa
	Zhy3eOD9F7L+dGHax7aWL6nRLWO21i8cEc3suGzTD4SiY3stbCDKteVjllpBU/KaE7fIBJeablD
	lZ8WLBZiVAjAk9MpGVsXZW36QgGLhZyTLQ0wWyjCx5dHpN9WxsPIjT8asTvlQ3Fw==
X-Google-Smtp-Source: AGHT+IHW15FvPpMLWn1HKaL85qfGSHpQDCxTWGFYK6N/65irCZHXzpE1wn1H8XnTV124IW6pqODmzO2IIQUyBB4r
X-Received: from pfbna11.prod.google.com ([2002:a05:6a00:3e0b:b0:730:4672:64ac])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4187:b0:736:fff2:99b with SMTP id d2e1a72fcca58-7376d6ff535mr8193650b3a.23.1742435769805;
 Wed, 19 Mar 2025 18:56:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:41 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-7-changyuanl@google.com>
Subject: [PATCH v5 06/16] hashtable: add macro HASHTABLE_INIT
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

Similar to HLIST_HEAD_INIT, HASHTABLE_INIT allows a hashtable embedded
in another structure to be initialized at compile time.

Example,

struct tree_node {
    DECLARE_HASHTABLE(properties, 4);
    DECLARE_HASHTABLE(sub_nodes, 4);
};

static struct tree_node root_node = {
    .properties = HASHTABLE_INIT(4),
    .sub_nodes = HASHTABLE_INIT(4),
};

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/hashtable.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..27e07a436e2a 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -13,13 +13,14 @@
 #include <linux/hash.h>
 #include <linux/rculist.h>
 
+#define HASHTABLE_INIT(bits) { [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+
 #define DEFINE_HASHTABLE(name, bits)						\
-	struct hlist_head name[1 << (bits)] =					\
-			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+	struct hlist_head name[1 << (bits)] =	HASHTABLE_INIT(bits)	\
 
 #define DEFINE_READ_MOSTLY_HASHTABLE(name, bits)				\
 	struct hlist_head name[1 << (bits)] __read_mostly =			\
-			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+		HASHTABLE_INIT(bits)
 
 #define DECLARE_HASHTABLE(name, bits)                                   	\
 	struct hlist_head name[1 << (bits)]
-- 
2.48.1.711.g2feabab25a-goog


