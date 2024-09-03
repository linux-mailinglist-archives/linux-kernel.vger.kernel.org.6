Return-Path: <linux-kernel+bounces-312167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245C9692F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA89B22351
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68A1CE6F2;
	Tue,  3 Sep 2024 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pepXRYHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF22904;
	Tue,  3 Sep 2024 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339511; cv=none; b=E0GkpV4TPvFzlk+87/vCHUryRFBGyNQzTp6+0gOBN0tR5QY4+ig3Kxz1ilQPHIgeHIsW2vs/I41uLThsrRHtn1UkvL5vYmreI9m5fTdOXfPYTcXYblUfS8jPMemvCylsmLNtgMW+XQLYdm5jSi6Ta6voyipGNRki62jwx5TYwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339511; c=relaxed/simple;
	bh=tdLMtVR7YmxiIHJhUKcA6olrG88nI5AsrPflnfZQiLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYTF3t2St1jgkCzl1+Lc8InzpNPXgMZNVCoY2IlGO75Y/tvdFNTTbtkLFwSyCIpfGOrXAt9eIWSWvMVI1t2Go8y8SoTeEAXaoTh/0mDK/23KnwjDG+tTlxq9JqHf9FZ6blYMjesUe7CZlWvFP/LSHIWElc1K8DwBBuRe1WmlBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pepXRYHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265C6C4CEC5;
	Tue,  3 Sep 2024 04:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725339510;
	bh=tdLMtVR7YmxiIHJhUKcA6olrG88nI5AsrPflnfZQiLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pepXRYHKdOG3ESgqBn9T69uS2e+af/+rBoD82sC1aJE16tmSlPIiLWgx0P0ZmgFZQ
	 jzWxoMDDQKqHIH55rSQWgt0Ip6LRwUk7TIiFO+1FPhQSovAn/U+5Qmz8qhTulJFwo4
	 0Zi+KRXRC41gvbK3JyU5IWCV99E1HCjsXdSLiXXQ=
Date: Tue, 3 Sep 2024 06:58:27 +0200
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
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?Q?H_v9=5D_usb=3A_gadget=3A_u=5Fserial=3A_Ad?= =?utf-8?Q?d?= null
 pointer check in gs_read_complete & gs_write_complete
Message-ID: <2024090328-carbon-feeble-3d84@gregkh>
References: <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <PUZPR06MB6224FF88145DAA364464EA7FD2922@PUZPR06MB6224.apcprd06.prod.outlook.com>
 <1179f9e8-1e5e-4658-8102-ee4d2c49575f@kernel.org>
 <TYUPR06MB62171CA61CC646756826B8D9D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62171CA61CC646756826B8D9D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Tue, Sep 03, 2024 at 02:23:09AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> >You ping after four days? As whom do you treat us? I already complained about @vivo.com in several threads. That's one more to the list of very poor interactions from @vivo.com.
> 
> >READ submitting-patches very carefully and then get your process fixed.
> 
> We sincerely apologize. We have always respected the maintainers of the Linux community and had no intention of offending them.
> 
> Perhaps we were anxious and hoped that the patch could be merged earlier (to solve the problems encountered in production as soon as possible), 
> which inadvertently offended the community maintainers. We apologize again for this.

If you wish to have patches reviewed and merged quickly, please help out
in the review and testing of other changes that have been submitted
before yours, to help cut down the workload of those of us reviewing
these changes.

thanks,

greg k-h

