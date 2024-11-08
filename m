Return-Path: <linux-kernel+bounces-402143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638349C2466
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA821F27D86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A81A9B3D;
	Fri,  8 Nov 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xEujkJUQ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2D1A9B34
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088130; cv=none; b=mcdlx8yVhWE0XwHysoSvAiYpqvbBsqs8pGcVOTN9fTAy6f1BkTLSo/55CcxW6oJBtKshaFeXfMg4wqisBrdEWpbSKh7XePMwxaLLMiGfLZbWH7o9k+gQUhp6gDL/8LfxGkBWp63B7EnOlsEGaGlPQbtn/kneM8osOEyss1ZtKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088130; c=relaxed/simple;
	bh=dmVBF+gVgRqb2m0UH7tVO5FC4PKZEFZyqiOgOx4tnD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7qgJCd1pqbarjmzr/dJL22LEHDGZPz6lYui9MHGCii6bm2gZp+P+78LJ3t+XKu19B6aTJ0zfR6r0wYxCtmz8iRHjmgDYIeFLErWcAP9Y+PvYo+EEEEdGfNtTl4hILhQ00IHySFpOsgstm7vTGIXFRsiJRcyu58uahUK5Ty7tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=xEujkJUQ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abc039b25so90293239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731088128; x=1731692928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFPspQpHyy6aevwZuzdWMApSf1pc0likCEV22CGoebQ=;
        b=xEujkJUQ4O8MGVqJJxvQdHqLEldotDqJp/tCBOi6bEiN9fSmoX9ESkzxekApr+sYBv
         3LJtSBk/y96y8fxPQygic2lbdjjErBrAc4j2YBlGgapj0L+vA/F7dFSwVmiLcux20yIZ
         o5iR89/1WweZA2p7madUyHV/nw2Wabkw4gF2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088128; x=1731692928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFPspQpHyy6aevwZuzdWMApSf1pc0likCEV22CGoebQ=;
        b=mKO8lltPlbU5eNzdvPRuBTISDwBXzyXk7vwc+kZuIxo9I34FgAmb+EOCGqslzNcshc
         YLQ0JRFCjVSR1er8YSHQ6ZZhGJ5n6dKS9/CJkvd55XWYwO5LhSuV9EhYLoBFo+aGGc/Y
         X+eUHbvWoGyntI4UHMwygh8DWBnf2Yl2Ec6DDgl3UQ1G5Ywhct2wuDFekzX0LXCas2nP
         YgJcevA+OWxPDTEWkqv6msj+UmVR52rh5LzcISS+2tdg2FHwv39h3a+YCmCN0oxegwUL
         /xwGP8YVUVVsrNIIqAvL4ieGRL7I0DKeYz6MfeYuOX0zaZDonKJq/HM1sLt1K6i3J39j
         9uNg==
X-Gm-Message-State: AOJu0Yz9JXLn7LcyuHzomcqj5B1QgCdZbZUgEBa2iihvTwAZJ+6mQaKK
	Tp5t08+96/GTIeGoTptlpEuASs0GcJUroV9MRWjCuaeaD99WCvWVZ4uKkim3FkHUJu9J2hmhsZD
	L
X-Google-Smtp-Source: AGHT+IFSnCztkTdSKCuvwCGZvduGdkDE5vnqwsbe4dstqS40QCTqYbqdgEHrkvtdce9BwN/csOpp2A==
X-Received: by 2002:a05:6602:1485:b0:83a:b657:b9e4 with SMTP id ca18e2360f4ac-83e032e35a1mr454266639f.7.1731088127830;
        Fri, 08 Nov 2024 09:48:47 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8e41easm918119173.136.2024.11.08.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:48:47 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC 0/3] tick-sched cleanups
Date: Fri,  8 Nov 2024 17:48:33 +0000
Message-ID: <20241108174839.1016424-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
Here are some things I noticed which could be improved in the tick-sched code.
I still have to work on the third patch a bit more. I have done some basic
testing on the patches and I am looking for any feedback!

Thanks.

Joel Fernandes (Google) (3):
  tick-sched: Remove last_tick and calculate next tick from now
  tick-sched: Keep tick on if hrtimer is due imminently
  tick-sched: Replace jiffie readout with idle_entrytime

 kernel/time/tick-sched.c | 39 +++++++++++++--------------------------
 kernel/time/tick-sched.h |  1 -
 kernel/time/timer_list.c |  1 -
 3 files changed, 13 insertions(+), 28 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


