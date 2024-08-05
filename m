Return-Path: <linux-kernel+bounces-274365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C1947760
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90A11F21B58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582DC1494D6;
	Mon,  5 Aug 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="c1xn301e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SeD4BYcx"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EC14F9D7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846833; cv=none; b=R376nb2kyb0D0roIXdm+Dzn1/BeHsIniUn6UKflPxGOQNgz5GFdeG/A2bJLWNhgh4KRLnB6J/HpsoSdUV71SWPAETDb+A2NoNO2T/LXiTO7DSB1Lc49ULIyCuSWq1obu/062K7zggcpuCqZqLByWktm3hLxdQPjDKWPvEVW7uxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846833; c=relaxed/simple;
	bh=E91a+VTwhceaSODgrHkbHHr5BYlJ7t1Ysj7YhU/h+bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMDZyukyeTEc1xqML2LNLussoLwtsc9YEhR+/fIcyQsojfVI2KvB18Q9EiaDEvtp9eqEEWQ7PdD1rM0l+fSyeicD/q4cm9cvMMwbd+toH1diV7rbQeiQNjBj9sg9SKWRjYlwvpsxGPznLo48R5U7FbiEErq+lK6yT6atJ2XSbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=c1xn301e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SeD4BYcx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DC4C51151DC2;
	Mon,  5 Aug 2024 04:33:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 04:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722846829; x=
	1722933229; bh=zJ9UFW3JNgRiKo3q812jCKGIld512jGf9/66Tll64Ls=; b=c
	1xn301eGytn+wVO1yDQK7keAg51KkyefkwH7umZ/HpnpT34xYA1IkNaB3yMOGUNj
	WYuV9aAKj91S4rnDu9sVYy3ZVDtt9T7bafSwW5nWmzFt7oaOqz8NDuEAAhTmi3/B
	I4nRCrY1hWoutdn559YzWyIsVuTbMDPNrX8aqHNN6oOlkTQUs/TedrJy5elpzTKG
	wkzMhwrX0xF+zN0ZOSQBGx/ooRnNdD8CZbyL/J97uOD95fs9RkRbGn/6vN90SnD5
	DJDn2BMWHXG/CyFDOGqtT2b4K0y2dT/3b3NUeKNu3/CKzzm4kucfQ7BklXWfWk3k
	jHDixHmoqugSeSi0OthRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722846829; x=1722933229; bh=zJ9UFW3JNgRiKo3q812jCKGIld51
	2jGf9/66Tll64Ls=; b=SeD4BYcxOLcdEs4eGIo4ctBaMjlGxDgRPHyUERRUd2sy
	2m6bAtjpv86yMUcbFy0zf4MAIQKYNS72ZyzfBA2XmFxKMQfOOT4kCAg8c457e6nf
	/5kRdmgoJYoShFN9G2pRSuYkxMbCW9YsIPJz6VdPf11r5Cn2ss9JEy+m6iHk8Wji
	paJViiJhGtMkatlEJXZtgfVc+OBEh/vpldpQ2OA5AV4c6bwqMj7qhUZzM9NLSYsO
	ZRuPQgdwZkGkvj1i417xhyD6pIWMhavNvuv3wmN+yvopMjQgjLbVZTP3AIDFIOkf
	4otq5ieKzMTspcd4BbfLGCJGdtoZBEBKAIokjqw8JA==
X-ME-Sender: <xms:bY6wZuW6MrqXscaKw96EOb09DPNSNZ2F8-PY1mNQwNgwoDO3Q1Mddw>
    <xme:bY6wZqltlQSjtmcKH2AFgoIrat0L7puMtpAKLR_joOHXCDD9RvrjVBN35OZO9DU2w
    wjkLG3KeXu2wzOFtms>
X-ME-Received: <xmr:bY6wZibfUdEzWvs66yiMn9QTiRa8ulogjtgIW6Tr_pP0Kvcz9hrcgO86gEcc-dMKDKzl_3IuE0tGaS6h8icJFUjoUM7BOH-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepuedvffegge
    egfeevheehlefhgfevfedtgfffgeelhefghffhvdetheefhffggfefnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:bY6wZlWTQ547DS4fWmLXjwiIoby65VXO52Z_LbjYyeuBx_lEI86DnA>
    <xmx:bY6wZondw92IWsNK9FMn2WQsO__X_1HBICUvAtUNUgH8CRNrkdupUw>
    <xmx:bY6wZqcFoe6J9m34l78kpaT5HnuJq_Mo4W49YUG00w3jc2BZ4wqxPQ>
    <xmx:bY6wZqEDNcC63EOcAdKDflUcaZag9oIzUe4IdJ1vXdkfHueQCMVFDg>
    <xmx:bY6wZnu00_6EF5ZhaP14cmFuDlIzVPv_d-ML7vLJiXjeYKmo2yysEHzO>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:33:48 -0400 (EDT)
Date: Mon, 5 Aug 2024 17:33:45 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: kernel test robot <lkp@intel.com>
Cc: linux1394-devel@lists.sourceforge.net, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] firewire: ohci: use guard macro to serialize
 operations for isochronous contexts
Message-ID: <20240805083345.GA248096@workstation.local>
Mail-Followup-To: kernel test robot <lkp@intel.com>,
	linux1394-devel@lists.sourceforge.net, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240804130225.243496-18-o-takashi@sakamocchi.jp>
 <202408050730.y1eyRcTv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408050730.y1eyRcTv-lkp@intel.com>

On Mon, Aug 05, 2024 at 07:33:01AM +0800, kernel test robot wrote:
> url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Sakamoto/firewire-core-use-guard-macro-to-maintain-static-packet-data-for-phy-configuration/20240804-210645
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
> patch link:    https://lore.kernel.org/r/20240804130225.243496-18-o-takashi%40sakamocchi.jp
> patch subject: [PATCH 17/17] firewire: ohci: use guard macro to serialize operations for isochronous contexts
> config: arm64-randconfig-003-20240805 (https://download.01.org/0day-ci/archive/20240805/202408050730.y1eyRcTv-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050730.y1eyRcTv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408050730.y1eyRcTv-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/firewire/ohci.c:3138:2: error: expected expression
>     3138 |         guard(spinlock_irq)(&ohci->lock);
>          |         ^
>    include/linux/cleanup.h:167:2: note: expanded from macro 'guard'
>      167 |         CLASS(_name, __UNIQUE_ID(guard))
>          |         ^
>    include/linux/cleanup.h:122:2: note: expanded from macro 'CLASS'
>      122 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
>          |         ^
>    <scratch space>:133:1: note: expanded from here
>      133 | class_spinlock_irq_t
>          | ^
>    1 error generated.

The macro expands a declaration, while the line just after the label
should be still any statement in C11.

I'll post take 2 patchset.


Thanks

Takashi Sakamoto

