Return-Path: <linux-kernel+bounces-554360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F5A596C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610637A503F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481222B590;
	Mon, 10 Mar 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwkcmgIT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0322AE6D;
	Mon, 10 Mar 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614793; cv=none; b=UzNnKqvvgZydWvgWbto1P5s0wCzXS6Xzp3R7iJHkIVKkuqQ7+8EJlSgR7/+JE1lKM7lovxq8+RHqvv/q2fxayDetAeyc7ysnW1e31VvERflWKiEZKG1bmqTSEOq9HKUJl1WK56WOAnkNX8/FC9wcV+iiB7rSOXkjcL1Zo0gwQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614793; c=relaxed/simple;
	bh=b+P4vKkK142ylgc34PXD4AdP2x7aUnRfBXYHIS1TtRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVyieT54uOBW3IxsEFhI/2IrTLm+/srCb6/kaP8VOa/lDLF7g88kii9SN7cuIQrpl8fegs35LF4YGZuqB5Pn2YEAoQTgFRlSjMYA9Q0LM2/sQ2PgD9QHRNmswEesrvvGXhaCNwZg7ZdhzKS6trZXnSW/xxOyF8Bh7NGtfH3OG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwkcmgIT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741614793; x=1773150793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b+P4vKkK142ylgc34PXD4AdP2x7aUnRfBXYHIS1TtRY=;
  b=NwkcmgITt/uXh+74nX6qYuFgYzUA6/GP1ywwjxRuNC7dkMhB3H9XhWe8
   iCQ+ohfrm6x/TuurQlK3FOBH5Fb9jZN/8OI3yITli+S8Ef9q642GPqsDG
   1473xllGMEEwSffGIV7KijWjIfTznc6S40HxxSzMGQ+cGf5VUud2b1YkP
   bLUbwAP3nKytRIeLHqqjGMwOC8Ic2gun0jEmAsvTermyqrOykqrf729Ug
   HCF8eTHNDfUWuaC/vRWiEP4gGJzTIuLOzDkiFfIyRvGSCk/vQ40GUCdVu
   MbBk/bU0Fg89u/JZiNIaLcnGmpahtluGKFoDks+hJqrttfc7HE5/pEKp/
   A==;
X-CSE-ConnectionGUID: FZvlbWONTEOQy1IvRiVF1g==
X-CSE-MsgGUID: p4jL86nARbuxY8TZdZh7kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46519404"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46519404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:53:12 -0700
X-CSE-ConnectionGUID: IoWGwWhwTnqZxjnweKexBg==
X-CSE-MsgGUID: GGzU0XmXSR6O9wlBy0n8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124170270"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2025 06:53:10 -0700
Message-ID: <2e3372fb-5eed-4259-841e-4af5ceeebf76@linux.intel.com>
Date: Mon, 10 Mar 2025 15:54:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] usb: xhci: Don't change the status of stalled TDs on
 failed Stop EP
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310093605.2b3d0425@foxbook>
 <20250310094037.52625e24@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250310094037.52625e24@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.3.2025 10.40, Michal Pecio wrote:
> When the device stalls an endpoint, current TD is assigned -EPIPE
> status and Reset Endpoint is queued. If a Stop Endpoint is pending
> at the time, it will run before Reset Endpoint and fail due to the
> stall. Its handler will change TD's status to -EPROTO before Reset
> Endpoint handler runs and initiates giveback.
> 
> Check if the stall has already been handled and don't try to do it
> again. Since xhci_handle_halted_endpoint() performs this check too,
> not overwriting td->status is the only difference.
> 
> I haven't seen this case yet, but I have seen a related one where
> the xHC has already executed Reset Endpoint, EP Context state is
> now Stopped and EP_HALTED is set. If the xHC took a bit longer to
> execute Reset Endpoint, said case would become this one.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>

Makes sense, nice improvement

Thanks
Mathias


