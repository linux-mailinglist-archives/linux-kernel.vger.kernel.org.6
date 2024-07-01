Return-Path: <linux-kernel+bounces-236305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB391E038
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5347D1C21983
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCBF15ADA0;
	Mon,  1 Jul 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K0UZTwOZ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAB158D9F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839182; cv=none; b=IzHZ/mHS1p48ysQsT0aly19MV2AHEmYrD68LpzwqJT0ROaVw33DdrZ4BrLAW0ORZ+n/lyKWFfOurfatSxw9RliMtzuyAwV28ubGLEDy1MMMUx4k3iSJlSpyxoNc3cBHFs4q3AKZICOUk6aGM4G3AhCv96Gaxsady58YIIhBuy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839182; c=relaxed/simple;
	bh=oGYSrYWdqSlfP50f6B+7Y3qjHt/RSL9qLTDw292P7QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW3xhj2poAA8W43qJE+NNhK8kaBYUMQC124GKO4wRWPZptayvt6RmBcxVrxUzglU09ObyQTx8cPedFlzHO72awhMmsw3kQwG6IQtgp2YkYi83tNdLIWxwE8dqMdZePcbVffWX3/RZGmg0rRIoaRkwy/rN8TRVqaTagSnJmruqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K0UZTwOZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8624060003;
	Mon,  1 Jul 2024 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719839172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOigm+lmrrAayqgxGapMPlIg5+QAdA30qXZZ1VJ9MgE=;
	b=K0UZTwOZRzVe/+8QVUPUZnI5ZqLpGOmEoiR6fE/1Rx9/9UTuImMOwsL+NqmPdV+5bEtId5
	Xe4xlnXP/lWu4m7Yg6hOT//UyYZXc+BOwZGJRjJWgIKc4H8u9Xo7M8SRZnf33I1Z/Cq5HY
	NVSJQ6rfOuneCzN75ViNv8l7ejHfAobZcxJxgqESVkUlLDVIrWSwxsf9M0CDUujUSGQjn+
	s9wJ+dDY3nG0sMhiRxTSjo0vU8joRjIvU2QLPJlPk9ZwAfSay06ZhmQOO/Ef0Ss1lYWPpR
	yKUsK3YJOPmEl5HAotX+HZZMFV9o8QzD/2P3BTz9fzSmnf0zcdMVIBMiI7krPg==
Date: Mon, 1 Jul 2024 15:06:09 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v8 00/17] drm/vkms: Reimplement line-per-line pixel
 conversion for plane reading
Message-ID: <ZoKpwWaX4LGqLC04@louis-chauvet-laptop>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hi everyone,

I sent this iteration over a month ago, and I haven't received any 
feedback since then. The same goes for the two other series [1] and [2], 
which I sent after discussing with Melissa.

I'm a bit surprised that nothing has been reviewed or merged, as Maíra 
mentioned in [3] that she wanted to merge at least the first 11 patches. I 
just checked, and this series applies to drm-misc-next. However, if you 
encounter any issues, I can send a rebased version.

As you can see, I have more series ready ([2], [3]), and I am working on 
additional features (configfs [4], variable refresh rate, mst...). 
However, I am currently waiting for feedback on this series before 
proceeding further with the next topics.

What should I do to move those series forward?

Best regards,
Louis Chauvet

[1]: https://lore.kernel.org/all/20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com/
[2]: https://lore.kernel.org/all/20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com/
[3]: https://lore.kernel.org/all/c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com/
[4]: https://github.com/Fomys/linux/tree/b4/new-configfs

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

