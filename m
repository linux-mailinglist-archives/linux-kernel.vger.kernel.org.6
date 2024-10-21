Return-Path: <linux-kernel+bounces-375147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287819A918F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4C6284189
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCF1FE100;
	Mon, 21 Oct 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmYS6Vn7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44D1FE0E6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543738; cv=none; b=eml+Pnd9v6NqM1efvJqMIVglsQyQbARdnwNq+rrlva0DZH5CeKJukTI/xCJ5BJbOHJzu1GckMxbaT/LGT1gUAXMAJWw1cjHk3PkkZSagJsvEqunlkBA0kguxRjyzxQsVIAgD35Lu7ft/8QwTTUsFwczAwOS/UEVwcd32p4ldxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543738; c=relaxed/simple;
	bh=h/OVx8fY1Np52b6ZnjtJ7sQ3UhDWKWmuvHiNf1EmvbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EKHRjM0n7CbknHC8t/CfP1FcOLFHMOi+XF+fbbAcPVFBetR2gyVWoDCCmVbJqlSZmQDp/v6X207Q4vbD6C5WqdgoQpmnI7kUmW+bw1fcj75RJNJoB5u30LXm7LKsG43DrWQ0Kqvbg2oBPxsxwQhLS9jhT1r5PAoOcdltQb6Qlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmYS6Vn7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370139342so79575337b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729543736; x=1730148536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlBeTjB30t5sVtg+4c19Ovx17PsydaPYj9vbcqxgxA8=;
        b=bmYS6Vn7/FSEzebxvjqX+hoKhpRrOpZpGiFUN3GRj5Q7j8CtwKCe3mLvLfOEX6oTun
         coJN5Eae/p6l2ldKhkeYiwE1TgPXz/MxAkeCfMKJPEjpHKyYHD5G2bUV0lGkS/UZ4QQp
         +9vLsRveY3ubX4F9Jy97uUOp/UPFmDIjzNZGPx3I81Zew3yDfoQjRfNglq7Pofjtx49v
         uGSUUSIMdZWJ7VeoSg1/aIlaaBQdCAFmyjx88Pm5Iar2roMBW520plNmYMqwl9A0Yjha
         2HEvT8CzLeS3YOa/fySmscrasX5je817t/3NlT+3laKdKOlYQpweX7R+yjsBnAF2fQbj
         xtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543736; x=1730148536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlBeTjB30t5sVtg+4c19Ovx17PsydaPYj9vbcqxgxA8=;
        b=R1/8L45N2UpLR64yxTgDbFlXhB4fbb0GXwJ8SaGE63HDqvoxxvsvMZBxGKQMTRmHK6
         7KcihatwGFEkuOtRmOfbOIFeUmFX2wLogUQKq+7+BEZJFVG89NTDJPmib/w9tl5UoicR
         4nqmebXGD9rQln3Fyk6yedQE+bA3SDX4WDysY5JgZNySwab9avk3v0xAeB8K/nolq0bO
         yjIKV+7Ah9LH9DPkWKeDzaUvdpo0vDxZ50sytcKci43DhvwR0ZhY0ZOqp4tDbhaz89ol
         CgXqmGQBQv+8qygNyqf5TNwJjerptg6YtehG4o4DOd6DHBekBKkiY3QX551SEG5OTuX9
         dNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc+QDIikWyeFfnEGrpxUypDpUmaIiXCw6kmpcLBgETydcUwCJdC1OUVcBLk5yOvrfpg4/S5GY9MkMPJLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFn8o7GipCx2KH21DLYihH8rMmVAH9fkBXX4Qdh05LE4EqgHph
	3e1JVm4wwnHU9Queiq+0eostpAzk0RY4JhLUFjGfSG9lCq5SPJlCCs+ZH34o2eR7zQ8TCHuqsOm
	bsWnH5A==
X-Google-Smtp-Source: AGHT+IFaD6sHUUx1iDTWVXuvYhwh3MjPeso168+Vopjk3XjtpPDKt7LWCqxSWBJfBAZl5rNsNo4cmve1/N3T
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2c5:11:202a:34de:6d58:91d2])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:9b06:b0:6e2:ad08:4924 with SMTP
 id 00721157ae682-6e5bfd21d18mr3568567b3.4.1729543735690; Mon, 21 Oct 2024
 13:48:55 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:48:49 -0700
In-Reply-To: <20241021204849.1580384-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021204849.1580384-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241021204849.1580384-2-yuanchu@google.com>
Subject: [PATCH v4 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..c0afabab8b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18716,6 +18716,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.46.0


