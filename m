Return-Path: <linux-kernel+bounces-245185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266F92AF68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7545F1F219E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452C13213C;
	Tue,  9 Jul 2024 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEdW7hmY"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E784D8BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502689; cv=none; b=A0XPMUkvHgRmlehr8uiCoL6NLGqG+Xlm82Ud0GJKyhX5eU3WEkp3lOPHRFPXEEvxRLMt5sfg1BeiPTiCTBOu80iQJpDX9V6jt3RuByigCcq34j9xcpAfS4hwJFCNXX8O7HTt6pua4Cakw82/sgJNoD4HMnUdtB62/3+1ZcR/SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502689; c=relaxed/simple;
	bh=ShJ2SRcPXiThajj6mXrDhek7dNOvA0ou4pf8tpzkyLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IymyjNJIUrM6OKXGpzxwx5eZmt9SluFbQSfPB/AunYHdMtAZbHoyn8IjnXGpI0NlZdNffFedWo0uUq2teSu/qnXKPiY+w+0PLBJQhff0GKU59JB8wwPPHIbrO0gC/CIcdAmL+tIm6gu0F1h0phW2f2Fnmm/uuVeBIiUdIRpDCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEdW7hmY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so3401358a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720502687; x=1721107487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ps3lG/PULQJDldl+4+0mWuZnq0P9RsTgm5luTvIchyg=;
        b=DEdW7hmYh60jT0aD+2mGJPt00qm01jhydZVVKTpWcZDnTNrXqycdIbJECPDIGb6XVJ
         CRYnaBv+VPWAy8W18zw2DuAJF0uuV9V2PXnH85cnRrXY/tnQ6SStO3tot0xuGCZQcRL+
         3PTvIZMQ3EJeXdhno8b8IkmKI0KdQ55PWGfoa6R5/XMmnZ48RU9+B44XGHosWqiDmdCw
         +yUKw/+vL1Qsr1voLF/wbfNZcO676s4vlt1HOiT2yotBWNgNtg9Aw856BLoWDR4EJPlE
         1sxTZeLvo3tFkNN4/YUNvdszxrfZ8gVgumyAaf6KWt2d58K+9GLjb4M/ASTeRO1pKT2Y
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502687; x=1721107487;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps3lG/PULQJDldl+4+0mWuZnq0P9RsTgm5luTvIchyg=;
        b=lVj2OqbqWskogZW0DU5wkY5aYR4gA1o3Vzyqek6VNwe4tcI337mWiwjErTk9r/cgd/
         epn9Rl7iIW6QokZHtj0rPp52CjnKkZjYIBZ7YrP0fR41RvgKfzaNHC6sdfLGLcWKgnUn
         MzQIaX1VlL8qzBcjttE8HPNaVlj0w0JpQaEkZVvqM5ipdhczBhWkwJm/Bu3W9/z2bjv4
         Brn19mt7ITzRxr1J4ZRxgK2Ytb3CNkmNZKJd+QFR5k2hIlACBF5fweWyqzAA8U5RtyC2
         5kmsMPFWWZ0iI8VtMV/kRGhtvPmBxjEAjrPxPTDkuRtXS6I7jZUbiMDCjHXgCX05xvxG
         6CZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfZLIv0jWvyVClbl4PIpECEifF/QWctDh3eXfXukQNgqVwTQmLv+keYeAvR6yiblpPKWSZznN9DkLaU61sSXb2X0LEFXEF/KBzmIg
X-Gm-Message-State: AOJu0Yw+q4dlxgLuZQijYn9h97vbI4NLCTK8vYTY+5QXhX4bSAc/cFT0
	sv/nc0Iv8IkoAeU1WoJsByif45DDHCDAGP3RnCrf26VIaSXVFNz6nku68KklHHxHoVa68e8dgQF
	VfwlYR3/646dgTigzPSouqg==
X-Google-Smtp-Source: AGHT+IEnE18pVhj8KxuhMIrrakjlq5qVTSryJpNEnZOtvXnmApyS38wo0XKNdx/2PB7nIwLXgMrWNqpDerA6NWhmOg==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a17:90b:278c:b0:2c9:7e93:498b with
 SMTP id 98e67ed59e1d1-2ca35d8c003mr4534a91.9.1720502687049; Mon, 08 Jul 2024
 22:24:47 -0700 (PDT)
Date: Mon,  8 Jul 2024 22:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709052408.4032665-1-yutingtseng@google.com>
Subject: [PATCH v8 0/2] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

Separated the binder_features change into its own patch.

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


