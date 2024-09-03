Return-Path: <linux-kernel+bounces-312875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778EA969CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A922824D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400FD1C984C;
	Tue,  3 Sep 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UgKXTVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918621B12C9;
	Tue,  3 Sep 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365139; cv=none; b=qIEFpmc9+Lvxl9HX3VZQVHjkQeqBFzcIZ8ncBj9aMbHIwxeCa+1tWSu0d1zXSdM/3kMd/9m//RiRR5tOKdcR7owzpw6SNhlGSftz2wKiWxoaxgBpSv1FPdciKcAac0SktW/w3PsupkITVloxxQ/m8UnPaiVszICc33in7KfLfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365139; c=relaxed/simple;
	bh=JemuxbKrtbEt9RnxHEP5fT6MG7HmqDtkW3lDG1heGwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqR32fGJYYaiUJN1TkkjJTPX65dZQ14kLDUCNQMNehCb5EJjuhcgceaMpvorbji7aKE0yQyp6kEecJMCBYod0MbQkq1sK4kpx8Mnzz7eFxnv1QBWs0a0P7DIDhnc6f19uXDF7i9Ss8iUpV932m4RezaBSPa2+2GbKjXDto5DXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UgKXTVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3FBC4CEC4;
	Tue,  3 Sep 2024 12:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725365139;
	bh=JemuxbKrtbEt9RnxHEP5fT6MG7HmqDtkW3lDG1heGwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1UgKXTVUv76hfQI7LRCby4mtWl6pVt92riInKsjrr5hFgEw9o1/5hCq13XRgzyfE3
	 m/GCia+UVORtkaJpMKTnAxQ2bc8LjoOcG+bBWseuKHAGSqO39c/XuLhW1vm1OpsNQ7
	 Vt0tfI1GI/8HJ0vCRtcq9jkXwzD2BMqFyMIi/5d8=
Date: Tue, 3 Sep 2024 14:05:36 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?5p2O5bKz5p2+?= <liyuesong@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0ggdjldIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWQ=?=
 =?utf-8?Q?d?= null pointer check in gs_read_complete & gs_write_complete
Message-ID: <2024090353-cinch-unlovable-f8f7@gregkh>
References: <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <PUZPR06MB6224FF88145DAA364464EA7FD2922@PUZPR06MB6224.apcprd06.prod.outlook.com>
 <1179f9e8-1e5e-4658-8102-ee4d2c49575f@kernel.org>
 <TYUPR06MB62171CA61CC646756826B8D9D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024090328-carbon-feeble-3d84@gregkh>
 <TYUPR06MB6217F14E7A4DEA451115F086D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217F14E7A4DEA451115F086D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Tue, Sep 03, 2024 at 11:49:25AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> >If you wish to have patches reviewed and merged quickly, please help out in the review and testing of other changes that have been submitted before yours, to help cut down the workload of those of us reviewing these changes.
>  We usually do the related pressure tests after Patch. For example, this patch we have a USB mode switching pressure test, and the ADB ROOT & UNROOT pressure test.

I'm not asking about your testing, I'm asking for you to help out with
the patch review of the other patches on the mailing list for the USB
subsystem, specifically for the usb gadget code which you are now
familiar with.

We always need help with that,

thanks,

greg k-h

