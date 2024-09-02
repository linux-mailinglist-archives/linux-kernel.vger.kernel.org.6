Return-Path: <linux-kernel+bounces-311533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91713968A27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EA281F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1913E8A5;
	Mon,  2 Sep 2024 14:40:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DEE1A2651
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288056; cv=none; b=EkC50mVMZx3IGs2coOH0GFmhDv8GHbWQunpA7OGn0W+nS+g6V6Y6v2BowQLKXyFnlmBbbCp5jvzijzFqRQE1/my6ZDbipzd+aRZFWab2M8oacUDglgBICblfScPzHRkVjarH1xEaBCXf9Gecp0lKAiXNZu9XSv19wRIZtNa1M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288056; c=relaxed/simple;
	bh=pvT7FcHnPJTUPRlCpzi2ba0+kynIsj5aOBmiVVY5sG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQZcDe3pS4nGXCcoOBnJJZe5CPdpm45F6cLQKAaUcZIXx1GEkU/CU+pIa/p6GOZ/m/sQON+DDsuD7IMGghaIVt0e9fXRmDq7wNUauzcUySAVCxF1M8HA5SWqp3th5KwICdFaGJEJesXNZd48O96Zk3dOm0wf9Y/FztWrUAORJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WyBHz5F0Qz2DbhF;
	Mon,  2 Sep 2024 22:40:31 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id AED9C140360;
	Mon,  2 Sep 2024 22:40:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 22:40:49 +0800
From: yangyun <yangyun50@huawei.com>
To: <mszeredi@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <spasswolf@web.de>, <yangyun50@huawei.com>
Subject: Re: commit 5fb9c98e9d8d causes deadlock 
Date: Mon, 2 Sep 2024 22:39:46 +0800
Message-ID: <20240902143946.585814-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAOssrKfDfUBt8YBqo3-Wivm1gHhv6B-6jZA2ifgDXooKf8oYFw@mail.gmail.com>
References: <CAOssrKfDfUBt8YBqo3-Wivm1gHhv6B-6jZA2ifgDXooKf8oYFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100024.china.huawei.com (7.221.188.41)

On Mon, Sep 02, 2024 at 04:03:42PM +0200, Miklos Szeredi wrote:
> On Mon, Sep 2, 2024 at 3:40 PM Bert Karwatzki <spasswolf@web.de> wrote:
> >
> > Since linux next-20240902 starting debian sid on my MSI Alpha 15 Laptop hangs
> > before the GUI is enabled. After rebooting into a working kernel (v6.11-rc6)
> > the following messages can be found in /var/log/kern.log:
> 
> Thanks for the report.  I reverted the no-forget patches from fuse.git#for-next.
> 
> I know what the bug is (spin_lock instead of splin_unlock in the
> nlookup helpers), but this was clearly not tested (partially my fault)
> and not well reviewed (my fault completely), so this was just hurried
> through without proper QC.

I am so sorry for this. It's all my faults. Not tested and checked carefully in the end and submitted hurrily. This gives me a serious warning. Sorry again.

> 
> Thanks,
> Miklos
> 

