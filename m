Return-Path: <linux-kernel+bounces-437056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0299E8E89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A0B1611F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB294215709;
	Mon,  9 Dec 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQCpUeR3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82621507C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735885; cv=none; b=KWj5HhqeA0AlElolWgtRfpMGE5zVGuZspwSgUbqSCNn4s8l/DoYDzVvNknJGIeI4WNrX7XzcqOY0GJXKF+9Okbj0gxWgcu6agcPmyklbRKrF+oRUv4zS0/8NNG+FW6O6azzVAkNMgYTcewIrTZiIzG3gTCIzygMtzchSao5F4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735885; c=relaxed/simple;
	bh=pRZwO89URpgxNnOkotNXGV4M1y2rSUCLzB44oF5LRC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTCE2w78CvkivoqIyfzKacD/CnAV/ea7cdVVcYB+Nh2f8hY94vtFRQzjzgSvJ01+nPZEZfl5f9xcqeA3iMoOkhcAU6+dQVFMiVHf7ycgdVGc+HVe0a3qMaUnSTtpZ4U2DN5D2DgcyF1ICcO4nDQvBfC4+hOAqsleuhg+9r/AYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQCpUeR3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434f7f6179aso7160985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733735881; x=1734340681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wBAwdJ29oKofR805FVZElGCgodJqD684iSyvXfouII=;
        b=gQCpUeR3xFTm4V76DvAINm6FJ1cuBS32VtRmvxpPslMOKUHF7zQ8TtqyPuVGaOVxVn
         0qMekyK3Oj3eOfLabIq1bYqHqaqkD+OYDZZkfeHe7s4ElM8DYB0HnBn04DSpvwgEFpCk
         q6JLusMyo+1dIMlTVeOCJ5ofwvuR4lyafKGg6O2H5C201DIv7v+mPMDrKD0pp2oHi8cR
         RCAQ0v7GTddGVbdHpsHUuzo2Pn9vbuqs54SkgeF78Ena69ku4wUfLyUJ9uenDgxCIjMX
         vpwcVmI1R28SiCaLWBu10CyGaRqOP9HUcdEGZ7zqjOj53aXocWqMmnWZIDWA0U98Lczw
         VhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733735881; x=1734340681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wBAwdJ29oKofR805FVZElGCgodJqD684iSyvXfouII=;
        b=hqU+gpBGCCP98OY/CDUnG+VdmNJUBxuc5cJqQgD0pDG1u7gZpN1lZiOc4TLeOFiFUg
         psFcgdNOtf1WSO02aVvnNsA+kHtUDeEnluGjgeQa2ybeT1FdY2rhojHkTesi17KWkTZK
         wnJcZ0WfTV7PZ2CnpZeNaPcPpudJve3XOEOnFkH/JqQXNR4QhDGPhxFzBcHRP2k6n1XY
         vKDo9ZqsjSXsGgXT6GOjXxHVQCS/jlFzED42tuHS1A0KJZoYuEnhr5qQ5zNbFSFR+qs/
         mCFOt4eGJw1yh5Q4TmInoc1+0FwmSih7lji255TC8O8QMeahGalLQWOxY024XvGVB0uw
         DSAA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3fhogVw8nwrPM/ktICPIlonjrdMS5GqE47WpCjYjxA+8R8zOC3UwIZZdDconUuP0osYHOIypP1VkxKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwU70UomEoOxOsRml45Qh8Xf39b+gvBayXXJpAepQBg0wwVdW
	9s/+wT1YxLFpRwhtD+qePSDC4204R5txPBmm1qOMTCTWJ3Ogb+aV
X-Gm-Gg: ASbGncvYUqMt6FStPGIAAbbUwRWtyiNskjXP3jFKiCiGG7akwk/TIDA43U0KheRBBS7
	MiuwuhbM+qLe9vYDDV7W5r+c4HOIrygZjwCXeqO3gjPz5V8jYKcqS1j7OGdmwYokuiKywbGr3Sg
	JgFKTyqs7dfCvipIfDH6lE7OeduZNLxuAs55K6to6qxSjErs6+zGwLvyhjbpxsuCCdXsbQgKsm2
	kxeMMm6guyZhFmIcLDtzb/btqJiY0hGMlLCGk6Su/kZYMBvdqEIT954COcKrvvgXSGnW6WF2gXB
	oY5y5niUpRO6hRDtJ38Tar2ptpO6y7b5aXkWSExdzR2k/l7mVPoiwuuR/1abFSRPKXg6piz1iNr
	7bqn5c4cOHIuXU1Og2FduXebRjHF1SC3DRslnFpOzP6I=
X-Google-Smtp-Source: AGHT+IEb/Umt7kRF5RN8R8jT90v/Z87riaC2QztSPPZs6jc4W9y10iiBGuMRWsWgVsjo+OroWx0Kog==
X-Received: by 2002:a05:600c:4710:b0:431:93dd:8e77 with SMTP id 5b1f17b1804b1-434ddeddbe5mr106386965e9.31.1733735880400;
        Mon, 09 Dec 2024 01:18:00 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:bfd5:cd4d:44ef:6ffe? (2a02-8389-41cf-e200-bfd5-cd4d-44ef-6ffe.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bfd5:cd4d:44ef:6ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f5774454sm43327715e9.13.2024.12.09.01.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:17:59 -0800 (PST)
Message-ID: <3fc932cc-4b38-48fe-a692-c31e3346c9b3@gmail.com>
Date: Mon, 9 Dec 2024 10:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] drm for 6.13-rc1
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "wenst@chromium.org" <wenst@chromium.org>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "sima@ffwll.ch" <sima@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
 <Z0NXQ6iRK43x6WbG@sashalap>
 <CAPM=9tw5eTBCDn93GyrMjF3r_kDbr2-v1GgKdZECFNupqakDFw@mail.gmail.com>
 <95f01caa-0f32-4c5c-b262-435f839c81aa@gmail.com>
 <17d4fac0db55a8f9835b53d55463ed9c4331950d.camel@mediatek.com>
 <c0cbd447-42c7-4529-8455-cdde9d693423@collabora.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <c0cbd447-42c7-4529-8455-cdde9d693423@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 09:56, AngeloGioacchino Del Regno wrote:
> Il 06/12/24 09:54, CK Hu (胡俊光) ha scritto:
>> Hi, Sasha:
>>
>> On Mon, 2024-11-25 at 01:35 +0100, Javier Carrasco wrote:
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>
>>>
>>> On 24/11/2024 23:58, Dave Airlie wrote:
>>>> On Mon, 25 Nov 2024 at 02:41, Sasha Levin <sashal@kernel.org> wrote:
>>>>>
>>>>> On Thu, Nov 21, 2024 at 10:25:45AM +1000, Dave Airlie wrote:
>>>>>> Hi Linus,
>>>>>>
>>>>>> This is the main drm pull request for 6.13.
>>>>>>
>>>>>> I've done a test merge into your tree, there were two conflicts both
>>>>>> of which seem easy enough to resolve for you.
>>>>>>
>>>>>> There's a lot of rework, the panic helper support is being added to
>>>>>> more drivers, v3d gets support for HW superpages, scheduler
>>>>>> documentation, drm client and video aperture reworks, some new
>>>>>> MAINTAINERS added, amdgpu has the usual lots of IP refactors, Intel
>>>>>> has some Pantherlake enablement and xe is getting some SRIOV bits,
>>>>>> but
>>>>>> just lots of stuff everywhere.
>>>>>>
>>>>>> Let me know if there are any issues,
>>>>>
>>>>> Hey Dave,
>>>>>
>>>>> After the PR was merged, I've started seeing boot failures reported by
>>>>> KernelCI:
>>>>
>>>> I'll add the mediatek names I see who touched anything in the area
>>>> recently.
>>>>
>>>> Dave.
>>>>>
>>>>> [    4.395400] mediatek-drm mediatek-drm.5.auto: bound
>>>>> 1c014000.merge (ops 0xffffd35fd12975f8)
>>>>> [    4.396155] mediatek-drm mediatek-drm.5.auto: bound 1c000000.ovl
>>>>> (ops 0xffffd35fd12977b8)
>>>>> [    4.411951] mediatek-drm mediatek-drm.5.auto: bound
>>>>> 1c002000.rdma (ops 0xffffd35fd12989c0)
>>>>> [    4.536837] mediatek-drm mediatek-drm.5.auto: bound
>>>>> 1c004000.ccorr (ops 0xffffd35fd1296cf0)
>>>>> [    4.545181] mediatek-drm mediatek-drm.5.auto: bound 1c005000.aal
>>>>> (ops 0xffffd35fd1296a80)
>>>>> [    4.553344] mediatek-drm mediatek-drm.5.auto: bound
>>>>> 1c006000.gamma (ops 0xffffd35fd12972b0)
>>>>> [    4.561680] mediatek-drm mediatek-drm.5.auto: bound
>>>>> 1c014000.merge (ops 0xffffd35fd12975f8)
>>>>> [    4.570025] ------------[ cut here ]------------
>>>>> [    4.574630] refcount_t: underflow; use-after-free.
>>>>> [    4.579416] WARNING: CPU: 6 PID: 81 at lib/refcount.c:28
>>>>> refcount_warn_saturate+0xf4/0x148
>>>>> [    4.587670] Modules linked in:
>>>>> [    4.590714] CPU: 6 UID: 0 PID: 81 Comm: kworker/u32:3 Tainted:
>>>>> G        W          6.12.0 #1 cab58e2e59020ebd4be8ada89a65f465a316c742
>>>>> [    4.602695] Tainted: [W]=WARN
>>>>> [    4.605649] Hardware name: Acer Tomato (rev2) board (DT)
>>>>> [    4.610947] Workqueue: events_unbound deferred_probe_work_func
>>>>> [    4.616768] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -
>>>>> SSBS BTYPE=--)
>>>>> [    4.623715] pc : refcount_warn_saturate+0xf4/0x148
>>>>> [    4.628493] lr : refcount_warn_saturate+0xf4/0x148
>>>>> [    4.633270] sp : ffff8000807639c0
>>>>> [    4.636571] x29: ffff8000807639c0 x28: ffff34ff4116c640 x27:
>>>>> ffff34ff4368e080
>>>>> [    4.643693] x26: ffffd35fd1299ac8 x25: ffff34ff46c8c410 x24:
>>>>> 0000000000000000
>>>>> [    4.650814] x23: ffff34ff4368e080 x22: 00000000fffffdfb x21:
>>>>> 0000000000000002
>>>>> [    4.657934] x20: ffff34ff470c6000 x19: ffff34ff410c7c10 x18:
>>>>> 0000000000000006
>>>>> [    4.665055] x17: 666678302073706f x16: 2820656772656d2e x15:
>>>>> ffff800080763440
>>>>> [    4.672176] x14: 0000000000000000 x13: 2e656572662d7265 x12:
>>>>> ffffd35fd2ed14f0
>>>>> [    4.679297] x11: 0000000000000001 x10: 0000000000000001 x9 :
>>>>> ffffd35fd0342150
>>>>> [    4.686418] x8 : c0000000ffffdfff x7 : ffffd35fd2e21450 x6 :
>>>>> 00000000000affa8
>>>>> [    4.693539] x5 : ffffd35fd2ed1498 x4 : 0000000000000000 x3 :
>>>>> 0000000000000000
>>>>> [    4.700660] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
>>>>> ffff34ff40932580
>>>>> [    4.707781] Call trace:
>>>>> [    4.710216]  refcount_warn_saturate+0xf4/0x148 (P)
>>>>> [    4.714993]  refcount_warn_saturate+0xf4/0x148 (L)
>>>>> [    4.719772]  kobject_put+0x110/0x118
>>>>> [    4.723335]  put_device+0x1c/0x38
>>>>> [    4.726638]  mtk_drm_bind+0x294/0x5c0
>>>>> [    4.730289]  try_to_bring_up_aggregate_device+0x16c/0x1e0
>>>>> [    4.735673]  __component_add+0xbc/0x1c0
>>>>> [    4.739495]  component_add+0x1c/0x30
>>>>> [    4.743058]  mtk_disp_rdma_probe+0x140/0x210
>>>>> [    4.747314]  platform_probe+0x70/0xd0
>>>>> [    4.750964]  really_probe+0xc4/0x2a8
>>>>> [    4.754527]  __driver_probe_device+0x80/0x140
>>>>> [    4.758870]  driver_probe_device+0x44/0x120
>>>>> [    4.763040]  __device_attach_driver+0xc0/0x108
>>>>> [    4.767470]  bus_for_each_drv+0x8c/0xf0
>>>>> [    4.771294]  __device_attach+0xa4/0x198
>>>>> [    4.775117]  device_initial_probe+0x1c/0x30
>>>>> [    4.779286]  bus_probe_device+0xb4/0xc0
>>>>> [    4.783109]  deferred_probe_work_func+0xb0/0x100
>>>>> [    4.787714]  process_one_work+0x18c/0x420
>>>>> [    4.791712]  worker_thread+0x30c/0x418
>>>>> [    4.795449]  kthread+0x128/0x138
>>>>> [    4.798665]  ret_from_fork+0x10/0x20
>>>>> [    4.802229] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> I don't think that I'll be able to bisect further as I don't have the
>>>>> relevant hardware available.
>>>>>
>>>>> -- 
>>>>> Thanks,
>>>>> Sasha
>>>
>>>
>>> Hello, I am one of those who touched something in the area.
>>>
>>> To check if my changes are the cause of the boot failures, please apply
>>> this patch:
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> index 9a8ef8558da9..85be035a209a 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> @@ -373,11 +373,12 @@ static bool mtk_drm_get_all_drm_priv(struct device
>>> *dev)
>>>          struct mtk_drm_private *temp_drm_priv;
>>>          struct device_node *phandle = dev->parent->of_node;
>>>          const struct of_device_id *of_id;
>>> +       struct device_node *node;
>>>          struct device *drm_dev;
>>>          unsigned int cnt = 0;
>>>          int i, j;
>>>
>>> -       for_each_child_of_node_scoped(phandle->parent, node) {
>>> +       for_each_child_of_node(phandle->parent, node) {
>>>                  struct platform_device *pdev;
>>>
>>>                  of_id = of_match_node(mtk_drm_of_ids, node);
>>>
>>
>> Does Javier's patch fix the problem?
>>
> 
> CK, to resolve the issue, please revert commit
> 
> fd620fc25d88 ("drm/mediatek: Switch to for_each_child_of_node_scoped()")
> 
> Thanks,
> Angelo
> 

Hi Angelo, thanks for your feedback.

Are you sure that only reverting that resolves the issue? There is a
previous patch:

f708e8b4cfd1 ("drm/mediatek: Fix child node refcount handling in early
exit")

That adds the "missing" call to of_node_put(node), and the one you
mentioned switches to the _scoped() approach. I would expect the call to
of_node_put(node) to be the actual cause of the issue, and not the
scoped loop. In that case, both patches would have to be reverted (that
is what the patch above, only for testing purposes, manually does).

I still wonder why the child node is required after the loop when it is
not referenced, though. But as I said before, that is a minor concern in
comparison.

Thanks and best regards,
Javier Carrasco


