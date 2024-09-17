Return-Path: <linux-kernel+bounces-331828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D83997B1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F93E1C218F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A34184546;
	Tue, 17 Sep 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jfRFsKpD"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECD17C99B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585129; cv=none; b=SZmxtp/fEtN5KXho6yz4Wn8rnQ7Z82cTPng7wX4SaG6kB1y5AtBVoYEDMrSBq4QyP67TMLfZ4hxPDWdlLIObTkErE0vP/E7ZXGEP8jWfQCFhiM7BUOcKJSwfCDhaIzpLBzBN+EGAH3PusSQlwlsSbI+JcZmQI/iXuLP776YJ2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585129; c=relaxed/simple;
	bh=NmVUmeOzlys0kSoIEYqDhgBZLT8MPcy+WXTwZcPLABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRqEKmYG1uWsrpCuKIyKcBXo75du3iIHI04z+/hjZiQ8YbDXpbco62GQOf+feNztttigoRylrhWvaOZNqD1Myv0CoVfII0HhhV35C4Kd03AglO/7d5QqxWJj5xzZ9pTNL33eAKhICa/32pbQU2aYrLc8WDMOvXyXI4vDG+LWXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jfRFsKpD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06DE01BF20E;
	Tue, 17 Sep 2024 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726585125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSNzm0MM9/kWIscB7xeO3+8HP21NdASVUDDgzdIZKOo=;
	b=jfRFsKpD9CXtw6PRDTauyhcgsblzRJqqtou/enyRuKEhkJd+K19cbGNB0+c4mVXDa1oFnw
	6khvjLvGFXvNC1ma9zpX9PlRndaGFIr9cGWcZZNpN5yEqz8EYfPESGe45lJdLkAIIn7Xkg
	1lpL4vqzBNpFVpwsjFytUto4qBEM051uoJ6g/pEfve2CHxyMTX+NTmo1sszGOYE0KTnEu6
	jpIp1B07V6amMXGqAJ6xNJ4UqttzKz9QC+DJrPY+LtWPzcB5ohh+SE4FVuz2+/QIFcf9nq
	k+5VL4b6RKa0UNBH3wysR/qK5MUNvp2VngnAFTVYdWFGvrCq3AXkMZe6IcWqxA==
Date: Tue, 17 Sep 2024 16:58:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: pgaj@cadence.com, Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: linux-kernel@vger.kernel.org, 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn
Subject: Re: [PATCH] i3c: master: cdns: Fix use after free vulnerability in
 cdns_i3c_master Driver Due to Race Condition
Message-ID: <172658508687.68424.17048789596930423201.b4-ty@bootlin.com>
References: <20240911153544.848398-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911153544.848398-1-kxwang23@m.fudan.edu.cn>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 11 Sep 2024 23:35:44 +0800, Kaixin Wang wrote:
> In the cdns_i3c_master_probe function, &master->hj_work is bound with
> cdns_i3c_master_hj. And cdns_i3c_master_interrupt can call
> cnds_i3c_master_demux_ibis function to start the work.
> 
> If we remove the module which will call cdns_i3c_master_remove to
> make cleanup, it will free master->base through i3c_master_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
> 
> [...]

Applied, thanks!

[1/1] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
      https://git.kernel.org/abelloni/c/609366e7a06d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

