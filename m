Return-Path: <linux-kernel+bounces-296989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23895B19E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08F21C21378
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761117C7D5;
	Thu, 22 Aug 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dqXViVL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037D1C6B5;
	Thu, 22 Aug 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318802; cv=none; b=A92QnaK/MONgSVtkcplD2kcI86MqHbmxXEM6wPSU4pcQfIlNEo8UmMzstIvgRZ8CZ36u12+wkrdqzpj/HkJNB+Xw1d6TgHoM1qzKYmu488ddcrHwYYRUvO0LQsVEOr+RVYBzv/ePqSZHfCX+cnwgsF3xkPBO7ItFNoHvW3ISwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318802; c=relaxed/simple;
	bh=FWF9DF1CxrugxkwgdC2uYLB0I3wE7fR9AdLYrKWreIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM7p/GyHHP/sLsG/Uu5a9nzFbrVZfG9y4gLauX0bDv8XEHuXeY5SECpDcWIp4eOu/QnaKCfa8Qa0tk0KVTZ+aDH/rHzV8qypvz4p9vELgFhnb9IIvOTPbXXVnRy42GChCOlZS8kzcLjtAAPi5/Mo1UV0TL18/GVTlupWhRg2p5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dqXViVL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50154C32782;
	Thu, 22 Aug 2024 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724318800;
	bh=FWF9DF1CxrugxkwgdC2uYLB0I3wE7fR9AdLYrKWreIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqXViVL3Y0Fpkg03DRV7nAUX7wK7QwcRspkl1+W5U0UQKxMWsRvKJ0Ed6zpBxzFDO
	 HoY1Sh4Hia7X7m97wBgkr6NCzUA3bWBpUQ/mH7pSt0MpR6PxKpXNnIcjkGbzVX1WPZ
	 oLniUOzk9Q0WeSt+bRiyceU935xNE+nNxQPFvmds=
Date: Thu, 22 Aug 2024 17:26:38 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org, Konstantin Aladyshev <aladyshev22@gmail.com>,
	David Sands <david.sands@biamp.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, Chris Wulff <Chris.Wulff@biamp.com>
Subject: Re: [PATCH v5] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Message-ID: <2024082225-squad-twerp-ad11@gregkh>
References: <20240817142850.1311460-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817142850.1311460-2-crwulff@gmail.com>

On Sat, Aug 17, 2024 at 10:28:51AM -0400, crwulff@gmail.com wrote:
> From: Chris Wulff <Chris.Wulff@biamp.com>
> 
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
> [1] https://lore.kernel.org/all/20220805070507.123151-2-sunil@amarulasolutions.com/
> [2] https://lore.kernel.org/all/20220726005824.2817646-1-vi@endrift.com/
> 
> Signed-off-by: David Sands <david.sands@biamp.com>
> Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> ---
> v5: release spinlock on copy_from_user error path
> v4: cleaned up a warning
> https://lore.kernel.org/all/20240814125525.3917130-2-crwulff@gmail.com/
> v3: rebased to usb-next, checkpatch cleanup (formatting, lore.kernel.org links)
> https://lore.kernel.org/all/20240810141834.640887-2-crwulff@gmail.com/
> v2: https://lore.kernel.org/all/CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com/
> v1: https://lore.kernel.org/all/20230215231529.2513236-1-david.sands@biamp.com/

Nice, thanks for sticking with this!

greg k-h

