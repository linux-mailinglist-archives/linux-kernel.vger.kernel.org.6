Return-Path: <linux-kernel+bounces-385260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729389B34BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D1BB21AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF91DE3C7;
	Mon, 28 Oct 2024 15:24:16 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951221DE2C6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129055; cv=none; b=jqw5lCevpmA/cXBCTm2Hbdf4kTFveGCnfzaUa6gYYj8LqRM9T0NiGB9u6VdbIk4jaVTmc2bvMLsIfeoyY79MOdWVnaj9dgz0zZd8RcPthBL3ip8oAVgxG+LtPIkQ/6vy5QSrAzMnXgqcYkZvCrc5IdA9aFiG7NAirCPBJCTZlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129055; c=relaxed/simple;
	bh=JtTrG/4GdXbrMkhit+ETrpCvKaheVe6oGpgIVECq6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOk1CNbBMVja8SZDLr0/UYLvJ1Aw/LCQf7Q45pjlhLPfsIciYoxjscrUegDkW+cZczZ1N4n879cn5LythirHngMzEY7GN6QoRWlS/IvqP4yM3gy1WnQiNjR+kt3Vzv5X8J5BmydFPbzSKflSYuPlN1a52i3qlvWWUSnFyX/WeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so693606066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129052; x=1730733852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H87zT4Qpe727lS8z09w0nqgSuCfv7zoKQxxmfDjyp0c=;
        b=SMGpgkT4gLioiu9Q3o9SDKtv82rmhJWPv9UCJ8elmdcg8+fGkBdofuTrY3Gmd6BGyv
         xcD5+PSQYJq/KSO7pmz05YQki1xzTyzB4zNQJKy+l19cXqhTm+WfVj5F+P2J7FbrZrfu
         vjBJ4bLyE1dCBSnvmxXkRbf5316SSUWERcGx183ojz/3BlAhSnlKTdwXb9pJvKz7BGZi
         q9jESk8ecydi0WZHSDYyBmkBsRY7Vik30J7QN3H5TRIO5YOuJDQXC7ssgMkbLfWBydMu
         4TcuA1NvacXe662OCk3+4BTpzjrnogE33PyAt6hgNXoZSHwhaZg6dS/B9Ao6RfqDSwaB
         Jomg==
X-Forwarded-Encrypted: i=1; AJvYcCU0DGqiZyu0YH8y0VMXi2mn8IFyFW+SdTBya2+cvDSYpdIrk3h8JN4khzRtJIitxbGFVdqCxrx4MvEz9cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxioztk+OWPHExwwCCf17cAhkUPPsiwbw8/TcGzv58gV5WJekiQ
	oAeiLNnxlbCbanPU31CbhOe7Z/DDxkORYoOqjmFrdOtxChEnnqIu
X-Google-Smtp-Source: AGHT+IGLTpe4Nm/jo2HXoxCW0nbU+K+ZCwgom9UexWOG2gLUtmI2+KkwT3n6NFXwlzLf7M18Z1if4A==
X-Received: by 2002:a17:907:9729:b0:a9a:7f92:782 with SMTP id a640c23a62f3a-a9de61ea441mr761303866b.52.1730129051562;
        Mon, 28 Oct 2024 08:24:11 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029564sm387822166b.51.2024.10.28.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:24:11 -0700 (PDT)
Date: Mon, 28 Oct 2024 08:24:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: kernel test robot <lkp@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse:
 sparse: cast to restricted __be32
Message-ID: <20241028-silent-hissing-ant-aacb10@leitao>
References: <202410271721.jiVrriXD-lkp@intel.com>
 <20241028-sticky-refined-lionfish-b06c0c@leitao>
 <20241028141051.eoltcyf37lf5dsyp@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028141051.eoltcyf37lf5dsyp@skbuf>

Hello Vladimir,

On Mon, Oct 28, 2024 at 04:10:51PM +0200, Vladimir Oltean wrote:
> Hi Breno,
> 
> On Mon, Oct 28, 2024 at 03:56:50AM -0700, Breno Leitao wrote:
> > On Sun, Oct 27, 2024 at 05:36:56PM +0800, kernel test robot wrote:
> > > Hi Breno,
> > > 
> > > First bad commit (maybe != root cause):
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
> > > commit: 782fe08e9861d00ce8aca370453dd9ceb9a23d50 soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
> > > date:   3 months ago
> > > config: arm-randconfig-r123-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/config)
> > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
> > > reproduce: (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202410271721.jiVrriXD-lkp@intel.com/
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > >> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse: sparse: cast to restricted __be32
> > >    drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/linux/module.h):
> > >    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> > >    drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file:
> > > >> include/soc/fsl/qman.h:245:16: sparse: sparse: cast to restricted __be32
> > > >> include/soc/fsl/qman.h:245:16: sparse: sparse: cast from restricted __be16
> > 
> > Thanks. The commit above "782fe08e98 ("soc: fsl: qbman: FSL_DPAA depends
> > on COMPILE_TEST") was created to detect problems like this, since it is
> > not possible to compile-test dpaa driver. 
> > 
> > Copying Madalin Bucur <madalin.bucur@nxp.com>, who currently maintains
> > this driver.
> 
> I will handle the sparse warnings exposed by your COMPILE_TEST change,
> there is nothing actionable for you, except review if you wish.

Awesome. Thank you!

--breno

