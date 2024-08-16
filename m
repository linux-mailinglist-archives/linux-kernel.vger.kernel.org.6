Return-Path: <linux-kernel+bounces-289483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581619546A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0890F288F23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1259617C9B8;
	Fri, 16 Aug 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TG5Ua8gj"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66617BEBD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803602; cv=none; b=R8Pr98o/hYFoq5flNgOXV+wdGxorT7zR02OhG0DUQcaRM9r7fH+V/eIrxOhRuCJEvB1uIUfk7o1JqN+wlgY6K6rZAnr/G6mxzGpaEJ+d5RsUCEixJoe/3fpSBx1bYzXPEaX7POy446ZaO9mWwsgkASOcW7LzP4UiY4mR2V7hNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803602; c=relaxed/simple;
	bh=MQFYcJgF3GCPNTGvdTNgyXl9CUcUIcxvfrPusyvNb6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdpvvWTNJwYvvZYI6RY4z2jIiF+7gYTGudi27x6YIHAMoDdb0jEk14f9pRVhgZLY+iOxjfsQp1HKCMsBa3u5DQPyeyr0GiLc62E+0vJ8Hu+3HcA3JxJz/nfJKGuqfrvJylHmMgst8M5W97yMu/o/nGd7942gUMT4Pej9lTkmGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TG5Ua8gj; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-49299323d71so691172137.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723803599; x=1724408399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKl6sG125oIcosA1A44lD12PStzJaGU1SQK7ba2gVx0=;
        b=TG5Ua8gj9Ru7+rM51I0Rm/Rz1D9GUxeos6xPqH06NTC1bdW75yy1I/BFfyulNlRMRq
         0DZjNmaaUzDbJNinXirfN64Lk/7w51gA3IA82GteetWHlzjg4mbw6w0au/lIT476smo9
         BUZA0y5L39K6ucwI7fSb6IZzIVhaq496b94ngKkKFnw/IMHz50BmXCwcV8mHdYtLc2Y2
         uZ0n87SZz3HkSUveEzPq4DvZHTia1ylNfo0AlQFnzzfKEu0TfoxQsFUvBR1v4T0xrFWi
         qO6G3+T+KNiPl7ILUU7LXSDTNR/48vFwuk/2BCW6I1wOgBWb+s0MVV1y5vSkTGYKTuqv
         mORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803599; x=1724408399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKl6sG125oIcosA1A44lD12PStzJaGU1SQK7ba2gVx0=;
        b=hLw7vhby9FWI5GbeiVZQV67+dNV6pQoLpGPwIhSSuwCGyU4x0CY5XKdQae6xWYEj7Z
         jiP68Eje7cVJVDmbXQeu6maoYqwVZeWXlM9AkOQYLXcFqeFw2/YsEyTgfD2ph4Ph4h50
         +TCdctT8a3gQxllTGQRsruFFwT8O+Sn9luaug+19QHSPjwSVkrkO3CqjEQpuIuzZTslQ
         RlofP6RsgBozqT8yEiu/eaK0ZXa0DhM5cRSpUwbw6Fdk6tMxsE9Vbl+LbME20sFfzhCk
         tAl8ytQaEQxG6Dy/bLCS5jJ0k73ASwexN2i22lFydTQ/qmyt5d95c9/X6Fnmf9ovHxXw
         e9JA==
X-Forwarded-Encrypted: i=1; AJvYcCVsiuW7WJaPnBQh8g0MOnHtCYhc18of3ocuH0wUUTGHrnkuJe1Pc45eqlZj/hxPDSeoaB67fXV2cOvCxg6GYNm6vEAf78qzHtnKqXzm
X-Gm-Message-State: AOJu0YwckaTb0S8ZOwjEAXJpmCMungvocClMTI4aoQ/W0QxXoJidU1RF
	2qRX+gn6GwhmeuW7gXofNnN1vRhAigjWx25mdEgUypP7LCYzZhWqZzLCWC/wpo3EBgK3HsgGkEl
	zH72DgLdKgDSIwH3TQ6/cVmWUniOGZA1N7Y79/A==
X-Google-Smtp-Source: AGHT+IFR1QBwy+VtprC05B+2GUxI//V9NWd4R/09+N+8JCX0Dgl5n0lV/1KsHDVBP3cRjPolh6r9Lf8PZd31g/60Gjc=
X-Received: by 2002:a05:6102:3e94:b0:492:a5a9:a74 with SMTP id
 ada2fe7eead31-497799b55b9mr3615334137.22.1723803598879; Fri, 16 Aug 2024
 03:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502224703.103150-1-swboyd@chromium.org> <CAE-0n50VDgsg-4QnynvLOzykr3KP5JsnHqeFPA=uRT3EfgL19g@mail.gmail.com>
 <CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com>
 <CAE-0n53X1Gv9nnyDfeivYd7n5W6D1WFkO0tCvYc9drb0+4hQbw@mail.gmail.com>
 <CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com>
 <CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com>
 <CAMi1Hd2drhMGTsvnX1aqwpDTOkK_+n2OKMYY1Y9ONHyYiFLTSQ@mail.gmail.com> <CAE-0n53pjPjSw0m93biWOXRkV=V5u-HVqBx8=MLgQ=Z2ydfEKA@mail.gmail.com>
In-Reply-To: <CAE-0n53pjPjSw0m93biWOXRkV=V5u-HVqBx8=MLgQ=Z2ydfEKA@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 16 Aug 2024 15:49:22 +0530
Message-ID: <CAMi1Hd2ue5D1gb5eekQqCXi1DdPtMbzQV9BxEDjLgvw+G7hHwA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Park shared RCGs upon registration
To: Stephen Boyd <swboyd@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Laura Nao <laura.nao@collabora.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 04:26, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Pundir (2024-08-12 02:39:47)
> > gcc_qupv3_wrap1_s7_clk_src and gcc_usb30_prim_master_clk_src need to
> > be left untouched to fix the Audio codec and USB-C host mode breakages
> > respectively. It seem to have fixed the serial console garbage dump
> > issue as well.
>
> Alright. Can you try with this patch for the gcc_qupv3* clks on top? And
> keep gcc_usb30_prim_master_clk_src on the new clk_ops? I think we need
> two patches. One for the usb clk and one for these QUP clks that don't
> need to be parked.
>

Moving gcc_qupv3* clks to clk_rcg2_ops and keeping
gcc_usb30_prim_master_clk_sr to the clk_rcg2_shared_no_init_park_ops
works too. No audio or usb-c host regression in limited (~50) test
runs.

> > Thank you for diagnosing this race in ucsi_glink. I needed to run an
> > overnight reboot test to reproduce this crash, and could reproduce it
> > on ~380th reboot. I'll check if it has already been reported or fixed
> > on linux-next.
>
> Amazing! Can you add the msleep() so that it is highly likely?
>

You are right on the target with this one as well. I hit the following
kernel panic on each of the 10 reboots that I tried with the msleep()
in devm_pmic_glink_register_client().

[   17.824050][  T164] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000010
[   17.824068][  T164] Mem abort info:
[   17.824074][  T164]   ESR = 0x0000000096000006
[   17.824084][  T164]   EC = 0x25: DABT (current EL), IL = 32 bits
[   17.824096][  T164]   SET = 0, FnV = 0
[   17.824105][  T164]   EA = 0, S1PTW = 0
[   17.824113][  T164]   FSC = 0x06: level 2 translation fault
[   17.824124][  T164] Data abort info:
[   17.824130][  T164]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   17.824140][  T164]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   17.824151][  T164]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   17.824165][  T164] user pgtable: 4k pages, 39-bit VAs, pgdp=00000008820ac000
[   17.824180][  T164] [0000000000000010] pgd=080000088208e003,
p4d=080000088208e003, pud=080000088208e003, pmd=0000000000000000
[   17.824221][  T164] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   17.825877][  T164] CPU: 0 UID: 0 PID: 164 Comm: kworker/0:10
Tainted: G S          E
6.11.0-rc3-mainline-00013-g1690e68dbe30-dirty #37
[   17.825906][  T164] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
[   17.825914][  T164] Hardware name: Qualcomm Technologies, Inc.
SM8550 HDK (DT)
[   17.825926][  T164] Workqueue: events
pmic_glink_altmode_enable_worker [pmic_glink_altmode]
[   17.825958][  T164] pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
[   17.825978][  T164] pc : pmic_glink_send+0x10/0x2c [pmic_glink]
[   17.826002][  T164] lr : pmic_glink_altmode_request+0x74/0x108
[pmic_glink_altmode]
[   17.826328][  T164] Call trace:
[   17.826335][  T164]  pmic_glink_send+0x10/0x2c [pmic_glink]
[   17.826358][  T164]  pmic_glink_altmode_request+0x74/0x108
[pmic_glink_altmode]
[   17.826379][  T164]  pmic_glink_altmode_enable_worker+0x28/0x68
[pmic_glink_altmode]
[   17.826401][  T164]  process_one_work+0x184/0x2e8
[   17.826432][  T164]  worker_thread+0x2f0/0x404
[   17.826456][  T164]  kthread+0x114/0x118
[   17.826477][  T164]  ret_from_fork+0x10/0x20
[   17.826509][  T164] Code: d503233f f800865e a9bf7bfd 910003fd (f9400800)
[   17.826520][  T164] ---[ end trace 0000000000000000 ]---
[   17.826532][  T164] Kernel panic - not syncing: Oops: Fatal exception
[   17.826541][  T164] SMP: stopping secondary CPUs
[   19.164392][  T164] SMP: failed to stop secondary CPUs 0-1
[   19.364551][  T164] Kernel Offset: 0xf96480000 from 0xffffffc080000000
[   19.364562][  T164] PHYS_OFFSET: 0x80000000
[   19.364570][  T164] CPU features: 0x18,004e0003,80113128,564676af
[   19.364583][  T164] Memory Limit: none

Again, I have not yet checked if it has already been reported upstream
or fixed in the linux-next. I'll hopefully do that next week.

Regards,
Amit Pundir



> ----8<----
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 9ebc0ba35947..12169b0d2adb 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -97,6 +97,8 @@ struct pmic_glink_client
> *devm_pmic_glink_register_client(struct device *dev,
>
>         devres_add(dev, client);
>
> +       msleep(10000);
> +
>         return client;
>  }
>  EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);

