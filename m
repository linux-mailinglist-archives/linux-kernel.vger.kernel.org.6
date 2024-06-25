Return-Path: <linux-kernel+bounces-228278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA3915D90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D711F22775
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC313A253;
	Tue, 25 Jun 2024 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbPv1Wfw"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD31849
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289301; cv=none; b=FfpJqLnDDBFXRbxEeo4jKFqrLwzrQxAPYrL5kmQNS1scBsMYiHox6WWbEiAZQI9BAAz8X8+lqvEOQZt+W89dXkybpeJSvbjthu70DrJDjhvx+vRhDhkGxEm5T25lrBKT+9775WEmW2DbBoryzLK+TBVIlT5PHV2T3SJv905DyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289301; c=relaxed/simple;
	bh=MuaU0bXcdpTyugdKuKzHuor0YUYhBTI1Pq877jksSag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPimQDOjD/+2044jmC+j0lcraz4KLhu1aOuGhIRPdl/iirg/xMwHuaycyMn00wtk1k3KYE+UAxE9BZO7jrtav50orku+gstC2pZ7jiJFXos6jeNmR9ICxo5Nr6IXhMYdBrARN4nBEgZGS6Khyrbx/AxyUm65EyLUwPdmGUvUntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbPv1Wfw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd9f9505cso3961441e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719289298; x=1719894098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu1LnZogWHoCyLFUWKpiivrgVlmD+xznk1rmZJOyHgA=;
        b=gbPv1WfwlxnWXa8TO8OIiJG+/MvFa6TQJFDg4TfWhpv2LckIchwDe4+5dEac2THTFX
         PJifX12aP6KllzKtxl2QZOTBUD095nXeAAF7eUMNaroRe/fLeCRbDGJ7NdSWc8pfMrZL
         nXXtdXu9EcqMxKMZmJ7MCBi6JUXe0BWodfNioNsmq01X8aI9u8aTqQ0e0M/LXfliDvw0
         vBNc/cOPuDq2aXKyovbGQhzZwt66eDJvEqW3jAyqFy7sCkgeKSPaQAg7snoHN4HHRGx9
         6ZWzStC/NrITT4kkTnHoXBkSN1UaBdSwQDj7LngZKyK1XM0NN2UQo3wwOHujHtfK1Qsd
         PL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719289298; x=1719894098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu1LnZogWHoCyLFUWKpiivrgVlmD+xznk1rmZJOyHgA=;
        b=uYSyY9ExZZVyCOZ+d3faP0sW52EdQJFmbSIOHF5CX3iQui0mzxc2gCFkYiADy/WOl7
         zVoRk1GBKDpMbVMrTe9ZFRYF2ku0E+VODXDOs0tn5bVIdCwU6CGvg5IssXZwbNGodTJB
         3qS2HO3jd1wdeFnavJYWDEqqFpkKOv+Dq9L+OBUo/NUcF4yDPuF7s8tvCJJNH7BjXI6o
         L6p+7KMrMf7RrwiNrQIYKr88EnfLZ0uDssLLHwCy5S8CFqMIdZJVbWozrWKd+y5yS0iT
         V2lvLTqqB8QfcLS8jlJYbRrN0THUU2LMscC7LBqV+JZSVduOmLEyeeMPv2Z/ZBEW9Ub+
         Di7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5mG4rtOWPPcgh4IivtjYizkZkHhKY0zSdaSyC0xF6sY0D78Zsgk2okqlxGtroNP1h/xRqijjraTa9SOS3YOLDX490ayfjYtdcL41
X-Gm-Message-State: AOJu0YyG1Z3wKbcD/2Ed/NJRKz5RmfoW0rIo6th+vaO1NeFCCI6BMDfF
	wT606yv2m7vSWSVhSzb3bJQ8wi9X2aaHoC/tlPJSJCaYc5MjBnvgqTVSggG7yNSPJo1bhuafaSa
	HETUN8uawrs4QSpU4qI2xVRSFr2g=
X-Google-Smtp-Source: AGHT+IFwN1NXNL6jfb2rrTRGo5ey7OVdTIF03YPWsbWXLa4+X3VRioA2aHnl6BcksHM0XT5qt3KrFvsTAkTa+cpIGRE=
X-Received: by 2002:ac2:43ce:0:b0:52c:da39:e40d with SMTP id
 2adb3069b0e04-52cdf7f1581mr4202983e87.26.1719289297244; Mon, 24 Jun 2024
 21:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com> <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com> <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
 <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com> <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
 <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
In-Reply-To: <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 24 Jun 2024 23:21:25 -0500
Message-ID: <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:41=E2=80=AFPM Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Mon, 2024-06-24 at 12:45 -0500, Jassi Brar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Mon, Jun 24, 2024 at 6:29=E2=80=AFAM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > >
> > > Il 20/06/24 16:39, Jassi Brar ha scritto:
> > > > On Thu, Jun 20, 2024 at 1:33=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=
=9D=BF=E7=A5=A5)
> > > > <Jason-JH.Lin@mediatek.com> wrote:
> > > >>
> > > >> On Wed, 2024-06-19 at 10:38 -0500, Jassi Brar wrote:
> > > >>>
> > > >>> External email : Please do not click links or open attachments
> > until
> > > >>> you have verified the sender or the content.
> > > >>>   On Wed, Jun 19, 2024 at 3:18=E2=80=AFAM AngeloGioacchino Del Re=
gno
> > > >>> <angelogioacchino.delregno@collabora.com> wrote:
> > > >>>> Il 18/06/24 17:59, Jassi Brar ha scritto:
> > > >>> .....
> > > >>>
> > > >>>> For example, when static content is displayed on screen, the
> > CMDQ
> > > >>> mailbox never
> > > >>>> gets shut down, but no communication happens for a relatively
> > long
> > > >>> time; the
> > > >>>> overhead of actually shutting down the mailbox and setting it
> > back
> > > >>> up would be
> > > >>>> increasing latency in an unacceptable manner.
> > > >>>>
> > > >>> Hmm...  in your driver,  startup() is _empty_   and  shutdown()
> > is
> > > >>> all
> > > >>> under a spin-lock with irqs disabled, so that too shouldn't be
> > > >>> expensive. Right?
> > > >>> Then what causes unacceptable latencies?
> > > >>>
> > > >>
> > > >> I found that the BUG report only occurred when opening the
> > camera APP.
> > > >> Maybe something in imgsys_cmdq_sendtask() is too expensive or
> > somewhere
> > > >> else in imgsys driver.
> > > >>
> > > > If you move anything from submit() into startup(), which is once
> > per
> > > > lifetime of a channel, it will only make imgsys_cmdq_sendtask()
> > > > cheaper.
> > > > Btw, the imgsys code is not public, I don't know how it looks.
> > > >
>
> It'll be upstreamed in the future, so I can only test it locally to
> find the information we want.
>
> > > >
> > > >> I'm wondering why this BUG report is not occurred in display use
> > case
> > > >> which is more frequent than imgsys use case.
> > > >> Does this mean sleep() is not always called in
> > pm_runtime_get_sync()
> > > >> and if we can guarantee this sleep() won't be called, then using
> > > >> pm_runtime_get_sync() in atomic context is OK?
> > > >>
> > > > Instead of hacking around, maybe try using startup() and
> > shutdown()
> > > > which is for such uses? Maybe request/release channel as part of
> > RPM
> > > > in your client driver if you are worried about the noise?
> > > >
> > > >
> > > >>>> This is why I opted for autosuspend - it's only bringing down
> > > >>> certain clocks for
> > > >>>> the CMDQ HW, adding up a bit of power saving to the mix which,
> > for
> > > >>> some use cases
> > > >>>> such as mobile devices with relatively small batteries, is
> > > >>> definitely important.
> > > >>>>
> > > >>>> I'll also briefly (and only briefly) mention that 120Hz
> > displays
> > > >>> are already a
> > > >>>> common thing and in this case the gap between TX and ACK is
> > ~8.33ms
> > > >>> instead, let
> > > >>>> alone that displays with a framerate of more than 120Hz also
> > do
> > > >>> exist even though
> > > >>>> they're less common.
> > > >>>>
> > > >>> I don't know how even busier channels help your point.
> > > >>>
> > > >>>> All of the above describes a few of the reasons why
> > autosuspend is
> > > >>> a good choice
> > > >>>> here, instead of a shutdown->startup flow.
> > > >>>> And again - I can place some bets that PM would also be
> > applicable
> > > >>> to SoCs from
> > > >>>> other vendors as well, with most probably different benefits
> > (but
> > > >>> still with some
> > > >>>> power related benefits!) compared to MediaTek.
> > > >>
> > > >> I agree with Angelo's point!
> > > >>
> > > > Ok, but you or Angelo still don't explain "unacceptable
> > latencies"
> > > > when your startup() and shutdown() are empty. You just want api
> > > > changed, which we can but at least do you part and tell me where
> > the
> > > > bottleneck (unexpected latency) comes from.
> > > >
> > >
> > > "I want numbers" is a sensible request, honestly I would do the
> > same so I totally
> > > understand that.
> > >
> > > Jason, can you please perform latency measurements on 60Hz and
> > *especially* ISP/cam
> > > cases while "continuously" calling startup() and shutdown() for
> > every power saving
> > > operation?
>
> You mean moving clk_builk_enable() and clk_bulk_disable() to startup()
> and shutdown(), and then calling startup() in cmdq_runtime_resume() and
> calling shutdown() in cmdq_runtime_suspend()?
> If we do that, I think GCE clocks will never be closed because
> mbox_request_channel() and mbox_free_channel() will call startup() and
> shutdown() already.
>
> I found that display thread:0 will call mbox_send_message() every 16ms
> when I moving UI continuously:
> [   61.503604] thread_id:0, send_diff:16 ms
> [   61.520266] thread_id:0, send_diff:16 ms
> [   61.537143] thread_id:0, send_diff:16 ms
> [   61.553609] thread_id:0, send_diff:16 ms
> [   61.570811] thread_id:0, send_diff:17 ms
> [   61.587075] thread_id:0, send_diff:16 ms
> [   61.603527] thread_id:0, send_diff:16 ms
> [   61.620082] thread_id:0, send_diff:16 ms
> [   61.637496] thread_id:0, send_diff:17 ms
> [   61.653876] thread_id:0, send_diff:16 ms
> [   61.670162] thread_id:0, send_diff:16 ms
> [   61.687318] thread_id:0, send_diff:17 ms
> [   61.703747] thread_id:0, send_diff:16 ms
> [   61.720656] thread_id:0, send_diff:16 ms
> If I didn't do anything to UI, I won't see any mbox_send_message()
> logs.
>
> It means mbox_send_message() will only be called when the display is
> updated:
> [  782.777205] thread_id:0, send_diff:20072 ms
> [  820.296738] thread_id:0, send_diff:37519 ms
> [  863.034270] thread_id:0, send_diff:42737 ms
> [  880.297759] thread_id:0, send_diff:17263 ms
> [  917.795432] thread_id:0, send_diff:37497 ms
>
>
> When opening camera APP, it seems to become 30fps:
> [  120.551778] BUG: sleeping function called from invalid context at
> drivers/base/power/runtime.c:1164
> [  120.560844] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid:
> 201, name: kworker/u17:1
> [  120.569363] preempt_count: 1, expected: 0
> [  120.573367] RCU nest depth: 0, expected: 0
> [  120.577457] INFO: lockdep is turned off.
> [  120.581372] irq event stamp: 0
> [  120.584420] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  120.590687] hardirqs last disabled at (0): [<ffffffd3624a86e0>]
> copy_process+0x578/0xf10
> [  120.598780] softirqs last  enabled at (0): [<ffffffd3624a86ec>]
> copy_process+0x584/0xf10
> [  120.606865] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  120.613128] CPU: 0 PID: 201 Comm: kworker/u17:1 Not tainted 6.1.92-
> lockdep-14419-g8c5f20e56598-dirty #1
> e971112e83e796239a41e46e8747794c737fb18c
> [  120.626073] Hardware name: Google Ciri sku0/unprovisioned board (DT)
> [  120.632420] Workqueue: imgsys_runner imgsys_runner_func
> [  120.637647] Call trace:
> [  120.640086]  dump_backtrace+0x100/0x120
> [  120.643919]  show_stack+0x20/0x2c
> [  120.647230]  dump_stack_lvl+0x84/0xb4
> [  120.650891]  dump_stack+0x18/0x44
> [  120.654203]  __might_resched+0x204/0x214
> [  120.658123]  __might_sleep+0x50/0x80
> [  120.661692]  __pm_runtime_resume+0x48/0xbc
> [  120.665786]  cmdq_mbox_send_data+0x8c/0x434
> [  120.669966]  msg_submit+0x84/0x104
> [  120.673362]  mbox_send_message+0xb8/0x124
> [  120.677365]  imgsys_cmdq_sendtask+0x688/0x928
> [  120.681717]  imgsys_runner_func+0x44/0x78
> [  120.685722]  process_one_work+0x274/0x574
> [  120.689731]  worker_thread+0x240/0x3f0
> [  120.693475]  kthread+0xfc/0x11c
> [  120.696612]  ret_from_fork+0x10/0x20
> [  120.710570] mtk-cam raw 16030000.cam-raw-a: [SOF] frame done reading
> lost frames. req(7),ts(120697780083)
> [  120.720352] mtk-cam raw 16030000.cam-raw-a: [SOF] SCQ_DELAY state:4
> ts:120697780083
> [  120.990091] thread_id:0, send_diff:1470 ms
> [  121.007210] thread_id:0, send_diff:17 ms
> [  121.016484] thread_id:0, send_diff:9 ms
> [  121.032652] thread_id:0, send_diff:16 ms
> [  121.049366] thread_id:0, send_diff:16 ms
> [  121.066880] thread_id:0, send_diff:17 ms
> [  121.087023] thread_id:0, send_diff:20 ms
> [  121.099325] thread_id:0, send_diff:12 ms
> [  121.135286] thread_id:0, send_diff:35 ms
> [  121.149349] thread_id:0, send_diff:14 ms
> [  121.179259] thread_id:0, send_diff:29 ms
> [  121.203183] thread_id:0, send_diff:23 ms
> [  121.242234] thread_id:0, send_diff:39 ms
> [  121.280645] thread_id:0, send_diff:38 ms
> [  121.318651] thread_id:0, send_diff:38 ms
> [  121.356366] thread_id:0, send_diff:37 ms
> [  121.394484] thread_id:0, send_diff:38 ms
>
> The cmdq_runtime_suspend() will only be called when I disabled camera
> APP:
> [  468.137530] pm_on ts:465259, pm_off ts:4681375, diff:2877 ms
> and the diff is the duration from opening the camera APP to closing the
> camera APP.
>
> From booting to seeing the UI and any operation of UI, I didn't see
> any cmdq_runtime_suspend() logs from display mbox channel.
> So cmdq_runtime_resume() and cmdq_runtime_suspend() are never called by
> display mbox channel.
> This can tell why only opening the camera APP can see this BUG report.
>
> > >
> > To be clear, do with the mailbox channel that you do with the clocks
> > now, because your startup() is literally and shutdown() is
> > practically
> > empty.
> > Call shutdown() when no request has come in for a while, so you know
> > the client has quiesced likely. So try putting request/release in
> > higher level RPM with autosuspend.
>
> I'm not quit sure how to modify this from current usage.
> Do you mean:
> 1. Move pm_runtime_get_sync() from cmdq_mbox_semd_data() to startup()
> and keep pm_runtime_put_autosuspend() in cmdq_mbox_semd_data()?
>
> 2. Call shutdown() in cmdq_runtime_suspend()?
>
No shutdown() is called from channel release. Maybe release the
channel from suspend() of user driver (imgsys).

The idea is that
1) If the gap between transfers on a busy channel is ~10ms or more.  And ..
2) The silence on the mailbox channel is multiple of 100ms. And ...
3) startup() and shutdown() are empty (as in your driver)
  ... then you could afford to release/suspend and resume/request
during the silence period because the _api_ cost of request/release
should not even be 1ms. Your stack may be designed to make doing that
difficult but numbers wise it should work.

Thanks

