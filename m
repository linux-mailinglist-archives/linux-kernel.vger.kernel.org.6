Return-Path: <linux-kernel+bounces-227665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FE915535
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3176928170B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C619AD93;
	Mon, 24 Jun 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igs+6Ip0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DFBA41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249738; cv=none; b=EG30NzGZqhm9kXcgC6k/AYzza+UtvY1A9t23iTbPk4o+jzgUUfKIccU69TODcMEneZsalJHDkHZHAjxpR7og0bXIOD95MkBSRZwNirkenTTX476krixgjmwW/UXuPXQZaRaxPWxggoT34JImjh3loV/UTdYgwfNL0VweC2NpQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249738; c=relaxed/simple;
	bh=lZGZji4oPKa3khyohelBnUHaZQCOz3Chvj5/5UdmSOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWp4vgVuZ9Un1GQqziaxbeLufL+gAKpkRIsNLo4p5SO1xTupFQjmlJ+QF9+EhATxVIeqSuhfUUthSXvbABvOh+Zv9J5JP3WYoF79VvlqbxtvbwAAv6pgYZ44kP1MiENdv8K1V0/ehCSj3f/79oBRfAw5RPNCwOL0W73arHg76sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igs+6Ip0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-71cdcb122e8so2628077a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719249736; x=1719854536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8bWbmrEanG0cq7LQzNQldcyBiZSyrvwSSnA5ftQoIM=;
        b=igs+6Ip0neMadtXOOpp5IJhj9p2avSvv4O26BCm9jJjyGZV1CYOVOGjEOQm/DO9lVw
         jSF9ZFZQyJVpxUJu+dZ/6Ljcjs/nQXQbFb7RK+JScoXU9t7cKaRHQdko2amP6qWfe5AP
         8bvQ+63xuagsI6QVIBHilIRqjo2U01xSoHVLT4IlusnpY082yPXqfQK+CeKgsEbczaPd
         7PlqCzh23SjVdoF7Pmgh66yiI8zZetzK0Fuay5Umq8tFhP36yRrdMEyf/UelaxkFVWbg
         EhpbPRRgUvgOkUjWwVfO3h9ZgkI66Z+f3yDtb2Boc2ig/ryI3xu1pdcF4h5VsgECbaxW
         HuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719249736; x=1719854536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8bWbmrEanG0cq7LQzNQldcyBiZSyrvwSSnA5ftQoIM=;
        b=q1wnj8Om5AiyfZ2SRcPtl1JpWWWhiAzEfDYlLLX0SX5vn7k3AhwtX9zoEjrL/c1Hzg
         9Wxeyf0SehvC4Xq8DpbLRN7RFM3zM0tg5YvdJ1TrVk1F5UYZCwzXYo7f9H7sbmyrObEg
         krigjPcc6B4ZpZJTdVW6aB+U3/bBID8aflzkJdkcZTR1w0anE0HlHT3oXWhgNofq9BsE
         SNwERt9si/8DNKBD0aRStTN4Faj7lQ9xirkjK3Tfwlg8vC0S+C45Yl3Nu9NkNJJIrYxm
         mMBOzbuQ8P0A3by7NyDSgq2/bXlJCtZjsojxEJcOtKIZJS/8sJSamuAM6ldioTrIp+GZ
         wirQ==
X-Forwarded-Encrypted: i=1; AJvYcCUluDgfrHzyMeIw8/krm1TitmM2QDGg7TdjZPCXpwffMHIhBQ8L2hiFQlMA5PoI80aL5nAjRf/sktJ5Lk3HiXO9FZjYBjYTRuIYfQ8w
X-Gm-Message-State: AOJu0Yxmp5YrLTZEZAImhW17+3JNd9kM6kYyl6Mi28J9pM6bJ6YcOhM4
	eQ3o0GZPvXT0xy91wJPrjVFnJA2H1UVkZvnw3zCtvobACF1vVYICwlyZpov/nD3fu9c0oZ87StB
	CormNGziaL0Cye20YUXoPqA==
X-Google-Smtp-Source: AGHT+IH5BbPfxjchf+mTaxNw4PUPX/0W5Goo/LHtB1JZ/H8+Eem2HMIC09t2UMvj5JOyhX0x0DgwkxPw7gjTQapnCA==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a02:fc7:b0:65c:f515:1590 with
 SMTP id 41be03b00d2f7-71b5f36982fmr18438a12.11.1719249736198; Mon, 24 Jun
 2024 10:22:16 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:20:32 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624172031.407921-3-yutingtseng@google.com>
Subject: [PATCH v3] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

Yu-Ting Tseng (1):
  binder: frozen notification

 drivers/android/binder.c            | 300 +++++++++++++++++++++++++++-
 drivers/android/binder_internal.h   |  23 ++-
 include/uapi/linux/android/binder.h |  35 ++++
 3 files changed, 354 insertions(+), 4 deletions(-)

> freeze was allocated with kzalloc(), you could drop the "= false".
Done.

> If !node->proc then process is dead. Do we really need to continue?
Update the code to return an error early if the process is already dead.

> This access to node->proc->* doesn't seem safe
Added locking.

> Why do we queue this notification?
Yes, this is to get the current state back to userspace. The userspace API delivers an initial event for the current state upon a listener registration, which makes it easier to track what the latest state is.

> I'm looking at the death notification code and it seems it only queues a
BR_ERROR after failing to allocate a "death" and that other errors are
silently ignored?
Sure. Please let me know if you think we need a change here.

> these could be just bitfields.
Done

> freeze->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION
Fixed. Working on a userspace test. Will post a link when it's ready.

base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2.741.gdbec12cfda-goog


