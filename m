Return-Path: <linux-kernel+bounces-261017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EE93B19F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939A1285B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90589158D94;
	Wed, 24 Jul 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8DIYO9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63179F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827778; cv=none; b=QV8hmYeM/AQLmxBwSnpoCqpm0cpVTz6a8C0ceOT7xeD99ebt8ZxkX3v+us6zTBHJwy9LAzM5CPwK73Ls/1RoeVSfT5CjbVluShYD2nmn+Gcxy6YsKvCWPcdFjN3KUYzxghA2x0TjHBzinVOAwhy+R2rGTxlupU4a40lgRWVU3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827778; c=relaxed/simple;
	bh=l/Qoh1QLauYtzkMPlhEkQj1b5vMwVNveJRs+l9GETA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq6DQz2coC/Olgg7wLwCZcvXmi37Imvyi3kkrcCau6mWRucQC2R5TKFYRihaeHwp/1aiNpqUMo/UUqzDYmKN82gV0afJoL9q7rfRIYukMN1xSpCRmThBXIkIcOxhwNbEc6jOJKv+BN1yqxVptHusr86GfOHBR+sLNmvf4mGOr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8DIYO9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7986EC32782;
	Wed, 24 Jul 2024 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721827778;
	bh=l/Qoh1QLauYtzkMPlhEkQj1b5vMwVNveJRs+l9GETA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8DIYO9SwKkUQTgAa5WqqvIqzw6Cccfw0DbwciTd7Lhs0FEVAe6lBQNkAtgzGOhfl
	 X2hfTXQ4op6giN6SLPPBtCINC51deGgEj1bDUMsFXi6B7wDZbmqh5XPMW+bnZSnqO7
	 dfsN3NDYvcQ6taie3XBb/zO0NHBqfJzp3f+Hm4+k=
Date: Wed, 24 Jul 2024 15:29:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
Message-ID: <2024072449-tidy-cosigner-f681@gregkh>
References: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>
 <2024072316-yeah-snide-ca28@gregkh>
 <70ec36ff-1be9-4fc3-9792-4950a483b272@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70ec36ff-1be9-4fc3-9792-4950a483b272@quicinc.com>

On Wed, Jul 24, 2024 at 08:56:18PM +0800, quic_zijuhu wrote:
> On 7/24/2024 1:31 AM, Greg Kroah-Hartman wrote:
> > On Tue, Jul 23, 2024 at 10:55:43PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> Return -EIO instead of 0 when show/store invalid bus attribute as
> >> class/device/driver/kobject attribute.
> > 
> > Why?  What is this now going to break?  You are changing a user-visable
> > api that has been this way for 20+ years, how was this tested?
> > 
> this change should break nothing.

Have you tested all tools that access these files?  Please document what
was done for testing please.

> tested by wc a writing only bus attribute, for example
> 
> root@kvm-Q35:/sys/bus/gpio# ls -l
> --w------- 1 root root 4096  7月 24 20:20 drivers_probe
> root@kvm-Q35:/sys/bus/gpio# chmod u+r drivers_probe
> root@kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
> 0 drivers_probe                  // for current design
> 
> root@zijun-kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
> wc: drivers_probe: Input/output error  // for this change

That's just using a shell, I am referring to actual tools that read
these files and rely on the contents and error values that they provide.

thanks,

greg k-h

