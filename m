Return-Path: <linux-kernel+bounces-236587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC391E45E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EA8282484
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A7616D317;
	Mon,  1 Jul 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz2bN1aH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D353AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848544; cv=none; b=Lf9ji90HOugmVJrc5+BADEMUfixVNXlrcOnG5sBfVOjP2EXfK6WIohUjI8ruBS1AANloDiE8EAfRy/i+Z0KKq83co+ZUV/JdnnIZZWCWy18NeQxM68Ol7pUJptT8PlHo5ZufCvmANGY1bkkZ/hDHg5isOFSNuAwtXtt7di0aigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848544; c=relaxed/simple;
	bh=eRi2Lte9zrOdaRxTw0j5KeaAMhO9mLiP7y0TSEbnLaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Knc3Uef4E7HPm8+GfYGiYAiHqgto+s3dlhc9sVMUu5FBkMn8zr2LiA+oiS+ZoohCNqsLdoqxwgb/geiyFbIHrHCMI5XiHrVulQ6cajRdM8Z8VHHLIi59QMYeQFV9XzrR8KhnNsMn+4xBCh7uEahSLo8e0frdiIF7WmAFC0qpof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz2bN1aH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719848543; x=1751384543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eRi2Lte9zrOdaRxTw0j5KeaAMhO9mLiP7y0TSEbnLaY=;
  b=Jz2bN1aHOC4NH2kgatMJCAl4K71zmPyUBltI/7VIIvZa8YvHaTdpFxH8
   rIw9GpZ366FmD8QjE5uyGFJnXKMITfCdcOXx5jgxtOSo7/Wl6ULRxDfMu
   bdUnJOLshCKvLCZz4WdzpQvQUMbV8zIPV6RWu2D34deW7lsxO95hOF1VC
   8KoQ+8OygwTGPOEbMSycLh6Z78wxtVGCmX8RN2AnSUbYUYsf+hkSKj149
   reRcSxAkUd5nW6uT55hBpqoNq0A2rHt6FzqVRz7xqoERBqbcgD8Y5L70I
   bYF1ROdbCA5CnkHblughylfcZO+fOOWe6MC62SPUVmNflg5ZWsaQnnbuK
   Q==;
X-CSE-ConnectionGUID: LdDoD6+HRkKFPHaNF2flzw==
X-CSE-MsgGUID: hM6RndNsTyWzF4d14ukiNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12341898"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="12341898"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:42:23 -0700
X-CSE-ConnectionGUID: 4rpfAkTKSyOcy5C8TNvLpA==
X-CSE-MsgGUID: Y56bThHpTN6cgtx1G64tjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45466295"
Received: from hdoran-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.216])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:42:22 -0700
Date: Mon, 1 Jul 2024 08:42:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <20240701154215.wxiqm7q7n3rc6mky@desk>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>
 <20240624170921.mep2x6pg4aiui4wh@desk>
 <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com>
 <20240625180150.7awxiyvmztcuu4pw@desk>
 <eK0mvc1FJknv3ZTg6opsYgeqRGgQCTFIQ-gdp5k0KdB3EsY-dL7cKmKvsG93qcTKvPQhrjkbRTrI32YK-AqMXcqiKqLetkLeDnn_b5qs7AA=@protonmail.com>
 <2024070152-unpaired-trouble-2632@gregkh>
 <HhniN4n96_JaNG8CoExQV0wVbtYBjetZdyYg5d29J85Cc2mR6RNR8ZiVhIx7OQMwK-kTh_n1g1n3LuheOayxsnjqgvAU-162TYAOb_RmuWk=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HhniN4n96_JaNG8CoExQV0wVbtYBjetZdyYg5d29J85Cc2mR6RNR8ZiVhIx7OQMwK-kTh_n1g1n3LuheOayxsnjqgvAU-162TYAOb_RmuWk=@protonmail.com>

On Mon, Jul 01, 2024 at 02:55:08PM +0000, Jari Ruusu wrote:
> On Monday, July 1st, 2024 at 15:27, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 26, 2024 at 01:02:35PM +0000, Jari Ruusu wrote:
> > > On Tuesday, June 25th, 2024 at 21:01, Pawan Gupta pawan.kumar.gupta@linux.intel.com wrote:
> > > > Thanks for pointing this out, CLEAR_CPU_BUFFERS should happen before POPFL.
> > > > Below patch moves it before POPFL and also adds a safer version that
> > > > switches to KERNEL_DS before executing VERW. This should ensure VERW works
> > > > in all cases:
> > > 
> > > Your patch looks OK to me. Thanks.
> > > Tested on linux-5.10.220 inside 32-bit VM.
> > 
> > Great! Hopefully someone submits this to the stable tree so we can
> > accept it...
> 
> Upstream is still not fixed. My understanding is that the patch
> is on its way to upstream already, but not there yet.

Yes, its being discussed here:

  https://lore.kernel.org/lkml/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com/

