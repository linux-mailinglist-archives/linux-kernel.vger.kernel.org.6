Return-Path: <linux-kernel+bounces-376190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A357C9AA155
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C001F22ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB019C556;
	Tue, 22 Oct 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgRDrhN8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CA45026
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597689; cv=none; b=JIgovO/Z0+n7ecuXb+n9s4YuzBfdhVgT4Vh5jBdff5ZBJOEI496c2m9sgypkY5B1zdHzrGJ8A/c9LSF1WByavnuXD2F698HV+b01+MvYp+/24l8OHvDRqJ2x8Ke2q3AumZiEDeQUaDFB3c7H+4FD2UmdnOvpSKbJQH2rZSWF2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597689; c=relaxed/simple;
	bh=K+GFSODQZaSWywaYiziQUujRKZEgo8vCbwx2j3r3cs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loDKn00LIZRjSocSHDAs+sIMmApUo55AMiTxWlnaaohgaFpk42BfU1GGfzSIsRGURQHEIjmdo6zrn9KdBrvAwrKjIyd5W6YVlr0ihJVyeCHNu1H6r1oQsMyr3vm3RYodKWTCWVtLolsL7H13p08VcqmpBtm5Dyf+FcNBvjoA6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgRDrhN8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cb47387ceso49108725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597687; x=1730202487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aix/fJFji8qXSyMgAkZiqUftW7RkYeP6GgFXFbZAYu4=;
        b=QgRDrhN8eCzzo+AT9ya/y/H+G087oOic7HTx1AI5sPlpp1l7toITu+v0wLyKscOOUY
         skmrD8GjZS0D9WwxIPtqJpBCKWz2HNfJ0HwZXRpNUr886aARDolea6y7xJ/4M5+bC98x
         rbbVbeJYvx5vf66Pn+bIhRnxPEwY2h8oLbXiolYjgGqFa+9+SV+4rXgQvhrklHc0Ye4Y
         lsOu+A37pJqvVMA+NJeXMDUdw7NMzNb30XhH91mIHra17zQ7xFpzZJNdSNh3hbL7NjXf
         HgmMbzsvfzFjMV/rKjkhl6VdKQ2OyeQaGhKpmlE6RPImRUg/tbVZWqjrcvd1EM2nvtVn
         gDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597687; x=1730202487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aix/fJFji8qXSyMgAkZiqUftW7RkYeP6GgFXFbZAYu4=;
        b=oD5VquVhZT9vKivVBXzEi/9YMGIXI70qNpY9vOZ2wlsW/6cVZRDG5sKy4Z04vvQWzG
         nCqYpVewpT/UPMdd2nwInxAFaNrAFMTn+ZfLCOYXGG6SKhLmodIcZ/Gb3USJR278uSyX
         0INMUGk3g6j8W6SrgXwcKtKdKFoA85o0Hix+GRg2iGGbvcZuqgF50B8/gl99U8RZz7qz
         LskfArBAh7KlFQ0eFxC1yTm7U9UliokzX0WlmAr2Ngas1Vki/sDZIZu6TKbIN++peAKo
         RECrjWDocSD0Xjgpcfbhq0dKKjs8qAWOR24jO8Tig0vmyfmDnZQLG9RSHVbo2eyWbz9l
         kRzw==
X-Forwarded-Encrypted: i=1; AJvYcCWoK3DyY/56kjGfkXqYIjLmXpxLcy4RqRgtYVNYPp9t51mg720IYZxSo2eqwxFircI+b1R8R9wNbGqh9U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHNK3KDjmco1h7C7fcWL1YrnnUyvHrijXP1cgmgB+7eNJS1gV
	cHXs2o/vLIwQeL+6Hx5am6ImTHyrgpGXak7WG6G3rTIy/Pd9LlAx
X-Google-Smtp-Source: AGHT+IHZfTrQSfOJKUUPfVwkqMDL5NClGIhS/oFuKKL/FMeRej9NneZsBbGCfBBEYnh2eoq4NXO9tQ==
X-Received: by 2002:a17:903:990:b0:20c:cf39:fe3c with SMTP id d9443c01a7336-20e5a9055d7mr237378955ad.41.1729597686741;
        Tue, 22 Oct 2024 04:48:06 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e13bsm41147145ad.65.2024.10.22.04.48.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 04:48:06 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: cunhuang@tencent.com,
	leonylgao@tencent.com,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 0/2] hung_task: add detect count for hung tasks
Date: Tue, 22 Oct 2024 19:47:34 +0800
Message-ID: <20241022114736.83285-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patchset adds a counter, hung_task_detect_count, to track the number of
times hung tasks are detected. This counter provides a straightforward way
to monitor hung task events without manually checking dmesg logs.

With this counter in place, system issues can be spotted quickly, allowing
admins to step in promptly before system load spikes occur, even if the
hung_task_warnings value has been decreased to 0 well before.

Recently, we encountered a situation where warnings about hung tasks were
buried in dmesg logs during load spikes. Introducing this counter could
have helped us detect such issues earlier and improve our analysis efficiency.


Lance Yang (2):
  hung_task: add detect count for hung tasks
  hung_task: add docs for hung_task_detect_count

 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
 kernel/hung_task.c                          | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.45.2


