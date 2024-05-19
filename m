Return-Path: <linux-kernel+bounces-183303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F248C975F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D21C20750
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCF48CC7;
	Sun, 19 May 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj1w73lL"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A342FB2
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716160920; cv=none; b=MB9wO7gEIBOGGOY5YeOdNPIv98jRBmrhKGQWiEpfNIYu4+lk8MGE+GpsYcea/GDjB+YmlIjePTyZnobhRudZ5yk06UICJyRBEFWDi99BxEcJ014orpPtA8BxM56NYpeUXb32xuQUBH5//ti1KgS5qVauYQR04zoi8J1+7Yy+mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716160920; c=relaxed/simple;
	bh=u7gjMjuglaAO5QCvcjIQw+6IPzjFWvmSLcTIn0twOQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcvb3+ME1k0+ihf5JVciSNntYr0GB47EEXeEZXKP4NmdZS1O4diVEqYx8DyS/Bk3etRMSFEVt+koeSwQfFRDXFsFg9ySqYb84OIewQoeCY6kMgEQFuLuh7bhFuzjjoRNXQ+n+MZ6drLfwroc8vQjM/NRY/KF9kh5ajfDJe5lxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj1w73lL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61bed738438so18254467b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716160917; x=1716765717; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BL2V7WIZ6oU98oGtySeECzPZ7Qlj0COVkgIfg+hQpaE=;
        b=dj1w73lLULGuD41YDamiB/0yUFoDyHtFJRoxJqVq0o9WzToIoPz2fGYdJOtanwtnAN
         gonfglkBn5udrrPA7IhxJAIY1xbrvNfdHXZpcYxIg4lBNMulOhIoolW5TAy898KzAgve
         KDwiH+OMIPhBFQV96FG+KP1lFKek/9j+0cUI87jQ5ox9UuHwZdSrAoc+2PxNb84WPeZa
         NWhjtNGNwv/20kFyXL/7yvMoYyjQvyq9KCBrTy2CyQQkQlQbd+Zg+qrN6o9a+TUj0kv3
         ghobKJ9EfH+VHlqB7JCjLt2p49i0N6FqfdVSWQKikQgQpKLsCZxr7W1RVibNIraRLp71
         o+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716160917; x=1716765717;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL2V7WIZ6oU98oGtySeECzPZ7Qlj0COVkgIfg+hQpaE=;
        b=VCZKkmPtlYK1MOQEgCOFTeCmNCA8iETNg7o1KkOsh/9GoDnPPu9BxwlYbL+6UKWVgt
         qHY2ztJK7PRZaJwna7L13tPa4NnHZC7tgf2pdUSaHz7rrzIaOvoXQA8vELvuIaGp0UBn
         yuKd1vIx6ZlfLRVgPTd1xpietKQm+nz6MYg3UGd+tdthVcb+hthepdY8d0J5fR3X5/AI
         spspNzmx87rS+o1B6EXGFMjJyvolb4V3jFxWu+b+ZI8vVDESCIOJulYxO6CvASmOBSJ6
         sMTgCNKDaDbVhF2OxXQTCiMOyaR69c7HifSywafPKQFbAuJbrOqIJtwXOXCace9ddeBM
         /Tiw==
X-Forwarded-Encrypted: i=1; AJvYcCWUuq7JQmlYE6YzFEAtlonTDS6H6WrgZLaOwM51oRqJZ1pvQ9u200hJOh9AWgqE0jmuFhORRt53wht4yUeBIjf9VnnFbVceVO6oZWXs
X-Gm-Message-State: AOJu0YwFgIBrEHsBU66uauDS2ccaftS6wmSDaT6GcZoHTzpbhKvVwO+w
	3STobGqmHQfCes7XAhoOrAfpUHfJcignT7xgTdJsS8KnZPNiNeKf
X-Google-Smtp-Source: AGHT+IFLh51+a2JXUfa2+56Pqmwk10QpP3ph0QdbSeXq/BucqSa382IT61UHLcOEX2dcuvFoFqosAA==
X-Received: by 2002:a05:690c:6bca:b0:624:4154:fcf0 with SMTP id 00721157ae682-6244154fe2dmr190825797b3.35.1716160917617;
        Sun, 19 May 2024 16:21:57 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:3ab1:7ab2:ea8c:dc68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e23abf4sm47526247b3.3.2024.05.19.16.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 16:21:57 -0700 (PDT)
Date: Sun, 19 May 2024 16:21:56 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>, Kyle Meyer <kyle.meyer@hpe.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [GIT PULL v2] bitmap changes for 6.10
Message-ID: <ZkqJlKdwMU+LrLqC@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 678e14c772130d3a83225ed56fb9860a40bca38b:

  Merge tag 'soc-fixes-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2024-04-12 13:02:27 -0700)

are available in the Git repository at:

  https://github.com:/norov/linux.git tags/bitmap-for-6.10v2

for you to fetch changes up to 5671dca241b9a2f4ecf88d8e992041cfb580e0a5:

  usercopy: Don't use "proxy" headers (2024-05-19 16:12:38 -0700)

----------------------------------------------------------------
bitmap patches for 6.10

Hi Linus,

Please pull patches for 6.10. This includes:
 - topology_span_sane() optimization from Kyle Meyer;
 - fns() rework from Kuan-Wei Chiu (used in
   cpumask_local_spread() and other places); and
 - headers cleanup from Andy.

This also adds a MAINTAINERS record for bitops API as it's unattended,
and I'd like to follow it closer.

v2: drop binary fns().

Thanks,
Yury

----------------------------------------------------------------
Andy Shevchenko (2):
      bitops: Move aligned_byte_mask() to wordpart.h
      usercopy: Don't use "proxy" headers

Kuan-Wei Chiu (2):
      lib/test_bitops: Add benchmark test for fns()
      bitops: Optimize fns() for improved performance

Kyle Meyer (2):
      cpumask: Add for_each_cpu_from()
      sched/topology: Optimize topology_span_sane()

Yury Norov (4):
      Compiler Attributes: Add __always_used macro
      lib: make test_bitops compilable into the kernel image
      bitmap: relax find_nth_bit() limitation on return value
      MAINTAINERS: add BITOPS API record

 MAINTAINERS                         | 14 ++++++++++++++
 include/linux/bitops.h              | 19 +++----------------
 include/linux/compiler_attributes.h | 13 +++++++++++++
 include/linux/cpumask.h             | 10 ++++++++++
 include/linux/find.h                |  2 +-
 include/linux/wordpart.h            |  7 +++++++
 kernel/sched/topology.c             |  6 ++----
 lib/Kconfig.debug                   |  1 -
 lib/find_bit.c                      |  2 +-
 lib/test_bitmap.c                   |  4 ++--
 lib/test_bitops.c                   | 28 ++++++++++++++++++++++++++++
 lib/usercopy.c                      |  9 +++++++--
 12 files changed, 88 insertions(+), 27 deletions(-)

