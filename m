Return-Path: <linux-kernel+bounces-262789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F068793CCC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C55DB22261
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B71B947;
	Fri, 26 Jul 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T41v94BM"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B51B86C4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961352; cv=none; b=tsSryczeJnLfZQZFPrWayHQIPv4lADmTLlqmBWNnfA5cC4rm7lDu2Pp5QXZHKQ+XgsNw30aM1ymDEEJ1aS/Zbs3rGig6zF8PUEJ9JZXsG3PPl3+OysKEsG3C4FKZd3lMWheaUfpqCR5Nilyzy4La7rTsxHw6oD3Z1hGxx4tQGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961352; c=relaxed/simple;
	bh=mVwTv/PU0FgZvKqjq9zEotYBoxvJYrG02XMlZ0LCiSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjAL8FUcCFfio1ozK2tEEwR9anAnf6SN4f5o4uuEyUKVj4ff1gjM0qeN3RAMx9bYYYXfzzI1bZESBdLfbN3aYWZHYRuPcmdeDNyQWkwq8JMHNBmCmlgWNwTjwJ8wYph10SNqXO5x0sp7l71wZvti+Lx6TDpuJNwR0LS2DSf49jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T41v94BM; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eZ9r6
	niTYNrCxK8B6XBW+XzVZwCXO5bwC8vmdFJG53g=; b=T41v94BMIzIpbf9lSZSce
	dTmrafWcn5nFy4+56SptlcRE+b6OD4Ai8iGHXSFSo3ss//aVkX5I1/MRs7OVftgH
	rfHpTiboGMm29wcANcbO3ou7zR2hwXuPR9DjCWI3spvmOOd8urU33wg1BwRN2BJS
	O8XTpPmioYtfAvNQthlz7A=
Received: from localhost.localdomain (unknown [139.226.176.233])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD338RWC6NmhrIhAQ--.16234S2;
	Fri, 26 Jul 2024 10:35:03 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Fri, 26 Jul 2024 10:34:06 +0800
Message-Id: <20240726023407.70799-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
References: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338RWC6NmhrIhAQ--.16234S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4rJF18try8WF15GF18AFb_yoWkCrg_u3
	9Fgws7Ga1xuF4Dta1xKFyrZF1xtFW5JrW5Aa18KF4xKry5ZF13GF4vkr9a9as7Gayktrn8
	uw13Zw1vk3sFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR8u45UUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBMmKWXAmcpbkgACsp

> On 19/07/2024 12:19, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will switch to
>> unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
>>
>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>
> Hold your horses.
>
> This cannot be just switched without a thorough testing and actual 
> justification/proof of
> a benefit beyond just a narrow use-case brought initially by Ping Gan.
>
> If the ask is to universally use an unbound workqueue, please provide 
> detailed
> benchmarking convincing us that this makes sense.

So you think we should not do a radical change for the narrow usecase
but
keep the parameter to enable it in previous version patch, right?

Thanks,
Ping



