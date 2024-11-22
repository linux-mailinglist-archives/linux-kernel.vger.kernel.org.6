Return-Path: <linux-kernel+bounces-418184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69919D5E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67315282B87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB117E00E;
	Fri, 22 Nov 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ANjxycDU"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327D1DDC12
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275664; cv=none; b=KkAMiqbKJuf3yT2OpA52uUQ0BxBPtI2hqgYMtl5JKS7hc0h8DOuBuC9kpaWa4xl1AilQO/hA/iJMEgQS4NybXjxAG3E3Vv6242eECoWD1ITt70kiCJE38qSaau+Dbqfot14MYSwJfaZV7uAhXQHuie//S2w3LY2945jTyfZ6TQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275664; c=relaxed/simple;
	bh=lp1vi2Iq7ya/TuTEogBGxYG7jWeLrKl2kVVMsWCIOvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjU116wqGbkn2ju6CTTL0VcplUdfqmVLcwCDOqPowBU/zfabiIadzV5bbLMnXtz4dZILthyFQNVocom+KG3oYiRtFzfkzlJqba01y+ZuB13kWt2CdUuprmWIr8KAsiN8K9mFVV+FhycBEygcZRj8HRNcG/I2/5ht5KRAe+Z3j34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ANjxycDU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e382330ec4cso161486276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732275662; x=1732880462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJAb2wfaEGwYjP5tGhyEnaRAxPwQNw0aCt1/mnNWsV8=;
        b=ANjxycDUzqeTlyEr1M8CfjE0MHVN6/d9+raR+j0db13RmAdBh9cEXYRIujm3Uv2eh3
         ArC4jqV1FaNo7ygUQkKyW0OAWvbUtRDiKfKcwtLLQvY7yb4hnCYIR6H/VwciH9jo5HKU
         mvT4AdNdx+imcqF+3juBXphpKjJrYeoUilTMGoOszlO4c7YriAgO25uEmLaHowfvElw/
         lut4a9bExpDNOuz5CUzj8C9Upqw2eOhNHHqHONfjQ6LVuYH9K1LWPTc2Jz2gqrthM+cR
         IXXnpjrw6cbaYxfPt/kEsLnqVZPMZTv8lx6963XxlnivO5g0qY82QZZgCxLGZCMN+M0S
         jvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275662; x=1732880462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJAb2wfaEGwYjP5tGhyEnaRAxPwQNw0aCt1/mnNWsV8=;
        b=eK6vqMpNUXK0oSuIVMSpn4cKb0pk9+P/eJxxdwsD0/9lW66ifmNWl0Df26lM1/QxKY
         9B+T/Iq16HAlMO4SN6ueRH6XmagOxw7Grcu2V3+HRbPgWVvIfbrnGiBmD09jF2FSxgoQ
         blcfiM/U7oMw6R9UoqPE+F2S8+HYvIY1fT6fdsveLDUrrQdmAsL1k1lmAPsIP5+lR8Qc
         WFH26kbkwhhyi68Qr+zXpQWe6lt3nfrJ5/I5rG8cTXuvpNaZd/WTO+e0b3FIJae1klLt
         wfu9himrD6ICv1xLrZf9eAep3Gyj7nAsu8A6HqhPxtzcbqlK4uWhwG46v0AEKmrjdXqM
         YjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQpzlyzSRBWZbRzF3r6fXPDi6bhR8R3fgUiwXWERd6NdJjlIAqimbMjcbKNwPD6IDpFrNiE8SHJM1lkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3A1SK5a5+aRbEN0u5mIGAmLulIMEc7At67VgWeJzo89uyDp/X
	YkkzHiV8IOiMQDqUzNGTD7Paen8rDyuq/UYdsoSGfHsaUBlR5f1HWS7nAbAZ8+ip6eW+mWXN/fn
	m0BUsqsLBSAG/bmHXcFPR71nsfvtVrihy1IUMXQ==
X-Gm-Gg: ASbGncuuaetrFbOSj1NKjDX8sVJBcSaB3FY14uj+Srut5IilWXw0EZIZrHQUJZucC1i
	mxIx5YWHTAxhy6lIDBwUQ/U6iRBWJAixPJPWzr//CQK60JViTP07GkDODQ+LFi7w=
X-Google-Smtp-Source: AGHT+IEi3ScDmwaL6BuNLPC9RVZ0SffHnlV2j182TkFRSvu6Ibvv0coqzDmjB1nUi4Vfhlt3vE6Ek0Qw1Jo4FhfXkvs=
X-Received: by 2002:a05:690c:680d:b0:6dd:c828:485a with SMTP id
 00721157ae682-6eee0b67b47mr11613407b3.8.1732275661801; Fri, 22 Nov 2024
 03:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122084152.1841419-1-naush@raspberrypi.com>
 <20241122084152.1841419-6-naush@raspberrypi.com> <xy44zndazbw7ehpzbc6hexgptjymevvupjhuy2x6zxp54qtepm@vlbb6js62cq4>
In-Reply-To: <xy44zndazbw7ehpzbc6hexgptjymevvupjhuy2x6zxp54qtepm@vlbb6js62cq4>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Fri, 22 Nov 2024 11:40:26 +0000
Message-ID: <CAEmqJPrrAhhukn2H4nUhe1njVi-dyW9q=u1h8YgafvJGbYRG6Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drivers: media: bcm2835-unicam: Correctly handle
 FS + FE ISR condition
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-media@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo,

On Fri, 22 Nov 2024 at 11:16, Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Naush
>
> On Fri, Nov 22, 2024 at 08:41:52AM +0000, Naushir Patuck wrote:
> > This change aligns the FS/FE interrupt handling with the Raspberry Pi
> > kernel downstream Unicam driver.
> >
> > If we get a simultaneous FS + FE interrupt for the same frame, it cannot
> > be marked as completed and returned to userland as the framebuffer will
> > be refilled by Unicam on the next sensor frame. Additionally, the
> > timestamp will be set to 0 as the FS interrupt handling code will not
> > have run yet.
> >
> > To avoid these problems, the frame is considered dropped in the FE
> > handler, and will be returned to userland on the subsequent sensor frame.
> >
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > ---
> >  .../media/platform/broadcom/bcm2835-unicam.c  | 39 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > index f10064107d54..0d2aa25d483f 100644
> > --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> > +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > @@ -773,10 +773,26 @@ static irqreturn_t unicam_isr(int irq, void *dev)
> >                        * as complete, as the HW will reuse that buffer.
> >                        */
> >                       if (node->cur_frm && node->cur_frm != node->next_frm) {
> > +                             /*
> > +                              * This condition checks if FE + FS for the same
> > +                              * frame has occurred. In such cases, we cannot
> > +                              * return out the frame, as no buffer handling
> > +                              * or timestamping has yet been done as part of
> > +                              * the FS handler.
> > +                              */
> > +                             if (!node->cur_frm->vb.vb2_buf.timestamp) {
> > +                                     dev_dbg(unicam->v4l2_dev.dev,
> > +                                             "ISR: FE without FS, dropping frame\n");
> > +                                     continue;
> > +                             }
> > +
> >                               unicam_process_buffer_complete(node, sequence);
> > +                             node->cur_frm = node->next_frm;
> > +                             node->next_frm = NULL;
> >                               inc_seq = true;
> > +                     } else {
> > +                             node->cur_frm = node->next_frm;
> >                       }
> > -                     node->cur_frm = node->next_frm;
> >               }
> >
> >               /*
> > @@ -812,10 +828,25 @@ static irqreturn_t unicam_isr(int irq, void *dev)
> >                                       i);
> >                       /*
> >                        * Set the next frame output to go to a dummy frame
> > -                      * if we have not managed to obtain another frame
> > -                      * from the queue.
> > +                      * if no buffer currently queued.
> >                        */
> > -                     unicam_schedule_dummy_buffer(node);
> > +                     if (!node->next_frm ||
> > +                         node->next_frm == node->cur_frm) {
> > +                             unicam_schedule_dummy_buffer(node);
> > +                     } else if (unicam->node[i].cur_frm) {
> > +                             /*
> > +                              * Repeated FS without FE. Hardware will have
> > +                              * swapped buffers, but the cur_frm doesn't
> > +                              * contain valid data. Return cur_frm to the
> > +                              * queue.
>
> So the buffer gets silently recycled ? Or should it be returned with
> errors to userspace ?

The buffer silently gets recycled and we dequeue when we are sure it
is valid and will not get overwritten.  If we were to return to
userspace with an error, there is still a race condition on the name
frame/buffer which will also have to return as error.

Regards,
Naush


>
> > +                              */
> > +                             spin_lock(&node->dma_queue_lock);
> > +                             list_add_tail(&node->cur_frm->list,
> > +                                           &node->dma_queue);
> > +                             spin_unlock(&node->dma_queue_lock);
> > +                             node->cur_frm = node->next_frm;
> > +                             node->next_frm = NULL;
> > +                     }
> >               }
> >
> >               unicam_queue_event_sof(unicam);
> > --
> > 2.34.1
> >
> >

