Return-Path: <linux-kernel+bounces-396875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF19BD37B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B081F234D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E021E283E;
	Tue,  5 Nov 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="eO6tBfAc"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9671D7E35
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828207; cv=none; b=sUkGKUVLhTWACiOCchONJwYI9U+DAYby/cbdxg7LRPyh8kg1oSOw2MEvJnyFmcMx/nOt71iJMTVvgvpLzEeIeint+j8ONnHsNWvTznEgXx8vb2YeYFt3gGWyytz6Ns+5MYax/L9eGOeQBrY/jbz16Hcq/Qd93j9wW6f6Lt0/cCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828207; c=relaxed/simple;
	bh=wlUvfcxYFaki82NqoqzxEqV8ERNXMiI5uZ3ZUKx8jfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcXTgAEhP3JiCpUv00NYsqhe9vBD3l3Mq92jwAm6Bb9oRIWlVHZVj690Gy0hjhaZP8ruItMCIMCbIYHgDwDhIdeekBae08/eYtkVTqQxxZGLwfzli3lr/Zsktq2V+i1GbpoMluWX7lzhYoJMrortCYiz98KW7CowSdfssyc93UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=eO6tBfAc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720c286bcd6so4795745b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1730828205; x=1731433005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zk6qNKgyraSMC1CLlZkY+ZTrEOnoJclzOJZ98l693Rs=;
        b=eO6tBfAcFGlBwXtN2ePOU0rUCOBmYqEpfky4haas/IxWZmtEhS2sxVjbFdhHQy6nn1
         GH28FJPnuLgM1ZmOtJY2yW/ddzYBmACzfBKcgJAf2eMsJaJBL/vp+UAJ41BUEFL7Ns4O
         Tp45IL4TdgtU37a0T846NHIMuxcWdL/bWDK0mQTgVw+CYsV5aX164BT46Cny8TGlPcLo
         1Gc7XYAM9bfI/WO1saGiFNYx4nsDK7O6VMOcTkohiydqRuNVvnCN4mSir2WwCsaL3N6H
         OfVxSHHRBrCjV7TXjBE9n9gbGPB/cPQDx6R/Jc18hKgJ6HzqLp51K8LH+ShWPBM6U7i3
         ZWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828205; x=1731433005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk6qNKgyraSMC1CLlZkY+ZTrEOnoJclzOJZ98l693Rs=;
        b=RniXpjMs/+G1zBUm7KDa+nsZsl6hkeU4Xic+gHJRlhty9fmXsVv7Ea9bX2svfXlmBG
         NjxWn6w5LJiMAxz3SC+In1n/okvoYvuZVP17g204SPGBUTXmKBJ+Xa+xHlLqs5gRvA4n
         B9HF7ImWuJL1s+AmSsweDpsUTBjvQ5DCVjR19CbF8S/o0zQqk7cCEjTaDKRsm9pPalu+
         BiD4DjihPuxVFZa65pykyKLo7l55n2uY1o7G8NJRMuyXep3iuftTv7psAmtXS1hsglwY
         BJ9Rko52TuZDSVFl+6QlruIgeBAhSwTJlCBKHX/axXPCVsvMbnqU87AqzNZlXmEY/at5
         v/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV1LPU0cy555+9Kl0aIFdejv+t7XjOiakMqH94qViX3/Pcrgp+br9UWtM8ipPIk7mNiDxv3pK5yQh8sckU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQdwn50RNesHS+sjCFoXOCKvlj93o0LCjReT9p1502dxBIgrv
	uMXHXsAOpo2YRY8Sdm900aVZK7lRXceci5Akes8gdC205BLh4x7gcx0fNY/u8+M=
X-Google-Smtp-Source: AGHT+IGXoaxgWbe46iVHnktYjRfWj/uMDtxswKkYEPwup6IDufYCzGM7npb9iAwx/F9Zb0ymyaeGFw==
X-Received: by 2002:a05:6a00:1742:b0:71e:722b:ae1d with SMTP id d2e1a72fcca58-72063059df3mr46329848b3a.25.1730828205156;
        Tue, 05 Nov 2024 09:36:45 -0800 (PST)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c390fsm9876529b3a.110.2024.11.05.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:36:44 -0800 (PST)
Date: Tue, 5 Nov 2024 09:36:43 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] pps: Fix a use-after-free
Message-ID: <ZypXq1Q0SfiFTOjX@mozart.vkv.me>
References: <2024101350-jinx-haggler-5aca@gregkh>
 <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>
 <2024110551-fiction-casket-7597@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024110551-fiction-casket-7597@gregkh>

On Tuesday 11/05 at 10:44 +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 04, 2024 at 11:56:19PM -0800, Calvin Owens wrote:
> > -	dev_info(pps->dev, "removed\n");
> > +	dev_info(&pps->dev, "removed\n");
> 
> Nit, when drivers work properly,  they are quiet, no need for these
> dev_info() calls.

I'll change these to dev_dbg().

> >  static int pps_cdev_release(struct inode *inode, struct file *file)
> >  {
> > -	struct pps_device *pps = container_of(inode->i_cdev,
> > -						struct pps_device, cdev);
> > -	kobject_put(&pps->dev->kobj);
> > +	struct pps_device *pps = file->private_data;
> > +
> > +	WARN_ON(pps->id != iminor(inode));
> 
> If this can happen, handle it and move on.  Don't just reboot the
> machine if it's something that could be triggered (remember about
> panic-on-warn systems.)

It's a fairly paranoid WARN(): it's a bug if it happens, and I don't
think it can happen. Should I remove it?

The test-robot found a couple *pps->dev dereferences I missed, I'll send
a v4 in the next day or two with those fixed as well.

Thanks,
Calvin

> thanks,
> 
> greg k-h

