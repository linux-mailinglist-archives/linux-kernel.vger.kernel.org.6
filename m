Return-Path: <linux-kernel+bounces-537516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6AA48CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA202188F023
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BA276D27;
	Thu, 27 Feb 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipautFG6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353EECF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699472; cv=none; b=J05CRcPXMvnK62EzD3Tk/OBL9Byzlyb05v8Pg8vOp4Ei4h1ET2mFfDAwWxt+hxdP1hh2iw4Xsip/ud4SQD6FJjVV3wvOn/30iThk9hvkh2FWF4pf/8+1W8syJCn7pHxprxFVysSzehPRzuRQoJ07QSswsp5QxjWPKOg07PInte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699472; c=relaxed/simple;
	bh=WbgiTFR8OLXl9EBrqSFd1T+tSTHxoHSLOquz5CCP0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrDJAPm50PYl9o2Orlv/T7bjcVrSl++5ym17D6V5HUnoyovVPBcGmTp28XP5yC1t/10UVVwFn7xLOWJX1wytRhLiegPZgCvCebFElvWPJStLE2n48HmvHTQGA7Mb38F4gaTflf5V3sfrAXDzlt62FFnSdlFmmYys7B2S/MJtaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipautFG6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abec8b750ebso233831466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740699469; x=1741304269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGc/M4Idkv0pwDjroWrApK5Pl9QbkdaU6P/ll2uMees=;
        b=ipautFG6dzwXeRvDsqzrJTT0SdQwi+fqageiZh+AbFoN0PYwST9//B8exAJL5LB3xK
         mFFyofQ5U4LU2VFigYoteQD+Rx9/vedKguzqhDcolOi8x5SM6TAM3793CeiS3dF/JZEN
         KrHwJps4n0UIKGVYPEyFBwJlfxYVBZgPOK3kHxgMC3zQWqLm2yfOcG63LjuKWd2AA8dy
         a6GxreyBUo6fMCMdhy7aNwxvuZN9DAJCI0RQLZsR+oeleXwy5ZrH028JAgqC7bSDkwlH
         sZLQQ9BGhiUnIqMP6iJaOPf3oDWJBv08+GtDbHr3OHcaSawA/TZJy5glSCzpoHADIuZk
         QpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699469; x=1741304269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGc/M4Idkv0pwDjroWrApK5Pl9QbkdaU6P/ll2uMees=;
        b=iQAn5KBwlcQlF5Tyk/tCbFkL+DUqoBVcadf0lxpe5575QHULVl5e+XIRTb2jeH6y4I
         nzKNKHwQIBLlzz86OlWfxn+jGNuvJKM7nMSFSFRMwsMFxUOYTddt66GPUCprfeUCJnic
         +xYrWqW36re6aKwSa8+o/a71tnBFNnbEL/T5KBzpec128ia1n2yA1d5uOX+FEqu5VCO3
         fyslxdSbPb22PAzmeU3TAJRhvwvt1r+FAM4a4JR8cEtAclHvkLBrZdJSdZH8opEtv2OF
         91sOIUGD4TSzFftmzHZFIUlhqQ0FRoCQlsFiUaH9Tvqk5e1nh4fTJdgGo6vxyJuroOPb
         NNVg==
X-Forwarded-Encrypted: i=1; AJvYcCXjFLAkIW7dzpLW3Pb73qyKkQFuvtqbQbeFDmLhZj6kL3kDoqAYn2ZgoFqCggCB05oSC89/aSWCVN1jY0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzm9/LijbVPNZ1IyeELoTuxqqi6TdiJ/tORoxLH2Io4HJe9UQ2
	+dXlXgUzARZM9J3ZG9Xe/B21+Ff7+6A9t4f0phh5CgsNIHc3lAn2
X-Gm-Gg: ASbGncvByYkma+EqygHxBP/hi2LLfC7TphH3XLsbgAmB4U6BpanPUVaZ8a7mveL7Jdo
	35a+DAFLkj4DedFGVMxoikEUmvX/OSxCHGhv66U4BrjaGiM8VMtHq9DKcXpCq3215gXYRc4eSUy
	VjpM5u0+FBFSHOIiTkIuHmfapkA10OdNRjgX6vxt7YyUuAKfV+gLYC0BZ1TJOAlvQHtPkmAcLWe
	q80y3RbA6pdx9c9k5NQpwct1nGGKIPJ82uTOHyHSWARQRhD3RHSsWCAB8dBLEPW6d5z+dNKATNQ
	bsQTBWKh0O3lw0sofHNuQIlF8L7TPe3gDZei29Hoh7LT
X-Google-Smtp-Source: AGHT+IEJcVjn3ZpyU+qcNsU8eoJanDnChcfkLru3SZxuIgNCauuDPyZOublah5knY8QfPW6TT9dHFg==
X-Received: by 2002:a17:907:3e9e:b0:aba:6204:1c03 with SMTP id a640c23a62f3a-abf26831546mr126718066b.57.1740699468600;
        Thu, 27 Feb 2025 15:37:48 -0800 (PST)
Received: from f.. (cst-prg-72-140.cust.vodafone.cz. [46.135.72.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm199241366b.13.2025.02.27.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:37:47 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	rostedt@goodmis.org
Cc: vschneid@redhat.com,
	mgorman@suse.de,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] wait: avoid spurious calls to prepare_to_wait_event() in  ___wait_event()
Date: Fri, 28 Feb 2025 00:36:52 +0100
Message-ID: <20250227233652.142613-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vast majority of cases the condition determining whether the thread
can proceed is true after the first wake up.

However, even in that there is an additional call to prepare_to_wait_event(),
resulting in a spurious irq + lock trip.

Then it calls into finish_wait() to unlink itself.

pre-check the condition instead after waking up instead.

Stats gathared during a kernel build:
bpftrace -e 'kprobe:prepare_to_wait_event,kprobe:finish_wait \
		 { @[probe] = count(); }'

@[kprobe:finish_wait]: 392483
@[kprobe:prepare_to_wait_event]: 778690

As in calls to prepare_to_wait_event() almost double calls to
finish_wait(). This evens out with the patch.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

One may worry about using "condition" twice. However, macros leading up
to this one already do it, so it should be fine.

Also one may wonder about fences -- to my understanding going off and on
CPU guarantees a full fence.

 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2bdc8f47963b..965a19809c7e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -316,6 +316,9 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 		}								\
 										\
 		cmd;								\
+										\
+		if (condition)							\
+			break;							\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
 __out:	__ret;									\
-- 
2.43.0


