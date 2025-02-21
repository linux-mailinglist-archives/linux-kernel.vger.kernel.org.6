Return-Path: <linux-kernel+bounces-526293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A9A3FCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831B6704408
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806C2475CF;
	Fri, 21 Feb 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QwFh39Je"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC39244E98
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157378; cv=none; b=qGHpHFYa92/mt8a2qvXUNkOQeOM07MqgQFym1iVMy9lC8Pd7K6znHdJI917Ib9QV/IdsCqHEr16ocpXSRMA3CDti+TpPnAYRm31Amnkpj9/JC57NxjwvgmVX/qlZFFfRSYdcPWqWItyAT9k0rl7VeDzKgrG8o5sMfBPhtOG1b5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157378; c=relaxed/simple;
	bh=CSW10IqiNdAkspr2IgyTQkreJmoj1lkd5Vs5Tjhn4Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjFtzd30SSK9UNtkyCNIKjUaYsgBDHf+lXZb5wqsXMlp041rO5B+IwApuz78odOfTEBir1kiDK17xIHaM3hq9uYscv7mS2bQwsrUV6vtnOE7JHaEBsFTJKBFc4+WSd4rtmvN7L6AUXyXs8VVdVdURmRQThWehEJJPN5N2PwLwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QwFh39Je; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso357798566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740157373; x=1740762173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDByaDv2MeIoDkWDRCtDD68r/JuubevBl9+EY++FX5Y=;
        b=QwFh39JeqOC/L5XL2f66VTxmJj5cJEme7AAXfK7OIAhcQzpFmYaqe3QFX4KX9mGDFh
         qbNHWeHSYk6JhstjFSsNC7K6aM04+ogSFIoYYv2WfyvLDN3R0y7RKg46xtpVKtFm3Xue
         YhexQFdNPaYEasZdUdakA6iFKkyIbOPLzG0JY/pZnB2aD+buf4yRG0IidRVF42tm24Dw
         TUtZe0CkwRjyZnMzSgxJy2EBRcxkF+V9W/cZoYDVJGAytYxVEMG9s74v/+mUwPc2dXKg
         TIXRy3MEu+voy5q4afxEUFUvSf8dtozHP/qkecmN7AQigSGElxDfXk444p+C5Dn8zw7O
         iFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157373; x=1740762173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDByaDv2MeIoDkWDRCtDD68r/JuubevBl9+EY++FX5Y=;
        b=dZbHffEyQXSAzDXBwtdTaScMU9FtCt2zhWby6Qh6000pFehNHMvKZtS6p/qZpxDspJ
         BQ0pj5dLQK4KFQOox2jttgNVEDksXDTL/K4ZVUgbXv2TcBccKEpRjC0lEPRGt2y1I9D8
         5+ZrHljzUCftBTjB0VEqpMV5rnOqAM+XKfz5y8MdluSfOpQkxyJeOIcwSX2DkiJl3VpJ
         yUN2m+Y83xZY5y/EvA6SeAtqVH4XCrSWdV7JRO1NFWa5zCaxcet2eC5PJTafX3Bs4Y8J
         aJwMS5zkChKsf9wm/qFbCYiGg+S6g64Hfmd7tZIUlGNYhwP6cHGWIWdgMkB9aYNkc1HH
         mMFw==
X-Forwarded-Encrypted: i=1; AJvYcCXAsxgAlribJ4j9bOX8c0J9xRClEV3wZdrnzBtH1+DUA63LCE/1qEJAHortrIpKQDOpv7B6yDPz7gII16g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gR+Dw9boI3O6S/1Qcha/jOEIdHZEsCbaYsuwKZK10MtPcbsp
	Mvllvo93ZqFdO+S9jTgDAdJiNrCQyOH/bL0MUrtK7+z6eLeif49gfg3YsippD74=
X-Gm-Gg: ASbGncsP86e0yHbyr/9blbxqoTYDxTIVaC1qbl96CYrfvaqkLdTrDiC1IeuN38IQccK
	mD6zIc3xqyHqu/Ah5eEZt/b8Az8rN8IF5FpbkArdEjhTtX6JTDsLEMOeyAIee4ivGcpv93YKTE1
	ADCDGPjAD4oPL4CuOeQUVuD5BQJ6HTdZDomLJIesIfWGOcreY5DZ5A3oYkFlsvvas94PFkp10Kb
	VXCilT5rs5I+yybotiXP6srnu0kClcXqo6Tn7zlXyrgILeJEBH6Wm0eUYjcb2fKA1VpxDZS/r15
	npmVsgZPZ1aNruR6exBabdT9I8Ys
X-Google-Smtp-Source: AGHT+IGfcJwK8DsLRDynNMYZTxbIxb0l+jqrdkXEpzFnvtKSRwocRJ46u22XwIA9pSi82Z9VX3nCQA==
X-Received: by 2002:a17:907:7855:b0:abb:b092:dade with SMTP id a640c23a62f3a-abc0de0de6dmr329918266b.38.1740157373377;
        Fri, 21 Feb 2025 09:02:53 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm1105668766b.161.2025.02.21.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:02:52 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 0/2] Alternative "pid_max" for 32-bit userspace
Date: Fri, 21 Feb 2025 18:02:47 +0100
Message-ID: <20250221170249.890014-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pid_max is sort of a legacy limit (its value and partially the concept
too, given the existence of pids cgroup controller).
It is tempting to make the pid_max value part of a pid namespace to
provide compat environment for 32-bit applications [1].  On the other
hand, it provides yet another mechanism for limitation of task count.
Even without namespacing of pid_max value, the configuration of
conscious limit is confusing for users [2].

This series builds upon the idea of restricting the number (amount) of
tasks by pids controller and ensuring that number (pid) never exceeds
the amount of tasks. This would not currently work out of the box
because next-fit pid allocation would continue to assign numbers (pids)
higher than the actual amount (there would be gaps in the lower range of
the interval). The patch 2/2 implements this idea by extending semantics
of ns_last_pid knob to allow first-fit numbering. (The implementation
has clumsy ifdefery, which can might be dropped since it's too
x86-centric.)

The patch 1/2 is a mere revert to simplify pid_max to one global limit
only.

(I pruned Cc: list from scripts/get_maintainer.pl for better focus, feel
free to bounce as necessary.)

[1] https://lore.kernel.org/r/20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com/
[2] https://lore.kernel.org/r/bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt/

Michal Koutný (2):
  Revert "pid: allow pid_max to be set per pid namespace"
  pid: Optional first-fit pid allocation

 Documentation/admin-guide/sysctl/kernel.rst |   2 +
 include/linux/pid.h                         |   3 +
 include/linux/pid_namespace.h               |  11 +-
 kernel/pid.c                                | 137 +++-----------------
 kernel/pid_namespace.c                      |  71 +++++-----
 kernel/sysctl.c                             |   9 ++
 kernel/trace/pid_list.c                     |   2 +-
 kernel/trace/trace.h                        |   2 +
 kernel/trace/trace_sched_switch.c           |   2 +-
 9 files changed, 70 insertions(+), 169 deletions(-)


base-commit: 334426094588f8179fe175a09ecc887ff0c75758
-- 
2.48.1


