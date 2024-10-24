Return-Path: <linux-kernel+bounces-380121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32A9AE92A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D86B28A415
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4051E3DE8;
	Thu, 24 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAfM0OWt"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED581E377D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780910; cv=none; b=J6XFU0s+T/hQJYWBmO6xIjkOV+Wb8ZZao6c/7MItKig73V3/aFLcZ1ihuROnQQjKG4CCylr/YYGbZDi9WMOUIRzLPeF9a9zMpUSfI1KnIXnBR8FrElUj3VYTgFR9JvB1rn6uerMsXyR6DVDlRUEM2Wom4Y1OYDGr0ctGMYgv9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780910; c=relaxed/simple;
	bh=PB8KBVtiODUPJZipdTOV7LIC3rFuPdVi4OkEXiOycZQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i9FZCaV+wC65sfti78syurSU3E6sChRyVGL3igOfmqnr/cQgiMspnDCFVEuY7l7erYk9ieEMb+PS8B2FmBkNEtJVEFrmtQUl2QEqk6H6Kfieo82Y5P1KX2hIRCE/fljo8AHWzTio2NzWmUFEqTMR5EWCSNs3Lhs5Qhcy0ppxVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAfM0OWt; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71811c7eb8dso558643a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729780907; x=1730385707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZVAlNyX41TJtkmqUex4uvcXk1DCDx1jUZWPpru6ieQ=;
        b=wAfM0OWtqL3UAFrAGLpmyT38YMOJU3RlJGWdA22cvnLzKsG2yrqnbYtdcpxQ2OJdPx
         WHojQU+W66MEYcqeORNuCTGlbG9pByfnkF5MJeaTLH+VFfRMZPEp9Kr5WK/zIlsHFEXM
         nAhu2+p4f61leCBTqz8ktk4UiVHyvXzz1d9IDiC3yDaUc912qBXHLs25YUs94ZvTEhn/
         msR2cz7IR6e+63DoVlXOvcf98K9bUFV6+5lgFB/YGdlRDRMW1/zmy614wEb7zGg/Yp8E
         0HBnylUyITPWdkrV7ZuyAek1psV1xAF6USHUNcPVkEJOwIVpuXNs6jKAziHhmgUHwzHv
         YDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780907; x=1730385707;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZVAlNyX41TJtkmqUex4uvcXk1DCDx1jUZWPpru6ieQ=;
        b=phBlSiN/WAVBey8JxuwGhTAfX2Mm8ndgwkDyUcMgt7LimLHeeAVzQtHyEOb7H/DVBd
         HvS7SgrUvA7eLkmBMvMIT/GL79U3C8yPBhfwg6AbR4DBcQq7104pF2Y6k+s++FKaYmY9
         NdUW7erU6k7OWacV6J76BWPqWGGIXE6M6Kkc9fhVjY9roaFq1Zon/O4nB/nvtyjOexK/
         NsTR1Q7NMP2WTCakglw3qp+SxoRkyYWAjJGqaPbFlvn9HoBcc3V364ECmljLDN6mA47r
         ij1Cc94+4Ed3MvRmmGEa3ovSe7TJ0zS3QpMWl2hk/DwVVRtik9eviMVoSr6mVBHMw7Ba
         SODQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pv8V8gQdGDKxSD9/3dIafB5ncmLfbUkTfXTwayC4NrnAtmir3WKtrT1wwyzdUPoqRG+QMhCjUX2dmnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOor3NnZM3OzhM92poZ/4ElBhhhmNcShV+zg3vXPlnUeeTP1lO
	+LWrjihBFNseAglqwKr1xvkfQ9HDM7mXleTJzzDFeo1kLa7IMHuPWYGSGJl9N0lSr+B+Q9qbrHD
	tugxHLBMeXZ/51TNTR3OBjIrnnqzE/iV7I9lGpQ==
X-Google-Smtp-Source: AGHT+IFoj6HxQyMTP+O33KIqB5ZEoLUAbXegDn8qFNOc1tMmOFYwu+hGvrsVM/tago/3Idtl8FtQq6jNLh4roVRyF88=
X-Received: by 2002:a05:6808:3a07:b0:3e6:261f:5a51 with SMTP id
 5614622812f47-3e6261f61eemr6815877b6e.35.1729780907103; Thu, 24 Oct 2024
 07:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Oct 2024 20:11:34 +0530
Message-ID: <CA+G9fYsaQPsvJdCsezaTu1x3koCzkTBEG8C1NpZotZLXZpZ9Qw@mail.gmail.com>
Subject: stable-rc linux-6.6.y: Queues: tinyconfig: undefined reference to `irq_work_queue'
To: linux-stable <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	rcu <rcu@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Most of the tinyconfigs are failing on stable-rc linux-6.6.y.

Build errors:
--------------
aarch64-linux-gnu-ld: kernel/task_work.o: in function `task_work_add':
task_work.c:(.text+0x190): undefined reference to `irq_work_queue'
task_work.c:(.text+0x190): relocation truncated to fit:
R_AARCH64_CALL26 against undefined symbol `irq_work_queue'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
------------
git_describe: v6.6.57-251-g1870a9bd3fe7
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Build:   v6.6.57-251-g1870a9bd3fe7
Details: https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7
kernel_version: 6.6.58

Regressions (compared to build v6.6.57)
------------------------------------------------------------------------

parisc:

  * build/gcc-11-tinyconfig
mips:

  * build/gcc-12-tinyconfig
  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/clang-nightly-tinyconfig
arm:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
powerpc:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
arm64:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
arc:

  * build/gcc-9-tinyconfig
  * build/gcc-8-tinyconfig
s390:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
sparc:

  * build/gcc-8-tinyconfig
  * build/gcc-11-tinyconfig
riscv:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig

compare history links:
-----
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7/testrun/25533195/suite/build/test/gcc-13-tinyconfig/history/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7/testrun/25533195/suite/build/test/gcc-13-tinyconfig/log

--
Linaro LKFT
https://lkft.linaro.org

