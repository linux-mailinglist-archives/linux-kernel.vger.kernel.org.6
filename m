Return-Path: <linux-kernel+bounces-266172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47693FBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF82282B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920615921B;
	Mon, 29 Jul 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWBK5J/1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE215622E;
	Mon, 29 Jul 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272443; cv=none; b=LVz9yvg2It6yzB2pqo9aGGmlDU2VWLV2C+G/jQGmS+UkQxRQgCG0GzItriGb7CaI5HK9LANYdB7DhAwRXDaIgLtUHRerDkZKn941+rbg0fF738OslNMvuz14XTubhkSIESvnf9pJrKGveq+jXCGwp8I5hNMt1Uq0nx1LO0QHM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272443; c=relaxed/simple;
	bh=IFkGlrBeSobkW77QizdeJQdd6iLBy/wzKY7LKGO4qt0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SLiEeAIeV0p7ndjO7928jef3r16KjfbRRPsNom81lPf5veoomjZ12byA5vm/F5U6+12oEOJGxa0BtTy7ZY11LqibmzQuwrpL1m3i2/jQh1oF7W+6GhdQmztXnkSmBqmGwSHtuEgxZJrSdwGYQ2yw8ifcY3LPtL7UZV8VQzVE89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWBK5J/1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722272442; x=1753808442;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IFkGlrBeSobkW77QizdeJQdd6iLBy/wzKY7LKGO4qt0=;
  b=VWBK5J/1lPSoY1lYTwZyN77uI5Uu50jJhECd4TLQ1EE9fAzMiEZoM2J5
   FjBqgD7+z1IeeDvsDLIu5C7m4o93ADvtBxXWzOB2aoROvLQLFAiwrsLqx
   QjiySeE57bY5ZNqbai9fn+SlQwSxAY/WvLM7KfVLCevtbL4iympbLtpt3
   C9sTqYhNNK/XE66BBAfwT8MDL/nDvomixzg4SfNS4Az5jHNoWrlfHjxGS
   lEHUL0IocgUd6eyQPWPpKcOLNQ+3tu2BGyQUdN4WILISYTSv+CSm3z8OH
   INPnfRDZBdwLN6SZVajvne2swyr4rwpjzvWle2R9A0Zvfmt2nz60rDVvN
   g==;
X-CSE-ConnectionGUID: sFXFJlZ/TpeoChsI36RSGg==
X-CSE-MsgGUID: 8oV9xI59RSiCtg74WmS7sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30634420"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="30634420"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:00:41 -0700
X-CSE-ConnectionGUID: oMkXgV2xQoWbjW6vrWpmSA==
X-CSE-MsgGUID: 1J557ww0SsihsETU/nwh8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58625745"
Received: from fpallare-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:00:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 20:00:34 +0300 (EEST)
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: W_Armin@gmx.de, corbet@lwn.net, platform-driver-x86@vger.kernel.org, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] wmi: Fix spelling
In-Reply-To: <20240729164721.125708-1-luis.hernandez093@gmail.com>
Message-ID: <ec63657f-93d1-919b-f87f-eebb13c8938e@linux.intel.com>
References: <20240729164721.125708-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jul 2024, Luis Felipe Hernandez wrote:

Thanks for this change but please don't leave the commit message empty, 
it's not enough to provide just the shortlog (in subject) even if the 
change is obvious/simple. Please resubmit this with the commit message
included.

-- 
 i.


> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
>  Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentation/wmi/devices/msi-wmi-platform.rst
> index 29b1b2e6d42c..31a136942892 100644
> --- a/Documentation/wmi/devices/msi-wmi-platform.rst
> +++ b/Documentation/wmi/devices/msi-wmi-platform.rst
> @@ -130,12 +130,12 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
>  
>  Due to a peculiarity in how Windows handles the ``CreateByteField()`` ACPI operator (errors only
>  happen when a invalid byte field is ultimately accessed), all methods require a 32 byte input
> -buffer, even if the Binay MOF says otherwise.
> +buffer, even if the Binary MOF says otherwise.
>  
>  The input buffer contains a single byte to select the subfeature to be accessed and 31 bytes of
>  input data, the meaning of which depends on the subfeature being accessed.
>  
> -The output buffer contains a singe byte which signals success or failure (``0x00`` on failure)
> +The output buffer contains a single byte which signals success or failure (``0x00`` on failure)
>  and 31 bytes of output data, the meaning if which depends on the subfeature being accessed.
>  
>  WMI method Get_EC()
> @@ -147,7 +147,7 @@ data contains a flag byte and a 28 byte controller firmware version string.
>  The first 4 bits of the flag byte contain the minor version of the embedded controller interface,
>  with the next 2 bits containing the major version of the embedded controller interface.
>  
> -The 7th bit signals if the embedded controller page chaged (exact meaning is unknown), and the
> +The 7th bit signals if the embedded controller page changed (exact meaning is unknown), and the
>  last bit signals if the platform is a Tigerlake platform.
>  
>  The MSI software seems to only use this interface when the last bit is set.
> 

