Return-Path: <linux-kernel+bounces-354644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFA99408C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43E61F26F1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F8201113;
	Tue,  8 Oct 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="SXUz4QNl"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FD1DA60C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371841; cv=none; b=uKXI76drUBHYngk6ggL+++Z5jiT03edywVmoiBv5N3lk/u2qj9TXQQxrQ+Rl0Xn8tujsB2l612C3xuok+blx2L+cdMyePQNboznVeBlz8QBy6OERhTtkDtYJPcLPR1GVpOu4nrVNYB3YBPSZm7I5dpdvp7qukuuhtjy2caoVpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371841; c=relaxed/simple;
	bh=/IbPserPXJa1bMDNzcpey2MsSiGwUivhhrPZ/JfO9dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJbmoAGo+IEyEYKrc4ci0JJ9U5E642rqCtzxku55vpxeK6s7o6IEl1hLTbKabXYqgzdDjHXlD0uYHPf/F4y+dxw7zu4ZFPnm6OIhXUlEBHXEfK6zM/YzCaKPrquYxfv+GIRr22uogAHuvjLhYOiw3jytRaiudMV7gt0QjzaeLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=SXUz4QNl reason="signature verification failed"; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so1079580b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728371836; x=1728976636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f01doXKW6VFqsZ9MOvvcKDX1KhWLQSKuPO/rCisrRcY=;
        b=SXUz4QNlRZv35Hg1fCJeppBfUO4GYxuADIRAtbI+p2j89whTCrVZ2qMLSj1+58DtX1
         9NTNqIt5SWi9i4+oOUlnTHvxg4pPPvKnKGkcHTppFMh6K6tMHauI2FXKvgB9GM+Jz1qp
         7L8QmwgCIX6UFPCLveMH3BP2rVBcoV1UK1Gg3t5QdzJjF04uPq2XHiEchf1P2yZLOEAg
         lGtbPQrhFl6zsDPS0d6iBvn0Zm76pOdYQ33hBNJGUaohV89OO18gf20icT6jUQKhoW68
         gF8HS8Qi49K6RFmuklsdKK7bDYAI0qhmZaCh8lQrNQV/qDAslhUYtx+hVV7MOCsi8Pij
         K98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371836; x=1728976636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f01doXKW6VFqsZ9MOvvcKDX1KhWLQSKuPO/rCisrRcY=;
        b=HgK1DZoHYH12qJPW7nCb93KA0xJDZuXVkdJgLAwQO2G9zmP8oZoNRN/nYtIe9UrtUT
         V3Ey3HIQUpOsDty6MLZnIU8oNwFlOjT7v6VTO6u/4Z79PgHQY7L5r1rExlCO6RjOOFvw
         R6L4xpZVk/vfLD5FP9NfgvT9CHX3A6wf7Oa8muzLe/os6yNUMQn1jrHn6JQs1UOy1hmG
         xgWKJwU2Ot6QpkNRxxDyvg5NEZTG4QeDUGXTiycahWOlEJfKKZicrE+PNRzm1tHO6Yu4
         WuAFFPNJWkITehVHuES5ZGNmfZWduPvsQHhYvnnbRXn9Ayzp+2GbPT6iPBExqkCzwGQy
         urDw==
X-Forwarded-Encrypted: i=1; AJvYcCX0dQOzhjCHwxdim3TFG+xPeB4Kj8/BGA1wtuzqkXLFD93eq/F73jF7MwTD3tfZtXFJrnZ+4irnaoWwoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHQLZZsusgJlntYFtdLFGO1noxG9mJnjcrBEt9AO7rjjBkuj5
	z3E5KH50hi5manii3iq0nETLNQRKuAby4qDX8us7cdPYIlKUyaD+lLsurRcifAs=
X-Google-Smtp-Source: AGHT+IEUDv9nt+vKX0Q/pnMHLEKmwOXUvnewz9lr9/wo/hLdaw/xgTmRckwI+bGaNzPWcVxI+fAWWw==
X-Received: by 2002:a05:6a00:2289:b0:71e:117d:b12e with SMTP id d2e1a72fcca58-71e117db5demr2405190b3a.9.1728371836414;
        Tue, 08 Oct 2024 00:17:16 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.195])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f682d368sm6107758a12.43.2024.10.08.00.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:17:15 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	corbet@lwn.net
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-remoteproc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: Fix spelling error in remoteproc.rst
Date: Tue,  8 Oct 2024 01:15:57 -0600
Message-ID: <20241008071559.18523-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following spelling error reported by codespell
was fixed:
	implementors ==> implementers

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 Documentation/staging/remoteproc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 348ee7e508ac..5c226fa076d6 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -104,7 +104,7 @@ Typical usage
 	rproc_shutdown(my_rproc);
   }
 
-API for implementors
+API for implementers
 ====================
 
 ::
-- 
2.43.0


