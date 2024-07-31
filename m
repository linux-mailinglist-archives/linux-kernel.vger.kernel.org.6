Return-Path: <linux-kernel+bounces-268777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BC942928
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A9E283E70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24071A8BE7;
	Wed, 31 Jul 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="dtErQt5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dn0tPkPd"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191B1A7F8F;
	Wed, 31 Jul 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414585; cv=none; b=I+1H64fItRsiVbc9kEHfuvyvShXyE63Y6713FzEOqhu4cBP5YaKm5o+QtZCCBAhUxPTAiwURiroRTeRHVlPssFBF5NQyjZcj4oHhLpaNYYPpip0pLFt7mXzkGyGifQe3orGXmjOeAcjspmazz3npUSYj0dPx+revJlfsCKfQSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414585; c=relaxed/simple;
	bh=8VxD41nxBOqnLaH9BOpB7TJvz9r7DCcnICL7KhvTN0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjLwuI2cd1NkYnV1d7bxYkpspwjHgf5H7kJl/nUe9k4ivrD9emZu/ug/tPuNniOZnGBUtUDJ20BV8mgyRNKugC6J3JtrIKVgwlDVuBqr+vzpqQ8+j4H/CUbpAZjYphpK3MPm+koNIILPYw1JWRndWW3j5Hfy/ZUTMekmOmDxi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=dtErQt5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dn0tPkPd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2D6701382263;
	Wed, 31 Jul 2024 04:29:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 04:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722414582; x=1722500982; bh=9w2bHNx+2D
	4WJOWK2AyRKextPKfYm/gpxjhvE164VgY=; b=dtErQt5oFgBmxZDOQZ8AxLly0k
	41G6uvg14p8Z8U+eX+OSCXhhvjO5mk9jCssNDPjR+h6bCSLZH2950CetF4lLFVZR
	h6nvcpi1OgxjYKrwDllAejPzXuj8wCYYiSD5L1zP34PEpJgRNgX8Wzd/A6JGhrnV
	umypCmftggqg7y3hX1sgsq/jKF1ln+FXhaMEFQ4XgPb98t92kTmBtTZQxt/EWAzw
	yBoZTPph4Ghsy4U/KbE5I+lhnmXhyDnraMiutr9thdeqJf4bSzKYGuu/7tEBwOJC
	+4r8ES8gwUXch+s9cX4osP3u83oD3v+0O1zKXOcO3jqJeWIUqJaTFxYKhsfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722414582; x=1722500982; bh=9w2bHNx+2D4WJOWK2AyRKextPKfY
	m/gpxjhvE164VgY=; b=dn0tPkPdEYd0sfNrqTLWv4AOCBbxAO6kEmLy1+KPwRQp
	oEWJiQ8ywx6qUMGsCTaQZ+wauNuW4dJTChkUCyZ+yuSFfaV6Vf2CeJ/8AYK/y5ql
	am+7d6+VduV2ERpA9LUDCSGmCvylXVOb3riF5gxHmPGOoYcv41l6OE21vnx9ScDK
	eRxUTevzh3Z0uNWQnxtn0jX5VR+2eS+b7/elOBOjLHArPqFsGU3cA7QdlG/eTBJS
	w1h6WuXmYgAL17bxRI1EyZ9Hn9SO2xwrW2aA6gF31mGcenkAypo6He+jTcWT2mAM
	tV1/L1YoiHMl1ruPsofv5H8ZcVZhEyj6dSgKTZ5AfQ==
X-ME-Sender: <xms:9vWpZuel77uAt4B28wCOtimxxpB1YDRQcIerEHSav9UjL3n9kXREQg>
    <xme:9vWpZoNJAd86NUyVRZ7Dl26_OvYDZtRuc8vNCLNGaoHXFdjLFpbliwN5RMQvldmjQ
    K5j-dLjuzuDZw>
X-ME-Received: <xmr:9vWpZvhWvHHjLGL3SHwTZHfYaicLcqL81KWESSomLURs5CLtnvbiUFBLxJvfnl7UQHnTY4BCJ1bsGECRdHL6FIIDYNbPJyCxy4SMfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeggfehke
    etteehveeuudevfffhjeehkedujedvieelgffgvdehgefgiefgieduueenucffohhmrghi
    nhepmhgrrhgtrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9vWpZr9D1ySmvDkXDdZ6gFRQlVrmiFp7CjhKbFML6jNByKju_wds5Q>
    <xmx:9vWpZqs23WiX39YX3jhyJNYmS_SF7ahvijMhHxgfUovsoI4YmVikdg>
    <xmx:9vWpZiGF2JW7tESuw8NwgvlPRX3rDvTrUiVsPKefB09V0B4Dev3KbA>
    <xmx:9vWpZpPm1R_PH66RGgF4KlFV8cCLQL0XYkHoUV2O9Ii5DAjTxNlZPA>
    <xmx:9vWpZoDtjvkYDGzoAwcxSbSU9DA1foTXrYK8kYj_v7Y7R24VdbbfDr0h>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 04:29:41 -0400 (EDT)
Date: Wed, 31 Jul 2024 10:29:39 +0200
From: Greg KH <greg@kroah.com>
To: Chris Wulff <Chris.Wulff@biamp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Sands <David.Sands@biamp.com>
Subject: Re: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Message-ID: <2024073114-singular-stream-1dd9@gregkh>
References: <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>

On Wed, Apr 17, 2024 at 06:29:27PM +0000, Chris Wulff wrote:
> While supporting GET_REPORT is a mandatory request per the HID
> specification the current implementation of the GET_REPORT request responds
> to the USB Host with an empty reply of the request length. However, some
> USB Hosts will request the contents of feature reports via the GET_REPORT
> request. In addition, some proprietary HID 'protocols' will expect
> different data, for the same report ID, to be to become available in the
> feature report by sending a preceding SET_REPORT to the USB Device that
> defines what data is to be presented when that feature report is
> subsequently retrieved via GET_REPORT (with a very fast < 5ms turn around
> between the SET_REPORT and the GET_REPORT).
> 
> There are two other patch sets already submitted for adding GET_REPORT
> support. The first [1] allows for pre-priming a list of reports via IOCTLs
> which then allows the USB Host to perform the request, with no further
> userspace interaction possible during the GET_REPORT request. And another
> [2] which allows for a single report to be setup by userspace via IOCTL,
> which will be fetched and returned by the kernel for subsequent GET_REPORT
> requests by the USB Host, also with no further userspace interaction
> possible.
> 
> This patch, while loosely based on both the patch sets, differs by allowing
> the option for userspace to respond to each GET_REPORT request by setting
> up a poll to notify userspace that a new GET_REPORT request has arrived. To
> support this, two extra IOCTLs are supplied. The first of which is used to
> retrieve the report ID of the GET_REPORT request (in the case of having
> non-zero report IDs in the HID descriptor). The second IOCTL allows for
> storing report responses in a list for responding to requests.
> 
> The report responses are stored in a list (it will be either added if it
> does not exist or updated if it exists already). A flag (userspace_req) can
> be set to whether subsequent requests notify userspace or not.
> 
> Basic operation when a GET_REPORT request arrives from USB Host:
> 
> - If the report ID exists in the list and it is set for immediate return
>   (i.e. userspace_req == false) then response is sent immediately,
> userspace is not notified
> 
> - The report ID does not exist, or exists but is set to notify userspace
>   (i.e. userspace_req == true) then notify userspace via poll:
> 
> 	- If userspace responds, and either adds or update the response in
> 	  the list and respond to the host with the contents
> 
> 	- If userspace does not respond within the fixed timeout (2500ms)
> 	  but the report has been set prevously, then send 'old' report
> 	  contents
> 
> 	- If userspace does not respond within the fixed timeout (2500ms)
> 	  and the report does not exist in the list then send an empty
> 	  report
> 
> Note that userspace could 'prime' the report list at any other time.
> 
> While this patch allows for flexibility in how the system responds to
> requests, and therefore the HID 'protocols' that could be supported, a
> drawback is the time it takes to service the requests and therefore the
> maximum throughput that would be achievable. The USB HID Specification
> v1.11 itself states that GET_REPORT is not intended for periodic data
> polling, so this limitation is not severe.
> 
> Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading
> showed that userspace can typically respond to the GET_REPORT request
> within 1200ms - which is well within the 5000ms most operating systems seem
> to allow, and within the 2500ms set by this patch.
> 
> [1] https://marc.info/?t=165968296600006 [2]
> https://marc.info/?t=165879768900004
> 
> Signed-off-by: David Sands <david.sands@biamp.com>
> Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 270 +++++++++++++++++++++++++++-
>  include/uapi/linux/usb/g_hid.h      |  40 +++++
>  include/uapi/linux/usb/gadgetfs.h   |   2 +-
>  3 files changed, 304 insertions(+), 8 deletions(-)
>  create mode 100644 include/uapi/linux/usb/g_hid.h

Can you rebase this and resubmit against the latest kernel tree?  It's
been a while since this was last submitted, sorry for the delay in
reviewing it.

greg k-h

