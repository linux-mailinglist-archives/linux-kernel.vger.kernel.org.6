Return-Path: <linux-kernel+bounces-285487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63F950E19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3AA1C23161
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE43B192;
	Tue, 13 Aug 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6VWNOfY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA160B96
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582075; cv=none; b=YBoROzT9U89rbfMeAaXR1TSLF+deKuQqbAB1yy5iPlFeHqSGsnZ1ih7Z31g7V9znddFoL0hU4mrbvjIv4r+tEd90hR/f6vTLBXB08l12vTfEI+nCDN5/gG/1BPutQPGUB4UhTuXPC1fU8bwDLPi0YyeliKaPO849C21tpXtW8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582075; c=relaxed/simple;
	bh=x8+0SHcDmVGIqKZHn79dfKmGygZtA2zzr59rfOJVeY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PqY3D+oKfGHcamvDkZI3TNWS5vDEPdGM9iWRCfZT7YfER9sUIGglerK3ILDyrKYMZf1nDyaZqAOjegOB8i0YQz7fT4bxlQe/HPVZqv8Zd2wQga29CaVRiFWoMd8/oHghclcXCoW0dLsbRtY+A2vZJrAfSzitOYJBotrQ9rMBBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6VWNOfY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650b621f4cdso127722447b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582073; x=1724186873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VTAXcSzg2nJxUF/QOoTMCzcY75N5+KjH45iaTDlnBg=;
        b=j6VWNOfYgpptKR0mePrlKzNq4RsmgwAa0iDL8zfyx9k0cFtydGL4fy40hsDzaw0nwm
         /a1XRfpHgLGWHId0TZEyoFLL1XYrdbmf6WrKdI+Rqx2PGGOq4DnQLmtGsfdaO8qAqHtb
         T47A1jB49KPMltSCbjr7M10KyWmovOtYg4Yrj98GFjk6MbJJAe/tMJfTnhcjnbthEjqn
         KmhmbV0VwS1B5wWq37uMz7sdd0gIR4PGGdeDdIotb0zlzKE6M97gVR9FQ7FvKlRkrMyX
         paYPHZ/ASwJDEr7shIHL1dNmqbHmCeJ8tUeHN+A+VTh9TE+Kxx7/kZ2k8JWIsVaBXly5
         YB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582073; x=1724186873;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VTAXcSzg2nJxUF/QOoTMCzcY75N5+KjH45iaTDlnBg=;
        b=CeEvZihokkxR/LtUx0zENr/pPraqf5NJpXZCLzu9OInjK00EbbYbfmWcQV8lMBpHrB
         0+3PoQBIfJvPwwZjYfVLh+xEC3pLh4tU/CTjt4VFq90QrcIsarOlzlL50vFIDElHQ/pv
         Ju2n2ONlfeBSBAaOFpZElsPgDtNjU5O5ZsSEJWK8kYWww7/rmSXvEMpBjfr8udT2RvyB
         KHMsllPj7do3rQ0Lzzb0YoEatnhwOZsqzRNuMmIsDeomom+vk27HxvKgTytlTGRhBgWq
         C9Vv09xPbkDhzUG00kyXyjBN4DWtiwiwEJlz3cFp5C5rlb2AyYDkCoxOITlPu7qeloAv
         vg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfl/HQwDkn3j40cggNCEQVcgjn1RnBN0S6R86RDqV5knhZnTXgdynoycDv+2KdCdYvpE8P05BD9shuPSYoLRKQM9shkVFGGQfoXrZs
X-Gm-Message-State: AOJu0YyNj5LwTADsBWCCLpCUlfYA7uBeOqpFZV3WGqtydUIjQ2Smr6GA
	TQBeyLEfQsmeI5RoET5iIJZoTuDe2jsxk2R1boVLDVUqWI/XgUVQxM0k6WNWiMGxxipciXBjZYa
	oyVcKMSzgSA==
X-Google-Smtp-Source: AGHT+IFzblsx6HVwSONVyuq1qq/U8tF5umc8wK7YjkPphN9wlYyR7AcobNhp+giR2cU9kqZsxLwEY6K/rtnFFQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a0d:d385:0:b0:673:b39a:92ea with SMTP id
 00721157ae682-6ac997f8a9cmr286847b3.7.1723582072721; Tue, 13 Aug 2024
 13:47:52 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 0/5] Improve mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Incremental cgroup iteration is being used again [1]. This patchset
improves the reliability of mem_cgroup_iter(). It also improves
simplicity and code readability.

[1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/
--

v2: add patch to clarify css sibling linkage is RCU protected. The
kernel build bot RCU sparse error from v1 has been ignored.
v1: https://lore.kernel.org/20240724190214.1108049-1-kinseyho@google.com/

Kinsey Ho (5):
  cgroup: clarify css sibling linkage is protected by cgroup_mutex or
    RCU
  mm: don't hold css->refcnt during traversal
  mm: increment gen # before restarting traversal
  mm: restart if multiple traversals raced
  mm: clean up mem_cgroup_iter()

 include/linux/cgroup-defs.h |  6 ++-
 include/linux/memcontrol.h  |  6 +--
 kernel/cgroup/cgroup.c      | 16 +++----
 mm/memcontrol.c             | 84 +++++++++++++++----------------------
 4 files changed, 51 insertions(+), 61 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


