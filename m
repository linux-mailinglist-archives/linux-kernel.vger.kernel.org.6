Return-Path: <linux-kernel+bounces-417037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF49D4E23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CFB282AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C211D88DD;
	Thu, 21 Nov 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CP6QsN20"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933151B0F0C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197217; cv=none; b=V5OeGkIVfYIQELXtWIopFZXe+adHG3rmkl6tNY2ZbjAZLfU3vd3ROandD5+0iQPkP1wokYdxomy7w150L3dm7reBppwBw9jTZ9Qx0IZGqL8HR/O0+XfCU7bPs7//iHYpLCrgn8o/qWCz2cl8bIewrzziRDUveQBoc5L7Gk4BntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197217; c=relaxed/simple;
	bh=r6MspEvresOTn3QxXgxDqAj09zu2cS0aBe2ZP+i59J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHESE228RGj64XRPV9MM2ncz88WRX0R9i+ONYBMfbqu3O+NW6ixZP2p6cPCXUmfHA2+WJB+QWDl3ZjlBXNJDyl+Vc6dppr6uFpmOr8F/t5YKG3675iTOrEQg3T/0hlEyV81mPAcLDXGz7lB7w9Qzohcn4g8Dl+vifEqOGgu0ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CP6QsN20; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b13fe8f4d0so53253185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732197214; x=1732802014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4uQC+61RQiOUY1Dl95bxhptVZ9V560RrMjbg6Uiw7E=;
        b=CP6QsN20xGYCOUBiBfPxodSVTpO0Hl2JvaHTqr6Xx1mxxOIs/VCF8NuJnZzc2foJfq
         C5EQmU6NKnq0s4KuU8Xdyjt06mnM9P4oHzAUe8N76aAk/uGTUIGgKjxVYS3fo8r7K9kp
         574kaK/3U+mPnZp0di90iKE/Bxw4VaxItKXu7zPGVIRtVC6m4qibIGCDZKQhl0mUoeIH
         8aSFbjNnrgrNhGlNQ+a/vD7UUuw8JqTF0TtzmxIWqN2o0V7dgGtKbrRmKeQZbaVhTBuK
         KmcqB4Ntp/oMt/2IHSRlcd49r78eQF8ZhQCCcNCDZpmuG0V44Q39mBGQp8f2jbOc7CK0
         8MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197214; x=1732802014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4uQC+61RQiOUY1Dl95bxhptVZ9V560RrMjbg6Uiw7E=;
        b=V0k2CbHgizwj7H69r8XcQjlbPv+BuN6pkmnF3++rezdDfjG4WVU2ELNZ5HxjepMM/v
         MD9Mg/c/NTOQ0N3tI2FedP1hqPB42TunwfbRDxLcFSQY442MeVNlnfXur3tlxtqWS5mo
         dEEWgSnemO9j2/rnwL2mqX2COj/8PsK9Vq5VMTb/n1aggTjbMFY5sK+rQ9RGWO6p2FBi
         cAGFQrMg/A+2fcjz9/tbtslKIm9owDMYKgHFCEr/OCQ7Weuj8OO8c+0EYVh6BGVXhxM/
         ENWicqNdXLIgdsvxqsTLcVmz4QpOHKjGxpbyorGtWiCcYc8ow1vJf6i9wPyw+39Imwza
         AAyA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtvnyRbVa61+QW08hl3viCDlO/fcKR/CQhXc2S2k/7dwalRmEDIjDJDrkP61u8V3KK1T8Gk34cN91ywY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbcI7c4bi6/nf1Kf94+MSoroelfMz3xKDdOkbCSQf9vPdZCH0
	rdR2R4iThmGa8qNhJerD9OMasbPwWFp6+loUtSyAflAUCsz+xP/dMZBF30v2NqyWPfJbJ6JyiZn
	4
X-Gm-Gg: ASbGncu26R8FFGzieHHuFR6FXxQTZU/J5iQ4+afXDC95prCoVYdlNgY0xmAou98fi9F
	0Zve69JBxRa7jJm6zq4q01YntyU/0YE5NHo0NF/LKvxoRyh+aeFrm7v5L2oCAV12Hqy0vw304zT
	nNdd7GfhFa2iqzKORK3dLBoRPGvma5w2D3kUUF7/R22eMHhv0lNtKdMqJ4LK3O9qssuAkQM5hDi
	NOdmo6KLEcQFYKNp5uZu/5Ua7d/0micCWe7PrXErSvC/xbKeD/wj1H4j45Yb8xRz69g16nXbzOQ
	wmXRtFRuwAkHooQ6lx2rCsQ=
X-Google-Smtp-Source: AGHT+IHDmI9hye5XOi6YSrGUXA+r63Ly14kAASwQM2O8Pu1R5EQHAMNGo2bLTDb9eyt1MuS1FkFoHQ==
X-Received: by 2002:a05:620a:4042:b0:7b1:48ff:6b48 with SMTP id af79cd13be357-7b42edbe9e0mr773356585a.14.1732197214343;
        Thu, 21 Nov 2024 05:53:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b485226511sm211401085a.90.2024.11.21.05.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:53:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tE7cj-00000003msa-01KT;
	Thu, 21 Nov 2024 09:53:33 -0400
Date: Thu, 21 Nov 2024 09:53:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zelong Yue <yuezelong@bytedance.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
Message-ID: <20241121135332.GB773835@ziepe.ca>
References: <20241110123532.37831-1-yuezelong@bytedance.com>
 <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>

On Thu, Nov 21, 2024 at 05:22:36PM +0800, Zelong Yue wrote:
> Gently ping. Do I need to provide more detailed information on how to
> reproduce the issue?
> 
> On 11/10/24 8:35 PM, yuezelong wrote:
> > Imagine we have two RNICs on a single machine, named eth1 and eth2, with
> > 
> > - IPv4 addresses: 192.168.1.2, 192.168.1.3
> > - IPv6 addresses (scope global): fdbd::beef:2, fdbd::beef:3
> > - MAC addresses: 11:11:11:11:11:02, 11:11:11:11:11:03,
> > 
> > they all connnected to a gateway with MAC address 22:22:22:22:22:02.
> > 
> > If we want to setup connections between these two RNICs, with RC QP, we
> > would go through `rdma_resolve_ip` for looking up dst MAC addresses. The
> > procedure it's the same as using command
> > 
> > `ip route get dst_addr from src_addr oif src_dev`
> > 
> > In IPv4 scenario, you would likely get
> > 
> > ```
> > $ ip route get 192.168.1.2 from 192.168.1.3 oif eth2
> > 
> > 192.168.1.2 from 192.168.1.3 via 192.168.1.1 dev eth2 ...
> > ```
> > 
> > Looks reasonable as it would go through the gateway.
> > 
> > But in IPv6 scenario, you would likely get
> > 
> > ```
> > $ ip route get fdbd::beef:2 from fdbd::beef:3 oif eth2
> > 
> > local fdbd::beef:2 from fdbd::beed:3 dev lo table local proto kernel src fdbd::beef:2 metric 0 pref medium
> > ```
> > 
> > This would lead to the RDMA route lookup procedure filling the dst MAC
> > address with src net device's MAC address (11:11:11:11:11:03),  but
> > filling the dst IP address with dst net device's IPv6 address
> > (fdbd::beef:2), src net device would drop this packet, and we would fail
> > to setup the connection.
> > 
> > To make setting up loopback connections like this possible, we need to
> > send packets to the gateway and let the gateway send it back (actually,
> > the IPv4 lookup result would lead to this, so there is no problem in IPv4
> > scenario), so we need to adjust current lookup procedure, if we find out
> > the src device and dst device is on the same machine (same namespace),
> > we need to send the packets to the gateway instead of the src device
> > itself.

We can't just override the routing like this, if you want that kind of
routing you need to setup the routing table to deliver it. For ipv4
these configurations almost always come with policy routing
configurations that avoid returning lo as a route. I assume ipv6 is
the same.

I'm not sure why your ipv4 example doesn't use lo either, by default
it should have. It suggests to me there is alread some routing
overrides present.

Jason

