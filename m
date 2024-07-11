Return-Path: <linux-kernel+bounces-249791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831892EFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B3F285265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E4187351;
	Thu, 11 Jul 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbrbjbZ7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2A186293
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726766; cv=none; b=V843mG6BJ4xqC6BB3HX9mG+bp5hBxAYNlEafAhauFsBo+yV6gwPLhXBXii4m9SIuTgBdxTxF54IVUp3tD047akkYul2JgTRjJzu45MdseiDmIJEefitxT8pdKDGpfPfL2jYi6WWjRD2lPVoyLanoZxL2AGKQ1IqLwPo64x+D65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726766; c=relaxed/simple;
	bh=77Fle0UxEK6EwAcqoaNanQHiVkg19YWm2CKEwPFrX+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cd0vADQ7lvdsBBrL7WVbWZ58sMy6ZnLDXH7Yc6P6/8HkuwV618hvcSR6KIeVni6Ms54qmtjrAKnoy0Khp57Kum4NGKXZ+t2hth7sq31Z/4Zs49kByXRPmWyc1qMR59fzmQjiR5vzQPbbI4LChyD1aSyWAoNVUd+j+sGpeOVYQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbrbjbZ7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0561513c21so2496395276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726763; x=1721331563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuOZKjw/4Tx33ZawZRx4a+P5bBTfvgvLFnSHZM5EMU=;
        b=rbrbjbZ7GU6ThAd4loYZpzf9T5nChFt8bqFP0XYg7qzHgdI1xs9WtsMkJZ6/hKEyCa
         bQIhHAP3YVhrA5Owg10JSfhBpwVwvx4FN8xLjZmnhMIRdYGWJyagypxmdGeMb1W/7Vw2
         7K23EZSa5oLFweeEJZJ98qspTQpzmma9L+IWxGuWY+LD+O2pzv43y0rNMBoMTbEmXIHK
         yXXMcYgZej05kU7zLTbU6ixC4ORLOrR4LuwptVRnrOgMzOb+UWi7KsGgGjcdf09J0X8o
         99Eti/RCK8gm0yVluuqbACd2q2i6yhRFkQOSy1NOwM2T87EhueKudOoZPFlIxMY+JMT0
         X2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726763; x=1721331563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuOZKjw/4Tx33ZawZRx4a+P5bBTfvgvLFnSHZM5EMU=;
        b=WVJ/RKV8dejTwiEsAMT6f0P8dSD9XMw5zR2cj854LB8Inq9Bi3VW22aSrPulZ5Z/t/
         IJmTFivh5Y0BgN9O6m1HvBi2gOowCJ7NbJsBRaeWX2pDg2IEpC89DdjKmH7YHNSb9/3b
         1Q7JzevN6UDjJ9ZdBSsz90CYZXhiEaG4PIJ5hwXDGDlP5ToAbBja0BZMrjJfBp6JHZOe
         xPWaqvETg+p6bfjNcxS+VJen3qxUpCQmE3oa6EZOfzpS/v6SP+UoNRtm6/lBjddOb7AI
         EsqS2DlXsezeKGpHkEkT1+JNl2j5FUmbiRTiLxyg5e0keep2iFOyIqIm//Vgr6jW65s8
         8QBw==
X-Forwarded-Encrypted: i=1; AJvYcCV1obDriFbOWzxu31XCvyRieOAsFnvMXtcxRdb7G0de1bGRcUlNCTQI1Y3rWbAyJfkmM8gCgtq3xW9PHvRCO9LekH1L/5siA4r+uIMp
X-Gm-Message-State: AOJu0Yz0CZgo6INGlPociokLKzsfIgsxYU+X5eug7C8ytwM1x+F8oo92
	zzGxUdJi8z8CIZUx+10LMSGkkJ3pXQyh5qwXAsPHrmoQ3xwcnAZoh9QqIJtyk8UE8oix4BMRhzA
	S1waSstxXvi0Vf0mgxQ==
X-Google-Smtp-Source: AGHT+IH6KHs598qSeIBPsOGu8UPNk+DERfUoNF6Ncsl21ateD2j5KJKs5jvjqp/cn3t/zbMtdixdYO8tAx/HfDEZ
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a25:8447:0:b0:e03:5e58:489b with SMTP
 id 3f1490d57ef6-e058a62eb69mr2360276.3.1720726763466; Thu, 11 Jul 2024
 12:39:23 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:39:17 +0000
In-Reply-To: <20240711193729.108720-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193917.109380-1-ericchancf@google.com>
Subject: [PATCH v2 1/3] kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

The current comment for KUNIT_ASSERT_STRNEQ incorrectly describes it as
an expectation. Since KUNIT_ASSERT_STRNEQ is an assertion, updates the
comment to correctly refer to it as such.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 61637ef32302..87a232421089 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1420,12 +1420,12 @@ do {									       \
 				   ##__VA_ARGS__)
 
 /**
- * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * KUNIT_ASSERT_STRNEQ() - An assertion that strings @left and @right are not equal.
  * @test: The test context object.
  * @left: an arbitrary expression that evaluates to a null terminated string.
  * @right: an arbitrary expression that evaluates to a null terminated string.
  *
- * Sets an expectation that the values that @left and @right evaluate to are
+ * Sets an assertion that the values that @left and @right evaluate to are
  * not equal. This is semantically equivalent to
  * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
  * for more information.
-- 
2.45.2.993.g49e7a77208-goog


