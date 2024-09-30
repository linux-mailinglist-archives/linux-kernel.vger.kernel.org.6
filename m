Return-Path: <linux-kernel+bounces-344661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5D98AC73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D736BB22C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F7198831;
	Mon, 30 Sep 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="AD2ZcWHJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D7199395
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722822; cv=none; b=oUpl9AkF9Zv/mbXZWeGdAA+Dkd5L3XOLcBXgdcWZ4SHDBJA7IEC1xrtMPB/k3cXRU1dD0tZePNaaflCVfJM8ZYqdmY3NHowEEMB5xufJXN4RDDQNnNLsDkLbM0rwJhKEvCC7vrycyYNq1o30dy9RbpEJnAdIRmOlY79BNdn+Pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722822; c=relaxed/simple;
	bh=UTeuYgMehmLJA/arPzgIQes3j/4SwwxcY8cev10CXXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBJLBO8GmG1Y6fp+0vjTCwRORJT4w+brcvWijCIFZqjhRGpyvz0AYUH8CT0ZkRYjBgLgWvIC06Ln8x/70WFRT1/axRObr6LEDWqlFV539fdk50R2f4XNONAkUkaiuYD//A4FP75o6wrdf21l8qBuwIk5rhGc5yMSC28KtCiSFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=AD2ZcWHJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717839f9eb6so567063b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722818; x=1728327618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=AD2ZcWHJT/Eh8QCoGwtR2mU/72Hn5PXbAqIORnZDyFQ12uCk5B6tgPR0gvJL4FDpmJ
         ulZzhaj/oQ9sKYNODSjhgVv94UWmTt9EA+rp3AZxM3D7FuMreK9zLBVPVKWu3uh3+yR+
         vy+EFC32Ma8cvowRGq+XAGeEadeMV+x3qYlOPzmGn6BqAD76WPYrQPop8bkeDhZ4ERpK
         1UNXgJ0vFc4lVx8afjUXBo0LvvB6Rd4zof4t3Zc6Vy61FsDUmw+QDwS60x7YioxFUGH3
         CoTsxWXSnHhGL7i7+cVMdkBzfJQ1pVAYBQUJy/0cBhT0hau1JKlewvZ94VVeJ6zOGv4q
         0Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722818; x=1728327618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=UbpvGYa8GZUb1lvaHVaSvG7plnnnvr2iht4CEV9sX0cDnRxEVBU0iltz6OZU1KXAUP
         1nvONfQQVsQ3Q7Ry7jd/uLlGeIBNuw7cOS+M9usFVQkwStyx7vg2iIDZ2/j+bqljhbpk
         B7kzTlP+m4xGKGX8wxkEgx8Qrx5vI0Xs7fKB3LiucUNsKXNjOqknM0PjrHuJ+vy93mDA
         fDMI+fHqDcYxQb35nLyC7L86UbNAcY55DR48talyiCNqG6lszMYD5Yzh4ItHNtTY1FZh
         +09R0y/acuHWAFLlfOzUXiAgPtSGWOw/A/30vfigH9RpZddrjeDtQi7NvKkxp+g7i3G8
         8qwg==
X-Forwarded-Encrypted: i=1; AJvYcCWb/DzA+S2+d6pH5VWmfz034rMXDsKF0H9RYtN9AZ+5OGZ/FClKwENsoiJU2Nq2P/RDKr2+5hkkjX8vG30=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLrMtCGjQvf0GuIR293n49YGR9g1bwKkgpzT2QXiw80Fq4SpX
	AIV0xw4S8EJiNEVQNccxXn+nlmwNUMybcgdD5zgoFtCaN8uCZzAPY7R4iGRkf6U=
X-Google-Smtp-Source: AGHT+IHr3t4octArrJkwK4KlggdiRYNEixY4E7CvOHzMJxxuBtEfGjyLTrjjT9DROP00qxEU234jog==
X-Received: by 2002:a05:6a00:2392:b0:718:e49f:246e with SMTP id d2e1a72fcca58-71b260a8a3fmr8397735b3a.6.1727722818090;
        Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652a622sm6544654b3a.164.2024.09.30.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:00:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:00:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Howells <dhowells@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
	hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
	smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <Zvr1PVRpC33aaUdt@telecaster.dhcp.thefacebook.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
 <2968940.1727700270@warthog.procyon.org.uk>
 <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2969660.1727700717@warthog.procyon.org.uk>
 <3007428.1727721302@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007428.1727721302@warthog.procyon.org.uk>

On Mon, Sep 30, 2024 at 07:35:02PM +0100, David Howells wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> > Are there any hacks possible to printout tracelog before complete boot
> > somehow?
> 
> You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
> dmesg.
> 
> David

I hit this in drgn's VM test setup, too, and just sent a patch that
fixed it for me and Manu:
https://lore.kernel.org/linux-fsdevel/cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com/

Thanks,
Omar

