Return-Path: <linux-kernel+bounces-268916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC50942B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF111F21F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3B1AAE06;
	Wed, 31 Jul 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSIk9tdP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BC16B395;
	Wed, 31 Jul 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419247; cv=none; b=RbIRlzBtLj9Nu1wqRcwJiH9CX6sTtB+LMvz2zPGsl8vnWoPT1jUeJepuZkasfOXHFdzabkihqT0iHbTN61lV7ekrf1RFwwxLwhp3OQVU/94BJqrEvqnbPU74CvpRfM7p/dCkRT04WOLCZOI7orOkIZsqppichkflKzdunen2bQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419247; c=relaxed/simple;
	bh=AGXgFWGPvCkQywQFuD8KV4/KxjstWINHIpS7W9YsYhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyKE6ByHVSmlW4r7Hi366gFPHodBlkBzOmxf99vDDq2UUDqZgS9T/a/JqfKs7j9ss/12v7yVZGyPIFfGKcE9485/juGRZjST4ncQv+FNPZa9jVcg2JkH7C4DUYoCAlh/3JvCNqQpJKD2Fue292y7xmDru3wDEk8Ku70rEamcmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSIk9tdP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722419246; x=1753955246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AGXgFWGPvCkQywQFuD8KV4/KxjstWINHIpS7W9YsYhU=;
  b=aSIk9tdP30aGhkE2uLX9oRQAzWRxBlE0saASdT7AgYRmSIC3d36EX2vo
   677yTL2YG/qifVnHN/Uu8Wj1gaDnCO/AeH/fWWs+QBB3Ev2S9gChpeEtu
   biJlhBeRAH2qnL8A9EH7hXH38jRHddRRIIVt0wIggzdn57YgIz/4dOOrK
   8d3ECsSEuhwGZPk1J7MCW1u2ykXEn7TBAuaY2YLx7FvaO/pZxsFs0hvkm
   KvukgMsOVyxRBFVZLbQPzHToc23+U2l3uERn81Aw82W3t86oJ7gNaFizu
   gYBeAk4ufNE/hYuvLz7JZaWtjVmMEJAKw5VN0HkWBI2W5WqzEx9TkRxx8
   A==;
X-CSE-ConnectionGUID: Zglfi/kjT++FpY3O65/UhQ==
X-CSE-MsgGUID: MJ+5zBv+TGuP2/W0kym+aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19876878"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="19876878"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:47:25 -0700
X-CSE-ConnectionGUID: 5f0OupZTTFm3hSPIojK+pA==
X-CSE-MsgGUID: SnWXh8EgRV+pkCAph7Or6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59481339"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 31 Jul 2024 02:47:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 12:47:20 +0300
Date: Wed, 31 Jul 2024 12:47:20 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] usb: typec: tcpci: fix a comment typo
Message-ID: <ZqoIKCTYIaHYoMXe@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-1-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-1-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:08AM +0100, André Draszik wrote:
> autonously -> autonomously
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/usb/tcpci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 0ab39b6ea205..d27fe0c22a8b 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -190,7 +190,7 @@ struct tcpci;
>   *		Optional; Callback to perform chip specific operations when FRS
>   *		is sourcing vbus.
>   * @auto_discharge_disconnect:
> - *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
> + *		Optional; Enables TCPC to autonomously discharge vbus on disconnect.
>   * @vbus_vsafe0v:
>   *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
>   * @set_partner_usb_comm_capable:
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

