Return-Path: <linux-kernel+bounces-239978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B00926782
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940461F22FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE341850AE;
	Wed,  3 Jul 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1Qrvg9M"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09371C68D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029533; cv=none; b=TGGddR5dpNeNvvi1/cfpntTyF7FF4AvnHvXIBVjWRZ9KNDaJvh9WY7V8tEGl+DiB3aY1/fpqsNrCAK4ZLsZmo/Y6d9vBAAPB8KQ3ODbHlaQTpm02DrhlJK4B97awEPaLTbKCbFiVwA8FzRzu+oigxcW/8hblsk8jPjo87OJ2cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029533; c=relaxed/simple;
	bh=ShJ2SRcPXiThajj6mXrDhek7dNOvA0ou4pf8tpzkyLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9Lfj7m2nfwIN24/IFZ6QhQ2g93G9we58f/E7+zLn8SySha5V+j14RipbPq2MoJ+xbxUTL3N40bth60JQTDlXEHXyqzPFKN8RZpP/GbgFBEE3Jx6HNjF55moNoCSYXUUfJbel4xU/QDboyvFAzurgJxISjbj8Go5XpLYMdQ3/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1Qrvg9M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1faf6103680so14006635ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720029531; x=1720634331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps3lG/PULQJDldl+4+0mWuZnq0P9RsTgm5luTvIchyg=;
        b=c1Qrvg9ML5Zu2+34c7Galk6wtaozeKTqIH8tpYrsMw3eytO00ewxiHV1RqVXDod/h/
         dsVmyKV0Zxej8Mf7SVdKxjvo2pFMcgkNSKCU20CffeAGJQiTE92tkuWel5wNP4nOpTVp
         YfvtmB9wlkHy105VQ7/Z9ZRMOKdthhn0LPONgdgGdWv7iG1YL2f3GoL1DiR016n4ddF7
         CXCjKu/NpUESBNulaDkRQ07tCg5W8RQhnAsjXroTA9ZWjNJ92boWsfM+DrqBSdFHc0kX
         moQvdHtW8MoPEHXHA5uhd7l2MfJn4vtt6hS5mUcOIWnmod9NVjbAERQX8ubvMoTMZV6C
         SgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029531; x=1720634331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps3lG/PULQJDldl+4+0mWuZnq0P9RsTgm5luTvIchyg=;
        b=LUrE4vckB+vd7nUkXadW07nGqRjKFmepZxlxXVyqagYnkKXm3SpIymxVtldo0TCw54
         34f7MAplZl70MD8xD002PfbXGyXyh1VjrT7uJnhVL9j9NYCT94ENOHzj8uPS6MLw8GwX
         srOmA2zX5OGAicyk6Hx7vDVQBQbQhTQ8NAGbj8Wgc5yvGqZY2luXJSnYUqen4vEIU353
         /fB39Q6LcRrxE0G0Y89pEU/t1bHix6RbE0IqejZ78wnSU0N1UPEQuF85+LJbbifA0xUd
         pA3vry1YgVwjsa2ITKe9K0UtpPX39hmhfofq4Q5YA4Gr6K0kKMEFwgmEftlXRcSsAM+d
         baEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08xfAYlewJniI6rX9DvZnp9d8JB5pr9zBsZ/3LEEJNQnXJYqDA36x7bE9WIWDIDuoPdEwP1BsV0rY/4rvAMVMy8VxefnpWvW+PLpm
X-Gm-Message-State: AOJu0Ywvp3oaUz7LVYh3Wvr+Yidctgy+AadLXEcgOnXCWhS9+CbY+vzt
	fvqt9JSkqr90z9p+io3cL1N3QqFxdSwceEFxCxZvJg1b1goOfII2IloZKmSnB/xh8Uj8168kdmF
	/D+Ct1wO4Uo7t3STJcaeStA==
X-Google-Smtp-Source: AGHT+IFOoYYSATcHYcupfntr21R/yKcpn4lGfO9MVkHlt7UZSTRxo85sLIpvmU5tkj41yXoq1MvaJPVnzAEjOYa7Hw==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a17:903:2446:b0:1f7:1c96:d2ce with
 SMTP id d9443c01a7336-1fadbc9694cmr9428575ad.5.1720029531016; Wed, 03 Jul
 2024 10:58:51 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:58:42 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703175843.3639568-2-yutingtseng@google.com>
Subject: [PATCH v6 0/2] binder: frozen notification
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


