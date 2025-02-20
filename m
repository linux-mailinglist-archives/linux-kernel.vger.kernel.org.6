Return-Path: <linux-kernel+bounces-523996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D3A3DDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA26B7A4AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A31FE453;
	Thu, 20 Feb 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KovFf0YR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07120C034
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063834; cv=none; b=jgWNZ78CYDTdhakAQX3shMTkW7P18vGd9WfXXmR3w2z/D3ps/m+cNXBq7f8QZUFpu0COBhqcNO0ndtK1fMCPDz6epRx6Y1qt2MLvTcKGWxC2F4NVRqcPeWoNd1P9EZ3Iev8x94hq5RITWk5nkoKwSkbFYzVtWkHTZwsZmWV1x7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063834; c=relaxed/simple;
	bh=W4mj1z3uEq947HIkExuSIBSOsvPwRxwjgNUnGwTjvA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OY9L7Y3WEh+5cue//ok3JFQkKw62CcZeszU/7v8V2/0h2bo7q384NFDisRiuPa7K2YjB3u0Ma+NAYIpot0/2BVL02SRndef6+zikhEOHly6G8D/udSwLQbHY1vsl41nfmIl2DRcSr/m29w+vIYrjROix0OvhgLouMWt9+kuQYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KovFf0YR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so8962485e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063831; x=1740668631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbBII2vXo7U0fvcYEVnofRQGig0kHut1fyAo0nfwDbE=;
        b=KovFf0YRRr+aSy7IFePApN2u1PY8usv/WOA7D13UUU4bpr3YH34guHZzP27VltJJ7f
         yfsxCyu5KZfu2gSWsTqyFkOAjrQjngVmkr64SwfWUze/Z02eabKZovhgD/5+9KKe1xeM
         y4tmGAJQ9T02CWWw1LerY4Lp8Gr7MksvV/fBT6IN0Zw2rAsKlyXkaAkOQeE3pWL7nHRy
         qMCBRDaEARV/wq96m8yKcTcI/XW3UotTA0ioSqFS1yE88wH0szgukNiE2IqFEwEXD8ni
         WGW2Bjqdm7I01kMFFzBiIXRs+LmJY0xgrNiDahSSA83yQgybN8wwJ+qaw/EpgnC/ZoEn
         pNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063831; x=1740668631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbBII2vXo7U0fvcYEVnofRQGig0kHut1fyAo0nfwDbE=;
        b=ErAiU0okSpfmRX4T6FbJ1iQgkd/w2mQckYurDePhKc8ffmVzlNZJCzoOdRf380lmzK
         huq+ly/ek419K2K+KVu1LWWvOy5ZDJhoyTmDsqmar2cL23HXZinbWunUnKdAQFRHa+Yi
         szaVS4yYWEmaP4cVb5va0nveAlKZ9/+75EGxBBNzXLjlhOoXIjHEB3UojGQUchRdfyhp
         SROk3RNd/476sc3WYcE0+saqyvn9ZLuWgiSJr5m4ETGiMHm6f7fQ9h6CMRtdIb1DBIlv
         VkSkzdO76NaxW1y4aKkfJe9mQsZnyGVdoMSw9HuoIcsnZIqdRucDZncldMhC9APg29gR
         dJkA==
X-Forwarded-Encrypted: i=1; AJvYcCX0PwBe+/EGW98/WGYhYNguofgGhsrigKj2vv36HAHoGWv5mrwNLaXlJlNc5WUp6gvALeH7kl/qDclpo74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeJedfreHylubRUZnwM8Tblcfl6OT07aF/FJi+5FC71Ie9SIp
	k8EGcHptSxNye+p2TaRDDHp1BPttp7HTetjPl1Lwxt/6VRVEGPcEYVZCN1tR4oYcu3oikSn5H0b
	M81QlLJl07A==
X-Google-Smtp-Source: AGHT+IE7Haql4kRMGhVIrFouZcnUmxPrPTorpBWL1U181AADTVynYOoCOjR/I6BHdrXJEH2hvn+bGdgYYdY0eQ==
X-Received: from wmbay10.prod.google.com ([2002:a05:600c:1e0a:b0:439:8715:690e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1f8f:b0:38d:b8fd:591f with SMTP id ffacd0b85a97d-38f614991e7mr3002810f8f.5.1740063830609;
 Thu, 20 Feb 2025 07:03:50 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:18 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-6-9bbf57d64463@google.com>
Subject: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This calculation divides a fixed parameter by an environment-dependent
parameter i.e. the number of CPUs.

The simple way to avoid machine-specific failures here is to just put a
cap on the max value of the latter.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 1facfb79e09aa4113e344d7d90dec06a37264058..f306accbef255c79bc3eeba8b9e42161a88fc10e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -453,6 +453,10 @@ int main(int argc, char **argv)
 	}
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus > 32) {
+		/* Don't let calculation below go to zero. */
+		nr_cpus = 32;
+	}
 
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
 	if (!nr_pages_per_cpu) {

-- 
2.48.1.601.g30ceb7b040-goog


