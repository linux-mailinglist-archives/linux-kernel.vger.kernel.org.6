Return-Path: <linux-kernel+bounces-295635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA4959F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC601C21C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891D1AF4F6;
	Wed, 21 Aug 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgkIx0U8"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701461AF4F4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249468; cv=none; b=HI8RM2RX/0mjogG7BtPzmnOTbqW+P3srCQMBA7NQtvAnIKitu5avhkatCtyB6ENEVYEdufUdGy8MZAqzaeI7Y0IiIiHFqN16RPyw/+nJso5bH1CvYcEJzjz3x2MJc76o4KcMGdSzWRGwzeasnOOZpT6sSZ6Ky1xkDn3WSfxGVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249468; c=relaxed/simple;
	bh=7LN1VPua/GREWYA77ysD6GCYYUF0iwvig9V4vs6/EnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCUyxl127KQtkjGxs1ZBelLyT1BjX4z9eIy9ay3AgcuVg3yBla7kjMz6exewgtC7cwDYXw2UJrjqMfgws8f52u9ewRFV/HUG8C//7X0mKqgeBYbH1WnBeduzB3GkeIMYtZR98E+SyJWyStxOol99V7Ff/4wbmvW1gHDEX7niUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgkIx0U8; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e165825ebfdso1802840276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724249465; x=1724854265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt6DNfGyFCmulHbPUqbeiwc6HHUuVhB/uxCzt67oVF4=;
        b=kgkIx0U8DFjeMLSpQs20fFXKpNWVAJUb5YpVYD2L4cLOy0kSrUMjPS0tiDMj2Bavfk
         d/HLYDWh7EVtNqYYGh2+C7JZJ4PBMDOye+cdcPQx4i3SReE1cjgOoLGCoc/Q+ciQ86bc
         QzEqxGHGXkeKo0osn4h3hdiyRo5Xvh0BKg4B92Ai9CCEY/P5RYFFRIc0BZaRPLpe7CuQ
         qAdqq5LXMqXB9x/K+RxOZhD4UzmIxvpx6Ujo7bZPP3UAgieggH9PQ0mRS5BqbkJQhMrR
         2JZi0tNbD26LFh16ALBmIsqd1Ck0OnvSyLEDWF2q4/myKSOU6ChkpB2S0Ml3WxKmf75G
         m+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724249465; x=1724854265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt6DNfGyFCmulHbPUqbeiwc6HHUuVhB/uxCzt67oVF4=;
        b=NzpzxLuAcyeD33/rNXxmvNqoY4pcJAyHWUm7DnvVNlVUCOu2+odZkIbJC+BHlNNrxg
         C+tb3Ge+BlALZOikRPCQ1LUrMyvoWnISpR7w52IYgIPWDkm1lmdLPfKBwaGbPG80wJoT
         oJET34Y4JR0Rw7Tmt5N1uclth67j64mhZzQ81jmuWaW0UVS8MPRyeEDjD0wKjc3oCs9V
         asvJDIKSoXhCkc5VQWjq/JshcHH4yWFciPDwsbErH4ei0cimuqgADihH7YNfTm9voy10
         yV9CAoSaqmC7zEE4cyIeKEc4XyESEbpnj8YbOBkxkSjuEZhJnb9z087FqTmubq+Kj3BC
         z1eQ==
X-Gm-Message-State: AOJu0YxRS+5uWFZINhs5nMpoKWZRiE98BTwFw8mrKDW7V/hQBrnZxZ6B
	Jnm2rpBa5ccej/lJy3eh2zFZVMQ8QvI/A0exTBALq88umwQ5w03XXtnVP6FL6hSxzKblYuvo2CI
	yy2yGY1pdTUJcYGTkSuQF/yueQal4ePanMp6uNw==
X-Google-Smtp-Source: AGHT+IGVaY+XOzSCMMKYo0vk2NKxuiTvl/6LeynA4FnIc/ol95c2Kjx2OzRWhoDXoulGihOVWJhIbgtU2EjMVYvn7Rk=
X-Received: by 2002:a25:aa4d:0:b0:e16:6aae:e68 with SMTP id
 3f1490d57ef6-e166aae1097mr1635095276.20.1724249465228; Wed, 21 Aug 2024
 07:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
 <20240814153558.708365-3-jens.wiklander@linaro.org> <CAPDyKFprUeK2UiqAmLvMvZMhtOZa0zmCZ-Gbh_2n1kKF0iOXSA@mail.gmail.com>
In-Reply-To: <CAPDyKFprUeK2UiqAmLvMvZMhtOZa0zmCZ-Gbh_2n1kKF0iOXSA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 16:10:28 +0200
Message-ID: <CAPDyKFpX7=DGE8ERpt4ATM2XkgfZ2Tmi+QP-ozMJ6nVmgUeMEQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] mmc: block: register RPMB partition with the RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 16:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Register eMMC RPMB partition with the RPMB subsystem and provide
> > an implementation for the RPMB access operations abstracting
> > the actual multi step process.
> >
> > Add a callback to extract the needed device information at registration
> > to avoid accessing the struct mmc_card at a later stage as we're not
> > holding a reference counter for this struct.
> >
> > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > route_frames() function pointer in struct rpmb_ops.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Tested-by: Manuel Traut <manut@mecka.net>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> First of all, sorry for the long delay! Besides only one comment, see
> more below, this looks good to me.
>
> > ---
> >  drivers/mmc/core/block.c | 242 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 240 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 2c9963248fcb..cc7318089cf2 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/mutex.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/string.h>
> >  #include <linux/string_helpers.h>
> >  #include <linux/delay.h>
> >  #include <linux/capability.h>
> > @@ -40,6 +41,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/idr.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/rpmb.h>
> >
> >  #include <linux/mmc/ioctl.h>
> >  #include <linux/mmc/card.h>
> > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> >
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> > + *
> > + * @stuff        : stuff bytes
> > + * @key_mac      : The authentication key or the message authentication
> > + *                 code (MAC) depending on the request/response type.
> > + *                 The MAC will be delivered in the last (or the only)
> > + *                 block of data.
> > + * @data         : Data to be written or read by signed access.
> > + * @nonce        : Random number generated by the host for the requests
> > + *                 and copied to the response by the RPMB engine.
> > + * @write_counter: Counter value for the total amount of the successful
> > + *                 authenticated data write requests made by the host.
> > + * @addr         : Address of the data to be programmed to or read
> > + *                 from the RPMB. Address is the serial number of
> > + *                 the accessed block (half sector 256B).
> > + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> > + *                 read/programmed.
> > + * @result       : Includes information about the status of the write counter
> > + *                 (valid, expired) and result of the access made to the RPMB.
> > + * @req_resp     : Defines the type of request and response to/from the memory.
> > + *
> > + * The stuff bytes and big-endian properties are modeled to fit to the spec.
> > + */
> > +struct rpmb_frame {
> > +       u8     stuff[196];
> > +       u8     key_mac[32];
> > +       u8     data[256];
> > +       u8     nonce[16];
> > +       __be32 write_counter;
> > +       __be16 addr;
> > +       __be16 block_count;
> > +       __be16 result;
> > +       __be16 req_resp;
> > +} __packed;
> > +
> > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> > +
> >  static DEFINE_MUTEX(block_mutex);
> >
> >  /*
> > @@ -155,6 +199,7 @@ static const struct bus_type mmc_rpmb_bus_type = {
> >   * @id: unique device ID number
> >   * @part_index: partition index (0 on first)
> >   * @md: parent MMC block device
> > + * @rdev: registered RPMB device
> >   * @node: list item, so we can put this device on a list
> >   */
> >  struct mmc_rpmb_data {
> > @@ -163,6 +208,7 @@ struct mmc_rpmb_data {
> >         int id;
> >         unsigned int part_index;
> >         struct mmc_blk_data *md;
> > +       struct rpmb_dev *rdev;
> >         struct list_head node;
> >  };
> >
> > @@ -2670,7 +2716,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
> >
> >         get_device(&rpmb->dev);
> >         filp->private_data = rpmb;
> > -       mmc_blk_get(rpmb->md->disk);
>
> If I understand correctly, the call to mmc_blk_get() is here to
> reference count the usage of the md->disk. So when a user decides to
> open the chrdev, we are keeping a reference to the corresponding data
> around, until the corresponding file descriptor is closed and
> mmc_rpmb_chrdev_release() is called. We do the similar thing if the
> regular mmc block device is opened.
>
> If we change to increase/decrease the reference count from
> mmc_blk_alloc_rpmb_part()/mmc_blk_rpmb_device_release() instead - are
> you certain that we are still taking care of the above scenario
> correctly?
>
> I guess a test that opens the chrdev and then unbinding the mmc host
> driver should tell us. :-)

From your nice little debugging session conveyed to me offlist, you
have convinced me that this is perfectly okay.

Therefore, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

