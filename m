Return-Path: <linux-kernel+bounces-566350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220DA676B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91003BF405
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1C20D505;
	Tue, 18 Mar 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZekapVn2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F01A2C0E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309093; cv=none; b=EwJbgHnUnX4i6h4iPwUrgcvj1MNaPikq9FQs2y+PEEHv/gxqVWb8XhH2MVfBEEo3dmqkc98ZqbgQpMsDq895e/X6oA+hFxjVBt8do3FcbWsIJhspPWRJrtsQzN+xCOwlgF7/zYVBw/pMOZcXIuE7FqcCCVCU0in9Pb+61idZ3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309093; c=relaxed/simple;
	bh=PjKLNZZoxK/fnTpi+HUsrEjFOgcRFJ7hLVvjT8+ECTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiiQ3IVdCJk0kYYHP1P/PasP9/jMa5XsqL9qInt/eQNmEDPHaluH2aVaIb9yI6zk+V5PqaMuIIdg+N4v7NNIJLnTv67Wx4ISSk+SY4cslZs3gHpY7VFVR6drGPAHJbAoUypsWkLz+gqVkj+1dWeZXSxBii5Zm86HPHeeP3r7vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZekapVn2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742309088; x=1773845088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PjKLNZZoxK/fnTpi+HUsrEjFOgcRFJ7hLVvjT8+ECTs=;
  b=ZekapVn2cNFinfT+O7ZCX3NpBZnCkMePUnprBNtyVlxYWHVU3kcK+qPW
   MV96Pbd6jmcytbjPE2u4iU2LqhvBBMiR/xGlQIEKPW09gS7aF9DFXdYow
   gHj9bTE5SmBIQX72EqIDwlQM7ZggASRmlyp4xMadrCnu4rUmoXQoQO5Zt
   ykIuI2DO7T/15M/GRBBhq8Exsiw9dE445LC95FlsZLT6+XoXS8bjAIIPG
   US5/abgXHuZVtCwY3O5PH327/HK1rTEeHpHP9Im6ER1QntcH6pWrZu1+W
   0/waZaPFgmql3WK7FIKwPindZNAow34saPAx7V8IQPt7EXBtAGYmnDmFE
   g==;
X-CSE-ConnectionGUID: P85twza2Qc221IP+UHDu3w==
X-CSE-MsgGUID: Cd2T7d7cT4OfRbJNlStHIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43558120"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43558120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:44:47 -0700
X-CSE-ConnectionGUID: 5ErdgUMFQp+bhOfF2YExOg==
X-CSE-MsgGUID: jJ3hwea9SfWwOhAgvn7fMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122453430"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:44:44 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DB4C811F9BD;
	Tue, 18 Mar 2025 16:44:41 +0200 (EET)
Date: Tue, 18 Mar 2025 14:44:41 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wentong Wu <wentong.wu@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mei: vsc: Fix kernel-crash when build with gcc 15
Message-ID: <Z9mG2XDr5DCP-Sif@kekkonen.localdomain>
References: <20250318141203.94342-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318141203.94342-1-hdegoede@redhat.com>

Hi Hans,

On Tue, Mar 18, 2025 at 03:12:01PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here are 2 fixes for the vsc-tp mei code. The first patch fixes
> a kernel crash when the kernel is build with gcc 15 and it would be
> get to get this upstream ASAP.
> 
> The second patch is just a small cleanup of something which I noticed
> when working on the fix.

Thanks for the patches.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

