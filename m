Return-Path: <linux-kernel+bounces-359351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0D998A81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5111F2893E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC151E765D;
	Thu, 10 Oct 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3btxgxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E1E573E;
	Thu, 10 Oct 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571381; cv=none; b=JGu+ZpOkovMbTHu/WdbYCYmnq0kJqpLl9E+aGYtwbx26Nynld3Nb7/ZKNFs/4eoS0oiNEZEoUkiuWbx4QENkSwHZ55ahKjIut9u9TszDYTxu7+aMoYvLM8zbA72PR5KdaHft/MiaLjOw0eHtkPkd60tUpNKVcFPmmSU9DwIAwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571381; c=relaxed/simple;
	bh=6e73heRiVIY6t99HPQu60V03l+lRLei6T7aIWoYzu3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPl8p9KWQ9gjghc1pB2sfRxHmih3LO2vmj4NFlHG818UnXw00PpOQ2qJelid8KlSP9X1Tu5A2xa7Grd8o19Hf2nynSQ6oeICJ7VfDh+QE9/AUxVexn+tQl7uE/LgZx5itc6HA9EFcGNa8ACjdxKNJcTUpifARBSwJrh+2a5a4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3btxgxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA6C4CEC5;
	Thu, 10 Oct 2024 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728571381;
	bh=6e73heRiVIY6t99HPQu60V03l+lRLei6T7aIWoYzu3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3btxgxFKogvIUcc7dQmuOyfXH38gMVtU+5biNRy77WYo7F1fkxjCAwp5/hfUz4jZ
	 nh1grHRGZemFI0B+lNSXEC+TN9W7Uk8sRxR0b9DmASmbclorbrZy91GzyicmhvbFNQ
	 JErr5WI2RYzjG6Ha5kxyBNCCTEV9f/qYxxxfw5Woy2WXVAKYZRPR2dDnbqviDPWmUK
	 boRK7oggZd9mRJ4zfPDqjn2snpnfSUWiz2kr4AQwDqT2sUcGevIf6IhhEhTE0zXKN3
	 BHjiM5dXMmIyNs+mAilio/QOZRVRszOvCfaCM7s+4YdocIA5pfUKZ49SQE1L6/XT23
	 G6+kHoDO653kg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1syuNe-000000006uX-1rTS;
	Thu, 10 Oct 2024 16:43:06 +0200
Date: Thu, 10 Oct 2024 16:43:06 +0200
From: Johan Hovold <johan@kernel.org>
To: cristian.marussi@arm.com
Cc: linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	sudeep.holla@arm.com, cristian.marussi@arm.com,
	quic_sibis@quicinc.com, konradybcio@kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Skip opp duplicates
Message-ID: <Zwfn-kGr1yYP8Xff@hovoldconsulting.com>
References: <20241009143905.2440438-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009143905.2440438-1-cristian.marussi@arm.com>

[ There appears to be something wrong with you mail setup as the patch
  had a bogus Reply-To header:

  Reply-To: 20241007060642.1978049-3-quic_sibis@quicinc.com
]

On Wed, Oct 09, 2024 at 03:39:05PM +0100, Cristian Marussi wrote:
> Buggy firmware can reply with duplicated PERF opps descriptors.
> 
> Ensure that the bad duplicates reported by the platform firmware doesn't
> get added to the opp-tables.
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> A new version to include in this series that should address the limit case
> described by Sibi...not tested, of course :P

Thanks for the fix. This seems to do the trick and gets rid of the
warnings about duplicate entries on boot and resume (including the
debugfs errors).

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

