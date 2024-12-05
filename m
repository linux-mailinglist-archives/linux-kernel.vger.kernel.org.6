Return-Path: <linux-kernel+bounces-432788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4A9E5055
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F8E1882381
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC34199920;
	Thu,  5 Dec 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cO1Bn9l+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856B1B1D65
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388868; cv=none; b=XCeWvr18+P+TBUoBUCXhzP4cTZmYUHEFNUxJcDUU6f8CAG36titOhl7N68FZIrMtXZDaXPcUHS6u7d5QcOxqtBVnaYwKbLQBmrhMfagILjwiW4x+cYyNCjnVoSMbjBICH3jhQL6+Nz+lXah/KW28r0qFwxh6Tu4tGSh5qBm37RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388868; c=relaxed/simple;
	bh=oEZ8rhW2ytSHWJcE9Z++lbOMIs3gQTmU/D6Etsh4zxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxvR2b3w3hbpS6Hhe/EC1eNrMw3ViGDL9YecJpKc0quRqgTVLJGXSmu8r38+c0lDBqp3QyT65QFGxbAena2DZP0vcDnJjXPBZye70ccR7gOHjvkRo9KqM7sbqzXXfDwWkEwoBonmto4cWrB/HI9MZTdwQPI8CdXxSN757277WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cO1Bn9l+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IcsDxMoiN7TNJEZpNWOj8buoqn0gV394uJbXKXQCWiU=; b=cO1Bn9l+peVZ5Vp9k8peqnNgHR
	aIBl+/9vunapUW8U+SeqbA2ARNPeIj/OnX+tsUTfGYNembEi14mWx+i7abMncCvpjz1UfR7yFbDvH
	OBLv0HW+HWm0ObwTS97O+2SBqOryjFkK+f/RXloYT8M3Ma0wzTQ/dvYhb0uTzsMcrALxBHjQ0B9m/
	VeTpNrYXoNJbNk+LKqtP79AT9NMzLN0EvmEjE2IYpHR57+fUcXJ3zczSieD8MMBqhEBubBUKIFYLi
	G1yYOzNlqoKvPR3Oib9JptAQA0I6zlLL5T6acz445OFfnYoFepSKmZhc4pNf0p0KVZfw4DnMTJi5s
	fckR/8gQ==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJ7cg-0001mo-UZ; Thu, 05 Dec 2024 09:54:10 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Piotr Zalewski <pZ010001011111@proton.me>
Cc: skhan@linuxfoundation.org, Piotr Zalewski <pZ010001011111@proton.me>,
 Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>,
 Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH v7] rockchip/drm: vop2: add support for gamma LUT
Date: Thu, 05 Dec 2024 09:54:09 +0100
Message-ID: <12938960.VsHLxoZxqI@diego>
In-Reply-To:
 <9Rp0NJW2QG5qDduowVaialZWN6xTe9KJFciu7Q2LERJZQXsUgFvMGXfcFaNznIEJEBpZeOdZPuL4fxOEFduaSJLuQJ3cIvN-fx2lEzYSBKE=@proton.me>
References:
 <20241101185545.559090-3-pZ010001011111@proton.me>
 <9Rp0NJW2QG5qDduowVaialZWN6xTe9KJFciu7Q2LERJZQXsUgFvMGXfcFaNznIEJEBpZeOdZPuL4fxOEFduaSJLuQJ3cIvN-fx2lEzYSBKE=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Piotr,

Am Mittwoch, 4. Dezember 2024, 16:45:21 CET schrieb Piotr Zalewski:
> I just noticed that after coming out of suspend gamma LUT is lost and must
> be rewritten by userspace.
> 
> So I guess it will be needed to save LUT to a buffer and rewrite it after
> going out of suspend during modeset?

Most likely ... the old vop does this already too, so I guess you can
get inspiration from there. (gamma_set call in vop_crtc_atomic_enable())

> I checked the patch isn't yet in the "official" linux-next.

The patch is in drm-misc-next:
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4f537776340dab2b680a4d8554567f6884240d0b

so should turn up in linux-next at some point. This also means, please
provide a follow-up patch for the suspend handling.

Thanks a lot
Heiko



