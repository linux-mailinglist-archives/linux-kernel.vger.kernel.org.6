Return-Path: <linux-kernel+bounces-557769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF11A5DD70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381751895DED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7918245039;
	Wed, 12 Mar 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="o3NkZ7ex"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4012E7F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784981; cv=none; b=U062feykN60L6YN9eeOeL2Kl3kEIfyLw35k0DssnNGRV3dLg+gGAlricz+1dBpWzGRm/gVEBceZFiaH1958CYtEiuR9pkKLxXlsPAKI9rKJEBW5SMFBzrVezHcWQoZOzbtqiQkqdy9ojVc5qTYZoLc+WpSaC1Ls4V44OnsF8Pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784981; c=relaxed/simple;
	bh=Vv8RYYNN32jkVSIlC3HEqjsVMtw6rjCGH2BUjDQtq4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZFnwGnmQA3h4EeyK6Rtcl5kQM738D3KMpjVfDW5U9WBtKhlffWI9IIV92fKv+9mCylqQJPRPXc4/SNOB+6tRqOf+Z6Ncw/7yCgrinx8oOxi5sVrzLNRJuO1PqgTvjpBQmWR1faePcONmniEsVypkvZKiX7AzH2Hhm4EH0qTTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=o3NkZ7ex; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22580c9ee0aso49587925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741784979; x=1742389779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=o3NkZ7ex9okIONmJbBbPVyagkm2/DybIppMTlcDYqE1R7MxbQVxdEFheKsJvKguIvk
         FuXZ666QwzfbosnzS2v7m9LKjuCbCZXZtFuVYthZFMQXZL4vPp9wFkkSPfpMGOPyiEzD
         AUuosU4RmcImdlEcMNK3NE62Qcfxmk1Eexc/vtJqd/Klce7s7StREDACzlY8pDz7GNAm
         PShJYSK/93f45LjiaWyAqhXLxgM26hjDGgsL6yCX6T0owV9Y328/k2p4AMk4p27QZlxn
         +NvGztp6cLz3s02x+9FpJ51Asm1E66fECGwVeaH0EdKKfzp4TTqnx9v8ulBZGG4GB0V5
         v1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784979; x=1742389779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=W0bEa13M6VyLov8QncYrFbR9fhheFfZYvx7SaTS3PBmpYQRXzfVaVDsk2i0xpMrcfj
         BUxLGYfoRXjgC5w/2D97jO4IO0PcyDcH/BMGl4cLYvuY7HU+S/X5rei6Qi2tabv7uF4X
         Kz7glK2+AqwO2J384FROvMkOn5nRkMo6vcJlPj2xbRnWNqsVjP8CSUpErWbUhF2RJ9wB
         QZiOT0TEK73wcodZu6iqBXozT8hi/8+jrfKXHDZUlXfi8RXHOVUdqknuv4oMgVNcj/rm
         OYtQxV1p/6vTSjAiGwfmj9Lb1i9amwnbLBkv4YyH1YsGgu8oVyeFAypGv3hSk9Ida/RW
         JU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUmi6ni/KBjDOvjYRB87J8+oOk67m4YwkMaPcoqQVdT/tA4SWTZPWq/npQ3MJOvDRlmd8LbiBNMH7Hr2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VuGDhq4z9Kto7Zcv2L+fCUi+PcHzKWDfzlNgoWJLAMmm6ttV
	Y1C6K7ily02CwgBW1lOe+4hsiEurgMiSb1Mj7BE8iJ1AZRs/BFe9NV45UQ00nUA=
X-Gm-Gg: ASbGncsuoC2YeiNU146FPgaDR4YaGcnAsKitsTRwcd7noY8t8Qp83FzmeekMVPv7VoH
	IEd+5ZuyTDw83k0mEHsxKP8siZq2wjj/hn+zrj5y3t00jPbcGIQE3jzxZd7gJQkwF4Y+ofvdLzx
	X3VXbfH64WfCdSvQumQvi3eOk+PM13OvNDQXd/dyndz/CJ2M7BJitobfQfOACGJbHW4lLCm3TZO
	a2qD2KlQ0G43qANCS7Jani91ZB5SEiKyC4u3/ZUhmTjrk1mitedQ3dAh6GaOnyMTpatb8F2d0WI
	OlIW7udLDUokrZ6FaIS0b0J5g6az8cOK8EADikHYnM+Q+meSB0M1tV1ruOuTHg/v/sTjtqRre6n
	xGW1j
X-Google-Smtp-Source: AGHT+IEw/moyxYqrtJLyuuYhHY0pdrsP5qeyzccAp7ltN9DQfF3V5SgWTYBCiqpn4Sv+xnF5QXan6A==
X-Received: by 2002:a05:6a21:648f:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-1f570afa5a2mr24970418637.32.1741784979399;
        Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af5053a85c2sm9432299a12.10.2025.03.12.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:09:39 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 13:09:20 +0000
Message-ID: <20250312130924.11402-1-sidong.yang@furiosa.ai>
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
for new api for encoded read in btrfs by using uring cmd.

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec
 
Sidong Yang (2):
  io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED

 fs/btrfs/ioctl.c             | 27 ++++++++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

--
2.43.0


