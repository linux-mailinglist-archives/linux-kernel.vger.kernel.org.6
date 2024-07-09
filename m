Return-Path: <linux-kernel+bounces-246021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6B92BCCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D362817F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1718FC6E;
	Tue,  9 Jul 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNw5Rkyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E02132112
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535075; cv=none; b=CSeHwbSMoIMjFF3Q/eAi60A502a6RbdwPF7jFJp03Ywkf/GemyzGv3E0FIOoQdFXgdDW17CX4OqsojmBPoJOupyoUm2EpvSFpEVcnoHABzQOPtTV6Fy3qYeQUb4ZE9ZOUjKRd1XM2kiNMjmbsLX80Aq7Mm0M8L2/Qinm3FCL0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535075; c=relaxed/simple;
	bh=0G+H+5Q/xwH/f4CxWVLQn9oSZHX/23Z/fMFGonhovSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfPWa6BSXqURrxrjrhwTTmrW28s/K3t+zpB/ak776dQl9T3+ZSjiRU7Q2yqbNXxtCFi2CNF/fCHf5SNzDoAYByQxj9bdoM5rsyzaiCvnFURfu34NbIACkUjZFWcI+wTEx+8prufiPbWGKWOL6/hmp0M85dXaD14oJ6B9G4K3gtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNw5Rkyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22949C3277B;
	Tue,  9 Jul 2024 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720535074;
	bh=0G+H+5Q/xwH/f4CxWVLQn9oSZHX/23Z/fMFGonhovSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNw5Rkylzsxbi+hPih8LuzVCLJWofAlOQYq9YkGM77vz//5TUH+GLbRj2lqeYFSsX
	 BwOBPGi4bOLrNcKni6yVttnhCOpwqZ7VB0aKcn4usJJB3NpTpJriz4OqtpoLIvKOvP
	 P5E4I+Tg5HrMG2P+jzrvgINM1+hEYVtatAlCDyFQ=
Date: Tue, 9 Jul 2024 16:24:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver:core: no need to invert the return value of
 the call_driver_probe()
Message-ID: <2024070904-blob-unvarying-715f@gregkh>
References: <20240709141417.3349-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709141417.3349-1-sensor1010@163.com>

On Tue, Jul 09, 2024 at 07:14:17AM -0700, Lizhe wrote:
> In the probe function (either drv->bus->probe() or drv->probe()),
> there is no return value of EPROBE_DEFER. the error return from probe
> should be -EPROBE_DEFER, hence no negation of call_driver_probe()'s
> return is needed, nor should there be an EPROBE_DEFER check in
> driver_probe_device()
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> 
> v3:
> 	Modify commit message and versions go below the ---
> v2:
> 	Delete the judgment with the return value of EPROBEDEFER
> 	from the _driver_probe.device()
> v1:
> 	Add the judgment with the return value of EPROBEDEFER
> 	from the _driver_probe.device()
> ---
>  drivers/base/dd.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

The documentation says to put the vN: stuff below the --- line, right?

And how did you find this issue?

thanks,

greg kh-

