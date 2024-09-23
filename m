Return-Path: <linux-kernel+bounces-335575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF997E7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65104281711
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F38193439;
	Mon, 23 Sep 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY/MlD+F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00E2F2D;
	Mon, 23 Sep 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080537; cv=none; b=mZxBa7aijuGcMf0yo1oQSUWd076uCwmUrAW2Ek4fHZFui6biuf/OlGmuWS+IKTbf7vscCLXCqdHnZnmd3G7OSinplg6KadagGeqZvAL1KGeLDJ6aA5x6tThUKbeN+LsqLA3DLrd9lGABrQKk3FoLRkQi4u5iWu181yQTS04Sj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080537; c=relaxed/simple;
	bh=TuLbQ6JY2vaoEN0WIg+n3A+Asb+9whfW5ES2kkitQr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWs+gmcnjVvQKzSmOwz95RbFhcDRFwr5XEXMUpMmvJlW8wvGtVFOmbVQYhNNyQ6spdSg2g+nFbpXPXSXNMknSrcO7sxL0CuutITaGyiRKDLvZjfAZkQwQa/hfH76k7R2DABT8Om8q/mEqzY0UBFzs5lsRl/mcIfOpf7qr2S/uM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY/MlD+F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727080536; x=1758616536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TuLbQ6JY2vaoEN0WIg+n3A+Asb+9whfW5ES2kkitQr8=;
  b=XY/MlD+FJ1naa29Fj5LTMWL+ouchUY1mTDCWUN00E2G2G7vo9vsAFHGs
   tCM8JE0FycB4Opt1fH46FsdmnNjxNGT6bgSmk/lm18Jp9lVXmPnIz8Biu
   07ID3i22avLKK8YoO/ywtBzBcOv+crOtvLpfVkQldyrVWNTM1m0bCDq5h
   5k8TGfUO25OVccb07ExnN8UDLFPC2+YKIJtZigvQrzIQ0sfOBB+7lIIpT
   kPAY1OOVnJaSk+80DzFk6SgGgnv9yzJb936X+Pf3epX0exwq2rPvcMIez
   OBaSfhqdqWHNuLNhUOwUx+TDweeUUyVC3fisbEvTUSbO4A429AeqLlPa4
   Q==;
X-CSE-ConnectionGUID: FSx1izCeT1mmEsQVuGi5jQ==
X-CSE-MsgGUID: gOTrw77BQbW4UX2Ih32ksA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26208650"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26208650"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:35:35 -0700
X-CSE-ConnectionGUID: 5LZN6QK7Q8mDS07Bq1iiaQ==
X-CSE-MsgGUID: CxGdlIbmR4CijYL5m5mqlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71444819"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 23 Sep 2024 01:35:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 23 Sep 2024 11:35:32 +0300
Date: Mon, 23 Sep 2024 11:35:32 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix  dereferencing freed memory 'fw'
Message-ID: <ZvEoVC_j6jdBhvim@kuha.fi.intel.com>
References: <20240922105212.28099-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922105212.28099-1-kdipendra88@gmail.com>

On Sun, Sep 22, 2024 at 10:52:11AM +0000, Dipendra Khadka wrote:
> smatch reported dereferencing freed memory as below:
> '''
> drivers/usb/typec/tipd/core.c:1196 tps6598x_apply_patch() error: dereferencing freed memory 'fw'
> '''

This is only my opinion, but I don't like those '''single triple
quotes''' in commit messages - they are just confusing. You don't need
to use any kind of quotation marks in cases like this IMO.

thanks,

-- 
heikki

