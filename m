Return-Path: <linux-kernel+bounces-239642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0772926377
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869231F2328E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C11791EF;
	Wed,  3 Jul 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cs+z83tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE94C7D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017210; cv=none; b=L8HQiODTlPyXPoxdxoYt3pGmwxzPzifdJCD1oOZgbHitK/kHnPIlh/0HGplgR6qaLleJm2QTkRSv6SQS/oWF+yM98DqkY+1bnYbU3RvNpkBDDSd3/pEzFNE2a01mUlwpf6kWqvwyi2jdFG058sSdUrEjDyJaBd8aYs/P/tj5jnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017210; c=relaxed/simple;
	bh=K4tGBXDyHG3s64xGn8nQEFFL2XRCDQHevLpd4H+cf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ1cf35y/GhTRwsZd6Y/i5Hbv/igOaXUUCVvnMFFTTHipBrVzao8YNMC+C8Z5uWo+cNB5rRBxBxa1DOTrRaV4ADI89B4cW/KWkoqvdwmwsnEuyVvv/sE+3Ynm5ohxamQpPjiEH8jCxezTAn+O5AtMKRCrKKKmpI8R4q0GXmxFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cs+z83tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A2C2BD10;
	Wed,  3 Jul 2024 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720017210;
	bh=K4tGBXDyHG3s64xGn8nQEFFL2XRCDQHevLpd4H+cf6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs+z83tVby1gFRgdgV3hxmn+1e2+/K6H5+LK6Ev/xD9puUuoS1WnRXMdRSIwNQgD6
	 oHRTmsVR4+4ljE7LIYLDepLyf558JUhQtCD1S6F24U/h64lqlZidH0O8hZyzVN05li
	 Z379oGymd0gfzZpeeCPwIt3CwX0RU7i/HchXtj1U=
Date: Wed, 3 Jul 2024 16:33:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, jerinj@marvell.com, schalla@marvell.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024070333-matchless-batch-57ec@gregkh>
References: <c43e2c24-cd5b-44c2-a997-5f324f58746c@app.fastmail.com>
 <20240619132109.3168940-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619132109.3168940-1-vattunuru@marvell.com>

On Wed, Jun 19, 2024 at 06:21:09AM -0700, Vamsi Attunuru wrote:
> +struct dpi_mps_mrrs_cfg {
> +	__u16 max_read_req_sz; /* Max read request size */
> +	__u16 max_payload_sz;  /* Max payload size */
> +	__u16 port; /* Ebus port */
> +	__u16 rsvd; /* Reserved */

Please spell out "reserved" you have plenty of characters to use.

Anyway, you NEVER check this, so you just made it so it can never be
used.  Please read the documentation in the kernel for how to add new
ioctls, it goes through the reasoning why you must check this for 0 now.

thanks,

greg k-h

