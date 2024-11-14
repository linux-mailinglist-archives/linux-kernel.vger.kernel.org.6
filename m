Return-Path: <linux-kernel+bounces-409778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448F9C915D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAB0283591
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAC18CC17;
	Thu, 14 Nov 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="fjZAzTbR"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840C18C92B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607560; cv=none; b=qNNzJ7rRWCnJUrAU5IKWIwXloczMoICJzip2gRZ1YQd4QEV/02x9MP04666UCvb4K7LbK8dpwMc4AkFET8ujUM9p6Y9hX7fzAjvqCN2kG37ILeQ9FG3vhhsiOPdmcxeT9k7YvIE0WQ4x1LjCbicyaGEiKkuFdeCsP8i8jzhOSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607560; c=relaxed/simple;
	bh=jXRph9NfOW5onZ2iP5qRU/U8A71e668Zy6tQyB/Z2Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg5XIVijdyI0wuko+TW9UEeYg9Ac3+hTLz9Djg0Z5cHXpkT2W0u5flLWBgDLhA6RI2FJjftlX1ZfBhEr+wSaP3pZhuXinyFtPabFOM2qzHwtpexMGlnNrdhmrPxWkfAPQm5NV0OWipQ0dXaidLTVLzD46rmP8ddfSTCBoPO/XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=fjZAzTbR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6CD7440777C7;
	Thu, 14 Nov 2024 18:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6CD7440777C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731607547;
	bh=6Mrmh8SlJGuf6/TCn8LCJHutLgCLvW0FX6am49VxyU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjZAzTbRsFrqqGgohMLKbaSs5pp63q2gddJJ6TBnJa1/hH1VVlqAl2Bf6bYvPK0ck
	 MTtPde7CHBfeI3CgfhOAflwN5PM0wom2u4HwnKx3fGcK1KV23H0m7wZ9J6guM0XZcM
	 qP3u0TeKmlld0DCps1Z3+gzDmoi/6h0EAOb+2U8Y=
Date: Thu, 14 Nov 2024 21:05:42 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Murad Masimov <m.masimov@maxima.ru>
Cc: Dave Airlie <airlied@redhat.com>, Simona Vetter <simona@ffwll.ch>,
	lvc-project@linuxtesting.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Subject: Re: [lvc-project] [PATCH v2] drm/mgag200: Apply upper limit for
 clock variable
Message-ID: <20241114-1e41c566600f3ef18943a36f-pchelkin@ispras.ru>
References: <20241111163306.860-1-m.masimov@maxima.ru>
 <a394af10-8428-4d19-84cf-f21ec63f23f5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a394af10-8428-4d19-84cf-f21ec63f23f5@redhat.com>

On Thu, 14. Nov 17:47, Jocelyn Falempe wrote:
> On 11/11/2024 17:33, Murad Masimov wrote:
> > If the value of the clock variable is higher than 800000, the value of the
> > variable m, which is used as a divisor, will remain zero, because
> > (clock * testp) will be higher than vcomax in every loop iteration, which
> > leads to skipping every iteration and leaving variable m unmodified.
> > 
> > Clamp value of the clock variable between the lower and the upper limits.
> > It should be correct, since there is already a similar lower limit check.
> 
> I don't think it is correct.
> 
> If the clock asked is > 800000, then delta > premitteddelta, and it will
> return -EINVAL.

In many cases when clock is > 800000, the check won't be reached as the
division by "m" variable containing a zero value will have occured just
before.

> With your patch it will instead configure the clock to 800000 which is too
> low for the mode asked and will result in corrupted output.

Worth moving the check just after the loop or e.g. explicitly denying
clocks > 800000 at the beginning of the function?

