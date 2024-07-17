Return-Path: <linux-kernel+bounces-254575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E729334DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91506283788
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B86FB6;
	Wed, 17 Jul 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TEq9CJB5"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D045661
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177701; cv=none; b=fN4cz6FUX59ntsvDh7iOJquXRhnCmk/XLBHVsyU2HypQ+zec+MFbqLsqNcT5VGhwIvcBW/9xZeyEv/7cM7uysePpr/nNuxWaI/gKhJH0ra++VfasJ80EIW5NuLjObGcgTQw8nioZDopahiI0M2pPmm/IvWWnpMFAM436vAa+7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177701; c=relaxed/simple;
	bh=ZKwq7LcRRZUvYPzTy3HqmC7u8/eRuHUR0dKL26uLKwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWjEdbRlWAyJ1+TwHbxu0hmOkDlLHeDrjZ8wG6SI2kqdmAZERRFcFFxivSbFHwkwfxBqHGwHT4CMto+eDC/GPmgzfG63qiu4RySmP9/zdTZYQvF9D60aMb8mTCAGW80tBFUhhUSFSGgLV0anQEoQCPh5WaFImMYd4r5+bkakHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TEq9CJB5; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t5/Ee
	HzpNabXc5RVd46C/7TAlz4/G8RSGiM4PhgH1hs=; b=TEq9CJB5fJj2t7fvUc32R
	HEhIeVy08Ot9HIC4g1MWp2IFRlAN+MutULMrOON5qyEylJMT2RuyDSvzBpyWvfEz
	yklcpK3/Gp1gN3ry1XI6lYRt6uTlUCKgaWv1BhtJ1UEwH1ytdtIy45z0Vzy3b6U3
	tljzXsmcuqkGfLG2lE/Yn8=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3X502FpdmwwpwBw--.43354S2;
	Wed, 17 Jul 2024 08:54:15 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Wed, 17 Jul 2024 08:53:17 +0800
Message-Id: <20240717005318.109027-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
References: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X502FpdmwwpwBw--.43354S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw1ruw4UZF48GrWxZF18Zrb_yoW8Jr15pF
	yfJF1vyan7Kr1Fy3ZFkw42qF4Utw4rAFWqgF97trWrJr1Y9ry2y34xtF1rWFykGr4fWr1j
	yayDX3yDua1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6uWJUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwAAsl

> On 7/4/24 10:10, Ping Gan wrote:
>>> On 02/07/2024 13:02, Ping Gan wrote:
>
>>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>>> improvement.
>>>
>>> I think you will see similar performance with unbound workqueue and
>>> rps.
>> 
>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>> unbound
>> workqueue, and in same prerequisites of above to run test, and
>> compared
>> the result of unbound workqueue and polling mode task. And I got a
>> good
>> performance for unbound workqueue. For unbound workqueue TCP we got
>> 3850M/node, it's almost equal to polling task. And also tested
>> nvmet-rdma we get 5100M/node for unbound workqueue RDMA versus 5600M
>> for
>> polling task, seems the diff is very small. Anyway, your advice is
>> good.
>> Do you think we should submit the unbound workqueue patches for
>> nvmet-tcp
>> and nvmet-rdma to upstream nvmet?
>
> Please do. I have been using pretty much the same patch during
> development of my nvme-tcp scalability patchset, and using WQ_UNBOUND
> definitely improves the situation here.

Thanks for your confirm! Okay, will do that.

Regards,
Ping



