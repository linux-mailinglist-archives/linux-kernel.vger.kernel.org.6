Return-Path: <linux-kernel+bounces-198146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A518D7412
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0935B281AB1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F261C6BD;
	Sun,  2 Jun 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApEvx5CV"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424418E11
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312379; cv=none; b=TkL96pkB7GqPYgV1JwZPRLPi1MxYJBgFjh9Dz/IFTCsKNri0PJ5BVXFPWUClf+60nSfhnCveCXqKhD3S72xa6Hub8u4c5QgRCLI3lyyj2l8YXBuFXbrwjIbPucPFltph52ioK2gb5oIVQnzZepqySwy1CQQuL+zDqJxP3aSILSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312379; c=relaxed/simple;
	bh=oTQoDEfQIFU3PBj8ap6fcsT+Z7Zse6j2D8TBTgtnijU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HtMjCOCE/cvXbTxMxW47vTSrbXJAJ+FKW15jAEU/WGfT2q2Ug1HKhs+fml1usKy8I34uNqcUpFfbPQyV7ZobY/1H3zsU38jIvAeo7qsOIKGIKBPm0+UCSId0jdOQhO95tdZK8Vf2W4rANgkdknDQR7p0do0Eir712T1tzg3hCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApEvx5CV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b89fcdcc7so2579701e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717312376; x=1717917176; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bsFHLMYUU9AwsmF3HpV2tyAkuNDM2etqeX/q98oNWl8=;
        b=ApEvx5CVytcls6nDOQJP5vqVaPU+MMgo5kpV95sEepeKU3GupKwB0IOTtTvTosKuQh
         iCZo+2m5NQuFOWU7wAZnbG3hD52fUun5sGCJLgvAqvspp1dhOseH2tiH5u1NluGoQoVM
         RXYWY4ZkLeM39xK7iHuZLVYh3UB3jR6Elk92kb5Dz4FAoUEM4BuTqfHaq+UvC3OzL+Wr
         LD9GnA4zLTWzQPnnv/wHEGTsK2MG7LqNUwIJ0N+FkVNQhxOvq4yyFiSm+xZov+yr7kpY
         IyILEShPRlZo9WhmpaSO+EvB+rBq1KqjCQFB8Bb5KT5czFR1w3/6+XrtpjurZMMiEo2n
         ROpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717312376; x=1717917176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsFHLMYUU9AwsmF3HpV2tyAkuNDM2etqeX/q98oNWl8=;
        b=gI8H9y4MWKFl8QwFS8o5c2TNym/eme8izQYQ3seTHxggyJe+TmH3n43rvDmyACRUPD
         YntodsLzQfLUwjUi2hi8NuU5PbkJACJoAycqNJtHZYBNj6iiWY7y5LY2yH3hXacJac5q
         ANsL6Hvv1b6vrhNGgnYFMSs9Ye0yFvYjAcXCq/djnZ+S9T9z3p0stlnBo5ABAelJe/3g
         iWCrty8Gp3CypPVnpOb603EZ5QjIx+6iTiqSwVQHrdiZT4i4mgItg4fbLmqu1v1FG98Y
         85d+WJfwP48OoCdVI3wRYMqshVcR2V90IglgJzBxWZJUMVVPxucc2+9Q5E0G0pGDwr94
         As2A==
X-Forwarded-Encrypted: i=1; AJvYcCUr63zZ0lk7dBVCc14gRK/teePN2rOdIQAdqynEHjdmSSEX8PqOrhOb9sfJRwqMcErUms/uHPkRsxWwGS4j8fVL56vBqKnS/dS9Qk3s
X-Gm-Message-State: AOJu0YyNkTuhsBS8tR2tsTXijVXYT7/+ojk6Zi7I7NF/5xGg83IR2xwB
	DQGJTjzSdDdoJY/e2M68xhSjDETSAIJIqz8xTqM9itcbq6dz/epP
X-Google-Smtp-Source: AGHT+IHqXBSiw3AGQlmg22gjJH7zJQBhp4duRI+SNbdU9/PzxdNeMUGdllju0KQB7x+F2P3egmJBpg==
X-Received: by 2002:a2e:b5a9:0:b0:2e6:bb81:ba0b with SMTP id 38308e7fff4ca-2ea951226c5mr36711341fa.25.1717312376008;
        Sun, 02 Jun 2024 00:12:56 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5746ea76sm439893f8f.103.2024.06.02.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 00:12:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 2 Jun 2024 09:12:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fix
Message-ID: <ZlwbdU0uaVMMra5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-06-02

   # HEAD: d40605a6823577a6c40fad6fb1f10a40ea0389d7 sched/x86: Export 'percpu arch_freq_scale'

Export a symbol to make life easier for instrumentation/debugging.

 Thanks,

	Ingo

------------------>
Phil Auld (1):
      sched/x86: Export 'percpu arch_freq_scale'


 arch/x86/kernel/cpu/aperfmperf.c | 1 +
 1 file changed, 1 insertion(+)

