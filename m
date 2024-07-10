Return-Path: <linux-kernel+bounces-247996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9092D726
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CD9B244D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01E19539F;
	Wed, 10 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCM42+K9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158221922E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631195; cv=none; b=LONXrYLPZjh11Sf23Kc6Hss0JdjwRZeJXyr+7nYaxVje2/aUaWKbr6eLSNudZqXluCQVr7hSXfShq68tJWjF/w37bjl9/kA71Sb39elp2logoqtuf9FqqNzCM8xJG0t0yys98zjhMl9iIMIUwI1WlwuehbctJ6mA+NAu6h83kjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631195; c=relaxed/simple;
	bh=4wT2jC6PAkErIVyGGjb3mnQZSgwRN62Cp3V1tfbR5v0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t61NcCKF3yUDRJMeTo/N//dPb64Y4Xream7z2Cr7tZE/jHAdouPRx0li9T+7V6UnhemmzR6RSUGi1uqtKnag83lFXDEq8S+qmuypZsXJ+U1QheosDxE6pgI3yJfSwggpUuAesr7owOhEAN0zTjQQ4xd2Y/Y0YJd9QBEYUnK78pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCM42+K9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0561513c21so975421276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631192; x=1721235992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HbPsmQ0gN/q3U8COOHnxX2fTOdZkrHtTrBhyd2/ae4=;
        b=mCM42+K9eLzedGLr0PvjQ1xZ3Lw0rfCggM5MF85K8mdVB3zTA95unoZW2u+f5pN7n2
         BvNSbD4psijHPVF4aUVyLxEoo8fPcWIr3Fmqd0ZYc3uEn7Yf/wRtFhVzRNq3M8Aygpre
         HkDQ14UZo7YczdMzPoZj2KMLx7EUpWYB5ihw2WrLjugcnMB8bq8uncXIbAtL2ZAUDCm0
         1TpjA6JWeefqbn5rmdvcTqd5JSzzlnFr/BdUMN3LeAdUMTeMrjXdCmvBir/j8UuOV6fr
         t/soGLeZv6yli4c/waNaBxvlkjUzS6vlQbWfOKxe0of9twiWTMzvxZB1Veecz33qynWx
         dnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631192; x=1721235992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HbPsmQ0gN/q3U8COOHnxX2fTOdZkrHtTrBhyd2/ae4=;
        b=w5jeNUKOggu9T50LVywmdeUBB2LHkToZNvbiQAxNH9iMlGz7N2qzZPbDSMIr1Kvc+Z
         oOLBr+4GxtQJg2cltN0mKS4m+T9SfW83uoHXo8qS56bQ9HdBS72qSupyr9U3r0O8b1aj
         RTq9DJPuVoPt4N5ssfbEHx/U9mwEoj9YB1Cpy7TXkJQzGPPUKVCpBHN7XHvlo0ckPnHi
         KCyjDwwzQ5SRjpv9df+LhM8eDZDrmUCxL6rjGieftnElKTpNn5xN/Da0/pKPQ8WaEzgG
         /wIX7vVbYZKwMjAlr2dtVyL5XvKT9CrP8ObaT26bbJDzAUyyMYTaTPE55BI2HuA4dvUS
         8e/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqPVuPAnC7pIidVGo+gAkaKwUjQWKtNAjDk085FdcrJNT9WO2kkDBSuE0IS7j1V6xAx6nAFfYjnSAFi/PIc9AkbMBR3T0EUGruiceO
X-Gm-Message-State: AOJu0YzWc2IUyY1kDChIcER37ZQpclrNsX7EeSMhtMNRRiq1hLiXDCyl
	nnpf1888UvaxbGKnXseb+QgJx9ur6XNw7VhffNfMVkNzg0ZaZ95IknZjKqaS0urTqI6mLgNIEh3
	kWwVlNGAsIJpKh7D2YQ==
X-Google-Smtp-Source: AGHT+IFrIOvkkPKpRQh+/bL3Bjds/gNme8/diuIke7SGwoMFYK93/GkFdth9JHVvr6t2O2es4BoqOqb855CwFjvG
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1002:b0:e02:f35c:d398 with
 SMTP id 3f1490d57ef6-e0577cd7b4fmr5197276.0.1720631192033; Wed, 10 Jul 2024
 10:06:32 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:06:25 +0000
In-Reply-To: <20240710170448.1399967-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710170625.1400724-1-ericchancf@google.com>
Subject: [PATCH 1/3] kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
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
2.45.2.803.g4e1b14247a-goog


