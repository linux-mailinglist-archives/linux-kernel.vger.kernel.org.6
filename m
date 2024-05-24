Return-Path: <linux-kernel+bounces-188476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F488CE277
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0952830B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401A1292DD;
	Fri, 24 May 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NK7Qp/jn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6177208A1;
	Fri, 24 May 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540189; cv=none; b=gRjtZxGVnzy04LbqzxURb0kMLu5mtP6nFJZg9uU/jic3+QmD2coWtvTOFSaFXJhN1RMT+qlk/+//cJQqxfQIMnMF05vgG3P6Xrerc+8O7jJY8uOoOHDrIjkUIuMA/yMtY0fHOH98wfw5zt34lHij4v8PtQ90b7bghg9/dICPCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540189; c=relaxed/simple;
	bh=09omjS6n6bS+Mok1qvfUhKmY70yiq+Ar+KIThZ+ukvE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=O3kvYj22Ea1AW6AcTnp/Eqx+2/iTERTaiUwRAgzocTfamxBmubWc9K6VbZ+vAm1MO44kRskTgrrYXoXVx69MlYZ4SHMthdwCZLOTyxenYWYBCb1X+j3Pc2qSGoLfz1EQBXZp55xMUHF2zjw0NpSRc+fzKVpwv6fJ+y7MpQQH8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NK7Qp/jn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716540188; x=1748076188;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=09omjS6n6bS+Mok1qvfUhKmY70yiq+Ar+KIThZ+ukvE=;
  b=NK7Qp/jneVJZ2dvmJ/15/dtQ4h6McwL/6OZ0/9IYAJ3PYU3xot+MSjvl
   YGSuv4GaIk6Fs403sFysc80AXsXCgIaxdqTsN1U1LNSYk82qlG6Yauhop
   WoKoRLJCnySE9QSPTyV3FB2jIIuGWjwbg+OcQJY/Dw6VZUXR8t+/kx/XW
   WKdb+S3TC8IWMAspHgkYjPrz+vmA3iz/K5IdIUCEyQVMeWQJN2qVl+yi8
   /FkbKaeIsYAU3Sl3K3i3Ge4T7NDGVNFExs0Xf6CJVuCc4TvPoqMsLThIP
   Ox4xumzDQXmfUJpF8iCml/Kz5J62E7Hs8rUPQDnaNF1cAfShm76Ye2ig3
   Q==;
X-CSE-ConnectionGUID: gNwfOOazRnG80eliCfMf9A==
X-CSE-MsgGUID: Kiyj7K97Qjq2vED9MragBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="15851903"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="15851903"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 01:43:07 -0700
X-CSE-ConnectionGUID: PuiP2VxpS+u6Q76viLtA+A==
X-CSE-MsgGUID: NxtB4KGLTXCQx9XJji0+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38370718"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2024 01:43:05 -0700
Message-ID: <768a8ca8-2ca5-1c41-16c2-b0b0421ce645@linux.intel.com>
Date: Fri, 24 May 2024 11:45:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524-xhci-deadcode-v1-1-a4453a756e0f@marcan.st>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Remove dead code in xhci_move_dequeue_past_td()
In-Reply-To: <20240524-xhci-deadcode-v1-1-a4453a756e0f@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.5.2024 10.07, Hector Martin wrote:
> This codepath is trivially dead, since the function is never called with
> a non-NULL td (the only callsite is immediately preceded by a NULL guard).
> 

Yes, thanks, adding to queue.
Comment below tells this was destined to be removed earlier.

> -	 * We shouldn't hit this anymore as cached cancelled TRBs are given back
> -	 * after clearing the cache, but be on the safe side and keep it anyway
> -	 */
> -	if (!td) {
..

Thanks
Mathias


