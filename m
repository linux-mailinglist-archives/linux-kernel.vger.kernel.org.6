Return-Path: <linux-kernel+bounces-214327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C29082CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA01284B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF721143726;
	Fri, 14 Jun 2024 04:00:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9738B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337637; cv=none; b=Io8uMpqbM818j5WLpJdWyZhJPTibJ9KLchPFnpGoQgEGiP1xHI8Tf8wQ/LoanC3rIAUu5kr0a+SROKIWVN7SWnPkpFutXaiSRc5iMzBYlB0gVC+0cvxv4hXqn2QztO4vgjfmDu+0dl4LNwHnYSECnvpis0T83z31wCn37Ccek04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337637; c=relaxed/simple;
	bh=YD/hzsHGKMaPc9AEbzcC6z/zcPMYzbpxMvd818N27SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBPNg7fWsLy6u5Jill9bg98hLUxSacI9OS/duN02qWxH1I44BTtSRj5XmRDBdzPrASd95GZQwXrYiNYhvdqV0rs6/7O/vWh3wJSNOPIQWYFjZGzuYVWk4G1zSHr1n6OS8dZw9QKm4Kv0Nc76s3sEIiW+PnU5m6TueNhuZQyo5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45E40WLc079668;
	Fri, 14 Jun 2024 13:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 14 Jun 2024 13:00:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45E40WRc079665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Jun 2024 13:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <522c0b17-c515-475d-8224-637ca0eaf6a2@I-love.SAKURA.ne.jp>
Date: Fri, 14 Jun 2024 13:00:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net/sched] Question: Locks for clearing ERR_PTR() value from
 idrinfo->action_idr ?
To: Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
 <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/14 11:47, Pedro Tammela wrote:
> On 13/06/2024 21:58, Tetsuo Handa wrote:
>>
>> Is there a possibility that tcf_idr_check_alloc() is called without holding
>> rtnl_mutex?
> 
> There is, but not in the code path of this reproducer.
> 
>> If yes, adding a sleep before "goto again;" would help. But if no,
>> is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?
> 
> The reproducer is sending a new action message with 2 actions.
> Actions are committed to the idr after processing in order to make them visible
> together and after any errors are caught.
> 
> The bug happens when the actions in the message refer to the same index. Since
> the first processing succeeds, adding -EBUSY to the index, the second processing,
> which references the same index, will loop forever.
> 
> After the change to rely on RCU for this check, instead of the idr lock, the hangs
> became more noticeable to syzbot since now it's hanging a system-wide lock.

Thank you for explanation. Then, what type of sleep do we want?

schedule_timeout_uninteruptible(1)
(based on an assumption that conflict will be solved shortly) ?

wait_event()/wake_up_all() using one global waitqueue
(based on an assumption that conflict is rare) ?

wait_event()/wake_up_all() using per struct tcf_idrinfo waitqueue
(based on an assumption that conflict might not be rare) ?


