Return-Path: <linux-kernel+bounces-177284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB988C3C62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233311F2166E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0B146A90;
	Mon, 13 May 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CUCKKwqU"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D971292CC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586563; cv=none; b=HqALS6BLQZHVxdxgb6WSIvYLM7o+4lXiLnZ44yatkOqKtpMU8AGw9WqHFxHxDNGpJhhpRZ9DiP7NgOkChdXsdnMV9X44cDjHG+cqcUzlnuJ7YQnyrJRvaIS5sBoGJjqaF4PVbU5+0xv14HqCQ8b+mLocoZOsfu+1owgw7Dkl3kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586563; c=relaxed/simple;
	bh=G0Wxv8Mr3gKi571FDo6mPoWa+cS4/DlqZzx4ZahtWhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cR8jftPyPxPFss/Qk6olKF2RG5R/aSItgetw46p5J7defsNL6/O/i4hV52wd/5RaXpGQAUnTylLW0jTUVgQmrxQFgihYK+1UHdzm7wzU4GSJt+PhMfgp3iuQKedVduB+kyB2ph+lonlxhsmnBttF6pp5GwHwqEEij5VXjv7CW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CUCKKwqU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edc696df2bso34760185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715586561; x=1716191361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce6cAtkfdDJ8qQDyG9L+69C5l2y3I58tgkjiw/QsktI=;
        b=CUCKKwqUevQwNv02m7TkbtrAN8z26k9dUe7xANRRKSUYwefDZU7dztOgXR2/XWSKvq
         WljQ5Ro5lyEMxuhQ9iXJ8OsPnsevz5zMePMOrzjd0VnHWHpsN09sy3qeDNYe+9pYsQXb
         0kcx5KgsvYTcp1w8J4/XjWkGqx6LvOXTpI6rsfMWPP6XE2VVle+XTFcqBMqrZ1fbudPb
         U+j5fl8bikeVzyRBEWg8uv+S+I7BmqkED1nrcc8WD3btfzz7Lz3SAKR1VA9qq+1iBknM
         QnRZrtKV3BzJAqBAwKBF+NPXpVIQXORpnMk4KwIgftnComaX/wsCrB6taSUfN+BzYTTR
         LZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586561; x=1716191361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce6cAtkfdDJ8qQDyG9L+69C5l2y3I58tgkjiw/QsktI=;
        b=uk1G7QPW/T3SrtdaoEfBQJa40Q4GGMBk8nOHNf37YucHZ52sB/Ft1t4kN4HxbyhZCd
         mrbi1rUPA3FKLEe7agQ8g7NWtN7fKjwJI2Na2cj+pB2Z+TmCXMOVlO90JbhIqMbzt82D
         dVAwL7zctzLzaFtHxcCIgHED8wsqiZSUbBrkN7K94G/zYXp+gmOGNri17sW8dPWFB3dP
         INcg/UIcn7/8RJeku/Y7ufWQVIskqVN6Wz1gvASCvFcMAHYsX3JlBicq9Luh22ldDiPC
         o+7k8hmVbcZ3GJDS+VRWJp/dKb8bweygATR7anF9EPVy2aq/0Nxh3T5u4qtuvyQM8r3z
         cTPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIcobpNxZUl0YD91nhi6LBANuV/qEqB3+Hn533hwlgSa4KfUm8cXO+RJCGnUOWP0brWi66xVEHxgpvbqZ2NcwBqu6kRdc9hXTj+Pcc
X-Gm-Message-State: AOJu0YyVel41vhAAzMcZm+FUax7etgazBJVyqFtPikXizwgSebcxLW6Q
	IsU6b7v41zc2Lb+um/Ap1SIt7Hhgg3DtHcEQyDiV03QstKKRJA0VLL4auK069HA=
X-Google-Smtp-Source: AGHT+IHsZkaJ8aFaqG2a2zjY3RR4Sd5vDyKdRVfmpduYP6Mph7JtbC4FwjhzP0o2kan4XSnp00oQJA==
X-Received: by 2002:a17:902:d38d:b0:1e5:963d:963 with SMTP id d9443c01a7336-1ef44059de3mr109780255ad.68.1715586560881;
        Mon, 13 May 2024 00:49:20 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm73396695ad.111.2024.05.13.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:49:20 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/2] perf build: Specify libtraceevent dir to rpath for asan/msan build on 64-bit
Date: Mon, 13 May 2024 15:49:08 +0800
Message-Id: <20240513074910.1660373-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for asan build issues. For detailed discussion, see:
https://lore.kernel.org/all/CAP-5=fXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2vKT-TDSOQ@mail.gmail.com/
https://lore.kernel.org/all/CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com/

Yang Jihong (2):
  perf build: Specify libtraceevent dir to rpath for asan/msan build
  perf build: Add libtraceevent lib64 to -L directory & rpath on 64-bit

 tools/perf/Makefile.config | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.25.1


