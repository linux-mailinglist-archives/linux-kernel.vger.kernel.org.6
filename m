Return-Path: <linux-kernel+bounces-544746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB8A4E45F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0E7A1410
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9782836AF;
	Tue,  4 Mar 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2HYJLli"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67552283692
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102729; cv=none; b=jpxDzRN5LXtHv5vFkRKIU3DGEhfnD7FCXPQDgIobh0QhUbDRuJ0/Rvh/gJ2NQ8rpEVCS/klmQ7HHBevfz1zlt2D+rxUVAjZOrl5eig411vCde3V/s08NqRdRZnpsqlnTFLlpJgF7Fs6wYIyq1CRWS/sN/uUrLNHgKxIXFJwpRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102729; c=relaxed/simple;
	bh=j/4wLCwQln8i7pXmi4m03KiQwQyMuLnJxfUl/0RP5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJg8pvot9TmRQ+FoZ4mpsowAOHkQ38QP987aRcEK9dDX4mKiUJw1MxJZWhAKf7TFvwQtZkUsVhucBnzZiLIvZcZ/GhuCjYXQcwr6Kqk8zfLoS9XWpRgD4QL4DLpzZnzqhDJ4c2H2jE/vrMVrW9coqqPVQSkqSLp5oYRDlv+7/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2HYJLli; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so2962282f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102726; x=1741707526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=N2HYJLliJ9A/Tj6vHsUxVN93UT6Fy84xy/lYFyQ6ldK6DNjsMaczFQGZMBa5eG3til
         TxjVJcEVt109Wx4/gTU7rImxV+PeSWDaAAZPLZ8IF7lrNqPHMhwBqva0pe3wU/rfMRf0
         A0cO8qitFhDk7ArJRt0GzDrNfy+8cUP9v3HdBFeinJIn3MTFE+NMe0BFFgRVbKMb7wEb
         FxJRXU7CFz0yeLT6Xh+yKL+NCGqb2SIO5c7DIq4iKi9ckOJOjXMXuI3AJ0HEAwt8wJ0s
         tUSYJc4nUVdesSKpY99OtF7rygHU51W7uItPGvwpXKmG1aV7Wv57WtRvJ401A80GcQoF
         PVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102726; x=1741707526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFPt2CI1XVgWzStHf0nCdXSR4n5UutvMSPTp/cgKSsU=;
        b=fv4o/eu6KXpWK7j3y60RM6PIfrJ8y8eqZDeNXT9QGz283IUJbCdzJwNoVYj/quumxg
         av4WEeX0EaNZ0YNrPgXQvcNbIfGu0dKG9sypXoTjOgTidKJaMu6ZK8KE5ukIw3gHO1J8
         DuZPm/qC5tu5EjCeX6Q9vjeEYLLZqFPDEg4C1wntxUnAPA+bkRyump+1tww+89gozoOL
         4ttPOf1VD0fgOTGU0XnD3NQc/1ocVuWrs5ckroK/shbWnWX0noWw+SGSmEYWhvYStpNQ
         Y5vGemZDvzeGGQKsOeL9HHoe5Wotc98j09oXumLgI0YbbSaUuF9U2H1YF5DuHtC+6NyM
         QU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWYJ4tayYEwcG8F5By/GBXr5ff4ENyAITM4+nhZhK4Y0cqHPcQtGuzFgn644FEIURJeUDjIxI5LcxkzPyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQehu2DgeUyyyl6ffYTnNmTmcirpnN+cGOSpIAiNSHYb6O6sy
	m1YyH74ja5OjmhkuwnU3dW+jRqa6L7/qbZTZfmr0hETTDW6w1QKIMuiMTYV+BNw=
X-Gm-Gg: ASbGncs/gOhBUnVmMTXAO+dJg8drX87Ske2PTfHpm6p5cKEf8GR6UJe1lugyaXDsKo/
	wD2/bA/IkC6yq/7A9x704/oa56Qklw6Btuxna1jdKms6t9U/2gUsqJFdKPshcfij0wpYgxY4UzE
	n7/yj+MRGY29PAplN9qMzwv8Pbklp1bpHijHdfsEXVWAyw/2LaoJ0Qqa5pMmKaZXGY/x0u3kSPQ
	SF0eeykB1HAiuuU+eGDZFoQ1/AUN8FIgrWMNak8fgMAEvMlDExQ2WV0Bf8vDzCsNWjKGENyjHG9
	rZT6DUWuSUIvYv5yp6pRKbEQ/Jzpkswc4aISxmp/JjmI++0=
X-Google-Smtp-Source: AGHT+IFzh8tpm5PJ+6KB1qG+RR0gOraUB8vKw1xBf/Zc44nQ/d4j9J/DEIN5yaKw5Z2Ch0s1pQhPNw==
X-Received: by 2002:a5d:5849:0:b0:391:268:6475 with SMTP id ffacd0b85a97d-391026866f1mr5796830f8f.20.1741102725724;
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:45 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/9] cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and memory_spread_slab
Date: Tue,  4 Mar 2025 16:37:54 +0100
Message-ID: <20250304153801.597907-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is MPOL_INTERLEAVE for user explicit allocations.
Deprecate spreading of allocations that users carry out unwittingly.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 3e81ac76578c7..9aae6dabb0b56 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
-- 
2.48.1


