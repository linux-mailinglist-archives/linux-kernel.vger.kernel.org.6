Return-Path: <linux-kernel+bounces-245336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AB92B16C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540301C21CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC8144D11;
	Tue,  9 Jul 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee/pwKj/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662027713
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511036; cv=none; b=EE66QKTCIslKum9ptflA97AuQbQ8rQSQZT6dwVMxbjb9jhYV0Lxg0ObeqIO8aQZQz3KLEOuLICtV8xSfIcyGg5flq36+7ZqRBH1XIBZycdWf38CqYe/KIZPJz/9hrzJXPkjoc0syi/5gafddpxZsT2hTFoGJFJKSf8Dd2dl0mkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511036; c=relaxed/simple;
	bh=20D5O3BjA9Qecn6pydHndjEQujH+ywE+VJHs0En/u64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/N/rl+Gn4SM+fSs2iKMLacJ2XEbrgnMN+VJykjZlRFnQNedznXMv44p/Wa8Bg8V/SCC8zYEbWY6yZOzTgFTLP/az2uVMr5933D+UeLm1SQU1arNjVGLgFJBOyvZ9aQD2EEICEJg8i+IjGyytTdJl3oDvGOIUrxFzaj9a06jrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee/pwKj/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77cb7c106dso455676366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720511033; x=1721115833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20D5O3BjA9Qecn6pydHndjEQujH+ywE+VJHs0En/u64=;
        b=ee/pwKj/fTJMtTyOvHUq+l+U8dzF/tUcL8ysLM9dP64zqXFh6jD4wX9z+Y5WRWevLx
         tw7J2ze7F++M6FDvCeuUHdfQof/09WKR44hYJO504EP9/oQnUZc+AjwOTNIZYtaH9thR
         rv2z1k8m0bQugPWbPsFUIkeSATU+C0jqijOwq57kipmSJuEEXHaAVb2P0xBUlk4HCywi
         1FPmxhOfy2NfFYxv8UMKrCou+M9dyLlwfxOjX/lTzJnSEzg8m3e+asKoKR+DCJMkKnOZ
         QKXrdYqTmWfs2rebF53nQ3PgYMsmdlIZKSB/SHdThlNUIVSe0MD32sdE9tUI8vlb/+ZR
         CP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511033; x=1721115833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20D5O3BjA9Qecn6pydHndjEQujH+ywE+VJHs0En/u64=;
        b=cK+6dhhh/5dBvgZk4uhh32/no5xFw/r6jHcShpoJUErmcgWEQUXRGVRQIRaRr5Jczr
         fh8tuCGVnJoyFeHh9VN2Ug+UfsnKFjHER/xXEPUZ4tm3oy/Nf6Ng/yE22EVFJwuh8bI3
         AADab2SXa277b13u4cRqcVAhK96GTTI15KLYonycOnmz5eJJgbfSHzxic2crRFMA6P+l
         2uPL1uPdbcAD2WlXrCLwyW/kgOhMfg//tnziJiiDdT7eQxds0G8Cgx6aHbKUCOnzUiMs
         M6ofxDovV2Q8B6w3wjadaxV1wKISaBt0BOB87tCf5YEg/Y1MsVbGxkQ9kPozcmfEo1Nr
         umCA==
X-Forwarded-Encrypted: i=1; AJvYcCXBOcQW39jAeJ3mgbt83Xkna7YSPd5cvZ0UAQMAGMqXPt4RPDbKPPMu+tJNg070qOirBpWYdqnsPDKpMdeCVglwtL36pRrzM7pSt/sa
X-Gm-Message-State: AOJu0YzQcEWFEmaapvP6HYvK6gZGx+bNh45WjhfXlJhi+ZUPUJWh8ghx
	8ROQrixqmLXbSsIw1fPg63KP+TRGSZNv7FLtOUThH4gslZ8XJZe5
X-Google-Smtp-Source: AGHT+IGhQSfrd+amaKpnM5/PJQRIykf6Kxt0jaCjBol+EWAP88HS2ZqRo89aelEp8OMD2IpxIzYPcA==
X-Received: by 2002:a17:906:c8c6:b0:a77:d85c:86f5 with SMTP id a640c23a62f3a-a780b884b5dmr100763666b.53.1720511032657;
        Tue, 09 Jul 2024 00:43:52 -0700 (PDT)
Received: from LPPLJK6X5M3.. (178-37-38-123.dynamic.inetia.pl. [178.37.38.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff7aesm54674966b.102.2024.07.09.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:43:52 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: peterz@infradead.org
Cc: akpm@linux-foundation.org,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kunyu@nfschina.com,
	liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	oleg@redhat.com,
	radoslaw.zielonek@gmail.com,
	rostedt@goodmis.org,
	syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tandersen@netflix.com,
	vincent.guittot@linaro.org,
	vincent.whitchurch@axis.com,
	vschneid@redhat.com
Subject: Re: [RFC] Signaling overhead on RT tasks is causing RCU stall
Date: Tue,  9 Jul 2024 09:43:34 +0200
Message-ID: <20240709074333.2799005-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705081052.GA11386@noisy.programming.kicks-ass.net>
References: <20240705081052.GA11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm having trouble parsing this. What overhead becomes high? Is the task
> spending time in-kernel? Because if the task is spending time in-user
> handling all its signals, it should accumulate runtime just fine.

The overhead is in kernel. The RT task is preempted over and over by SIGRETURN.

In my case userspace set posix timer interval to 8ns.
The posix_timer_fn enqueues signal (send_sigqueue).
Then when the signal is dequeued (dequeue_signal) the posix timer is rearmed.

Radoslaw

