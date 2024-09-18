Return-Path: <linux-kernel+bounces-332347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344F97B8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3013B23936
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B9170A27;
	Wed, 18 Sep 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OinEsvUR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF5482EF
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645540; cv=none; b=hA9nMNIIlL2+hpGkDw8AtXGfU1tJE/dYtOsMUulQj8Tbj/mvS07H/eDm6AM2loGxEdinioPpDxuqAlD+DMxN6tGHYMeU24MXa5AIzlCaL/3I0jPQee3dVYVCzk8qfHTmN4xiOlygSl6mAhghB/0pAL0h5eHHWmuUzJ1Q0wY4RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645540; c=relaxed/simple;
	bh=8cbZTCDd4mL+ru6kg5Gf3qUptfO0w/oF9SJAxiqHGio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1upr7RNPFSQW2fNRyd5ExgIoP3zBGnFIgv6b3hbmyeD7hst/rktZQSakp8t7ZoHL5AlnIHMrV1PStKDzGX7/l31cw0h/ES9ZEDBQTTBuO46wE47k9JWimt7DWKhhYqn5sUDvt5enhZDO5ur4NbFR2ibq3w/nCxzfwdmH5M5ONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OinEsvUR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20688fbaeafso58552335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726645538; x=1727250338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+I7dUgrSuHMQdwaXopkdXCgHbnd+bfTOM+bzbwYhISo=;
        b=OinEsvUR0ZuftFGWF7ydpG/DYZM77aYld2BTT/0RyB3Goa7YtZNqlBV4S/VC6n6TIP
         +YBfao6n/EFRllA4w6LGNEgGjafW+EZXDyJQ9qBdY4laL5tvw05GfJSHtrYGx2Cb5nxu
         FEeKerguC46ur/RGfwQ2Jh8hywu1QHpGdicbX4Khxu2gwtnyaranvRuW6l61dcvhpbU+
         nABMOHBEQ6DjCyYLbOskA7rDSftrXSi8//lCCfujxpg6M+9y4Dj5LbRAkAlkCuVS4u8V
         EW/nXW0o7uijBmI7Tgf31GdHFIkOq67Kb1aAKczX6qAuRDZapzIEgvP1DzgJ6shXgnhx
         N6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645538; x=1727250338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+I7dUgrSuHMQdwaXopkdXCgHbnd+bfTOM+bzbwYhISo=;
        b=waHyM8k77Ko1Biixhly7aY69OYRAyyW61yQB+GUgme2qIO1hoZI0QLCcJBZMBzW8rq
         qx2zP9azvSPF4h3LyakRNNCl454lMoL2hCzfnpySkHa+7tb9dKL13KcuM8Or0FEafFvw
         bUn/yk5qTAqQiC1cZ8c/479lpYHjskeaOCK+ON0mwsXaKhwMzOuxwM1sSav63G61LUDh
         Fyy3MixSHa35tAtq5jxV+Kzed7qSaNzsMUzNriP2EJFKzi8+DhzXXPVYgpP28hXdgaZj
         wSgUpsKJlzNjAyTg0Z3kjMjBmibVk+ImGBZ8FY63fDqWwdVVRJ3T43RLwuLkJdDPL6sN
         X96w==
X-Forwarded-Encrypted: i=1; AJvYcCWUZLcaOZakRf2q4EpaTTW1flsHcApy1AqOej57+BugF4JsMMNHnVZYUMt83K4de08Siv90WSIAUVFLPyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPnQY0/4BzHR+WXx4MUS/080iO6ZWqk7pEs3BhOjoXpiKUToU
	YcxVBl7BQ5RE0FnroV/DYPK7pNbK3O1E/5qWjXfq28Eg0lTZMs7JJm2n9FEeLKk=
X-Google-Smtp-Source: AGHT+IFpSIeGa39ByCsIFwY+HDxOIoRC8C0L3buusq68sEAHO+OkhE4RObZ1rPjsBZYe0iYf4cPzmQ==
X-Received: by 2002:a17:902:ec85:b0:205:82d5:2368 with SMTP id d9443c01a7336-20782b7c5f3mr358418875ad.49.1726645537888;
        Wed, 18 Sep 2024 00:45:37 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794747379sm60412995ad.288.2024.09.18.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:45:37 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	geliang@kernel.org,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 0/2] Cgroup skb add helper to get net_cls's classid
Date: Wed, 18 Sep 2024 15:45:13 +0800
Message-Id: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

0001: Cgroup skb add bpf_skb_cgroup_classid_proto.
0002: Add a testcase for it.

Feng Zhou (2):
  bpf: cg_skb add get classid helper
  bpf, selftests: Add test case for cgroup skb to get net_cls classid
    helpers

Changelog:
v1->v2: Addressed comments from Martin KaFai Lau
- Just bpf_skb_cgroup_classid_proto.
- Add a testcase.
Details in here:
https://lore.kernel.org/lkml/20240814095038.64523-1-zhoufeng.zf@bytedance.com/T/

 net/core/filter.c                             |  4 +
 .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
 .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
 3 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_skb_get_classid.c

-- 
2.30.2


