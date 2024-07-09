Return-Path: <linux-kernel+bounces-245290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555992B0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF065B20F13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389512D1E0;
	Tue,  9 Jul 2024 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxuev6H8"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84FC148
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508499; cv=none; b=C/tenN//NVa9uIS0Hz8yVyc4MBJpM7hgHpP8rMRcwuzLaLGppusg8ysqwnPwENe2PG6jRyYDOV+r5RhV8ETokBA75ogoGc3vLlSxx0Pio6aVQ65wEIqIN76Cgwdw6LLDVoN48dhN0/JIrLMfkMAqfws0fVJKGRCh3I2ITdCED6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508499; c=relaxed/simple;
	bh=aYzGimuCT0+JpdanNSa9nCbhOPV5oJ7+e1r30gwBU/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SboevXxj/JvqNzxiHLaofVMAymIFsNKYywVf+p2aG46m2hqNpxCgMuFuUtmGhVMsHLXMfUxbjSy6kvwhmWxlMz1/GBUEQaAot2FufJhT8B4aAhgDEn6KWo/r0WfDpLAXyF4VcPvGcip0J1w43A0qQQLiCoUffH3Ql5lNyBvbPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxuev6H8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af58f79d1so3321332b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720508497; x=1721113297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yO2fWwWyK7GSaYxijZp1nvn1T39EutIfIJQqsiub/M0=;
        b=hxuev6H8iVSpxvTM39dg12rMIjodFmM/sM+W9uTQTNAUTgjyWKoV3GMsMZ0QNY/JIC
         kKnuAjpBf/ceyD2dDqjd+46uHk/PRrwg421qxr1Xe4x/jicaUiEpqpjIkhd6GG0Svizi
         /IGj+rwmZUtsOJHHAG6KlfTghHo1pzfCsOxNJWNtFBVsfigeeprmRR33f21v3sPavr3+
         r5ImT6e8jQiMNgQxdPeHeqKO7Y/eoLTiUsFyvI6/mhlqNYG8kuIDhw69n6JHm9ciKY73
         aztBNy/kgaB08iivADwYQxbSS4l83235RIxQu366Z9hsacNuGwbijnRT8VwtiJzt43uE
         uxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508497; x=1721113297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO2fWwWyK7GSaYxijZp1nvn1T39EutIfIJQqsiub/M0=;
        b=rCp/STYqacRT0qh7phgXHD5ThyuWg1384wc8t4M/HrrcEF84GIL1KRQO/i3WkiugS5
         yyhiP4hrJUn+TevdicYserMs25KdRcK/dAmHbP6FMmscH2va13Q+SE6Li4Za5LLB1ZGg
         xKP9rqUvA49w8pgHuQaL7Od0J7Z50MEGKvFKba2eAlefAmLu1NDgu0L04LZIFieQjZ8p
         rfD9Yx8er2YhrWaCcChXsdIRhOQbvN+fz9mtHhrLbxwXGjCMqdxdPBTOQuKA3enqQxj5
         LTrZnzx6MoYzetxFuHcY/pKTn95X0CHpc8cSWLD6g6jW7AZNjhSbNajPMcdoc4NJa7a8
         8OEA==
X-Forwarded-Encrypted: i=1; AJvYcCUwCJdyXeuDxKQTI84e6cyq4KuTZNjIegWypexyLWdq9zf/ZhAxQh5eFcOKJChKqMA1HM/OE2f+U8pOiyRc+XGD4V2W8w245olULZm6
X-Gm-Message-State: AOJu0Yz5FOfx/Yu+yWusaJjbQMQPekkXfN5NmpTyx/wWygaF/tnCYPh2
	+DO0r2m4HRlRMDri+UJEAKNKmidjt2tXTFC3tmbJb+omPl5DFM4wxCHW30JTTjOk8Opyu/VskKc
	IeQEEx9osvAsImcHtxN44jA==
X-Google-Smtp-Source: AGHT+IFlZ9YoYQMAk69OYELMVcilvRL5ZzGzsXw6tNxDvr38eDDrWoge7rnJTyFJ2r5Wcx3MYn0PLKAmWwLN+YWjrw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:b45:b0:70b:1086:cf8c with
 SMTP id d2e1a72fcca58-70b436df1a3mr168808b3a.6.1720508497214; Tue, 09 Jul
 2024 00:01:37 -0700 (PDT)
Date: Tue,  9 Jul 2024 00:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709070047.4055369-2-yutingtseng@google.com>
Subject: [PATCH v9 0/2] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset adds a binder feature that allows userspace to subscribe
to frozen state changes. See patch 1/2 for more details on why this is
needed. Patch 1/2 contains the core implementation. Patch 2/2 contains
a binderfs change so userspace can query whether this feature is
supported.


Yu-Ting Tseng (2):
  binder: frozen notification
  binder: frozen notification binder_features flag

 drivers/android/binder.c                      | 284 +++++++++++++++++-
 drivers/android/binder_internal.h             |  21 +-
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder.h           |  36 +++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 5 files changed, 346 insertions(+), 4 deletions(-)


base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2.803.g4e1b14247a-goog


