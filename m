Return-Path: <linux-kernel+bounces-232631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9940391AC18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C31F229DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF1199399;
	Thu, 27 Jun 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqnGt5xA"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA519925B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503922; cv=none; b=VtEp2NiwTkWHxYnKBTTOk0xXGZrAG1RilnmfJkruQDmKvSFN0QH0AgK7DNB/FRTDEuvgFTd3AZTa3+BpfRMRo3pmvw0zljzpxzeTKO33bYB/H1ZZWqdui36VK0eniy7IHa72M2iJp7tUAOp0pEqTzRrE9SLhrBkfGhytdx9gW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503922; c=relaxed/simple;
	bh=alY8Un95zE8FxbdBKFyejfbYJ83ei7VJoaDQT0QyfoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeJjwDg19rni0B6QTwsmNXUnaQUqBosSi/nd5IanHsX+1m4+djWMG3AV251N+qrc+ClelenuuYxODS1OAWRE89UknV8IexxEaIk2SvcCgc/S/2ZOZ8/TcxiEMyPjDw1iCvoJdA25J8/Kjyw4W+NytivG6D7zzg7oh/pfxT31uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqnGt5xA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-643f1ee4b3cso49371507b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719503919; x=1720108719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8ZzzGZRi1QKExrw3BT/1Kv0MzbBRGnRw4edtWk3+Og=;
        b=aqnGt5xAtQmL2ejPH6uKtrWdkXJZ4Hr1ko7nDQwDcW5ZFAoXPkTCwA5nFNCtC2J3mD
         L1tBWpfF+HE387uqwWsWktgPYg+Icq1+o22HpSAXiDuWaGpcnXA7vZuMpBf14pApGAqm
         b0IB07/VICPo4jOX3f9xyMy+8vAhDOmfPaHwk8euRi5+SdqoRLGBT22MlorZrGRQqL/f
         O9TWpHJ+hV6czZnhbjw8uMTW3rEaE8METNLmtNKTIGuSPPdQfGIsfSMCYRoSSie52L3e
         F25qDCX0ufjYXmcmytTldr/9Mu2Twjg3vlSv1hQR/zrk29G+TyDkUsAyeDW4MI/EFeWM
         o5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719503919; x=1720108719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8ZzzGZRi1QKExrw3BT/1Kv0MzbBRGnRw4edtWk3+Og=;
        b=HqBfy7sbm7KJv2yqdNyI+tfGCL9fIP5ay8gp0FS6P+R17kQT/pVKZr4DKyQCWLM4sH
         1N8vEIa668uv+duYmuK9eGqt1CyH5KjwI1Rlbk8HUfNuqlE+niXjl2MdkrHGVLvpnK23
         NrhKkamgtMWD21VDNfjXE99ejT9WH/Fxj+nrq4FnTiC5Z9nMtJVqGYlTLG+27BywPHDl
         8meF6ZR9EDGz3l3NDIsRGR5PwwNxhEsKG/BXn2hjuGGXaAMito4Uae6XjnYcKeoUJX2Y
         VA4XHotwNcVcm/EvYUhKaPfDCw/fC2sT1dNDXG2yvc85qvnQNARXn7ddQfKE6fTiFN43
         3itQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDGIcbpZDnv8l5pFtts5uqyLFHkWrT/Gc4GhQ8wsodMrcmlCSHzZ3Q3Peq5mTQ0nnj05xOC2KTT3feqCmsVeZ6QyrPJc+wO1yLQH2q
X-Gm-Message-State: AOJu0YxEkzKMglTAGAgxji/94bqsbYzE7VcZJFPUGoj7yYpBatgieC0p
	h5+l+WFZJPypQsoRetptmEt8x34QiKO73VQRLwPht2JmdO3M8Hwm5EtpSQcgbJADEX6yVpaU5qR
	peCtAGKy7j06XkZAL8z2fDsi2TpJd6bBTM0sElA==
X-Google-Smtp-Source: AGHT+IEGiCrH8BWw13I1i48IOGUhT9YHzvAq39yzyI0zIVycObTcf2eKMnqqaPTk8iMwZNXP8e5umU4P+BuQvardwU8=
X-Received: by 2002:a05:690c:ecd:b0:632:5b24:c0c with SMTP id
 00721157ae682-643a990bee0mr161400757b3.5.1719503919225; Thu, 27 Jun 2024
 08:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
 <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
 <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com> <k2q7g6ka34o2vgoy5s64nwixqa6qjaok72fuxgircwseyn2k7z@pm56aurq42n6>
 <3869dcd0-9936-4712-b7ad-3c66cbe4828a@foss.st.com>
In-Reply-To: <3869dcd0-9936-4712-b7ad-3c66cbe4828a@foss.st.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 18:58:27 +0300
Message-ID: <CAA8EJpqEYRFOZbN55Eh0SisnR1HQ0iseA1L+1n0QxOrspsmLuQ@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v2 6/7] usb: typec: ucsi: extract common
 code for command handling
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 18:51, Fabrice Gasnier
<fabrice.gasnier@foss.st.com> wrote:
>
> On 6/25/24 18:49, Dmitry Baryshkov wrote:
> > On Tue, Jun 25, 2024 at 05:24:54PM GMT, Fabrice Gasnier wrote:
> >> On 6/21/24 00:55, Dmitry Baryshkov wrote:
> >>> Extract common functions to handle command sending and to handle events
> >>> from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
> >>> the same way.
> >>>
> >>> The CCG driver used DEV_CMD_PENDING both for internal
> >>> firmware-related commands and for UCSI control handling. Leave the
> >>> former use case intact.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
> >>>  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
> >>>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
> >>>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
> >>>  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
> >>>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
> >>>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
> >>>  7 files changed, 62 insertions(+), 198 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> >>> index 4ba22323dbf9..691ee0c4ef87 100644
> >>> --- a/drivers/usb/typec/ucsi/ucsi.c
> >>> +++ b/drivers/usb/typec/ucsi/ucsi.c
> >>> @@ -36,6 +36,48 @@
> >>>   */
> >>>  #define UCSI_SWAP_TIMEOUT_MS       5000
> >>>
> >>> +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> >>> +{
> >>> +   if (UCSI_CCI_CONNECTOR(cci))
> >>> +           ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> >>> +
> >>> +   if (cci & UCSI_CCI_ACK_COMPLETE &&
> >>> +       test_bit(ACK_PENDING, &ucsi->flags))
> >>> +           complete(&ucsi->complete);
> >>> +
> >>> +   if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> >>> +       test_bit(COMMAND_PENDING, &ucsi->flags))
> >>> +           complete(&ucsi->complete);
> >>
> >> Hi Dmitry,
> >>
> >> I've recently faced some race with ucsi_stm32g0 driver, and have sent a
> >> fix for it [1], as you've noticed in the cover letter.
> >>
> >> To fix that, I've used test_and_clear_bit() in above two cases, instead
> >> of test_bit().
> >
> > Could you possible describe, why do you need test_and_clear_bit()
> > instead of just test_bit()? The bits are cleared at the end of the
> > .sync_write(), also there can be no other command (or ACK_CC) submission
> > before this one is fully processed.
>
> Hi Dmitry,
>
> It took me some time to reproduce this race I observed earlier.
> (I observe this during DR swap.)
>
> Once the ->async_control(UCSI_ACK_CC_CI) call bellow gets completed, and
> before the ACK_PENDING bit gets cleared, e.g. clear_bit(ACK_PENDING), I
> get an asynchronous interrupt.
>
> Basically, Then the above complete() gets called (due to
> UCSI_CCI_ACK_COMPLETE & ACK_PENDING).
>
> Subsequent UCSI_GET_CONNECTOR_STATUS command (from
> ucsi_handle_connector_change) will be unblocked immediately due to
> complete() call has already happen, without UCSI_CCI_COMMAND_COMPLETE
> cci flag, hence returning -EIO.

But the ACK_CI is being sent as a response to a command. This means
that the ppm_lock should be locked. The UCSI_GET_CONNECTOR_STATUS
command should wait for ppm_lock to be freed and only then it can
proceed with sending the command. Maybe I'm misunderstanding the case
or maybe there is a loophole somewhere.

> This is where the test_and_clear_bit() atomic operation helps, to avoid
> non atomic operation:
>
> -> async_control(UCSI_ACK_CC_CI)
> new interrupt may occur here
> -> clear_bit(ACK_PENDING)
>
> >
> >>
> >> https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> >>
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(ucsi_notify_common);
> >>> +
> >>> +int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
> >>> +{
> >>> +   bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
> >>> +   int ret;
> >>> +
> >>> +   if (ack)
> >>> +           set_bit(ACK_PENDING, &ucsi->flags);
> >>> +   else
> >>> +           set_bit(COMMAND_PENDING, &ucsi->flags);
> >>> +
> >>> +   ret = ucsi->ops->async_control(ucsi, command);
> >>> +   if (ret)
> >>> +           goto out_clear_bit;
> >>> +
> >>> +   if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
> >>> +           ret = -ETIMEDOUT;
> >>
> >> With test_and_clear_bit(), could return 0, in case of success here.
> >
> > Oh, I see. So your code returns earlier. I have a feeling that this
> > approach is less logical and slightly harder to follow.
>
> By reading your proposal bellow, I'd agree with you.
> >
> > Maybe it's easier if it is implemented as:
> >
> > if (wait_for_completion_timeout(...))
> >       return 0;
>
> Yes, sounds good to me.
>
> >
> > if (ack)
> >       clear_bit(ACK_PENDING)
> > else
> >       clear_bit(COMMAND_PENDING)
> >
> > return -ETIMEDOUT;
> >
> >
> > OR
> >
> > if (!wait_for_completion_timeout(...)) {
> >       if (ack)
> >               clear_bit(ACK_PENDING)
> >       else
> >               clear_bit(COMMAND_PENDING)
> >
> >       return -ETIMEDOUT;
> > }
>
> Both seems fine.
>
> Please advise,
> BR,
> Fabrice
>
> >
> > return 0;
> >
> > But really, unless there is an actual issue with the current code, I'd
> > prefer to keep it. It makes it clear that the bits are set and then are
> > cleared properly.
> >
> >> I'd suggest to use similar approach here, unless you see some drawback?
> >>
> >> Best Regards,
> >> Fabrice
> >>
> >>> +
> >>> +out_clear_bit:
> >>> +   if (ack)
> >>> +           clear_bit(ACK_PENDING, &ucsi->flags);
> >>> +   else
> >>> +           clear_bit(COMMAND_PENDING, &ucsi->flags);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
> >>> +
> >>>  static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
> >>>  {
> >>>     u64 ctrl;
> >>> @@ -1883,6 +1925,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
> >>>     INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
> >>>     INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
> >>>     mutex_init(&ucsi->ppm_lock);
> >>> +   init_completion(&ucsi->complete);
> >>>     ucsi->dev = dev;
> >>>     ucsi->ops = ops;
> >>
> >> [snip]
> >>
> >>>     ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
> >>> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> >>> index 14737ca3724c..d948c3f579e1 100644
> >>> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> >>> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> >>> @@ -61,11 +61,7 @@ struct ucsi_stm32g0 {
> >>
> >> [snip]
> >>
> >>> -
> >>> -   ret = ucsi_stm32g0_async_control(ucsi, command);
> >>> -   if (ret)
> >>> -           goto out_clear_bit;
> >>> -
> >>> -   if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
> >>> -           ret = -ETIMEDOUT;
> >>> -   else
> >>> -           return 0;
> >>> -
> >>> -out_clear_bit:
> >>> -   if (ack)
> >>> -           clear_bit(ACK_PENDING, &g0->flags);
> >>> -   else
> >>> -           clear_bit(COMMAND_PENDING, &g0->flags);
> >>> -
> >>> -   return ret;
> >>> -}
> >>> -
> >>>  static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
> >>>  {
> >>>     struct ucsi_stm32g0 *g0 = data;
> >>> @@ -449,13 +416,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
> >>>     if (ret)
> >>>             return IRQ_NONE;
> >>>
> >>> -   if (UCSI_CCI_CONNECTOR(cci))
> >>> -           ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
> >>> -
> >>> -   if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
> >>> -           complete(&g0->complete);
> >>> -   if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
> >>> -           complete(&g0->complete);
> >>> +   ucsi_notify_common(g0->ucsi, cci);
> >>
> >> I can see the fix "test_and_clear_bit()" sent earlier is removed from here.
> >>
> >> I'd suggest to use similar approach as here, unless you see some drawback?
> >>
> >> Please advise,
> >> Best Regards,
> >> Fabrice
> >



-- 
With best wishes
Dmitry

