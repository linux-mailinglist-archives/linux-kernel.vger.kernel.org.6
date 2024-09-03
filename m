Return-Path: <linux-kernel+bounces-313368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3296A49B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52396B265E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785218C033;
	Tue,  3 Sep 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX4tknn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0918BC21;
	Tue,  3 Sep 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381229; cv=none; b=e6ycqXXxIf9RoiraUkYxc92fGjuE5F8z3gAwZUnMdLboTClb0JN5eL0pgvIxDsOBDk8zoaeT+5QJlYx0NJAuK5aJ1vutlCdIfZRXSmN2eB8FOoihl6AxK+In92XfAn8DixjLBRAPfZFu8Zuj1CBrk1z8vUWpOLfl41mEGC66h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381229; c=relaxed/simple;
	bh=6Yg57+zQA+RKWmFz3J/bXMbmOzlooEBeuFJW8RKYpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8zKTWkOCjbM3vdeWh3et/dD+Jyt+6CLuwcE71wFsWJ5OoJ+6tYmOgIWTonafiUIRTMDWZEGFkh4+abx0Om0lAaUr6qPy8gl3c+/tk+vcXnAKXN/iotdfbn2yY8RQxGo+Zk+UJe1isY34BPZCN1ZnIUjWApipJ7IOC+nT0Gnk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX4tknn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809BDC4CEC4;
	Tue,  3 Sep 2024 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381229;
	bh=6Yg57+zQA+RKWmFz3J/bXMbmOzlooEBeuFJW8RKYpCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX4tknn3dB/a1xd6T5HNUHWdMy2VHWAQDmQeJsHVDNf5LnlZXpEDciUwHj5UQPVlP
	 2I1w92GLzS4nbVeCFC4iLlLWcSs7WCBZ+1jkKXhHlfo0/WgPXv+MTUS72S0w3czXFy
	 21MNpyGzD9VFdzw00Ex8dQGBD1mrnc1FywAC0dTOboxPHSGmxbOpzAtd7OipDHR6aF
	 8CxUKe5MAyCLeioc2neMf4ZE1B913TXSeH0rDNXK4tJgFVgZcnvgW5UnDzUVjtRCjW
	 hI9KURcXhSpNSxX8XwYRiplKY99S7x73tMLBpZM73p4XK71brrMCYYj+VLLflczQH+
	 IMbc4ryW96syg==
Date: Tue, 3 Sep 2024 17:33:15 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: do_setcpu function not need to have a
 return value
Message-ID: <20240903163315.GE4792@kernel.org>
References: <20240903095111.7204-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903095111.7204-1-liujing@cmss.chinamobile.com>

On Tue, Sep 03, 2024 at 05:51:11PM +0800, Liu Jing wrote:
> in the do_setcpu, this function does not need to have a return value,
> which is meaningless
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Thanks,

I also see that the caller does not check the return value.

Reviewed-by: Simon Horman <horms@kernel.org>

