Return-Path: <linux-kernel+bounces-236588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1E91E45F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC93C1F24E30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9F16D304;
	Mon,  1 Jul 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baE+4n2m"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994053AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848554; cv=none; b=l+ihkd6FVdznsRr3o/ttcKPW94r68I4neEFG1u1H53HEfgx06xo7MgSudWJyKglFYL18jgvZkQu9oEi71eGEjNcZThmnCChSq2zMAPjDlV6UhNdRpQer4pQqzXdNAlJW8UnRDeDaELih/lqFmKZR21ruDFztO8JeMOtX9I89gK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848554; c=relaxed/simple;
	bh=QQewevtGQ3yWMkgwpxK9/fUyTSs394KE0gqEa+aQ/Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUjgmBb29MqE5MJihg5Y+FiJZRNlZJbKLihyCBBQMFsyuHJYwBtn/HY8IgO+UwHeTNSHLxxeyMX33rCcOfRFYwH10Pp+wkGptWcMj1EmvpIxzUeMLh44qvUvGsgigRSOqgEvWQTi4voNy4drS802EcGLkCNx+Po21RxxBd3BH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baE+4n2m; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2c9357a2647so1466787a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719848552; x=1720453352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQewevtGQ3yWMkgwpxK9/fUyTSs394KE0gqEa+aQ/Ko=;
        b=baE+4n2mGnu40GZepTVxL/rdEEWNUwMkgNA79EaI0PzmtmJlSPyJD/qcyncLBJXBGu
         tFxj3lJBRJTPKRH+4ZJLRzrugH5I7O3fZGwrmVQixBIxvPBDUTdc/el5s9PK4Bo0nEqj
         BI8PXdxOMUDlMRyp5V8YESGZ0fl7ETZmZ2ppdRtIaofQdeTq8B4fIqMFl8rRRmANtUjB
         NFYsZiGpsk1bSwwd7vQLi/VhH69k3uJ1de9W1vVLJe6Sy2or0FOAQe0Uadmn7nZQ7oZy
         XX9wG+wTGvN8JESKWD9eDzd8rDvYHSKUlw1bA8FGWYHJK9Czb+hUMXPZr5siQOJwljpg
         Wb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848552; x=1720453352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQewevtGQ3yWMkgwpxK9/fUyTSs394KE0gqEa+aQ/Ko=;
        b=If+eqeOb0VnitvgD7XU+id023pbHE5L+mCxQF/Uqz2/bZRs89yIchiFC6HIE+HGOIO
         1kZ3ZjTLIyYduKoKz29qkBYOg4DLk32aVHnK93tqX3E4sd4WJFY4SGSfrWADMq/ahtHE
         8bYR7otNFQIXwb9d7VlOnEOWsqDZONaUrv9MbqsW8lXcwirs/wnoL2unalb0Mz0gQJJU
         OxCtzeWENpugSs2R5mRbhPT1Pp4PkaIljZ/mC0uwLfUzOkc3Gq/Jkg42AeYGFrSMEGu5
         7uYucOBlsSj0I/VW2GgmdUfeZVB45iJF8Brtr08Uqhlp54yWx8smtbSgfv0bbfJKrbSH
         1FHw==
X-Forwarded-Encrypted: i=1; AJvYcCVpzupNmvB6MR4AnY9uEJJPcxalisJzdYs83BTwAMST1qGBsLCj5km6l+o70xo3JMER1QG0+6/ezm442u4ZSSsCiU+NcWvgII2lTiPr
X-Gm-Message-State: AOJu0YyVMghOCRkBP2ttsnSaw4EtClvUxX1fy0brr4TXxwu5wwzzjhls
	Gw43cBBMef2qLS2vKagRbgrPWQ5Jt7Wv7PbNcyadiaf8DdYotvsy
X-Google-Smtp-Source: AGHT+IFCPCx0k14WVdBvLs29h6nUsTmgwXbyMg22CfeMNJbPXjBv3Dn2DAWpMHENoi8UZf4nCwJsWg==
X-Received: by 2002:a17:90b:3ece:b0:2c8:64a:5f77 with SMTP id 98e67ed59e1d1-2c93d76a045mr2970706a91.37.1719848552421;
        Mon, 01 Jul 2024 08:42:32 -0700 (PDT)
Received: from localhost.localdomain ([39.144.194.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce7414esm6944906a91.34.2024.07.01.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:42:31 -0700 (PDT)
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
Subject: ask for commit hash
Date: Mon,  1 Jul 2024 23:42:20 +0800
Message-Id: <20240701154220.22493-1-luzhixing12345@gmail.com>
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

Hi, I'm trying to apply these patches in linux kernel v5.15 but meet some conflicts,
could you please tell me which commit hash did you start?

Thanks,
Lu, Zhixing

