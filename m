Return-Path: <linux-kernel+bounces-574325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999FA6E3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D7916FDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444B1A5B8B;
	Mon, 24 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OeSvl8Vx"
Received: from mail-ot1-f101.google.com (mail-ot1-f101.google.com [209.85.210.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF2157A46
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846783; cv=none; b=iz7d1l9muEA+qIYhP5s0KuAAdVCXvLzGqxCOayypk6w1KsvIyINQwBUtME6ELIAdQi0Yf4iIgqYgvZzPNUuQ/Epbw9GUap/L2WCAl6fEcMtNKK64LfEQYymbPsAK7PNe1ZP1/oc8hrPZReh4ZCJoNsGtJjdrPkwnOAkbF7/Jqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846783; c=relaxed/simple;
	bh=RU4KBmaVK3ygmet+S+vCB8NQAqxuQcm6KN9RxfBHPp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc6gS9RJMoVJZf/d6YAxk1fXNKX2zWkSezBeRy7Wb4JSa1gEaOeIgISZxA0AN2wMBcFPIOJ1csOU3rBcF+5r7VPDC7Gsbk/FlK9fEyFm87r07iPUy/SaYodi76gsjveNGRO/e46pYJ4CkdO2+r2rqe6fiW3Ef2Iz6pLuWFy0bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OeSvl8Vx; arc=none smtp.client-ip=209.85.210.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f101.google.com with SMTP id 46e09a7af769-72c02e22d96so206271a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846781; x=1743451581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTwm9kKLcwau7i+44COu+WxPnQuj//ctrEfQZj6FqwM=;
        b=OeSvl8Vxgg1zNmkrzf+/gwkC1byPqftM8T1ljAntcdi6dkqsaudI6jQgHQY6BOd/jt
         D32zNRQp5JVmxx0212pJBTOdPPwEmeyLFeP5ftN+o89IkVKglm71Bw86hSEDghTI/9kx
         g3MV77vTWnnZttK9dzdlXKwOCnMKJSUqyDLdRP70IVQlo9pbYQlsATTZgXHtR1lgl7ZV
         4Sr/afRvtYZxG84JCpjbtImVQjvJvHESNKsDlf+SiZ4R27A8W/p9FNIA24FeHwfEiF8V
         zqDSO3C3wVuBj2/XIXNzpoG63ckkP0zR8QwvSUjYigd4jUIl1QGeLpyZVthHSi1gwskI
         BA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846781; x=1743451581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTwm9kKLcwau7i+44COu+WxPnQuj//ctrEfQZj6FqwM=;
        b=ZcD5VAVXX/uCkOgd9/sPo6Q+jNays3cifl/cEU3DS6iSs1Y2cyuzAWvMuiheqQ/YbU
         oXnzaulfVyY8ipKCaTAcBfQ2fROSTzXffImH6wUBfwIVsKuZSdfcBnXht1LSc9K9BQf5
         LcrjK6NCOIiRyUSIGfkCmttC9/rpueKM3Zx2q003rzppTtNFWSZ8lyCXZs6H/DHhnGL+
         usEHFJwN4UVFtSRzGRSjilgTQx/C9pTI3yZJMraM/bp1PO+wGwh+yqoWd5pUgONiB3dK
         QJICKc4oPpZ5C1OLXZvQ6GvRmpvSxarI1hf1aAOWebz2OdsQreeADzwhD/ZnAjWObhRL
         d+hA==
X-Forwarded-Encrypted: i=1; AJvYcCXjA6NDJuHYpD99/Vtyu2WY2Krkvs77+Z+aSWIw9rBrZNfTsUM/1sAiG1BiB/y2aet1f+qLGGDu8Qqv25o=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJbU2l1d8AefuYS7HQuXuTlOCMmJpM6yqQZmZ6oi161nwb2OE
	c2uBrx1ABopFcmK0ePUjslUIVACQQ+JFPm3xePyZio5PTEuuyl9Ao/Yjf19jvgsVanMZBJW+OM7
	BkXXWX/NhZ4mgRQR7wjEBfLUaDbnzp2ERidrSbbSZRR1JTKCl
X-Gm-Gg: ASbGncsCpFm/vgiydVyUXWNATvHBNBHdMqhyAvhYYEy50lRH4v71kkeS+DqADWbU4UB
	idlc61aoBzF93J9atbWdS4BNxnYwSR7wRk5/DFm5FxsKke3e9zbMBH4rFYnIK21ivYdZnZYbWZl
	RkoMokppqkiy66l5NlsINiqU+4/9e95w7j1CZ7dx3fRxuixU+lypgmZChLXqlkq6M93H1KWKNp7
	EyUxYc3udsaf/DSfb89cSVbGNGLZ8lJH3RbnagieF+S8TQgtCwGlH0sQbYlFmhk4F67EK36i2cj
	96Viezyk2MXpOvuJ1MyU+2f8ZxRFcoxCAQ==
X-Google-Smtp-Source: AGHT+IGbzC5rsYnWtKfoFuox71C8ckicLGxH9xUNA20u9la2CI41xNym4wlWLHGUxDyKBzS1y+QuAI2Xu6p3
X-Received: by 2002:a05:6830:2805:b0:728:b605:4bf9 with SMTP id 46e09a7af769-72c0af05ce6mr3394263a34.6.1742846780972;
        Mon, 24 Mar 2025 13:06:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-72c0abb89cesm76621a34.6.2025.03.24.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:06:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 23E1D340363;
	Mon, 24 Mar 2025 14:06:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1732DE40ADA; Mon, 24 Mar 2025 14:05:50 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/3] nvme_map_user_request() cleanup
Date: Mon, 24 Mar 2025 14:05:37 -0600
Message-ID: <20250324200540.910962-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit removes a WARN_ON_ONCE() checking userspace values.
The last 2 move code out of nvme_map_user_request() that belongs better
in its callers, and move the fixed buffer import before going async.
As discussed in [1], this allows an NVMe passthru operation submitted at
the same time as a ublk zero-copy buffer unregister operation to succeed
even if the initial issue goes async. This can improve performance of
userspace applications submitting the operations together like this with
a slow fallback path on failure. This is an alternate approach to [2],
which moved the fixed buffer import to the io_uring layer.

There will likely be conflicts with the parameter cleanup series Keith
posted last month in [3].

The series is based on block/for-6.15/io_uring, with commit 00817f0f1c45
("nvme-ioctl: fix leaked requests on mapping error") cherry-picked.

[1]: https://lore.kernel.org/io-uring/20250321184819.3847386-1-csander@purestorage.com/T/#u
[2]: https://lore.kernel.org/io-uring/20250321184819.3847386-4-csander@purestorage.com/
[3]: https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

v3: Move the fixed buffer import before allocating a blk-mq request

v2: Fix iov_iter value passed to nvme_map_user_request()

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 68 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

-- 
2.45.2


