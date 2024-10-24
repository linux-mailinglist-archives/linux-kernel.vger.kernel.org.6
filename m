Return-Path: <linux-kernel+bounces-380146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4D9AE97C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D81C22243
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EA1D8E18;
	Thu, 24 Oct 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XCwXo69e"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E081E25FC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781928; cv=none; b=fisGo0x6wteEHgT6pBffg3cmFxOC3cF6dxTNcuq3Y9bLpClARJa+7NK9qUtT3usiB8d28XPhL2cA6COnNDprI812txbxZpsioP1ZYNaSN/wxqPKLm7kOC5z+8w4I2RrHYFE6NZvRa6GcSo83qHeNeeTLlO6ReJy+xPGAnSTJXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781928; c=relaxed/simple;
	bh=+gUYrl90Bp/HIAFirwtSe5aPKXXW4Xb7fDGVEPtSi+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiOhWubmraUFf1F/hC0c2ct5rktfNVV8O6v9Pm1yU60rzQIS75lQKcM43DWmeejyj4hGUAFFHqF5hy/YiJDiM1Mrm6KFcNb3xJoL3dUrCaVqOG+gG1ulhZOqFbGSbz7xmFFk/thtBrywhJ1BQViiLQAHRL0vKq2VwEg3kjV76Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XCwXo69e; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 07:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729781922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JsbdXGheXE8UKAwXz3WcVrbgQiwH49btzygF0hSZwQM=;
	b=XCwXo69e1xpI6kba8dr61TzdH1ksoQSOerz2LCHynr7o2Whd5fnBP8OFDIS5GotsM1cJBO
	Lwc5CiKBG327B9PLkp5eDH9N3on0vK5fJLuL+X1fTzLew0+yqnvBUooJaIplNVasA5z5CK
	uSopyswAoV2DS+p4L1nQl6x+NNjDdJQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <20241024145831.6b44fqhhzwny6kc2@4VRSMR2-DT.corp.robot.car>
References: <20241015201424.2914652-1-dionnaglaze@google.com>
 <20241023201654.pjz67e5cv7kbki5t@4VRSMR2-DT.corp.robot.car>
 <e6003804-1f91-45db-8ae7-368fda354acd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6003804-1f91-45db-8ae7-368fda354acd@amd.com>
X-Migadu-Flow: FLOW_OUT


On Thu, Oct 24, 2024 at 04:35:20AM -0500, Kalra, Ashish wrote:
> 
> 
> On 10/23/2024 3:16 PM, Russ Weight wrote:
> > 
> > On Tue, Oct 15, 2024 at 08:14:24PM +0000, Dionna Glaze wrote:
> >> If a kernel module registers a firmware upload API ops set, then it's
> >> unable to be moved due to effectively a cyclic reference that the module
> >> depends on the upload which depends on the module.
> >>
> >> Instead, only require the try_module_get when an upload is requested to
> >> disallow unloading a module only while the upload is in progress.
> > 
> > Generally, the parent driver that registers for firmware_upload would
> > want the module to be present until it unregisters.
> > 
> > Is there a case where this change is needed?
> 
> We are using the firmware_upload_register() API interface for SEV firmware loader/update
> with the AMD Crypto CCP driver.
> 
> Now, when we call firmware_upload_register() it does a module_get() and bumps the module refcnt and 
> then we do the firmware_upload_unregister() as part of the CCP module's exit() callback, but the
> CCP module's exit() callback is never invoked as it's refcnt is non-zero, so it is like a catch 22
> situation, we want the module's exit() callback to be invoked to call firmware_upload_unregister()
> to do a module_put() and decrement module's refcnt, but the callback is never invoked as it's
> refcnt is non-zero.

That makes sense. Thanks for the explanation.

> 
> Isn't the firmware_upload_register() API interface intended to be used by standalone drivers ?

Yes, it is.

Thanks,
- Russ

