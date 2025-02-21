Return-Path: <linux-kernel+bounces-526243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03498A3FBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE16C19E3D77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08F1FFC73;
	Fri, 21 Feb 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jgDC/afs"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37F1F2388
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156067; cv=none; b=MxW7h0Yo9FpN8mX168Di4s4yEYXNue62Q70HLIs6SakEEbzE/yp1GgUrkKPMyWx5yGKNJtIt1O8Y52SsxQyjl8fH+fbUH9rk8meUWFk02yt1ujmqLpJoRI+moH8P7+qXmREbsE3i2im6M2Fy3dkEHhc8fFxJxMGg4BG9J7xsRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156067; c=relaxed/simple;
	bh=dmUxB4J/2XKaiD0TPz1wNh4b/XwJpHH1eifZLpTasOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t2gOnWWWBm/nF4JtCxUHs+GKs4LVyypqhv5sJVsjkXznuwhWAOzoUGJebEHJA2C02511u6n/xaGjoamQKsIBpQS8HSuPGknH3sXEpAHDICpibANgGjtb5sKZEgrDdRZ26PIiPfpJzPXFeRt2P3A2VAMrR0/Ucnz8Tejo2v87C3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jgDC/afs; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855b09fca35so174462639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740156065; x=1740760865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4ID4+lyldDoEC3ThrXQZyVv5qoGJRoVswuBHih0cls=;
        b=jgDC/afsb6rGc2zHGJ7kO9eMMsDg4MMpWYpBaoLsNaLBNfHzLiuE8m/tt9TXZmMKkd
         KQRLxQJKvd7jBKrPjpcMh0E8EelGB2k777Cn9K204BB8V+T1JNrjG/kqxvyG8hb6pIn/
         6436opAbOLL0HVkuDjsFPyLC60NhM+mTr/CNX5TqEaam1zsYWjpl+VOiBVUvpxWxs+y3
         Sfmu+semPwZtpfcvrm8WJrd+CG+NPhY9QUWmR5M04KSKLzvfYl0EL7Wm+dDbiX3SntTC
         z+9PyGeyaGUF1un9ZiDKczLkb18oSCOTulqt9UZKysK9AR5uqf6UpL9m2EyxfRf8yeRY
         S+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156065; x=1740760865;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4ID4+lyldDoEC3ThrXQZyVv5qoGJRoVswuBHih0cls=;
        b=dPHKQhNhVMJxUh++JwgjVES4bxJV7DH45TE6OF64wKHq4P9Z44MTSBb/GCtvwsqBg1
         43RzGmHwuc8kKFhesHOxFRNY4mSNFvqmKZjdHcTsbU9XJNzZRh/+1vKO+59KqW4GJkzQ
         PaaI96z1hHsBJ/ImapPgG1MoBiulfuA3wdwcINWdXu0ZBO7ovyeK1Xedab3Eif7rvyRc
         8A+RSeEJS6dibGY+itigpsmvTauKCuDFka9YfodpGgOMzzDHRUiggFCtTv9iQmjvdU1Q
         2F4pXpKv0qfhy9dP1/EyJv/pa7KBGdLfP3eLUaAfOC5jwh0r3DaRZgxLesPo6ldVwEBc
         JOng==
X-Forwarded-Encrypted: i=1; AJvYcCV3S+gjhwqLwuKN3brzAmRQg838v7B2xyqaHJk/KmVnPoQZwaYwaXKOeD9sK3iVLV7IFIEiR4mV4ngKYhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aoev9/XUAiNQGUnvJdNyo33RvSX1+pQnT6KOodiy5uyW7ASV
	ZGK9Ath7Y2HsBHTKxmPMcUF/I9Uu3h05b8qg7RWAWKw1U4JiWBszVGAcv0wGJhs=
X-Gm-Gg: ASbGncvdy378mwOMsGjgLw0VAGd0LKTLyy7hvNhiHAN96gbuWHCUHWtNRQqXWSeHxy2
	4UdjFYL/3pTw1xBVhmME7Q1he/eK+QxcQ7NKcpOts5Phj2c6mdyt/WbSmYY629tbILaQublmQgF
	Of+njKgu1JDUaZ7GCpCyA3VH5UdK7zeaCZJajkJqfLTwuhqbfNbpUute2mnn/Mt1sBcx5e3rS2o
	QaYVxpmPJN41Emdyvg83D2KC6wGC5zyDYUwOPJ0Cq3vSHDzaCjhndby7lC+XZT21q352vsf+tLM
	myrV3WQ4pY7F3aWfHQ==
X-Google-Smtp-Source: AGHT+IH24WicmLTOdffhUruC7b/9hi6JwA3K+wqMsYujP0Llt/zIev+nrrMyu7vVLU9VPE+m21XCLg==
X-Received: by 2002:a05:6e02:1c0f:b0:3d2:b34d:a264 with SMTP id e9e14a558f8ab-3d2cb492863mr40089155ab.12.1740156065127;
        Fri, 21 Feb 2025 08:41:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea474d868sm2178355173.53.2025.02.21.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:41:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221085933.26034-1-minhquangbui99@gmail.com>
References: <20250221085933.26034-1-minhquangbui99@gmail.com>
Subject: Re: [PATCH] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in
 io_uring_mmap
Message-Id: <174015606425.1769700.10918790702012673616.b4-ty@kernel.dk>
Date: Fri, 21 Feb 2025 09:41:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 21 Feb 2025 15:59:33 +0700, Bui Quang Minh wrote:
> Allow user to mmap the kernel allocated zerocopy-rx refill queue.
> 
> 

Applied, thanks!

[1/1] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in io_uring_mmap
      commit: 92ade52f26555f15880b42405e35f0cfbb8ea7db

Best regards,
-- 
Jens Axboe




