Return-Path: <linux-kernel+bounces-236565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12591E416
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6B6283A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73E216D317;
	Mon,  1 Jul 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFuyiac7"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12A16CD1D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847707; cv=none; b=upFCSGxDBVcT+HhePxTw+QsdnFPATSkKJF/zmfusjlYT5hM1QNJ07ZSjBwqRjk+zwXf7R8tlOb7uV0lwTWZm3/DTwaDNMGh4pFimvtcPDbkldBRvn2aZmzxJXTMdbt+z3SA68qiyx4WmZ4c972DA1ZAuU8fqnRcXgwRWCTTl1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847707; c=relaxed/simple;
	bh=2WewFR0Y6Iu2bcPCVFDNmYojcNZnY6itjEZSRjBnzWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OinZK0loAqae5JIRPE/TtUkZBdYMeFwWWaEKQJA7ah7HJKu3976q8dHcw8UEy5v8MRcw+MnvOteYTKhxgvLYTKi4XjR52dW1Vk3lViZq/DacIhYg9SwLh2K/e4xe2kyKQdavPScNuLgkXgxuB2g0e8usn1JFp590XtfRY5gBxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFuyiac7; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2c7ecfc9e22so1868172a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847705; x=1720452505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WewFR0Y6Iu2bcPCVFDNmYojcNZnY6itjEZSRjBnzWo=;
        b=eFuyiac7wEKX+9SilURNOBkauR+8KJpj0M9hcqy0FmLvjovJMjjfgj+5I15TGGlGSx
         Os5rIB/nkCbLQTYTx4zNuT9McUoZF/me8YSrLVjzeAchRbNWHEi5D7iZMH0yN25FGFdr
         eowMDfWTlL7kwJsJNZT6SjyF9DpWZkGck/Kta8jt0NDEspPuWQsUGBCEiO9tjUpogd00
         Ovuh0z4ya24sgQH2xo5eY0w8WHOf6P0kDvAnEnsbnweIvmihpok+kctc91dWPDl1HUVx
         dnbHfxtEou8J/9MkNKh6gmmhgMxZUFwNXiq1HAJWJHlKzYtM7X7b0xLN/D/yOH5KiG3s
         6JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847705; x=1720452505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WewFR0Y6Iu2bcPCVFDNmYojcNZnY6itjEZSRjBnzWo=;
        b=bsZmPo7Pt9PpOjbKOQOMJC/sty+UHKazDTX4CmWV6KjcZYf3eLCNGNqQNJowfn8+LM
         Q+Bors/EWxajb1o2g3Wn7mYxGT38TGSkIPuvlmD5aP4j/quvjL97w1XjVlQ5cGxCQPB6
         Ynm2dIpVOmZKgF/LeHmnhG0Lomp/lqbknXEe2Km9PBA+lA+c4hYJ7cCi3scOJLyEOakX
         iw26vgloLEnndM4TjNWfSDna0hSa1LmYV5hDKJ9j1HlJwdCwaeF7nrcaf3EkuNPjdLsa
         FvVkX31dQb51KyWJuR0U0Dj6zQ97ZeWTxYJ0HhXbHtvr0l9RHgQLjV8Oun8mgNwMXWcW
         cSfA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Rcie+AVa3O95/ehq+NdF5xT//UPvNTAzfVZ+1d4rFzYkOTD2GIVcD4jXxIDKGF6ewkO/lkAH6d/9yWJpT6FIHkkh46KEQ/mAxfnl
X-Gm-Message-State: AOJu0Yz9y9QOnAghgm2JR+FwpaI91nky7OhOChUCCjiL8KPJvCpjrJeY
	+d9RQY9M043+ayA8L+8SP2qC3RcUGylPV/q4hPbyzoxgh8591HjP
X-Google-Smtp-Source: AGHT+IEhMBsWJz4AA1BER3YQr9RPvpHjMxCGLD1Uz7xwquP+7xEZ3HnX9oQYVpNA3uqGF5uqVQXuAA==
X-Received: by 2002:a17:90b:f84:b0:2c2:e45b:ecd with SMTP id 98e67ed59e1d1-2c93d70b2d4mr2947871a91.12.1719847705239;
        Mon, 01 Jul 2024 08:28:25 -0700 (PDT)
Received: from localhost.localdomain ([39.144.194.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce6e7easm6925232a91.25.2024.07.01.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:28:24 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: hasan3050@gmail.com
Cc: dave.hansen@linux.intel.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mgorman@techsingularity.net,
	riel@surriel.com,
	yang.shi@linux.alibaba.com,
	ying.huang@intel.com
Subject: Re: Transparent Page Placement for Tiered-Memory
Date: Mon,  1 Jul 2024 23:28:13 +0800
Message-Id: <20240701152813.19528-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211130044922.42995-1-hasanalmaruf@fb.com>
References: <20211130044922.42995-1-hasanalmaruf@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks,
Lu, Zhixing

