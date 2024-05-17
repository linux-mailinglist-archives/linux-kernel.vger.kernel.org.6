Return-Path: <linux-kernel+bounces-182209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869528C881A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2951C24530
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D58479;
	Fri, 17 May 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTo+g/9s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72D79F0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956397; cv=none; b=PbclgKtbwcpLYO5z4TKoP4nPjE17NHRSZLzsDB8OV+qElui7x2WcQjPyKANy5r6I1SXpBmsbQFp6i7Zk7zOwILN1wtitpKHH36jLEwOO+rb8d3P4C9BBhleorQfpNQ6CqY7re3X8QR8uPnVO/Ox2f9Eph5FF1tJus40IF+RfLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956397; c=relaxed/simple;
	bh=V93XLAiIxz56pOFhKRk2dq+FLKZDcnpird74nR4nZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5WgJZ1TB/213kthj8ZU0NuL+VFU4l4dJT8lx4mcpmDraG4KvhnJ06Flskh34tWrTojEvZF20pi8tDMKPJ2xq7VgtAq7z6XMmghhwPe9tEAbsPgXgvaUSQ78H+Yysl/8u4v5H57lLS2Ig5DfE7Ag4AdL37M5nzMxWSXJ+Q/U37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTo+g/9s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715956394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXRpht3Oiyb6WnCO2PLJaNfFB/1BTZbbiqXWPvuMhk8=;
	b=XTo+g/9soUDDzOiG63F1mMEa2yfrX532Iz2cW8AkVHiO2nLXRjVLRwDtkjZt/N6ZCrRsh6
	VMy3sRaP5Pd+jVGiWZft4SO9sRtGwNZoSsG1by6lGztBBDJdlZA781uCHjbnnPh7L9FWbU
	aYNmk8yWhH2dgJs+gPNAi0HG1BMR98Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-f_iC8IrFOze2TXNajTJl6Q-1; Fri,
 17 May 2024 10:33:11 -0400
X-MC-Unique: f_iC8IrFOze2TXNajTJl6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 004D23802130;
	Fri, 17 May 2024 14:33:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F5F2026D68;
	Fri, 17 May 2024 14:33:10 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 44HEXAqY146578
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:33:10 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 44HEXA7Y146577;
	Fri, 17 May 2024 10:33:10 -0400
Date: Fri, 17 May 2024 10:33:10 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dm: support retrieving struct dm_target from struct
 dm_dev
Message-ID: <Zkdqpl5SN3RV0smg@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com>
 <20240514090445.2847-4-yang.yang@vivo.com>
 <ZkTXzG1yrPmW64Z6@redhat.com>
 <80ddcd90-2e1c-4fbf-a45a-b1b5ff4d60fb@vivo.com>
 <ZkYmZaGWPtGIwedG@redhat.com>
 <8f49b95e-88df-48b8-9311-8a15414d8107@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f49b95e-88df-48b8-9311-8a15414d8107@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, May 17, 2024 at 03:48:49PM +0800, YangYang wrote:
> On 2024/5/16 23:29, Benjamin Marzinski wrote:
> > On Thu, May 16, 2024 at 09:55:53AM +0800, YangYang wrote:
> > > On 2024/5/15 23:42, Benjamin Marzinski wrote:
> > > > On Tue, May 14, 2024 at 05:04:42PM +0800, Yang Yang wrote:

> > > 
> > > If I understand correctly, you are suggesting to iterate through all the
> > > targets, handling those with sends_pass_around_flush set, and skipping
> > > those where sends_pass_around_flush is not set. I believe this approach
> > > may result in some CPU wastage.
> > > 
> > >    for i in {0..1023}; do
> > >      echo $((8000*$i)) 8000 linear /dev/sda2 $((16384*$i))
> > >    done | sudo dmsetup create example
> > > 
> > > In this specific scenario, a single iteration of the loop is all that
> > > is needed.
> > 
> > It's just one iteration of the loop either way. You either loop through
> > the targets or the devices.  It's true that if you have lots of targets
> > all mapped to the same device, you would waste time looping through all
> > the targets instead of looping through the devices.  But if you only had
> > one striped target mapped to lots of devices, you would waste time
> > looping through all of the devices instead of looping through the
> > targets.
> 
> Yes, I get your point. This patchset may make things even worse for
> the striped target.
> I am just curious, in what scenario is the "dm-strip" target mapped to
> a large number of underlying devices from the same block device.
> 

I don't think anyone in the real world does create dm-stripe devices with a
huge number of stripe table devices. My point was that it didn't seem
obvious me that looping through the targets was a significant problem
compared to looping through the devices.

At any rate, Mikulas's patch already does this optimally, even for
targets like dm-stripe, so it doesn't really matter now.

-Ben


