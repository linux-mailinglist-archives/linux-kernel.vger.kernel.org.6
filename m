Return-Path: <linux-kernel+bounces-232940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42E91B035
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A1B232DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B7119D8A4;
	Thu, 27 Jun 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwDuTe9N"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342619CD15
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519293; cv=none; b=bQODyMxshgPIPbh8v5GbJiZtIj4d49yITu6W4ZjAyx9R5aOURwXw5Rh+Mo5VhjP4RUFXKLZam9s6o75V7AZ/p91HL4SXcv3RzIw8HC38K4gugIseO10nrfHr6uaYTlOQlRY35Ir1qSpgK62hwd4JEEPEijzphiKyy/ccKcCdKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519293; c=relaxed/simple;
	bh=uqMmpT6ErT419I1h+FSljhiSBtZrRu6wn1b0k1Lb7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVVnFXga0TadigXXwrA9ywjfe7YcVEeSsuxLJL8x5OenQWprDVLtZXnUPdgPrz2PS2K3nCNBCaqDC5Hsqbmu+LA3LujG1vidP2bmbZJuu4Axqagn5PVGiPtZoafBMli/Z3MEdBdU2OXSTUS4vAq4F3n1fbV89U/4Qie+0cA8eRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwDuTe9N; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso8204343e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719519290; x=1720124090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qSjrjHwVZDBImPSY+J+EMCkVAdKCh5wyCZmCHzUKhc=;
        b=ZwDuTe9Nah2/mQNeLLpHeOnwbecYyjSsqxttGjWphUKp0+QYHbOwrttjkPR5ewAKUK
         fBI9L5mUN7a2xkxo9So8yL3O4XYW0YXmnSw+BZjYVms/W+6BZ8jcH43hbBTpckSyAdYc
         Yo1HW3zF5Gr4D0bYS5+HXOEJRZltd3IeygG4P0Qy3tzVSomMWoVgs/Wqqzd7OZMMxnIV
         Wa1ociPTMkMUKVBhrsfQQ0pR/pRWR0rjsDs7s1xU6uZ8j7I8YRe36D265LxGAzceL23x
         8uvDCK23/5qHnMsuyW3Q4BzvH2O/4cI3FDVVcXLfcQpNsuXJn46vIpbfjyaNmr9MQcOg
         7xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719519290; x=1720124090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qSjrjHwVZDBImPSY+J+EMCkVAdKCh5wyCZmCHzUKhc=;
        b=kRYox5lZHpCbCFqxuaNCGleFk3whFKx3YD+eT/e840tIQHfEEXjIHNumy8oPvPdAOz
         M/cD7tOGJOgx2mIx+nz/Jk97e2nmlvkSVbWAiHB3YLfweSHMpG3VEU7EF4tcEsuif2Ot
         ZIVOQcBDV2Ab5NvY+e0pWaf0azkBVnhQJWEUvD1+RNsCwdJKqA9dVO4S0X8rDjYzrCwa
         99KmrDIfQ6w5Kj+MC2mz9ElHhXW0IyDy245d0bn8BegThOJgAo9VZT1cCTYY4QtZwWJQ
         o5vdcDIakGpiRCTzbzmMaYqKYuzsoUeVNGibjWTU6/LnnH8RixoMyIUoFbrW1g2ZQgbK
         VYaA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2esfHxAECEfr+ew5IBGxSYikBLWX7Pr4VTnNNgCLSbW9YMsJGNpCp9Qo4fsq7AmWV//63zzCchL2WPZPjjV8sgbbv5R8D4OeYLoD
X-Gm-Message-State: AOJu0YwnCOvPmr2f1G2gtv0lQZeHcrJgLW+k4zGAAdneWi7IboTBJrJw
	2P7SFUGODJHM95G+FJ5BL6XieMPeJscegp9v8fQAM6NxiVwcoCsp0+EzE33385A=
X-Google-Smtp-Source: AGHT+IEVpthfVjK7rlkJjNHkNoVz5Gaf8ymrlQmVwlRfVmHkt5P6ksUHBGaSYmDMLGYcn3bOYKcWZw==
X-Received: by 2002:a05:6512:2308:b0:52c:df6a:eb5f with SMTP id 2adb3069b0e04-52ce1ece4a3mr10797409e87.37.1719519289531;
        Thu, 27 Jun 2024 13:14:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101dbsm40953e87.74.2024.06.27.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:14:48 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:14:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-stm32] [PATCH v2 6/7] usb: typec: ucsi: extract common
 code for command handling
Message-ID: <bd7imlksghy5iigc75ob3mghm5zqvn5wrotj5fez3hahq2zv6x@l2bx6mbnijgp>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
 <20240621-ucsi-rework-interface-v2-6-a399ff96bf88@linaro.org>
 <160e7af5-29c8-49a6-ae4f-dbfc3dd608c1@foss.st.com>
 <k2q7g6ka34o2vgoy5s64nwixqa6qjaok72fuxgircwseyn2k7z@pm56aurq42n6>
 <3869dcd0-9936-4712-b7ad-3c66cbe4828a@foss.st.com>
 <CAA8EJpqEYRFOZbN55Eh0SisnR1HQ0iseA1L+1n0QxOrspsmLuQ@mail.gmail.com>
 <1ed93216-9445-4b31-85cf-5b7f35ee91c2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed93216-9445-4b31-85cf-5b7f35ee91c2@foss.st.com>

On Thu, Jun 27, 2024 at 06:49:02PM GMT, Fabrice Gasnier wrote:
> On 6/27/24 17:58, Dmitry Baryshkov wrote:
> > On Thu, 27 Jun 2024 at 18:51, Fabrice Gasnier
> > <fabrice.gasnier@foss.st.com> wrote:
> >>
> >> On 6/25/24 18:49, Dmitry Baryshkov wrote:
> >>> On Tue, Jun 25, 2024 at 05:24:54PM GMT, Fabrice Gasnier wrote:
> >>>> On 6/21/24 00:55, Dmitry Baryshkov wrote:
> >>>>> Extract common functions to handle command sending and to handle events
> >>>>> from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
> >>>>> the same way.
> >>>>>
> >>>>> The CCG driver used DEV_CMD_PENDING both for internal
> >>>>> firmware-related commands and for UCSI control handling. Leave the
> >>>>> former use case intact.
> >>>>>
> >>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>> ---
> >>>>>  drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++++
> >>>>>  drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
> >>>>>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 46 ++---------------------------
> >>>>>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
> >>>>>  drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++---------------------------
> >>>>>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++--------------------------
> >>>>>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++-------------------------------
> >>>>>  7 files changed, 62 insertions(+), 198 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> >>>>> index 4ba22323dbf9..691ee0c4ef87 100644
> >>>>> --- a/drivers/usb/typec/ucsi/ucsi.c
> >>>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
> >>>>> @@ -36,6 +36,48 @@
> >>>>>   */
> >>>>>  #define UCSI_SWAP_TIMEOUT_MS       5000
> >>>>>
> >>>>> +void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> >>>>> +{
> >>>>> +   if (UCSI_CCI_CONNECTOR(cci))
> >>>>> +           ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> >>>>> +
> >>>>> +   if (cci & UCSI_CCI_ACK_COMPLETE &&
> >>>>> +       test_bit(ACK_PENDING, &ucsi->flags))
> >>>>> +           complete(&ucsi->complete);
> >>>>> +
> >>>>> +   if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> >>>>> +       test_bit(COMMAND_PENDING, &ucsi->flags))
> >>>>> +           complete(&ucsi->complete);
> >>>>
> >>>> Hi Dmitry,
> >>>>
> >>>> I've recently faced some race with ucsi_stm32g0 driver, and have sent a
> >>>> fix for it [1], as you've noticed in the cover letter.
> >>>>
> >>>> To fix that, I've used test_and_clear_bit() in above two cases, instead
> >>>> of test_bit().
> >>>
> >>> Could you possible describe, why do you need test_and_clear_bit()
> >>> instead of just test_bit()? The bits are cleared at the end of the
> >>> .sync_write(), also there can be no other command (or ACK_CC) submission
> >>> before this one is fully processed.
> >>
> >> Hi Dmitry,
> >>
> >> It took me some time to reproduce this race I observed earlier.
> >> (I observe this during DR swap.)
> >>
> >> Once the ->async_control(UCSI_ACK_CC_CI) call bellow gets completed, and
> >> before the ACK_PENDING bit gets cleared, e.g. clear_bit(ACK_PENDING), I
> >> get an asynchronous interrupt.
> >>
> >> Basically, Then the above complete() gets called (due to
> >> UCSI_CCI_ACK_COMPLETE & ACK_PENDING).
> >>
> >> Subsequent UCSI_GET_CONNECTOR_STATUS command (from
> >> ucsi_handle_connector_change) will be unblocked immediately due to
> >> complete() call has already happen, without UCSI_CCI_COMMAND_COMPLETE
> >> cci flag, hence returning -EIO.
> > 
> > But the ACK_CI is being sent as a response to a command. This means
> > that the ppm_lock should be locked. The UCSI_GET_CONNECTOR_STATUS
> > command should wait for ppm_lock to be freed and only then it can
> > proceed with sending the command. Maybe I'm misunderstanding the case
> > or maybe there is a loophole somewhere.
> 
> There's probably also some miss-understanding at my end, I don't get how
> the ppm_lock would protext from non atomic async_control()/clear_bit().
> 
> Let me share some trace here, I hope it can better show the difference
> at my end when I get the race.
> I've added some debug prints around these lines, to trace the set/clear
> of the COMMAND/ACK_PENDING, main commands and cci flags.
> 
> normal case is:
> ---
> ucsi_send_command_common: UCSI_SET_UOR
> set:COMMAND_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
> clr:COMMAND_PENDING
> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
> set:ACK_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
> clr:ACK_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: ucsi_connector_change
> ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
> set:COMMAND_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
> clr:COMMAND_PENDING
> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE
> set:ACK_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
> clr:ACK_PENDING
> 
> racy case:
> ---
> ucsi_send_command_common: UCSI_SET_UOR
> set:COMMAND_PENDING
> ucsi_stm32g0_irq_handler
> ucsi_notify_common: UCSI_CCI_COMMAND_COMPLETE
> clr:COMMAND_PENDING
> ucsi_acknowledge: UCSI_ACK_COMMAND_COMPLETE UCSI_ACK_CONNECTOR_CHANGE
> set:ACK_PENDING
> ucsi_stm32g0_irq_handler              <-- up to here nothing supicious
> ucsi_notify_common: ucsi_connector_change
> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
> ucsi_stm32g0_irq_handler              <-- 2nd IRQ before clr:ACK_PENDING
> ucsi_notify_common: ucsi_connector_change
> ucsi_notify_common: UCSI_CCI_ACK_COMPLETE
> clr:ACK_PENDING
> ucsi_send_command_common: UCSI_GET_CONNECTOR_STATUS
> set:COMMAND_PENDING                   <-- completion already done :-(
> clr:COMMAND_PENDING
> ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-5)
> 
> I notice the two conditions are met above: both ucsi_connector_change()
> and cci ack completed.
> 
> This happens before clear_bit(ACK_PENDING), which lead to anticipate
> completion of the subsequent UCSI_GET_CONNECTOR_STATUS command.
> 
> So the test_and_clear_bit() would address a robustness case?

Ah, I see. So the race is for the completion. I fear that your solution
also doesn't fully solve the problem. The event can arrive after setting
the bit and before sending the command to the hardware. I thought about
doing various tricks, like reinit_completion or something close, but the
issue is that test_and_clear_bit() just makes the race window smaller,
but doesn't eliminate it completely.

It seems the only practical way to handle that is by making sure that
ucsi_notify_common() can sleep and locks the ppm_lock while
processing the CCI.

> 
> Please advise,
> Best Regards,
> Fabrice
> 
> > 
> >> This is where the test_and_clear_bit() atomic operation helps, to avoid
> >> non atomic operation:
> >>
> >> -> async_control(UCSI_ACK_CC_CI)
> >> new interrupt may occur here
> >> -> clear_bit(ACK_PENDING)

-- 
With best wishes
Dmitry

