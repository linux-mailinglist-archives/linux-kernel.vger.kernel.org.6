Return-Path: <linux-kernel+bounces-441606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DC9ED0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2501886D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7851DAC8D;
	Wed, 11 Dec 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="brFS5u1K"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCC1442F2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932858; cv=none; b=QatjXkhNj81hpaDdgogBSLwRKjm6EsRifZOG8z4nmLwAb3ocd/HyJ6VuMYPm7Bwl32pXoMigBzXa8G9JOXMh6net561fFQLVJjYmYmleLQyIS6AwzD8QayD4a1GVP9rtHiWfmbW6iHYCKTZSgOuuKPW239ppMSIqATzSg6yk8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932858; c=relaxed/simple;
	bh=YVeA8O3i7Y8Q1EHeW6JgR9d59C4yRq8yEHlcS5ZMdnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewtU61vCHqdgGc05mJ3M0QeM+APDzI+8y/nazaCnTgPrZ1FZlsF2Q/LSW5+62rf4wuiY9dQSOOOtEjTqE5Ocm86u3hy26n3jrSmwmuCeR6S4vQbKXLKWGlNhyhpFOin1dgw1rkO8Am9dhtstVvaj4IAnevM1j4hUW0UVngJw37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=brFS5u1K; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e4d38185so140419085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733932856; x=1734537656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV9Ft1tIX39VZGq6X6Q++chZExuhbKDUHOANQjurrlo=;
        b=brFS5u1KiTmZq/Dy27QjElP0PvGhgkk74zWU/gyyZuWdSnn2JFWPTqYE9d0+uUUSo1
         nWjVVLD20EIHbPAxfV9BMzYxW/8+BSvJAhJEdCAnt3K2ak/X2vLBJCQGrNBUj3P6I3Hl
         yzA3Ruty8NWwCDIbl20zlLOM6oM9jIgrp9USnkfkuJSCLyrE1c1uMoB+ue1CcUR5fMwB
         IrCx8DCus/gaHxUm89T9NqRlFkvbQvDEsPKCYGF+cEh3pVSxT8o3EVHsaKpYIw75X9nY
         qS+Ax8eG50iat8uNXUFS30nsA6IeTAyUaF7D5SFRM0YOEyuHRdbdlGqjCswPyn+Kl+5m
         Oc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932856; x=1734537656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9Ft1tIX39VZGq6X6Q++chZExuhbKDUHOANQjurrlo=;
        b=VQ+VVLmYqyhqTPpXBPQGa6kw1hSuAWskimjDml6VpwlUNrLk4eBRIoVm9meM2aFKAB
         z50WQn2tw6eb6BL4OPfgzONJskDq9kPPHn4Y6P8w7RvVJqXPD6Bgyb1LY4coZqqO6J0W
         +P/IN1G+OvtOFPfXn49CXfEglI6Nmw4bdLWo0hIXHvQIv1HXsOm74eDymLXUNt+oRspV
         khPQQorvg2TxVq8GL+LG+TrhoXH8f3KH579Vm5f0OoPYO5Ic0sgEX4f6g0Hn7jXVg+10
         NdfdDako5aFSZVziNnwn8tV53lOWMVHC4wZHkqZdOdnZ4EDhstIlmHDdeEbHtfX2RdJs
         4KNg==
X-Forwarded-Encrypted: i=1; AJvYcCWAy0/xusYXmv2W89ysltjGv0WAQwocr7QgNSyBbbtpows7mN62cX8qDWY/DWK34zrrqAdwl2xtkAZUhps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMgnLJqwUJNP7Fo8GTNPp6xw1FCFMIO09+1f1i/W5qRM1TmSF
	oD8I2A+NR5vsHU6YgcYnLoClpO0+0eghEv9SU4LfFh0znk4nIgHLaneEhSDmTo4=
X-Gm-Gg: ASbGncukfIsSnUjNFBVX2Fk5T6mLyRhGdzn0G4+KbgifJODU65Ks4BxRUD7u1if3p3B
	gNsjkc9LY1ESt/eDkDFbhwHlXnmc/0a8YmvbWsKzgMVkHs0Fo2guyEgdo6JnebTf+BnGTgmuiNX
	a8mFlYmvm7c+xRoKmUy0BqdKSodn56H7hR9H0jKAi6L/Amp+BIOGd+hs6IppsZ0sAS6mt7SdK42
	UMOJVSrRcdIlUmbr87LtvnlVuJ/sdQCMVnQPwzeddI84S+UC29K6nujtymAXAy4srKxenabxB6g
	vNUNDncTjBSfAoXs3m13SmlWTtI=
X-Google-Smtp-Source: AGHT+IF0blHLPw5V1rIaiMGPynlooTCXklunTpSd4ZXC/5lxcxc+hoeJtBja2c6cayFi/JFjdMdhAQ==
X-Received: by 2002:a05:620a:4088:b0:7b6:d8da:90a3 with SMTP id af79cd13be357-7b6eb525549mr660409285a.44.1733932856267;
        Wed, 11 Dec 2024 08:00:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f08580b4sm24160685a.11.2024.12.11.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:00:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLP8x-0000000ADwB-0ccP;
	Wed, 11 Dec 2024 12:00:55 -0400
Date: Wed, 11 Dec 2024 12:00:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	zyjzyj2000@gmail.com,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241211160055.GM1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <20241210175237.3342a9eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210175237.3342a9eb@kernel.org>

On Tue, Dec 10, 2024 at 05:52:37PM -0800, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 10:56:27 -0400 Jason Gunthorpe wrote:
> > >  struct siw_device {
> > >  	struct ib_device base_dev;
> > > -	struct net_device *netdev;
> > >  	struct siw_dev_cap attrs;
> > >  
> > >  	u32 vendor_part_id;
> > > +	struct {
> > > +		int ifindex;  
> > 
> > ifindex is only stable so long as you are holding a reference on the
> > netdev..
> 
> Does not compute. Can you elaborate what you mean, Jason?

I mean you can't replace a netdev pointer with an ifindex, you can't
reliably get back to the same netdev from ifindex alone.

Jason

