Return-Path: <linux-kernel+bounces-326765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23A976CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B314281110
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80F1B9839;
	Thu, 12 Sep 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMypD5tI"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01391B6541;
	Thu, 12 Sep 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152648; cv=none; b=Ls+hFxubGu3Rmhx38f9LqnZW/1MSZSVtgJlRxfDy8G5DUvD1UCSeBJZexfaWf0GGH/e6zu5/T9z5o3i2AgggfwFevS45EUSLNrtyN0BEgIivEsTd8wsqydUzDy87YBAP5GJYuXrYXMV9g5ASFDknSyc1xPpcPgyizmJ4mH5JLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152648; c=relaxed/simple;
	bh=ayH+utA3EDdkSrZkZF7fyyNHjV7s38pbI+F2Y0qcPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHmnz0DSoUkVzd+R77R3qA7v67N6khPm+66EfRC83ocV1KvqbtU//iFegsILG/BT4m/XQKSpDVJer6X6cg6gJUXfhwOFnaKZrX69XU/MGeqdKsOG3dGc18T0cb7vDTrnEN/Oopuxyvbq5sLSkS7VsrPJvgqCb/TiwylC98e/9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMypD5tI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso883670a91.0;
        Thu, 12 Sep 2024 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726152646; x=1726757446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/1O0y+ZcovBucCacZFimGopfgJW1W3kqGSazoLLM6M=;
        b=WMypD5tIjLay3GelBlWTePeOOzIjjPqODk+JPF66k0Lx3owPwkoOfnnOwnS+CceqBd
         vFJiD7zFk7I6tbfMxq2nMJbi6ImScTWUHxVUOQd4YVVYHZNFgh9zVbpRTuosr1Ocflm4
         qufz+lD7bw6TXfdJ/SLvY60yfwKN9MeZXvpb9wuRkIHPVc7UOa6Asvifd9GYTQZ82Js/
         tkkaIkndiWlbFJ+PiywNoFOJU4MKNM2u1YnO8fGOx4jiYLW4gBC2bCOQ38Ud6iGv1Fcd
         AtkOg2+gX/Fu1uEw7K6a3p4lBkug4FzAwpAZW3MDszGtqHMwnJ+P3Fh7jcdyPQuBueso
         PDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152646; x=1726757446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/1O0y+ZcovBucCacZFimGopfgJW1W3kqGSazoLLM6M=;
        b=i5hvSOL5wjvl2AZb3b6ODHMSTd+rJ0HVcbOI7ECcyzwuKuJdn1k6cFuPepeh8GJ/hG
         AJAMXHrWYOxdVKpN5vN4is/d2GhQsuro8hw+MmJ3CS47T6/uRlh424ulv0FolXM+ifc3
         OYUAXC7F17RJhZ/NsJ4aeOvDVcqb4pZFca8hCgQnf1v0xxoeG9XII4KOUYfIoUqCEEML
         0vguiiuYQwlPE0kjcKG6E6abNvbdM3vPr7dwXY+ip4JXci416lvMMR9eyjwGoJb/QzFm
         M5LBcL5aYuno1yBTOpMi+tGwbhUki6cvgc1ZWRzxhDHY7JiAQk83mk3LEUvWDSaLDPgA
         hQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7V2WU1SgWdb24lHbNUDLSar5tYnEYlDu8O7e/M/BPNWtIYqnByjk7l7en/TjD5LVwbBXHuNKLb91z@vger.kernel.org, AJvYcCVvwLxgxrvGIaEFD92XUIZj/oPLauL0Ut8reyaBRbvQnv/KL4MosOTtoeHdq4t3tIBA9Q/ERsOU/tIjIsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOUCylKfVNm75IQt967Hk0L7ak1DCZskZUrmjJDkEgo8HfbYu
	R9G/bRTAnszXlqQCiZiAsKGJWCaG5nEnjxxNhV9SS/wHKImaWJtz
X-Google-Smtp-Source: AGHT+IFjcRQsP50gGkz963RmfFpuknI+lDTIV0qWQ9uuKZptDHcTYTXmrlSqWc2zir8P9uH9bkiq2g==
X-Received: by 2002:a17:90a:9308:b0:2da:d766:1925 with SMTP id 98e67ed59e1d1-2dba007f632mr3535363a91.37.1726152645657;
        Thu, 12 Sep 2024 07:50:45 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.232.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc040397sm12678925a91.25.2024.09.12.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:50:44 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:20:34 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, usb-storage@lists.one-eyed-alien.net,
	linux-usb@vger.kernel.org, skhan@linuxfoundation.org,
	dan.carpenter@linaro.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Message-ID: <ZuL/um0Pcm8o3Gox@embed-PC.myguest.virtualbox.org>
References: <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
 <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
 <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
 <f5d4711f-9b4a-457c-b68c-c2e9aefbe4a8@suse.com>
 <890e0ed1-25c3-414e-9e8e-f5925fe8c778@rowland.harvard.edu>
 <ZuI5nptdk+BcXh+R@embed-PC.myguest.virtualbox.org>
 <2024091228-bootie-name-4867@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091228-bootie-name-4867@gregkh>

On Thu, Sep 12, 2024 at 07:06:45AM +0200, Greg KH wrote:
> On Thu, Sep 12, 2024 at 06:15:18AM +0530, Abhishek Tamboli wrote:
> > Hi Alan,
> > On Thu, Aug 01, 2024 at 10:51:35AM -0400, Alan Stern wrote:
> > > On Thu, Aug 01, 2024 at 08:54:18AM +0200, 'Oliver Neukum' via USB Mass Storage on Linux wrote:
> > > > 
> > > > 
> > > > On 31.07.24 20:19, Alan Stern wrote:
> > > > > On Wed, Jul 31, 2024 at 11:34:45PM +0530, Abhishek Tamboli wrote:
> > > > > > On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I should make my reasoning clearer.
> > > > 
> > > > > > > Replacing the variable with a constant won't make much difference.  The
> > > > > > > compiler will realize that bl_len has a constant value and will generate
> > > > > > > appropriate code anyway.  I think just changing the type is a fine fix.
> > > > 
> > > > While that is absolutely true, it kind of removes the reason for the patch
> > > > in the first place. The code gcc generates is unlikely to be changed.
> > > > 
> > > > We are reacting to a warning an automatic tool generates. That is a good thing.
> > > > We should have clean code. The question is how we react to such a report.
> > > > It just seems to me that if we fix such a warning, the code should really be clean
> > > > after that. Just doing the minimum that will make the checker shut up is
> > > > no good.
> > > 
> > > With this fix, the code seems clean to me.  It may not be as short as 
> > > possible, but it's clean.
> > 
> > I noticed that the patch has not yet been pulled into linux-next, 
> > even though it has been acked-by you for over a month. Is there 
> > anything else I need to do on my end?
> 
> Yes, please resend it, it is long gone from my review queue, sorry.
No problem, I will resend it.

Thanks,
Abhishek

