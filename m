Return-Path: <linux-kernel+bounces-275551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83294871C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9DB1F2391A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB4B65C;
	Tue,  6 Aug 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UR0WAKVJ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56401F9DF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909435; cv=none; b=jP0pYPGWxa+kA2SYWOuRUr1SI7/fOJAyNdM4emmpeeW1F8jLq2VLl3sxMpGJNlbn312mhABRIBqVCCr3PlXs6AebZLolApVVAdLxUbo1oaUvNaZKbNKe4gDR11eKv/brB+VD/dU5Tba6WRg6EnYeeiIhglVOJMdkvzqeGPZPOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909435; c=relaxed/simple;
	bh=qmjwWQ6QasKjrkVUxCzo9BcRTbn5iMp89oLmum3d2Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzdQwO+DWMEZERFJ5qXVlka4b9j+rXmmdoDWdRAtRUliQT/zsWrn9PiQS2c9z1eC6hL4EMq3Z1MhRs7gG3gNEcr7jiZMuq56mBNERh8l5QM8RqEAGByImrwbIHJCj8G33y3jhSZGI29vCJ1mdSE6FHF5MYN/0KkZaLbEeymvBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UR0WAKVJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd69e44596so2624565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722909431; x=1723514231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNbH2l+f98EFaxyweVh/dPqISWyY0AP+f1WHA/sTSok=;
        b=UR0WAKVJ/We4USVgtTA8DAXtu9RZyoAV9PX0QKb2wSjD8pv2YnilQyTvtOUKAXJAhh
         srQFpjJZ17kB4eeZMS7pN+5cDQ8zUtyqA1azbAffA2qytC6lJksHo0Q1CW/Uea0oxfdT
         1H0g0qKXPgcMRFSaAPKi3rE2iDb36kxt0LxwRM/il8CcRtdyaWMbJINyGca2tx9nZGCX
         hZMCwkfTmnunUc6yrBxM5aW33dt72zj5F4JIZiSSiGiKchZPOCuLOMTJYJ0bXA/WaYix
         V0j8KYNDFbX3jsvnViWhW2RgRFqIgiD5hBn7euOc5Fa07DUMYqNWUMWkoF/JJZ95qs5e
         FiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909431; x=1723514231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNbH2l+f98EFaxyweVh/dPqISWyY0AP+f1WHA/sTSok=;
        b=UBu38lu+SfKgLYteJOrC3xlWXL3Bxvr+Mc/SZ0+95J8lH3ugODNW0aP23LERbWWctb
         IcOCVWKjEvHeSJQb133TXeVuIQUfeWZC3f3BKHXATICMo9AMICXMDC8vHnLJOhb9oz0n
         81LN3ve31w8o8cTRXYI4pwECXqrtRnHoaiBHdQPYsxIqJCiNW00Eukw1yyG+OhDlE5GI
         Tq28bkYJjtspnNalX1mXp1XzYc4L5cxrDwexJC1DzkU6G8E68XzhsSf+p4iYzyTZyyc7
         HBxTEwIvOQ1rM04i4ShXzkKvvMFac0tXg0lPJNAt6gJc5lj+DOKaeO7m2uBw8isZvJVu
         yQNw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGjTRJoU68FajT6N/noDrAMC3Jr54vTAzHhWoLBiclf9e1DMpeXrebiXU5EY316lXTcGwUIwP2aYeAfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykC3FP1bw75RH1SP/TJnUVmYZSDtHrdsY5yxQXU2gorbOlwT8K
	pwM52jmqHjOH633H3P63YaHjuYbJCRv0kTSOkfOXryOZqWQNox3JpQdqASONKnw=
X-Google-Smtp-Source: AGHT+IH+NAgt5RGJPsxRWyM2LY2HdYVr5vLtBqHS1AuItEYySLf9oxzb1hg/HtnL1pYaofvNDkUQVw==
X-Received: by 2002:a17:903:1209:b0:1f4:a04e:8713 with SMTP id d9443c01a7336-1ff57f062b9mr246030095ad.28.1722909431538;
        Mon, 05 Aug 2024 18:57:11 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917496fsm75509455ad.182.2024.08.05.18.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:57:10 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 0/2] perf sched timehist: Add --show-prio & --prio option
Date: Tue,  6 Aug 2024 09:56:59 +0800
Message-Id: <20240806015701.1309833-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds --show-prio and --prio to show and filter task priorities.
Sometimes may only be interested in the scheduling of certain tasks
(such as RT tasks). Support for analyzing events of tasks with given priority(ies)
only.

Both options are disabled by default, consistent with the original behavior.

Yang Jihong (2):
  perf sched timehist: Add --show-prio option
  perf sched timehist: Add --prio option

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 163 +++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 7 deletions(-)

-- 
2.25.1


