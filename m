Return-Path: <linux-kernel+bounces-336282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A297F189
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5288BB21AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A11A0B15;
	Mon, 23 Sep 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UAzz5R94"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456871A0701
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122003; cv=none; b=e5rYk2ubLq3gzVRboBsKnMyKti0bnxPS4hmXYM7SlIUTunkNNtJhJ4BTpFW5Z0q2YSuGRhVecBduzPmusLBzhDPZvO9KXcYsyvvCee9lO+e+RyxaDNYbv5b7biB9k1Q280GazgNRcG9Z9LXz+s/bSv8hXUDFyqABT7BnLrrwzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122003; c=relaxed/simple;
	bh=2qClRv2u51HJ5DZ5ukRUKKJBNtpQA3BByVkkJAoymBg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=fBhYssnT0w1RiT8I4ovEDrd9pDvJMZUkgdqBrPStFNPX6Ncq717Bmzcb9E6wpOfOtKI6+DV09KMQ5lBOqvhlT0yJuo1PYf35Gz9U23OKnKoe7xmncNqTqbF2whlevGNmykfjC0UhMfPaMTig/UUIXz22Qv0nqHPsuJSRv6YUpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UAzz5R94; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5dfad5a9c21so2412403eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727122000; x=1727726800; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P23y1Kzvrc9ngvdQj04Xt+ODVVaQhl42LTZ4zzaCVI=;
        b=UAzz5R94Fp+n/xug3G661zSiRh29cmL0JeE4UyveWGGS0os/G7E7XL4nbXa6mjZHSW
         XeqaqSXppFC7T2hzMC1mZZeupUkn2/z7HqI9pTb9z4GYBDcbfZiyxCh5I7Tezmz5vgRt
         bYbLtyy5F9mHjDFydrsN0JZhPnPv140+Ue97NkpmGQhXDs5gCvZo3LOmIiRisIaRg3zV
         I8kJaJxf5ZW69FreV41ndP5v0ZJVYRDlu1Z2386rMwkskOLZU+Pz/v3i0cGIs9I+/Ejk
         eatExGJdH6wnfoEbVtu6WYJdzaV3Q9WoXw2aFKF6I3F72Iy934/ttSYKU1joE5PJnJha
         fC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122000; x=1727726800;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P23y1Kzvrc9ngvdQj04Xt+ODVVaQhl42LTZ4zzaCVI=;
        b=Rxe4O8zS6FsBc+sohMN5BuYAurbLFMmnEEu3D2bzlsrZKIlv5DiaS9ou1hVHabxmSy
         2aP/i7AiFhppgDXYBNZkRHVS3HReMKg7/pcmJmvae853enHfR+qic/6Ct8gUGKErgf+y
         xJxXu6GtTgh7B0IBaEtluq4LKVLt/SSGkeVIOUtPHl9fR/XeML0HpfFrPKUwFlkziIoW
         Ut2zkGni3mc7YslChotA/VdidxtDsBquz7ivbUktORyUl1y1+X6HQltVxQAk5e3iRs4P
         4RD2x5RtuAg5VlU0XuDdG5nQw6SrcrymP+te+wEeF91ecG+xe+PlhNB7Ek+vCT9v8U1w
         ZOKg==
X-Forwarded-Encrypted: i=1; AJvYcCVobEkMvi+Ldpzc9XYnSlTjBJV6W3MMii5iyTKGW0ptutzOlBTSjA+U1HUdksL9heOHTwON7SbR9STjNmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdWxFHhLSsA8dbiUxdMxDmSSDCf497Bepq9RlNK+WOeeGSSfK
	LXxSKdby02q/Qq5N6piJ0z6GPu9wk//H+8q6ho62U1dwvt9pcKZ+4YIUFSynpg==
X-Google-Smtp-Source: AGHT+IHexHQcsFqylxyINccp9kWCtDo+YRAuXa+STnGUXXNG5JGJmYCFYYfO0q8GOE/iRfJxrGYhKw==
X-Received: by 2002:a05:6358:c6a6:b0:1bc:d1b9:ccc1 with SMTP id e5c5f4694b2df-1bcd1b9d28amr41439555d.16.1727122000254;
        Mon, 23 Sep 2024 13:06:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17867eb0sm50109261cf.12.2024.09.23.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:06:39 -0700 (PDT)
Date: Mon, 23 Sep 2024 16:06:39 -0400
Message-ID: <d46aba81e752a28ebf49ddc49fd1aed8@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240923
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

This pull request updates the the previous lsm-pr-20240920 pull request
sitting in your inbox to include a single one-line patch to IPE to fix a
random selftest crash caused by a missing list terminator in the test.

-Paul

--
The following changes since commit 19c9d55d72a9040cf9dc8de62633e6217381106b:

  security: Update file_set_fowner documentation
    (2024-09-09 12:30:51 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240923

for you to fetch changes up to f89722faa31466ff41aed21bdeb9cf34c2312858:

  ipe: Add missing terminator to list of unit tests
    (2024-09-23 15:53:37 -0400)

----------------------------------------------------------------
lsm/stable-6.12 PR 20240923
----------------------------------------------------------------

Guenter Roeck (1):
      ipe: Add missing terminator to list of unit tests

Paul Moore (1):
      selinux,smack: properly reference the LSM blob in
         security_watch_key()

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

 mm/mmap.c                   |    4 ++++
 security/ipe/policy_tests.c |    1 +
 security/selinux/hooks.c    |    2 +-
 security/smack/smack_lsm.c  |   13 +++----------
 4 files changed, 9 insertions(+), 11 deletions(-)

--
paul-moore.com

