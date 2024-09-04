Return-Path: <linux-kernel+bounces-316006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F292196C9B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72E21F28040
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16815B108;
	Wed,  4 Sep 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="schR7UBq"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E2148850
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486569; cv=none; b=icA8/8dA8TUnqLt2p9uB/9zBdc4Mhl4eEXT3t+vQ5k+heYbZAVJXIeadTsgxndaYLYvLqBjQsewgdbtz3GeMIYm6PGka9bMXJ3tdlxrqqxeR0llTFtrSFzkYmYr2LpL1pend8Jx6C6kgN+n6GH4LiU0nU+i99faWYQ345sfIQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486569; c=relaxed/simple;
	bh=+p2aRGs1g89kg4NdZi49Ns7xp/U9sMwGhn8KDIOcNd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV6G+o4Shjpo0J0/l6ZKhqswyYjWWvwFS3Sz8vmHIUtgvrhnAPobBJIdalo8A6GwUGU3doin3/f057+Hrsx0t0B/WcfX0qztr0mv/2XMwgzEZp/4kSJVhHZMTGLdIf518D/e1h4p5zoNTYZnR50P7M0IK8IE3QqE2YXL1hBYu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=schR7UBq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e017808428so77112eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1725486567; x=1726091367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUC+uQISGHQ5jVT1STade2cAcO2zC+t6ZT5+g59dS8w=;
        b=schR7UBq2+UXpuh1HZCgdGrxEhlSUUWcQ3amhsbFco/ahKxRCd7PT/ElVMXxdRa5FZ
         3ZKXSvDiUuZ6EDgfZlZkqY8rXv2khMxtPSU3YXYFehx6Vq20mfobNTR8ltQynxlYXTrM
         KoycAuY3gtkAqTrdl4tMApAkn3mEsk8aA4R56nm6DFTA2cwxPsbhQnBjTgqN4GnVkpVA
         lJ/3cRUrBvQWBVb5uc3IcotwPz49VXdIS0NrkL5TyJj0KMS3Nv4k+yHQTqMckcweHs0m
         9VxU7JxiiKTSMLMSvUysjp5QLhqBh/WBm1L3gNoEYldZa0PsYX2pg/QGB8QVi0fFuvp3
         IYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486567; x=1726091367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUC+uQISGHQ5jVT1STade2cAcO2zC+t6ZT5+g59dS8w=;
        b=unlogQdkSozR3MkIjYmgIc9DiCdxlTYJBt2BMkI0uNmSZhCANRkJE+XfkarJcT5qRG
         ekCOpglar8sDl/LP5ml3h+TFpbFNRiKKiE+I8yIoGT1H+EkLdVvJIIrNs6AZC+WKjEbv
         Lu4uwS343dZQ68pXgQay39k31fUeSgw2+mUEKEJIPqr5ETsecDgEMv92FvQX983NbHKu
         iD8+N436knqW65wWq7YtESMVaQ++MMAg8/D/P67XGTRYaRJaviRSoFUvlg/BdYsHhD7z
         uP5GF4Qt7zM4zbapgjVfSzR8pZyMX/RHpVUVTUiYyu9pxbgM8OejLf/BdmvO9yA3yyyR
         /QPg==
X-Forwarded-Encrypted: i=1; AJvYcCVID5uY5lY9F52DNRTXAmA5GqX4CCpLRzwmCHeciX0i9L8tvAkwqkjOUDYfXhgHaO5Wgs3U4hUzFKk2sZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/g43VNbXtlBGBlrWbQf6nTByCCejL2nRRG3hG95zD6MYLOVqR
	gUGLrwkm63pNM5JnXPIAUR1mAmN+GICcWYOjhRolCe7N5quLbDLul4RDY5/F8I7NlneOXOdnY4O
	JtNxMQw==
X-Google-Smtp-Source: AGHT+IEddVeItfFcf9pz4MFnAMr7VK+zsdERClwM2k4p8pf3Nz45p5Sd8jQeznKvm0aA1UymO2/9oQ==
X-Received: by 2002:a05:6820:168d:b0:5d6:c77:fb85 with SMTP id 006d021491bc7-5dfacc104dfmr19656292eaf.0.1725486566938;
        Wed, 04 Sep 2024 14:49:26 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ba64:652b:aeb0:4f05])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa05526c7sm2516413eaf.29.2024.09.04.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:49:26 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:49:24 -0500
From: Corey Minyard <corey@minyard.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, minyard@acm.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi: Use devm_kasprintf
Message-ID: <ZtjV5DoZXPYM1NJx@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20240904041213.53052-1-zhangjiao2@cmss.chinamobile.com>
 <004f59c4-7401-473f-b15f-02aa5151374b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004f59c4-7401-473f-b15f-02aa5151374b@wanadoo.fr>

On Wed, Sep 04, 2024 at 07:41:32PM +0200, Christophe JAILLET via Openipmi-developer wrote:
> Le 04/09/2024 à 06:12, zhangjiao2 a écrit :
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > Use devm_kasprintf to simplify code.
> 
> Hi,
> 
> I don't think that it is correct because __ipmi_bmc_register() is not a
> probe function ans is not called from a probe function. So it is really
> unlikely that a devm_ function is correct.
> 
> The kasprintf() you are removing is balanced by a kfree() in
> __ipmi_bmc_unregister().
> So you patch would lead to a potential double-free issue.

Yes, this is incorrect from a number of points of view.

-corey

> 
> CJ
> 
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > ---
> >   drivers/char/ipmi/ipmi_msghandler.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index e12b531f5c2f..5d78b1fe49a8 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -3213,7 +3213,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
> >   	if (intf_num == -1)
> >   		intf_num = intf->intf_num;
> > -	intf->my_dev_name = kasprintf(GFP_KERNEL, "ipmi%d", intf_num);
> > +	intf->my_dev_name = devm_kasprintf(intf->si_dev, GFP_KERNEL, "ipmi%d", intf_num);
> >   	if (!intf->my_dev_name) {
> >   		rv = -ENOMEM;
> >   		dev_err(intf->si_dev, "Unable to allocate link from BMC: %d\n",
> > @@ -3226,7 +3226,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
> >   	if (rv) {
> >   		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
> >   			rv);
> > -		goto out_free_my_dev_name;
> > +		goto out_unlink1;
> >   	}
> >   	intf->bmc_registered = true;
> > @@ -3237,11 +3237,6 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
> >   	intf->in_bmc_register = false;
> >   	return rv;
> > -
> > -out_free_my_dev_name:
> > -	kfree(intf->my_dev_name);
> > -	intf->my_dev_name = NULL;
> > -
> >   out_unlink1:
> >   	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer

