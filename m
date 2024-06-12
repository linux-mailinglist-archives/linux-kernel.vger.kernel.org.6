Return-Path: <linux-kernel+bounces-211723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83C9055FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339AE285D30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA917F4FD;
	Wed, 12 Jun 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFep9gm7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225417F4F8;
	Wed, 12 Jun 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204256; cv=none; b=Hnoi4PEUMijmodxEstz0HwyAGS7CwfXLtmhe+1kJsLQbcT6KVQCb0vd2LW3RnGbasdJMCMSQ5hEhwZVlh7s3zFjEn+4FxK980vAu8kQRO3o2qJlXYXQuS1MPp856cv6HdL3KU2LLEYyCxz889KQnoTUsHKg+vE14RivZJ6On6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204256; c=relaxed/simple;
	bh=Syu7BB0zsaZPs6cikFGcro90qjIg1ejbMOeCL8FHf6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNZ1lDzhATd/QXDJdscvJtZHnUIgsTR7OtBlTZUVbWWB1Z6yFpPGrunHD8wHwVFLD+tYzuuhiBa4nKhBMwSvTaPzekddKjMHaGGiFY7fTkHb8ib2DF5ETDtFafyz+B/zwqdLqH5gJtC6AtpG/DHo33I8EGHSqHbZB2aXMLjpVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFep9gm7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718204256; x=1749740256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Syu7BB0zsaZPs6cikFGcro90qjIg1ejbMOeCL8FHf6M=;
  b=bFep9gm7mBvmAb1WcwDrRaC+GjrQ+DWgW7AJwfqAkTBp1BZFyM2X1RHz
   1tiFiGbmvHI1j07/18WoKxgq3qrv83iBSrvOj/B2nU7T/SI9ozLZz1Sa+
   V2/GBcLVhXAfyr2OMLdxS0TQm9xfTjvDUeS3g70hqcAjjx9TuhcXNOdnU
   HdAH6Zzds9+9gy2xqwjxUrT5wSJapQvsf1YCIP2c6T4PI06Ct3q6Ti4uk
   8ZmFYZ7A2yM1sD588OtVmDCmtDXDsDxPawOnOOzyGW/B1TYA4ptIU7lYh
   /S9qlgeQbRVklRBMAnjzEBH7BcmMkqSK8Mt0IH1i9yCLWrRyuYyZz3GDn
   g==;
X-CSE-ConnectionGUID: dZRmq3roSlKuvms0CF8hTg==
X-CSE-MsgGUID: j2W+0gGzSm28z8nldDEwrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18798689"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="18798689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:57:34 -0700
X-CSE-ConnectionGUID: ZXmtThsIQQ6tImepGZ/AOw==
X-CSE-MsgGUID: /g+wx0HGThGiYikLxyvHkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="39927202"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:57:29 -0700
Message-ID: <d5c6fff6-68ab-4248-814b-41b77d7105c8@linux.intel.com>
Date: Wed, 12 Jun 2024 16:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 17/32] ALSA: usb-audio: Do not allow USB offload path
 if PCM device is in use
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, broonie@kernel.org, lgirdwood@gmail.com, krzk+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
 robh@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240610235808.22173-1-quic_wcheng@quicinc.com>
 <20240610235808.22173-18-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240610235808.22173-18-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/2024 1:57 AM, Wesley Cheng wrote:
> Add proper checks and updates to the USB substream once receiving a USB QMI
> stream enable request.  If the substream is already in use from the non
> offload path, reject the stream enable request.  In addition, update the
> USB substream opened parameter when enabling the offload path, so the
> non offload path can be blocked.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   sound/usb/qcom/qc_audio_offload.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Patch title is missing qcom part and it clearly touches QCOM code.
ALSA: usb-audio: qcom:


