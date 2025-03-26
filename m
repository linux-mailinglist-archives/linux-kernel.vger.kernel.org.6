Return-Path: <linux-kernel+bounces-576720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B532A7139D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559521755A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45AF1AAE08;
	Wed, 26 Mar 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWLgV8QB"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B21A5B94
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980994; cv=none; b=epmRsWSse2z6seOSteyrwiVQ6/JhqAtORKxLbG4EOeZ5zk/WG8RZ90mglqV9A1wE6UtW1W/SbOmkUJTJR4dE9xIcPzbKDi6i8FzN8bPrZ9o+gwoAAn5VRnNzjzfAHVUQNASDWYTOXg1kFfcUikVy7YRnRlMcr55bhS+DJekvs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980994; c=relaxed/simple;
	bh=3yhFAj3HEIpovIZR3i63ZVWmJLvXXJ405jcYzIzFgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbMrr1Kz0aFFlxh5UoLuwE6xJddgBUxgOCEQEahWze9RcvsZfe6D6dWg3eFhwaZdpPAYf6hy/YFEIVlc32/ZIgO+eloEoWVHTD1sXnx2X0doL0j1R6SASAR0dKs2Dv4iFtWp5ELNbmOOd16BtTytLTwI+b1XjXMGEr6VxuLtr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWLgV8QB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04837432F9;
	Wed, 26 Mar 2025 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742980990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ICov7xy3anbwFGwLDL1Zlrl3SIGqSbOCI42+MYXwTs=;
	b=lWLgV8QBfEJlwFvqXBUA7qgcfzdChLj3CkFT/yadTnlCmWG9EKeXOf7zKMr9C2XP0GsgF0
	ClsOMLh9fCxuYkx+wWIF4erWDxw0zKVrTMTUUdtLER26J9qjoXjoTiRtrdIdcFzRwiGJlK
	Ezq7SsvAAG190tn5eyt+KyOKYU430oQMYmkUUrzGBdWq+MCUDg2RRrahHcwxpjg6JwA0dI
	SgV6q0GE1r7GiRji+UbrQftGVeHUlhzpT01oM2Ey5S60PAqY5CmB6dN9/fOImIsqOrBmre
	90WaDaLhU6rA/3Tj8HOwbValJNe9rfovhltxo4zSjhM75vpc8QpYvHiNY254PA==
Date: Wed, 26 Mar 2025 10:23:07 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
Message-ID: <20250326102307.5ee0cb83@booty>
In-Reply-To: <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
	<20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeljeejuddvudetffdtudelfedugfduledtueffuedufefgudegkeegtdeihedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrshhrihhvrghtshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehquhhitggpj
 hgvshhsiihhrghnsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
X-GND-Sasl: luca.ceresoli@bootlin.com

On Tue, 25 Mar 2025 13:24:10 -0400
Anusha Srivatsa <asrivats@redhat.com> wrote:

> Take the panel reference and put it back as required
> using the helpers introduced in previous patch.
> drm_panel_add() and drm_panel_remove()
> add a panel to the global registry and removes a panel
> respectively, use get() and put() helpers to keep up
> with refcounting.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

This is OK but is should not be applied until all panel drivers are
converted to the new devm_drm_panel_alloc() API. Otherwise for
not-yet-converted panel drivers drm_panel_get/put() would operate on an
uninitialized kref. See [0].

# Do not apply until all panel drivers are converted!
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

[0] https://lore.kernel.org/all/20250317155607.68cff522@booty/

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

