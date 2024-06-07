Return-Path: <linux-kernel+bounces-205958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3094890029D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C328BED0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE9190672;
	Fri,  7 Jun 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Za6uMNgs"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B518C35E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761036; cv=none; b=H8Cn1qDIZzE1fjmtO05YIjICcDbKk/z/FPEDUJPTx5Lw4YzDNNTaSS7/ja8KNaaegSTDszjfEO/OqvBdLtkVoBa/cQdg6T0yN6CsFZkuPvK+LXkS4uSX9nEU05Fmndzer9rJeVdUp2wBq0320+r5JsKG4rNdOrXOEYxwrISzWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761036; c=relaxed/simple;
	bh=mToYEPLef2RyybsAYtlIyhPGJxWFMKSIt5YEX6Z/q28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC1X/wAvx3XGo+qkGeMUyma8CdRceAva+hsJ/dQoHDsWgofdBsqgb/rbaXKQmHuv0CglZvAZhE46A5NYbX3bgrWqlb5QQFc4VS+XR+pOzwQp2Lr7mNqMiHHixbIanhE5K62ZxM8CsU5V/XFzPIMcZlGUOihtUWOTV789xIULnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Za6uMNgs; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1717761035; x=1749297035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h0nbU2pDdu8rUUiGBO74R8RNqqy2YEu2aAXfrEo5Mw0=;
  b=Za6uMNgsrm+fKGJgJZ1wKS7uWHpIEEEk9xevZj20vxsXyA95rGwB6BSW
   s+9OtdIz54cG/EKhqu4Xbkb+4YEJdN/oiwFWYVKpSMbikD5s9jru1c/E0
   VhnAPNP4U5X9pjIu9+X5oBC1SH04ye//7x7AlO0mDi9kPKNqxqMRrd9O8
   v4ily9mEMtuO8jPkofhZECNxNCTu9OXU13fASe0I8fDw3Ht5S2uYg3PMd
   Y/I3HS2+RR0Q17hA1fqEJMUm+0q0QiYhVE1HbXBHTGaXRb/D9jGJmlT+j
   IEfoP883MivUgEryJVruwDrSu32lu9HszLvLTgV4GoA1NeiJ4VH0sH3Sq
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:50:33 +0900
X-IronPort-AV: E=Sophos;i="6.08,221,1712588400"; 
   d="scan'208";a="421152400"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 07 Jun 2024 20:50:33 +0900
Date: Fri, 7 Jun 2024 11:50:32 +0000
From: Khasnis Soumya <soumya.khasnis@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
	festevam@denx.de, lee@kernel.org, benjamin.bara@skidata.com,
	dmitry.osipenko@collabora.com, ldmldm05@gmail.com,
	soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v3] driver core: Add timeout for device shutdown
Message-ID: <20240607115032.GA31351@sony.com>
References: <20240606085003.GA118950@sony.com>
 <2024060637-imposing-ahoy-b8bb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060637-imposing-ahoy-b8bb@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 06, 2024 at 10:52:14PM +0200, Greg KH wrote:
> On Thu, Jun 06, 2024 at 08:50:03AM +0000, Soumya Khasnis wrote:
> > The device shutdown callbacks invoked during shutdown/reboot
> > are prone to errors depending on the device state or mishandling
> > by one or more driver. In order to prevent a device hang in such
> > scenarios, we bail out after a timeout while dumping a meaningful
> > call trace of the shutdown callback to kernel logs, which blocks
> > the shutdown or reboot process.
> > 
> > Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> > Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> > ---
> > Changes in v3:
> >   -fix review comments
Sorry for inconvenience caused Greg, i will update details properly.
here are changes i did in patchset-3(v3)
 1. added help text
 2. set configuration by default "y"
 3. added range for timeout value(DEVICE_SHUTDOWN_TIMEOUT_SEC)
 4. moved #define's to base.h file
 5. moved timeout functionality to device_shutdown() driver/base/core.c from reboot.c

> 
> What ones?  In what way?  This really doesn't help, sorry.  Would you
> like to see this type of response if you were to review other people's
> code?
> 
> >   -updated commit message
> 
 1. added information of where call trace is logged.
 2. changed patch subject from "reboot:" to "driver core:"

> In what way?
> 
> confused,
>
Sorry again for inconvenience caused. 
> greg k-h
Thanks and Regards,
soumya.

