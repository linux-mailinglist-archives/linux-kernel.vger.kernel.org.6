Return-Path: <linux-kernel+bounces-521941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989AA3C417
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026B2188762D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFF1F9421;
	Wed, 19 Feb 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSZG4m9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340F1DED60;
	Wed, 19 Feb 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980123; cv=none; b=A+UzsHq1dyX25v8vWVhC320mFBxwtKUKlVDXYw6vYuIBB9bvsRgSe+1lvmJiivlYzTPPC4OkBtOptP9v+sxT06jZg+E5QS8F1Rshiw/T3LkkxhPD36+pNls8LICsgjcQsb0sXO21SB3ghWrBU7krTF2x9eP203vXeQZxfthP3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980123; c=relaxed/simple;
	bh=kArum3zKXaRk2fpqNYtvOFMPtVi0en0S5USFtMcfk74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/9KU6QSn/zw7PiABpYblsrt+hQo3GNO3arnuCSuCzoyGTIp0D+Vt2wzjyY9SaV1coqqMXZmlWvuW9KGSKYQEHcBmGDOQ8uNMu2AOorFy5WsIGf5NQO06JyB9Y+/2YT40AOQHlgHIaanDYO4sjGOFOEtfqND3GElEFrEpfEw1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSZG4m9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A08C4CED6;
	Wed, 19 Feb 2025 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739980122;
	bh=kArum3zKXaRk2fpqNYtvOFMPtVi0en0S5USFtMcfk74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSZG4m9rJL0fIgtfhRh0pkPQR+1YBdPdnf/K1BgW7JpXkHLiGp4F3F0XBjt6ZYD/3
	 gwrHtXwkxc9GJSVV/zm77lvZDxVVF+l1MVaixhzMKedWl15OS2v3OnzOAphj8eqJS2
	 SarDGDS37sPJAuCA0bAZxG0BeMPpiV3W6qEQrngQ=
Date: Wed, 19 Feb 2025 16:48:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] staging: gpib: Console messaging cleanup
Message-ID: <2025021923-leverage-endpoint-c06e@gregkh>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>

On Fri, Feb 14, 2025 at 12:46:51PM +0100, Dave Penkler wrote:
> The GPIB drivers printed a lot of spurious console messages. This
> was linked to the level of code maturity, often using console
> messages for debug.
> 
> This patch set cleans up the console messaging in the spirit of Greg's
> recommendation: "When drivers are successful, they should be quiet"
> 
> All pr_info's have been removed except for one which is in the module
> init of the common core driver indicating that the GPIB subsystem is
> initialized.
> 
> All dev_info's have been removed or changed to dev_dbg except for the
> attach and probe messages in the agilent and ni usb drivers. This is
> to facilitate the creation of config and udev scripts to ensure that a
> particular usb device is systematically attached to the same gpib
> device file.
> 
> All custom debug and tty logging has been removed or replaced with
> dev_dbg.
> 
> Error messages where the user can figure out what went wrong with
> errno have also been removed, particularly timeouts and interrupts
> during reads and writes which can occur quite frequently uneccessarily
> cluttering up the console log.
> 
> The patches are 1 per driver.

All but 4 of these applied, can you rebase and resend the remaining
ones?

thanks,

greg k-h

