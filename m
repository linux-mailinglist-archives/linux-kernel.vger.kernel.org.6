Return-Path: <linux-kernel+bounces-569820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F013A6A7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BB93BB4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87637222580;
	Thu, 20 Mar 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H7wC7U4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4097FBD6;
	Thu, 20 Mar 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479360; cv=none; b=BFEuAJ/XEaVbDUFN+9X2K4GOJTCdu+Ew3sRtgeYRsB+jsWUndhvS9KIdT/Su/gvxNXFYO1yrKqHdTZvkk8BTgNz/Y2nWoPYJFShzrvsAJUiooIBwN4PxGVgOBrwy2VuHGWMazA1dt1sSRQh6OqYmFAiGMdfJBlOnKS8envEERlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479360; c=relaxed/simple;
	bh=jK3397BdrtUlBR0ZqoujfE4jvwrD8tW91D+P9fByrlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhxkqRGKL7a/vynFdM1t+ePvaZ7LToz3qXwCUobbTEs7J+prSCgfKgDYcS35sDEFWOFkXavsgOj//bqS0h4Ugjr0U4A8bVXsKoTVmNBHpiFLQWnxuDad0sm7bOZn3C/lCCfUEvG4TAxJ8S30QGqf7i7Mw/09rgoFuqakGNkajFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7wC7U4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1908DC4CEDD;
	Thu, 20 Mar 2025 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742479359;
	bh=jK3397BdrtUlBR0ZqoujfE4jvwrD8tW91D+P9fByrlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7wC7U4q4rC/obmYMiWc6K9r+VMOyscFo2WrFsxQdTOmTL+/mEjmvV0z9tbwjwS2C
	 lMSHXikKleAutr9hsXRYHwq03XGpkfrx5qCVXQtCm9q8Yzu833ROdCeK/9ee/BrKV3
	 Sx7tdslNp5lt6VDEQcdF6Oz+HvIlrA/GbQ+vTP8s=
Date: Thu, 20 Mar 2025 07:01:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 2/2] staging: gpib: Remove unnecessary print
 function dev_err()
Message-ID: <2025032037-antibody-emptier-9986@gregkh>
References: <20250226060735.7484-1-jiapeng.chong@linux.alibaba.com>
 <20250226060735.7484-2-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226060735.7484-2-jiapeng.chong@linux.alibaba.com>

On Wed, Feb 26, 2025 at 02:07:35PM +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> ./drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1426:2-9: line 1426 is redundant because platform_get_irq() already prints an error.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19059
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

You have 2 different patches here, yet the identical subject line.  I
just caught this after I added it to my staging-testing branch, so I'll
go drop it from there now and wait for a v2 series.

thanks,

greg k-h

