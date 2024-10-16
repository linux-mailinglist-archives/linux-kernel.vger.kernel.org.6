Return-Path: <linux-kernel+bounces-368903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E29A164B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2E01F21491
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3301D54E1;
	Wed, 16 Oct 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEGglxzw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46871D5168
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122991; cv=none; b=bPCrPyoJLMsrK93J8H5wq9elvgw6DW1dpLxzXY/Q9nQF3fuwXQKgKpaEm3hHem+Yiekttyr6IzJn7AlI+DWiSdALq+93JUgjmW3oSbOP/EtoQbKBW+xHzQXRGEa4tiYaGuOtvXeeM2uvzMzfCaVFObG+3NH84FyLPP2/dL0i36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122991; c=relaxed/simple;
	bh=Bs2cKov5g074OfyZxI70AYL69p/8X/pN8AqRpTZvDu0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=d2yRCEhCDxjsV89O77q4nYsstz28ZGUuytY3VL6lgoinQU69rZCZCHjy05u8J/9ApCq20lAixVOBVtUAjtqJXgQrGQCuOqKoPWSrak5ofRhJfQIQCkUOYE1MZS8b8Hd+9QWcmJsMprua5yTk3m74MfqyAzjOKHZTqZoU1WbssRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEGglxzw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so12337527b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729122988; x=1729727788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEzJ0iRcDple22huSPs4DlKKUeqmgoCxw4frQ+1aRxk=;
        b=JEGglxzwpMy9T3GD+AGUxa99b/eSh3kfHGlTRiZ1/by9WD9U0cpiUWR88d5Q4Km07S
         Gxjgw5/03t39YkkmxhpnGYEprOSixlCPCsP/BwB1SGS9R9vnetvPug2C4TTpcZkV11Jr
         mDZH7qaZwpOL5pQ+LGBJJckv5X/ZsfUtBpSglRxPec8ZSDmL6sg7pTe05XONG9TLANYb
         zQIt/rkxIio69dOo7VpKlW8ayjz5oKIk0UuxhX7uXEua9HFRt76i4fa28jfLCDJTV82j
         geID3GR63DO4WdcbQS7C3SPo4S3gk+MQDsQDoFBkYT0eo8pPboj2zSDH/4vZkqtkSeTh
         2CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122988; x=1729727788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEzJ0iRcDple22huSPs4DlKKUeqmgoCxw4frQ+1aRxk=;
        b=jaZI+lAdwSvtOFYOen3kZS/NV9JILndOKdR/OMd/va3M4QQmR4CHi3jKKRvWdg8YSO
         pdu4pee73GOaYOKnGKOqEFwDDCjo7X6b4tk3krGWFbTlpxPjqbNbtFVSFEaOnEXtQbte
         Bb+4ofnORGqkdANzqD/H8zAcxhPNqKM/8yNjHAOAb511BcSvnhWIEFgzqIvUBuJE/W7I
         6mymuu+9A/ELPL8zRxFO2HDk0muwcVzLqI9M87yW8k4a9O39cFkd8ndOLqhJHnuhuwOy
         F1qdsuC0f1DuVPcOXggkKH15wUD5Z6jyG6v+yqFvFekUY/RidItmhRw6JdCexck0Bohx
         qqKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QkRZ4/vro4gbNXsyMZpWfYKffR5OycaD0I/MtSGjG1TT1pI+QGkTvE/cPajOLm8gIpKp2JPCzo7WYvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1hpSzf0Bh2Xgri+CV78I7nv8JT4KiNIGoz1u1RLm+hm2Q3CX
	mshPLQCvQtIDvN8T+0JoGuKNFAZ26ow4oMfk3uj2L0IRVVtDdW4nxLYUFRQcM8e6CUfXLb7u7Sf
	8CM4NKg==
X-Google-Smtp-Source: AGHT+IHI24jqBASrAtT64uRY0cnhQL9f8zsYp5VuyXMpamVCWXzsRO52catAzQegbSl+MV9plJMSCJY0TmT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:350c:b0:6a9:3d52:79e9 with SMTP
 id 00721157ae682-6e3d41a64b8mr1096747b3.4.1729122988494; Wed, 16 Oct 2024
 16:56:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:20 -0700
Message-Id: <20241016235622.52166-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2 0/2] Fix 2 memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix memory leaks with libcapstone and libdw that are detected by leak
sanitizer as part of perf test.

Original v1 was here:
https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/

v2: Avoid broken free reported by Namhyung. Move build fix to
    subsequent patch.

Ian Rogers (2):
  perf disasm: Fix capstone memory leak
  perf probe: Fix libdw memory leak

 tools/perf/util/disasm.c       | 11 +++++++----
 tools/perf/util/probe-finder.c |  4 ++++
 tools/perf/util/probe-finder.h |  4 ++--
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


