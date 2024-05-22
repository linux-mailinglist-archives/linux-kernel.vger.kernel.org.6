Return-Path: <linux-kernel+bounces-185588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB88CB739
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA81F210E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848684A57;
	Wed, 22 May 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roZaxLIK"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18948288D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339612; cv=none; b=NAKmceravs7HuoGEHfBUaYP5xygCBEXjWkTHF+zP1wIMWZgulSU4I2bfMk5SPe+Gs/6+oH2ZruL/3sk4c0hnY4YdsDWPU+jh0YuM5XXqfraKfIMrCUXdzN+4+b50CyZY/uO4MttN49EuN7ADqKqIyFD0akmpdHhiLVjSyKmP5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339612; c=relaxed/simple;
	bh=S1fHZ16QGTzRdof7kT4XVR0on/jJvuLWPLTX5ALLxIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sn/29GFC63V4vKCWzMlXpqSyLtQ2ZB8teUItX827l/+yPFpjcLrIBDOqrhR1gcdMoIjWHPVznumzYg/lle1ZpZC68R2a1FnLmauvtzs3OHc/uWfRy4V80UnLy/yBqi9UEjefJzudz91UeSRt62qaoenNqbeJpEN1TYlOPy7L2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roZaxLIK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b8700329e6so10248347a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339610; x=1716944410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SrfosPfaORMORiDV3L6HqdThQeC5VRMNDfvSuUG8c=;
        b=roZaxLIKbfqCeY7X71vD8nhyFc4CE7XJh8ZvX2oUUVFSYNtO01h7bDZlAeI4CMuGSF
         PUAsXXw1bzEdpv3HqWpDpNbB9d3O/6Y2qyjLTK9l9+pMuL+OTJfYkW2UtFh6lQGusWFP
         jpUesHxsxTTquD6Tk04TO4iYc2mYKbqF+xlTnUIfeAuWKH0YWLx9OSe3C5mvZwLij7oe
         CNDl90LiLwCBStzZ2ZVpNVwBSziOEjA+4ou75tXFQ/I8QF3nCXgPbgC/uKJ6dpQZ/Mi0
         1dQKCD69KY+54w7XD66/1242Y2Tec8X+5H5NR4fXRbpJ12RsODj9wos+Ep5PKU+ggH0x
         HzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339610; x=1716944410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SrfosPfaORMORiDV3L6HqdThQeC5VRMNDfvSuUG8c=;
        b=C986y7TbI40BhvZ++Htewi6/INW/Qb3sxaDqhwp3vJerx+SvRSAYUlLu5tjA7IiFyO
         4hCeK0OufPfqsJRTyv0u8CE1scgynwS9a4FVLXYdSN2a+oJPVreS/0PA2zWiLOuBYebX
         qMveaaHpp0vv7ccep9vMWNGfXdc+SvFQEf5juO4RZVyg4d2aruc+Rxe2UfvhvD0XVv70
         f5v0R/ZoFMtAjDADoiGadAXJFiyXeo6mI9fBW+jG0JOK+R/2s74cnlzJbYd2lZZ/Eesb
         d/Lv4aZ73y5c1HEcK2CAi4jo/4u6WJhUop4/CZzc2VeQxNAKnvYc76B9GF7jfmp5C+Mt
         P9jQ==
X-Gm-Message-State: AOJu0Yyi3IyWVW5OYGB9MUk/Vrfx6axq2NwMa6O4A0dYG0orjzwpdhQh
	EJAqZcMVjdh3ECf1CNpcB0sib4Ekl4kZ5NCYPSi+NcYK9BNWCwlZCQ4/KhQw1YVqF199+6aGh9A
	V7Q==
X-Google-Smtp-Source: AGHT+IGUpVwRCqPawwzanMXPOZwgNaMDkfSqd1hp2W1p1CdLiIMpUGI6bBPVJi6DEWQCXHcXLDTPCIyai9A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f688:b0:1f3:7ba:db47 with SMTP id
 d9443c01a7336-1f31c7f28aemr145555ad.0.1716339610323; Tue, 21 May 2024
 18:00:10 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:59 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-14-edliaw@google.com>
Subject: [PATCH v5 13/68] selftests/drivers: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


