Return-Path: <linux-kernel+bounces-226917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B69145A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCFB1C22539
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2112FF73;
	Mon, 24 Jun 2024 09:01:22 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A24962B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219681; cv=none; b=Zs98fp6vgrwVyIuBvlF8Z73BD+ygzJ8cETh6zF1jRtNiwqv/PEjGQOgx9QSQcgB51hzatvywKBlQk2wqZYVbsBwIwW3jlUeHJM/ntx8x/udDWhJp+PD2hxH8hGao6Qd5grrGrcGXDnkDHxuBfqtC21T92k30VxHaOZpVBrLWNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219681; c=relaxed/simple;
	bh=N85Zfkwf/vmMiaaoycM7F7srdOzTSCvVXPXoryIVDvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk7Uqfj+m3WCll/uFZq/R9svyDACesrGIcYbIaHQsI9gIKpA2jWbf+5v8KCpOFVvUQnlPVlxALIIxXlUzemrztND8ZzqmDCmbK1DoCvD/KRFadtdyDbbxCniM9NZZHkPUgOEL5JfNtiNq8r4t1lvlypq61plu/vty8E+u+a6VeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7245453319so186946866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219679; x=1719824479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTswA08HnhEj5BYCk/nQOW7qmYt0/+MAtVSxpLYk8iI=;
        b=GK+ZOEvWeCK3gyXlDv90kuX31dL5BX5q0EV7d0sEpQ/PhC4Soyw+iSwDv9oai+S64B
         xOntYNTLB49MBcoOusRN8+DPsjR8lPtjhd2MikmGt6YyoyDGtN9sE8H6TR0yEoC7a3TN
         QE1rT6BJQQXybrubOxhtLkyxHDArfK7gUYNkxnYeCvjzphD0rBMNRMGGMhLH+MbB3bMa
         sHf542yVwvvsBVYatvypnuV/UyCTQsJAZY9pRt7B0lLFbKjUco7c9HPv15GRK1xVdwem
         9MpsILM7rsUJ88AfLZiRuUZFHidgOFLZdFnxC0JZp7FnI8Cy5zYV62mib9TjSdb/sVE9
         ONDQ==
X-Gm-Message-State: AOJu0YyjYBwbGumOLgA8sfRzccZifYOjgJ46F72YrVsj/VYifYUs+t9v
	dtlZJ3JhHFCm8LVJsp7ESXS5p1CWxKZICGeNkUYmrv/h63+bBFy2
X-Google-Smtp-Source: AGHT+IH9oWw2uc3qoArWVYcT7Ir3k5o8z44K18sX+FeERfWc5/SldL77ucpLFPeRkwgR1xO4Iia8Kw==
X-Received: by 2002:a17:907:a64b:b0:a72:5bbf:efc0 with SMTP id a640c23a62f3a-a725bbff13dmr83213866b.16.1719219678464;
        Mon, 24 Jun 2024 02:01:18 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7415600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f741:5600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724162f037sm225997666b.194.2024.06.24.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:01:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] mcb: remove unused struct 'mcb_parse_priv'
Date: Mon, 24 Jun 2024 11:01:04 +0200
Message-ID: <20240624090104.12871-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624090104.12871-1-jth@kernel.org>
References: <20240624090104.12871-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mcb_parse_priv' has been unused since the initial
commit 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-parse.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 1ae37e693de0..a5f8ab9a0910 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -8,11 +8,6 @@
 
 #include "mcb-internal.h"
 
-struct mcb_parse_priv {
-	phys_addr_t mapbase;
-	void __iomem *base;
-};
-
 #define for_each_chameleon_cell(dtype, p)	\
 	for ((dtype) = get_next_dtype((p));	\
 	     (dtype) != CHAMELEON_DTYPE_END;	\
-- 
2.43.0


