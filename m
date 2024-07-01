Return-Path: <linux-kernel+bounces-235753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7F91D944
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A74D1C21943
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC278C63;
	Mon,  1 Jul 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VStLEhU1"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5D376E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819875; cv=none; b=VteGotgchG5hneXKl/zHqzQu+bn6wa5eeqOiCw1x2yRKM0/yRSsyBVoMzBNfgGdds01OA2yHccYp69NGbDpwXZh29lMp/I7hR8c2T53BKM6vO7K2St4k+rMpT2zRc3hpzVrI95p0N+JZlO9h/b1T6K7u/5KdFHP8FghZd4f/k3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819875; c=relaxed/simple;
	bh=tN7l8i682+OKNUhtIAMz0gv17+/bm1AJ56D0MW52aUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H10LLdfmjptDPTxawzK09heecgQlix7x2JFHaTes+b9khIeSIK/4cYQbfqeYPx46xMqeY4snRN5hY173dhw+mh6VnCiz+lU31d1A9O8fvJAsTT7P0XkjdHfaZDVAulF7MsB+hX8N5P+rvx8JM7QAudPAMLLi3ATmboSWW2Q11T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VStLEhU1; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=x8gIqUvIEyIvWrLcnvnN8RgcwBPeQB4VF3UFpzQZusY=; b=VStLEhU1ASWq2
	aiANfD5IZ3x66VWPwssGK0z6W7kfR/Z5WoQG8BK/SI11dVEZ0Jc3HvbL0XH+cskW
	c2YxKiCrMv8/ScdHGZ6lfzF6Yv45TWuHq3p0SL/Te/FGBQw7X70FvPHN8Q08Donj
	ZjlB0X1bIS+yC26gz12FRr9MLT6JGs=
Received: from localhost.localdomain (unknown [223.104.212.168])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3v3UpXoJmVPDIAw--.64400S2;
	Mon, 01 Jul 2024 15:43:39 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Mon,  1 Jul 2024 15:42:44 +0800
Message-Id: <20240701074245.73348-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v3UpXoJmVPDIAw--.64400S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7JFWfWFWkWr45trykAFb_yoW8KF4xpF
	WfJrZIkrs7urWrAw4vvayIgFya93say3y5Jw1fJ3y8t3yYvry2vr40gFyrWFsrCrnY9r1q
	vFWDZ3Zru3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4a0dUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBYOKWXAmBtWegADsw

>Hey Ping Gan,
>
>
>On 26/06/2024 11:28, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use kworker to handle IO. But if there is other high workload
>> in the system(eg: on kubernetes), the competition between the
>> kworker and other workload is very radical. And since the kworker
>> is scheduled by OS randomly, it's difficult to control OS resource
>> and also tune the performance. If target support to use delicated
>> polling task to handle IO, it's useful to control OS resource and
>> gain good performance. So it makes sense to add polling task in
>> rdma-rdma and rdma-tcp modules.
>
>This is NOT the way to go here.
>
>Both rdma and tcp are driven from workqueue context, which are bound 
>workqueues.
>
>So there are two ways to go here:
>1. Add generic port cpuset and use that to direct traffic to the 
>appropriate set of cores
>(i.e. select an appropriate comp_vector for rdma and add an appropriate 
>steering rule
>for tcp).
>2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users
>to 
>control
>these UNBOUND workqueues cpumask via sysfs.
>
>(2) will not control interrupts to steer to other workloads cpus, but 
>the handlers may
>run on a set of dedicated cpus.
>
>(1) is a better solution, but harder to implement.
>
>You also should look into nvmet-fc as well (and nvmet-loop for that
>matter).

hi Sagi Grimberg,
Thanks for your reply, actually we had tried the first advice you
suggested, but we found the performance was poor when using spdk 
as initiator. You know this patch is not only resolving OS resource
competition issue, but also the perf issue. We have analyzed if we
still use workqueue(kworker) as target when initiator is polling 
driver(eg: spdk), then workqueue/kworker target is the bottleneck 
since every nvmf request may have a wait latency from queuing on 
workqueue to begin processing, and the latency can be traced by wqlat 
of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py). 
We think the latency is a disaster for the polling driver data plane,
right? So we think adding a polling task mode on nvmet side to handle
IO does really make sense; what's your opinion about this? And you
mentioned we should also look into nvmet-fc, I agree with you.
However currently we have no nvmf-fc's testbed; if we get the testbed,
will do that. 


Thanks,
Ping




