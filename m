Return-Path: <linux-kernel+bounces-257073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209279374C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57E62823FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5015F873;
	Fri, 19 Jul 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m75v15wA"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310254765
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376533; cv=none; b=Aswp5RY2nzRjYHJdVRS9hZMuLE87m+tIua13zfsDs4xAPZXHTmNiStvs+ACscDr7W3s7e3Box85dA1dh5glS6rfaLo7aBUrnb48G6oK+KCHJLpdX75r2KLN5QWMYcHA8T/co4gDMrhkQ9SaFT4hguVrPJCTbXdwau10ORTaVW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376533; c=relaxed/simple;
	bh=v2XbweZJDCiW05CC4PVeVzum2gpaDdQ6FCAVXpF5Res=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXXBsEY7pLwXasmcVrrm2cm9PyOEMZTXGQFii79FzfB63FqOaAt05qGxt8Ob3jT4jDvh8j3y3dZf5lY+eNlx+VtDR0kSHwrc4deSADwG6d2LQnMrEW/NqLVUz+zIemgzI3FhDaWHLSedwGobo+8hLFux4Y+/uJ7k2vK+T/abB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m75v15wA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dxy69
	Vkbak9zsjGVTjGLdoPayVPvBj27QHGHH4yqIAU=; b=m75v15wAYR27WLxFk3//Y
	C5Nyp24WEXnXsO33g4Xz+7hvN2GgWGxWobt2mAhQUu6kSmucKZk3rccjTh6nHGo3
	z4yB1ZSIbUCK3DWx2liPJVbGicnysFcji1yaufpOcwgdvCfxBp4hb0sveMkE4rz4
	6axFSx326AEIg+SejvoSwk=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3PyDvHppmvJLJCQ--.60815S2;
	Fri, 19 Jul 2024 16:08:16 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP 
Date: Fri, 19 Jul 2024 16:07:22 +0800
Message-Id: <20240719080723.125046-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
References: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PyDvHppmvJLJCQ--.60815S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8Ww1rZr4furW5Jw4DCFg_yoW8Xr47pr
	WfAa18Krs7JrW8A3sxCw47Jr4rCw1IvF93W3WkXr12yw45uF9xZw18Ka4YkFWfGF92qw4j
	yF98X34DCan0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuc_hUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBMhKWXAmWEXHAAAsF

> On 7/19/24 07:31, Christoph Hellwig wrote:
>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will enable unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on
>>> previous
>>> discussion from below session.
>> 
>> So why aren't we using unbound workqueues by default?  Who makea the
>> policy decision and how does anyone know which one to chose?
>> 
> I'd be happy to switch to unbound workqueues per default.
> It actually might be a left over from the various workqueue changes;
> at one point 'unbound' meant that effectively only one CPU was used
> for the workqueue, and you had to remove the 'unbound' parameter to
> have the workqueue run on all CPUs. That has since changed, so I guess
> switching to unbound per default is the better option here.

I don't fully understand what you said 'by default'. Did you mean we 
should just remove 'unbounded' parameter and create workqueue by 
WQ_UNBOUND flag or besides that, we should also add other parameter 
to switch 'unbounded' workqueue  to 'bounded' workqueue?

Thanks,
Ping



