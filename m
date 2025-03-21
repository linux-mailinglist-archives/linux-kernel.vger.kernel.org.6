Return-Path: <linux-kernel+bounces-570790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E196A6B488
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BA1484807
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E651EB184;
	Fri, 21 Mar 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="cljChQQM"
Received: from out0-213.mail.aliyun.com (out0-213.mail.aliyun.com [140.205.0.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B57184F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539204; cv=none; b=FlO8nrVNWRElqmN8Wn0owOSTEg+DFD15sjscIbHrXvDp9Pj2ao8b8rXo4//z00dokEUq1sVc79mtClQbNb0B7K9T0B0erE5g51F82ZHGlMMwloJmREMQiEXDgPUhBmPwPavp7cp+862DblNU5OyZQcFCPe+9MKhcjMBOC4TMMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539204; c=relaxed/simple;
	bh=CooyqoHO4hUs00h0ReZ12NGWWlOuDGXiYX53uof2eKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdsg/NOl1cYtaY9ZlglDQxm1JZQ0EbmyFPljaRz2MLJxG//fSAUE0O+W0537jEoSxIslzEn3pZUFbKepzeGS7u8eLaYbe0Qx68Jmi6vCmXT4OaE6HO/8G+B7d8YAfYd5grYZDg/k4jGPNmYiZNHiMCyrKkVaC5PgTLyCPhTe0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=cljChQQM; arc=none smtp.client-ip=140.205.0.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742539198; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=DBQboQbc3WGX1z3cTYc/o2gPUMTWBJ7I22LQVB8O2+A=;
	b=cljChQQMB34aBrOPpeYpa9wloXfnWAIT1FcEWXTcnHkmWVJbK1LigICISDKSN5/7YdaixhqZjPBM+dOHdYVZklLJQMflYi8SKm8CtmnbAob030yySOpNkoAlcRk5Dyc8lGhBUbqUwJqoAyRy9xfgSGvVaGgNmDjckSSpdia/Om8=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.c-P8Uwe_1742538265 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 14:24:25 +0800
Date: Fri, 21 Mar 2025 14:24:25 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] char: misc: Use __register_chrdev() to register the
 actual minor counts
Message-ID: <20250321062425.GA129980@k08j02272.eu95sqa>
References: <b63b7981191777a6d175cfa98379e987281b9e3a.1742528326.git.houwenlong.hwl@antgroup.com>
 <2025032054-stylus-chemist-1cd4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032054-stylus-chemist-1cd4@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 21, 2025 at 12:44:54PM +0800, Greg Kroah-Hartman wrote:
> On Fri, Mar 21, 2025 at 11:54:42AM +0800, Hou Wenlong wrote:
> > In commit ab760791c0cf ("char: misc: Increase the maximum number of
> > dynamic misc devices to 1048448"), the minor number of misc char device
> > is increased to MINORMASK + 1. However, it still uses register_chrdev(),
> > which defaults to registering the misc char device with only 256 minor
> > numbers.  Therefore, when a misc device is given a minor number greater
> > than 255, the device file fails to open in kobj_lookup(). As a solution,
> > use __register_chrdev() to register the actual minor counts to
> > accommodate this increase.
> > 
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > ---
> > In our environment, the per-cpu coresight_tmc driver occupies too many
> > minor numbers, which ultimately allocates minor number 256 for our misc
> > device, resulting in a failure to open the device file in /dev. I'm not
> > sure if this is a bug or if userspace can only use fewer than 256 minor
> > numbers. Therefore, I didn't add a fix tag here.
> > ---
> >  drivers/char/misc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> > index f7dd455dd0dd..dda466f9181a 100644
> > --- a/drivers/char/misc.c
> > +++ b/drivers/char/misc.c
> > @@ -315,7 +315,7 @@ static int __init misc_init(void)
> >  		goto fail_remove;
> >  
> >  	err = -EIO;
> > -	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
> > +	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
> >  		goto fail_printk;
> >  	return 0;
> >  
> > -- 
> > 2.31.1
> > 
> 
> I think this is the same change as this one:
> 	https://lore.kernel.org/r/20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com
> 
> right?
>
Yes, it's the same problem. I have replied to that one. Thank you!
 
> If so, can you provide a reviewed-by or tested-by on that one?  I
> haven't picked it up yet, sorry.
> 
> greg k-h

