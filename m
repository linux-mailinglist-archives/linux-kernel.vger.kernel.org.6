Return-Path: <linux-kernel+bounces-177320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80408C3CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCBC1F21C95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC04146D61;
	Mon, 13 May 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7yv9L9+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902C146D50
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587632; cv=none; b=PXyDMBizgpjNRkESoGhZx+RXfnjNsQHhY66h6wkwKwKM/B5XiOU1CvXdIZ7IY7cBOkQnLiB6AhEihIn1mxO9VYpYu0gcAj7l9lgIknzNpUbf3BApWtoUt2gZBqZmBYUFaE9N7xQuDgtDAN05yRDqLCdnkE5gGj8fG6dGYp91dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587632; c=relaxed/simple;
	bh=EeUXmr9HAakt/d6Lgv/yRcwt4Y+9jKqEXOWiByXUOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7fgH/G2iMnvLUaVrLdeeHKMD0PsguodZIgeQengFtXD7Lbb2NjCMS7sSCNp1+KrhUTcs7JVzgmmxe+fUBL0vcRYBLN8oe7C8A/O1pgXoJgQLEc5DwHu9thJWhJQrc/A7mB+3G6m8YYdKqxocmMmiMJOsLsas4niY9iB3N0Mgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7yv9L9+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599a298990so979771066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587629; x=1716192429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGHXX3XLgR0pPwQe/OCT29nrGo7u0+4XrkeOCZxlFyg=;
        b=d7yv9L9+9RmxUpLs4mHIciCP/UATcLkf5CEB+Rg9HeqJlvoFyqy7zFl6pd8LnG9Xij
         aW9k13qZBmm3lrQsSvvyXpxqqXnO7PokfoCCns7PRFvEDZut4ex7pE/Rc2BulEjnubPP
         pvimMVOXoIyDR8X8CfSGdnAzqth5QDfkaXUMcGevhp528wiIMhYco+ergaQmirNGalSH
         hU1TbW2hR3PvUgJhIFvQ4XanHXhQWAjVOWAjBc7iAQ+vw6meMAbHxfN6yV3N5NqkRKaL
         WPLfXYyVvTcZOJG8GHcVnCW55p3bP9bdx57SHdIpxGuAe+syNJPh5y1n4PzKH1fP4ZAk
         t0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587629; x=1716192429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGHXX3XLgR0pPwQe/OCT29nrGo7u0+4XrkeOCZxlFyg=;
        b=GjDVC5+au7zggazUP973tqtDXrA0L7ml2Foy+gm3iT7fq5VStnvNgIjKOadVjFRQmP
         bihK25Pu6nJDhKhvsd/vsucvA1kLNQ2Kqd5EeFP/3xIRBhn+C8F2btwyxa6yskYXFqLY
         MgEG0ZHioEhNiW2ZVTyAmeOWEz4YrrEjCP60WCOXaMz3AxlfOobiAe6586NZ2O42r+G9
         IBn8g3D7o4+ZJ+hbjw1p74mQx3PuFXKKb7H8OqGYnJiLKz1w8v4X1xmlpsXm2qjTIfbs
         RoyI4fyYC1e+CliKbNxu52gEUUWGaIutJlFdkPWOeanh3yqwA4YTygVonWemnhY/FFLC
         nqTQ==
X-Gm-Message-State: AOJu0YxpBdGU7fFyP9X5iA1y3rNWGlDJvgKnG87tPja85m6p7DSzJMep
	n+B5hy8HY/6G5+04zadEsR2wmhcPYrRXgN4uj6hhtuHKuVa2hGa5
X-Google-Smtp-Source: AGHT+IG4OLjZFrIHbMJiMz/al0lM9n4dDwuMBIGN3Fw9D5n2gPEO+UYQ9p4DP54lfDXVKyyAOQ6tvQ==
X-Received: by 2002:a17:906:aad0:b0:a59:cfab:50d with SMTP id a640c23a62f3a-a5a2d536daemr595316966b.2.1715587628787;
        Mon, 13 May 2024 01:07:08 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d708sm560353466b.41.2024.05.13.01.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:07:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 10:07:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] Documentation/maintainer-tip: Clarify merge window policy
Message-ID: <ZkHKKvyLJSy8FYoU@gmail.com>
References: <ZkHJRYpDIBpxWeyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHJRYpDIBpxWeyz@gmail.com>

Linus,

Please pull the latest x86/misc Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2024-05-13

   # HEAD: bdc42c8b9befcef6368be345004cee3da1ace955 Documentation/maintainer-tip: Clarify merge window policy

Update the -tip maintainers merge policy document wrt. merge window timing.

 Thanks,

	Ingo

------------------>
Dave Hansen (1):
      Documentation/maintainer-tip: Clarify merge window policy


 Documentation/process/maintainer-tip.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 497bb39727c8..64739968afa6 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -409,20 +409,20 @@ See :ref:`resend_reminders`.
 Merge window
 ^^^^^^^^^^^^
 
-Please do not expect large patch series to be handled during the merge
-window or even during the week before.  Such patches should be submitted in
-mergeable state *at* *least* a week before the merge window opens.
-Exceptions are made for bug fixes and *sometimes* for small standalone
-drivers for new hardware or minimally invasive patches for hardware
-enablement.
+Please do not expect patches to be reviewed or merged by tip
+maintainers around or during the merge window.  The trees are closed
+to all but urgent fixes during this time.  They reopen once the merge
+window closes and a new -rc1 kernel has been released.
+
+Large series should be submitted in mergeable state *at* *least* a week
+before the merge window opens.  Exceptions are made for bug fixes and
+*sometimes* for small standalone drivers for new hardware or minimally
+invasive patches for hardware enablement.
 
 During the merge window, the maintainers instead focus on following the
 upstream changes, fixing merge window fallout, collecting bug fixes, and
 allowing themselves a breath. Please respect that.
 
-The release candidate -rc1 is the starting point for new patches to be
-applied which are targeted for the next merge window.
-
 So called _urgent_ branches will be merged into mainline during the
 stabilization phase of each release.
 

