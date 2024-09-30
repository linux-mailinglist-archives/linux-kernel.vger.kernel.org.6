Return-Path: <linux-kernel+bounces-343567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBD989CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F4B1F21FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270C178383;
	Mon, 30 Sep 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STxir4xm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8904204B;
	Mon, 30 Sep 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684700; cv=none; b=rtudSqNtnMPyweCI7rdFiDuTzIif04DMjmk/i24NH7/sN9/PoIh1FiEHNqViZz38kl33iJKcgbO1VR1dShBio+04Kuh1NLff6THLdFEwwk/qxOwuNxLhqwEm+gFfl4SqlJwQ04a2gEF56S9hljS/++AXzWxHqb0n00WhgroHYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684700; c=relaxed/simple;
	bh=mOhG+WAARAPKOcsmCH2OQx1L91bTwJXenzBkkgTQ7ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6qVVyIv6pOKpW6RyLMGm+FZNGiYCCuYkhSGgej84IJXfcQL0XXSquKShURDw0HgY3U4TBfQ0ixgzcpWbnh1EuJOecIjnpCBpZYnQOspPAS/nV6IgP1KNdNqXCPcOjjjHsvDoawLitlm8O4mIVv9Sahf7ujVuiCGx1o1/gaGAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STxir4xm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684698; x=1759220698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mOhG+WAARAPKOcsmCH2OQx1L91bTwJXenzBkkgTQ7ao=;
  b=STxir4xmROs8yQKrEgyNxTzoJpA0z6aEzsVgzjrBXkyRmk5MuP2tWGDG
   izKfHvOMlvLkyHtunUQrnbYuljtEBAZa1v94vBb/NGxcmLeEQT+TiYSmg
   6/9AFPJ71a5zkbXlp6ODoa9+ZRMT+e9S206VTUXUhx3uJ5bvx7L61J4nk
   tmniTeGhGsKea78qNc+/n535uENTSOKqnSX5z054LMKxW4dC8p2oscHek
   qhGvmtWvG5gdlVTU5gGFe4QgLnLrrs8WBJ68110nlkKJzxFzBGre66IdT
   gE5atXiY35Hd76q8vqwecoH/+30l7Nj4n+e9VGySPFCOh6dDA32xVftmw
   g==;
X-CSE-ConnectionGUID: QToiLAmzSbaGVg1ihB8DpQ==
X-CSE-MsgGUID: 9Mb+VKgmQQ+ud0/Zvnwiug==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="14384004"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="14384004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:24:57 -0700
X-CSE-ConnectionGUID: eNNzLVpQQ0iKa/Qu/87zCg==
X-CSE-MsgGUID: Y9L6yIlYT+6ZNiq2W4IDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104016205"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2024 01:24:55 -0700
Message-ID: <c4feb8df-5204-4197-962b-f9ce6d6d1b4d@linux.intel.com>
Date: Mon, 30 Sep 2024 11:27:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: debugfs: Add virt endpoint state to xhci debugfs
To: WangYuli <wangyuli@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, raoxu@uniontech.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 guanwentao@uniontech.com, zhanjun@uniontech.com
References: <63B520E210CBE3F6+20240920051159.1363806-1-wangyuli@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <63B520E210CBE3F6+20240920051159.1363806-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.9.2024 8.11, WangYuli wrote:
> The ring data structure of each xHCI endpoint might stop sending
> data due to the virt endpoint state.
> 
> Show the virt endpoint state within the endpoint context via debugfs
> to facilitate debugging.
> 
> Co-developed-by: Xu Rao <raoxu@uniontech.com>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

Added to queue,

Thanks
Mathias


