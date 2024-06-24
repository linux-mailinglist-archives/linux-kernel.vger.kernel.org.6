Return-Path: <linux-kernel+bounces-227063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2F9147D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0031F23ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98041369B6;
	Mon, 24 Jun 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmJm1IUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D42F24
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226083; cv=none; b=TgMzyyOBsDtqOBuRahSyrX+cmHMThcD9hA5izmJLAcU1N+P6lhsY72PZsjBwtL5f4TkG+3lc7OuWyRWRt7xLousO06EJSFSPXy/Q5QHPKLRw4D+BTbr3nB2cPlfPw3zAr7P54hK1OUq4OVThkUrS1/I4Fz5OKMIsvr3TgDAVWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226083; c=relaxed/simple;
	bh=rWdKqF1Gqp1ZPtQjpQ3fFUqL0rZ5CWJ8Ga+INNkw4lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9IwHI6jovF/hzAbBq/wJV2N/ijokfLDUkTyFHM+7jzTMlCuthmbjX5SDN3+ofhQsaoP/9p83XrVjlTrNXTDxvNvGnyBrHh1JehBuznTWylAuIjaO/kfK+i1pzveO5Mx5CvokD7kv4mvA6qjmEOkw8vshiqYA05sAindh3iS1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmJm1IUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78DC2BBFC;
	Mon, 24 Jun 2024 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719226082;
	bh=rWdKqF1Gqp1ZPtQjpQ3fFUqL0rZ5CWJ8Ga+INNkw4lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmJm1IUF1c0qpkjPKXkExTkn6PWQaL9ogpgMcu/NT1wThSBrHApZ5nhpdEWOIwV87
	 6Q3Gl+BOT2v6Shnon67kIPI7KgXC3r54tzCn9Uvit5kIrTM7AjFGRVfdRCtpls4XQV
	 zFqxqqhk4Im0axBXsJPzVWfZKhSntAR5je8yiFt5biRn+tcks7fuRLD8VGzwqwPIIS
	 hg3Rc5uuv7k4nvl6B9NrT06bWLyzUQwKuJXVAJ0jnxUy4u6vcVMGteQejO+YE2cms6
	 dWZXlvp5vWrjCPqigd8LaoFYpKCoJvEKGKqIbw209tUDNxXmT2y7ywTjW0bq5Z006O
	 ZEKyqKqa7LPew==
Date: Mon, 24 Jun 2024 11:47:58 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Message-ID: <20240624104758.GP1318296@google.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
 <38a69a56697a80486067f7817d4d0ed3bdea4257.1718626665.git.matthias.schiffer@ew.tq-group.com>
 <20240620163552.GQ3029315@google.com>
 <b46e06b64ceb14c205f7c48871687bd283fce53d.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b46e06b64ceb14c205f7c48871687bd283fce53d.camel@ew.tq-group.com>

On Mon, 24 Jun 2024, Matthias Schiffer wrote:

> On Thu, 2024-06-20 at 17:35 +0100, Lee Jones wrote:
> > 
> > On Mon, 17 Jun 2024, Matthias Schiffer wrote:
> > 
> > > GPIO IRQ setup can fail either because an invalid IRQ was passed as a
> > > parameter, or because the GPIO controller does not support interrupts.
> > > Neither is severe enough to stop the whole probe; simply disable IRQ
> > > support in the GPIO resource when setup fails.
> > > 
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > > 
> > > v2: no changes (was patch 3/4)
> > > 
> > >  drivers/mfd/tqmx86.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > > index 5aa51ead00a28..7f9ccd83278dd 100644
> > > --- a/drivers/mfd/tqmx86.c
> > > +++ b/drivers/mfd/tqmx86.c
> > > @@ -259,13 +259,14 @@ static int tqmx86_probe(struct platform_device *pdev)
> > >  		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
> > >  				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
> > >  		if (err)
> > > -			return err;
> > > +			gpio_irq = 0;
> > > +	}
> > >  
> > > +	if (gpio_irq)
> > 
> > Stacking identical if()s one after another doesn't sound very efficient.
> > 
> > Why not put the contents of this one inside the one above?
> 
> The intention was to have the "else" branch be executed both when gpio_irq was reset to 0 in the
> above error path, and when gpio_irq was 0 in the first place (so the above section running
> tqmx86_setup_irq() hasn't even been executed).
> 
> I got a better idea now however - by initializing flags to 0 and only setting it together with the
> IRQ in the success path, no (!gpio_irq) branch is needed here at all. Will change in v3.

That sounds like a better approach, thanks.

-- 
Lee Jones [李琼斯]

