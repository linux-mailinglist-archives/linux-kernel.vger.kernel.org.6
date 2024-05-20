Return-Path: <linux-kernel+bounces-184304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1BB8CA518
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF88B21ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32324AEC8;
	Mon, 20 May 2024 23:36:20 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [88.198.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAA3611A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248180; cv=none; b=lLQ+Xtq0MW9BAmUT64SsMs9ZQJGyJVlJ+Rm88RZeuPEvq4B2bL2HJf7n2/OsAdEns80DgNH5v6exo6vYaSqA7QkXAsk0VojBe0I1BVDKV1gfUVfb7QI6sPY2KknFnDjsNWzIxGSLXY4E2XSjf7WusVr6NiR1bsLXbaBdWbHApgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248180; c=relaxed/simple;
	bh=uucoN9rdGS26EbUDT/h+eCdiNgARYYTm7CKjrTSB84A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QlsRjEHN9ncC+mzsrOnOjuN5H8g1pj+B0Q+AKf9btrjox2oTewHEcZCkVZhVIlRaAPMTypa3b2FkSl00pI5xBYMjFkhM+3DXiD+/PHFDGjtabUWbZ59mWqzh1jCtCm7zHMWNOJsTshVLp33uO848O67qWcI75uZUv/MdC+ode1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=88.198.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 4F7C0587FE733; Tue, 21 May 2024 01:26:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 4CAAE60D19DFE;
	Tue, 21 May 2024 01:26:28 +0200 (CEST)
Date: Tue, 21 May 2024 01:26:28 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Tejun Heo <tj@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Craig Small <csmall@enc.com.au>, Yafang Shao <laoar.shao@gmail.com>, 
    linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
In-Reply-To: <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
Message-ID: <8r004s1r-06r2-1pq1-4s29-6177np23q0rq@vanv.qr>
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com> <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tuesday 2024-05-21 00:30, Tejun Heo wrote:

>Currently, worker ID formatting is open coded in create_worker(),
>init_rescuer() and worker_thread() (for %WORKER_DIE case). The formatted ID
>is saved into task->comm and wq_worker_comm() uses it as the base name to
>append extra information to when generating the name to be shown as.
>
>However, TASK_COMM_LEN is only 16 leading to badly truncated names for
>rescuers. For example, the rescuer for the inet_frag_wq workqueue becomes:
>
>  $ ps -ef | grep '[k]worker/R-inet'
>  root         483       2  0 Apr26 ?        00:00:00 [kworker/R-inet_]
>[...]

This patch works satisfactorily for me.


Tested-by: Jan Engelhardt <jengelh@inai.de>

