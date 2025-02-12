Return-Path: <linux-kernel+bounces-510295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B48A31AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF331888D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A76156CA;
	Wed, 12 Feb 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3YOQvw5"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E635FBF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321473; cv=none; b=E5t7fFzH7qD2+PhdZQO4YDC8loe/SkaEZBemSvm13hJSKhxFZoRAEGpwEI5sJRS6xUHyCJ5HLU7hd4XaiaDz4Rux3unFnhlsJLTS6AQSbNQI5l1XMNSqVIwXXW9T0Fb+rQDrPdr3uG7WnCFRcjsELWpJ0TXxnXKnZNoPWMgFoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321473; c=relaxed/simple;
	bh=iDgfw7D06BV6DpvWC/SBKtipHT37O7eJVNt47iRLts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrLvpm2fjpVRUey0xFhqtjf9AP8T85Jx0K67Xvz3SH8f1yu22Cef1SGb7P3XA/hmci4ujBhBhFEN8Xy/hcipKKdHO11j4GpO18l3aUsYZNw+FZ2OKEL/AkL3cVYn3sdQDtSpuSQGY/FIN5j8/8xf/nNTfVwrUo9Cr2pDbQNvv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3YOQvw5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30795988ebeso62616821fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739321468; x=1739926268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nLci9veCthHDubqv0cSUycI42m1FuOueczGHBi1MmQ=;
        b=r3YOQvw5PMymzjvzLqy7ImTV938P580U8SxuDuL/RlppJNgh6IyaiRCSx3uZWh6+nc
         cRA4NuzA22uYDwEbA6pO8oA676xZY+rmmEUOm5CV0AaN76O0+ct0UfZT0ez+FJmSqlpj
         v+H77lUfJrzzqqNgpn6R4slYutPBfFY4MHSYDqke2PGvcGPQdYYEEzajbaniIuqdRML/
         R3dEjYJMX97nYSSCtwxs/qP+Xx1c0CWX7+QipUpc8SK4X4pmC5frdzLxJt8RrZooLKFr
         cWoTjJGbDKnUBgLKFxNmG5J+tVRCT7rukgqB/5HsGd9xNB3J4ixWp+cm5/TyfTthceg+
         Wcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321468; x=1739926268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nLci9veCthHDubqv0cSUycI42m1FuOueczGHBi1MmQ=;
        b=gFzRbbGf/Z6I/NCXA9xaTKdv6HR6d9N9f9qZgrmGa/TvTvxEPvrdjqAUtL2/1Al9Yw
         HDvrrVZjTRAijjc17S9VuTH3oVLS5Lo/92OMwU0FXj8blY2RdBwfmQvwrCH/wVgC0iQm
         pMHUXZvKcvkapyskcmdHaxGHZ1XgHVYZNeIx8xsfAhiDLVQqXKe8kJz8WJJpAfqbwe1Q
         oWq2jSrVKW8p6dXbePMEE9Fxu53Zr8rHV0zueyV3RySO7FUb8KUlq9OtW8tLO2bFJT7v
         juUyUTByOwEL8hwnXY/xuHvvR+2VEUUMgadwp8Ujvw6Brb2IOxoIp+FPJ42CtN9IBpMa
         nyHg==
X-Forwarded-Encrypted: i=1; AJvYcCVcB8Sr+hd8TRAXxTPdfSeMWKU7RX970b/XuTwlxODMJDKYxqZhOPXSxn/hrCyRlG7JZQqweNiqAqUiWaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5qT9DKqfn8+NcrfNxNGTBiDqhRwvNzFF9tYsyX2RnzTclnl4
	+XrftO7XCOn+dXr5WM8Ga6g6AFZeR+T1QHqBw/LVEH8LZ6gzm8MBeqFZmVjcObllg3vrnQ8Kw9N
	eYqY=
X-Gm-Gg: ASbGnctAsQYaNl/bI/Qm4TeufGOkQzut3T8yb9r/kFUorvx1U+GTmQnn2LN+WN/VAPG
	z6QiVrhTOtaBlcztcaptcrkDAwOeulbimT3K6rYSVYEpTMpTj0khwQqb9zFF4cPIYDo8ZZATFHC
	AEmj6Z7KagVqrWUaxqRJXHfxXuzsVOTqJGukevvccGfy4euk5FfRqa3yRMLAx0BgSIXB+x6LkCL
	78m2spVWFRTjZMoL3wpwdcOi+zke9618LUzh+BRUrlgjzMh7NIDtFc5vTurEOIV72bUe3vTEEnJ
	4X5kZxRD7ktcZEKjhAi3MAYkfmt63C58cevx8wZIQAeetcAHBqk7H08WZhqLdBdBpAovXqg=
X-Google-Smtp-Source: AGHT+IHrEVCtROhIx+YyYA4QRU91GByT1IhN/KKKBcdE8BrWoX2fAT7zlZDzAxjgWmcLyL1wGBtxPg==
X-Received: by 2002:a05:6512:33c9:b0:545:6fa:bf60 with SMTP id 2adb3069b0e04-545180ef5famr301216e87.19.1739321468152;
        Tue, 11 Feb 2025 16:51:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545067a7576sm1079063e87.198.2025.02.11.16.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:51:06 -0800 (PST)
Date: Wed, 12 Feb 2025 02:51:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 00/35] drm/bridge: Various quality of life improvements
Message-ID: <b5og5jvjq4jnq5rogyro5rtahayvsbroq4z3yrplioyb4itbak@3cepdouqxyny>
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org>
 <yudkovtipwtnofr3o2qwqrmriwxlczrwploieh5i4ke3sx5zhk@5ktlrew7o6k2>
 <20250211-peculiar-misty-moose-639556@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-peculiar-misty-moose-639556@houat>

On Tue, Feb 11, 2025 at 02:17:30PM +0100, Maxime Ripard wrote:
> On Sun, Feb 09, 2025 at 05:27:01AM +0200, Dmitry Baryshkov wrote:
> > On Tue, Feb 04, 2025 at 03:57:28PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > Here's a series of changes after to the KMS helpers and bridge API
> > > following a bunch of reviews I did.
> > > 
> > > It's mostly centered across providing an easier time to deal with bridge
> > > states, and a somewhat consistent with the other entities API.
> > > 
> > > It's build tested only, with arm64 allmodconfig.
> > > 
> > > Maxime
> > > 
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Pass the full atomic state to bridge atomic hooks
> > > - Make attach take the encoder as a parameter
> > > - Mark bridge->encoder as deprecated
> > > - Rework the logic to detect if a bridge uses a state or not at
> > >   atomic_check time
> > > - Add lockdep assertion to drm_bridge_get_current_state()
> > > - Link to v1: https://lore.kernel.org/r/20250115-bridge-connector-v1-0-9a2fecd886a6@kernel.org
> > > 
> > > ---
> > > Maxime Ripard (35):
> > >       drm/atomic: Document history of drm_atomic_state
> > >       drm/bridge: Pass full state to atomic_pre_enable
> > >       drm/bridge: Pass full state to atomic_enable
> > >       drm/bridge: Pass full state to atomic_disable
> > >       drm/bridge: Pass full state to atomic_post_disable
> > >       drm/atomic-helper: Fix commit_tail state variable name
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_wait_for_dependencies()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_tail()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_tail_rpm()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_modeset_disables()
> > >       drm/atomic-helper: Change parameter name of disable_outputs()
> > >       drm/bridge: Change parameter name of drm_atomic_bridge_chain_disable()
> > >       drm/bridge: Change parameter name of drm_atomic_bridge_chain_post_disable()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_update_legacy_modeset_state()
> > >       drm/atomic-helper: Change parameter name of crtc_set_mode()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_planes()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_modeset_enables()
> > >       drm/bridge: Change parameter name of drm_atomic_bridge_chain_pre_enable()
> > >       drm/bridge: Change parameter name of drm_atomic_bridge_chain_enable()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_writebacks()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_fake_vblank()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_hw_done()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_wait_for_vblanks()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_cleanup_planes()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_commit_cleanup_done()
> > >       drm/atomic-helper: Change parameter name of drm_atomic_helper_wait_for_flip_done()
> > 
> > I agree that use of the old_state can be confusing (and it has been
> > confusing to me for some time). The main question is, do we loose useful
> > memo 'this is the state after swap'. Most likely it is useless now, just
> > wanted to give it a second thought.
> 
> The drm_atomic_state doesn't change after a swap, only the
> plane/crtc/connector/private_obj (and their state) state pointer do. And
> if you meant that old_state mentions that the states have been swapped,
> it's still a terrible name and we should change it still :)

Ack, sounds good.

-- 
With best wishes
Dmitry

