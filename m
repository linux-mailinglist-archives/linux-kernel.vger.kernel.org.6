Return-Path: <linux-kernel+bounces-515379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA6A3641E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB24C188B035
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B9267B85;
	Fri, 14 Feb 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LRmqiR8I"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684D267B15
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553069; cv=none; b=PN9ILWUG08VGPPAuTKGcm6BVtLGGdGoT+A51DhXobnholjMl/5+cYufg1zqTZugZZM2R3ekXPQTHxXRH7An1GwkLzGlpYzVLEOkrcWvWn2FDD43ODPhdchSpM1sE+YnsozzzD1RiBzpmTgRZaj7gpHNqE5A4bjXKN6IIuLxcgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553069; c=relaxed/simple;
	bh=ELy+zrfrHewmzsP5iE3srJfwjuO1/17WeHvmzSm5Cx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTaVkcyyNhPv5PKucTCcKt9HMym3UYquaSzI3FvhFM7LWKfEXWtqBkbngp+QnI9ReT+zZFKnN9TMIW2lp2inVngw+DPFeUoenbZtGws/Dq6XVvszTDZ+SnmI8nJMI/C5K7Gho6d6HtwkAeVAzCLO5m4XYlXBmcUtniSt+cBzEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=LRmqiR8I; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220bff984a0so40697145ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553067; x=1740157867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3WJ3Hbul+BcwiKbMsLe5up1foaUcyVA+15YyjU7ZeY=;
        b=LRmqiR8IKvX6YkCu6yLaOHyT+sYWVnTa9BtSiHFyLHLTVLfZpHZGHTtQZqBXBhys5K
         /QAVefqvY+Waln576Di2Odh0usLJIrkxUN+IugdcWOboMVkY8M4NoWlPYTTdx4hiyG5e
         CrvUi1aFsnRPFKX/64tYqi5v73BldjcqsncCKuIibVutcEo4aiYmI/5EimamtgosMqFo
         t/GZFOS7CCLQ5bwq4ta3VJUHEpFFkeYmUpSJFExge1KGo5dDrp0NivfKDVklysunplR/
         c2w9QxOZ0OoTZzPGiYsbL0LV85Of4tXOE4XVKVEfO5LIh2JkoqgrsHOTBuF1KSNKDaiB
         pESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553067; x=1740157867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3WJ3Hbul+BcwiKbMsLe5up1foaUcyVA+15YyjU7ZeY=;
        b=dvsPWnCaolnD/zCIvp845uCR6+sf4NzKzUG1LSsjOBTehCeZe20X8PTSa9kVh+chHZ
         sKd09hsRuBK62EeXqH4Si6KqEsYvTZcFA68fmCEIJlJ4MxQx0qXQtiOmCElLai7H4I3p
         /UO9/IKAdQvEvKKWCFqdRY/bpTVj0J8621cyjoKzk4bN5oYOhuNIedd0ur4SPj2RKPPA
         lZuWbItMcPM8Sgx1EuO3C8de6d3yzJHNpbbDDygELcWhjp3UaobRwrkqjW5SRbvaeKkq
         l8ysjSdOK/DuFYsjCbBc6TpNPDJZzU8oiwOJC2yCz8hjLeqgfUSHZmWewOyH1eyS1Bny
         wKng==
X-Forwarded-Encrypted: i=1; AJvYcCWhrFanAZ5a3cmhuijOZK9YO8dVozGfRQIN6uMROlsP2EdgFC04/xP8HvUWUJjhMNNjza1J0WtAjtb7alo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBT9hl95bYgSltYxZ9v0e8nqNGKzmKxaOCQCx7bFACuF0Zwaww
	rgJqQH9HjG1TGfqA7QoOJsUEkD4gOF7PAhpT1nigW6CCZIPJQntkQnDFhv7yBzoi8AXPdXbt1hW
	eQac=
X-Gm-Gg: ASbGncuCn51mGQBJRq3F+MN91uSgDYoc2YSPqLaxGSmVCkLYJpIaMzDXWTfBwxrMB07
	Mwo1kG83gd4bBUVnwpRotVxRQl8qcVjE9etJ84dWrD5dxx3+VP5TmGGf1a2N//wCQWuqHuT0pYx
	XU/CqbFcSdW3RAtwMIFYhE+ovFrUJghqIQ0XlUkVjt/X5ggb5MDmaX1Ob6P9TFvybBTj1qXAXUB
	f6L7UoB7didQ3HsmZ7LtLTltcaaIQ9SzTaci5Sl75wZA6Li27A8oJiWwtBvEl929DsjrQPKOzJs
	7XLb5YNmwtJtX7HzMToDYt4wD5zF5zS2JYG1qMI25nlQxaYv8NJ5XzUzHpnRgVm7P8zg
X-Google-Smtp-Source: AGHT+IFmUYelpgd2oImgFRIzH4xmfNMtpcgqp/XRqTu33fmCKbF5ZW0INkiDWT/S0JQHXkWBpK/8lg==
X-Received: by 2002:a17:902:ccd1:b0:21f:542e:dd0a with SMTP id d9443c01a7336-220d2132b27mr132509325ad.41.1739553067141;
        Fri, 14 Feb 2025 09:11:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d448sm31250045ad.150.2025.02.14.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:11:06 -0800 (PST)
Date: Fri, 14 Feb 2025 09:11:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <20250214091104.01ae4d0a@hermes.local>
In-Reply-To: <2025021418-cork-rinse-698a@gregkh>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
	<2025021455-tricky-rebalance-4acc@gregkh>
	<bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>
	<2025021418-cork-rinse-698a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 08:41:57 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 14, 2025 at 12:35:44PM +0530, Naman Jain wrote:
> > 
> > 
> > On 2/14/2025 12:21 PM, Greg Kroah-Hartman wrote:  
> > > On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:  
> > > > On regular bootup, devices get registered to vmbus first, so when
> > > > uio_hv_generic driver for a particular device type is probed,
> > > > the device is already initialized and added, so sysfs creation in
> > > > uio_hv_generic probe works fine. However, when device is removed
> > > > and brought back, the channel rescinds and again gets registered
> > > > to vmbus. However this time, the uio_hv_generic driver is already
> > > > registered to probe for that device and in this case sysfs creation
> > > > is tried before the device gets initialized completely. Fix this by
> > > > deferring sysfs creation till device gets initialized completely.
> > > > 
> > > > Problem path:
> > > > vmbus_device_register
> > > >      device_register
> > > >          uio_hv_generic probe
> > > > 		    sysfs_create_bin_file (fails here)  
> > > 
> > > Ick, that's the issue, you shouldn't be manually creating sysfs files.
> > > Have the driver core do it for you at the proper time, which should make
> > > your logic much simpler, right?
> > > 
> > > Set the default attribute groups instead of manually creating this and
> > > see if that works out better.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > Thanks for reviewing Greg. I tried this approach and here are my
> > observations:
> > 
> > What I could create with ATTRIBUTE_GROUPS:
> > /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring
> > 
> > The one we have right now:
> > /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels/6/ring  
> 
> What is "channels" and "6" here?  Are they real devices or just a
> directory name or something else?
> 
> > I could not find a way to tweak attributes to create the "ring" under above
> > path. I could see the variations of sys_create_* which provides a
> > way to pass kobj and do that, but that is something we are already
> > using.  
> 
> No driver should EVER be pointing to a raw kobject, that's a huge hint
> that something is really wrong.  Also, if a raw kobject is in a device
> path in the middle like this, it will not be seen properly from
> userspace library tools :(
> 
> So again, what is creating the "channels" and "6" subdirectories?  All
> of that shoudl be under full control by the uio device, right?

The original design of exposing channels was based on what the
network core does to expose queues. Worth comparing the two
to see if there is any shared insight.

