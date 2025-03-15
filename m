Return-Path: <linux-kernel+bounces-562676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B40A630A1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B09A7AB0EA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D33204F7D;
	Sat, 15 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="KnXF5An4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23074202984
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059434; cv=none; b=sx5Eg1OuzgwVZl8jpynK19UyQcDBbi9+tJ4NN/9EtHf9OhAyVer0RrI8SvYQDk5ic0u/8wVFYpu9R6zOxrNAoHNbajlgxrSCYBKhwytKPu+p3SiOl4OE8h//RN+VkOFa1SDx4GRAzoBzL37jqKA59V6T2XDwgjii7FeyEMG+hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059434; c=relaxed/simple;
	bh=eMiVf6KfqTI5zgd9NGL4oAR5xBqRGI9Xup1XAQCrP2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al4A0jPAYAN+yv0AMh8k7eixkexzlzssl3Z2hdhDZTz7sH/98GHpHX4GlF0oJ9yIApleQQxZkIS9zBNi+i0DnM8kXKXaLzUseEGNqX1bUwliZNC5pCLof9r2Yp1+uQbmY3quZ7J7aFdB5L6BfWSjFfp+S6VnyC7NRsi4yE6Yo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=KnXF5An4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225d66a4839so36171905ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059431; x=1742664231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fOkW6M/g6NHBx2eUo/ctcQ4zIQwQjQgCpK4kWc44uQ=;
        b=KnXF5An4RS51ew0LlHVxKsUl7Q407I0m5pdTa7iXaAVYxayN/lE+EdAfU+voTmSl3V
         qin08og7qFH4OYTMoDJfsNZhTkouGOICu/YBj4ucUVQu3MkmlgnPlPFoYQ9cExhJwIpM
         iKHQ54+bJoiCaVwla7QpgZEIuiKi6LhWE4S86gPXThoiT7heDYgTLdAflxijcjOjdRC/
         SRC+VzmZg9vUDJ6pKUiwye70cMDXYkHO1jTG42OVk41Hjr7QbapclXk1TtOVAcf/RDIy
         mfb6BHl9EVKTBBgkCyttJupi3Z+cKrEHJa5YdGTqT9WoorEq3T0woK0Ltfkh67DtDE6t
         50fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059431; x=1742664231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fOkW6M/g6NHBx2eUo/ctcQ4zIQwQjQgCpK4kWc44uQ=;
        b=UyJKxKZiQTtjo2xEm7zqo9yG6f+urRBxnSyMz93PXEkcjQ1rPo3wM+KNa8cDJ45FTN
         s4CuSmmoqtFqOUbVq0+r+0sW3UKQ7gdTr+bIT2TQCcHn6yAVjuY5hpDac80URuqUw2PT
         KUrdu+XbfAxA0QXrIRwag5A+QEWqyCw81oGP4DHL0F2fs+VvQ2hCxHapprD/xA/GnP15
         BmHB0OLgqaJHVwf4gexcINS76G5rqSzlJUEAlZo13yH6B3IPOok/wcGJgyEJpBGCvzbJ
         P96gTLefVDlBONte9uxvXbakKhLJWRcXnHikeiEvwBqnvv3HfwpUGKHN2vdQDoIoa5bK
         RMLg==
X-Forwarded-Encrypted: i=1; AJvYcCVXxI6dne896PL/WSX8GQ5xSfVnzsscFNvcc2qjnGf9NknT/5cLb/S2wy2Y+Eb4kvkpT8Huahx/2jYtMY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpggdsCFDt5O+uRYtlfaXPGdFVi0Rt283QhvnsUP+d2RgBCtQ
	AsVTDF2wOza1l4x7BT/HykH23ZrWQuBaPRvQcKrT9w+eRK0Hlx0V9hJnP1E6rvU=
X-Gm-Gg: ASbGnctOWB+lh2HjuT7w/kHvJdqTtq4VPJx3ZP8CiOT7Ej37X+JzxtOn/NGquacyzJj
	Wh+MISmtn1F2RW8l0g92k3NzySvb16jSGa3XKCeE7NKd191ZT1EJu0mb7TjY2iPfBQ2k2mL4Q5j
	GcrPiNKMLK0GhBXEHXbozHUtOev2/rA4v88IsuLwC3qLGgzwJXyIMJ/zuR0OkxUbSM1onlonHoT
	f/Fyvd1+qlSe8XGjSwZbXYvAyir+LuJT+xMqEICiHYxRCRUKlpB9OxdzDPSfhbcAPbsYvbA8vEJ
	6O5gOBnB2aKuZHdlnZjhRAz+ecLgm39xvwHE64+fSg==
X-Google-Smtp-Source: AGHT+IHKTM3f6+ScrhlzObjxpZKu4z2AtYffjEWvQjvgTGHXpcQR1TE6tL40+vpAUTLVL9K0i9NNag==
X-Received: by 2002:a05:6a20:4388:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1f5c2864feamr8994248637.9.1742059431366;
        Sat, 15 Mar 2025 10:23:51 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:50 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 0/3] introduce io_uring_cmd_import_fixed_vec
Date: Sat, 15 Mar 2025 17:23:16 +0000
Message-ID: <20250315172319.16770-1-sidong.yang@furiosa.ai>
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

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec

v3:
 - add iou_vec cache in io_uring_cmd and use it
 - also encoded write fixed supported

Sidong Yang (3):
  io-uring/cmd: add iou_vec field for io_uring_cmd
  io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: introduce btrfs_uring_import_iovec()

 fs/btrfs/ioctl.c             | 32 +++++++++++++++++++++--------
 include/linux/io_uring/cmd.h | 15 ++++++++++++++
 io_uring/io_uring.c          |  2 +-
 io_uring/opdef.c             |  1 +
 io_uring/uring_cmd.c         | 39 ++++++++++++++++++++++++++++++++++++
 io_uring/uring_cmd.h         |  3 +++
 6 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.43.0


