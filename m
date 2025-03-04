Return-Path: <linux-kernel+bounces-544281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15877A4DFAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7083F3B2252
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E22046B5;
	Tue,  4 Mar 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDilSD43"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0849204685
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096217; cv=none; b=NGzSy142q9oE1WBOveoybPW9ou7amZfQQgEWbf+MKKV0NW2C/OQodftmQSXv7vK/3fvKLQPuMjLEXKOfYrS7cPu162G8mLXX2Rw1Kylqn6URW59ds73llfxK8E4/DesFLRxMeVXbAVwa4+BBJ64IpnuLcbWqd8hZfP9KCyoQ5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096217; c=relaxed/simple;
	bh=VIqcZfiOk0OaZ2h4QCbBt4ZSsIFKt9GBkYKdO7Qnc0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NcDzzW/TTD1gBUrx9GnSjxMbBwz618rB1ffKGhGYPcpeMU0p9pdCTqlFC6pUH8+U4PysyWWmm1p2zSohltSwYOulLszZtmjyY3/Z/B9p501wMPGQxhgI4zpiHKnZ85kZtfkqWt97C5ONQ2hVqoxN2Sr/4ncIPDnrMCwJtwqQllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDilSD43; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso13813435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096214; x=1741701014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GF053zzKXV4TcXq6EZaCYpeQukmq+2ermGWSI6/DtXs=;
        b=HDilSD43tNNGNcQVdTKt90SYKEr3jWLnTGKnX5W/GhfMawuDA/jsz5RHAUc5JHbOVf
         DEIa3RheQ9u6CA/Cy9JbNfDhtJGRa3DBEO8/BmYvIv/JohWjnIMuLX6wGC8YqPd8u1Wg
         C8apHrjamlbIs5bDJwXTQFQzIYvjxgJMTN02LrTqE3/RiEE3a9vKHnF1VFNF+QHKtbl7
         dXw6M7PDwpR8ETD3s7GlQqRQBBgcloawZPFQoyNLNg4feEqeAl8qg4m0ji7ykLb8epjG
         0FcLsyyR0UvWpynFyHPr4ZcHUK6GGLrzT6xMWuGrCfpKvi+uaEozUvSDv+9K5LGnSSNI
         Ul7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096214; x=1741701014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF053zzKXV4TcXq6EZaCYpeQukmq+2ermGWSI6/DtXs=;
        b=FzuV93Nv+kWKlGS5soac63lUAk70uIKNhEmnSWSVZ7x7a3pvb48m/3cGAGd7YBx6RK
         ck6rNs/rSUmmmSYqlYrzEGF3FXmDU665YBmsaNrhcCIv08WNmG8ufFLrGFJ3zW5wrbBe
         /1hHuDGxLIn25ht+AUjnjNyW6k2N3U9BQXIxEcSxUgWoONwlT4JqRsJvNGlWpuK9OhRd
         oNWovHm6XLsBWxlUAi0dYRB37iyMOECRRs8TIZCX6PJOWLJzdlwNp3LvwLcNgbw2AgmM
         NZzZTTExJimQo3cr9pB1r2bCmrYTIZpjCUqTKavGztEwyhr2tPfMCzKxje/00O6MpHqt
         gK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1gO0Ty85+c8GY9XQnpWb6J8MS3plxJoSw3K+3IcSxF8YuP46l4CiXrtKhYxhfQuuhooSgqIiu0Y5/1qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpVARnzaYr9sqY86GmClzkL1o5TjNdmPppeX3YewKNzotuZaK
	2yqUI0LyByQiAzjtpOhEoQVmxrSU1RuSXKnlubbasKRbuxZnzJu7WqW4K8uMLMI=
X-Gm-Gg: ASbGncvD12XDv9m7qMr2+aeVAEXMku4q94FXqSI57jb/aJwsEAXxn9yy/0pjfPwqeh5
	VnTmdH5NcsRZSc7aHlu7yyhL7vkfL5qa9T9AcVI9frsNIYVzTdJqjElUe2uaFOSjOIDhdKZ+euw
	EqzaknV7hcIWioI+qrP0JnYDDy/WxGxAAYjFGi0M0BR9UB8EECmvqNymplru0emLRmIssWRkLfp
	O42ZdaVgl/QescEMyRgB+mycElc5h9hTcWv/Swke0kj8GRqBQKriFVaa+hRhu8QFAL5iuZpQM6b
	wSHN6YQyfF2aC1ey52Q0RLS0X/8sS8u+ZWvxEbwedd/jr7G8
X-Google-Smtp-Source: AGHT+IGbdm2bSX/GRgVRkuVD6qCgZWkLZAlu4OLR1FMdBVqYgxPW5Ql3R1YZzWMUfz3c/ALaXTMdpw==
X-Received: by 2002:a05:600c:3b1b:b0:43b:cc3c:60ca with SMTP id 5b1f17b1804b1-43bcc3c61ccmr18071935e9.21.1741096213994;
        Tue, 04 Mar 2025 05:50:13 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:13 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf list: Collapse similar events across PMUs
Date: Tue, 04 Mar 2025 13:49:12 +0000
Message-Id: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgEx2cC/x3MSQqAMAxA0atI1gZaByheRVxUTTXiRCKiiHe3u
 HyL/x9QEiaFKnlA6GTlbY2waQLd6NeBkPtoyExWmtwUOPmFFHeSgOPdCvc4sx5obeuc60KRlx5
 ivAsFvv5x3bzvB472/5doAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Some changes related to the discussion here [1] about deduplication of
PMUs. This change stands on its own right now, but it may not go far
enough. This can either be dropped for now or applied and improved
later. Extra ideas are as follows.

Treating alphanumeric suffixes as duplicate has been slightly
problematic due to marketing strings having looks-like-but-not-actually
alphanumeric suffixes. For example 'cpum_cf' and now the one digit
longer than before 'cortex-a720'. The easy fix is to increase the
minimum length considered for deduplication as suggested [1], but as
also mentioned, the current mrvl_ddr_pmu PMU names don't zero pad the
address, meaning that > 2 alphanumeric suffixes are already technically
not enough to deduplicate the same PMUs. They could have only a 2 digit
alphanumeric address suffix. Increasing the minimum digits feels a bit
like kicking the can down the road and it places awkward limitations on
marketing names which we have no control over. Also I'm not sure helps
the following much:

The problem is that arm_cmn_[n] PMUs have a numeric suffix, but they can
have different events. Even if we were adding this PMU today, keeping
the suffix rule in mind, it would be difficult to come up with a suffix
that differentiates the different ones. Flavour words might work, but
that complicates the kernel which would have to group them and come up
with flavours rather than just doing an i++. Deduplicating too
aggressively on only PMU name suffix means only arm_cmn_1's events get
listed, missing other events, and it's hard to see which events relate
to which PMU.

Therefore in addition to the changes in this patchset I'd like to look
into:

 * Collapsing duplicate PMU names into ranges, for example
   arm_pmu_v3_[0-4], rather than simply concatenating names as done in
   this patchset
 * Deduplicate uncore based on the contents of events/ rather than just
   the suffix

As some background, the original commit for deduplication, commit
3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
mentions reducing the number of duplicate PMUs, and is presumably
motivated by usability. But there are also other commits mentioning
reducing openat()s, for example lazily loading formats 504026412162
("perf pmu: Make the loading of formats lazy"). Deduplicating based on
the contents of the events/ folder is somewhat in contention with this
reduction, but could be done along side some more lazy loading (like of
the terms) and hashing the result of readdir() without opening any of
the contents. JSON tables can have event name hashes calculated at build
time if we want to consider them for deduplication too.

Then with the events hash, PMU's can be sorted based on this and the
'Unit:' string can be constructed with a set of values that collapses
adjacent suffixes to display as ranges. I believe that could remove the
need for any further changes to duplication based on suffix, but still
avoids over deduplication.

[1]: https://lore.kernel.org/linux-perf-users/CAP-5=fW_Sq4iFxoWPWuixz9fMLBPyPUO0RG0KPbYa-5T0DZbTA@mail.gmail.com/

---
James Clark (3):
      perf list: Order events by event name before PMU name
      perf list: Collapse similar events across PMUs
      perf list: Don't deduplicate core PMUs when listing events

 tools/perf/builtin-list.c      |  2 +
 tools/perf/util/pmu.c          |  5 ++-
 tools/perf/util/pmu.h          |  2 +
 tools/perf/util/pmus.c         | 95 ++++++++++++++++++++++++++++++++++--------
 tools/perf/util/print-events.h |  1 +
 5 files changed, 86 insertions(+), 19 deletions(-)
---
base-commit: 7788ad59d1d9617792037a83513be5b1dd14150f
change-id: 20250304-james-perf-hybrid-list-11b888cf435a

Best regards,
-- 
James Clark <james.clark@linaro.org>


