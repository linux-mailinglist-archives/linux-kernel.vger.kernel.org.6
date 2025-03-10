Return-Path: <linux-kernel+bounces-553657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68AEA58D08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9C188D0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CD2206B7;
	Mon, 10 Mar 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VTIQQfM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7D2206AE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592252; cv=none; b=EwmOxRtB4ylk/Rzpy7SawH9VuyH0TNx/PaxMeYBJT65rHHdlxY5pfd9VgFbYQodfDYl0dd+4grJSVucmB5H1P/Bzy71+WZttjO/Ua7lNiIwS/AVta7Yg1SmIevO+Av0vVNQMdfvTUnwNJGOiEfaL5ii37Za2QAxbBRs69yAB9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592252; c=relaxed/simple;
	bh=xVgLarHn50O9PKKN4kyFylu/RZ9gGDOTnZ6y7nd37b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0UOy5Xuns+IcIn66zzhEllgr/rdsPp8RZrfhRs8oV+g9ZVZ2F+yvFWO4Gk2BSj3zRfnTk8u9qWSDh+rEtgRcP1tM/xxa9BL8Nws3ay4BUObvdvdliPUDHVOXOex3qtP71EZfFkHhHqqo2Ez7A7Ai9Cm9WIFP7eZBhqK9ROkTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VTIQQfM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426DDC4CEE5;
	Mon, 10 Mar 2025 07:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741592251;
	bh=xVgLarHn50O9PKKN4kyFylu/RZ9gGDOTnZ6y7nd37b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTIQQfM3kKhWjK5iDUqR/JOxwraykLpPgfpWD/1/j81w8U6HlqVuKQLqRMzHEv38Z
	 X108+WwmbYPFe8ExhRjQj1q2Zm/7dO0kpBI7A1OEVR5jIxFRmpzVokPsBJiKrwBVd+
	 nJ2JD0h1cpYFDB0bf1ZvHO/LZK4sooCHjM1cmIsw=
Date: Mon, 10 Mar 2025 08:37:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: cve@kernel.org, andypma@tencent.com, Jesse.Zhang@amd.com, forst@pen.gy,
	adobriyan@gmail.com, vegard.nossum@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add vulnerable commits for few CVEs
Message-ID: <2025031043-parcel-uncharted-0d8c@gregkh>
References: <20250310062349.206687-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310062349.206687-1-harshit.m.mogalapalli@oracle.com>

On Sun, Mar 09, 2025 at 11:23:49PM -0700, Harshit Mogalapalli wrote:
> CVE-2024-49994: block: fix integer overflow in BLKSECDISCARD
>  — Fixes: 44abff2c0b97 ("block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD")
> Reason: The overflowing addition in blk_ioctl_secure_erase() is added in
> above mentioned broken commit.
> 
> CVE-2024-46861 kernel: usbnet: ipheth: do not stop RX on failing RX callback
>  — Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
> Reason: dev->rcvbulk_callback() was added in the broken commit, and the
> CVE fix is to remove the return statement on failure.
> Note: The CVE fix is preventing driver to stop on non-critical failures
> -- I think this shouldn't be a CVE

It's it a denial of service if the driver does not work for normal
issues that can be triggered?

> CVE-2024-46819 kernel: drm/amdgpu: the warning dereferencing obj for nbio_v7_4
>  - Fixes: 28f87950d935 ("drm/amdgpu: clear ras controller status registers when interrupt occurs")
> Reason: ras_manager was first brought into usage in the above mentioned
> broken commit.
> 
> CVE-2024-40997 kernel: cpufreq: amd-pstate: fix memory leak on CPU EPP exit
>  — Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reason: memory allocation in amd_pstate_epp_cpu_init() with kzalloc is
> added in the above mentioned broken commit.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks for all of these, I'll go apply this now and update the database
entries.

greg k-h

