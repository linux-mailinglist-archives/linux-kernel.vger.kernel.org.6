Return-Path: <linux-kernel+bounces-335018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FD97DFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0620281422
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1C1925B6;
	Sun, 22 Sep 2024 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="onqNu5Qe"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BB11712
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726968446; cv=none; b=KzwHJmKxyriz8QUb5/jDa3QXgFGHCsLVvfNDd9mz2SpmAqFcA4bPr3R+AQjgt9hhaueua3We0wgEvHeUCvL8BiniEDHBDoAskKB/MXG0NEHhtrzUhW5mnpXzE18TCVwwuHSGJ2pq/RGWFsZ3ZFA/1M28xBWVxoDYdQoF6H633Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726968446; c=relaxed/simple;
	bh=jhApeWXdt1Yl3qfPidDGfpcHeqO1wsOY63AXNx1p5dA=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q1zN715Vk04oLILxLJ8jgQH70T80EJAQ8yoWxufEeQ6mu738rPGUYJCmmyWsS6PIrBquNVxIEMus7l7DzGXGbigDeizkfK851r+fJrHMLGhD1UNXVGLhS88VdZtby0zNyPRClfP3x96osrwJtW208gOKmSsOEwpKUypcefzaIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=onqNu5Qe; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a99de9beb2so209028385a.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1726968444; x=1727573244; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbFdl7VnXEX4Mb6253inW/2BiKmBhWMhiUAP4BaCSe4=;
        b=onqNu5Qe9x7b4We+2Op1/tgCAHYJIknwKCI6NVWaxoW5Xxtmrkv9Rv7gyRaoXOHyYo
         ff7M9XtufW0EFJMeGGVGEnh7fBXYwmRz+BdmogznjUTPUDBwJJJNAR/YzfcQMZ2yOS9n
         Fb/4ygXkdJxnCwQpPvWavgyK8r8u+t/DrRh3d3ECJQnn99acubJdgDVclr9lcB7Mg6n8
         2xu/dlxVA2b3kL4Qsf46LTt6ZL+uG2o3knnpZ70PvykMLEjSv4XKTCtZMDJd/SPg/aa0
         KDEjZx1RT8/LpBeMhvsmvMJk2/0VpPUM2gUZpRuhTuSbdmM6a1Xrm4eRfd2CNOZwjePy
         hEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726968444; x=1727573244;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbFdl7VnXEX4Mb6253inW/2BiKmBhWMhiUAP4BaCSe4=;
        b=habYgDMHLP+o4bmnKMc8lxdac4vu47dB8kSaEGl8ekj2mF4t/9UpTNmcBNQO/urU9U
         mJjPkdyzwSGSHZdvQRnxBb4KqeaLNXPQru5aqZc2RfZlcQq7tz/SLLvFjZxjbGjkAcgM
         0aU0fEPhZRvo5/iqqya/Wl71EXPcE6TIKBd42zKTIXniN1kYCbRian+TIvwyWXuYB313
         zdyJ70No2xuIiZzIohOcTptiJZDqVyOuloqdZuTa/+ynF+o0HDtub6ojGL3/C9jesDd5
         ueRCkXAmuHDzCendq9tRWGdLLq9+MHNb6elYMBspFF3NwO5fvo4ZaMKGqytefUozrmU5
         gITA==
X-Gm-Message-State: AOJu0YxO8tv9q8R6FDxyiNhiQCAGRDcJo/RL+9pprEN2xUQTrk5f3akV
	AyN2RSAThZ2SNZr6k1vqVqCmC2M9hY2sjdPzmUmoJuqGeF7+4MjzD4ghK87/lDSJy0GC6rx2RT8
	=
X-Google-Smtp-Source: AGHT+IEhl551TnvEEJss7ZzCqTbWO2F19ZkWKlgBIyvPJ3bYZZrKvTQ0j2VVrnpt80t+9fxizdDGYw==
X-Received: by 2002:a05:620a:3908:b0:7a9:bf9f:5ccb with SMTP id af79cd13be357-7acb8d813c1mr1118210485a.1.1726968443952;
        Sat, 21 Sep 2024 18:27:23 -0700 (PDT)
Received: from localhost ([136.54.20.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07e01c8sm335928985a.19.2024.09.21.18.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 18:27:23 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Sat, 21 Sep 2024 21:27:22 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for v6.12
Message-ID: <Zu9yehc5ZdgUO_Ws@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a few NTB bug fixes for 6.12.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.12

for you to fetch changes up to 061a785a114f159e990ea8ed8d1b7dca4b41120f:

  ntb: Force physically contiguous allocation of rx ring buffers (2024-09-20 10:51:25 -0400)

----------------------------------------------------------------
Bug fixes for intel ntb driver debugfs, use after free in switchtec
driver, ntb transport rx ring buffers.  Also, cleanups in printks,
kernel-docs, and idt driver comment.

----------------------------------------------------------------
Christophe JAILLET (1):
      ntb: Constify struct bus_type

Dave Jiang (1):
      ntb: Force physically contiguous allocation of rx ring buffers

Jinjie Ruan (1):
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Kaixin Wang (1):
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Max Hawking (1):
      ntb_perf: Fix printk format

Randy Dunlap (2):
      NTB: ntb_transport: fix all kernel-doc warnings
      NTB: epf: don't misuse kernel-doc marker

zhang jiao (1):
      ntb: idt: Fix the cacography in ntb_hw_idt.c

 drivers/ntb/core.c                     |  4 ++--
 drivers/ntb/hw/epf/ntb_hw_epf.c        |  2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c        |  2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c     |  2 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  1 +
 drivers/ntb/ntb_transport.c            | 33 ++++++++++++++++++++++++---------
 drivers/ntb/test/ntb_perf.c            |  2 +-
 7 files changed, 31 insertions(+), 15 deletions(-)

