Return-Path: <linux-kernel+bounces-175303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7A8C1DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7B0B2154B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D415E5D2;
	Fri, 10 May 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lc9/js3I"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9812DD88
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320440; cv=none; b=Vje6OhI7JuGvEMA2j8KWY9u7n30+N+N7q7R6LYD8XYJ/Iy6f5Re2qAjyIJuqXQBGz7TpVPzDCbDW4rtiFSMZEHeNjRVo0wE66VtaNHYvY/fZn6r9YP9Jhhchnjj+OOM7U/P3FcPR3rGhXDYjzo9WInXT8gzqORf2+KVJEjAtAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320440; c=relaxed/simple;
	bh=4PEitjlgb+KO6v9/1VnUNw8pVTM6GDPJ4mUKQsGr/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQLy5eUgbGNlxvpoBancXQezrTV4nZkVgHPFvJUYBL/kgmP5i+4wPZK3PbmWq4gHOLcE4Q6hVVhWxWZAqe5AAbi8yzUkhnSmBjeBSZz4+3W3vzGetsOSdLWIfcXN1PC8depyH+aE3uKmPAZ9SYgL6wGZFRr++skOKYmw1Gd954Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lc9/js3I; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA3DB3F366
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715320435;
	bh=pb53mmGBdA39Om/S6gifWUIT/OZjQtmNrFO1eNmJ+LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=lc9/js3Igi2d+FF9o7mqGr1bWPXeF+NVTbzNHdvfAMidNges6cXEmNKSGevcQ/4pM
	 IklAiEzrQGPOwgst6GRSlK9ry19SC9rYeJN/hLFjoD5Xd4nJWICTGO3u0uXpGOzvrc
	 CiO+K2Kgpnew8vRm8YquRNA5tF4QH8uRYrg50eMkCLVLlfXbR2sJFS7CucTmr6PZgH
	 Q/D7Cg/uALctuoEDkzFMLWJtJKna0FX93CkJSJ/EV2Zt5iSmb9BQDAq04WJrgnSLso
	 XwrPCnNEJrkahJN7MjZpcI+xtx0TcKWYBCiqdEijFONaeL9h54EcFs58GUpIUW3tYR
	 83YAaiON74HbQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572ef3eb368so635636a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715320435; x=1715925235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb53mmGBdA39Om/S6gifWUIT/OZjQtmNrFO1eNmJ+LA=;
        b=C7JKxid8BsSIF86Td/DwVYfNAdV2xyyQADWqRPpGmqIEc5CXIlnqBSkhMSTIWQoWyd
         IjkNSwrv1oKwVu4N9X7GHj/AWWm/5fPFoKaq7D3v6wO/oamkJLhEXnfJsoDx/TOGcDXX
         4yLhqjutCpE58yY2B0OwEYkCTrEvsye2cseJCZCi3kDR1o2043/E2spaqMYX0iBt5WWw
         G2FzsLX89ihSp36kkd0UIgsk48XxcMhzxAdRb0Hld7SldCkz+tFcO7/yN4H2XzLu7+Aj
         KvAaaRp6n6E5Ald03ZVERRmDqCQL3LVShZSKhFpjwLELTwYSLHSTvLGrh45aFchJIUp+
         +UhA==
X-Forwarded-Encrypted: i=1; AJvYcCVr3YzK1px98Ur13MC7wGGVsdjgu7KbnZcVdc6bAJTmNBQ4zZhW728TdhFwqryCrq7nb69uPr9bccJa4yuYr8quIBwT/+SnHh+TkILw
X-Gm-Message-State: AOJu0Yxvkqu5xm2KAftEyThr8zsNVxtxMwmhlrPhFyT6YoTWvxs+F1Xh
	rfe+TCQcKYeDqyjYjuPMTxxBUWH+0GaUQ+Vx/4Swg1CVyA0o57mfRH0OaXneBAnQTHm7dXacFIB
	9RTfHI7nn3OYa+XhyYkG8uPJeuipVT1zaIFIZFT3pycRzXkAETutddcHOtYpL6Xs8VXANL2ftb1
	bEVg==
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id 4fb4d7f45d1cf-5734d5c1692mr1161727a12.7.1715320435059;
        Thu, 09 May 2024 22:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUERLBxoc5gVqjALyHDp2f85+2hPeKHWBMU3eKKrua9AkiVLI6CvgwDj1X1kdppOmcHMa0VA==
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id 4fb4d7f45d1cf-5734d5c1692mr1161698a12.7.1715320434315;
        Thu, 09 May 2024 22:53:54 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c3229b5sm1436042a12.79.2024.05.09.22.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:53:53 -0700 (PDT)
Date: Fri, 10 May 2024 07:53:52 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <Zj22cFnMynv_EF8x@gpd>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <1567252.1715290417@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567252.1715290417@warthog.procyon.org.uk>

On Thu, May 09, 2024 at 10:33:37PM +0100, David Howells wrote:
> Andrea Righi <andrea.righi@canonical.com> wrote:
> 
> > On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> > > Use netfslib's read and write iteration helpers, allowing netfslib to take
> > > over the management of the page cache for 9p files and to manage local disk
> > > caching.  In particular, this eliminates write_begin, write_end, writepage
> > > and all mentions of struct page and struct folio from 9p.
> > > 
> > > Note that netfslib now offers the possibility of write-through caching if
> > > that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> > > v9inode->netfs.flags in v9fs_set_netfs_context().
> > > 
> > > Note also this is untested as I can't get ganesha.nfsd to correctly parse
> > > the config to turn on 9p support.
> > 
> > It looks like this patch has introduced a regression with autopkgtest,
> > see: https://bugs.launchpad.net/bugs/2056461
> > 
> > I haven't looked at the details yet, I just did some bisecting and
> > apparently reverting this one seems to fix the problem.
> > 
> > Let me know if you want me to test something in particular or if you
> > already have a potential fix. Otherwise I'll take a look.
> 
> Do you have a reproducer?
> 
> I'll be at LSF next week, so if I can't fix it tomorrow, I won't be able to
> poke at it until after that.
> 
> David

The only reproducer that I have at the moment is the autopkgtest command
mentioned in the bug, that is a bit convoluted, I'll try to see if I can
better isolate the problem and find a simpler reproducer, but I'll also
be travelling next week to a Canonical event.

At the moment I'll temporarily revert the commit (that seems to prevent
the issue from happening) and I'll keep you posted if I find something.

Thanks,
-Andrea

