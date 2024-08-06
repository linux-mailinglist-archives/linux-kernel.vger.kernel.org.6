Return-Path: <linux-kernel+bounces-275789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C075E9489CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF0D1C232DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB8165F1C;
	Tue,  6 Aug 2024 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC5kddHc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBC15A4AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928174; cv=none; b=X53Ixe8nS9zw6An+ww3h+FpjSj7jeqybjG2X3nTaHB8O62CRVYx/7Z1zoeBbdDR/UP+gPHzWsQnOLELGgkUOAyeQarXY5SRbbbX7TOx/fnMjEeoAuRFEMiDmYaa8vCOpyZswP48BKgv8ua7OEhKzgI9SSiY57JXptyn8DLSH6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928174; c=relaxed/simple;
	bh=9O/PN2ByNNX2MAC0pEpxG3lhXMK3jbOV2GGEZLJYaNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVeWa8cjE1HBqRKvm8mAKL3XPlGVBfwYgKyQmvN3dUFFjgIS4cJ0RFgfPojATrjPd0B3iocfNH5PLTnC3U0fXT6DGJOUXl0dfSB71v67WnCE7pP4kFtoKbCJ0Uq2fnOk3Hb6HXV3Oxq0DAQXayB6ozh8VsYAf2zCDpOQRbcrLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC5kddHc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722928172; x=1754464172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9O/PN2ByNNX2MAC0pEpxG3lhXMK3jbOV2GGEZLJYaNk=;
  b=FC5kddHci6q+4HohjKlASU+i6zkcWNj3EEW4dR6oWETlyk32ntBCzgiF
   TFTZDpE+1OhqDLmi3mlAHQSaNsRlHiCskf0FwsDCnnWwviCbrHjOxVlvl
   QMdxUbNMxA9Whei0ctlh4IeoDZXsABCs8tgWqsrIHUZ00hBYTAPMocZBZ
   hPdWVFx9tH5HO7SXL6yZjEOmGA/dVJJuC9g/ZMCmOtgfYVRgkCZ7KlI6S
   Fw2xTha2dvyDlR01V2Odzmw+kYwuwSlDHqnZ1VKc7ZLptnQFCFhMvcqP+
   18Ip3Wk/eQDsQfLnqh7vhYvX4sFT9GbRX72FFiZs5Omm06YBRzv73NTgJ
   A==;
X-CSE-ConnectionGUID: EcmHvR1KR1GQummcZpTJLg==
X-CSE-MsgGUID: kXclmbfLRpSwHXoTFrLvBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32329064"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="32329064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:09:31 -0700
X-CSE-ConnectionGUID: rC06mci3SC2SGLuLnynhbg==
X-CSE-MsgGUID: 1NBSZX0HRkqVvBDPy9ZlLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56300998"
Received: from unknown (HELO [10.237.72.57]) ([10.237.72.57])
  by orviesa010.jf.intel.com with ESMTP; 06 Aug 2024 00:09:30 -0700
Message-ID: <034b5511-e3c2-443d-8bac-8e5ed7095236@linux.intel.com>
Date: Tue, 6 Aug 2024 10:09:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
 <20240724071245.3833404-3-Shyam-sundar.S-k@amd.com>
 <a0f5ea6b-2be4-4fac-8c22-34fc21df84b2@linux.intel.com>
 <8ec23c64-0b55-4a71-8199-14cb6061ad45@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <8ec23c64-0b55-4a71-8199-14cb6061ad45@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 12:26 PM, Shyam Sundar S K wrote:
> Hi,
> 
> On 8/2/2024 19:28, Jarkko Nikula wrote:
>>
>> This is true, I see this now from pre-v1.0, v1.0. v1.1 and v1.2 specs
>> too, HC_CONTROL_PIO_MODE bit is present only after v1.0. And therefore
>> version != HCI_VERSION_V1 check is not fully correct since bit is not
>> present in pre-v1.0 HW versions either.
>>
> 
> Agreed. HC_CONTROL_PIO_MODE is only present in v1.1 and v1.2.
> 
> anything below v1.0, the version check handling is already present;
> 
>          switch (regval & ~0xf) {
>          case 0x100:     /* version 1.0 */
>          case 0x110:     /* version 1.1 */
>          case 0x200:     /* version 2.0 */
>                  break;
>          default:
>                  dev_err(&hci->master.dev, "unsupported HCI version\n");
>                  return -EPROTONOSUPPORT;
>          }
> 
> Let me know your thoughts.
> 
Yeah, true. I'd still use version > v1.0 check because that reflects the 
current situation. Mostly to avoid confusion when reading the code but 
also if someone adds support for pre-v1.0 HW (perhaps unlikely) and then 
doesn't need to change version check here.

