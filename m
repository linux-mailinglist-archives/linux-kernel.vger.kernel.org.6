Return-Path: <linux-kernel+bounces-257112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8CE93755C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9741C217B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E537C6CE;
	Fri, 19 Jul 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pOHE3kAd"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A675EE8D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379085; cv=none; b=ryDDPty/NExdc/P2wqMttvKn5FseL/KiYGwaIBrVmNHa+zbcl2fEUJQ2YxoCViHMBE3jVv7KFbXd3koOmxsM/KX/aP0G+7M2Iuuj8hDTP6l23fVhUEGjJUy2CW3SXlhqnYQPoIXZBYFbB1+9mj4WC/piSrnNHKeWpgKFP+IwOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379085; c=relaxed/simple;
	bh=wmwGEx6qtEeitpWxaVBw9lChs2TcfHKub3HOlnJa1/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIOBPswCVNKCYgtOzcT/ugMMCJd/BcS2TopAfSgkn0HDTf5erbElFZaYYEuspLAZNrMjVH8Xt21cRy92e6PpyEB6McI1KQEj+FAckWxMJhczTbRUeXKmkGdMg+qteimzQ9jB5cioHuxeWW94E26Y0ZlaoblIrEy5efhrCjp5sxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pOHE3kAd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uyRnP
	kOlL+K67i9INrMaahcKB0i6SvDn1QwInydhxG8=; b=pOHE3kAdS53c17AU3E1sc
	Vfo0CEuo2SMGba865U+x92XcX8ADovsUhXyDjr+ZoHgi3A05WsVZoF+gNM5Y/M0W
	WiUi+SqVWv4Gk53vpg3HzJRiq3dmVfyKYB6QE2z6HjsZhC+4Br0vsWV5g/EGWovD
	PvDiqCNNBddit8v9ivhFRM=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD33xrnKJpm4hB2Dg--.41463S2;
	Fri, 19 Jul 2024 16:50:48 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP 
Date: Fri, 19 Jul 2024 16:49:52 +0800
Message-Id: <20240719084953.8050-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <716c2c20-9471-4a37-9a75-c1bed7b30116@suse.de>
References: <716c2c20-9471-4a37-9a75-c1bed7b30116@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33xrnKJpm4hB2Dg--.41463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43KFyUXFyDGw1fuw1Dtrb_yoW8AF1rpF
	WfAayxKrs7trWrA3sIkw47Jr4Yyw17tr93WF1kXr17Awn0vFyfZw10ya4YkFZ3GFn2qr4j
	yF98X3sru3Z0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuOJrUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQAAsR

> On 7/19/24 10:07, Ping Gan wrote:
>>> On 7/19/24 07:31, Christoph Hellwig wrote:
>>>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>> high
>>>>> workload on the system(eg: kubernetes), the competition between
>>>>> the
>>>>> bounded kworker and other workload is very radical. To decrease
>>>>> the
>>>>> resource race of OS among them, this patchset will enable
>>>>> unbounded
>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>> get some performance improvement. And this patchset bases on
>>>>> previous
>>>>> discussion from below session.
>>>>
>>>> So why aren't we using unbound workqueues by default?  Who makea
>>>> the
>>>> policy decision and how does anyone know which one to chose?
>>>>
>>> I'd be happy to switch to unbound workqueues per default.
>>> It actually might be a left over from the various workqueue changes;
>>> at one point 'unbound' meant that effectively only one CPU was used
>>> for the workqueue, and you had to remove the 'unbound' parameter to
>>> have the workqueue run on all CPUs. That has since changed, so I
>>> guess
>>> switching to unbound per default is the better option here.
>> 
>> I don't fully understand what you said 'by default'. Did you mean we
>> should just remove 'unbounded' parameter and create workqueue by
>> WQ_UNBOUND flag or besides that, we should also add other parameter
>> to switch 'unbounded' workqueue  to 'bounded' workqueue?
>> 
> The former. Just remove the 'unbounded' parameter and always us
> 'WQ_UNBOUND' flag when creating workqueues.

Okay, will do in next version

Thanks,
Ping



