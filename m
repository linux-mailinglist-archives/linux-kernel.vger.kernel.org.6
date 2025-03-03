Return-Path: <linux-kernel+bounces-544547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D290AA4E26E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4997188859A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBB27E1AA;
	Tue,  4 Mar 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvpcbQRF"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD50264609
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100294; cv=fail; b=ud7qNuIhJWCSaWnG+uehBpR/9juxkZRqrABVjjeIWbVEvQEHjzTjJg41x/ZLCfAuo4/DeXQbsSgxFO0FVt7yTbVeiMNXoe5squcjTuAFkyxUxwctAdZyRl3Ik7qYpJHzVEDeFI3fsUhWnrjyrn3p6ysq0VXkFoLcmLBZAolUxVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100294; c=relaxed/simple;
	bh=jnE4y3k6lc681apqOKMO5cbN+C4iA9vg4UnHMdyboD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKz4l3OvOEyq5lqOFArpdkHTx7iGU2jWMdoGBb0RxE2TnBpJBiVn9W42cNER/l2ztdw98GOtyG0TgP7OUV1ItjqENnq80p6bPkxUyrYuH2TEwlX6ofA+8C7i7vDxrsvVBsZEh6ZFkOl+9Pf/fPcUxG+1DuAynewN8sQRb8ipNRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpcbQRF reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.19; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id A56C440F1CDA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:58:11 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UvpcbQRF
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f0T5L7MzFy5X
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:56:57 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8D15C42746; Tue,  4 Mar 2025 17:56:44 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpcbQRF
X-Envelope-From: <linux-kernel+bounces-541563-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpcbQRF
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 41DF842631
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:22:32 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7F0D32DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:22:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CBD7A1CEF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6B1F542A;
	Mon,  3 Mar 2025 11:20:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DE1F4E34;
	Mon,  3 Mar 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000801; cv=none; b=bZfXDdZtu0AlHW83r4iwZaHnHHbcvrsdXNjsX8Mrd9Ss/m6CHlq8oglBZMNlqZ8pPkLdjFDfmqZFAiAZV5fdJl0GpLxDv2gh9+uw2GU5fkDGGlYyduoi1beQTYsDF8NJNtGAjYsd2w5FGxrHHFohQkeLYMDnMCahSna17utdkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000801; c=relaxed/simple;
	bh=H19stMRWzPjk5CjO8dxV6ELvbly3bLebu40Bgo9sTRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfkYyEKNQnoJq3Cvw30CKhUUHuGBCfKD0T2AF3yb8TAS4vVbzb71rYRTXiXcByieJM4+I5sSXviQgWM42z/siYau4+eIRu6n9BDA+xViqA99E3ARquxqRhIiJizc69IURvRCvsCGsxMvWcV997xepLqwebJxhwEyd/bUrdTIrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpcbQRF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741000800; x=1772536800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H19stMRWzPjk5CjO8dxV6ELvbly3bLebu40Bgo9sTRw=;
  b=UvpcbQRFAquFZm4W7As2HjVJUNzzuid6lLmN0a9sh01dXR+7a4AFJmzc
   /txc0aX/VL+Z/mccI/b33wRloDp36n5xv9Y/vqPg8jzjceebVca6rEzKe
   pF6RQNT+m3V6lUW6fCad7F2zmtQOOfTJs+Az8a0NQ44LazLlfBUGF4eqk
   Y5Je62zyjKCsHEmQY9BlDYfxBKpPxzmdi+sUxhkYFOR8RzChLS7ixSjWw
   QUp53sseTDKGLt/erwAAcYIOigyKjBOOYyKaqsYHox0SmNEJZ19np2wxt
   wJGv+ftHOBMH1fXSg4RIdIp8bLu5dPuOV7qK2URLUJaAdjLkW8eoRcpLL
   w==;
X-CSE-ConnectionGUID: YLG6mV2ESUufa7aGYy85tQ==
X-CSE-MsgGUID: 28PphnMVS1u0XWba7nEGpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41724445"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41724445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:19:59 -0800
X-CSE-ConnectionGUID: uRZo5azaTgeR24yb9U58eA==
X-CSE-MsgGUID: 9Ub/7dyCTwCiJLGSrsHVeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118676309"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:19:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp3px-0000000GnDN-19U3;
	Mon, 03 Mar 2025 13:19:53 +0200
Date: Mon, 3 Mar 2025 13:19:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/3] gpiolib: finish conversion to devm_*_action*()
 APIs
Message-ID: <Z8WQWPJGjEKuYJDS@smile.fi.intel.com>
References: <20250220162238.2738038-1-andriy.shevchenko@linux.intel.com>
 <Z8WJNPrD6033anWw@smile.fi.intel.com>
 <CAMRc=McQMvbLc0OGa7JU_F7Y6Qw6-pUGK9EC25jfVAZNcTkzfA@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRc=McQMvbLc0OGa7JU_F7Y6Qw6-pUGK9EC25jfVAZNcTkzfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f0T5L7MzFy5X
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705019.78364@VOqqzInLsvxLNvsBQO9qfw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 11:52:07AM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 3, 2025 at 11:49=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 20, 2025 at 06:20:25PM +0200, Andy Shevchenko wrote:
> > > GPIOLIB has some open coded stuff that can be folded to the devm_*_=
action*()
> > > calls. This mini-series is for that. The necessary prerequisites ar=
e here
> > > as well, namely:
> > > 1) moving the respective APIs to the devres.h;
> > > 2) adding a simple helper that GPIOLIB will rely on;
> > > 3) finishing the GPIOLIB conversion to the device managed action AP=
Is.
> > >
> > > The series is based on another series that's available via immutabl=
e tag
> > > devres-iio-input-pinctrl-v6.15 [1]. The idea is to route this via G=
PIOLIB
> > > tree (or Intel GPIO for the starter) with an immutable tag for the =
device
> > > core and others if needed. Please, review and acknowledge.
> >
> > Bart, I know it's still 2 days left till the two-week ping time, but =
since we
> > are at rc-5 and this may affect other subsystems I gently ask for you=
r
> > Ack/Review and I push it to my branch for GPIO (as it has dependencie=
s which
> > are already in my and a few other trees).
>=20
> I thought this needs an Ack from Greg or Rafael?

Ah, you a right, I wasn't carefully looked who gave already the tags.
Greg, when you have time, can you ack this, please?

--=20
With Best Regards,
Andy Shevchenko




