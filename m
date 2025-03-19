Return-Path: <linux-kernel+bounces-567346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB9A684D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F73B17B163
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFA24EF77;
	Wed, 19 Mar 2025 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="H8BYkdqV"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88C211707
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364805; cv=none; b=nA6+fhYuRUMlphAfb2NKUvshLorLvxlnvWUg6Qy8MD9PunnbHd/lHr2wqu3LwVm054J5icixQWtNbidentqAYeBYATGlFgrgpJJ2FNF4CSpbxPXvWstN+92dVScyrCqcJJcwk1tc40OCNOEjutwSFTarOU8turzvs3XsNKQSXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364805; c=relaxed/simple;
	bh=fgnAZx38kJQsnATPCXUWNm/xxMyws7K44nXgSeGVxpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQiGxjscZrzvpktYv2yOnN8g744otX67M/4bnUpm8WJUgnYMw7vFmEpE/zYwqkrV8h2Wi/MFV0OOlZkiCH072pA87lNxZQjBCzc19kVPAjzW7vee+bwgGuZjjjbSA7VWs3a5HM0v4jGJ4efWfE2sitouDkFOiAoLNOaal7PQm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=H8BYkdqV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so8352677a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364803; x=1742969603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO+tODm7EgareZRu9AnwaIx9J+0t9yuli/V05KPQy4U=;
        b=H8BYkdqVwfZRt1QE5UnlWhpFTE6ENeMyD22hy7dJoA/bXjB8aGdOaUqhIpSMfkaf6o
         XwaUFuUdJ4aK/V8VDWItEn3Dyk7YwS41dEEdMYqZ9SNymxwkk5OU1n1YoGK5QnukTrsn
         h4RE7MfDk9IrH5H2FjAvyQS+lleL3I6UFdZv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364803; x=1742969603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO+tODm7EgareZRu9AnwaIx9J+0t9yuli/V05KPQy4U=;
        b=bidWG6XZvfataruQYTQzRtPz7/OgDV46VmoA+mvH049MWuK/+otS36zwZx451lZ1k4
         1grL/cR6rtIRtIRMBfrRZyxdev7l1LuuSFjiC6iD6yXFtRnmyqP1A4l0MKdXWcpYgyDC
         7yiY8C8nlMO14nlQhtxbkCYEnBYM/pT1p9sAsBwmbrVJLGxYWddiWgqY9Xr32gebbRcv
         V2xvI9Qb4iRtE/Vka9zd531pEKF12zmNtjHqB4HMRmPpjnIttIoJVURaagIdYv5dfW/6
         G7k4w8/NUXzMP672D+8i72Xw3AsH+aOl88HF4X4hp7NVJpHjLOlRmrMraXYkYvkda0CF
         gV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfr+JZG6EjG49Wl97xeMVrKC4EyX17TOrGn7upcpORZq+/F5hIReU93OzApgtPnIGaqtJ9LXqEw2jTeaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnvZChWvBhVvpyXm4/h6RyvfHU+bUdp8jDzYjKGGm+kcvhl28
	n9+mcUvJJw5/mhFeOQ/NC2koeudwml4F5UuEK+Ptl5bkmJTbXG5mbR3StYSEa58=
X-Gm-Gg: ASbGncuEtu/Aca/WqT901wIqbhS0W7N7doNbkrdG/W+GcvWQDbcvfet/YCANDGXXzLq
	xnZgpjz1qZebyM2vqED3Bo25ZQR3Rg1OKo7ixUiHMmNMD4UlkPJxvjuNMNhW0uu/LMDLHxbtMmM
	KOchm8ME4YoN4vAKvdHAKvTQX3hpyvEf9mJY0GRgm0rOW3Z43SIaOSq10LuH2yhwcYJ3v/c9KUO
	HA0Ly4od+oaTPrhgpWmzX3830WBhzkbUJyayBWEkB5LRODEu6hYYSrl94uP4+RoRCua9uhKhEJ7
	mvzGjFbHgKNa2C7V84jwtZ1Otujp2yjbf334h69sg0Dr2o7Dt8/OiTQHv8sIyof3fDWNgBkZ/7D
	BCrmT
X-Google-Smtp-Source: AGHT+IEzTDs9bfHyzrbfJB3F7AOGqX76yXqDNjzD+C2zBRo0LVMeiT924eMNXAxSK2Hv3u5HUl7iZw==
X-Received: by 2002:a17:90b:4c81:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-301bde769camr2191504a91.10.1742364802913;
        Tue, 18 Mar 2025 23:13:22 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:22 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v5 0/5] introduce io_uring_cmd_import_fixed_vec
Date: Wed, 19 Mar 2025 06:12:46 +0000
Message-ID: <20250319061251.21452-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read/write in btrfs by using uring cmd.

There was approximately 10 percent of performance improvements through benchmark.
The benchmark code is in
https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c

./main -l
Elapsed time: 0.598997 seconds
./main -l -f
Elapsed time: 0.540332 seconds

Additionally, There is a commit that fixed a memory bug in btrfs uring encoded
read.

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec

v3:
 - add iou_vec cache in io_uring_cmd and use it
 - also encoded write fixed supported

v4:
 - add a patch that introduce io_async_cmd
 - add a patch that fixes a bug in btrfs encoded read

v5:
 - use Pavel's original patches rebased for axboe/for-6.15/io_uring-reg-vec
 - pop a patch that fixes btrfs encoded read
 
Pavel Begunkov (4):
  io_uring: rename the data cmd cache
  io_uring/cmd: don't expose entire cmd async data
  io_uring/cmd: add iovec cache for commands
  io_uring/cmd: introduce io_uring_cmd_import_fixed_vec

Sidong Yang (1):
  btrfs: ioctl: introduce btrfs_uring_import_iovec()

 fs/btrfs/ioctl.c               | 34 ++++++++++++++------
 include/linux/io_uring/cmd.h   | 13 ++++++++
 include/linux/io_uring_types.h |  2 +-
 io_uring/io_uring.c            |  6 ++--
 io_uring/opdef.c               |  3 +-
 io_uring/uring_cmd.c           | 59 +++++++++++++++++++++++++++++-----
 io_uring/uring_cmd.h           | 17 ++++++++++
 7 files changed, 112 insertions(+), 22 deletions(-)

-- 
2.43.0


