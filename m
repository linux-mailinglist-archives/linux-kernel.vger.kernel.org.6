Return-Path: <linux-kernel+bounces-332630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDB97BC33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6941F24DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1F18952A;
	Wed, 18 Sep 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BfnZLIWt"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5D1CD23
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662406; cv=none; b=sH1eTBOmOp0v1PXpmY6Hc6N0ZQFU5wKWhYCTSLPQupIB2DMwE+XBHgAlmmtqsxAsLUP8se1y0WK5qkIJcUBRIXrT7rLN3Vop/Rt3+MYNcST3UGosP8pVTG/7/1/VKbgVSKsZfcRSsNNV7o28KFllrnS5BR0MkI2VqTBHdzs0pCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662406; c=relaxed/simple;
	bh=owkSPE+N434gd412TfpJW7YM2i6bFDTs176bOwmFdnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLQi4nCK21jmTwbFjZP2z3RJXa7JOVMuxKu4zCcQQcWe77I+yTxe+ifjfhVg99uBaP8SC1LWU5SbeuR8GFWkRFpLsIJA3xSvgqUOtjHdeAJQjhRo7cI9UtYekIM3tHN0qCSdPJgdNJ19IT1yvkNq3dJ8d39p2l/EC1T4N3UPNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BfnZLIWt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f763e9e759so70186441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726662402; x=1727267202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgAU7H+QNm1aqh8qRj4zRQupf73QoF2RSPiKY8v8FoM=;
        b=BfnZLIWtPMVtg8mvdAmSKLG2WigkOeBljbFnHMjcd2y+MjLCkshxzD6oaGTDAUtMeU
         kRr1erKMaoFslWajD0Ewo/4ifNOH0BHviaiJdWAzVQDfmQ7IhoW3eih8WrzRGrQ+BCdU
         BOhimVpHisyjAgN90bSWi72Qt+0vtSjRCJGe1NUVHBIFy9jImBi9xACckuNNBcviKcyf
         wkx169+tgpTyOezoweqGP2dA09gLTWs/hk5BJAhh3Yv1B16vqE1GShhiBiUhVahlFxfw
         WjYazcawgVUeHmaX05I9yHvdwJIZFLD7sS8YaoL8o5DCpCselCF5qPWXK17MZOzMGABH
         0j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662402; x=1727267202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgAU7H+QNm1aqh8qRj4zRQupf73QoF2RSPiKY8v8FoM=;
        b=dyuU0t6tQe03ig8heSXKwrTS/MRJfUXHs1dG3mUgyLVLG03qRc7WOD7BcOyZCobTpz
         TrMa4Xsl0n54PwuIFG8kuR8EPsXknTQGbVcb4CbGoPFuL16JjQ0YKiKgPIxq89kGzeKQ
         STiIwTwI1YUqwCvZHH3wjUTLH4C2Xtwxhjsscvqr6QxLbe9ENu5O4/djUfR8OKW0u7LM
         kvw7O57s1VSqbC1e58fjln18/ipHiWdZOcLAmtN/+uLIR/0pJ4Hr+GmAvN8H7gHseDoT
         AKpoMG5vBxQXfkSNZ6ddz0zL4XQu6gHOYVnoiLLN2Kfvo7Nl4PMpRYZmsm9p/rWWUHe0
         SFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVbRfDQXijX8rj9imPU+bo/BjyjXD/xIXugC/1zx56lMjGrMW0LDQpKs/S8pZDIfuFeaE+fV1J9H4ovjTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwIjsm0+68hZI+0mCaa/JeDstnbKkAQs52xMkV/UjBOwP6hhE
	471TM1sFpetnQZ4IDDkK1/8Ox3ZPH8bsQQ53C7SaRxnM8fqbZc6Zw8jprPzks54=
X-Google-Smtp-Source: AGHT+IEC/F6EZ09kmQx5BVBSXoY98rkEXpb8znml9Z7Ud4EnUNW9fTdlXL3qQ9lBJjSySlTwEV3JKA==
X-Received: by 2002:a05:651c:2118:b0:2f3:e2fd:7dcd with SMTP id 38308e7fff4ca-2f787dad3f9mr116066101fa.6.1726662401814;
        Wed, 18 Sep 2024 05:26:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd609af18dsm1459973a91.40.2024.09.18.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:26:41 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:26:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
Message-ID: <ZurG8YMmBmVVxttj@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-4-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:37, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks (write_atomic,
> write_thread, device_lock, device_unlock) and add CON_NBCON to the
> initial flags.
> 
> All register access in the callbacks are within unsafe sections.
> The write_thread() callback allows safe handover/takeover per byte.
> The write_atomic() callback allows safe handover/takeover per
> printk record and adds a preceding newline if it took over mid-line.
> 
> For the write_atomic() case, a new irq_work is used to defer modem
> control since it may be a context that does not allow waking up
> tasks.

It would be fair to mention that it does not longer support fifo in
the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
("serial/8250: Use fifo in 8250 console driver").

It is not usable in write_thread() because it would not allow
a safe takeover between emitting particular characters.

It might still be used in write_atomic() but it is probably not
worth it. This callback is used "only" in emergency and panic
situations.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Otherwise, it looks good to me. And it even works fine.
With an updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

