Return-Path: <linux-kernel+bounces-568895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07979A69BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8F98868F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C406214A92;
	Wed, 19 Mar 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="WYrPrihl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922712236FB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421604; cv=none; b=cIbx7XWmHq0snn9FUUn3pC6tBy5z20YglXNcqnpaIZU4+8Xl7ZDk62C9FdVwGgugDEDi9ld0ojlZN2oNca2fhPYFKrhgkIYj1gE5UxbCu+McKUX+i87DCMqNSvu4yfinjfXfcEWlSWCqWWFQRepXabiQ9sIrEcSr3a3zJmxt8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421604; c=relaxed/simple;
	bh=VbdeLRZV9ED0o/Bxs5o9aDMhEvtIGXCWX0egsa7yiVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro+WC5WamfNiwOCGNbOh76No82K1qjzvaL+wofDKzl+ZG+nLIRc29jD17KnwzrQzknBMSQg/zl1yRKDROAQbFTaYCgVngzoZb1VkTx2sjsgKQegvZ+Me5pjQAE3506b2NxCIOp7kdK6YIVJyO7DnbLBRrbVHkzNksX2+hOz88CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=WYrPrihl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224100e9a5cso815345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421602; x=1743026402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prJ1TM7FQQCq2HQpbJ4AVBwG2iHEDTkPGfRD+WVuSQ0=;
        b=WYrPrihlIwRQLpfwPnB/JqD0kwu5j2MAjuiwdZAuX5Xvl20gYbFHVKttOT9O9DD491
         M6+4rPuiROYjhvUQMvVPn2zau2p+QQ6hmz+X7SrxJitnod5LhMCDbYdhHV5tKMrtUHmO
         0OcXIi/wR3NY4P53UdGYhGPE3v2jaj9a0t2n4ZxTqE5Z1oph4hDqDootI254kTW+rpUy
         uPD9ChpNAfn+ofpRo3/+cTMg81I0CwCOqwzlGtJNqk73oZjK9gVrNaFa1d76DCdWl8E6
         xP3WBQju66KlJap1KI1X5a5+U0jt1i86kyv3HFciWUQwbn8LxVfGsnZjSJlY1+IjDPjm
         vNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421602; x=1743026402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prJ1TM7FQQCq2HQpbJ4AVBwG2iHEDTkPGfRD+WVuSQ0=;
        b=bPB46mWX3+VM6y8KHf7Duy4u8atTKQc+UGRoyHPH8TkiyteqKlRnq79R9h7CJNOUI5
         48024QCDCQp+UvVrLOTVZMnjHF3Kcp3mncnZkobR/3WwNHUb0J2DOlXMglD10JsVd9BA
         BjE4d+21509Sne98ykFcWwEEoMXQjHN/fEKL8INHHD0EHEQuf4oC7iWlVxtBGDmK4dRM
         o8w0bQU+4aIzPESYL0NCfnEbS9zx8nAtVx5v+gS6b+Do9R57V5JNW6rk4EtCtIErZbtU
         Iuq7Gyae5SI7Iha2vHlVbTCYGRMrB5bHXgMeAJU4HB19/fRp/uLM51hTFxhT0CZILgvl
         3qTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOfoiaeQfQBhvQClWhykNOq9sZBbN0OCrApQHI3rsLxGqmnSl7HePmuv9iI4BM8ExoPRlCMYIu8IoSGtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLl6dPLEbNRMDeT8hnVxVG9PxkybGN8i5TutAQDspAO7J/Jlj
	dAHUWqLqFM7OOThOrJ+iFePQtpymA4oABbAYjwqBIdunjTBCJQEjhWLilX27/Q==
X-Gm-Gg: ASbGncu9FpO+ctv/Dw4Xwnp+FaoWtykUeB0XgSFJDe+QzD0G7L0JDD57rZAkxMEWu+K
	X+GWCzP8ABzlv7EnvR5ndYzW2dv+cRAJWXtX6vo3zy+rDFs1VVQ8DLVbLkMsmcZk4/yQaW9/BlP
	AU42GmUXjwQWAd3V/2IUtb6q3r2pOh+8pX2+XWD/KRosrppf8uK12xu3+gj91AiKwJktfe3ULc9
	BlXaxTBXjiSVeahbhKfB2mc6NQwMXQ2+nkrgKg4ywG2f85AzoN6Lqcgds8uMp9y+Y5GnzelPFNH
	82DMXTvnQmYoRLUsCApBGnUrdnpKpU2siTGoR9Jl4FnH6YEwxQibhBWn2SgTKFRI0BAkBJGC398
	tTnZGch98UQ==
X-Google-Smtp-Source: AGHT+IFibFrspTU/Sa0g0di0JiPnyclzEvmMzIUQgoY1Fmh41qCzcBS8NG7aSZ/+vqVHMo9ZwlrHCQ==
X-Received: by 2002:a17:903:1d0:b0:224:216e:3342 with SMTP id d9443c01a7336-2265ee8f6c6mr13197075ad.43.1742421601806;
        Wed, 19 Mar 2025 15:00:01 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe884sm120346345ad.185.2025.03.19.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:00:01 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 20/20] staging: gpib: Removing typedef for gpib_board
Date: Wed, 19 Mar 2025 21:59:24 +0000
Message-ID: <20250319215924.19387-21-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319215924.19387-1-matchstick@neverthere.org>
References: <20250319215924.19387-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing typedef as per Linux code style.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/include/gpib_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index 515fdb91d150..31b35f2cb2e1 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -23,7 +23,7 @@
 #include <linux/interrupt.h>
 
 typedef struct gpib_interface_struct gpib_interface_t;
-typedef struct gpib_board gpib_board_t;
+struct gpib_board;
 
 /* config parameters that are only used by driver attach functions */
 typedef struct {
-- 
2.43.0


