Return-Path: <linux-kernel+bounces-530439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA9A43377
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2DA3B69CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAB2206A6;
	Tue, 25 Feb 2025 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTSd+a/o"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114481727
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453275; cv=none; b=b7Gn1pt2IsTW1RzJO8sd1p6ZIuXG2oThH99xV3syWve8oxBSOtoVS5XdKPg1PO6n/VDLpWpWtkyW0/+7/gGTnsSgTj8hTkTjkcoqdKuR9cReGwyxR+nG/SXuQeVCqH8cNrkLr7gCzf0pWatwCRyXwIwgIOfQg3OY5nT6bPE2BCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453275; c=relaxed/simple;
	bh=MTiii+zQqPJopvoIqRNCl49x8lpdFSLa6UIMeGztj1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oF2cv+FirVe9wq6/efT0GeQabVfVIwk772WhljBwagc4JVkdVlcOtaW3+2B7ABJVOI0W7masaWuIUENbIFIArecL7zyV3JuAXOWDJfmPzbRiY1OV5KG0B9VwGuo7F6bQwKUYac72ArUs0jgcsNZEEdJCG4DHqONSJboWy+WAKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTSd+a/o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220cb083491so10642655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740453274; x=1741058074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTiii+zQqPJopvoIqRNCl49x8lpdFSLa6UIMeGztj1o=;
        b=VTSd+a/o6JmPO5HNpNbuh/n3LNPE4l1PgRiBb/QCAZFOaN9A9/HecRPR9lWbeexmG1
         g6w1R8pt5K3RWiHRqMw+mOs+kV7tFvfZVXgVwEL+oTKXTMKGBH9TOC+7+HzJwvwftUBh
         0IyLWX+c+ZD5zfSQLaZSAp/8aF4UeAoptG7OkJNOi2GWfoVrfrvfKlxbHChV1Ec5fSEI
         aSUvJ6sqnmEvdSflQAeYns+96g+9WGoUxH03ffCdG0eGmlUKgzChDTxsn290ABGAeg3n
         jOFqC3qy9vFWCn1quNSs8l2DPktzyp3H/k2PF2K5u2UJjzTz7qliHKpIYNpc7++RpIuL
         RDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453274; x=1741058074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTiii+zQqPJopvoIqRNCl49x8lpdFSLa6UIMeGztj1o=;
        b=pq0Qm+bDAINsHHJfhJn6FqHUphSu+ul53JhynTE72NDjFuGknplqfUdpYZHysAncrN
         bBG+ZNw3pz/7ESrQYQz4pKphHPszQrb3FBs6e26lEdbiAUZFh2hvwHnmS/0KHnQ2Ofbg
         mfnZYFD7RNajCF+oIZKiDbhpFsMh5NkMvCwD0f5PBeOswA++LlVEClIpcGSuDGXUURvl
         JXbUI2CkzUFpgfwASCapZ3Xm8gVpXd+E6F2iQcrqAPrqsND+BxdLtTY3X+KkCdwMt2jC
         22hEhg5YErp/vySDNwpzn90HKHhYbnarfg+18ykyGspwOF1wkRjnu8+87O9YXz73PbxT
         JhuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZpZPz1CseojIZ8BOn7oTCfjmuTlMEI3cuWH8WHkPK+TXNT9QMDdnkRNOfpJg38umZDjS7Y3ZC3EmvqFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0ht+NMNJHsySN2O0++PsIcMAXRDAaZJNscs1MZHnmkhhl143
	f7pI0T5izqsiiVOxAhc64KvQtnEP35Fgcozj7incNQVuJVwxswIo
X-Gm-Gg: ASbGncsOxv9NkjfUdFfjNZ2KwXzxV3ToqeCxwXXRsi0OPgQ+3Ox8GZSCHy7kvD1szIu
	FdN1MFrMwojvnIYb7K3Gdbf3+Oj33iUlOke/KwZsRQkTMxxbm2cToBG9Dfx+f7GyVBB9cx71BN8
	H1pryEH3/ZJndCGxn5+QQ4A2eNGP2hj6jKMFcjFSSmlJyR1ettkPGshP3svXzvdweqRNCkjug6N
	g+mhPA7QVxGGxEKsgWFKU1Y/R3ZP7QivgB4w3nuptsf/canciT4NZVA1vf1v4QM9aoHkWiCDmoS
	RgWl4loziNKIbhIU9TWJquZ7SpRLr0sapljXKazoeD/SUTkiJ3JYmz5sxL4LXIep38CV2Dh/xyD
	q4wU=
X-Google-Smtp-Source: AGHT+IENisR31wnapQP5UILjmjga6+1j4+iRyv5pEpuKq0rZqZjB5Dc4GFMjy8dLP7W44x5xyZLSqw==
X-Received: by 2002:a17:902:da90:b0:212:48f0:5b6f with SMTP id d9443c01a7336-2219ffbdf18mr96244445ad.9.1740453273602;
        Mon, 24 Feb 2025 19:14:33 -0800 (PST)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0ae9acsm3491085ad.225.2025.02.24.19.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:14:33 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Date: Tue, 25 Feb 2025 11:12:25 +0800
Message-Id: <20250225031225.44102-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
References: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Philipp,

Thank you for your patient reply. Let's first clarify the issue and send a new
patch if necessary.

As soon as it enters the drm_sched_entity_kill function, the entity
->last_scheduled reference count is incremented by 1. If there are still jobs in
the current entity, it will enter the while loop, assuming there is only one job
left. If entity->last_scheduled has already been signaled, it will enter
drm_sched_entity_kill_jobs_cb, but because null is passed in, the
last_scheduled reference count will not be correctly reduced by 1.

Because the prev pointer has been updated to &s_fence->finished, the
dma_fence_put in the last line only reduces the reference count of s_fence->finished.
The reference count of entity->last_scheduled was not reduced by
1, causing a memory leak.

We should subtract 1 from the reference count of the prev when dma_fence_add_callback
fails, which is called balance.

Best Regards.
QianYi.

