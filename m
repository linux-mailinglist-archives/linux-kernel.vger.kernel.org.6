Return-Path: <linux-kernel+bounces-207739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF0901B42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09BFB24798
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAB1F959;
	Mon, 10 Jun 2024 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ce31ekCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC641CF8A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000946; cv=none; b=nVVisrkLRORuEeutZKROiGH/Mq2KdXagy18y1iyYICz9eak4g8zDwVPbVQXwQlftdn8xOiNo1nINwJlUBaojbXtcUMCuMIZC9vi8vLSsadIxukzk44vr1KKdj9KfYlsxWhXw0sVf+dCOizxyVC9IJQFHOn6/2ycyOsmFS2QoJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000946; c=relaxed/simple;
	bh=Ec39rAzc0NGlEHPjR6nbex/Eebmuk+Zzu5bMmFy71+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2NrvIjhO/TmR1svsTtN2sL9JPtl7IrhJ2uaU3DGF5YiLHTpzdNfKisJshcTzMeVlOmHyQRQ8FqUzMKo43VXbYnBYtB84YFciayKyDCU92Y2cLBpdXyoKwu3RHblGGeIK0OYXH1dQ6xiuCmB6NIKuqBxxoSlpXDWCg2abVG4aTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ce31ekCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205BAC2BBFC;
	Mon, 10 Jun 2024 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718000945;
	bh=Ec39rAzc0NGlEHPjR6nbex/Eebmuk+Zzu5bMmFy71+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce31ekCA+8IAJXzermXrI7uou+rjkoCt75Ezy9QikrP/nhTcDyTWh1h1DJbROQIgS
	 /DxWIdEQRezL0ubDDl0Gc5Qgab87rH8xuAhdrDikoWOmlCOokTlxoG16qcEAtRsFBA
	 OB+Q1anvEmF9a/S9IW8+fvUjvN27XY9z2ZlWnfyQ=
Date: Mon, 10 Jun 2024 08:29:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v4] driver core: Add timeout for device shutdown
Message-ID: <2024061046-protozoan-repost-6443@gregkh>
References: <20240610055844.GA68891@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610055844.GA68891@sony.com>

On Mon, Jun 10, 2024 at 05:58:44AM +0000, Soumya Khasnis wrote:
> +config DEVICE_SHUTDOWN_TIMEOUT
> +	bool "device shutdown timeout"
> +	default n

n is the default, no need to ever set it like that.

thanks,

greg k-h

