Return-Path: <linux-kernel+bounces-412624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373A9D0B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BD21F211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB53188906;
	Mon, 18 Nov 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4P415IGC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BA17C224
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921818; cv=none; b=ahY876fdAE1Vv5BkqwakXauNX6MdemPThH01EmAJF4i0thnkvDd8lnZD5NMLHXzueYbokwI68ezJ9JBNGZLgwgYH41Hvk7vo5e0AhAOHtIABTbKu5zwOX4fCc/EzR3ZLdv5BWadO+uE89dgJv0dCTOSv7IIKGIPfXtyqQDnv6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921818; c=relaxed/simple;
	bh=W9AwjAqhhy4+cY2WxYv12Yf84KCg6vSVJhSP4jirKe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ew85rq6om1L6phwJjkXoyyyIIIFcf17W/6AmycItLGFZyYjQS4NmkgklLT/o35qVibxtktZlnkWveh6ZkZKn6/obkKmc0imfs+EXL+Nh5ib5pQC0g1Vr/ATzHeKjqOwVrzqjzfZIQ5Yq0BWS2RaVRotuDcm3GvaYHD4rHL1sWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4P415IGC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso34497295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731921815; x=1732526615; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0WCXW20r9F4Yc3BjAdp9aLtMAOi2W5sVlPv1lj5qmY=;
        b=4P415IGCwrmZe6AGAI8kZ+jEBWfM5X1KQrDgwsG/aUCLPnZLOhnpuGE8IIsxiGJ9vX
         Q4yoNCCI6+R8WL+XamnTtqWgp84ol8d+M+vBrbi3ml1Uh3gP3uzPa+FFQ5e78Dwy+FkU
         RtJgdFYaFdkQTe/wEYrlgI+85Tu+Uto88Bz0D4LnESx5je7gFDZ6WZidze5bI0ATBAma
         cudJtkKLuGtjCgUVZm3jAfWvZpknlvA+eHXVYkypTTrRcAGqTTvQEOqicEf4FD30Scnv
         lvGNZus4koGGrGGbGwY7KwzA6KlkT8vc+atiDIkUy8zUXXp5Rx9FC6vA8tqu85fALit9
         UTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921815; x=1732526615;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0WCXW20r9F4Yc3BjAdp9aLtMAOi2W5sVlPv1lj5qmY=;
        b=sQdUPUauvvcLu2NJydmTU86iVoD8R88S7+jjigYF1ASy+HX+cxtxAUhAazEEJSnr/B
         EdHMRqechb/ubWO1IcNjIiJHTsdVUQSPdrOZdgq7nFOas2rErxhXMJpRIglCUK7cdg4S
         lIndcNoXv9yLLmbx0TLw5A6JyAwLJBAkgfcBSnTVrZkVCjSoA7zaDG836BAxb+MSAqUe
         kFtyzBKvvtBiIFLXXuPgCuLMGqRjbDJzsd/ffAowOr39sMQiTVUryYDMW7BnU0RmbXeY
         wKa5RbxeqeyFmQs945MBd5ZLHBNHqM72vVz0JARUock3+7MKswqmb2fvnQnrnxv1FSP5
         vzNA==
X-Forwarded-Encrypted: i=1; AJvYcCUR6mw/Y0edA+CHxNtvlIIeEMQsq0sP2obr7ChQXG3dDVl3Tll/OASFO1nd/oy2CiDCU2cA8oPF0x4Wgk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSyy1slX8T0jj/s9ejcM3ejj08KO/HAujIYS7PI5d5OWlwh01
	fzwelXWBY4cvCGAbINOz7s+KlfWXopSitg+tLTUZiSrD9Aj2mepjLBBW+DCOR+PDF64LMkrOO/S
	0TncY
X-Google-Smtp-Source: AGHT+IGc1fI2IJEDKEFJkmZPq/WUqT3ksxESS9UNMu46a0bIOaX9MaBpfhyk5pY3B69TEH1hgH8uVw==
X-Received: by 2002:a05:600c:46c3:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-432df7906e3mr103909215e9.30.1731921815158;
        Mon, 18 Nov 2024 01:23:35 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:7c0:adae:af6a:2c2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38246b7db13sm2752243f8f.91.2024.11.18.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:23:34 -0800 (PST)
Date: Mon, 18 Nov 2024 10:23:28 +0100
From: Marco Elver <elver@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] KCSAN updates for v6.13
Message-ID: <ZzsHkNopkQpY2nwy@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Linus,

Please pull the below KCSAN updates for v6.13.

Many thanks,
-- Marco

------ >8 ------

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20241112-v6.13-rc1

for you to fetch changes up to b86f7c9fad06b960f3ac5594cb3838a7eaeb1892:

  kcsan: Remove redundant call of kallsyms_lookup_name() (2024-10-14 16:44:56 +0200)

----------------------------------------------------------------
Kernel Concurrency Sanitizer (KCSAN) updates for v6.13

- Fixes to make KCSAN compatible with PREEMPT_RT

- Minor cleanups

All changes have been in linux-next for the past 4 weeks.

----------------------------------------------------------------
Marco Elver (1):
      kcsan: Turn report_filterlist_lock into a raw_spinlock

Ran Xiaokai (1):
      kcsan: Remove redundant call of kallsyms_lookup_name()

 kernel/kcsan/debugfs.c | 77 ++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

