Return-Path: <linux-kernel+bounces-440927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D39EC68B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE571188BC68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0ED1D5CEA;
	Wed, 11 Dec 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K58g9CZi"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8D1D54E9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904361; cv=none; b=bBKBgctvXKvLz9oFEsEYQ4mkzPn+ecTYzVYej6uHVioBlkQYi3DxFIKJtYZ6LLMVK5U01+7R7T4NZ26Ve/LYps4Qcd+CePs7Fo9wLZt+bbh09OXlA68I3Zayy9b4VABw6FjF0AKbK3dHd0CmlztAJMymJWCHKH8CN0C4A5C9k6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904361; c=relaxed/simple;
	bh=jjOsWQQAeL8r1aLiM8/yVXFmRTkFUM62IuJcagxG9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ1NzFPfi9Hsx0AX8wGts9Li4IOMl7vge94hqqJqt2AQA7a9TnDEj4XJawUlpRVHlHUKD/xY7fbyOeSoOhbpHV5Ci07usHn+Iki9jfTYetBlGNaSfJ/dJ1CIy/DpJWiQ4zV/iHzSQtXbG66GnXPygGYLlbxA412xzaidzrKE9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K58g9CZi; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0+zlv+dz8/ILwFQY9HbDj+1FCxZ7PSQHGfjsZXTgsyA=; b=K58g9CZi4hIP+KGa7s68el7dg+
	AlLtaFAL9uGtWn86FIm+rmJ+vwgK1tY88A7tKiPtKeEL6ACQBQnqwhFbktirzrkPEVPQwX5nwTJZw
	GVeAvUugUHV07Brc87OpFtqI2M2xqx3AyNMYRphO3tpmTVy20sVQ+2gyXxhMxxcL2/snHHKSuGi71
	8B0yIjmYRcTCYfDQSjxLYzDxb4yD9gXwtChtgKnS+0db+ccseUBVz9jiBBG2118eWMdnWjxutos/1
	76SBQ9vguPBk/HM+LbsTLbSW1/vO47ub5aDzA1a+B8+qxt0YACifwmf5yOqB8ErC3I7WasdG9ie00
	OzYcJE8Q==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tLHj5-001rwl-Fm; Wed, 11 Dec 2024 09:05:43 +0100
Message-ID: <f6cdf7d9-b11a-4b6b-9d30-35afb50a55f1@igalia.com>
Date: Wed, 11 Dec 2024 17:05:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched_ext: Get rid of the scx_selcpu_topo_numa logic
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-3-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241209104632.718085-3-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrea,

On 24. 12. 9. 19:40, Andrea Righi wrote:
>   /*
> @@ -3519,9 +3476,8 @@ static void update_selcpu_topology(void)
>    * 4. Pick a CPU within the same NUMA node, if enabled:
>    *   - choose a CPU from the same NUMA node to reduce memory access latency.
>    *
> - * Step 3 and 4 are performed only if the system has, respectively, multiple
> - * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
> - * scx_selcpu_topo_numa).
> + * Step 3 is performed only if the system has multiple LLC domains that are not
> + * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
>    *
>    * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
>    * we never call ops.select_cpu() for them, see select_task_rq().
> @@ -3530,7 +3486,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   			      u64 wake_flags, bool *found)


Adding Step 5 to the comment describing how it works if there is no idle 
CPU within a NUMA node would be nice. For example,

   5. Pick any idle CPU usable by the task.

Regards,
Changwoo Min

