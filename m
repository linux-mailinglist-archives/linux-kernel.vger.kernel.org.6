Return-Path: <linux-kernel+bounces-513031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4AA340C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09CB3A98DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9E12E7F;
	Thu, 13 Feb 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJM6KeSM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443518BEE;
	Thu, 13 Feb 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454729; cv=none; b=TbAutr5YOR+eZAKBWUcsSnD9W+8ZWx0MfSOd2Yfi/xRMKkEy2VVSQ5zFXI9eWpZ+TD0hirZN62NkeHL81XxMtA9Noigyu5m0eNMEyspPF99k26KeYdr4BCLNnW0+B7F2zl8Qz3DNyUHqW31AVdbLrFp99HW5vA6AgQ1FIaa/Izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454729; c=relaxed/simple;
	bh=lsntWK4tqPye8Ew5DO4nfMb1ImyVK+qFVpL64GvAbWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVoxYhTSZLNiYU6UMyuzrLzOyx5SKSxP7HBgMblccH+7FIcus3QNUqz7pU6n5cUpk/FvxA1r0b4f9hvtNfUUTM3eZtam+mckH1LAe0Xe3DR7Gqd9E93X9FVHqzjrVk9sTHEQ0dNPk/KeXcA08/w+rIqGYX991X0EvzNkK6qJa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJM6KeSM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454729; x=1770990729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lsntWK4tqPye8Ew5DO4nfMb1ImyVK+qFVpL64GvAbWA=;
  b=IJM6KeSMbZxFG/E19xTdREC4d/MKdEzC22NMMM/KUsFwLvoHxyBESAWx
   bG97AvdEhRaLGbpqkBBalJ/usGHwI78rtlUN5FIGpSlij2BWdKfd432dN
   M7a8QPDRFeviRc4fuqBZr5FkJglcyJK9us7v2SnhJKG8bYP7WFN9Gs07b
   MMHbPp46Xb1Eqw2IcqyD2IbZx01dzjrVoWweACpFWjkeGB1ystVSZ+jl5
   JYIZb1OrxMDUJAle1GF0nCSb98qBEIjpKl8CChMf/kQSUXqZNxzaLUYnl
   SvVNZ81av8g37BGdk/mS/6L787LQABx6Dek/WAwQgR2J513Q2xInsc8tW
   A==;
X-CSE-ConnectionGUID: f7JemYz+QFe2Ogu1P46o3Q==
X-CSE-MsgGUID: ObNJZ5aDRqyh/mhnvlsyAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40075699"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40075699"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:52:08 -0800
X-CSE-ConnectionGUID: EPpLeFCrSKuuRSwhzCOUpA==
X-CSE-MsgGUID: hNvfYQtoTO2XUd1Ve4v6Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113645273"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 13 Feb 2025 05:52:05 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2025 15:52:04 +0200
Date: Thu, 13 Feb 2025 15:52:04 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: joswang <joswang1221@gmail.com>, Benson Leung <bleung@chromium.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH 1/1] usb: typec: displayport: Receive DP Status Update
 NAK request exit dp altmode
Message-ID: <Z635BJNnFAiIFXxM@kuha.fi.intel.com>
References: <20250209071926.69625-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209071926.69625-1-joswang1221@gmail.com>

On Sun, Feb 09, 2025 at 03:19:26PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> Although some Type-C DRD devices that do not support the DP Sink
> function (such as Huawei Mate 40Pro), the Source Port initiates
> Enter Mode CMD, but the device responds to Enter Mode ACK, the
> Source port then initiates DP Status Update CMD, and the device
> responds to DP Status Update NAK.
> 
> As PD2.0 spec ("6.4.4.3.4 Enter Mode Command")，A DR_Swap Message
> Shall Not be sent during Modal Operation between the Port Partners.
> At this time, the source port initiates DR_Swap message through the
> "echo device > /sys/class/typec/port0/data_role" command to switch
> the data role from host to device. The device will initiate a Hard
> Reset for recovery, resulting in the failure of data role swap.
> 
> Therefore, when DP Status Update NAK is received, Exit Mode CMD is
> initiated to exit the currently entered DP altmode.
> 
> Signed-off-by: Jos Wang <joswang@lenovo.com>

This looks okay to me, but Benson, can you take a look at this?

> ---
>  drivers/usb/typec/altmodes/displayport.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index ac84a6d64c2f..b09b58d7311d 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -393,6 +393,10 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  		break;
>  	case CMDT_RSP_NAK:
>  		switch (cmd) {
> +		case DP_CMD_STATUS_UPDATE:
> +			if (typec_altmode_exit(alt))
> +				dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
> +			break;
>  		case DP_CMD_CONFIGURE:
>  			dp->data.conf = 0;
>  			ret = dp_altmode_configured(dp);
> -- 
> 2.17.1

-- 
heikki

