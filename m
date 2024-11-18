Return-Path: <linux-kernel+bounces-412986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A919D1201
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07242866B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640919DF64;
	Mon, 18 Nov 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oF4Tuvl1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE47193439
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936617; cv=none; b=EQwk002udZstSdvixoodPaUQbpPXNz6w3I6peWJHKS3/6h8tVIrigMVFVrS0py+F/ykZhBYKnVSWrW/W2pF4/GFQCQKHoNnhiBdmFh2XfEhVkYEYKgDU5kSHSO0tDM7JFWEFENMBsKD1pRS6CvrbrjF6yLB+C2gRQbLZBYz8sJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936617; c=relaxed/simple;
	bh=825IV0+m1Cz5yBZscUVnxENymW/iB/+ocUPkj5IZXhY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPX09W7AkMDUiJEFlWx5LKVxe6d/noazjwTxQskRoQtY27qNnRh0Jv5a3hHN+Gv4yLUbTzgFVRN7pID7Q7Mc882su5d6GvVFPqJye/4ruxPQc3+NeLJIBDoHCpKlugLNrYX1HnqT3qSfPwdn2AM1hpskz65cIjM7hCS856nkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oF4Tuvl1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4AB0240010;
	Mon, 18 Nov 2024 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731936613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oM6AbZrWm1JjX/mbzJsrlRU8XyzkzGMpUDByIVKqMWI=;
	b=oF4Tuvl16oOFVzX4Wr6fWjXrEfoFJKqFf7uK1GnG0AMym407hDfX7TReZVldBFUSadXzVU
	2ZSot3TD1b976mCGt8SQu22SihJTvhoKKbz7WmQTILC0krViD0kEY3RGD5b2GrinENrB5W
	9d25eIq1R78Tz0uungvhiz7gxC6rbGy167p4M9lDJhMOdXkgtsa0hFEG0HflTwYB1oCP3I
	PkJuVGYKGVcd8I64yTKs6mSH5DaQX0tPZuNMLrp1PYib+nYgiuwo21jEY8LFz/9qkfNEZX
	n9ZhtoZLiD2YTLfaTKQFeqP8/WXFPpU/dFcDVnfM0dtUgk7tLPUGmSC1K5sj7w==
Date: Mon, 18 Nov 2024 14:30:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: jarkko.nikula@linux.intel.com, Shyam-sundar.S-k@amd.com,
	Guruvendra.Punugupati@amd.com, krishnamoorthi.m@amd.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v1] i3c: mipi-i3c-hci: Support SETDASA CCC
Message-ID: <173193659469.36588.2524558035357805471.b4-ty@bootlin.com>
References: <20241113035826.923918-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113035826.923918-1-billy_tsai@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 13 Nov 2024 11:58:26 +0800, Billy Tsai wrote:
> When the I3C subsystem wants to assign a dynamic address using the SETDASA
> CCC, it needs to attach the I3C device with device info that includes only
> the static address. In the HCI, if the driver want to send this SETDASA
> CCC, a DAT entry is required to temporarily fill the device's static
> address into the dynamic address field. Afterward, the reattach API will
> be executed to update the DAT with the correct dynamic addrees value.
> 
> [...]

Applied, thanks!

[1/1] i3c: mipi-i3c-hci: Support SETDASA CCC
      https://git.kernel.org/abelloni/c/2b50719dd92f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

