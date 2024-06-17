Return-Path: <linux-kernel+bounces-218125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E990B98B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B3D1F25603
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43619AD64;
	Mon, 17 Jun 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amq+9uNr"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938019AD4A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648314; cv=none; b=t43ZE4+StdfrmrYTeExeNuymRMSN0jSYRJ0SMTPKsiMSRXHG6A6ZotMCqi+ZHRp00CSFkmZOzYCwMQUtmUlblFRNtPKZ/Nbrl1t18pnbVrpN08qdv8uxNRoNAd8nCAy3ZZhIIIeCjkoruzaqLF1p3hxyJQ++StFHEx4SE2JBMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648314; c=relaxed/simple;
	bh=uzUtkaBs1eFh4Kg9PPe9ZguhkJmdxCgTLkwCF9xPsqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw5Z+ErwLId/yPDC9DhSt5ohmysRtxMEfbsmDPxjju/h1MfBusXpX0jc9dNC4D+U2nj86O/ewLv6lrAQsUQ1Lq4teoyHApmhggn67MhpZJse9Sp71zFEqjC6GYXqCqPjL9P0/oXF9jbrTx04R7HWEbSOfVHuPCc95kBb8j9Zn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amq+9uNr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so5201395e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648309; x=1719253109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceumPs6CQec2Ii8QHoLW6uVvM6OUIg9EFfPHe4qWsWE=;
        b=amq+9uNrkW+jkpvs8ZvFy3AyRCVHpuv+qhFwAS+xMGN+b7nThHQx7kNMJRWpkPLoWa
         VReKoabxeS1dklMDZjoRE2sPgT1/xXvbEAKcQUrBtQIRtNmEre91yAfuAAmJhUpvxlai
         nLTYRUpRtVooqcR6bsvPqwNlHuImagd85esbBFSnB4jHOFyJS4JewjlBnwbJpcil97Vq
         LAFbjKFq/J5XDgoQPtqKiljvZ5G/Fhmm9Ahcn84ceFemPOQJCWbCIsokkP/md6bD5NSW
         dVI8Gdqqc4HfvQuYh3GG3smCC7QDHmRvSEXPehTAULWlqjQaJ7h4I1IxvJthlMpFhuIP
         1cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648309; x=1719253109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceumPs6CQec2Ii8QHoLW6uVvM6OUIg9EFfPHe4qWsWE=;
        b=vN7BV975vfwcC7CXLjYezX/UTZA6OEFEr7rRKC1cGby61OUpdqVfZZaGeQasUd59P3
         yi4AavtmrHMnjtaNJSSrBOjSlhBuykJGQ5NWowMGsTFei4evovcx4GdU1MWE3QMSoYAU
         s/xEDQRVxHkczksGAF6PIBKAYjzic4MMdOoc2u8iEszKw8VNuYnAjhBd+oIcyKVOv2FD
         Q9T02N8MyuofUe4NAi6v1NkpJalFBof8Moye+TPWzgEEnUthRhSb/KDc/8+QipoZgwOZ
         2Te461IAXZVeby7YlovFvXCyJRG0EtFAj4XAb6pdb5jTpCkDBiCVcf3JYGTDLTB2rpl2
         kIbg==
X-Forwarded-Encrypted: i=1; AJvYcCWwE5PAmNK5wgUqySrxvmzKf0Xt0OczeGirMK/lBB8K5d1JcOwM4va1LzRho5+Pl+fw+yU0WWSXsA6uvs1/oHWuWNagKLNNTFjYBpZy
X-Gm-Message-State: AOJu0YxZyLX2X4lPs9KRDbz5fFdqy5nwD08/kABO9PwMpL4iO5+cRo7N
	sifFs79t6FuDD0afUWyEj8Wqt46jAkeMCEeFi7ndKeyl0tuwyY+aAJ4yLv97wVp69fB6Ap2y7ZM
	dsPXFGWhTMmW47b22hm5voF7GJhA=
X-Google-Smtp-Source: AGHT+IEXnCfaKbC9VECLKvXP+gGDAdtlS2kXJD36wyau7KK+j3fKiPUEihIWyil45KdwIUkqEaNkbCk4Vt/mqTiW+z4=
X-Received: by 2002:a05:6512:3618:b0:52c:a7c8:ec42 with SMTP id
 2adb3069b0e04-52ca7c8ed39mr6903120e87.0.1718648309268; Mon, 17 Jun 2024
 11:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com> <20240614040133.24967-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20240614040133.24967-3-jason-jh.lin@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 17 Jun 2024 13:18:17 -0500
Message-ID: <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:01=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> When we run kernel with lockdebug option, we will get the BUG below:
>   BUG: sleeping function called from invalid context at drivers/base/powe=
r/runtime.c:1164
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3616, name: kw=
orker/u17:3
>     preempt_count: 1, expected: 0
>     RCU nest depth: 0, expected: 0
>     INFO: lockdep is turned off.
>     irq event stamp: 0
>     CPU: 1 PID: 3616 Comm: kworker/u17:3 Not tainted 6.1.87-lockdep-14133=
-g26e933aca785 #1
>     Hardware name: Google Ciri sku0/unprovisioned board (DT)
>     Workqueue: imgsys_runner imgsys_runner_func
>     Call trace:
>      dump_backtrace+0x100/0x120
>      show_stack+0x20/0x2c
>      dump_stack_lvl+0x84/0xb4
>      dump_stack+0x18/0x48
>      __might_resched+0x354/0x4c0
>      __might_sleep+0x98/0xe4
>      __pm_runtime_resume+0x70/0x124
>      cmdq_mbox_send_data+0xe4/0xb1c
>      msg_submit+0x194/0x2dc
>      mbox_send_message+0x190/0x330
>      imgsys_cmdq_sendtask+0x1618/0x2224
>      imgsys_runner_func+0xac/0x11c
>      process_one_work+0x638/0xf84
>      worker_thread+0x808/0xcd0
>      kthread+0x24c/0x324
>      ret_from_fork+0x10/0x20
>
> We found that there is a spin_lock_irqsave protection in msg_submit()
> of mailbox.c and it is in the atomic context.
> So when cmdq driver calls pm_runtime_get_sync() in cmdq_mbox_send_data(),
> it will get this BUG report.
>
> To avoid using sleep in atomic context, move pm_runtime_get_sync to
> mbox_chan_ops->power_get and also move pm_runtime_put_autosuspend to
> mbox_chan_ops->power_put.
>
> Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM wit=
h autosuspend")

Can you please share the pattern of mailbox transfers on your platform?
As in, how often and long are the "channel idle" periods? And when
active, how many transfers/sec ?
I see every TX is acked by one RX packet. How long is the typical gap
between a TX and its ack?

Thanks

