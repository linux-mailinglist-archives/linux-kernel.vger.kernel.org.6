Return-Path: <linux-kernel+bounces-391416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA899B8666
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A239B1C215EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF901D0DE6;
	Thu, 31 Oct 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="czHwhS0a"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74E19CC05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415355; cv=none; b=aSUqIzjuenuy85sa/FaiLf4osmzltM4d4Ag5F6OYDyyjuiS59FSXdXIucRyAVzm25uWBAjREmUQpecKQOQthncrGuv1DhoE+02THl/E0wro3jwz+Gfquu820sT9If2QTdzBbr8ocNy7btqeH8lWsxaoxotUoLJAEeibJjfpm8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415355; c=relaxed/simple;
	bh=NEWLqxDG/7C24HdYcXnUKC+fUO1Z0ESsfr5iv5uCqsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz+iKV5oWjPUB9fUDx7m+PVz4qKbX2WLR5f6lv+xRe6FGewbFjSaDThpDlz8bi17UEZDKQ5/TLcfXHzzOILGFODmq3FvHrQ1r36GY20m7yQMFfHde3ylCRBYXK9j2VRrp9N0ajoNP6jo0EktMBFEh+rhCYeCetwMKxwQT6plQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=czHwhS0a; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABBD4C0005;
	Thu, 31 Oct 2024 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730415342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQA0d1WJrJIdFs7Zvw7Azp27bcFdE29fGgC676nj/eQ=;
	b=czHwhS0aKKP6ir28M751dMssoU/Trd2ZUOKZ5ONNx/mXiun4QOxVtlUQ+NWMAkkh4s2Kgm
	914fRoNAfZ4RrIwBv1J+DL3Rft7St5AKkHCoqCR/287bqeHE06UoCx3AwdPitPabzPSFO3
	b5PQNVtIJ7/6eFqYmhd8PhrcDuF0eMvmFiAueAM3bTvvyVd18w29+FHFJgFztw45D2jWeG
	gwT9Zm5mr9y83+DtkKN3c8vv/GKYGeKAtOJXQ2+UiZDZFQbynV4vBmLE/yUPbx5els16L8
	oRr2rxOB278G2Q5JUBtJRip43tZ0bhBmKOMFZmg2w2+uj3kPSMWkVQVdbaABhw==
Date: Thu, 31 Oct 2024 23:55:41 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, stable@kernel.org
Subject: Re: [PATCH v6 0/6] I3C: master: svc: collect all patches to improve
 hotjoin stability
Message-ID: <173041531797.2391928.6742670173313972551.b4-ty@bootlin.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 02 Oct 2024 10:50:32 -0400, Frank Li wrote:
> This patches is splited from
> https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/T/#t
> 
> It needs more discussion about dt assign address issue about i3c framework.
> 
> This series is svc driver improvement and bug fixes for hotjoin. It fixes
> all kinds hotjoin problem when 2 devices random hotjoin and A normal data
> transfer is on going.
> 
> [...]

Applied, thanks!

[1/6] i3c: master: svc: use repeat start when IBI WIN happens
      https://git.kernel.org/abelloni/c/3c6684a15010
[2/6] i3c: master: svc: manually emit NACK/ACK for hotjoin
      https://git.kernel.org/abelloni/c/e22405a812a1
[3/6] i3c: master: svc: need check IBIWON for dynamic address assignment
      https://git.kernel.org/abelloni/c/6a12f56f7392
[4/6] i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
      https://git.kernel.org/abelloni/c/f36f6624cbac
[5/6] i3c: master: svc: wait for Manual ACK/NACK Done before next step
      https://git.kernel.org/abelloni/c/3ca529194e29
[6/6] i3c: master: svc: fix possible assignment of the same address to two devices
      https://git.kernel.org/abelloni/c/3b2ac810d86e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

