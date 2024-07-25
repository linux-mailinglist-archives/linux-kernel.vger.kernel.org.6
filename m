Return-Path: <linux-kernel+bounces-262079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32AB93C087
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F2B2113E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F11991B4;
	Thu, 25 Jul 2024 11:03:59 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73103176233
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905438; cv=none; b=fu8NYLcJTwhGoB2gpFQjxlPLjJT3tb+W+KKUfpagh2imR/xLG1NXoOkeSdq8wfXlLk3le1FGGkAZfM/4yD/kAbUTbPYHKbRMUbWNFqI6qAp7KL2MRUoOQ/3l4XjPzZ5otnIMIwP0SU16c0azctsscMUULYHir7aUIvQW5CkFLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905438; c=relaxed/simple;
	bh=uTEzl1DGTtt5PC7rNqFp3gSJItEkihIT3JivE6CRMMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPKS++GFh67DvL9OXfwoIYTVif1mFZalMDIflq15oixRcC9l/eCZO4Yfq16AQQ6l/sDuq0rXEdNcLfwirIAYNVgY2lh9jbw1SqHuGfejUM29zIPgOIsSzQgI//y0/CWca+QVeCwvMF3n6CyCnTWokLYJvP3tldhOPGoOcYkNQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.185])
	by sina.com (10.185.250.21) with ESMTP
	id 66A2307E00007549; Thu, 25 Jul 2024 19:01:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5484873408034
X-SMAIL-UIID: 45E6E71375B7484FB64D4B461277FD71-20240725-190122-1
From: Hillf Danton <hdanton@sina.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	tj@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Thu, 25 Jul 2024 19:01:11 +0800
Message-Id: <20240725110111.2063-1-hdanton@sina.com>
In-Reply-To: <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 09:48:36 +0800 Chen Ridong <chenridong@huawei.com>
>
> did you mean to say this issue couldn't happen?
>
1) It is deadlock if watchdog work can not complete before any cgroup work.
2) It is not if you could not trigger it with no more than a dozen cgroup works.

Not important, boy, spin with deadlock erased.

