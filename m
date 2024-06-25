Return-Path: <linux-kernel+bounces-228547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D94916182
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C643C1C23348
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6ED1487FE;
	Tue, 25 Jun 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKpIjocm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5211CABF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305099; cv=none; b=tUmI+f9yRbw4DL64dVaLrcKxPjRBLxczzFJY2e3ypeAlZhd6b3JwL0x6SFxQH/oNk4M0/VFzGl9WwcxIgeyt5sB0aMAJ5qjyBZ0SpvQYnDYYHKSB/ye+5FwqXOKd3jf7GVLthCLHjEccybvPtJ42iSQxB17t9pTxsJE1kBPBAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305099; c=relaxed/simple;
	bh=wh0PeBxiU3BH4g0PNaYrn7FRQaKbPVYcc/GwrnTDnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV3JM+YncrIRGRbXAsAzZhvyKn9Xty6T/7FI4aTi2VT+zrig5BR5oX8/vEicaka8/LW6eeSkSOU7eIocS3fPy7G15RBb545jaoKMPo2k3JTXtorOlHDHTUD7TKhwYMW0ZGvdK45qMmyc7oRIi/dbqDwypCyf2P+AXVkmmaAwbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKpIjocm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305098; x=1750841098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wh0PeBxiU3BH4g0PNaYrn7FRQaKbPVYcc/GwrnTDnOA=;
  b=nKpIjocmeKatHRUgZX4I0ftzgrwEvgPc77R7YM03dC3lFASRMzcrBDoZ
   K/3zYm3czKlpqZZVN24hrNf1J5kNvWiXU9hGEeiIaaoHvaMaEQEkPvIZC
   faOgmjSRbKLx/EYl6A1fqP+fiMEBttMWtUkd7pogYlBDGlPHI2cqRp47U
   DXvX7dwasOQ8r/6PrVlaUHG8Vquxh20i0LgqZSMNC+Orow3SK+vlItoCN
   9ADW1cF4hdlA3Xs/Os/9N7UJNR6hdxlySaKeZmceJk4ttYXXmWVW+KRMn
   NazqLCr8ZNaFuhwgRwGNhvPC3bUczbrjqloJLIc+tAzwBUxhMH04UgCx5
   A==;
X-CSE-ConnectionGUID: /TwclCGWQyuWzkV6Gq1+zA==
X-CSE-MsgGUID: i4BMcsnPTzKJCxgkQZPsUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33764625"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33764625"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:44:57 -0700
X-CSE-ConnectionGUID: Vf80HnypS2maDiRlGnFvig==
X-CSE-MsgGUID: BddMXMfYRbCjzSisI9OzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43646910"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:44:54 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3EF0811FA94;
	Tue, 25 Jun 2024 11:44:50 +0300 (EEST)
Date: Tue, 25 Jun 2024 08:44:50 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v4 5/5] mei: vsc: Fix spelling error
Message-ID: <ZnqDgpvC2eiZIEhj@kekkonen.localdomain>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-6-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625081047.4178494-6-wentong.wu@intel.com>

On Tue, Jun 25, 2024 at 04:10:47PM +0800, Wentong Wu wrote:
> Fix a spelling error in a comment.
> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

