Return-Path: <linux-kernel+bounces-268966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE83942BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195F92817B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8D1AD9CE;
	Wed, 31 Jul 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C53//iIJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F01AAE1F;
	Wed, 31 Jul 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420647; cv=none; b=ipCZIX1WpiOGQjaVvHzN5aI6Dik6kWladFHWXSEhj9AHsXZSfzX6Z+pIrRRLKFU0+FEifOp/mAtBSmqPeQWL+ZMdyNnhtWvV0szqgMfZcvXNGvAZ/s9PjmaV0ag8Ia6xPfAvVJZQDH2b4zcPRxNoZWhVdcuEtjG9Ks/icrqEnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420647; c=relaxed/simple;
	bh=EC/I4HMf2izPt7LJUZ/v40jJVDPJ4o4ird85WQKKpqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX0rfkOX3as1GCROwR+T5cRLS4R0rKAeU1yjhqRgf5Zy6RllBDkpx7+DB7Q7GiVluu63TtGid0ZzkRTNDJU5U52N8DDTvlpoLhPnq8nd378l+4hwmOOex6N2uOw5uh4/3FNo+gfazqHdmIJAxJCRkr0urM4iEXu628GhilGt2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C53//iIJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722420645; x=1753956645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EC/I4HMf2izPt7LJUZ/v40jJVDPJ4o4ird85WQKKpqc=;
  b=C53//iIJu2dX68909cuv+75N314BRmEw3eikeDztUaZdSuAJmFywvKWb
   T/iYVPFVhyKsTFSuM40hFRI1YcNr/muUGV9DdwMzRzgtimxSgfpTc5OOU
   JRmlzTGIyYULvP4xNoNQSziuMo684OJ5gcIY8vg4sqSGSXvgIHtOc3tmm
   Ma88zR9kHyAHD8OfCsScg9RC8+cAf7lrmqhE7dLqMOy4XEBEHpd2DGH+L
   zgxsVMQtLuOhCfa7s0fdpsik7vkgGqjYK+v+3ioMHdvRh6o0/jWw7Gs0q
   b+NadrSq4MFDoWMjxziGAf3JpltPytaj3w9VVkDe0Xsr1HzYHzaCQR3mx
   w==;
X-CSE-ConnectionGUID: U7DiH7rRTpSS2cwPSbs0Vw==
X-CSE-MsgGUID: k24rl28OTFOMMx672JtnEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19982801"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="19982801"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 03:10:44 -0700
X-CSE-ConnectionGUID: MGIlo/59R1+Iu/O6g8zoaA==
X-CSE-MsgGUID: YT4molzjS/yRxwW0ybck0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54881319"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 31 Jul 2024 03:10:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 13:10:40 +0300
Date: Wed, 31 Jul 2024 13:10:40 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] usb: typec: tcpm/tcpci_maxim: clarify a comment
Message-ID: <ZqoNoGcCsCwNl1N0@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-2-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-2-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:09AM +0100, André Draszik wrote:
> We loop while the status is != 0, so rephrase the comment slightly for
> clarity.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index eec3bcec119c..87102b4d060d 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -397,7 +397,7 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
>  	}
>  	while (status) {
>  		irq_return = _max_tcpci_irq(chip, status);
> -		/* Do not return if the ALERT is already set. */
> +		/* Do not return if a (new) ALERT is set (again). */
>  		ret = max_tcpci_read16(chip, TCPC_ALERT, &status);
>  		if (ret < 0)
>  			break;
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

