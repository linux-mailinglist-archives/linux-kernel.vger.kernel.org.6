Return-Path: <linux-kernel+bounces-319144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A4896F875
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F84F1F261D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE11D2F67;
	Fri,  6 Sep 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l1v2xZcS"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147A1C9EA8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637127; cv=none; b=HUPuot+KltBEVbD78rt1YUPBomCIvYzRn5pHErc8PXY0W9GOM7yzjSNyNUu2Efe24y2miMrYfavDl6yfvQkpY+JuPjoMMCljvQFnbuAtDJiSRzpov7CZ2qzQU/dMXEFG5NFR6w1SIaRk+dkTkvS0IDrD/8XoJkNlJmAhOgTpf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637127; c=relaxed/simple;
	bh=HzRZGonux5r43jMIj7yucErYFQnB933qHzpk5Ycq1LE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyn+jO+C1ro+tvVQ5NwOSVYUSSAXMqXlnv9eQJTHvHNlp/g53J5e9QGJ6pV64iTUxg7XSnebfHKz9cFAJuHnFl0Du35rGCt6bWynWHZso75kbd8zVlVAK91LIf8G8Wdwc9j6SBrZ7hMWrRG4j3aiVhkYA6rl4MKzROmcXT3ov8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l1v2xZcS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C8591C0002;
	Fri,  6 Sep 2024 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725637123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4phgVOTHCmQ3HBq6bcLfhgvUwM7d3HDKaPMvxrXCk/Q=;
	b=l1v2xZcSrhrOOhepIqsujTu+JcDkvfDxPR2ZTqv9TLjv6Zu9jlDJ6URgzaKXz7LYBsUkdv
	UiWik8Mc+TWNn27SEs/p6LTtRv2M+BbONoPgAZhdubWq1BG/j556B6m+PN572HTkM4+gRK
	FQTff8BZynFBvu9hfpf5hjtzrjCM9WEIISoN81q6e4DsYScRrQb3G/Qq3rxu04MLNUPah3
	why0z5fepADZvgtXEnZMFWElV3wmz2KFwG7EPNql87bjdYByz/Y8JqMw8UxlyoNQXMxFYt
	1mSIej2j+hZwtavetQvLgQQkntSqn4obvTxRxVKxJkSfPXtYZCprw/upgkhi1w==
Date: Fri, 6 Sep 2024 17:38:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
Message-ID: <172563708354.975422.17313525144371866545.b4-ty@bootlin.com>
References: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 26 Aug 2024 11:38:21 +0800, Billy Tsai wrote:
> Based on the I3C TCRI specification, the rules for determining the I3C
> mode are as follows:
> I3C SCL rate > 8MHz: use SDR0, with a maximum data rate of 8MHz
> I3C SCL rate > 6MHz: use SDR1, with a maximum data rate of 6MHz
> I3C SCL rate > 4MHz: use SDR2, with a maximum data rate of 4MHz
> I3C SCL rate > 2MHz: use SDR3, with a maximum data rate of 2MHz
> Otherwise, use SDR4
> 
> [...]

Applied, after fixing the commit log

[1/1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
      https://git.kernel.org/abelloni/c/061dd21ca712

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

