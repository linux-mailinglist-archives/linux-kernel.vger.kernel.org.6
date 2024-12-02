Return-Path: <linux-kernel+bounces-427856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C79E09F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C19B3627E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D2B2101A7;
	Mon,  2 Dec 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F4a39eXT"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECB20C001
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152355; cv=none; b=cirSJZ/rudFOBTOdUGotAzprUxWzjMmshFXcIcf3Vu3b5514M084OaFqEyeMOxmEBrYpDCSh5iOlSuRBs/4t7yZgdxc6JB9i4Q+i20qL7MqRXqpV7qK8GbSiz817kwOm+PyiOYHXpqMDE92SCneeOyKGUhBgL+sJbPZwFqI0nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152355; c=relaxed/simple;
	bh=GsoW9jar33QFlPyu/o1BiPaUWwEOUgAaeEeggWZ8yM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGasTU/mPn3Yd41FANCHSHTrlR/FWd/JYpa7nrSuCgQgIvIF1sd5FmqnrvAlKSexUGHnGLzmXQPlhe1BwyvBQNICjTIviqlrD9ocZY9uYjsK0cxFXntppfKVGYluG/QFyViT4lkOS+cwk8ajgKawZ87vlQURnVHGSmb5RzIxDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F4a39eXT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b673aacf13so463010585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733152353; x=1733757153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XySwqa6vfF7/NLOEDfWEU6s1YzlqvfeDKk1Yx5q6yxw=;
        b=F4a39eXT1+yYRrKpobXRA/bwip8nTcnmoM8INrY4D5ZE9y3/T3OV3CjrQfymqeN/nh
         2NA+kFzTRMrQ3CC1lkzSV/CWGtJ+IxFOMZ+YayPiF0FA6tOrf3TqBD/jbDG8837uCta+
         1WS/HH153/B6ix2oh2bioqc7bxWWxG4EwreNedS1hGN6U9Bwlg/MIoAGLWP5AEQan0Fh
         cibqF1ONcWm3Wa0sBCH9rpDYK2lmMygoTbjpuQDvIk6eaPG/akIYQ3arga87HOyd9xfM
         49cRqs0LHp48G3ba+s3MzXSqLa5bCAW8PtF89r0t/Q4cqxIfLjpxXFjfKL/iZ0a1hcce
         Fs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152353; x=1733757153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XySwqa6vfF7/NLOEDfWEU6s1YzlqvfeDKk1Yx5q6yxw=;
        b=sVDs6yOWS5TFgdLCbq9dLXT/MubywYy/uq9A0JJ2du/4pWuBBmoL0hqWqktmnOZanp
         +i8mo88Eys8iwrnXRYKw0pRzVYxC+nNwxPN+inNrfRao7XyC3xG0fphuwx63lPcpv9E0
         G0J3x4q/DIDU8WUKu7O45XO7VIVKyQv6fYfeEubmCVbYasKwlb8ZkyyDN0uQyywLcP8m
         0midmRSs5II4FdMRIuun/Ts+CnjaYWWMW0UHJEvp9jlyBNWqjebx61PSc6vTt3gs42UG
         kFGTXN+jlbRgEgQCaqgZ6NgUqjf6lzjpFLQfRyvMvD9cVKPep/giFLe1B25WD7L0h5rZ
         KV1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaTAc3ldScCAHkCSWzaNGXjbSiP951nh3oEmNUhOBWCsPd0RD6yIj3zwZbGfX9yXFVZxkxFhAVrqjRy+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZ3Avqhz4VkCl4ObbhIdKVCv8BtzzezDZv6fZdDyX2FehlHTD
	wMC1W7UV7bm+7r1740U5os91/z+PDV6X3GL/AphxO3vR2gjxPcAJ6FndOue40KYXjbDwvb82P3I
	p
X-Gm-Gg: ASbGncvO6RirIQFSB9/HgHwUtIHpkHf6D2JrqVVLfc+tUwievL4lMS3gUEDw8Z8yo2r
	XIdhTya7OgpDfI/4e1dz17Qjv/gjnRUQFSyAQvZwJAsvEGO9rNckwNFWeC0gD1SQ1GAMRCJsJtU
	/t8ydraAfTNI9SJoSuhhEFBrCC3R/lrxIlO7mYrffn7VPKXuZZ1QazmuTTA8183gtFW6OdcYouZ
	f5oAYdCbn1v/L7kP9t12nGY9DMKcHipOgGlUvI5bx5FOEsY1DDQTHKwQJtUkCw/OULvJExFR9yR
	7pUZGHBN0xc9w+w+yBJxY4o=
X-Google-Smtp-Source: AGHT+IF2qJsJ0FbtvmhHEABYAPzmLzYktVswQYCd1SC8IwO02PzmD/X8kcsImTR5inQFPXqmLqlW6w==
X-Received: by 2002:a05:620a:3727:b0:7b6:5c7a:52 with SMTP id af79cd13be357-7b6839c563cmr3126058285a.4.1733152353039;
        Mon, 02 Dec 2024 07:12:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b69e94bc88sm79209385a.47.2024.12.02.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:12:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tI86B-00000007EPt-4A1m;
	Mon, 02 Dec 2024 11:12:31 -0400
Date: Mon, 2 Dec 2024 11:12:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, pr-tracker-bot@kernel.org,
	iommu@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
Message-ID: <20241202151231.GF773835@ziepe.ca>
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
 <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
 <Z0WtI9-Xxr1eY7Av@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0WtI9-Xxr1eY7Av@8bytes.org>

On Tue, Nov 26, 2024 at 12:12:35PM +0100, Joerg Roedel wrote:
> On Mon, Nov 25, 2024 at 06:45:00PM -0800, Linus Torvalds wrote:
> > Those octopus merges may look cool, but you should never use an
> > octopus merge for anything that has any conflicts, because they are
> > hard to get right. Joerg clearly didn't get that one right.
> 
> Yeah, sorry, my bad. This time around there were unusually many
> conflicts between the topic branches, which also forced me to create
> two merge commits to put everything together. In this process I
> overlooked that the iommu_present() definition slipped through.

I know we talked about this before, but I think the topic branches and
octopus merge flow is troublesome. This cycle had lots of all-driver
work and it is a pain working like this.

We rarely seem to toss stuff out, it would be OK to just revert it, or
run a delayed two step promotion like Andrew does.

I especially don't like that this flow recreates the octopus merge
whenever the branches change so there is no stable tree for people to
follow, or to submit patches on top of the current state of the tree.

IMHO the more traditional flow of just merging patches/PR forward on a
single branch works better.

Jason

