Return-Path: <linux-kernel+bounces-337518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A2984B40
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226A3281B66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBD1AD9E8;
	Tue, 24 Sep 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hewVFhhz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FA1AD9E2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203455; cv=none; b=bWoNkRbA4acwO2t/G2GH7aP0HOTqFXgdJItlclBPxkKTMV9H5dvtKXwosWJAfx5/IcQXLFi20ghCRIuBnqHG3F7NlZn0r2tI1rxs+SuQjyMtvxXcJD5Qh/I65Z95V7FRpf6KOeqXHwS/gyC0i49bI3BnFxVOjbqTKMBAJ9Aisc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203455; c=relaxed/simple;
	bh=04CSVSNbQAoz5nJrui7w9wr9IJQYbvvCjU2rJHdTZ0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGOn8Lub3Ahr+PLAC3MzsKq2g2aAGWd7fnEY5hAnAz8nPdHdc/6PjH+6kWWJpI7+OEqhVewSRdpxwdc2vltgp/NAbhaDX+4GUoHPTe5MGqOSoXJhuo+Vw68X0dObFrga95iTsj2gNpIOiH+Nr2w1ThXGELuIb8n7ui0MPksUN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hewVFhhz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8dd20d0ddso129528a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203453; x=1727808253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbeoTgd2+9GtK/0uZbn6j9cZRGaoAw7YTDGHmlJEwk=;
        b=hewVFhhzJ88PLDi46vxv7W2eDE0atPzfZNSfzwXmpyjbzk8RyktM70wsdIPqMUlIF2
         xFV+RDvRMGUjy/W2PMArtGoSwi2emHqE6xhFMCh2VGBlRyAB4DrBQ4pXzwNQ61l9J7fz
         N21DqmY3qA8jPZTxeiCz7ebnzwr+xEzYB4nr2htY1zD+/CKfLaUzSo12MbqRYxJTlzUe
         pj48o8ppqUq9Q9awkMDaNj9gw4BCp02YtzaHtE5b0825jLT8YYkckcsfB/B65A5wBj7M
         XSiBiuq7gGcgis+BLeM6g/zw47AxBjBGjAi0vkJrSmgCVL3q8joBC1QZmqthoyu0clu3
         fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203453; x=1727808253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbeoTgd2+9GtK/0uZbn6j9cZRGaoAw7YTDGHmlJEwk=;
        b=DXGfhQ1M8jt3X5HG+WgAfZqcZ6HebA5YeQr4eM57UqKQZQxNvwNm+wjzdJemZEvgoP
         NoZj667/C5U7lf9aE93pSHnBatf7J6EgsD98H5w/GZ5Ec/bRKHpzu+DKzyZCx6vx7nHq
         8F0a7pCwIFSqjpfDo8jIPxJHirdEjULnASQAJ/lSt/ojhpm16KTHkqkjSmECV1KubQ8h
         7rPh7phI1X0DW5g7vG2zrka9jEP6//dnJQon58nu+avEfConEx6nqZ7+MUOXTKu8Kofz
         8eW4J4WW+L49s9NzMSpzqoKXixZ3ewTz38KK9HGhupfnhq9ukDDGFjcgX4mWjk61LnRE
         01rw==
X-Gm-Message-State: AOJu0YxaqPvWBqSan0pV6r/TU4oHSBmshgwtc9w1j/1hXcFti1uCNrAm
	CCmC7a2UcXLZ7P/lh6p0siKnjhBlxjOu6iGYANUCveHhOApwwi7xoRGJY0VmBfJ+0FYPZOGqP1S
	uUjSFtmr5wg==
X-Google-Smtp-Source: AGHT+IHcLZagAFVZvHn7R6Bk0sNRHbmj4BNbuwjtI6JLKo9USznZI2FyUOXL0EqWX8s17YI5FdFghtjemXEFKQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:3a8f:b0:2db:f123:60b2 with SMTP
 id 98e67ed59e1d1-2e06ac92ae5mr428a91.4.1727203453216; Tue, 24 Sep 2024
 11:44:13 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:56 +0000
In-Reply-To: <20240924184401.76043-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-5-cmllamas@google.com>
Subject: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
entries and it shows up as "unknown work" when logged:

  proc 649
  context binder-test
    thread 649: l 00 need_return 0 tr 0
    ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
    unknown work: type 10

This patch add the freeze work type and is now logged as such:

  proc 637
  context binder-test
    thread 637: l 00 need_return 0 tr 0
    ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
    has frozen binder

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d955135ee37a..2be9f3559ed7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
 	case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
 		seq_printf(m, "%shas cleared death notification\n", prefix);
 		break;
+	case BINDER_WORK_FROZEN_BINDER:
+		seq_printf(m, "%shas frozen binder\n", prefix);
+		break;
 	default:
 		seq_printf(m, "%sunknown work: type %d\n", prefix, w->type);
 		break;
-- 
2.46.0.792.g87dc391469-goog


