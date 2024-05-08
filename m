Return-Path: <linux-kernel+bounces-173804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4BA8C05C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A58283356
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E4131725;
	Wed,  8 May 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6+MJFeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D3130AF7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200589; cv=none; b=PZP35bIEpuM7ntV4cdRmInaChtVx0yhquOWvXndk4qAfcbmiFUQ9z4CUda8WJa0rYaXrrp0kD+R0N9vlHJP8KhCR5lxA21YGTY5eiozbUg3UyqERyqfs4lahGSks1u0qcQj47/uQcdTG3FEByOgIsSjKp9IKnnfNDNTqO7Xmpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200589; c=relaxed/simple;
	bh=ZulLVyVHZHxm3YQ8KxXaqVfwKUOEaGw+eiS2cOdkylk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuGFTbAzyIW4cjNWgVxJSfW76J90a7pSTb0KSF5HblPYbo+NLqJ8NK6bKS5iQQezRJigqEBbb8FBsQfUk9fIvXBNhcCD1yhE4cB0FEiK516EFSDmfn1kqTGf7sQmUIsm9FceBSbU5GfCtBsv7XBfuvHX8LyQqqP5DqIs0yqe/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6+MJFeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE262C113CC;
	Wed,  8 May 2024 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715200589;
	bh=ZulLVyVHZHxm3YQ8KxXaqVfwKUOEaGw+eiS2cOdkylk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6+MJFeM78qqdB1XJ3JJhbByN11JY6ENFlRiNajEPrMo2Hb9KkLhcXq/ezpilTCeb
	 7KGeWG02EmtxzXSluz/JlgVI9Mrl7rVoSPu296IWatHdYzvt1yAi9Mc4vo+HafapYu
	 PTPaC6N9kmoeeYjpVvC8uprnuRBHpYbzfTo3DoZTRrMl/bPV0EK4t5oX8Wp06+667Y
	 vpgbwTxBgGaD6AduR6ATOFKs19xEkO7rhFCNphkYUxEMdOmL+uK7g1MpKvWyxb788f
	 XajdlXmuyn0VhMANfI6+hraMc4pj9ry1wcu2bUgt2sw0iiBWWg+1KsbxqdSQ1chdOL
	 RDwMiG6WHNFJQ==
Message-ID: <74767f1d-639a-4477-a38b-e5f15bf575df@kernel.org>
Date: Wed, 8 May 2024 22:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20240508095143.12023-1-jason-jh.lin@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240508095143.12023-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 11:51, Jason-JH.Lin wrote:
> When we run kernel with lockdebug option, we will get the BUG below:
> [  106.692124] BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1164
> [  106.692190] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3616, name: kworker/u17:3

Trim logs from irrelevant context. timestamps are useless his. Registers
as well. Addresses of stacktrace as well and better just decode it.


> [  106.692226] preempt_count: 1, expected: 0
> [  106.692254] RCU nest depth: 0, expected: 0
> [  106.692282] INFO: lockdep is turned off.
> [  106.692306] irq event stamp: 0
> [  106.692331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  106.692376] hardirqs last disabled at (0): [<ffffffee15d37fa0>] copy_process+0xc90/0x2ac0
> [  106.692429] softirqs last  enabled at (0): [<ffffffee15d37fc4>] copy_process+0xcb4/0x2ac0
> [  106.692473] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  106.692513] CPU: 1 PID: 3616 Comm: kworker/u17:3 Not tainted 6.1.87-lockdep-14133-g26e933aca785 #1 6839942e1cf34914b0a366137843dd2366f52aa9
> [  106.692556] Hardware name: Google Ciri sku0/unprovisioned board (DT)
> [  106.692586] Workqueue: imgsys_runner imgsys_runner_func
> [  106.692638] Call trace:
> [  106.692662]  dump_backtrace+0x100/0x120
> [  106.692702]  show_stack+0x20/0x2c
> [  106.692737]  dump_stack_lvl+0x84/0xb4
> [  106.692775]  dump_stack+0x18/0x48
> [  106.692809]  __might_resched+0x354/0x4c0
> [  106.692847]  __might_sleep+0x98/0xe4
> [  106.692883]  __pm_runtime_resume+0x70/0x124
> [  106.692921]  cmdq_mbox_send_data+0xe4/0xb1c
> [  106.692964]  msg_submit+0x194/0x2dc
> [  106.693003]  mbox_send_message+0x190/0x330
> [  106.693043]  imgsys_cmdq_sendtask+0x1618/0x2224
> [  106.693082]  imgsys_runner_func+0xac/0x11c
> [  106.693118]  process_one_work+0x638/0xf84
> [  106.693158]  worker_thread+0x808/0xcd0
> [  106.693196]  kthread+0x24c/0x324
> [  106.693231]  ret_from_fork+0x10/0x20
> 
> We found that there is a spin_lock_irqsave protection in msg_submit()
> of mailbox.c and it is in the atomic context.
> So when cmdq driver calls pm_runtime_get_sync() in cmdq_mbox_send_data(),
> it will get this BUG report.
> 
> 1. Change pm_runtime_get_sync() to pm_runtime_get() to avoid using sleep
>    in atomic context.
> 2. Move clk_bulk_enable() outside cmdq_runtime_resume() to ensure GCE
>    clocks are enabled before configuring GCE register.
> 3. Add used_count to avoid cmdq_runtime_suspend() being called before
>    calling cmdq_runtime_resume().
> 
> Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 033aff11f87c..b50f42e69aab 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -82,6 +82,7 @@ struct cmdq {
>  	const struct gce_plat	*pdata;
>  	struct cmdq_thread	*thread;
>  	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
> +	atomic_t		used_count;
>  	bool			suspended;
>  };
>  
> @@ -317,14 +318,21 @@ static int cmdq_runtime_resume(struct device *dev)
>  {
>  	struct cmdq *cmdq = dev_get_drvdata(dev);
>  
> -	return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
> +	atomic_inc(&cmdq->used_count);

Do not implement own runtime PM counter...

> +	return 0;
>  }
>  
>  static int cmdq_runtime_suspend(struct device *dev)
>  {
>  	struct cmdq *cmdq = dev_get_drvdata(dev);
>  
> +	if (atomic_read(&cmdq->used_count) == 0) {
> +		dev_warn(dev, "%s when used_count is 0!", __func__);
> +		return -EINVAL;
> +	}
> +
>  	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
> +	atomic_dec(&cmdq->used_count);
>  	return 0;
>  }
>  
> @@ -392,9 +400,8 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
>  	/* Client should not flush new tasks if suspended. */
>  	WARN_ON(cmdq->suspended);
>  
> -	ret = pm_runtime_get_sync(cmdq->mbox.dev);
> -	if (ret < 0)
> -		return ret;
> +	WARN_ON(pm_runtime_get(cmdq->mbox.dev) < 0);
> +	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));

That's a no... First, you remove error handling. Second, you add WARN
and code should not have WARNs for error handling.

All this looks like terrible hacky workaround just to make warning go
away, without actually addressing real problem.

Best regards,
Krzysztof


