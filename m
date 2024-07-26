Return-Path: <linux-kernel+bounces-262873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF993CE26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A360B1F2380B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306F175564;
	Fri, 26 Jul 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RHxEZDUR"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C72B9C4;
	Fri, 26 Jul 2024 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975292; cv=none; b=JkJB4O96sS5nSsDdbIjb/I9E1oDBVxtBXXxhYwVj46UMKc4czKuP5KxDneiDkUcPf7xMIVnWWefLAGvbkeH+AA/ZQkpX8gamH8mO3PaK+N0hbMHMnuJP0lza6lPBp7D0HfRlnDVHLWmzzCK3qu5n7y1tlzMvT9D4eZoztRFzdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975292; c=relaxed/simple;
	bh=r80lj4hZKUqD2udwZJ8ycas5d1nB0H/1YubyA6RZMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkG5psWLNBqVaZXtuix4alKE4J5+czAiCBVvKwEPFxwKENGWND1+WwzuW5hIopvzkFgHBXDLxNFAQTxNZU+zS5PnDd2SN28SbgT8LYuNnLliKoovEDk8TlPSmFOfR+OygiBMry43qUZ+dN2m1cQhkpLBWVLua2pLqLzyljncAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RHxEZDUR; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1EDC2C04F7;
	Fri, 26 Jul 2024 06:28:02 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47900FF803;
	Fri, 26 Jul 2024 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721975274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOzzX32ozd6ZbK5MOx1sx+5gHj893tCji8oqee/N7ds=;
	b=RHxEZDUR0tkMO08C7OBQnwGgiEvEQdW2IB71JStgjKKOuItoWWzwxGd6J//LeLD9f1NDwr
	L/RViXbdOwTg1ICMSbYbUDWZjhvl7cNaazU5i+3V/2pQcOiVK2ybFNPsMHRjkzEY/nYMqy
	GkypQelyEBDP72i38ccAFJsAhqGk474Fcm29DERFfNNGY2N0fdWM8ZNd0mypbmhtNCSn9Q
	iaAP+ad3pgeJyg33cNk9LzMgsui0dn66zuHF1dDthyYCdu29Q5uelUXFrRx4xrwWgHpkNF
	rnM1+hIU4ktHsKdd1ONdXevmV3oqc8KzFK+J5vpDxghDI0ktnS21xfBxEQzjMg==
Date: Fri, 26 Jul 2024 08:27:51 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: mehdi.djait@bootlin.com, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 0/2] Add driver for Sharp Memory LCD
Message-ID: <20240726082751.74d349dc@windsurf>
In-Reply-To: <vlhicmhpvqkvdbyq2dsgqmofst5a5rjztr3uhp3bwyjhv3kqog@lu5lqtey262n>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
	<20240725074532.65616a26@windsurf>
	<vlhicmhpvqkvdbyq2dsgqmofst5a5rjztr3uhp3bwyjhv3kqog@lu5lqtey262n>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello,

On Thu, 25 Jul 2024 20:07:01 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> What would be the best way to go about doing this? I'm guessing appending to
> MODULE_AUTHOR and adding a Signed-of-by or Co-Developed-by?

Depends on how much you've changed things compared to Mehdi's version.
If you've mostly kept what Mehdi did, then I guess you should keep him
as the author of the commits (i.e the Author: field of the git commit +
the first Signed-off-by), and add your Signed-off-by underneath.

If you've made very significant changes to the point where the code
isn't really Mehdi's code anymore, but just inspired, then you should
set yourself as the author (Author: field of the git commit + the first
Signed-off-by), and credit Mehdi via a Co-developed-by: tag.

In any case, thanks a lot for this pushing this work, much appreciated!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

