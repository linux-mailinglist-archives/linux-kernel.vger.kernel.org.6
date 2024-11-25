Return-Path: <linux-kernel+bounces-420359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8E9D7958
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C882D281569
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E017D2;
	Mon, 25 Nov 2024 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3gixCUi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB60621
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494917; cv=none; b=T2p63fW4vzpRra+FJuIBFVYs3zI5VNUt3Jom/4RkiaYuizapD27oA4/lkY2/7bR9Q0q8hlE2XnIYmwHEBcOjiwi4c2MYvxYsK1+LA4zdv1Y2yebYtymlev1m6hbksBG75p/fu3LWT23q0CckqcuW69QaVl5sEYSyHBDsquobn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494917; c=relaxed/simple;
	bh=AYLzJM2ht9W0fY5+PESqc9rSE+pDetWAJQ7yrfK00V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMVkmgw4AkQ7NVqbq83HdUXuXMJ1BpAQP+ZyejR0ocJYGSdrosIwK3UKmAc5OmhWiE/7Ath6+BDYDonpA3uY1muCT2XfzKQ6AlESgICg2XK5yXQOqvZMVdXHT48Piz0SLRa6Tc1CinICzDIOTonBa8aew4ee4J0zvG7mUs8KfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3gixCUi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316cce103dso49820045e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732494913; x=1733099713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w42A29b+XcFII3HA5dynXRABPrSSK75R4qT/dcM9LX8=;
        b=j3gixCUiRZYube5ziu9JR0pwmySzo0QmjaFILwDe1yCIS6q+m3EsIfnVtE7j17+k1B
         34N7HEgfd1C6xHvMXCvBefC5mgh1b+E7fYQVWeZgAtP96TG+tP1aCh+8EhmXp3k3FGBI
         LQkK/zgFQj8kyp1tWl0igznvqe1uwqKJBzlMf2SVHn/HGuVdb1JYWnlEO4nYVtDaG7Wo
         ZPMDyS8Jo3eHF8/Ik53tQSQ8fWZ2yoW+6ZIH19yXsiYHBJpywvHcZ/qc0q6OGtC6MG9t
         S7Qwz9r6nc1Mny5d+19txuXk0WpXVqdqzh8fcF38QC6xh8pvWIVwBM92OdPaYEhTHmwh
         u9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732494913; x=1733099713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w42A29b+XcFII3HA5dynXRABPrSSK75R4qT/dcM9LX8=;
        b=aeNff6RBgGPutGKWVUmEVWae20IXVSNtLnnu9IRjC7pLRFY5QO7kakmU1Db/u3dGuw
         iO7P31rF8paFmKSs257G5mKS+uffeivlkic85kTMPmeluYrsbJeFG/iJlE9vkyvNOVjG
         K745TVAmEmlMDvEGuLvqCsmk7SYPCndoaTS0WDcTdr25u5umTusYLxPp32o+A8wL8xN8
         v6BMajGOWozEaXGFJZjUgnHSNTX/jwZtXqlWMltpbWDFdMe2Hd9GI0qHIelRRvTQnBh2
         sWwZqWpg9DRC2f9NBDcErWjqF9xikSci0/l/nGJM/RWam3VgYqfpNwXyeutLIkjhhFai
         DjcA==
X-Forwarded-Encrypted: i=1; AJvYcCX7WwlR8asH+rJ9dwiV1Ib/22e6jAGZ/Lz9RiiN4reIjAGZSAZbdKjckIO5GvETsZA+GUV3mYwgcNqQGMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSrZp5FQzsy/DqB4R1ZB528BWtscUxJb3oa/WgI1OouX+yt30
	g8dXJlY33dpFRgSj9D/mRnP/6pAI6bG8qgi8NLrDUnXSZWo4u/JR
X-Gm-Gg: ASbGncuNINqSe/FN/Cr/h8V7HJOuEesfoL+MnsIY3zmVWV+uysZvQ5PKQHlU7ZQNMNm
	zVu5YZvXLqimAR+sG8NTXVzhuyivsyedJkjaggyQZRSdozpMx3vrMm4j2GxqUL2P+YyodgTqYM1
	LqcBZGBqhtwBVKNZn0wq53BevmTT8bkiI2Q43bSEJ7cqNEIowQ7UTOd6GLoQqKgBy2GaIQRZGT1
	5u4uu2F+xp3iT7wuNkcaTG9BI/wFZFo1yEhVyuPCZpCHxTsuvHaYrD6KsOCAYCLuZRZN2n3BNQo
	J66kIyacowTmx9SYWUmI+JP2/IsQwXqweXdTyluEM4skGBG5KGQvn1LNz6UAplhLO8UE+oy6yIp
	F06FGRhZDjAiMvmEkqZusuS1YWJ6znPXAc75uwOhsm30=
X-Google-Smtp-Source: AGHT+IHmZb2ovoIujKXapX+UcdnRu8UmluaJHRHVolf48ZGcu3nrvKTQp3rQeUKIqOPeiBN/K034hw==
X-Received: by 2002:a05:600c:4686:b0:431:59b2:f0c4 with SMTP id 5b1f17b1804b1-433ce41ce37mr109056585e9.8.1732494913223;
        Sun, 24 Nov 2024 16:35:13 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:c9da:d8c1:1564:6a36? (2a02-8389-41cf-e200-c9da-d8c1-1564-6a36.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:c9da:d8c1:1564:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2683bsm8994516f8f.48.2024.11.24.16.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:35:11 -0800 (PST)
Message-ID: <95f01caa-0f32-4c5c-b262-435f839c81aa@gmail.com>
Date: Mon, 25 Nov 2024 01:35:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] drm for 6.13-rc1
To: Dave Airlie <airlied@gmail.com>, Sasha Levin <sashal@kernel.org>,
 CK Hu <ck.hu@mediatek.com>, wenst@chromium.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
 <Z0NXQ6iRK43x6WbG@sashalap>
 <CAPM=9tw5eTBCDn93GyrMjF3r_kDbr2-v1GgKdZECFNupqakDFw@mail.gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <CAPM=9tw5eTBCDn93GyrMjF3r_kDbr2-v1GgKdZECFNupqakDFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 23:58, Dave Airlie wrote:
> On Mon, 25 Nov 2024 at 02:41, Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Thu, Nov 21, 2024 at 10:25:45AM +1000, Dave Airlie wrote:
>>> Hi Linus,
>>>
>>> This is the main drm pull request for 6.13.
>>>
>>> I've done a test merge into your tree, there were two conflicts both
>>> of which seem easy enough to resolve for you.
>>>
>>> There's a lot of rework, the panic helper support is being added to
>>> more drivers, v3d gets support for HW superpages, scheduler
>>> documentation, drm client and video aperture reworks, some new
>>> MAINTAINERS added, amdgpu has the usual lots of IP refactors, Intel
>>> has some Pantherlake enablement and xe is getting some SRIOV bits, but
>>> just lots of stuff everywhere.
>>>
>>> Let me know if there are any issues,
>>
>> Hey Dave,
>>
>> After the PR was merged, I've started seeing boot failures reported by
>> KernelCI:
> 
> I'll add the mediatek names I see who touched anything in the area recently.
> 
> Dave.
>>
>> [    4.395400] mediatek-drm mediatek-drm.5.auto: bound 1c014000.merge (ops 0xffffd35fd12975f8)
>> [    4.396155] mediatek-drm mediatek-drm.5.auto: bound 1c000000.ovl (ops 0xffffd35fd12977b8)
>> [    4.411951] mediatek-drm mediatek-drm.5.auto: bound 1c002000.rdma (ops 0xffffd35fd12989c0)
>> [    4.536837] mediatek-drm mediatek-drm.5.auto: bound 1c004000.ccorr (ops 0xffffd35fd1296cf0)
>> [    4.545181] mediatek-drm mediatek-drm.5.auto: bound 1c005000.aal (ops 0xffffd35fd1296a80)
>> [    4.553344] mediatek-drm mediatek-drm.5.auto: bound 1c006000.gamma (ops 0xffffd35fd12972b0)
>> [    4.561680] mediatek-drm mediatek-drm.5.auto: bound 1c014000.merge (ops 0xffffd35fd12975f8)
>> [    4.570025] ------------[ cut here ]------------
>> [    4.574630] refcount_t: underflow; use-after-free.
>> [    4.579416] WARNING: CPU: 6 PID: 81 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
>> [    4.587670] Modules linked in:
>> [    4.590714] CPU: 6 UID: 0 PID: 81 Comm: kworker/u32:3 Tainted: G        W          6.12.0 #1 cab58e2e59020ebd4be8ada89a65f465a316c742
>> [    4.602695] Tainted: [W]=WARN
>> [    4.605649] Hardware name: Acer Tomato (rev2) board (DT)
>> [    4.610947] Workqueue: events_unbound deferred_probe_work_func
>> [    4.616768] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    4.623715] pc : refcount_warn_saturate+0xf4/0x148
>> [    4.628493] lr : refcount_warn_saturate+0xf4/0x148
>> [    4.633270] sp : ffff8000807639c0
>> [    4.636571] x29: ffff8000807639c0 x28: ffff34ff4116c640 x27: ffff34ff4368e080
>> [    4.643693] x26: ffffd35fd1299ac8 x25: ffff34ff46c8c410 x24: 0000000000000000
>> [    4.650814] x23: ffff34ff4368e080 x22: 00000000fffffdfb x21: 0000000000000002
>> [    4.657934] x20: ffff34ff470c6000 x19: ffff34ff410c7c10 x18: 0000000000000006
>> [    4.665055] x17: 666678302073706f x16: 2820656772656d2e x15: ffff800080763440
>> [    4.672176] x14: 0000000000000000 x13: 2e656572662d7265 x12: ffffd35fd2ed14f0
>> [    4.679297] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffd35fd0342150
>> [    4.686418] x8 : c0000000ffffdfff x7 : ffffd35fd2e21450 x6 : 00000000000affa8
>> [    4.693539] x5 : ffffd35fd2ed1498 x4 : 0000000000000000 x3 : 0000000000000000
>> [    4.700660] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff34ff40932580
>> [    4.707781] Call trace:
>> [    4.710216]  refcount_warn_saturate+0xf4/0x148 (P)
>> [    4.714993]  refcount_warn_saturate+0xf4/0x148 (L)
>> [    4.719772]  kobject_put+0x110/0x118
>> [    4.723335]  put_device+0x1c/0x38
>> [    4.726638]  mtk_drm_bind+0x294/0x5c0
>> [    4.730289]  try_to_bring_up_aggregate_device+0x16c/0x1e0
>> [    4.735673]  __component_add+0xbc/0x1c0
>> [    4.739495]  component_add+0x1c/0x30
>> [    4.743058]  mtk_disp_rdma_probe+0x140/0x210
>> [    4.747314]  platform_probe+0x70/0xd0
>> [    4.750964]  really_probe+0xc4/0x2a8
>> [    4.754527]  __driver_probe_device+0x80/0x140
>> [    4.758870]  driver_probe_device+0x44/0x120
>> [    4.763040]  __device_attach_driver+0xc0/0x108
>> [    4.767470]  bus_for_each_drv+0x8c/0xf0
>> [    4.771294]  __device_attach+0xa4/0x198
>> [    4.775117]  device_initial_probe+0x1c/0x30
>> [    4.779286]  bus_probe_device+0xb4/0xc0
>> [    4.783109]  deferred_probe_work_func+0xb0/0x100
>> [    4.787714]  process_one_work+0x18c/0x420
>> [    4.791712]  worker_thread+0x30c/0x418
>> [    4.795449]  kthread+0x128/0x138
>> [    4.798665]  ret_from_fork+0x10/0x20
>> [    4.802229] ---[ end trace 0000000000000000 ]---
>>
>> I don't think that I'll be able to bisect further as I don't have the
>> relevant hardware available.
>>
>> --
>> Thanks,
>> Sasha


Hello, I am one of those who touched something in the area.

To check if my changes are the cause of the boot failures, please apply
this patch:

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9a8ef8558da9..85be035a209a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -373,11 +373,12 @@ static bool mtk_drm_get_all_drm_priv(struct device
*dev)
 	struct mtk_drm_private *temp_drm_priv;
 	struct device_node *phandle = dev->parent->of_node;
 	const struct of_device_id *of_id;
+	struct device_node *node;
 	struct device *drm_dev;
 	unsigned int cnt = 0;
 	int i, j;

-	for_each_child_of_node_scoped(phandle->parent, node) {
+	for_each_child_of_node(phandle->parent, node) {
 		struct platform_device *pdev;

 		of_id = of_match_node(mtk_drm_of_ids, node);


---


This chunk can be found in mtk_drm_get_all_drm_priv(), which is not
listed in the trace, but it is called from mtk_drm_bind().

The loop did not release the child_node if cnt == MAX_CRTC (by means of
a break), which goes against how for_each_child_of_node() should be
handled. If the child_node is indeed required afterwards (it is not
referenced anywhere after the loop), it should be acquired via
of_node_get() and stored somewhere to be able to put it later.

Then another issue would lie underneath as the reference to the
child_node is not stored in any way. But if this patch fixes the issue,
then I suppose it should be applied immediately, and the rest should be
discussed later on.

By the way, are there any logs with debug/error messages to analyze
further is the issue is something different?

Thanks and best regards,
Javier Carrasco

