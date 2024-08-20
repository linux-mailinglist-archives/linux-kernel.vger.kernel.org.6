Return-Path: <linux-kernel+bounces-294158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8588958A16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2991F21A25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713B1922F9;
	Tue, 20 Aug 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS19oGSe"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FF1922EA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165275; cv=none; b=CdPepUqq0oTH8LxEXf2pjB0OmCjwUgegTryhkS1Jp3+KmMiFnYCozAI5sEzXlh+RvVSytMpo8oJqEY9gaDOJkfLaUJpQafQBwkFna5EEpQ1x8DilC+TUFSYoWLYOGq/q7ZI2MTiEg2Fa1LEfkFIz8sX8AGr6yoEDkssljxYj1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165275; c=relaxed/simple;
	bh=IXcYOmV5hvPnY8iDlrXzSqwkCSMDQ/hhHntQ4if1F6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSvMT4OCeGRY/sHk28evsOHYC2tJFsczEwex3WjSEazEYbGMrlDHcSV4A1qIpCoQ1GxXu4DAmv3/pGjRhB9C3EiasPR+K5NlgL60BuRN7g+ocvpuN6qJH/00ybLmnbl/kx+yVSonsKs8FP8n1VJeWaaXoOn+NYwU1eZAyZM0KuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xS19oGSe; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e162df8bab4so2204173276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724165272; x=1724770072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IUOLV3nrydguHU1qvPpgc0NsJ90ZCkVLHRrZwycCbs=;
        b=xS19oGSecofzR3n1kNyf4hvjqFvxh1DLUF/PlnT+P/9RUhjwoLNVK2Wt1E1tw3Ehuc
         E11b+FwzkUsUzt85shOgzFvv5cehFGvZK+ZBHcEcnZWIDzOPCAxuZJ4a97Je2MdCKKCA
         zuXRpQSfvYneflUYlz2z76TJuItbZqddpwuicvIZEwbwd9x9yYRPSbZWDymZW/vIMSTH
         0lXZnQMlvJ8mVBnXpr0B0cZJuo7wsdLgSVI/6vn1HfeBuLVoIhGa/SOjamwZBKy1eJNX
         t0fPqLdAdY21jjRL+zZMwK7VEmW+m3b2gh646uLHJJLL+IBS/rqYLmuJroROMl19ApoF
         Uerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724165272; x=1724770072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IUOLV3nrydguHU1qvPpgc0NsJ90ZCkVLHRrZwycCbs=;
        b=Drhv5DBsg3n4Fw4ljeDeV+yqEuemyobeREnB22ZumqZMjcPWEktM9YOvVcjaD6JIQJ
         NwA5SutL+x5u/cncEEKliSghV5j8sadsOjd5QIhUC8mkSFYzdVd3qHw1Dmeg3XZUKdXU
         2yJ6zwyyfhZl3UzIeDqVUPYKhrWZoB8oVtd2sINTSASC3LXkNc/yMSWNaxdLm/4fWKxc
         9Ky3oBcMt1RuWjBSvQNSNvreVW1rargiB1Gf6lO8zpvbFCekZh2lWZ6JShBSqkrmZh1+
         e2Y1cLvI8x/fzzv0KNSjtAwk44kC2V4NXH52d6yDqXNHfDaD9yI4c3c7HsXaEzERdEzC
         Gd8w==
X-Gm-Message-State: AOJu0YzR3+F+StfPXyuPpDek+F7oz6yB7+sZ4r72CWlNLYPS0QfrnMx2
	QwV2djKNCPcvrOquysQIu4dE98TOITZHdnNQfkS56uQP4PVPjTqsNykQIMIDd5FW+D9/FnrMhQu
	iCXP3dfq/LLrb0JZ2grcWKZJyAtPi4dJ/gIiunV1E59Y8qjirvy0=
X-Google-Smtp-Source: AGHT+IEagz0VyWYkn5A9+jZQvXGnQ1ruWhwKyO56i80HjABaxtFw/72bqxIzy0jpSc08iiMA+j3DnR1GDV0fP5e2kjw=
X-Received: by 2002:a05:6902:2508:b0:e13:d0db:308f with SMTP id
 3f1490d57ef6-e13d0db320amr13470570276.30.1724165272352; Tue, 20 Aug 2024
 07:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org> <20240814153558.708365-3-jens.wiklander@linaro.org>
In-Reply-To: <20240814153558.708365-3-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 16:47:15 +0200
Message-ID: <CAPDyKFprUeK2UiqAmLvMvZMhtOZa0zmCZ-Gbh_2n1kKF0iOXSA@mail.gmail.com>
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

On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Register eMMC RPMB partition with the RPMB subsystem and provide
> an implementation for the RPMB access operations abstracting
> the actual multi step process.
>
> Add a callback to extract the needed device information at registration
> to avoid accessing the struct mmc_card at a later stage as we're not
> holding a reference counter for this struct.
>
> Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> instead of in mmc_rpmb_chrdev_open(). This is needed by the
> route_frames() function pointer in struct rpmb_ops.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

First of all, sorry for the long delay! Besides only one comment, see
more below, this looks good to me.

> ---
>  drivers/mmc/core/block.c | 242 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 240 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..cc7318089cf2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -33,6 +33,7 @@
>  #include <linux/cdev.h>
>  #include <linux/mutex.h>
>  #include <linux/scatterlist.h>
> +#include <linux/string.h>
>  #include <linux/string_helpers.h>
>  #include <linux/delay.h>
>  #include <linux/capability.h>
> @@ -40,6 +41,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/debugfs.h>
> +#include <linux/rpmb.h>
>
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
>  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>
> +/**
> + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> + *
> + * @stuff        : stuff bytes
> + * @key_mac      : The authentication key or the message authentication
> + *                 code (MAC) depending on the request/response type.
> + *                 The MAC will be delivered in the last (or the only)
> + *                 block of data.
> + * @data         : Data to be written or read by signed access.
> + * @nonce        : Random number generated by the host for the requests
> + *                 and copied to the response by the RPMB engine.
> + * @write_counter: Counter value for the total amount of the successful
> + *                 authenticated data write requests made by the host.
> + * @addr         : Address of the data to be programmed to or read
> + *                 from the RPMB. Address is the serial number of
> + *                 the accessed block (half sector 256B).
> + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> + *                 read/programmed.
> + * @result       : Includes information about the status of the write counter
> + *                 (valid, expired) and result of the access made to the RPMB.
> + * @req_resp     : Defines the type of request and response to/from the memory.
> + *
> + * The stuff bytes and big-endian properties are modeled to fit to the spec.
> + */
> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +} __packed;
> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> +
>  static DEFINE_MUTEX(block_mutex);
>
>  /*
> @@ -155,6 +199,7 @@ static const struct bus_type mmc_rpmb_bus_type = {
>   * @id: unique device ID number
>   * @part_index: partition index (0 on first)
>   * @md: parent MMC block device
> + * @rdev: registered RPMB device
>   * @node: list item, so we can put this device on a list
>   */
>  struct mmc_rpmb_data {
> @@ -163,6 +208,7 @@ struct mmc_rpmb_data {
>         int id;
>         unsigned int part_index;
>         struct mmc_blk_data *md;
> +       struct rpmb_dev *rdev;
>         struct list_head node;
>  };
>
> @@ -2670,7 +2716,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
>
>         get_device(&rpmb->dev);
>         filp->private_data = rpmb;
> -       mmc_blk_get(rpmb->md->disk);

If I understand correctly, the call to mmc_blk_get() is here to
reference count the usage of the md->disk. So when a user decides to
open the chrdev, we are keeping a reference to the corresponding data
around, until the corresponding file descriptor is closed and
mmc_rpmb_chrdev_release() is called. We do the similar thing if the
regular mmc block device is opened.

If we change to increase/decrease the reference count from
mmc_blk_alloc_rpmb_part()/mmc_blk_rpmb_device_release() instead - are
you certain that we are still taking care of the above scenario
correctly?

I guess a test that opens the chrdev and then unbinding the mmc host
driver should tell us. :-)

>
>         return nonseekable_open(inode, filp);
>  }
> @@ -2680,7 +2725,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
>         struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
>                                                   struct mmc_rpmb_data, chrdev);
>
> -       mmc_blk_put(rpmb->md);
>         put_device(&rpmb->dev);
>
>         return 0;
> @@ -2701,10 +2745,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>  {
>         struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>
> +       rpmb_dev_unregister(rpmb->rdev);
> +       mmc_blk_put(rpmb->md);
>         ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
>  }
>

[...]

Kind regards
Uffe

