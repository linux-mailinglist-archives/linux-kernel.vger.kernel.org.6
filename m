Return-Path: <linux-kernel+bounces-211113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17457904D44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1A31F23DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE716C869;
	Wed, 12 Jun 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="se3m/+I1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B816C6BE;
	Wed, 12 Jun 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179093; cv=none; b=ghtp/g1fqp40vcvTyPdFbf1vvjmnuXGSayMzQOvrWUAHdgM+YKGWGWvB5fTBwKveLdJiPqSe5O6yNIEfrj2rtbgm4BTJn451eK5ooHPRUKp4TM/8sDgCEp/j7AU/7A9TYN60BCiwTf8lI6cUKFuHD1UZQn2wrGa78hh5y5jDaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179093; c=relaxed/simple;
	bh=OknuNNK6uKLrZGWMzcve3pAdEC6a+jZCzFuUAGM0Ipw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu38KHQhGFmQVXT4mhyxH9a4nbkJUw2QZISJAMsybpSsSRRNY20Eq6sAF1P0XYzzUHODkXH/1050HfdALc8RpSQoXPLqCocJ2ghDtDuSgi/W5vJu0v0zZzWkeCYixBlwtROM1JMU6qRQprVvRotCIftMAcZnLsG77OUFsRYr8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=se3m/+I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A9C3277B;
	Wed, 12 Jun 2024 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718179093;
	bh=OknuNNK6uKLrZGWMzcve3pAdEC6a+jZCzFuUAGM0Ipw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=se3m/+I1/51CyWYewGMwD1WNe7WIJWRqspVpvn8k3yTPWa7WQvJSpkFjjUYsNx3s9
	 2rDM1spM2i6oNdvCV6cHc8l7yevsUj1hAJ0DJUr+J8QtCRcmARc1zRkTMAHbS9bqn/
	 veY/zAQtP7Nf+E3xMa+5BbTjj2eCA2+RMe5JBXsQ=
Date: Wed, 12 Jun 2024 09:58:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061247-geranium-unstaffed-ff09@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240611142953.12057-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611142953.12057-1-joswang1221@gmail.com>

On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> This is a workaround for STAR 4846132, which only affects
> DWC_usb31 version2.00a operating in host mode.
> 
> There is a problem in DWC_usb31 version 2.00a operating
> in host mode that would cause a CSR read timeout When CSR
> read coincides with RAM Clock Gating Entry. By disable
> Clock Gating, sacrificing power consumption for normal
> operation.
> 
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
> v1 -> v2:
> - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> v2 -> v3:
> - code refactor
> - modify comment, add STAR number, workaround applied in host mode
> - modify commit message, add STAR number, workaround applied in host mode
> - modify Author Jos Wang
> ---
>  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Should this have a cc: stable line?

thanks,

greg k-h

