Return-Path: <linux-kernel+bounces-573347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCC1A6D616
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF118958FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC125D206;
	Mon, 24 Mar 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtkgwTkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72F15CD46
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804444; cv=none; b=N76rHc61PGLfinKAGc7TmoaUumx6NI6Tg7shVd11m3SWAXvQH6rmxku0+rxMd5trE5WqD3sJSwc9nI2P9W0yC8eRRreVtxLtHQCkMYi8Up63TbnNc6XkR2x5W20mp6orn+Lu07N46CYyGbs+lnpOZKkJmjyfjnaQk2NO7k+14lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804444; c=relaxed/simple;
	bh=pm3PhOm0TA6k02DhynwGtFtiCtph6tpxrXu52vqfi+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHjzfcE3s4RkWbMUk/uYUAuFImfEkMt2wJxXeAImM9eePg5zzlmefqYge46Yy9Rw/s+fH12uPl2p8Et1dKG5WBQLOaZl4co0kyb49cBT//DjImIBVulN5866ogg7iErZbMw1FjJGuDPX1IZTQbzfh8if7M06mViwGWSohsAWesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtkgwTkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E15C4CEDD;
	Mon, 24 Mar 2025 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804444;
	bh=pm3PhOm0TA6k02DhynwGtFtiCtph6tpxrXu52vqfi+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtkgwTkKTiHLTh6W7fKEvie4BMwHRQXCkZE3PdAAoF8K+ndo7kZIa2P/H5Oj4PU0p
	 I2l8EH+wGqKtMjyxfWHlkmX/GLAjqcaUphpl2qnfSCBKbtR5QAcXDXS0/16cl4X3ny
	 o22H7PXPfkDyXMgV/QDLqoXZLy6ckqmEMZcbZ3DtirAwyC4mNDZlTeaI3EMpXOsBOX
	 0ogQorMDKq3Eu9o+3nh0vohZm7d1qOj/x4Ndg6hcmcTlhsD5aPG0SZFdgJtDpCBUOd
	 D17mDo/elBEMRVVAsR03/EqaPjXfibe9w9wwTbHjwHIv62lZ8d4LTdr9l4oeNAznBg
	 2IavUGQQ/zySg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twd35-000000004Mc-2Evl;
	Mon, 24 Mar 2025 09:20:43 +0100
Date: Mon, 24 Mar 2025 09:20:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Message-ID: <Z-EV21KDfMHds73Q@hovoldconsulting.com>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <bc3601ae-5639-4ee4-bbcb-4e39b542bfbe@quicinc.com>
 <Z-EMgPg5Gp-JtTZp@hovoldconsulting.com>
 <a1aa02e8-7f58-46ae-b3df-ae43288cf683@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1aa02e8-7f58-46ae-b3df-ae43288cf683@quicinc.com>

On Mon, Mar 24, 2025 at 04:05:33PM +0800, Baochen Qiang wrote:
> On 3/24/2025 3:40 PM, Johan Hovold wrote:
> > On Mon, Mar 24, 2025 at 11:06:16AM +0800, Baochen Qiang wrote:
> >> On 3/22/2025 12:23 AM, Johan Hovold wrote:
> >>> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> >>> without an iommu (under OS control) similar to what was done for ath11k
> >>> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> >>> DMA").
> >>>
> >>> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> >>> Elite machines like the Lenovo ThinkPad T14s when running at EL1.

> >>> Note that the mask could possibly be extended further but unresolved DMA
> >>> issues with 64 GiB X Elite machines currently prevents that from being
> >>> tested.
> >>
> >> could you help elaborate how it could be extended?
> > 
> > The mask should reflect the capability of the device. That may be
> > 64 (or 40) bits, but I've only been able to test using 36 bits.
> 
> are you talking about QCN9274? As far as I know, WCN7850 does not support 40 bits or more.

Or really all devices handled by ath12k since they at least currently
use a common mask.

The T14s has a:

	0004:01:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi 7(802.11be) 320MHz 2x2 [FastConnect 7800] (rev 01)

	ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0
	ath12k_pci 0004:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0xff soc_id 0x40170200

Sounds like 36 bits is the correct choice for now then.

Johan

