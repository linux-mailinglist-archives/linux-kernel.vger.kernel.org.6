Return-Path: <linux-kernel+bounces-439793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4F9EB3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B29028547B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FE1BBBC4;
	Tue, 10 Dec 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+w8KBYO"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DE20326
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842276; cv=none; b=Acab62zrwbwqP6rTG3QJsfE/ewxc6lsMt4sw+NvqeGspBCoHBhYdmEM883ZC731RqYPgcJ/f7gjQ+rm9YX2/yNKUNFyI3++eEP4v5lhUtxO/tCYu7qvPGxNl5Wmx7EWBh9B03E+iFSUMs53HfahvUuPFN7ysOKTaekGybAySOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842276; c=relaxed/simple;
	bh=D9oWVizEfEi/tpISlMANAmYT1MULrIVMMBTpD8COT6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwxmHrzjSKGDrzP/wfxMLmaq3AhbB9CGigA4j6qoyKIdY8UeSvCw05zdCOhrYaqLsuqhP6UdDcN5eEf1+ygvruxlSADkJD0VfaTwRofbYFLs8P5fiDxMCeoAsHZI+V73uHTACcEgc4nNV/UZC2HXf1YD3xKugm53SRgTQEwj45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+w8KBYO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2648151f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733842272; x=1734447072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWU2eVhMhcb/iJGFd+VmNM2XsfhPsakUhRt7/wk/dGA=;
        b=l+w8KBYO0hSg6QM9KWHHVH+DVTC64u4qKx92KIwTjHIKN6jDnuCQ67eov8d855HqPs
         GBC4yRc1GEnvV4/HTlX869I1WuCAx4kBpmEDYjfVlwvAnd7TAN2MfkLSlx6v7AOcgqya
         nEbrTE/R1XAHHSFHDNSPV+VDtLkHsVjstb1PwxPPRk9i+kcrty48WKQfMFG6CE+rWvgu
         9Mpv8RoPBqh5RR3Mj5guXIq+mGkk/IlpmAwZB5UrIALg+tdCq9j3L+JpUjvhCJ0u1hSd
         jbBP2msE0+6o5tYjijaPvW/paBUG0WYDcTdhusevl1u7DYJI5o0zzTkiRzu1qW8jVkWV
         +lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842272; x=1734447072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWU2eVhMhcb/iJGFd+VmNM2XsfhPsakUhRt7/wk/dGA=;
        b=qcYhFDL/NvhgNQj8fPexqUAjYAW0ERV8TZ6sxjVsI8KILfAnMbm1LEoPmHIk0yMzrG
         CSDWO2bmkB0YLvwAmOAKs8kXzPYpC/LF+sKNt3BNRdhq1d3vb+CblCUlVP3ceKRXwD+W
         rc8kIh8Jn1Dn0HkzyC8g2qHK0SZ0Ph1Ys7niSzce4XgWHAuGyq3AM3OJlbJOFLNLMz6y
         Porxz+QwD457PVmM+Xszt3h9/S481bIZigC65uJ1/or0aLtLxBzVoMji+KennNGwchAX
         iCMDc0ewEyvQMR29638HwAj38o8RorlYtfSKQPZ/uhqguwEEAghYZMV8NGyMtdmA1KAu
         gJDw==
X-Forwarded-Encrypted: i=1; AJvYcCWMlgaT9Q39iNAjLqOQhiBNsdoCp96CBuGnA6+aZaqYRJFKZoZYXmfevwZxeTzvZeFQewTP8OdvRgK/F1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+levpHxfZ8AdT0OT4wLVrWvbXjU6pNWfvkBwHQXRvkyhn3ox7
	4WjDZo9Ajai145eHqZF0BTU92nuBD2XRAOERhCltSHZrIJwCk+/H3tYR6gP+NwE=
X-Gm-Gg: ASbGnct3rCQIaRhwgStRjZMnd26JoVPWEuZ9dgHPmivQt26tGSqmXj7dV5tojEuodud
	jfv6OznKVrcbjYzRDSvYkj2aYn+DS/R1UyogWpPg5kS0iVZrY7SqYZhX0ngwljrVf4ZrfFqm84g
	gToEB5wEidG8AMGOOdtP7+p14vheMCJVgpV/iXn88++04jNAdzC7fUX5DF/QvA1kzXADtHCIG8p
	BbC4eUIaG/sg0uYeRvj2HomYyDGOjDr7J69ZG9Spm7NWPJqfjwYWTs=
X-Google-Smtp-Source: AGHT+IG40tI08nse8JUwHqIkYlScp+nI0cpXGiTCqsdS3M7WqGX1DoAKZIPNJ0b6mJGMqFr9aOshZw==
X-Received: by 2002:a05:6000:1862:b0:386:62f:cf18 with SMTP id ffacd0b85a97d-386453fbdd6mr3663152f8f.49.1733842272254;
        Tue, 10 Dec 2024 06:51:12 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637445f13sm9879198f8f.35.2024.12.10.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:51:11 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org
Cc: yeoreum.yun@arm.com,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Leo Yan <leo.yan@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: docs: Remove target sink from examples
Date: Tue, 10 Dec 2024 14:49:28 +0000
Message-Id: <20241210144933.295798-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously the sink had to be specified, but now it auto selects one by
default. Including a sink in the examples causes issues when copy
pasting the command because it might not work if that sink isn't
present. Remove the sink from all the basic examples and create a new
section specifically about overriding the default one.

Make the text a but more concise now that it's in the advanced section,
and similarly for removing the old kernel advice.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/trace/coresight/coresight.rst   | 41 ++++++++-----------
 .../userspace-api/perf_ring_buffer.rst        |  4 +-
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index d4f93d6a2d63..806699871b80 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -462,44 +462,35 @@ queried by the perf command line tool:
 
 		cs_etm//                                    [Kernel PMU event]
 
-	linaro@linaro-nano:~$
-
 Regardless of the number of tracers available in a system (usually equal to the
 amount of processor cores), the "cs_etm" PMU will be listed only once.
 
 A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
-listed along with configuration options within forward slashes '/'.  Since a
-Coresight system will typically have more than one sink, the name of the sink to
-work with needs to be specified as an event option.
-On newer kernels the available sinks are listed in sysFS under
+provided along with configuration options within forward slashes '/' (see
+`Config option formats`_).
+
+Advanced Perf framework usage
+-----------------------------
+
+Sink selection
+~~~~~~~~~~~~~~
+
+An appropriate sink will be selected automatically for use with Perf, but since
+there will typically be more than one sink, the name of the sink to use may be
+specified as a special config option prefixed with '@'.
+
+The available sinks are listed in sysFS under
 ($SYSFS)/bus/event_source/devices/cs_etm/sinks/::
 
 	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
 	tmc_etf0  tmc_etr0  tpiu0
 
-On older kernels, this may need to be found from the list of coresight devices,
-available under ($SYSFS)/bus/coresight/devices/::
-
-	root:~# ls /sys/bus/coresight/devices/
-	 etm0     etm1     etm2         etm3  etm4      etm5      funnel0
-	 funnel1  funnel2  replicator0  stm0  tmc_etf0  tmc_etr0  tpiu0
 	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
 
-As mentioned above in section "Device Naming scheme", the names of the devices could
-look different from what is used in the example above. One must use the device names
-as it appears under the sysFS.
-
-The syntax within the forward slashes '/' is important.  The '@' character
-tells the parser that a sink is about to be specified and that this is the sink
-to use for the trace session.
-
 More information on the above and other example on how to use Coresight with
 the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
 repository [#third]_.
 
-Advanced perf framework usage
------------------------------
-
 AutoFDO analysis using the perf tools
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -508,7 +499,7 @@ perf can be used to record and analyze trace of programs.
 Execution can be recorded using 'perf record' with the cs_etm event,
 specifying the name of the sink to record to, e.g::
 
-    perf record -e cs_etm/@tmc_etr0/u --per-thread
+    perf record -e cs_etm//u --per-thread
 
 The 'perf report' and 'perf script' commands can be used to analyze execution,
 synthesizing instruction and branch events from the instruction trace.
@@ -572,7 +563,7 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	Bubble sorting array of 30000 elements
 	5910 ms
 
-	$ perf record -e cs_etm/@tmc_etr0/u --per-thread taskset -c 2 ./sort
+	$ perf record -e cs_etm//u --per-thread taskset -c 2 ./sort
 	Bubble sorting array of 30000 elements
 	12543 ms
 	[ perf record: Woken up 35 times to write data ]
diff --git a/Documentation/userspace-api/perf_ring_buffer.rst b/Documentation/userspace-api/perf_ring_buffer.rst
index bde9d8cbc106..dc71544532ce 100644
--- a/Documentation/userspace-api/perf_ring_buffer.rst
+++ b/Documentation/userspace-api/perf_ring_buffer.rst
@@ -627,7 +627,7 @@ regular ring buffer.
 AUX events and AUX trace data are two different things.  Let's see an
 example::
 
-        perf record -a -e cycles -e cs_etm/@tmc_etr0/ -- sleep 2
+        perf record -a -e cycles -e cs_etm// -- sleep 2
 
 The above command enables two events: one is the event *cycles* from PMU
 and another is the AUX event *cs_etm* from Arm CoreSight, both are saved
@@ -766,7 +766,7 @@ only record AUX trace data at a specific time point which users are
 interested in.  E.g. below gives an example of how to take snapshots
 with 1 second interval with Arm CoreSight::
 
-  perf record -e cs_etm/@tmc_etr0/u -S -a program &
+  perf record -e cs_etm//u -S -a program &
   PERFPID=$!
   while true; do
       kill -USR2 $PERFPID
-- 
2.34.1


