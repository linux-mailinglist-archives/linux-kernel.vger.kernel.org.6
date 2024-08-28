Return-Path: <linux-kernel+bounces-304503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15C962106
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09410281FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD715A4B5;
	Wed, 28 Aug 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zR9UeuQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8315886C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830074; cv=none; b=SQ7G6si/Or208cyGhdLEV4DmaCrLz8T60BnF6KuTIRgc+W9y+DoGxGuvLQ2FJbA/f2ZDf2jNvmCtosvcy25lwhvUoxJ1qwFjSozp4MxGzbHwVaBTNsItsJ3UjhqFAH+zY5q7TcH6ESCA8eLS5CZxMNmSovMycrwdTHDKmDWdW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830074; c=relaxed/simple;
	bh=ZsIgy1EemRxIauFuNts3NoTT/iOwg6MiBEBjqlK86II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WICvtWH8OuiP7yzS+G2KjKVfDEiCjT67kxAPb/jCH+fNjBbkmrNsLMLc00W+CAc1hIof0nAl6mysgu5sUAKmagYnsXJBH5znoM2roFDR2RrXd9+WHtUBPpWZPtJQaJd1udu4xuzWlYKcoZbv1nlgTPKh3B3f2cfh9V8mTHO99Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zR9UeuQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8623C4AF0C;
	Wed, 28 Aug 2024 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724830074;
	bh=ZsIgy1EemRxIauFuNts3NoTT/iOwg6MiBEBjqlK86II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zR9UeuQVwbNMulsENNe/I4jMUNVS96oceAskVcb3wqLTqMUq7vpZIEpsfFLpNz9qI
	 k6cIfnPFZfheLEL+oi9r2GFOGMiz5u6Ny+xBvCpeq53RPjcQAj1fBGhmJq3Pz9WD8O
	 QGqj6eJfyGSGQ2o06H9WySz0sQ3RI3+YbGtxIolM=
Date: Wed, 28 Aug 2024 09:27:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de,
	Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH] misc: keba: Fix sysfs group creation
Message-ID: <2024082823-egging-shimmy-13d4@gregkh>
References: <20240819192645.50171-1-gerhard@engleder-embedded.com>
 <6630b70a-2383-46ad-b9e2-42454a537bad@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6630b70a-2383-46ad-b9e2-42454a537bad@engleder-embedded.com>

On Tue, Aug 27, 2024 at 08:27:21PM +0200, Gerhard Engleder wrote:
> On 19.08.24 21:26, Gerhard Engleder wrote:
> > From: Gerhard Engleder <eg@keba.com>
> > 
> > sysfs_create_group() races with userspace. Use dev_groups instead which
> > prevents all the problems of sysfs_create_group().
> > 
> > Fixes: a1944676767e ("misc: keba: Add basic KEBA CP500 system FPGA support")
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Gerhard Engleder <eg@keba.com>
> > ---
> >   drivers/misc/keba/cp500.c | 14 ++++----------
> >   1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
> > index 9ba46f0f9392..ae0922817881 100644
> > --- a/drivers/misc/keba/cp500.c
> > +++ b/drivers/misc/keba/cp500.c
> > @@ -212,12 +212,12 @@ static ssize_t keep_cfg_store(struct device *dev, struct device_attribute *attr,
> >   }
> >   static DEVICE_ATTR_RW(keep_cfg);
> > -static struct attribute *attrs[] = {
> > +static struct attribute *cp500_attrs[] = {
> >   	&dev_attr_version.attr,
> >   	&dev_attr_keep_cfg.attr,
> >   	NULL
> >   };
> > -static const struct attribute_group attrs_group = { .attrs = attrs };
> > +ATTRIBUTE_GROUPS(cp500);
> >   static void cp500_i2c_release(struct device *dev)
> >   {
> > @@ -396,20 +396,15 @@ static int cp500_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
> >   	pci_set_drvdata(pci_dev, cp500);
> > -	ret = sysfs_create_group(&pci_dev->dev.kobj, &attrs_group);
> > -	if (ret != 0)
> > -		goto out_free_irq;
> >   	ret = cp500_enable(cp500);
> >   	if (ret != 0)
> > -		goto out_remove_group;
> > +		goto out_free_irq;
> >   	cp500_register_auxiliary_devs(cp500);
> >   	return 0;
> > -out_remove_group:
> > -	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
> >   out_free_irq:
> >   	pci_free_irq_vectors(pci_dev);
> >   out_disable:
> > @@ -427,8 +422,6 @@ static void cp500_remove(struct pci_dev *pci_dev)
> >   	cp500_disable(cp500);
> > -	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
> > -
> >   	pci_set_drvdata(pci_dev, 0);
> >   	pci_free_irq_vectors(pci_dev);
> > @@ -450,6 +443,7 @@ static struct pci_driver cp500_driver = {
> >   	.id_table = cp500_ids,
> >   	.probe = cp500_probe,
> >   	.remove = cp500_remove,
> > +	.dev_groups = cp500_groups,
> >   };
> >   module_pci_driver(cp500_driver);
> 
> Hello Greg,
> 
> did I made some mistakes that keeps this patch from being merged?
> I think it can be included to 6.11-rc6, but maybe I'm wrong.

Please give me some time to catch up with reviews.

In the meantime, please feel free to review other changes on the mailing
lists to help us out!

thanks,

greg k-h

