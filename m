Return-Path: <linux-kernel+bounces-364088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA099CAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D531C2374B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D31AA7A1;
	Mon, 14 Oct 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SahEqF1d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF71A4F20;
	Mon, 14 Oct 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911204; cv=none; b=QhPIf86oSv/u66UAUBSQb+0AgCOLpwxkPgoaWIZA44zWZqCmCQJ8CK19x37axg4nfBol18aAFPJPzIquN0K9Uk3SWc3pIPDUUcWNnWFJQl43RNdOTkTA4e2rC6UpXhX2nRVEHbCn3fevsGdmZXwegyfi5GjIZ6/yE9+dtkwuKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911204; c=relaxed/simple;
	bh=PTBOYMEy5sDrtcwT6alRgPl5WDMXK8h4WMrdqBbUtyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqPgtn+mQmej73Mgam19roOtaUKsKZP+ykUP/LjjUzKbVilCo23r4zsc/YtmlVasd+rTMk28DxXbDKwScAb67Br3x2hgmLjbA6PbTO4CXJ8x46B9qq6xy+CzG5skLrsbiDv2WUgloDyNcCWmOGzBScpA9gzDTtZyF7wG/N5mIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SahEqF1d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728911203; x=1760447203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PTBOYMEy5sDrtcwT6alRgPl5WDMXK8h4WMrdqBbUtyI=;
  b=SahEqF1dxhBQi2YZ07lUHo55+o6bkqydkvG/rvAu99YqrdH31xR/YiZn
   yokMsqafjjbKb50aVmO0Ihuchp60SlpE2cyxqkJca9isRPoBSliIeW6vJ
   BbemQ86VrbPmktJdB+TAC1jufZYTeuROL7LsOmDw3oVUJuPaj1KIRugkI
   sJKdlcWdSQb9ooJ9TZMO1Fw3jytU5jgptF6H1p7cGBdSyGF4e/2qlSfWq
   +zwKFfQhZ+KcCnMNbJRX8qTnbZDd4Yl+r7zXh6kW3ppWupVoFENSmUSZi
   suzFRR2ET0fEXFJPX/FJ7qKfSIZ6zpal3IUlhs6cszZh3WoFGzWPLHQMZ
   Q==;
X-CSE-ConnectionGUID: tK0wPuleRpSBv+uQjJErnQ==
X-CSE-MsgGUID: 1bUvLy8nTj++GxlgQ16oNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53678612"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="53678612"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:06:42 -0700
X-CSE-ConnectionGUID: E9t8hJZtRi+7bkSsKuDGBg==
X-CSE-MsgGUID: mzLeac+ZReall9eN25SgHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82192851"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2024 06:06:36 -0700
Message-ID: <afc9fa53-b7f2-45d0-bd30-8681b71beef5@linux.intel.com>
Date: Mon, 14 Oct 2024 16:08:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] usb: host: enable sideband transfer during system
 sleep
To: Guan-Yu Lin <guanyulin@google.com>, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 stern@rowland.harvard.edu, yajun.deng@linux.dev, sumit.garg@linaro.org,
 kekrby@gmail.com, oneukum@suse.com, dianders@chromium.org, perex@perex.cz,
 tiwai@suse.com, niko.mauno@vaisala.com, andreyknvl@gmail.com,
 christophe.jaillet@wanadoo.fr, tj@kernel.org, stanley_chang@realtek.com,
 quic_jjohnson@quicinc.com, ricardo@marliere.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, badhri@google.com, albertccwang@google.com,
 quic_wcheng@quicinc.com, pumahsu@google.com
References: <20241014085816.1401364-1-guanyulin@google.com>
 <20241014085816.1401364-6-guanyulin@google.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241014085816.1401364-6-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.2024 11.50, Guan-Yu Lin wrote:
> Sharing a USB controller with another entity via xhci-sideband driver
> creates power management complexities. To prevent the USB controller
> from being inadvertently deactivated while in use by the other entity, a
> usage-count based mechanism is implemented. This allows the system to
> manage power effectively, ensuring the controller remains available
> whenever needed.

I don't think all this is needed to prevent USB controller from being
deactivated while sideband is in use. The modified audio class driver
that uses sideband is still bound to a usb interface device, and all
normal pm reference counting should work.

To me it looks like this code is tricking pm framework into believing
the usb device and host controller have successfully suspended during
system suspend when they in reality are fully up and running.

I'm not sure I fully understand the case this series is solving.

Thanks
Mathias


