Return-Path: <linux-kernel+bounces-206933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F52901004
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63EEB22AB7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2101667FA;
	Sat,  8 Jun 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvkaU2K2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D117BAF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717832157; cv=none; b=rOPg4ooU0Zfn5of14MLHjIOxVuyaMSiCvN6vS9VklcP5ccU8MHx41UwVrFebXS9Svj5+LHB8vTyQKn8Qg3Rne7VBmOEh5mcmYpGTNbKm4EnDuQbh+Y3VP5SP8Js2QFAuGta/op7rpO8OIhmb8jW+mfRCXKiLQWgSAbwkG8Ybb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717832157; c=relaxed/simple;
	bh=uqS3ZTkoGzdB8MPzLW+Uv6OtbpHuKjx6MjLzS3mI9qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J2fI12yOHzgumdXSj2hDZzaRXpsDqJ89fzLUIkYZaZ2BQQbetyp9k9XeMMcd7qsg2WjHdW3JIKHnft1P0cbVZBU0NT6DkQV79h/Y9WOSmN728HKSmI/ho3DzOcIlaKxPm+3tLQu+AnZ4hU7bq9vobs51cJlIiXoA3hlP/663dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvkaU2K2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso3752105a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717832154; x=1718436954; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iX73bPugpgB98kNdoN8TAqfbpz34cE6ykjuhJveUYwA=;
        b=EvkaU2K2kjWSM2at+jHVkWZBrLGrqwoUQjR6ozrXjgD41KILb1O01KjBuOq2J3oqD7
         IdoHsUEDwRtbFOLZaxmyEVw/ti6OL6DjZZKvKwJoipA1eP9PpT8k31D3w4MtALCKHlvz
         1L2SeZ/QMGxgqMOn6Qcyeuf44xEM1HiMZhL91kefcaUyrwb609WiOPrwolDVNCVIJ4eP
         MZRW973QtEVCVN/5tTJ56LAsVIT+mryjxzhcgK6czKVIxPbHh5QXP0tzz79wITGuFilc
         lGStdWLiKVz5JOdpvhQMIHuOAz0cTLMyCsXqfvuk4x6OigOPfLk7TQrLjI6n+cm4riQI
         otng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717832154; x=1718436954;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX73bPugpgB98kNdoN8TAqfbpz34cE6ykjuhJveUYwA=;
        b=LUIGu7UHiMw23ImxjTTmTX8pJ9JT6brWpOn+fJMBbJMbNrAzoIihY7kGAabT5vsmyI
         lsLJpLcavREAncSqlNGO+heucZAIjE6v9heYrJoZrrJrsH2U6EtJZjtpQeDqFECHPWnV
         xlkEndkJR7N8nc7hQcj3FXdXJ6OmmP3cfgDIINR5dpUuq7htCjYxoikQCwHYYC9oQ4YA
         ro+PEZxySQYbZur2xN+rCTzNtzSrOY7xb3cvieXXJnw+giaKfkyIqSFRGu3GK/Zvxctn
         eycetlE2973RplGZQbBxLbuNP/kOt16rnzCKwgvUDeTp0fUhwgYdjMn09VSerm1EmJby
         E2lg==
X-Gm-Message-State: AOJu0YwHSyYJ6gLxdISh+f9IkonV6r33UhY8OOOQdtAojJKuWVsHC0gS
	IrxAMnzNBo0THq8mFW6G0xWVKyCChdWGLxeMgN7VC+NPkdDqJ6uOSKq47nH6
X-Google-Smtp-Source: AGHT+IFSyAA7QL3arJxtnRcJHndGEDR4y4oO93GNTQUsSGKT6l7uByZpdd5vfur+DsDWktTHI+qr2g==
X-Received: by 2002:a50:a418:0:b0:579:e690:8349 with SMTP id 4fb4d7f45d1cf-57aa55ae5f1mr7450452a12.15.1717832154212;
        Sat, 08 Jun 2024 00:35:54 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d8ddsm3900535a12.1.2024.06.08.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:35:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 09:35:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] locking fix
Message-ID: <ZmQJ13aFHTtl6CEj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-06-08

   # HEAD: f92a59f6d12e31ead999fee9585471b95a8ae8a3 locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

Fix typos in the kerneldoc of some of the atomic APIs.

 Thanks,

	Ingo

------------------>
Carlos Llamas (1):
      locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc


 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/sub_and_test       | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

