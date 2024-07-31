Return-Path: <linux-kernel+bounces-269063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB57942D00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A315B1C239A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B461AD415;
	Wed, 31 Jul 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KsAHJzwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BC1AC45E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424369; cv=none; b=BGumdTGatlYi3JiuT/fDWtrUPdIzIapbhD9te5xGZ4m+w6Rrrdd4mGjhQOCZC7nbUbhFVovenV0U8wgaRkPybyBs+HCiKs48FmzmUR6jOQTdNOx8Z+oJJZFLDDF1Dl4jad/VQ74mqIza+eFCPDi4krl2fXtPRBfarzp0+hlJMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424369; c=relaxed/simple;
	bh=OclwWEKl/YMKvSPUPArV1XjcS3l6x/0HqjlC5Ivjrl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSuOGZZ2HSZtCGnni68QZzNfKggMaqdbQOQZZ1CTbl9fJjwEfpiy+J8vcUaouxsIWmIdi504wTfQN7owIjpqs7ARPyNBgTjjuDy+oUDZjlOQLD8QsB2q8OD0aieWrfnj+K4EAM+lH7Sc8Ylaq/ZPhqDD83cex2++/fZnrNPnNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KsAHJzwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDBC116B1;
	Wed, 31 Jul 2024 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722424369;
	bh=OclwWEKl/YMKvSPUPArV1XjcS3l6x/0HqjlC5Ivjrl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsAHJzwYpRCUw9KWUIbhQ5T1/NiRve6UYH4IT3TqNf3HqFQiOv5YLaZOT+I3YdHAq
	 YFQdla7ABe4U2GYakApoiERqd6iKvGCmCvFlGrdSfw7M0a2RlaJhKsjOjT5XEWg936
	 bazWNiIMBzPVHf+bUZySyHCdIyiX11hSrunOM+90=
Date: Wed, 31 Jul 2024 13:12:46 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration
 problem of mobile phone as UVC camera.
Message-ID: <2024073122-margin-unplanned-6171@gregkh>
References: <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 08:45:31AM +0000, 胡连勤 wrote:
> When the phone is connected to the computer to use the webcam function,
> the phone needs to be enumerated as a uvc camera function.

<snip>

Note, why aren't you using scripts/get_maintainer.pl to find the proper
mailing list and developers for this change?  Please do so.

thanks,

greg k-h

