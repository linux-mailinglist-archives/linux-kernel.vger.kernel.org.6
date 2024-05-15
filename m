Return-Path: <linux-kernel+bounces-179846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9D8C6655
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D11C21F12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861E76035;
	Wed, 15 May 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dGz7X5wx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED711745D9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775887; cv=none; b=jzPbpConw0KkzZclB3IkG9GOSJI8mq+lnFJhZdT6w7sf1UdMAUTiFOVArcVodD8TdEE5IFJjqVbFdxlFMXKtZm2tH2g/ccVRMZO4ynG+1RwAcfqYamjMq2PjeH7He/A0yZWUMqp93wqJNaJ3WxiLi64FtN+TnkVfpSq6iyh0PH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775887; c=relaxed/simple;
	bh=I26vxRg0Sm3JVFBxBEuZ+GowCZD0aQjHCSLl80qSBxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d8O449QfME/LAmX/2YivYSBbN810MXoUBE3lawshB9uPpcScp6b27ZI9c57d2IUJP/oGEpcNuJs989aL5jfQEX3qAG3asesCSVwjqXr7qPH8OORzj53fCTgKME7zrO5UXfrh/8JL1OPaQhZJBLzbmqmwRc8lN+akuPvorTTR3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGz7X5wx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so1842338a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715775883; x=1716380683; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6M7AXHWYgFp+anZ+3MDmxURX8URiX5ZduGDdYauJYk=;
        b=dGz7X5wxFwrMHzs6Z2/S35Bgt9y4ZmZQNloQ9g31DmzzSXH8x9pXybRWHZQiOkmozB
         Z7TgpIGsu9gVg0o1Sd0FcMftSc1IQIoKAGdaxSdwkz6/Ct6LjeiEnIc3kzRFktnOD799
         jHPrdXoB/APDUk+x3gOxMOrtgvAqtRR2aanitTqywROG2bHClVx08AnLIpwIM3GMolrs
         lcItEUtO0+24p1fgYCfU5tixdfrhSI194EKWy2l94rIPpcd68BvjdcyGBRPpn0vppNgr
         0MUP+me6FKRl9MjuYGBhamABR9l0Kswmp1xTjM5eyzKG324W3y4nlS/8ifMtySOJGw85
         52RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775883; x=1716380683;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6M7AXHWYgFp+anZ+3MDmxURX8URiX5ZduGDdYauJYk=;
        b=MbfZ7MTdZVnue4yFwboTUlgE8qWEfj0hj8lt+W0m4ZQ/sw0IHLTfYGX/6sNPJyE2A9
         srLrqmyGgKQJigWcsOdR4754eDV8bSLgfeWotTmSk8f5EUa5Qxuh+863WGyvMyxzbJZT
         5XpxphBTPA7OP2l/00CJovUJYtYFBEH2kn8t0J0rMfBnj9IcSYMakb2njZl9LEugkIdE
         GoyJbHG4cZ2Zf1meKshNFEwVvPuMaroqpPsQPRPDP9hQND5L9EjIaScB2Uj/pgLr1SzO
         Mq9v6eDmFVHVGSgcP+nJUqP/4t1bqeQO7YOs0KCj1NPfC6b7+KlIIA7EQKCnEvVdSNO8
         v9Aw==
X-Gm-Message-State: AOJu0Yx0QY5TDyRoKbjp9hYMy/Aqt7bZnNCVxg9crkHVxkwmlzMqDXwJ
	hPMpolNZouliig/dp2HPUaRST+pvfvjGmOn5Rge4MCVBuHDkaI9+9HfkZd9nzEI=
X-Google-Smtp-Source: AGHT+IEYNfUrv2/IkKempwARG+LxeAXOezDLELUSXDXLZzvO24ZghEbY+Byw8CnRJ8glbgmwC8HBrg==
X-Received: by 2002:a50:d5d2:0:b0:574:ea9d:51f3 with SMTP id 4fb4d7f45d1cf-574ea9d5459mr2726695a12.15.1715775883276;
        Wed, 15 May 2024 05:24:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb52asm9035307a12.74.2024.05.15.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:24:42 -0700 (PDT)
Date: Wed, 15 May 2024 14:24:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.10
Message-ID: <ZkSpicJYoMleJRkY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest changes for the kernel livepatching from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.10

==========================================

- Use more informative names for the livepatch transition states.

----------------------------------------------------------------
Wardenjohn (1):
      livepatch: Rename KLP_* to KLP_TRANSITION_*

 include/linux/livepatch.h     |  6 ++---
 init/init_task.c              |  2 +-
 kernel/livepatch/core.c       |  4 ++--
 kernel/livepatch/patch.c      |  4 ++--
 kernel/livepatch/transition.c | 54 +++++++++++++++++++++----------------------
 5 files changed, 35 insertions(+), 35 deletions(-)

