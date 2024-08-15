Return-Path: <linux-kernel+bounces-287680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C46952B47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499E01F21F51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6601AAE1F;
	Thu, 15 Aug 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MxqD1vKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521B198A3B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711334; cv=none; b=s7yPEf/NVeepENd3RMw3UsBDR4cb1PIxqmAKw48X4Tva6OptlzuWBnsWbf+qnbBd9LkbVw9FUx1nZBZLg9gFL8fIvDGSHxNPWPdeNn3b+GQ6FIRo8hYghElwsruQvn2bhIlzkvXFJCU7A+IHpOluLDdOr7VwwgLtqn73ZFlSmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711334; c=relaxed/simple;
	bh=AgcoF9cvZpAjCqw7y3/w0gNhTJvYePD7xg+35Tdhsg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeUt9UCSK4q0pRsHViWWAfuIeGzya3Wm/Q26f1HzkCbrOyvOUafLjILQn1k043JJi3u39zO0KW3slzuSmXx0f97hUV9wFQCHeu0s6/xytoEHfCVxP2xnxwn1H5Zxv0eCcIBPLC/fUBK4gh6n9DUZ1mjaz1w8eKLuqCmnOHnA84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MxqD1vKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F457C32786;
	Thu, 15 Aug 2024 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723711334;
	bh=AgcoF9cvZpAjCqw7y3/w0gNhTJvYePD7xg+35Tdhsg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxqD1vKIizMWDWe6+Bcr/bVXlcihgQ5fg/Ltnd1JfTHZCMYGxxNzETlacjAmJu/eE
	 8kDG6crm+spUheY1z444iv+F1azD9nc4Gyk0WCyFBD0M0mTlGsdDrBMEifZ4GsmGMf
	 B8ZIkZRK1t2pTYP8KQkAquvN5J1RosAdiEK5Higs=
Date: Thu, 15 Aug 2024 10:41:15 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Message-ID: <2024081513-aware-tutor-e119@gregkh>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <2024081535-unfasten-afloat-9684@gregkh>
 <362eea30-7b6d-4cd5-aed9-88c0d014dd91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362eea30-7b6d-4cd5-aed9-88c0d014dd91@gmail.com>

On Thu, Aug 15, 2024 at 03:35:13AM -0500, Joel Selvaraj wrote:
> Hi greg k-h,
> 
> The git commit id is: bab2f5e8fd5d2f759db26b78d9db57412888f187
> 
> But I am bit hesitant if we should revert it because there is a CVE attached
> to it: https://ubuntu.com/security/CVE-2024-41024

Not an issue if it is breaking things, let's get it right.  We can
trivially reject that CVE if needed.

> Also, I am ok with changing userspace if it's necessary. It would be nice if
> the authors can clarify the ideal fix here.

No, userspace should not break, that's not ok at all.  I'll get someone
to revert this later today, thanks!

greg k-h

