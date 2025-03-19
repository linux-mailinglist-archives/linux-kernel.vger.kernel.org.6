Return-Path: <linux-kernel+bounces-568875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816ADA69BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34693A721E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E6219E8C;
	Wed, 19 Mar 2025 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="iB9k9508"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D07210192
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421580; cv=none; b=GiIz0S8ICu/bbmZHnZ2xVL57I2PDSxghGS2yQa/XioCj45Nd+93fwTMiAdExxeXakPzkZ+iHjgWvrd+JjekPLb+ShvqM4wCUmr2iUosP9yV1ncOBtKUNJN7XJExQeJIQxLWozbmY71bVFiakRjH9hUEuDj0akEvM6220trCrvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421580; c=relaxed/simple;
	bh=RKb+1sIHBOGYefHzaK1Sib+IBGYlcCV1odTLTle3f3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlAgfsEE0j73m/HgSxm61DkxEnjEC/W/FxiFFqujdDs9rolraqypUAANGS/c1UsV0Ks744MT7BbKFrhoS7XitHxIsi3PVFhx6RD5lkYdsSrcGOBr1LFgx7n041ZND5R769n+Mnx4hCrZRKtpvYXT4Uc+yE+Tl0rYNGdPUISd+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=iB9k9508; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso208383a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421578; x=1743026378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFQ/YvYbZ8R0CaqRMB9MAnlKHCmO+BcDVa05l7CnOdE=;
        b=iB9k9508kNSGKoN6TikntabhPU9rfGLREOiRGZSQMrtAuMeLhN4xysf6IR9Ahhgugv
         97Ro4HezTaRJEsrZUk94i1nHf/KNcAJvdeDKr7J/hRjaQZYNigA/T5A8p1Qixjf6ah5A
         Z5jo8cA5zBtqYVqRcPX5yV/B1kEHg1Td22NXQ4Tfz5YXWWkveNNGPrPfwWpUfDHXAthQ
         HHF+HJv5F5wWsQwixIdRd7IwmBb4BwMIxlJNyqGx4OHla0hCVn9PcQjbb38evUu6QiPq
         tl7vO20PZgO1nsEY1O9MjcOaixsO+45t6SZDu9eqtJNU4OD1qwM0mWuzsN1XZ6+Zmyq6
         iKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421578; x=1743026378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFQ/YvYbZ8R0CaqRMB9MAnlKHCmO+BcDVa05l7CnOdE=;
        b=TVbQo+XtB2wzWSWbwa6KsW+A6gIHFt+sRvH71LpAotMpijA2LVQ+AqQ85/TiM2M4QJ
         A7is+LQZGbc5XZUQY0ssCxE9pkExofWpvXSVbQgVfwCwKp0i+aDp1G/HvXuKhhaXZD3m
         th0RfrAFHQUB5SS+kUPxtgJsCm11dUoloLeSIf0d5indjmn6oe7KmuGAFFr6rv6d3P4d
         92QMVHtW9/g1rnQkJXn7sysofjXA1k7ILjsq98Cr8V4PgKDGdTeL8UxMab9w7WrlP5ZA
         AlvuhiNiFKHHrDgF/6vMEaDpD96a71IoaTHuuCI56AkyYgK2h9zU+IXM89HbohXhdyyD
         4q0g==
X-Forwarded-Encrypted: i=1; AJvYcCWbnVZHoCanPUDi0+24jQKaPITTBW6jlZUwLVBmwM9nvBhZ9vn6r17g7GIFn4xysx1wkpsPIsCEXxoNZ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bXU6aMdlKAkXgDxsjzYJJY915nF+63W+gBX5amKPZ/nY/ars
	6XRI31XUIUchRftRMOxrvrSPjSRafoYRxAh8Qz37MzxV22XCDopJn3O5v2LbLxm9sLtxmC2Z/40
	=
X-Gm-Gg: ASbGncsZTQ/oU/RoCPgUIlfs2/YneyMfk4N6m0UdMCvVPPDDpUvsmO6mAnlMBdxIs74
	Z57il5k487Gr5ggyAQrePWcurfb1QCYSRdAmM9+hDjkAYvTk9Ps0zJNZk3kGJZ+rTwmdFzqzvSj
	GjcEId7P93l0yhpYsktvDV5IUYQhUsisMjgwsO70klPmKNmQqwAWDrYtEPBM12Y9ZMYaxEmh0mu
	x18fECZJ+Pn1/tMsfQbDs1asFynfxp16zBOrDsaMgw6xlLrOgGjVwO3xM0oKCDXR9Je3waZjL67
	54PGcbrf+CC0b5CR2l/Y/MLr1If6mzp2T+o1/FVYEc7uj+Hez6vS35YCmw5WKfI5hJSj9CXzHMu
	qrE6HmZWBDQ==
X-Google-Smtp-Source: AGHT+IF60U1DlELYjOK158XzDQ0+T3RR0ImRj2326/SIg63h43OsS6AtFzreZLXkisKErOKfa8tzXg==
X-Received: by 2002:a17:90b:390c:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-301bde62d9amr7148937a91.10.1742421578198;
        Wed, 19 Mar 2025 14:59:38 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5cfd9dsm2220991a91.44.2025.03.19.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:37 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 01/20] staging: gpib: struct typing for gpib_board
Date: Wed, 19 Mar 2025 21:59:05 +0000
Message-ID: <20250319215924.19387-2-matchstick@neverthere.org>
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

Using Linux code style for gpib_board struct in .h to allow drivers to migrate.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/include/gpib_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index b41781a55a60..7dc5a16e427b 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -23,7 +23,7 @@
 #include <linux/interrupt.h>
 
 typedef struct gpib_interface_struct gpib_interface_t;
-typedef struct gpib_board_struct gpib_board_t;
+typedef struct gpib_board gpib_board_t;
 
 /* config parameters that are only used by driver attach functions */
 typedef struct {
@@ -220,7 +220,7 @@ typedef struct gpib_interface_list_struct {
  * It provides storage for variables local to each board, and interface
  * functions for performing operations on the board
  */
-struct gpib_board_struct {
+struct gpib_board {
 	/* functions used by this board */
 	gpib_interface_t *interface;
 	/* Pointer to module whose use count we should increment when
-- 
2.43.0


