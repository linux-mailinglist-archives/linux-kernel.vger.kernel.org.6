Return-Path: <linux-kernel+bounces-220340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF590DFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E516D1F24992
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C689181CE9;
	Tue, 18 Jun 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQH4RDlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71857155351
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753773; cv=none; b=Ix4aOZxDvlABicvAc0Qf4PFWCaH3t9GHdxLXkg19Wi4JeqQQkZeOx4Ad8a+D4taTdqp+E6UuvytxyJeuAfP0zbp9XygQiro9riE/7S4tiskk+B2ICo+EYVn1tZGHgOWAsarex7gfRTGfwdOf9+FyIoElfOCEHtVoig3UoC3KaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753773; c=relaxed/simple;
	bh=Ntqy76VFybkGcS9dAO++B//yYbRA0qUGQrrC/6+6gXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS1x8r2Ln+x8PP2F/sJCEUiZ2UziGiQcdXgiC5J+B3ujWjylPH3JhCrJjrI5Z/zVOADEc5l/sDsSk4n+BoHQ6vEii6zc+6vIO4o+NfURTpr7qm6FA0MV8/XPtSk7KFo5+7cl7I0N6oWiyn/rQY6Ken0E4PlRqK3Z/Rm2y8Ez7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQH4RDlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D19C3277B;
	Tue, 18 Jun 2024 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718753772;
	bh=Ntqy76VFybkGcS9dAO++B//yYbRA0qUGQrrC/6+6gXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQH4RDlPa1PpVeiadkbxPDo+1Z8m5w5DDmDB254oqKyMk0Z+JCzcQKTn7elqcm7A2
	 n0I3xmucAWfB/zZL9EXz2GNDqW6p8rrH8ubnNJiqlWklcsUi17W2iJStzcdt7TV3qQ
	 DEQTTsDjT/wvW806+UhvV+PG3oG5/42nZ5hzecxa1sbWPq2YXeygqBrxM9+4fVWSjT
	 EgJworij9+ebI/JFcHtjQBmKA4I7EB1txR2MFfYiYGGjKuTrAkJ5k6NuLjeRRS7dTo
	 G0lLgaMN3vr5eiXmiLhKAX6vuVj5xrqsGOHILQbpIdQgDrFpzMHD0fFamsIIzwrcXX
	 ag8lTBLz+o2nQ==
From: SeongJae Park <sj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm/hugetlb_cgroup: register lockdep key for cftype
Date: Tue, 18 Jun 2024 16:36:08 -0700
Message-Id: <20240618233608.400367-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618071922.2127289-1-xiujianfeng@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiu,


On Tue, 18 Jun 2024 07:19:22 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
> trigger a bug,
> 
> mount -t cgroup2 none /sys/fs/cgroup
> cd /sys/fs/cgroup
> echo "+hugetlb" > cgroup.subtree_control

[...]
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 2b899c4ae968..4ff238ba1250 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>  			cft->file_offset = MEMFILE_OFFSET0(offset) +
>  					   MEMFILE_FIELD_SIZE(offset) * idx;
>  		}
> +
> +		lockdep_register_key(&cft->lockdep_key);
>  	}
>  }

I found the latest mm-unstable tree fails build as below, and 'git bisect'
points this patch.

    linux/mm/hugetlb_cgroup.c: In function ‘hugetlb_cgroup_cfttypes_init’:
    linux/mm/hugetlb_cgroup.c:840:42: error: ‘struct cftype’ has no member named ‘lockdep_key’
      840 |                 lockdep_register_key(&cft->lockdep_key);
          |                                          ^~

Maybe we should take care of CONFIG_DEBUG_LOCK_ALLOC undefined case, like
below?


diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index a45065698419..9747c2e64e95 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -837,7 +837,9 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
                                           MEMFILE_FIELD_SIZE(offset) * idx;
                }

+#ifdef CONFIG_DEBUG_LOCK_ALLOC
                lockdep_register_key(&cft->lockdep_key);
+#endif
        }
 }

[...]


Thanks,
SJ

