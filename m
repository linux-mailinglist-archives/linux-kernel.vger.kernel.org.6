Return-Path: <linux-kernel+bounces-443203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D39EE8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC1B165F38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B72721576E;
	Thu, 12 Dec 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCRuNuef"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF4F2153C3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013692; cv=none; b=ruYDlnItvlz2egzN0rQts8GjqR9oCc954QxDbf3+HYN9DMjzeDU+RmMGG+EQTb7pHQ76d7c1Pablbh/F1Wsn9cxuy9CkIwxwrKUbcMGqCgWGdoSHZ+8sgpSoJEEc9hrl5cKLUXV6bUN1cxDmbf07NQE3xPapw6Bkc01ns+3rpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013692; c=relaxed/simple;
	bh=aSS5bgRidjiUxFisenmsNuxcGznEdMlJmfdI0hJT+Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQjB+ToF596CsjOx/CW+1EhYeqH2Z38KgmElDUa8UQWzPLUL7Vm5ATdlJI7bEJWb4vkZu/Mg566zEtJSM5IaXY4zJPyoo5lUcyGY7c8x94uyupnAu8L6mBpcIHAx/IbdqC/Hzo02iXz+/d3e5PvLK2Szj/4q6RKUNV0sDn42knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCRuNuef; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734013691; x=1765549691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSS5bgRidjiUxFisenmsNuxcGznEdMlJmfdI0hJT+Mg=;
  b=DCRuNuefHVI5kVBM26WAz5UfLeMXnhrx6W1Ba1OCihF0qSxb2f4gNTJP
   gQSf719VoRnaZrSDIEpjynqKFIGmH6ukvg0uDS+Wxeelllfv11DI6xhFu
   PyKDcAWzyNqsgXHo7w2pNdUS7Kxwdij7jAvhNGyE8lZhdXpNq93vJF1g+
   6J+KXGfuTQ5cA1nrDjPdvj3xmbH4xaYxmSpeP9kHq2uxpew1/s2XMGfU9
   rFHZQbDG5sK7dr4QTceorep534njT5vwpLYeJtyerLdpbOtOND1Ms0dOg
   ON5Xoc6wKQgyrHdd5fgj1S+n88yP/XxmPO0Ma/undR0AD+SF3tObHXiDz
   g==;
X-CSE-ConnectionGUID: 5h+fjSnrT72xrJCW8iXwcg==
X-CSE-MsgGUID: UJ3dEqdYS9aAh3TaKldb1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59827453"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="59827453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:28:11 -0800
X-CSE-ConnectionGUID: pdXdrzLYQ3aqO3gfNq19Uw==
X-CSE-MsgGUID: wR2vFy1CQeaEFtYp+uTurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127232169"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:28:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLkAg-00000006vBd-3xEo;
	Thu, 12 Dec 2024 16:28:06 +0200
Date: Thu, 12 Dec 2024 16:28:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: Drop unused devm_regmap_*_free() APIs
Message-ID: <Z1ry9spQeA6B1ImP@smile.fi.intel.com>
References: <20241119142915.2339362-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119142915.2339362-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 19, 2024 at 04:29:15PM +0200, Andy Shevchenko wrote:
> Besides the fact that currently defined devm_*_free() APIs
> are being unused, it's usually a sign of bad design to call
> such explicitly. Drop them and make people pay more attention
> on the misuse of devm_regmap_*() APIs,

Any comments on this one?

-- 
With Best Regards,
Andy Shevchenko



