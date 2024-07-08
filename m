Return-Path: <linux-kernel+bounces-243878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE34929C17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A087280C67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B412E75;
	Mon,  8 Jul 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Sq+yscb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AD1862A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419674; cv=none; b=QvaTYRjG0p3aFl5V7uNawtoliRojeR8JI9oECW3+mKdYtJSWGxLHv/n+WrlXe/Y5vRwv0pJ8A5dMP5+h6QaCx7TQsQBj80O0+upP9fPYsDSnuyfyU+8FiavO87GxtGKYvmDlpf4ZOgEsU5zmHx1FljVdjYr1DCTQtF3o5wKkovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419674; c=relaxed/simple;
	bh=u3ZZ7t8tHVOVPsKxksPNVwBVafkBo4e1PeXEuefjFFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=czP7PfVd3VApRG+Fs6qZ6lTuYfPVcQW1+nL2EHiwjcqkYZUdCc9gJnQ+y1h5OaDy0mnZU1DvAVJP3mGLmGmgXHijDTFRSxHV97vTyaw0t6+5Z+uLBxEWLLyD+J/pz+qn3UTqXn7ogzawQ0Hc3CZmbRIyLJUhCmRNf7HUeIV1hQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Sq+yscb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6524309be45so65266007b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720419672; x=1721024472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XuMB4jWfTK+nrsq0Cd41neWZ7Zk32YaXzBOwDdVumM=;
        b=0Sq+yscbjISLRp+8m+Of5xiQ8EsDRjBHdn1VzR4ryLjoCqCXom+t86dEK30nqSCPVJ
         31ChRkwNHtmnyT8fHcB/pvsSfKqkV+DUPHcZuv1AkyM5lirQcBAvAR+FDp8LkwK5O3LD
         ofQ3PBVxQ2pOVdZFO81ETil/imqFpBv6MntumBWjvYGqssUfg0q47+z5cZn1MgxAkx6v
         bYMsim7RPb0lIh52tdh+tVxRqeOrP0sp/3Limw8+ZgmeMEhkKStGSRtH1mkkMDnHHYSS
         mPkSOG8QglsTI0nwURwoKdlAIIj/Iuu6QKCtj3P1r04i3pcaoDYAT6bP+bScKv3vLTvv
         l/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419672; x=1721024472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XuMB4jWfTK+nrsq0Cd41neWZ7Zk32YaXzBOwDdVumM=;
        b=Pg4LFCg2EW2/Hrlmz5JaaVFXWFafA9uotVEQfAHJ5CjkWoBDqX2DQa4ju0ghcnnJuQ
         Yb8Rn1NoDlxmaBmeL9J2dtJO+Wk6UaXGzELAiIvHfX95+39guAYzetF3IvncEz2Z6BRc
         FqW8Ek1cFSJzWl/DqTsLO0xM8eLFCj0HkniJn0tr2wtbI6vgL1j6tw9Hg6GIplVS/j+8
         EJXycyaPB2TemvIrD5ugAcIgb6HVQj8nh4DOtEwBHq9e0iNwfDRtV+I+Flj/kISQ+vz3
         3tpbGCg+fIgV1d2am0uL8JwfFYACDV24Tr/GxusI/dfms+Cbk0dBlbgiUMV/sTc4HCgU
         Hu1g==
X-Forwarded-Encrypted: i=1; AJvYcCX4MEXs8FW/Alm5WTX2b5tPnbXjdacums4ag/035/t1WPvNXVcMSBU50GZ+hkjwiHADfdD6R+mdiec+kycmLOd0Pi0XZHAme/JeHCau
X-Gm-Message-State: AOJu0YxggzuE5jZG7ajxkxSHeNMua+lAaaMMJnd4LIEI2kSc17O3POMi
	rBcxnOoSOWUAg1DnBFFReHx1Dvyj+hnUyP2+5HG2Au/En4Uja8OKxGTHrARooHL18VFljgEnUKd
	fUQNFRB6lVgok5rX0EVe64r0wVA==
X-Google-Smtp-Source: AGHT+IG3AtsLI4pAN26wbfZ8bsC5JGvZOcnS9yABDyajFuFbZomTBMcMqoD+dcfc9zTQ3Rn1s2WlpoOvRRXwXHRnnvo=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:2b85:b0:e03:5220:a9df with
 SMTP id 3f1490d57ef6-e03c162e79fmr1172527276.0.1720419672035; Sun, 07 Jul
 2024 23:21:12 -0700 (PDT)
Date: Mon,  8 Jul 2024 06:21:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708062103.3296587-1-aniketmaurya@google.com>
Subject: [PATCH 0/3] i3c: dw: Add support for power management
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vamshigajjela@google.com, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

These patches add pm support for the dw i3c controller.
Controller registers that can be lost are saved and restored during resume.
Clocks, resets and pads are put in their relevant state during suspend and resume.
For runtime pm, power is resumed and later suspended for the xfer/IBI APIs.

Aniket (3):
  i3c: dw: Save timing registers and other values
  i3c: dw: Add some functions for reusability
  i3c: dw: Add power management support

 drivers/i3c/master/dw-i3c-master.c | 302 ++++++++++++++++++++++++-----
 drivers/i3c/master/dw-i3c-master.h |  10 +
 2 files changed, 266 insertions(+), 46 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


