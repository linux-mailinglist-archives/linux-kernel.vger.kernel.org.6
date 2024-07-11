Return-Path: <linux-kernel+bounces-249266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5D92E910
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FCEB2343F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE115FCEA;
	Thu, 11 Jul 2024 13:10:36 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D724F20E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703436; cv=none; b=E2usLRFTK0KoV4uad359+cCBrGtCgPNKlIiqc2AKXctilZaJKcre7iIWMCGa0z7BOlFOKTYhWbTxNvzUksb/fNzcCBnj8rpwMJZUlpH52zVnt89toZjdtSYiRLNV8lkMgXHK35ZosWoLCuQjhCQkXAh6BWZMr7wwWgejOBXdZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703436; c=relaxed/simple;
	bh=FPi/Q8AixRGzY5Ck5rAZA1UmHvBRkpSOuR9C9caZF3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=VY+RczQtZrX7kjjpGVFQogosXpCffALIB9T9DILDzVSizDTBBb88D4Buy9vO2PvitBmbE0EsEbWmUituY8sXH/Fk2Ef+ku/PaS3TS9kghiKzKTRJHyanUk+9sH7TWx3h7Atuy/FJlbxHM3L3t6b9aBTje4QecYCR85+Kqv1NWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WKZj53JYGzwX1f
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:05:45 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F2D9180ADB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:10:29 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 21:10:29 +0800
Message-ID: <d4edde3f-0047-2ade-0b65-d59dbeb6fca6@huawei.com>
Date: Thu, 11 Jul 2024 21:10:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tick/broadcast-hrtimer: Prevent the timer device on
 broadcast duty CPU from being disabled
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
References: <20231218025844.55675-1-liaoyu15@huawei.com> <87y1cek0av.ffs@tglx>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liwei
 (GF)" <liwei391@huawei.com>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <87y1cek0av.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Hi Thomas,

Sorry it took so long to reply.

On 2024/1/25 3:18, Thomas Gleixner wrote:
>> +	if (tick_check_broadcast_expired() && expires >= next_event)
>> +		tick_program_event(next_event, 1);
> 
> I'm not really enthused about another conditional here and that
> condition is more than obscure.
> 
> The problem is that the local clockevent might be shut down, right?
> 
> So checking for that state is the right thing to do and the proper place
> is in hotplug_cpu__broadcast_tick_pull(), no?

We can't check the clockevent state, because when exiting broadcast mode the
state is switched to oneshot, but the clockevent is still shutdown, due to
some device (e.g. arm arch timers) do not implement set_state_oneshot handler,
the switch operation only change the state value.

Yeah, hotplug_cpu__broadcast_tick_pull() is the proper place to do the check.
Thank you for your advice, I have modified it and sent you the v2 patch.

Best regards,
Yu


