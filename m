Return-Path: <linux-kernel+bounces-420858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E669D83B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC05016605D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2726193425;
	Mon, 25 Nov 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="JtmO6+QG"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A407193429
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531601; cv=none; b=pQBxxJWCvweb4G7YTlBa86IBzHntCP3M6jA/vH42f94iFdqXBYL1Qr3xx6U3MgclgkT6CfuIsSxznFuyAwVpJXw6T9eWKBkULClef3oKhx7W3VoXVTnoVauKnzajbKZXbP6Iv0tEsnIzfV7oBmOFF+CtDm8t6z1eNfimfykrHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531601; c=relaxed/simple;
	bh=GP0T8ewRYzu4HxZ3WnqjMjNwJ8ZYiCh/2BOXbms6Z8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEZCtDfvXarcsr54gSksET8z2qIvZS6OX3nCIsdnBgIuFZYE9k5KMyYm4730qrwSqxi0u2bGyyFvxXpNt3xdTj87N01AGWnNd2hyUhkoWEzYbWiv/2MmfhzRD0XKQnObOfa6yts6o3bcFSHaFxnHxyKENqI2TOuoUwKsnVhF9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=JtmO6+QG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e38863a8700so592372276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732531597; x=1733136397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26FZSeEdgO+NHa3EUYAzp6T4D/JS5Ge/APF1zhDq5PE=;
        b=JtmO6+QG0lePTPqJWQOcQqsdkAvPgdP3kkolDH+1z1F0BL5fv7zL93ll9wv4cOfkw2
         w4GFw2uClOSKC4x3qtee9W6gXxVD+/mFPdEWDxZPYqiWVJ0dRgEktZnJurhEpOLQRu2e
         FrbDcWJA7+hzyB4+pJWLoS2Zeqi2zfbslv0IXwFUn67IiemklgAN4YPzKdXMQwC4MBhg
         GjHl/1j7S3GaL2+jbSFiFoR1VgO9T1ixNVhRNJcYNFLVWRlRBB9Y6N3VJrleMmHaddSx
         qkPzuoazubtLMckEGFT/xfC1rgd6ZPoPXs414lpDyjtK5jUyWTw59CVXm4fGUyFfJ3G0
         rN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732531597; x=1733136397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26FZSeEdgO+NHa3EUYAzp6T4D/JS5Ge/APF1zhDq5PE=;
        b=LXcXyeNJ/wxHGHq/TCTVzkL9Q97D8x7y0FGDC2x25m8Q4zFkgHkLxXSX+Hc/thGPS2
         GvUimW3BdSVu0pxpN45wK3GtO85K1zILg6LzUsYhjKDzxklzuBhzGMf5u9Kq+udi05bA
         dytpz9KW7gsUhiqX2aTP9rGkAonpVqpl22TEmUwhG+O0oqiPq1m+4+o9VyrWekRwBXCv
         I21oA58bwqZHE2bQUkzMoPsqYTE3bEiIsQZ7jHQ9wAZPvkdp3GSL3vNiFGZJ0v81ma88
         4DVDzBq2DUQ6b78Gr3PHL/FdlGn2g/ApIj2aZ5l20ZJkgREC8spdnp68jeXkXT937z9k
         ckag==
X-Forwarded-Encrypted: i=1; AJvYcCVriC31FpoaeLnbd0pf45aWn55CTyr98KHhKtJ14zv5bKMmXpAkfCTtcFotsf4HZ82mAo7c1e/e2imTi9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcndw0jIcMm9JQJ460lv5k8Ji0OFlu9OuelQ9tO2XnCctSmMod
	TvCF21H7Qmj3AFBIbJv3BJFrgowmGNeRC2mZZf91OBDgkn6yooTZYD2k1rt/iGSBE5l3hjnVBe+
	1gbUG8Nb93OITa8dfzkkc8V8FrmnEAyp7r2d5Eg==
X-Gm-Gg: ASbGncuCADvBannKBxuJ98rU6IoJ4A7A8J0cDY1QFow3edUDfEA9wlYhYHlZ8ILqnDx
	YrNKo+exubiTxbwoaizt1+pQomEhhOBmeo6dv5CMHuUkfy7iAh2+2UtZOev0hKpY=
X-Google-Smtp-Source: AGHT+IEKBDUKsnQY2QvubNmp8u3yV1Nbr7olengon87+FnysXiAS6rV6LCeYk/aaPdprs28q0xV7/4+THizDS8P+rvc=
X-Received: by 2002:a05:6902:2210:b0:e38:b8bb:fb7d with SMTP id
 3f1490d57ef6-e38f8c11c69mr3265008276.11.1732531597130; Mon, 25 Nov 2024
 02:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122084152.1841419-1-naush@raspberrypi.com>
 <20241122084152.1841419-6-naush@raspberrypi.com> <xy44zndazbw7ehpzbc6hexgptjymevvupjhuy2x6zxp54qtepm@vlbb6js62cq4>
 <CAEmqJPrrAhhukn2H4nUhe1njVi-dyW9q=u1h8YgafvJGbYRG6Q@mail.gmail.com>
 <xadxi6rjcnmgjiqhinqnawj3mgps4b3xp6ftozap4ps6q5xaz7@bsdwrrkyniwt>
 <deremuh7mawzt6ke3c67fvzfyuksmuwon3dhorxbm5mr5rllmf@fbj2f5qvfpjd>
 <20241124070428.GG19573@pendragon.ideasonboard.com> <CAEmqJPrDvhz+np4MxKiwfrKyjxG0HnO45T+U2=Bpbmm6MW1uXg@mail.gmail.com>
 <20241125092335.GL19381@pendragon.ideasonboard.com> <CAEmqJPo58OCosJhKZeut4=ZGQfk3CCJR_G8ZZZvmAUNTwfmKjw@mail.gmail.com>
 <20241125102707.GP19381@pendragon.ideasonboard.com>
In-Reply-To: <20241125102707.GP19381@pendragon.ideasonboard.com>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Mon, 25 Nov 2024 10:46:01 +0000
Message-ID: <CAEmqJPrDb5_L-9tv7nEuG7GoN6naKhM-vsC0tPfLQaAQYisqjg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drivers: media: bcm2835-unicam: Correctly handle
 FS + FE ISR condition
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-media@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,


On Mon, 25 Nov 2024 at 10:27, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Naush,
>
> On Mon, Nov 25, 2024 at 09:46:26AM +0000, Naushir Patuck wrote:
> > On Mon, 25 Nov 2024 at 09:23, Laurent Pinchart wrote:
> > > On Mon, Nov 25, 2024 at 08:37:22AM +0000, Naushir Patuck wrote:
> > > > On Sun, 24 Nov 2024 at 07:04, Laurent Pinchart wrote:
> > > > > On Fri, Nov 22, 2024 at 03:48:11PM +0100, Jacopo Mondi wrote:
> > > > > >
> > > > > > With Hans Sakari and Laurent in cc for real now
> > > > > >
> > > > > > On Fri, Nov 22, 2024 at 03:41:31PM +0100, Jacopo Mondi wrote:
> > > > > > > On Fri, Nov 22, 2024 at 11:40:26AM +0000, Naushir Patuck wrote:
> > > > > > > > On Fri, 22 Nov 2024 at 11:16, Jacopo Mondi wrote:
> > > > > > > > > On Fri, Nov 22, 2024 at 08:41:52AM +0000, Naushir Patuck wrote:
> > > > > > > > > > This change aligns the FS/FE interrupt handling with the Raspberry Pi
> > > > > > > > > > kernel downstream Unicam driver.
> > > > > > > > > >
> > > > > > > > > > If we get a simultaneous FS + FE interrupt for the same frame, it cannot
> > > > > > > > > > be marked as completed and returned to userland as the framebuffer will
> > > > > > > > > > be refilled by Unicam on the next sensor frame. Additionally, the
> > > > > > > > > > timestamp will be set to 0 as the FS interrupt handling code will not
> > > > > > > > > > have run yet.
> > > > > > > > > >
> > > > > > > > > > To avoid these problems, the frame is considered dropped in the FE
> > > > > > > > > > handler, and will be returned to userland on the subsequent sensor frame.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > > > > > > > > > ---
> > > > > > > > > >  .../media/platform/broadcom/bcm2835-unicam.c  | 39 +++++++++++++++++--
> > > > > > > > > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > > > > > > > > > index f10064107d54..0d2aa25d483f 100644
> > > > > > > > > > --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> > > > > > > > > > +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> > > > > > > > > > @@ -773,10 +773,26 @@ static irqreturn_t unicam_isr(int irq, void *dev)
> > > > > > > > > >                        * as complete, as the HW will reuse that buffer.
> > > > > > > > > >                        */
> > > > > > > > > >                       if (node->cur_frm && node->cur_frm != node->next_frm) {
> > > > > > > > > > +                             /*
> > > > > > > > > > +                              * This condition checks if FE + FS for the same
> > > > > > > > > > +                              * frame has occurred. In such cases, we cannot
> > > > > > > > > > +                              * return out the frame, as no buffer handling
> > > > > > > > > > +                              * or timestamping has yet been done as part of
> > > > > > > > > > +                              * the FS handler.
> > > > > > > > > > +                              */
> > > > > > > > > > +                             if (!node->cur_frm->vb.vb2_buf.timestamp) {
> > > > > > > > > > +                                     dev_dbg(unicam->v4l2_dev.dev,
> > > > > > > > > > +                                             "ISR: FE without FS, dropping frame\n");
> > > > > > > > > > +                                     continue;
> > > > > > > > > > +                             }
> > > > > > > > > > +
> > > > > > > > > >                               unicam_process_buffer_complete(node, sequence);
> > > > > > > > > > +                             node->cur_frm = node->next_frm;
> > > > > > > > > > +                             node->next_frm = NULL;
> > > > > > > > > >                               inc_seq = true;
> > > > > > > > > > +                     } else {
> > > > > > > > > > +                             node->cur_frm = node->next_frm;
> > > > > > > > > >                       }
> > > > > > > > > > -                     node->cur_frm = node->next_frm;
> > > > > > > > > >               }
> > > > > > > > > >
> > > > > > > > > >               /*
> > > > > > > > > > @@ -812,10 +828,25 @@ static irqreturn_t unicam_isr(int irq, void *dev)
> > > > > > > > > >                                       i);
> > > > > > > > > >                       /*
> > > > > > > > > >                        * Set the next frame output to go to a dummy frame
> > > > > > > > > > -                      * if we have not managed to obtain another frame
> > > > > > > > > > -                      * from the queue.
> > > > > > > > > > +                      * if no buffer currently queued.
> > > > > > > > > >                        */
> > > > > > > > > > -                     unicam_schedule_dummy_buffer(node);
> > > > > > > > > > +                     if (!node->next_frm ||
> > > > > > > > > > +                         node->next_frm == node->cur_frm) {
> > > > > > > > > > +                             unicam_schedule_dummy_buffer(node);
> > > > > > > > > > +                     } else if (unicam->node[i].cur_frm) {
> > > > > > > > > > +                             /*
> > > > > > > > > > +                              * Repeated FS without FE. Hardware will have
> > > > > > > > > > +                              * swapped buffers, but the cur_frm doesn't
> > > > > > > > > > +                              * contain valid data. Return cur_frm to the
> > > > > > > > > > +                              * queue.
> > > > > > > > >
> > > > > > > > > So the buffer gets silently recycled ? Or should it be returned with
> > > > > > > > > errors to userspace ?
> > > > > > > >
> > > > > > > > The buffer silently gets recycled and we dequeue when we are sure it
> > > > > > > > is valid and will not get overwritten.  If we were to return to
> > > > > > >
> > > > > > > I haven't find in the v4l2 specs any reference to what the behaviour
> > > > > > > should be.
> > > > > > >
> > > > > > > If I can summarize it: When a frame capture is aborted after the DMA
> > > > > > > transfer has already started, should the corresponding capture buffer
> > > > > > > be returned to the user in error state or the frame drop can go
> > > > > > > silently ignored ?
> > > > >
> > > > > If the DMA tranfer is aborted, I would return the buffer to userspace.
> > > > > This will indicate a frame loss better than deducing it from a gap in
> > > > > the sequence numbers.
> > > > >
> > > > > Is the DMA really aborted here though ?
> > > >
> > > > No, the DMA continues, causing possilbe overwrite/tearing in the
> > > > framebuffer.  Hence we defer returning it until we can ensure we don't
> > > > overwrite into the buffer on the next frame.
> > >
> > > If the DMA continues then we certainly can't return the buffer to
> > > userspace. Is it the next frame being DMA'ed to the same buffer, or does
> > > the hardware put it the buffer at the back of its queue ?
> >
> > The next frame will be DMA'ed into the same buffer in this error
> > condition. The hardware really only has a 2-deep buffer queue (current
> > + next frame), and no reliable way of telling if next has been swapped
> > to been swapped.
>
> OK, that makes sense.
>
> In that case, is putting the buffer back to the back of the dma_queue
> the right option ? Shouldn't it be kept current and "just" be completed
> one frame later ? Or did I misunderstand the patch ?

Yes, I agree that the buffer handling logic below does seem
contradictory.  I'm going to need time to look into this in more
detail, it's been quite some time since I looked into this.  I would
suggest we remove this particular patch from the series until I get a
better understanding of the change.

Regards,
Naush


>
> > > > > > > Cc-ing Hans Sakari and Laurent for opinions.
> > > > > > >
> > > > > > > > userspace with an error, there is still a race condition on the name
> > > > > > > > frame/buffer which will also have to return as error.
> > > > > > >
> > > > > > > I'm sorry I didn't get this part :)
> > > > > > >
> > > > > > > > > > +                              */
> > > > > > > > > > +                             spin_lock(&node->dma_queue_lock);
> > > > > > > > > > +                             list_add_tail(&node->cur_frm->list,
> > > > > > > > > > +                                           &node->dma_queue);
> > > > > > > > > > +                             spin_unlock(&node->dma_queue_lock);
> > > > > > > > > > +                             node->cur_frm = node->next_frm;
> > > > > > > > > > +                             node->next_frm = NULL;
> > > > > > > > > > +                     }
> > > > > > > > > >               }
> > > > > > > > > >
> > > > > > > > > >               unicam_queue_event_sof(unicam);
>
> --
> Regards,
>
> Laurent Pinchart

