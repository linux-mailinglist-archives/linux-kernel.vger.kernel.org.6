Return-Path: <linux-kernel+bounces-562910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F2A63483
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65723B2466
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998418DB08;
	Sun, 16 Mar 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pxQML+Cw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEB18BB9C;
	Sun, 16 Mar 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110806; cv=none; b=pPZr9O6g/McneRkdDCPC4X3FxTLOhvLQvaieAzJc0UIhaytaBlt2LVNlE8HegJb+PAF3K60k4zOViCIRbgOhCYuUKliF8Nk/O3NscixKBOzorq87yR5uNTMghKWlhcsMoz+gCK9TjJP62Me/J/kjLufLGTb1p3ephW3wAJGqKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110806; c=relaxed/simple;
	bh=VxsYzw3B23c3+uK+n3YBUMNYEEWTk80UC0Tao0rr0rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9OArhInvMoWL0Dhg3vGtCSOQ3DiUzXqJeydVDx3vKwOeGZxfw7mIfLbSTGBSqZb5yOVVIQC6o5t/8NKRBeZ+JGik6tQvEfo48bQYkJV4IuLfOoOfEF/EX27f0Ry1tjRRtsQgHExzpL1ZFg2jsb4n7SniIqGclLEGbWbz/wU6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxQML+Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D735C4CEDD;
	Sun, 16 Mar 2025 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742110805;
	bh=VxsYzw3B23c3+uK+n3YBUMNYEEWTk80UC0Tao0rr0rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxQML+CwCZ7XBYCLlLbr3CRw4UWU+0zkJU6NUTbVmLIDvG7LWd+y7XxBtuuCMeIti
	 r201j3w6wL318xWfHH8JSrPLXsblLEy1C6xWljpegH47xS/6wtv9ulIE0OTe5TdmK1
	 +PNUbrOwTmQC1mrSUdKS/bxouBO09yKWJ087RXYg=
Date: Sun, 16 Mar 2025 08:38:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangkunbo <zhangkunbo@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-49562: KVM: x86: Use __try_cmpxchg_user() to update
 guest PTE A/D bits
Message-ID: <2025031608-destruct-spotlight-3d6f@gregkh>
References: <2025022618-CVE-2022-49562-1d2c@gregkh>
 <ae0422b3-61a7-4d2c-ab3c-de2d98a9d661@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae0422b3-61a7-4d2c-ab3c-de2d98a9d661@huawei.com>

On Sun, Mar 16, 2025 at 03:29:12PM +0800, zhangkunbo wrote:
> Hi, it seems the problem reflected by CVE-2022-49545 has been fixed by
> 2a8859f373b0. I wonder if applying 2a8859f373b0 could solve the problem

I'm sorry, but I do not understand what you are talking about here.  The
CVE-2022-49545 is an ALSA issue, not KVM.

totally confused,

greg k-h

