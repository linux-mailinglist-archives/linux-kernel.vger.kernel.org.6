Return-Path: <linux-kernel+bounces-212854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226690673E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CF11C2161E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01614039A;
	Thu, 13 Jun 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="LHgFx7Ui"
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654D13F456
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268068; cv=none; b=e7gfw5etBEeG1/WxJiX6BTF9QNz9y4o+P8Hc0IEDDdML5pYI9YWvwy4vjgO9eq+ZJAMZrBYPqJi5jjpGNvX4QvtN4RCxDWbQZMppdZyhHJi49DmoIhNBEtbifc9YTDyrtoKkzvoW3UTudhPSHO0cB7NUhoDJdghVBf05gm3W0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268068; c=relaxed/simple;
	bh=kaJDHSUhZn+FcluExfAV2T2ascjiP3guZqN5suxacLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu5SnzZ+d9rCpGSggk+f5llMX6CJg9V4kWEjqaknr5qmPxHho2H7Vr2tDnGasJXuVHMVyQ3GBVyxKZaVJ404YeaZylN8XDtY3u1eQCxUByFzVjmj5z0N4PG+FlUsNaWBwVWIg/BRQZPFrh4vGG57UEvk2lfoA9k9XS8zneEJVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=LHgFx7Ui; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1718268066; x=1749804066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VI3iX+RqAjqXsW2mXfYAzvb4c/eAmPyXQ29Eq194SH8=;
  b=LHgFx7UiOqsfS1ivUxI9ZEvUAAceJxz+KWyGFclHCJFJvohDw6634vYZ
   bz1yFzLikzDNJnJexCBi1QHECPGT6rjUZHz9QU9eDPZJMSzdT08Cq375t
   HdMikTv1wdqZDERSPBd7s4MnAbItTARoFADC7GvV42BgKlYebeCE1RFcy
   L1wuh0qAbpWATa5ZDsJ+FljFxTxT8CaKOAjlccEE31WzK0ZRBhAFzG6hM
   QV9Q3/DPvezaNrsPD6O0MZx+3I6g/frJk8pA0lC9WE1tBLE3svnXhd87Z
   Ef/roKh2FnzCINIHT9rV5uxUlaBYIm7nxiq/TbmnfkIGY0C8esan3DUgm
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:30:57 +0900
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="399086883"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 13 Jun 2024 17:30:56 +0900
Date: Thu, 13 Jun 2024 08:30:56 +0000
From: Khasnis Soumya <soumya.khasnis@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, soumya.khasnis@sony.com,
	srinavasa.nagaraju@sony.com, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v4] driver core: Add timeout for device shutdown
Message-ID: <20240613083056.GA8140@sony.com>
References: <20240610055844.GA68891@sony.com>
 <2024061046-protozoan-repost-6443@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061046-protozoan-repost-6443@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 10, 2024 at 08:29:02AM +0200, Greg KH wrote:
> On Mon, Jun 10, 2024 at 05:58:44AM +0000, Soumya Khasnis wrote:
> > +config DEVICE_SHUTDOWN_TIMEOUT
> > +	bool "device shutdown timeout"
> > +	default n
> 
> n is the default, no need to ever set it like that.
thank you for review Gerg, i will fix it.
> 
> thanks,
> 
> greg k-h
Thanks and Regards,
Soumya.

