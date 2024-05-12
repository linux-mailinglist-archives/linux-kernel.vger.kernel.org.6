Return-Path: <linux-kernel+bounces-176852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B008C35FE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB599B20E88
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84E1CD11;
	Sun, 12 May 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="dxlTVxnJ"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728671B966
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715510213; cv=none; b=cgiYgYV6eY14H3pRdcS4/h43J+sxXeIoWBe8AlmwiqhZIuRFSVzMLi0b9Q5dO7afeD1eURrCtXF2nh7dtKT+UPJSIdaIUkjWNVB110MaW3XU33eSRDqGAbqJD8QUCGUNsEe4xCCNDACrz9drOXbhfqXu9yg5RumIypIrAM6TmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715510213; c=relaxed/simple;
	bh=j30ddHpc932nEhD0I8IE5h30/grSJLRgARi76cpJ6M8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XQcI3GR8Vg52DhoBJ+Nt25TQQ8mHNSU4ZkTYME9krZ422WiFJe+i5FQiLBHieSVUvOZNKYaFPcBJ/189l05Z7IIxltc5ZV2q1PQghIkksFKjeQhB6uL30lHoOuXj9dYcJAXZdCsShG3r61cpARgjYsd41X6+SAU2KdGj7k9Oy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=dxlTVxnJ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CFrNgpT1Nwpx03uo6E/jHNM9dH4Al8QsEcPwh5BEXAY=;
  b=dxlTVxnJTUY0dP9lttlkLJ3cyJL1u+DbDsbeG6z+nmQS1o7/bmovgH2P
   8aKjVF+vrw4dW5xdOd2NdngZ/DQ/XzU3HwieUPMzjxBe7JgngPmEC5kjY
   9OwOCKaZdfZ0dHzjbG05MPXFcYA3AdDsHO1Wd2q3A1QJZhb/Q3zqG7MfQ
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165237912"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 12:36:48 +0200
Date: Sun, 12 May 2024 12:36:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kousik Sanagavarapu <five231003@gmail.com>
cc: kernel test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>, 
    Santosh Shilimkar <ssantosh@kernel.org>, 
    Julia Lawall <julia.lawall@inria.fr>, llvm@lists.linux.dev, 
    oe-kbuild-all@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>, 
    Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto
 cleanup
In-Reply-To: <ZkCZTv0Gci3xxKtw@five231003>
Message-ID: <alpine.DEB.2.22.394.2405121235270.6747@hadrien>
References: <20240510071432.62913-3-five231003@gmail.com> <202405111846.3m9z398l-lkp@intel.com> <ZkCZTv0Gci3xxKtw@five231003>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 12 May 2024, Kousik Sanagavarapu wrote:

> On Sat, May 11, 2024 at 06:12:39PM +0800, kernel test robot wrote:
> > Hi Kousik,
> >
> > kernel test robot noticed the following build errors:
> >
>
> [...]
>
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1840:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1835:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1831:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1822:4: error: cannot jump from this goto statement to its label
> >                            goto err;
> >                            ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1818:4: error: cannot jump from this goto statement to its label
> >                            goto err;
> >                            ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1810:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1806:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1795:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1801:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *qmgrs __free(device_node) =
> >                                ^
> >    9 errors generated.
>
> Seems like gcc didn't catch this when I compiled locally.
>
> Normally, this would be fixed if we placed braces around the individual
> initialization blocks, that is, say
>
> 	{
> 		struct device_node *qmgrs __free(device_node) =
> 			of_get_child_by_name(node, "qmgrs");
> 		...
> 	}
>
>
> That would make the code look a lot more dirty though and is purely
> unnecessary.  So I'd say I'd drop this patch and do a v2 with the
> remaining two patches.  Thoughts?
>
> There's also some stuff with classes but that too is not really worth
> doing because the code will end up looking very ugly.

Please include the patch in such a message so that one can see everything
at once.  I'm not sure it's necessary to show all the error messages
either.  Just a few that help illustrate the problem.

julia

