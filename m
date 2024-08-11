Return-Path: <linux-kernel+bounces-282303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A734794E1D9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454F8B20E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0E14B971;
	Sun, 11 Aug 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhG3Zwb/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302E14B950;
	Sun, 11 Aug 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390420; cv=none; b=ASlBenUK/kdUrxNIzVu4CTAEmMPfuC9k1Ej9wb5HvIMzflllp15NxggImEx8S0AfXq2QOcr7XI9Jrsvf0G70153E1PPGa03RNK5Wvet3nOxpC/0IVgw7GjBLGM1wm9pzLksDjfHjD9laXuWMDh9aKMHmPy0cb6tDPPbGWRNJTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390420; c=relaxed/simple;
	bh=0DERmHmJKOIgCh+I8BWA17AHixrHq1a1nOOrAyV2JnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fulpFQEQd+H/E9VoLTbyuDoCVXY+JWOXk59G2BUY31gSeWyuOqTo26LYQ13uhNbZ8OBr93t+0r5Uw3oQ4Hx96MS5TjJIWbbZNDLvwyDXz5cWrQMO7wnnKQs5aHewZZMbi9jKL/jCy92m2Bh8/uPShi2nVGGaGq6nJ7WmGKOKWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhG3Zwb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F8C32786;
	Sun, 11 Aug 2024 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723390420;
	bh=0DERmHmJKOIgCh+I8BWA17AHixrHq1a1nOOrAyV2JnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhG3Zwb/SgrEnVx77ZLduSCeo37PONWRBnhW+lW/zMb9NvNDDFw2IvUyRnBBLmaF4
	 ob0t4fERpysL3tJt2rYLv+FnrZFxpRYEVyG8S3sK6Wwn3fbF62Y711paf3UWRLjTfe
	 c3bScYYVpygU9NESu5ynPZz5iWV7ZoauBvDJ+2ec=
Date: Sun, 11 Aug 2024 17:33:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>, cve@kernel.org,
	linux-cve-announce@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: CVE-2024-42226: usb: xhci: prevent potential failure in
 handle_tx_event() for Transfer events without TRB
Message-ID: <2024081131-tamer-dreadful-17e4@gregkh>
References: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
 <9409f3d3-02d1-1e31-a6da-056b44a9523f@huawei.com>
 <010cb430-b0bd-40f9-897e-b48e326a9caa@linux.intel.com>
 <d36feb2f-c1f2-90c2-bb33-e6d0ff41096d@huawei.com>
 <6327d2ed-f1de-406d-a713-97934dbb6c39@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6327d2ed-f1de-406d-a713-97934dbb6c39@linux.intel.com>

On Wed, Aug 07, 2024 at 12:31:56PM +0300, Neronin, Niklas wrote:
> 
> 
> On 06/08/2024 16.53, Jinjiang Tu wrote:
> > 
> > 在 2024/8/6 19:15, Neronin, Niklas 写道:
> >> On 06/08/2024 12.25, Jinjiang Tu wrote:
> >>> Hi, Niklas
> >>>
> >>> The commit 66cb618bf0bb ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
> >>> has been assigned with CVE-2024-42226, but the commit has been reverted in 6.1.99 and 6.6.39 due to
> >>> performance regression. Do you have a plan to address this issue, or if this CVE should be rejected?
> >>>
> >>> Thanks!
> >>>
> >> Hi,
> >>
> >> Currently, I have no plan to address this issue.
> >>
> >> The commit in question, was not intended for any previous Linux versions.
> >> It was created as part of my handle_tx_event() rework series. Future changes
> >> in said series could potentially trigger the issue, so preemptively preventing
> >> it was both simpler and more secure.
> > I don't know if I'm understanding this right, do you mean the issue mentioned in
> > the commit will not be actually triggered in previous Linux versions? Now the commit
> > is reverted in v6.1 and v6.6, but the issue can not be triggered in these versions,
> > so no more fixes patch is needed for these LTS versions?
> 
> I'm not aware of any cases where this issue has been triggered. As it has been in the
> Linux kernel for a long time, I assume it does not trigger.

Ok, now rejected, thanks.

greg k-h

