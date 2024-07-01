Return-Path: <linux-kernel+bounces-236812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4E91E75E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB78A1C21B02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31A16EBFC;
	Mon,  1 Jul 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hy/n+Y32"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853F2BB04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858202; cv=none; b=IlJpuCD67D6AS6sk5xEu/u109dy0vGxnEAxdBLpMKznU2Rgv8RaztkWwWNInnRDbEFw+WICGc1bwY8y3nZBOne8wC5hI63Cnz/P4jC5NXOkqoxHGkfNtWDm/KOCOMk7Orc+7odeOKNG6nOP7CPJ899EJQHA0YcEBdOsVsKuQSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858202; c=relaxed/simple;
	bh=lRRFmBRLkvPQ0wYXbGn9EdnLusl6DEgTgvFHshUnVdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRRClPpzBtPYuuyZ9Hly1hH1d8cwk5ih2KMczLDnWU/T4wj5wKmozRE3FNz+pN9F2kqg/IcTp8P9CMJuJ56rQktoGnLxr+EfE7b3+dcxmbiQykl0pfn4O5nT2FRf6E2xhTN14KpPXGaCtr63k8gnWiSbA9FHTPfCYlyiVWP1414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hy/n+Y32; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yutingtseng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70a95a33c06so2696171b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719858200; x=1720463000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KDFJNory58LIsmkf2OHzcJAqjz1M0HmdFQBjHm456s=;
        b=Hy/n+Y32LX0SDHScBQZ2VEsWOcX1+e4csodj3wykzi/XnbsQHVUl5uhrwhmNxChpuw
         EAwZo3c7C/rOdvNhyj5MQubB6Od9qn44otRlG9AOSrfMP5V71f2JIYw7cCVo4TnMLTP4
         Bm4QK0QtZcPLWum2QoHQ9JH2uSjOrvx0K1Lfwk44/uoGwTmHbV9xh3Pha7ZsNx4srN5s
         a09k03X5Y7T0q3sVjyFI+96ZboqeMtS0hmPvIATDQfbqHH+nvbEetBm7HYh6/8d5ZeZd
         qSReDRS6OuwazfxC/1/3Ka/io76nN8CvAmZI7Fk790g/CS74iK52RyDm12yUHDSLuyOh
         w8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858200; x=1720463000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KDFJNory58LIsmkf2OHzcJAqjz1M0HmdFQBjHm456s=;
        b=UXjIyVJD3BMiRIIyZHu16LO4CZJz+K1pbg7fs4YkB90MTEybzu32yuDOtFcsi8br0x
         vZaTgVG4cmlhfLeuzKTsska7fqeGMnxPUSvRNmY9drLZzJOaq8wpcCzws+gWeXs9OKSV
         Sj6jtSoru2yL661Szi9jvLgDK7afInfp9qifv5kQBr4elvfGmbHbJyHaqO8zZjtvfLCK
         LbkF0Bh5G/xn2RrkwrYAl9zp/SCG2ywADBXGtzH8JNvtoLS0FsRetHfbfBK0P4/xwVzp
         rLhBxDvKjb3DV+gFzRp8PhXff3XZ7JokkOEG2DHcp5K3U8XUHbmSXbG0wxT5HXmvGGKm
         70Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXUtj+ep9iTbftVLQdNqdafR5tQMM6amWtOCNPcTkb53aVOx18SHFLlIOOIi91MUV+wTDh/C8pqv9lWRUTBRHZabyVj+W7XJn/LIpqV
X-Gm-Message-State: AOJu0YyYxFSoLupwOkRM1wt/MPOq+9kStzSenfKV4BDfsuHAxHONByQT
	xm5+t5yYI/Lj8cPaAZlVBxgISUxDFvlIzU/IDhZROX+RJXr/2BsyivbBn9BzjaypIa1r4U3Ysyg
	tINEVBr2rKd1tpkJuwVZilA==
X-Google-Smtp-Source: AGHT+IHXxrQ0Stn5mQKKD6AnikekuSGwntwbu9Od4Udkn4u0ZZJv7fBIyp0Q1EIf9HDJsC/3cefl4jzJVPxBGp44mQ==
X-Received: from yuting.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:317f])
 (user=yutingtseng job=sendgmr) by 2002:a05:6a00:98f:b0:707:fa7b:791f with
 SMTP id d2e1a72fcca58-70aaad45788mr526969b3a.2.1719858200417; Mon, 01 Jul
 2024 11:23:20 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:23:05 -0700
In-Reply-To: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701182305.1001156-2-yutingtseng@google.com>
Subject: [PATCH v4] binder: frozen notification
From: Yu-Ting Tseng <yutingtseng@google.com>
To: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org
Cc: arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, aliceryhl@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>
Content-Type: text/plain; charset="UTF-8"

> I believe the external link would be https://r.android.com/3070045
Fixed

> BR_ERROR and binder_debug
Removed

> Are we ok modifying the ref->freeze->* space here without the
inner_lock?
Good catch. Moved freeze->* access earlier before it's assigned to ref->freeze so that's safe without locking.

> I'm not entirely sure why we attempt to queue this as thread work
Was mimicking how it's done with death notification. Removed.

> We set the work type to CLEAR regardless, might as well factor it out.
Done

> It seems the freeze->* space is protected by the proc->inner_lock right
Yes, freeze->* is protected by the proc inner lock. ref->freeze is protected by the node lock.

> I believe you should zero the 'info' before copy_to_user()
Done.

> So we traverse every single reference of every single node in this proc
looking for references subscribed to freeze, correct? 
That's correct.

> What if there a EAGAIN error following this below?
Fixed. Moved binder_add_freeze_work(target_proc, true) near the end of the function where we know whether freezing is successful.

> any reason why is_frozen didn't make it to the bitfields?
Fixed

> No need for a struct
Fixed

> You could still keep the original bool for bitfields too if you want.
Sure. Done.


Yu-Ting Tseng (1):
  binder: frozen notification

 drivers/android/binder.c            | 300 +++++++++++++++++++++++++++-
 drivers/android/binder_internal.h   |  23 ++-
 include/uapi/linux/android/binder.h |  35 ++++
 3 files changed, 354 insertions(+), 4 deletions(-)


base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.45.2.803.g4e1b14247a-goog


