Return-Path: <linux-kernel+bounces-406236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839C9C5C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD2283F93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF03202F60;
	Tue, 12 Nov 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgxm+1ym"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B6202659
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426658; cv=none; b=XJ80Oq98tEcB/cfMWDOhpI+1XBZzuXHU1/Z49bK/QQ4fu99DinwD7iNA3EH06FHMJoIJPqr9/2jziIgtTeL6X08V4ba0oeSEmv7XtsE89M81NJZsvDQlKocM9KeGuauuB/PFKq+yPaoW/tMR0sTJE6YOqTL78Nu9+hJhfWgRdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426658; c=relaxed/simple;
	bh=EG7HdwcMBaAYnoAW544SINCcdo5I0uMOQId0Jkoslvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC0NA9iMCfF6bOZ7ArKTNBuuXNHtq+Q4h+WejcfjkNZp3y0TkCree9ceM1g1Xwx7VJ2hvxg7VpBcYSC9e+uDBIVmx3D2AnlkJHGDZLNBlygtgWlRGt/nliO5wcS0vLgAKPxlGH8yPJOay4LizCMMifn9wjKL+CoY/XqOFzuVw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgxm+1ym; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731426657; x=1762962657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EG7HdwcMBaAYnoAW544SINCcdo5I0uMOQId0Jkoslvs=;
  b=cgxm+1ymx7hl7U83xmsybQzCqXlmFvj5qcCWZ5y3lZS1VIVn78MIo4hW
   kE2lZZ7EvnfiuQuGMwar0rRS0CT9G0cjbj39UKhIkw0gTbLUeuNLT9Jxk
   S5I/XI0iDOk+qJxlZ6yhRpSPIrK0dOgMnOQudm+jim7cyvh2+dd5Q6Izn
   BsTdrnQFseoE1csECbGl4hzNlm7gp5QnqCBN+pGBllkMfY+VbFMDoI11Q
   gYwooTNRFjYG/90oXNaiU6dxLRrEz3wd3uyR+z9cOcNgrNtUMENyTBhQh
   SvVjqQykNZ8ZQSORl8Mn5SkomrE3G7hY7Jkl197385XcMZ2CKWqgnBScn
   A==;
X-CSE-ConnectionGUID: pxYh6HYhTJ+ZiMf1ZBorLg==
X-CSE-MsgGUID: NcD7Gj4NTUyMutESA8vVhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="30672132"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="30672132"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:50:56 -0800
X-CSE-ConnectionGUID: aBvPBYQUSuCArTQNGC+/ZA==
X-CSE-MsgGUID: fEsFuvHESNWTIOqjJbNVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="88348091"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:50:56 -0800
Date: Tue, 12 Nov 2024 07:50:54 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mce-inject: Add an MCE injection case with the
 yellow status set
Message-ID: <ZzN5XvH80AEb5ksE@tassilo>
References: <20241112073729.66059-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112073729.66059-1-qiuxu.zhuo@intel.com>

On Tue, Nov 12, 2024 at 03:37:29PM +0800, Qiuxu Zhuo wrote:
> Intel processors with the capability of 'threshold-based error status'
> use tracking hardware to monitor corrected errors of certain hardware
> components (e.g., CPU caches). If the tracking hardware overflows, a
> 'yellow' flag will be set in the MCI_STATUS[54:53] to indicate that
> the corrected errors of the associated hardware component exceed the
> predefined threshold. If so, then the system may need to be scheduled
> for servicing within a few weeks.
> 
> Add an MCE injection case with the yellow status set to test whether the
> events of threshold-based corrected errors are handled by Linux kernel
> or/and the user-space tools like mcelog or rasdaemon.

Added thanks.

-Andi

