Return-Path: <linux-kernel+bounces-425356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C762E9DC0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FC328213C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94716F858;
	Fri, 29 Nov 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKEIJ26d"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8821547C6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870850; cv=none; b=eMME0mt8Dr3jV0GdEOmGITKDxay2uqYX31BwsjLKHmH35RIpdJK5k47REGbuaSUFt/cj5nun3EQbf3CBxJNk3lPEEuyXthUXlpNU4PEPg/yVQqICw+zYdhZyFlFoUHNPXa50ntG3IIFJFLXCYxLXQH1AdpwMyXI9y2sL4ub1s70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870850; c=relaxed/simple;
	bh=kFR9PUIfM5ND9o1WW+w41Hok+j3QIJY6jvBaATu8WzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RTYyVo1BYtICmpjzfTtir96OF3lhlugvkbbaEplAh0KeKAVQoeejeUQ8rR5SbArDtxIxi1q1ar4MdoTciSSD2dUsha96bqa0N0PXE0xT6efZCb5LzyjwATcOHMK3xkBY78fOJdsomyZ7mjt41Yg6sGEWlgovuA+Psfk8A1ZzHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKEIJ26d; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0214ba84eso1089027a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870846; x=1733475646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=KKEIJ26df9CYYCZVH1gQqZzmdmiBw+Y0KjZaasM4Tc9kj/DwQFOipPL8zyt4Eo5AM7
         Q4vMD0DmBIke/vVwLyvzb29VY9yMOEY3pWX/trNFL6KmWek9h/XooEBtgWXP8h0qp7fh
         vNRQ0t9ACYCA+xJse/fLtyHkjokR0rOWg6+NwRSrzPa5G1Nr6lWEbs7PEIZB0AhWWC1p
         ebBhFfJThW6+GqGMPd68xplwh+DACLVIL6JjHz+LEVXhtVCMm4Wp8AEtKfyiJnrVr/YT
         uzuc5QAxDatd9mfqstuIYBebxHTJcmlSDkxdrnWpLLceZTYv6tu5x1z4j0V12sC33uWa
         zvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870846; x=1733475646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=eyzdfpSwKPjhi0+K4t6rVCEMRmz/VSRQBCjeEcGRYtGPso/KDAB8lDuXTiFDp2AoX3
         2vnoXuWCOXHtwF1Mc1+DaZW1jJ4Pl/6lMrVnvTO4SCIIcmAyVHbLxdd2Wnr+rCoYc1r2
         lC1c2iOBnaktZLOjlidq79UjN6fkJKUb5rEm/xC2SGFgSMA54G0nZye1lqPgB3ZNHWqW
         OySh7Vwq3SfYvPCDjDhXoUUcgUFmk7rmeGj3nyxdMCINOQn5JQ4OnYoPNUY5WbUqcGjJ
         aH80U1525X00ZxUrpIp3giPbE8WneBgg30r7HozC/YGu2omVHVA9vkI+bdcJ633vG7fZ
         TV2g==
X-Forwarded-Encrypted: i=1; AJvYcCUWnjxrWKDBVgYyOm+2zySEMn7zPaJH1nGF/xuZVu/VeKSizHMAoPi7B+HVrRVsNp+Av5eIziZ6b7EdKPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8QSHTlbiyZ6VKr0FLjjJrS8UQwiRV3W9w6moawBPwVyqL/5n
	G0TOULr1x3tMAQIXnT8oDwm/A9fSCBkA8owownMovIy5FP/hzYegX0mKdJ32tt1WCmzToYZrkg=
	=
X-Google-Smtp-Source: AGHT+IG9mRl6GExluYMkHBV45dwKpB6OXH/vz/+odQj2Yxo5GTjngyEuQTo0iu+v+9DVqfFoPyEKI6ujFQ==
X-Received: from edbca17.prod.google.com ([2002:aa7:cd71:0:b0:5cf:db39:7001])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2353:b0:5cf:d198:2a54
 with SMTP id 4fb4d7f45d1cf-5d080c56e0cmr8017762a12.19.1732870846213; Fri, 29
 Nov 2024 01:00:46 -0800 (PST)
Date: Fri, 29 Nov 2024 09:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241129090040.2690691-1-elver@google.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Remove bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The warning message for bpf_probe_write_user() was introduced in
96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
tracers"), with the following in the commit message:

    Given this feature is meant for experiments, and it has a risk of
    crashing the system, and running programs, we print a warning on
    when a proglet that attempts to use this helper is installed,
    along with the pid and process name.

After 8 years since 96ae52279594, bpf_probe_write_user() has found
successful applications beyond experiments [1, 2], with no other good
alternatives. Despite its intended purpose for "experiments", that
doesn't stop Hyrum's law, and there are likely many more users depending
on this helper: "[..] it does not matter what you promise [..] all
observable behaviors of your system will be depended on by somebody."

The ominous "helper that may corrupt user memory!" has offered no real
benefit, and has been found to lead to confusion where the system
administrator is loading programs with valid use cases.

As such, remove the warning message.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v3:
* Collect Ack from Jiri.

v2:
* Just delete the message entirely (suggested by Andrii Nakryiko)
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ab56af2e298 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -362,9 +362,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
-
 	return &bpf_probe_write_user_proto;
 }
 
-- 
2.47.0.338.g60cca15819-goog


