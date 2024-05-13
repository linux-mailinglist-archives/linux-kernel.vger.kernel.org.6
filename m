Return-Path: <linux-kernel+bounces-177315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA018C3CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB401F21B69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A746146D50;
	Mon, 13 May 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHiXjQ7t"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C49146A64
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587403; cv=none; b=Clf+XPWUXLmzpgB7NJWbpMsSATZ7JTupMKI29oD4pSdwI89vQy+QBww2tWl9MuNEfAsJCLUKH941B7kdp9PdI9qJ+I6d9IFaqDGUgnmBcmuGmK2+cGnYxj+3Ha6Tngnjxlc/oAf27NsDzwZAE+1igUwNGOvGmeHIQI5KCDMy0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587403; c=relaxed/simple;
	bh=23uWuj7ICqa3qQCSJxZ9h9ChpqiL/yGtIf1aTLfSpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Trcmyb1Q5ulNNeHH4IM+WEMF864oOYnW7NAZkkbJM5VwfuKyOfTlGhSI/4Cmr23g+Y+59rsIOMWiC9y1AFCz3ZESOYGkSj4TvpGSXFL63dSjrYohH2pgi9kPil4W6kbGvy8Ba1tQaeMqSq7hITGFzh/Qya0TcyIkbf1MRCwK730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHiXjQ7t; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59ce1e8609so877900366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587400; x=1716192200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnZ6trVhzdlXSKG3rKBrCEdLdkgOZsBK4FUKMxCUy7c=;
        b=jHiXjQ7tmi1NqBaI3GUirUyVepKe+K3dKIz4N7lY2vzT0nuZMd2X+z5r4iTmZxcLHy
         AgQohdjkGAhDw79lmkm3uJLsSnZxOc35sHBUlpxWLWJ3hVNbnMl7RgM1IB3joIFnlS+7
         JdwZAejdfRTEUmd7kR4Es7jaXPje/KvGsEfH0x5jFbO/DoqbrbzRlrqP5+Mg+tORxJlX
         Spc/XpZiBSJutFRs2rO/IoFY+/2hvGP4rAg44AMKHtkGpKAVA2L/+AJ1PkkZh09cNPJF
         5misHSnHSoF0tt1kkKeqD72X3spvvUZAUOqeuvxvA21ua2XNnJNDYT/rjcckIafUCCGG
         y7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587400; x=1716192200;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnZ6trVhzdlXSKG3rKBrCEdLdkgOZsBK4FUKMxCUy7c=;
        b=hT0VgQmJWBJGV43g+HsoPKSo7RNNztDxqWTv2uSSDQGlyhMpizOBOhZuhgM2pYvhUB
         UZK1w778DbVHx+SqgU3U1NnvdyfDdoz6Rmz53kZAzdTEV8ABb/rftQ/RNzCVGU/nQO/2
         l2eXw9Su16jpMtjHN3beb9m7tGKab6nCIgJ0n++ged255af5Sve0pM7fhH87QGehSLlT
         oMqO5V4oe64n+lDBxqi/ruwCF8+kPMIi7zCUpUpKcWhl4BF7EJs+rMUV6gMeknFtccVx
         61L2Bevn8vk0rPHRlwsgwepXraShW2GtdYWex9pUaP7783OO1EmxjP28wmgQrCuz5rsn
         1cYA==
X-Gm-Message-State: AOJu0Yya7VlRLxtKU8W6hvSp++FuKHZGcX2Jgh9MRbTZZXdcuR/B8sit
	ui8jSitlLLABuie/YfDmr1HgD2vRfcKAibE5XHs5K8+a7JTBE5vh
X-Google-Smtp-Source: AGHT+IG94D9DPyExALzgvsPjVqXg/C4+F3PXVM5MqYAZ6Xxfs8MPAM5TY6AhIDt6jLBUQMByxvJBkQ==
X-Received: by 2002:a17:906:8315:b0:a59:c807:72d3 with SMTP id a640c23a62f3a-a5a2d1ddfebmr773843766b.17.1715587400101;
        Mon, 13 May 2024 01:03:20 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892444sm558300766b.76.2024.05.13.01.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:03:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 10:03:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/platform changes for v6.10
Message-ID: <ZkHJRYpDIBpxWeyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Linus,

Please pull the latest x86/platform Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2024-05-13

   # HEAD: 801549ed6abe7586eb9ad0cf7147b0bef383ad22 x86/platform/olpc-xo1-sci: Convert to platform remove callback returning void

x86/platform changes for v6.10:

 - Improve the DeviceTree (OF) NUMA enumeration code to
   address kernel warnings & mis-mappings on DeviceTree platforms.

 - Migrate x86 platform drivers to the .remove_new callback API

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Saurabh Sengar (4):
      x86/hyperv/vtl: Correct x86_init.mpparse.parse_smp_cfg assignment
      x86/of: Set the parse_smp_cfg for all the DeviceTree platforms by default
      x86/of: Map NUMA node to CPUs as per DeviceTree
      x86/of: Change x86_dtb_parse_smp_config() to static

Uwe Kleine-König (3):
      x86/platform/iris: Convert to platform remove callback returning void
      x86/platform/olpc-x01-pm: Convert to platform remove callback returning void
      x86/platform/olpc-xo1-sci: Convert to platform remove callback returning void


 arch/x86/hyperv/hv_vtl.c              |  1 -
 arch/x86/include/asm/prom.h           |  9 ++-------
 arch/x86/kernel/devicetree.c          | 24 ++++++++++++++----------
 arch/x86/platform/ce4100/ce4100.c     |  1 -
 arch/x86/platform/iris/iris.c         |  5 ++---
 arch/x86/platform/olpc/olpc-xo1-pm.c  |  7 +++----
 arch/x86/platform/olpc/olpc-xo1-sci.c |  5 ++---
 7 files changed, 23 insertions(+), 29 deletions(-)

