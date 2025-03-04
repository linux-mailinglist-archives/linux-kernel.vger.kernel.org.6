Return-Path: <linux-kernel+bounces-544014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68DA4DC63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9575C16DB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02845200BBE;
	Tue,  4 Mar 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcYoZu7Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE11FF603;
	Tue,  4 Mar 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087196; cv=none; b=BKpM2qp5n1VVCaQdkPLQ8juFWvXlo4fWm4HCG2AGHDfD5ldHH94Oi8rEPrPD37xpjLNJBQu9CBaaDDD1nlQ1DQsAkPvnfhJQHTts2n3A58fEVvjXc05OEFsvMutEbsLAoEU+8J3whnlDpn0aYw9FbFaRI3nlrBm3fj+ZvYub+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087196; c=relaxed/simple;
	bh=aXLCirbqyqWDKSeNtGLe0XfGC1wfdwoT5HSgi35c4K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q02GVi/CmcLUT/HZOpteJzlEsE15ZXxoq8lr+WzLaJcpxg04WWeXEYjHnzO3/0cd93mauDQUMND6E+vKTq1e9qDXPIoN11KUxhCqNSY+rCxK2huBBCl4OZ4Z/YNrsBxkZK2fdOjV3DSJQsufAQ93U97Wm6K7czOFi9K+GX40L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcYoZu7Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087195; x=1772623195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aXLCirbqyqWDKSeNtGLe0XfGC1wfdwoT5HSgi35c4K8=;
  b=DcYoZu7YFdjqjGyb+uYCu/JZNVEKX8OOBzSqklZ2CziwnTdiqWJM2a0n
   J8jpRox5G0qB2BWFfbItqlzxCOEjaNQXNfSuEZxUAjLqRbtXpIcqHY4n9
   UKOH1PY72o/AtLXdG0O5ss3QJ9T4jGlUGn4RPXwGhnHGfHL4tB+xAzV+O
   GWmUqFIe3SKRl2mpSTDV63mw7ZKAAHHy0FqitFrtiKUU1O266ep/jJQ4a
   o8RptWf3pj5t2u81UR3JBTKwZRAGl1MBOmBh9vyQHLRsdu7tViO7L8Q1u
   zEqbJb6aSRIQTQusFO1r7kNjX9kDSz9k/yoH5OPupy521s68syMLXE7w5
   g==;
X-CSE-ConnectionGUID: G0/OSRP6R36Ry/6hORFx1g==
X-CSE-MsgGUID: Bu4njEMaRvOXzIp7u2OAiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53394452"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53394452"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:19:54 -0800
X-CSE-ConnectionGUID: wu6sXiuUTh6HXY84GWZRDg==
X-CSE-MsgGUID: Q7UiYmqsRbmAalYOYuUmHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118833812"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 04 Mar 2025 03:19:52 -0800
Message-ID: <855ed817-03da-4e6f-9c4a-898edfcafedd@linux.intel.com>
Date: Tue, 4 Mar 2025 13:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Fix host controllers "dying" after suspend and
 resume
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304085139.4610e8ff@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250304085139.4610e8ff@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.3.2025 9.51, Michal Pecio wrote:
> A recent cleanup went a bit too far and dropped clearing the cycle bit
> of link TRBs, so it stays different from the rest of the ring half of
> the time. Then a race occurs: if the xHC reaches such link TRB before
> more commands are queued, the link's cycle bit uintentionally matches
> the xHC's cycle so it follows the link and waits for further commands.
> If more commands are queued before the xHC gets there, inc_enq() flips
> the bit so the xHC later sees a mismatch and stops executing commands.
> 
> This function is called before suspend and 50% of times after resuming
> the xHC is doomed to get stuck sooner or later. Then some Stop Endpoint
> command fails to complete in 5 seconds and this shows up
> 
> xhci_hcd 0000:00:10.0: xHCI host not responding to stop endpoint command
> xhci_hcd 0000:00:10.0: xHCI host controller not responding, assume dead
> xhci_hcd 0000:00:10.0: HC died; cleaning up
> 
> followed by loss of all USB decives on the affected bus. That's if you
> are lucky, because if Set Deq gets stuck instead, the failure is silent.
> 
> Likely responsible for kernel bug 219824. I found this while searching
> for possible causes of that regression and reproduced it locally before
> hearing back from the reporter. To repro, simply wait for link cycle to
> become set (debugfs), then suspend, resume and wait. To accelerate the
> failure I used a script which repeatedly starts and stops a UVC camera.
> 
> Some HCs get fully reinitialized on resume and they are not affected.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219824
> Fixes: 36b972d4b7ce ("usb: xhci: improve xhci_clear_command_ring()")

Very nice debugging, did not suspect or consider that.

Thanks
Mathias


