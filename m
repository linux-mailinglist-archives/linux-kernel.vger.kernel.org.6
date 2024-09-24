Return-Path: <linux-kernel+bounces-337344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6B9848EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD578B22460
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE91ABEA9;
	Tue, 24 Sep 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDuB1kmf"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C61AB6DE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193414; cv=none; b=GLGjTqMsTWC7geEPUwiP2yfyg+2KS/ZzGgFLlWcrm5+2FFng39vOOgJsyqJnw5KF9cLvIZvGDysSeb8PtaH0JF2LAIE7munrQponaDSy0HPwp6Gm9Ra3j0ZHKhYJ62BnQ1L6A2aX01211McUwSnlJw1Xxo7VY+u7y5ZpLrKDyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193414; c=relaxed/simple;
	bh=BD4oxz4ohEQbKoYtZm3iSs+1uo7yPgLOw8YJFNMr7BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VA1EmgA7lU7Oi1gv3S/MfKKFXm3O1svAldF2JskzsU0565WI5pvNikuMuGoUmvIlMPIeKaRyXWUZwKkoqYUfIfb0qq+IGEv7/UOs3YAO/KrYS0u8e8rlEwew+8nFMJV8c51BblbnswadAx/3j0ftVX+YT0PpVRQbVX+7ze2ATKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDuB1kmf; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cdada0f21so223331339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727193411; x=1727798211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Orwzf4vl19r2PEeizo+it5ykxsLyDLfwmpPyw2xeBY=;
        b=KDuB1kmfXhMIgHBTFspXOcvA33kYCqYOqou6b3xFdjQXe/sQG5vw7/FAJLaPueCxY1
         RWANl/CTcy+pL/TCREwbuVrtlfPgX79ApeqoJwjXveWokyKhaJBFP7fRzISzQ9HUww6m
         /OgCaWeAxIzJX1Wilbw2l7XShrv1Jc+eaDaz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193411; x=1727798211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Orwzf4vl19r2PEeizo+it5ykxsLyDLfwmpPyw2xeBY=;
        b=VLVaFZJOKj6rh3mMGUd/YxuQ6iV2u8HAguQ/2aztswwQlntsKBO2fK8p+1d8oir47F
         awKnqfW0OkaA9gvG3SxMRv8JwuXczZYXZ0PHVpLEboz3iZJuaC55j0TQSYPxnFRdQIdY
         EBgFHb/0wuiLLs90r6swtZwyd71Qh5DEWvEN2A2r1nLj6Xw8OFsgIKY05mzfZlXhgS57
         AzDfLsIsVjd5apk4rCfceSaqBeYlt8DdhRHqo6h0xmPZbhJ88T9ypWWZwMy6OEclHVbW
         oDsNusp07BkLuHnklSwnco2GLFgY6e2sZhG1MgUzQJyireqBcPz+UMV0MyybH6J/mQCH
         EQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfsC95Y/ZZOTlMiaK6iSYRsSJFpcs1/vaY4oJSB4Jg8sfcA2e27nGYcG20XZyA0CecTG/yhKSTFWBX3yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcpeb+LIqCcVY/XOzflj0xmSUiQTiMxmBNG76hiljn5TOq6FMU
	ffliZZXrPQ0CC/CqTVL7+xw8nOwB+/SKxEKAcGC+QtLI/UnyUNjM5FcM7KD5Juc=
X-Google-Smtp-Source: AGHT+IGIytvphTbM94QqywnWbqNlUvZ6WkqpO2TD3CN/RxYwe8ykUm0fd5AGdgNl7fNEc7pdKgVBwg==
X-Received: by 2002:a05:6e02:198b:b0:39e:78d9:ebf4 with SMTP id e9e14a558f8ab-3a0c8d2af50mr150412255ab.22.1727193410814;
        Tue, 24 Sep 2024 08:56:50 -0700 (PDT)
Received: from localhost.localdomain ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b64sm4492035ab.58.2024.09.24.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:56:50 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] timers test fix and duplicate defines cleanup 
Date: Tue, 24 Sep 2024 09:56:45 -0600
Message-Id: <cover.1727191485.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch in this two patch fixes warn_unused_result compile
time warning in posix_timers test.

The second patch removes local NSEC_PER_SEC and USEC_PER_SEC defines.
NSEC_PER_SEC and USEC_PER_SEC are defines in several timers tests.
These defines are inconsistent with variations of ULL, LL, etc. without
any explanation why it is necessary.

These defines can be picked up from include/vdso/time64.h header
file. In the interest of making it easier to maintain, remove the
local defines. Include include/vdso/time64.h instead. This change
will also make the defines consistent.

Shuah Khan (2):
  selftests:timers: posix_timers: Fix warn_unused_result in
    __fatal_error()
  selftests: timers: Remove local NSEC_PER_SEC and USEC_PER_SEC defines

 tools/testing/selftests/timers/Makefile       |  2 +-
 tools/testing/selftests/timers/adjtick.c      |  4 +--
 .../selftests/timers/alarmtimer-suspend.c     |  2 +-
 .../selftests/timers/inconsistency-check.c    |  2 +-
 tools/testing/selftests/timers/leap-a-day.c   |  2 +-
 tools/testing/selftests/timers/mqueue-lat.c   |  2 +-
 tools/testing/selftests/timers/nanosleep.c    |  3 +--
 tools/testing/selftests/timers/posix_timers.c | 27 ++++++++++---------
 tools/testing/selftests/timers/raw_skew.c     |  2 +-
 tools/testing/selftests/timers/set-2038.c     |  3 +--
 .../testing/selftests/timers/set-timer-lat.c  |  3 +--
 .../testing/selftests/timers/valid-adjtimex.c |  4 +--
 12 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.40.1


