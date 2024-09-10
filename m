Return-Path: <linux-kernel+bounces-323129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA497384E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378061F24E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EC1922FB;
	Tue, 10 Sep 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ABYYV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35128524B4;
	Tue, 10 Sep 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973791; cv=none; b=i3YaOQEZVRgnS29zOrF8+7M4f4LTiOMW+NL/c+dFVVRw/zZJFkyr1T2urtsOzqJgSjk/y9werfDCSew9MvTMRRM9/eAmuDCVREfxsAXrLo2IgbU6X144x1oSytnXfp9clisy+BhrhSKAT2S3OHZryTA9WqurBWm29uV64o4HvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973791; c=relaxed/simple;
	bh=gXFzUSI3qK5Cbumkz3jbbr5JOPGAjlF9NOVDFBm058E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLuYQNaS7R223oZtK8zLGd4NiPwSzvdXRl/naPiBBAa+lJrINq+L/3+Em4R00jjdXHRBKzmUQpbJtxWM65Ecve3pN11nIuAciRpObGXguShHgsWxz+kDE48UGwBguJOPdq/+iDFSuJnmTBn4r36MLDVoUoKLWY7tkIQlVQJDBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ABYYV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43367C4CEC3;
	Tue, 10 Sep 2024 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725973790;
	bh=gXFzUSI3qK5Cbumkz3jbbr5JOPGAjlF9NOVDFBm058E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7ABYYV8SFYY42PlP4lWVQriUJ5EPIAVGptsn0YQCUBr3shEbsYqhqV1ym8WdyIED
	 NIbalDIeJcNd1rB+LMsvjOI4wUfG1Zkct0W2NhnUV+zpZ63BFaHpjtoUleJMRqCyaT
	 +0SkVFP2fwKFjpsR3YYLbS5kafRz9k6AJrPEXzqDKBzh8+9QmkOmws4OJ4W5BENSwE
	 l6PozGaFSFr7tbrrGB3eHZyeBsTG3F443CN+sWg+8wRkYi6x4Ydrin0av9UiVmA0Et
	 Mo79rumPIRWRlKbgDV094lHmHs086b/6f3+0iG8hRfG2MmVIsZ8iWmZTHrrmWvgXmv
	 enQ9m96/QWUjw==
Date: Tue, 10 Sep 2024 16:09:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Fix cpu stuck caused by printings
 during reset
Message-ID: <20240910130946.GA4026@unreal>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-4-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093444.3571619-4-huangjunxian6@hisilicon.com>

On Fri, Sep 06, 2024 at 05:34:38PM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> During reset, cmd to destroy resources such as qp, cq, and mr may
> fail, and error logs will be printed. When a large number of
> resources are destroyed, there will be lots of printings, and it
> may lead to a cpu stuck. Replace the printing functions in these
> paths with the ratelimited version.

At lease some of them if not most should be deleted.

Thanks

