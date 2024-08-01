Return-Path: <linux-kernel+bounces-271483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A5944ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1268B21B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC413BC0C;
	Thu,  1 Aug 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sw+rSkSt"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D43A1DA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525141; cv=none; b=cfYG/SHX3OvO5wDfdjBe8JsIG0pWpOlf+0hGVcVHb/r23FJICDf6+HHNTy+AUFJsXQe6sQg9ZcQk00LeOIB8pEUHPKs2vHm7+zzkQ25SMbnx+H8xPLJbrT6gBVx3ciMG0vR3AkQ4yS/SffvSHLjGowLrOI/M/M8rYIRO9bFm3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525141; c=relaxed/simple;
	bh=4bRG4OE5LtNt0K4M2umlVKzUYhufp+M++6Ir2tnUXAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D4PkFRoOyuSWFyi55/S4t++pnbhq20K8CZoqM3yz4ZZ+QvwVCyezvvGSXP3P/nY/rz8CwHZ2fMBBYyleRVwX7hIpH6C/RLiIKAw6mHqFXZzcaSrYZ2LuWt+XA6MVIPL9MXtOz0XfAn92sq6lUOznBw4U2A1rhEyvEOcl+oc8kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sw+rSkSt; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db13410adfso4013257b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722525139; x=1723129939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0EZ+3FD+e/PFQBsEAOnoseW0Xb2So+cYPg0oL/Wd7aE=;
        b=sw+rSkStV9L6HN90xi67l+94k6BFaiNhm61f6yheQhNnKU+xgtdnh4tWJ0RTqr+d66
         38pg9OrBo2K66dTU7tibz2BcL5DPdGp0IDmuROn+OelzGW1LzLSWcZAaYrapbf4JT/8o
         Rd4gS5P6rBf3y/hTXudJDd9PB4Q+SYQA2KsgRtM9v3CyUYtmb61u/VIJYxrH9jJ3JROs
         zbyuujxH/zkn3MYxUmJ26J2Ft2+K/tNon+63Yvci7EpBuza7m/KV1unJlnhawgFMzrC1
         SYahs8VqoyLYPABKxW6JzCIPlnVLc3BK5QHuGdAA79Cdo78WkzUTK1BfTOH8PbOC04Nn
         g3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525139; x=1723129939;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EZ+3FD+e/PFQBsEAOnoseW0Xb2So+cYPg0oL/Wd7aE=;
        b=ahmw9rUq15JTJm/EDte9VRwrKyRsM1KTCgmkZCR+p5xPgtVzHjY7FFB5M/FLkpikg6
         +/985AoTSiqXYkVLuCPHw64kStyN1oFIWBqDQYoUz1fGdLfEP0VfOYVQpSg8bESVUeFC
         KAO8KjMB3nMi/Hqwf0k/FPHbFsItsAJMfMY7na/Dp5PudeMlIZ+xJK8J+Hc35dKUzKpK
         8WIDSetVLDhdrCVa3HybThqJ+9YRcSTjhdSUD7YzX9FffybFQe2rX5/OYr/DvMB5cdGQ
         FQTIvU8l6L7Um5hrsPNCjwbHoi6awfW95qrEj8lVaMUmEw7wpUn9en9QxCYfAcVwMuz8
         8xxQ==
X-Gm-Message-State: AOJu0YzHOSN8Ys0b6KHCshxCzxCxbfYzk1vigRCVIFDTl7T/Gl7nCkFr
	RADRGOGMGoRpEFjaOCS8o5olylIjJCfvtJ/33U7DeEUR/zi4Jc+XpUpn060/JBegGpUCSFM/12i
	3yx1SvYIK4HZF1JwVpZoY/aej8osyQWyjBIJBpP4j9GT/tm8qx3c=
X-Google-Smtp-Source: AGHT+IF7V9tCFIwkCTFvpkg2tD6zCwQ3/PSb+e7xTfUy/IT9doiecUYalC15iGBwlHWOLdgiTH4sDDJtHVM1HvUbDSQ=
X-Received: by 2002:a05:6808:120c:b0:3db:161e:8258 with SMTP id
 5614622812f47-3db5581770amr362204b6e.24.1722525138613; Thu, 01 Aug 2024
 08:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 1 Aug 2024 20:42:07 +0530
Message-ID: <CA+G9fYtE2GAbeqU+AOCffgo2oH0RTJUxU+=Pi3cFn4di_KgBAQ@mail.gmail.com>
Subject: i386: kernel/sched/debug.c:341:57: error: integer overflow in
 expression of type 'long int' results in '-100663296' [-Werror=overflow]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

The i386 kselftest merge config build failed due to following warnings / errors
on today's Linux next-20240801 tag with gcc-13.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
In file included from kernel/sched/build_utility.c:72:
kernel/sched/debug.c:341:57: error: integer overflow in expression of
type 'long int' results in '-100663296' [-Werror=overflow]
  341 | static unsigned long fair_server_period_max = (1 << 22) *
NSEC_PER_USEC; /* ~4 seconds */
      |                                                         ^
cc1: all warnings being treated as errors

Steps to reproduce:
---
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2k2tW5pcf7uulmRCWIAWeormjb0/tuxmake_reproducer.sh

metadata:
------
  git_describe: next-20240801
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 048d8cb65cde9fe7534eb4440bcfddcf406bb49c
  git_short_log: 048d8cb65cde ("Add linux-next specific files for 20240801")
  compiler: {'name': 'i686-linux-gnu-gcc', 'version': '13',
'version_full': 'i686-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0'}
  arch: i386
  build_name: gcc-13-lkftconfig-kselftest
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2k2tW5pcf7uulmRCWIAWeormjb0/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2k2tW5pcf7uulmRCWIAWeormjb0/

--
Linaro LKFT
https://lkft.linaro.org

