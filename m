Return-Path: <linux-kernel+bounces-259139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAD9391CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BB51C2115C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE416E876;
	Mon, 22 Jul 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkSGdZko"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968216E864
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662137; cv=none; b=jyCutkBYah2t+vwN5QjsvUryZ9Ot1J0UsdVGN2O7zOrpd2s+SLtm75DptOE2f9kLwhR2MiwasfoyQV2tCIhDXfK/iWUX6RXNClJFdPwcWa0Wiad3d8XH5jFJF0cvXgstyXmjva0LP4yRJeOr6pExahSjGv3aXeAPyPc/IzBKmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662137; c=relaxed/simple;
	bh=KUt3x8NLnp7l6rMq90BpQGACUXWMEdwkYc0gJ83SdHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuSBtbJzrVstEC7wCqUoHyRuT3SrXMdghfiz8c7pEfP/bLuG2491R72fmU9/ascwKCfazSWDGyo5Pk1RfUuod22XcHLGRDwiUa1rW6whR/b9C4wlroY3SeTqIcu4dkEIM189FtGTAUz/J1QyJrH95x+hr7XSBLLMdCU3MHC8dQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkSGdZko; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f344091so32540195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721662134; x=1722266934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGaIE2BW7BgAaIE7phZSFxnm75sxmFFkaJHJRi/UoXw=;
        b=PkSGdZkoxZfOUYfyacYLc7HSslu7tbK32XwzgShsD11le0YZWHAaDNNRdMbJBf2ESL
         /XXCj0aMK9OuddT4fRjGylsrPZImhQhUCNflbiKOM4SoA6vdZRXeg4hQRMlE4ndWRstc
         sfivehn+Bvl2Xhik0M98P1hICJzVdTy5iGeQFhbzVUi8oTLye0WPUgpMB1tkZsgtOORn
         sp279vu3w0km8Ll0w3GQ+TtAFo5inT+IC2830jGhGk7oIARYVfJQnpzhKFdOnO6eJqDu
         7s5jTEjw0V2nk9igjunoG6bV1Si5IIz6MvBlsxNZDUFykb7usufmPmYZfhIsk6dLlcHp
         alfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662134; x=1722266934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGaIE2BW7BgAaIE7phZSFxnm75sxmFFkaJHJRi/UoXw=;
        b=e6e2NNl+nErzuWAC81Oe8zVGWHlJVHT28Yn8KLCbyx2odfwxK0zvUAJRQM5tn00yU4
         0EkChVkXutDb8W+fxwCqiuHm9YNGz3Rmff6HKiDnBO6RI2fN9HfowmbPK2yF6LLozJw/
         z9sjy7BG2F1ZIKI5M5m1VL0jSsk4ttst0jevk7Wyph4k5/JvtkTNnKCUd+M5YdKY7haa
         LWrjZfRpt2qfJ0job+EyFSmQI52qzUPbKxQ/m6K8OMFfQfQwN/Q+ldbb4ycHylCwLhLW
         AaySwoyF8ufydLoQxDyJzKzGipdQJksKhHifLxSu7kkeNBSqgJFSiv7JNBRd3vrG62IC
         oMew==
X-Forwarded-Encrypted: i=1; AJvYcCXQb4Xpllrni5xvZZQEtgO6ckEgPKsUbZr7kbbEW06ULG2SF3CV8c6fUrgoHHQoGvI7y3OFMQ0qXqOYjuLk0o3UEvD8lqaJakVQr8XN
X-Gm-Message-State: AOJu0YwiA7fPkorvAvVK+o/bm1zKVqcHOlSObGfY1zO6IrxNIMaa3ydh
	M2/zIq0Skb57H0geLa1PxtmzlstSGyIHnQLRNEQ6OVK1Tbps7E9342XChzCQ91U=
X-Google-Smtp-Source: AGHT+IFf2Ks8gYykNvvkym6GDERLbQvRpWLVHjp9QVc/oQjWbWHuohfqpzS9jIPwqCj6q/nHPU9N4w==
X-Received: by 2002:a05:6000:186f:b0:367:940c:6a3c with SMTP id ffacd0b85a97d-369bb2ba0famr4873470f8f.41.1721662134479;
        Mon, 22 Jul 2024 08:28:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm160654535e9.1.2024.07.22.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:28:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are flushed
Date: Mon, 22 Jul 2024 16:27:55 +0100
Message-Id: <20240722152756.59453-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed this when looking into Ganapat's fix to arm-cs-trace-disasm.py.
I assumed that seeing this in the output was a bug and went to
investigate why it happened in some cases and not others.

It turned out to not actually be a bug, but I think it doesn't look right.
In the end this change doesn't really accomplish anything and I'm not
sure if it's worth putting it in or not?

Maybe it will save someone doing the same thing as me, or maybe it will
actually break something if someones script is looking for 0xdeadbeef?

James Clark (1):
  perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are
    flushed

 tools/perf/util/cs-etm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


