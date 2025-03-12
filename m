Return-Path: <linux-kernel+bounces-557763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC64A5DD69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB057ACF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E07244EA1;
	Wed, 12 Mar 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="nlpvLYg6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4617243951
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784818; cv=none; b=j1hyyGZLLC6atNXbrAnIHurPAQ5qWkV4wGuqnJpU4hmQ+C8c1l3EIuHCoLODWys7on9hLGe2Ba7A3HNVnd9xYflji4guxXxvkG4CmLB3qjOecFiNnyW9rgJrnfWPXBKG1PL563wL8feMN4JqP1ibsIzGhYuR44oVxegxSAfyJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784818; c=relaxed/simple;
	bh=Vv8RYYNN32jkVSIlC3HEqjsVMtw6rjCGH2BUjDQtq4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnrGyQf77mN2qGJV/s0Dwo9DSV9I6nKL37L4wB8kXJ/pvTAvXelqrfaV0DTJMReGGZ6bUnw+O7ZcPJQTVnIc8O3kgk9fGixXgnA7iZlg+tPlKGedE/6tzh63iw5pD8g3l39uldzrmW0o1ZfJDdAZiYhq00UR0w57etdxcMvgdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=nlpvLYg6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso37128375ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741784816; x=1742389616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=nlpvLYg6WRGtMArxzvLvRaDRKJp+d5jFAdwXbOo0jDaBkWH3dUz19QRuRXz/J3AOc/
         lDLxDCQzZlL2NcyH8Rnclx0jt0n6GrFIEk0R+222qgCAkVwc5QStAisXJH0C2wcDS4l0
         OanfFEdGkNlLVg0sJ7PhOnoMMZhK+wAHigV6dNZ8duBS1xnQcCkAxNjHH8/g6jh8dzVi
         8SDQhpF5AFk+7xXcBjyFQyQYoJrjZAHMk9SWNfdBdTWkkzTcV+P59n7DjQbAErySeDIv
         1PjVpt+pS1beV6Lgn0+sDF70C5o6I1it3QJz1KjaSfPLyUQooTN1zwRScf8HelI0dUwf
         ipbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784816; x=1742389616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjzZK8IYtDnC7MfW99ZbF8PngYp+A/NXbbGv9fyWHAs=;
        b=Bde2j6e5974pc12ccmjFPDKKE4gTKngdDtc/ZY558zJgpsNLn/ZCTrbCnawFtXbYDk
         nglzpESR5Mhv/cpU3zgXpvkR3xHDuOpBJ7XMhfT9epBya+V2/jLq1JrHg3NqUcyEUl5b
         ssgpG2qMJcuvsTnMW6Z51s4EAdkObFgL1BCmzDR5JKSN1dl7oMp7qrh3w6kUfHgMycYK
         pfIDFyJdslQJNEtfAZlPUKCsyuQLJ0klGDKURNOY9pGfywQivmKfzy+yA/h3RlhUA59u
         vnbLWmrzrX1/yulg+6nXXNH7NIxN4750GF3hPI7/U54s8HLQg3qvCJ2+f/0z0W9NMdy3
         /31A==
X-Forwarded-Encrypted: i=1; AJvYcCWoAtjOHMsnlCmGfOb+p5cgPpnI0Ru5yvjJug3p4EXy+ErJQsXDLT0/M71ecYzuvP4E//0yTwRFn+kWkPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hSCqAcuTicr+xVOM/t6EkSReI7CO0cAGpiEIJpiA+YpZfc4j
	1qSPnG6dh6G6Dbj24pezn3+rWiPmt3SSCxbuMa9PDreMl9V2daRCsbeMu4XcX6E=
X-Gm-Gg: ASbGncs8hxqcPtz/OrwZWCgBGUcXPq6b2FZW6v8jHBOFUvZDIl+8WT+9bhQzBq3WQD5
	sTH3PK++VLNiGow2BVPyEFBXbJv18xKe9Tf/BzSeO1dv2YVSCe3UENeDWLj71RCQUbVunBmwvHE
	73OYe2j5BxFv5fMwa6uCW7lDUvq++4+6iVUNbIKvjCjLny+S8y08Fcu8hyYcbX4gt84NunWVvf3
	CKUZYqfw+vmXzJtGSTAvTYNOav8GCLS/9J0tyDPaV3GAtmNQqeuvsv+VujDt5uARRbLHwvi+Mw1
	5MBYheS+arfL7fyKWlU0Sj3XIrgckh1zl7hoR6G8tTCpk8GCRtVeo8VgPjcSuPGxgu3Lkw4CnDY
	qW69I
X-Google-Smtp-Source: AGHT+IFamjSNfNQnwjC1H9gJyAaC00Hj63Guc4XKOhRigG44Fv7J/0RmFyGsrfXvYamATdRL+j5vPw==
X-Received: by 2002:a17:903:283:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-22428ab7961mr347898355ad.32.1741784816077;
        Wed, 12 Mar 2025 06:06:56 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7fc55sm115418185ad.138.2025.03.12.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:06:55 -0700 (PDT)
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
Date: Wed, 12 Mar 2025 13:04:49 +0000
Message-ID: <20250312130455.11323-1-sidong.yang@furiosa.ai>
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


