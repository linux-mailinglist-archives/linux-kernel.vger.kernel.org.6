Return-Path: <linux-kernel+bounces-341974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B162B988916
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666C72815DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86816DC36;
	Fri, 27 Sep 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtSbMFNn"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1C3FB9F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454748; cv=none; b=UvUExUol0xGw2ML8/jByAxsmZUinc+k88dMNn5X+YfWhg5+M89OBfi55Z/XVBzw+aTOYJgUBabKPvtxN5zBbZMCuAAihW/2PZAeIFMF+6ofQgnx4lo0LkNqWggLsAvq4kmeviIhYbMCMMjGFf4yeSsmAGpn+6yVjVud9nzrTPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454748; c=relaxed/simple;
	bh=R7iLRmlbW2z7n95nhD62TZTfGF++V/AaCVV7l8V7G/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hgya1DPjqa6FlYJQpg0VmDnqomh9ubtVj7dFTJiFJaEvrU0lK1hUT+REmCjMa8jLqY4fxfiF43zRDBCD6WR8g2LEGhw68k3a01uybUe8HPujIbEkvlaU5WBk2Uann0ggrz2/g7BrMHwOltDoE8bG/kblBJ/pZs47FRA6R2d4C00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtSbMFNn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e251eda7f03so1981773276.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727454746; x=1728059546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6Or4vPk3tuAO5mXuI2AtTMkyCz+PuRrLhi4qPbQM70=;
        b=PtSbMFNnXUwHMd4JvnX/I9GSsMLY15tl9pxCZzVTKbud33DF322EyaCLgU2Zl0CUrO
         gof40wvyNHkg1wxz/N0GbfWV/KHHCbckQXURYFSk7HpTzaZfnYnETTt49Sggy7aBuVBr
         ak31zFWWBaimXs6pIO70eahnSiMuQixok3DMzigXL7I7inJZsY0PHCeZZkjzgFpcGlzw
         zrKn89Srkfs5OVy6ifSTlfd8Ang7olP4fLjxdCszugLU/8RAGIrmAloaTd0GuV9g35oM
         QpYCUp+Kvqne4/eK9mRHdi8Xs1RdVVOWri+rdEJO2FU8P+JAulQEKfhPW9FTtWHkte8S
         H4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454746; x=1728059546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6Or4vPk3tuAO5mXuI2AtTMkyCz+PuRrLhi4qPbQM70=;
        b=sd4QOkBD6DX8qp5+Y7NuwgXv9IDTDjzLLgWwpz0g/GlTSufQiemv42FoRWkSwXYUCs
         2I/Xd61UtHgxRo5/2H6VqT/zY9I9YvT63r2l3EpqWl6aluBa/q5YWuaWCwhmGACZas0i
         CuOJx65DSsycWTsooYfSxlUtdDyP1obpi9SApDfZkLIi+wpkES5KtPhoL2QyR68N8omy
         UamfOBfNFAlY0Bz1XABnhhkREPJkJEJgovNxk+33AEgmETcmrquOufyNsz2Ck7i7LdcC
         Kk9++4+vMpZ/o3OL4Ic9rkyndKgRrDpU2HDvriUTtjJVE8BmDQkaS3GmXOhvkdRyllV1
         pv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVKrx6JtEkNgWt5uU/jMde3X2XLNFp6A5Rh3FpWyGtFXIr+TgBLMBWWEWKe3ILZfj/bPMhzQErFYBChsWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyljMxNFSItMkQ3DXTnUFH3zrmUVIz90+dBaEnQySSYi9G4UR2c
	RMfGG2uhj52WxUrZWSOzavd04bAGo8bx6fdYTt7oF1TvfEFdtQPD
X-Google-Smtp-Source: AGHT+IFUApN0fRHXFK1bCRT7rpWoSaUEkZuCrtXycv1bAXF1w4rDGExmL//nRWUVqntJEtdq6ZrjJw==
X-Received: by 2002:a05:6902:1b13:b0:e20:2bc7:6646 with SMTP id 3f1490d57ef6-e25e59ac189mr3117508276.21.1727454746222;
        Fri, 27 Sep 2024 09:32:26 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3ef9b12sm523977276.12.2024.09.27.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:32:25 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:32:24 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [GIT PULL] bitmap changes for v6.12-rc1
Message-ID: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://github.com/norov/linux tags/bitmap-for-6.12

for you to fetch changes up to d7bcc37436c7d373a715d48a7cd74cd3b1724a68:

  lib/test_bits.c: Add tests for GENMASK_U128() (2024-08-28 06:54:39 -0700)

----------------------------------------------------------------
bitmap-for-6.12

Hi Linus,

Please pull bitmap changes for v6.12. This request includes:

 - switch all bitmamp APIs from inline to __always_inline, from Brian Norris;
 - introduce GENMASK_U128() macro, from Anshuman Khandual.

The __always_inline series improves on code generation, and now with
the latest compiler versions is required to avoid compilation
warnings. It spent enough in my backlog, and I'm thankful to Brian
Norris for taking over and moving it forward.

GENMASK_U128() is a prerequisite needed for arm64 development.

Thanks,
Yury

----------------------------------------------------------------
Anshuman Khandual (2):
      uapi: Define GENMASK_U128
      lib/test_bits.c: Add tests for GENMASK_U128()

Brian Norris (1):
      cpumask: Switch from inline to __always_inline

Yury Norov (3):
      find: Switch from inline to __always_inline
      bitmap: Switch from inline to __always_inline
      nodemask: Switch from inline to __always_inline

 include/linux/bitmap.h     | 140 ++++++++++++++++--------------
 include/linux/bits.h       |  15 ++++
 include/linux/cpumask.h    | 212 ++++++++++++++++++++++++---------------------
 include/linux/find.h       |  50 +++++------
 include/linux/nodemask.h   |  86 +++++++++---------
 include/uapi/linux/bits.h  |   3 +
 include/uapi/linux/const.h |  17 ++++
 lib/test_bits.c            |  34 ++++++++
 8 files changed, 325 insertions(+), 232 deletions(-)


