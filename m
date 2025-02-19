Return-Path: <linux-kernel+bounces-521554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F20A3BF48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6602E179E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808621E5B90;
	Wed, 19 Feb 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kAQ54mvk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385441E51F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969673; cv=none; b=mHpj1WQh44purDVnI2QzQbdWsP3xdnRSnRqHC/akHR6gnRMzApUXpAAMh2dsex35mKlgHVjPtbAd79kZ23ghJEsSQqQ0sdz/hPpbdMzcsIV987UhnmWJgOtDp4Od4Ha9+G9jLfIjag2BfhzeV8smPOuJW4IG4ztaGZ9s0e/7KxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969673; c=relaxed/simple;
	bh=ZbFDSDP6ihWQxeV8n2QAe0hnzHYjfxm2Xc2zWrP5Ae8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rtSLEAJoyfsAlrhd4WIMXBqdJTCgG6O+UHQu96f2Wb9WlP07DZMg8KfoIiwZNefCKT9yS3VnrB2MkcFZw9ztbcijDxOVWxvAxVkm3Kd9m0Etp5eeBxmc8lQh1uIlPmyQ5Ui9BJMjXX63b3XmNO+ob1CpjIPMkVcMJXOlR05R0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=kAQ54mvk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0819d8ebcso551314085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1739969671; x=1740574471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGyRcAMv6rGFWkpbew/x+SUNeZB9997kAxXImq7GFIY=;
        b=kAQ54mvk3YV7wh4UWK++qymxn6HFWzW4rfe5GAIH8dybDntTfGbouiEjR1JQYD8MVi
         Cnbtm2JfIXvTuyREGk3NZCL7s491+PMevPctSbeNU7BMwYpqTIZ/RqMYtGhaDivxUGCY
         Eaf8oJ7TGJRo4ZlYT1zUHb2VvnRVr61XJJkHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969671; x=1740574471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGyRcAMv6rGFWkpbew/x+SUNeZB9997kAxXImq7GFIY=;
        b=M/PxBZcor4G/Pxv7zzGJ9Y4Ih1A0cUFjHL/W9zegZ7KYO80P9lJi+46bHJIKZYorb+
         joOdB5y0IyMk9q06FzCA0zmEamEtu9OVLuY2SqzUCcg/xmMJqODgFAZjdm4zrQboW1oT
         imFAvpOF8BlJDaageojwgUhcsbhRY26XAylhu49M9iG8CWCNqZ18LUUM5ZOKfPRPF25E
         u42ea2JZh9FagUvdRGVZLxi5Vk5aOxsndMhTkVf4w3kyN9c1cpMhy2r4v6zDwarX6gdU
         g+utQcg3Y3XMiQxceZspyO2vlAO8vyDtdh82Sd5JpkgIDYRcPmfXAhX5bcKcB8+XpobM
         8yFQ==
X-Gm-Message-State: AOJu0YxpKwLN3mceHpoSZy+qJgb9JygyGARf/QrM/jxOsk8vJT1RXgY3
	oqUnLlTbNpDoewmgftPov1BxIX8l5q5EkyKkJiaV83w+dkgygisFBj8k4LGi72n6SAWTBRMnny4
	w
X-Gm-Gg: ASbGncsxGgEVzQ5shGKWBwvTO4iw1gQXbS3bMnARDZYO0ppHfeUdIOvy0dYKeyB8oaj
	/d5oJSBGddhJ7Ke6B7Q8rcxDj4rdEBfP1eAl5l0sbxETayAnwuFDWy9HimFtKkDdiEi1Tnbazxm
	sAcRnjCnGLu7HLbfPsK8iG5AF9DrmigBWIhX7fZ2Iohaj6ajA4Qw93o4sP2JFNvh1GN/e7aN8uc
	A7mJTLh4SU2yuNKSdhMIOZlLYFaC3/DkMqkTvDuuqAUi7AHZ8bQH3P0pTUzodEPkt5AC18Ak3gi
	kxjHCRS6WutRsa4pHQYX0XIDqP7tv9odMRNvF/91VWeGeOEjataArX2T
X-Google-Smtp-Source: AGHT+IGSDagjmy0sJ8WQxqSlY0UadiPBt+TBfV2Z1f8LHGSNN5HZAWiTioBZhRnXhlGmK48JoOI1fQ==
X-Received: by 2002:a05:620a:288b:b0:7c0:7a41:667e with SMTP id af79cd13be357-7c08aaa8aabmr2374004585a.44.1739969670662;
        Wed, 19 Feb 2025 04:54:30 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a436esm74469496d6.62.2025.02.19.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:54:30 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	boqun.feng@gmail.com
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] MAINTAINERS: Update Joel's email address
Date: Wed, 19 Feb 2025 07:54:24 -0500
Message-Id: <20250219125425.1175676-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update MAINTAINERS file to reflect changes to Joel's email address for
upstream work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ff7ba6cc270..97aba6b60158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,7 +1608,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
-M:	Joel Fernandes <joel@joelfernandes.org>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Christian Brauner <christian@brauner.io>
 M:	Carlos Llamas <cmllamas@google.com>
 M:	Suren Baghdasaryan <surenb@google.com>
@@ -13296,7 +13296,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
-R:	Joel Fernandes <joel@joelfernandes.org>
+R:	Joel Fernandes <joelagnelf@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 L:	lkmm@lists.linux.dev
@@ -19671,7 +19671,7 @@ READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
-M:	Joel Fernandes <joel@joelfernandes.org>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 M:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.34.1


