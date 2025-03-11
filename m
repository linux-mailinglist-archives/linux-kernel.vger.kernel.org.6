Return-Path: <linux-kernel+bounces-556139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD3A5C160
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19BE3A4263
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3E2571DD;
	Tue, 11 Mar 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MxRf14Iw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCC5A4D5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696619; cv=none; b=cw/jHmUjusPcCug2f1rVaaORsmmD+I0Q0V6AV1E2rOCy1jN65W+R27YPT/152cJ9i5OIB14lSSd4pBAmQHdmxtCkwQ78IKJTQo0gIxT36sXAxt7ItmTj+2IVSjYF53aImlecNLrRdp2D+Ox6FGRcFGKCpPQZpgSCYx9zcvemfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696619; c=relaxed/simple;
	bh=8xlbP+kPuJXj1ujVkaKJJ/Ff/doqow82behndxtTC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIk7o7Zrw9Dx1r5IzPbajyEM3B7QB39+UBuFuIv1uDn0S+auY/BFmHObLEAyY4wnmCJBHKrL9QSkWWk4pv5oML7pSL44RFGzEtYDAF4YTz6iSVAZXI0QQwYbxN97LOoUrE3AeGmgg/FZvC9q5yUbDRfSsEGNFPfnKif2DXPlGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MxRf14Iw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4284425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696616; x=1742301416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pokNekKuPIs26oz3GPhZwq4tj8n939iVWBrHJ6WBnec=;
        b=MxRf14Iw5+GDGa/WdDxrbcra34DUz0Vmh92YgIe7Uzt3/FE3j0sBBr+sdOaCwEg048
         0ANvq/BEOvWHJH6Gs8fTZqt2ii3T8vixyHsqV1QdxvhvoM8robZ8WH7zjKgZ0GnlZ0fB
         fK5I71HCGkaLSuRNCc7Mgtr/oaWbP2QcfD9u1hJBz0EJAHk0KGkRo1ifOHwkVCP8xYX8
         2LrXzYf99AduAIQisk3fv9rPEGVhulrVp59O8LvP07kCk8JiA4R62Sa3R7pfp94habp4
         HMO7rtRO4rohkYiP0fx28Z9kpkpJkWM8yytxBBNuHDDY5CluB9o5fH2ZxXjB9qNlTMZ+
         2THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696616; x=1742301416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pokNekKuPIs26oz3GPhZwq4tj8n939iVWBrHJ6WBnec=;
        b=MV3syIjvVVjBs91og/4mT3/C46Kfmtg84+hM1AKFLKlZXbmBQbA0k6e+ZU3FKxvmAW
         BmtJ/3ga8Rb8SnlAlUBrQpus+ELOEYu+7YUU6NFGcbivT+RyxqLMf2OP2CwDcE7WdJ0t
         zodu2Zh2vpR47yqfAPEEHWY0SJBToO6dz3+7ux01jaEQRtWhd/U4XROeCUnCkA8i/1CB
         +lgfrDw1ibnh8zMN3xSioxDki+MnkHmpy52s02evSjkoxpgikNpJrPmGYX9/8Bw0IC1s
         eRzYWLOVzEPUGe6LJeKJ4mMAz5CVfqIsTOzJo5czPeXIVBZlrhVk1FRDf6FqKEg3DCGF
         ojJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPHqzRQbbS4AfyIbYHFhpviB6odPMfg3uJKEvBrU1HurvyorEWZ3J9Wj43rTZECGJPqbnuBErAOPQO7Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qffsfoNvh+9BVuLda7POaOzegHkyjMBogWDkkr5pAD4FspnS
	rA0vXgbg/Awv2zcBl2efRg6us6AfsuHTnOV7n7DPnik4Tm8L9Qc6M5Jeg6Au4JU=
X-Gm-Gg: ASbGncsF//+boxjFEZO8eByIdnD6xQ1JJmj2viylTsUowZZvFPab2JKYEy2q86LC+FG
	9K8bVj73Xlc0mSOXRHZMEl56mERzzZTvvnN6BOMte7fGyPTgBgWzIc8fEm5Lg6yCs9KYPJL/8KK
	+/H7WtbvADlHnMjLVQbR46xCiyyCm9P7XJ74pXVmApewo8b/DiOdhwLREAG3mlJnn3zXBHcuJo3
	AF8KnPQXpE40TqKKxui/Xn4TIJ8Vs3GzrsfSpavqmub3TRRoQtLzdSGeLMNixXOWaeqBWWNNGbc
	u8A2LktiX5c53EyzN88N/IxvzOVXbdYXxjNUf3xloSdPZXg=
X-Google-Smtp-Source: AGHT+IHODza/GMf9T09SMT422tZdvwqWv0XTo4CpUj/5PPPS2WJqoiJLOke3WnMQoceqcT1Uu1Y5Xg==
X-Received: by 2002:a05:600c:4f02:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d01d25bafmr42168185e9.9.1741696615816;
        Tue, 11 Mar 2025 05:36:55 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:55 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 02/11] cgroup/cpuset-v1: Add deprecation messages to memory_spread_page and memory_spread_slab
Date: Tue, 11 Mar 2025 13:36:19 +0100
Message-ID: <20250311123640.530377-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
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
Use straight warning level for slab spreading since such a knob is
unnecessarily intertwined with slab allocator.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 9d47b20c03c4b..fea8a0cb7ae1d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
-- 
2.48.1


