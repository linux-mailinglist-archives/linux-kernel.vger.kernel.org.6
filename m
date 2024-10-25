Return-Path: <linux-kernel+bounces-382179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72CB9B0A71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C32817FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9C2022EC;
	Fri, 25 Oct 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwbPG9m6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F115ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875475; cv=none; b=cJW/iKmZ1Vu2Tc9Cfv7k+veu/SkNeOmk9Su9klWYoOnvQEa+eh/VK6f40h6Aqj6O4ztXWk/zX6YEhNNeWgSa1tCPx/sH1GIpENr3Av+m3JCeBfBRMJ/pLKu0vw4mmuJL3W3cKZTZAPuKtvTiC1vpI5fNCnRAzp+GwRCLTA0oTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875475; c=relaxed/simple;
	bh=HUpNZpAn4AV5+8BT8IJZiEa8fpELq7F5u2lA8eycX5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBypjyMvtzNlUsHtIXEvRgVwkp06Bpy9FF7qA/wi08Jn6ZtVzqUnYvBUfEIDnqMomf01dkZowtctjauOu4SDgU+FpQL4ELy3JgGMMqXDcPZUSHPadklCylt+iy9OscnFuUoCXxdbWAzZTg4SiX7PWGNrkIP05XJyBVKBj2MkEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwbPG9m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E63C4CEC3;
	Fri, 25 Oct 2024 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875474;
	bh=HUpNZpAn4AV5+8BT8IJZiEa8fpELq7F5u2lA8eycX5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwbPG9m6BnIkB4Hsb+TIrzuTZHbe1pSWOWluEva/NKSyQSEgKHhgIo9Lzg06kJKn6
	 I8EuKlMLd5CRympe7hKqLvBHGmO5UmV+bHqrk7ddtBe7Wv2XJYzhYonFGgUS5vbIrg
	 deOMSEv3tKRoGEEgD9U6/snpqwBek5UBWzTdL6zjTgb1S9SJZT5xU2ueX6Mi/WkHMX
	 Y/qA07AoySXKW85emWuv4BR8quUnOwselnRHo9k5lcoMslS0hUblfeNOQmfhPMMJ7Q
	 LMLvsZGVNSW7yYCZNcT0J385NZBjo+L5YfAXOSK3ufwWjwOl6zjC+5BVSUOsjxwzVA
	 CIMNnvK8vuFWA==
Date: Fri, 25 Oct 2024 10:57:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
 <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>

On Fri, Oct 25, 2024 at 06:40:23PM +0200, Konrad Dybcio wrote:
> On 25.10.2024 6:12 PM, Keith Busch wrote:
> > On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> >> before the platform can reach S3-like sleep states. This is very much
> >> similar in nature to the issue described in [1].
> > 
> > The "SIMPLE" quirk is only supposed to affect kernel managed runtime
> > suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
> > suspend?
> 
> So on these platforms, all system sleep states (incl. S3) are entered
> through what Linux sees as s2idle, with a separate MCU doing a lot
> behind the scenes. s2idle of course also covers the runtime cpuidle
> cases.
> 
> All but the deepest state (which Linux doesn't differentiate as of
> today) are effectively somewhat like s0ix.
> It's a bit hard to draw accurate lines between Intel terminology and
> what we have here, as there's way more things onboard than just the CPU
> cluster that may be operating independently..

Gotcha.

Is there any sleep state on this where using the nvme managed power is
advantageous, or is the simple suspend preferred in every scenario for
this platform?

