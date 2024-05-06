Return-Path: <linux-kernel+bounces-169535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268898BCA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC701F212D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705E1420DE;
	Mon,  6 May 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCF28Kd7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7A1419BC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985480; cv=none; b=iXd65Bio+aghu2qEJGbYa4VNgZ67gvdzR4thiHsxbOFy9yvuQIFmKVmAgleFTq1scQ+9WxDBI9Jeu5iovzqRb6I6A30BeGu1VQM0RFciszbKGg1re4zfi/Rd64xS2BWvq6WltxWwz5hR6D8074HGERBk1gA279gWUW7h/f1tHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985480; c=relaxed/simple;
	bh=N/vRgMjutnmXFlKISsQ1KB1ncvd1p8QS7GLxmgmCcDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByPi0K5XL2ymkQpVpRY0VNWcDybfKFwDCqf8NBykfgIUgItuMW8qzZI6CJe8vsPZVJhwNwntxG4qZzw2FGdET44NacVFZ8cyF+sQPFpd+7h6Uxqp+JeMMuIqG0gB2C6BKNDXRDAsykZ/zCXCvOnGLpF9sWpOMMN7sbtbIq4a0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCF28Kd7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714985479; x=1746521479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N/vRgMjutnmXFlKISsQ1KB1ncvd1p8QS7GLxmgmCcDE=;
  b=hCF28Kd7RRymjYgJuZD3GlYUun6LGQGY/A3O8rsJJXHYOHZoBdN0SYpM
   721oyIDPxnrVs56BZGUkWw2/3PUiUYzwr7WVUPBjgWZtvnmOnE0C8s/HG
   ebkdPnlVFzj143xPURoOvXX/vIo85A1aO/raDlh2/Dz3gn6tvldVyfg8N
   +vTwHoSxF8iFFF++EojB1Ld4h4vm9lFI0cXDwnvQo81Bnr8jtFHptbxWG
   Dvn+lQaG83pWxvm0Xgkg+E+N98Re/aFP7v6VgDfIXk5IHMOP72Z11jRpt
   YsMfjlGBO1WQ8xF0AqMNztf2G0earXCebXdX7letVS210hFZbKC//f8v/
   g==;
X-CSE-ConnectionGUID: bCrsjLwIT1OrHLsBJGYe7A==
X-CSE-MsgGUID: wCmGtpK7QReSlzvZ28QFow==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10564233"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10564233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:51:14 -0700
X-CSE-ConnectionGUID: NmbQeUr7Sw6H2rxavCrpIA==
X-CSE-MsgGUID: 6L1JWmOsTb6MMZXFpLAktA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28114850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:51:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3u3u-00000004cCx-1Hyf;
	Mon, 06 May 2024 11:51:06 +0300
Date: Mon, 6 May 2024 11:51:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda
 driver based on SPI
Message-ID: <ZjiZ-vAnsI1XQubA@smile.fi.intel.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
 <20240430072544.1877-2-baojun.xu@ti.com>
 <87jzkfm2hp.wl-tiwai@suse.de>
 <ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
 <5832318882b14f5cb171ce2ecde1fc93@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5832318882b14f5cb171ce2ecde1fc93@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 06, 2024 at 07:44:41AM +0000, Xu, Baojun wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 30 April 2024 21:45
> > On Tue, Apr 30, 2024 at 02: 58: 10PM +0200, Takashi Iwai wrote:
> > On Tue, Apr 30, 2024 at 02:58:10PM +0200, Takashi Iwai wrote:
> > > On Tue, 30 Apr 2024 09:25:42 +0200, Baojun Xu wrote:

..

> > > >  snd-hda-cs-dsp-ctls-objs :=                hda_cs_dsp_ctl.o
> > > >  snd-hda-scodec-component-objs :=   hda_component.o
> > > >  snd-hda-scodec-tas2781-i2c-objs := tas2781_hda_i2c.o
> > > > +snd-hda-scodec-tas2781-spi-y :=    tas2781_hda_spi.o tas2781_spi_fwlib.o
> > >
> > > A nitpicking: better to align with other lines (i.e. with *-objs
> > > instead of *-y).
> > 
> > I object this. The better approach is to have a precursor patch that switches
> > to y over objs (the latter is for user space code / tools).
> 
> I also do not fully understand why set it as "y", as you know, I follow
> CONFIG_SND_HDA_SCODEC_TAS2781_I2C, as it do not set to "y".

While you see no side effects, the 'objs' is reserved for user space, while 'y'
should be used in the kernel code. 

See Documentation/kbuild/makefiles.rst "Composite Host Programs", mind
the word "host" meaning.

-- 
With Best Regards,
Andy Shevchenko



