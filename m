Return-Path: <linux-kernel+bounces-177108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3B8C3A30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08AB1C20CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E71304B9;
	Mon, 13 May 2024 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASISNXpo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFE2AD1C;
	Mon, 13 May 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715567083; cv=none; b=FEaWNvfB6QOFnmo65wJ7wvw7VgNbn+MOT06M24AJG6yZ3Kx8IA6wSfyVmvpHzlq2/XCYrqozN1BqISP0SCiexfjlGoooTrLAm+DSGZK//MW5IVxiKxbWkMZuDzH6KF4GfnLFppEQKfRAmXii3CvD2nrcJOTLW4yNXPk2ZxxVsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715567083; c=relaxed/simple;
	bh=k7y4LA9NwgfR3UusDwBwp4Yc4j/2B54YlpDjOAsXinU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjU6b7jCEdqQQZ58PRNu9vndTmoRS8Puq6sp5OnRfvOVO2d2cLd08l/0gS/PRwzabDUOLrKf9toj68xPsvfeRS7hl68AzYKNAN6xWUaRdUA9UHt9/l9d3pFyLMNhkwbUukaknIt6SZ8xuVKs/s3hN0drpP89UEohDTWLPKDq+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASISNXpo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4302187c0so3308074b3a.1;
        Sun, 12 May 2024 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715567081; x=1716171881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnDDpIl73+VXVfz3/GJWrQTsKTk4hFyYoNOmEVSGsMA=;
        b=ASISNXpoYjekyHwdzopkQNcR0EKVayXZ2JGcre6GrCw2SRRQlMkWpEJ3yd5750+Nr6
         sLTBsL2lGKbgmELvkdyPEVjz2nS0qynFSeRDo3yTuByHWiu688ENID75NrV/yr6sGPyz
         IZobO1KKdJaagqCWKaFkn/X/mhuz3im+uYEsn+nmk0w3mtOfRCA+qgcUyJadJaFXAexP
         GvU+lw3qvvmtTIGxlI31jp/73UQzJBDGmRzkMgyi/xummZQtUdWDhqTSD/WNx7qxwNmr
         1bYvZDLqlBdJ6BUs/w9sYGsreAsHI3LOT2mfU5/D291lOY4FCO7StdZbeaDQk9AIPJzc
         FqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715567081; x=1716171881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnDDpIl73+VXVfz3/GJWrQTsKTk4hFyYoNOmEVSGsMA=;
        b=ug50Ur1i2oKOYG4QEKztj7jqt0bVtp68K7rY3bcEZvIU2kSE/A4LbDleU4GnyIjYyT
         02cVULYliwwKMMOtIj+CKvwGJlg8l3JuC6G0Yz0HMK+zskfods0W5rMCr41nmB5JcuMf
         rFmjafg6NI624UBJdow/imWwE8lw0bStwZ+bWNPD4Vfi1K83fXceajRVZQcxcJ0vZb99
         53K/xbEoZzH631CPHh+fDTeLsqBTNoW8CNIWLaeQkOcsuLjFo4COW8gLdQkEqAbC9e27
         mfLYwI1mOvOtXOjGcp1zorTELr8yTfJYU2D2QX6Xr2ABa+1+8Dzz8X3rpAGwwOoSKeN9
         x73Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuh3zqIvUjn+LiktTTtSqn9bMw45SqoF8cWgmeH3CM3l6GyfAmGzTuuB2h8JGBJxbgjteQLqT47NeEcGfSJGgrHs/XdPURGkJ/bJQcnN1zEuytqurbtmPxqsZr3BjymoF2MjAfJHik
X-Gm-Message-State: AOJu0YzqEnOHozGauRnUYRpwFOvDihX2Vf/Lnwrcz2lZf5T+peg/VpaJ
	IjqALo6gbcOIZV0IQe0I866QTtVJbNGfXaV9lJtscClWbTuT8wAW
X-Google-Smtp-Source: AGHT+IEQeErWPw8e6CNL90XgcM8c9kdJ2h1+HcN871wAwmIZ2GKuwNzXIaoc70FY6sXk7l938/oj1A==
X-Received: by 2002:a05:6a20:9f99:b0:1ac:de57:b1e3 with SMTP id adf61e73a8af0-1afddeea5c9mr13259451637.0.1715567080965;
        Sun, 12 May 2024 19:24:40 -0700 (PDT)
Received: from localhost.members.linode.com ([2a01:7e04::f03c:94ff:fe95:abac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0b8bsm6289933b3a.131.2024.05.12.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 19:24:40 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	corbet@lwn.net
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Refactor phrasing for clarity
Date: Mon, 13 May 2024 02:24:02 +0000
Message-ID: <20240513022430.17626-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Updated title capitalization for consistency
* Fixed acronym capitalization (e.g. CPU, vCPU)
* Added usage of hypenated compoud adjective
(e.g. host-side polling, where host-side is modifying polling)
* Added missing verb "as" in "basic logic is as follows"
* Added missing articl "an" in "guest_halt_poll_ns when an event occurs"
* Fixed parameter definition in 4, all previous examples started with
  descibing the parameter in the first sentence followed by additional
notes
* Replaced C-terminology Bool in favor of formal form Boolean
* Cleaned up phrasing in "Further Notes" section for clarity

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 Documentation/virt/guest-halt-polling.rst | 47 +++++++++++------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/Documentation/virt/guest-halt-polling.rst b/Documentation/virt/guest-halt-polling.rst
index 922291ddc40c..3e4e9d4099c5 100644
--- a/Documentation/virt/guest-halt-polling.rst
+++ b/Documentation/virt/guest-halt-polling.rst
@@ -1,12 +1,12 @@
 ==================
-Guest halt polling
+Guest Halt Polling
 ==================
 
-The cpuidle_haltpoll driver, with the haltpoll governor, allows
-the guest vcpus to poll for a specified amount of time before
+The cpuidle_haltpoll driver, along with the haltpoll governor, allows
+the guest vCPUs to poll for a specified amount of time before
 halting.
 
-This provides the following benefits to host side polling:
+This provides the following benefits to host-side polling:
 
 	1) The POLL flag is set while polling is performed, which allows
 	   a remote vCPU to avoid sending an IPI (and the associated
@@ -14,15 +14,15 @@ This provides the following benefits to host side polling:
 
 	2) The VM-exit cost can be avoided.
 
-The downside of guest side polling is that polling is performed
-even with other runnable tasks in the host.
+The downside of guest-side polling is that polling is performed
+even when other tasks are runnable on the host.
 
-The basic logic as follows: A global value, guest_halt_poll_ns,
+The basic logic is as follows: A global value, guest_halt_poll_ns,
 is configured by the user, indicating the maximum amount of
 time polling is allowed. This value is fixed.
 
-Each vcpu has an adjustable guest_halt_poll_ns
-("per-cpu guest_halt_poll_ns"), which is adjusted by the algorithm
+Each vCPU has an adjustable guest_halt_poll_ns
+("per-CPU guest_halt_poll_ns"), which is adjusted by the algorithm
 in response to events (explained below).
 
 Module Parameters
@@ -39,26 +39,25 @@ Default: 200000
 
 2) guest_halt_poll_shrink:
 
-Division factor used to shrink per-cpu guest_halt_poll_ns when
-wakeup event occurs after the global guest_halt_poll_ns.
+Division factor used to shrink per-CPU guest_halt_poll_ns when
+a wakeup event occurs after the global guest_halt_poll_ns.
 
 Default: 2
 
 3) guest_halt_poll_grow:
 
-Multiplication factor used to grow per-cpu guest_halt_poll_ns
-when event occurs after per-cpu guest_halt_poll_ns
+Multiplication factor used to grow per-CPU guest_halt_poll_ns
+when an event occurs after per-CPU guest_halt_poll_ns
 but before global guest_halt_poll_ns.
 
 Default: 2
 
 4) guest_halt_poll_grow_start:
 
-The per-cpu guest_halt_poll_ns eventually reaches zero
-in case of an idle system. This value sets the initial
-per-cpu guest_halt_poll_ns when growing. This can
-be increased from 10000, to avoid misses during the initial
-growth stage:
+The initial per-CPU guest_halt_poll_ns when growing. The per-CPU
+guest_halt_poll_ns eventually reaches zero in case of an idle
+system. This can be increased from 10000, to avoid misses
+during the initial growth stage:
 
 10k, 20k, 40k, ... (example assumes guest_halt_poll_grow=2).
 
@@ -66,9 +65,9 @@ Default: 50000
 
 5) guest_halt_poll_allow_shrink:
 
-Bool parameter which allows shrinking. Set to N
-to avoid it (per-cpu guest_halt_poll_ns will remain
-high once achieves global guest_halt_poll_ns value).
+Boolean parameter which allows shrinking. Set to N
+to avoid it (per-CPU guest_halt_poll_ns will remain
+high once it achieves global guest_halt_poll_ns value).
 
 Default: Y
 
@@ -79,6 +78,6 @@ The module parameters can be set from the sysfs files in::
 Further Notes
 =============
 
-- Care should be taken when setting the guest_halt_poll_ns parameter as a
-  large value has the potential to drive the cpu usage to 100% on a machine
-  which would be almost entirely idle otherwise.
+- Care should be taken when setting the guest_halt_poll_ns parameter to a
+  large value, as this can potentially drive the CPU usage to 100% on an
+  otherwise mostly idle machine.
-- 
2.43.0


