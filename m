Return-Path: <linux-kernel+bounces-518072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606AA38986
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C33B000C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629C225A2B;
	Mon, 17 Feb 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UxAl1eLe"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55198225416
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810294; cv=none; b=iu7fyy42SQEdjS8bxZ8ZN+QA/l8YIORM/cOUTVIPh9j2QS1vITV3XZ+/Nq5jq7zP3ihg0pJ4N4Bj7oN8nzSTeTBNkjqA/8rOAS1hmQWMv6iwMPjvL5f2HjKItIF6C45xzuKxD5ldxYj1mEcMw1kmfYXp2MdEksvxQSGiZW0VVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810294; c=relaxed/simple;
	bh=SOV2GkD4Y1xPZx8skN/SVArTJ9f7Uc8ltIPsPF0B3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bheMEEFSy+GbGocIxQr8mjmBBkL5zy/uuIrOdJP9PV6HssE+zDnnL0NAaG+KfS92mwED3yW8BYMss7v1CtzipNyqrZ18uzyBMs2lg/AI9hJN/U7ho/LNe6Gy7KadAcVhtWQBSyLFAQ3Akx5gA2o95AWsGpBt38u/rzlRpkz+fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UxAl1eLe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f378498c9so1885268f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739810292; x=1740415092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlNG99GTV+OPIhKK6SzcOvuW8gdnJ6Gb1Ice7bp65SM=;
        b=UxAl1eLech7n6HDi/lSVKXGFIKDCCvbocN7humKBdANj7a2azALZ/xdE7BnzTJO9bn
         qpyWaV3Mp3MmFi/ePvhfiDA1QnkZmkYrnyGjf2Fnm/VoW+/Z0T+eCuuqhBDfLQ8Mi1n3
         qLlubb76GhxwKnkkbQzX8imr34nz0cNe668tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810292; x=1740415092;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlNG99GTV+OPIhKK6SzcOvuW8gdnJ6Gb1Ice7bp65SM=;
        b=K32WX/27ZVHpHwODjRmfRZCY74F6hZSYK02g4PPjGP75svrUM99ZG75tMZl96l1Sb6
         us+ssrkR8L62+mSgWfm8WL4benPVZQWVJAGq5hQzDlJ0GlY2xB+e/4ykLLdAmEsjrvCf
         oX30XZuEgVX2Sb1XbCy86Ucu0ExPvsVwduf4kdZ1J0OQCmiRSeDZqlRXupFCCWBmmFbD
         HfwuzceGqP9QxHUYsK9ZndeC9IbYXT7XxEvncCdHJHXbm9fIffkYCG/lmdNa9rkAFff4
         LPeq3/x6XphBeWVsd66fmUwrl/eS8nspcchBYriADgvOqzPLGm02RRJYLo3PBkvnLHm6
         7tsg==
X-Forwarded-Encrypted: i=1; AJvYcCWr/s2bp4IbLUAZjMK770ZTkBfaokiyw0s4zxybxAKVgGzRD45NHcoVBS3BITUujblX9xJJw3BhYr/astg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNaZNJOEKDq8XUU8PxXCcFeA5DVU2WJ0pIQPYUYZkr5M+AFiA
	UOIqAOv7Yqg3AHdrkHaJumOGtI366dDVWmNzMhHlj79+Wv7SwsmKYAfYLU5NiCI=
X-Gm-Gg: ASbGncvncTevab2tk7g6BHoX5qpAqvzES0NrM0eIPIAKxYHAgPNTcHp8KTIKnMBjFuu
	LBqWK49tRoV7pAoBxtDSG8YFFQq7kfUeiWEc9adGnc30RQEDMErtFCc8ZlYJ6AS2AG38oKLRNl0
	J+H06pYTw/XJ7Gyl8quw2RKQREr3Djb+mqki510+5X2C9qEoZaZLUSsn/yZijbuQTG/zcL+N59B
	l2ORjcwcS87BgG2L+MO9fLteWnCTjkacYa4eyK+P9r2CHsw0sbWiQnkZiNq2QJD8h3sCXZvMOrg
	NJ74ApbkfrmBs0qnZdbmxXT3XkA=
X-Google-Smtp-Source: AGHT+IFd60CRWw/crQ4PqJA9O3LrM84lDIdHjWDAqTBxNvL64UjwetWcSQc4ZaOGrZvRZATo4YxAqg==
X-Received: by 2002:a5d:638d:0:b0:38d:d2ea:9579 with SMTP id ffacd0b85a97d-38f33f5651dmr8950428f8f.46.1739810291617;
        Mon, 17 Feb 2025 08:38:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm12704381f8f.70.2025.02.17.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:38:10 -0800 (PST)
Date: Mon, 17 Feb 2025 17:38:08 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 32/37] drm/bridge: Make encoder pointer deprecated
Message-ID: <Z7Nl8JiFncngynNy@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>
 <nfb4fb6lzjw4j5brsh242htgw3au2moklqjalfa3zzxjsi2qn5@l3censelmgbz>
 <20250214-arrogant-strong-hoatzin-efdcd8@houat>
 <yy37e4kne7i2hl7coix6v7vajb5bm4zohod4fdzayvxr52l57u@cxturs2uxgcm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yy37e4kne7i2hl7coix6v7vajb5bm4zohod4fdzayvxr52l57u@cxturs2uxgcm>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Feb 14, 2025 at 03:29:12PM +0200, Dmitry Baryshkov wrote:
> On Fri, Feb 14, 2025 at 02:07:18PM +0100, Maxime Ripard wrote:
> > On Thu, Feb 13, 2025 at 06:35:15PM +0200, Dmitry Baryshkov wrote:
> > > On Thu, Feb 13, 2025 at 03:43:51PM +0100, Maxime Ripard wrote:
> > > > Other entities (drm_connector.crtc, drm_encoder.crtc, etc.) have
> > > > pointer to other currently bound entities. They are all considered
> > > > relevant only for non-atomic drivers, and generally perceived as
> > > > deprecated in favour of the equivalent pointers in the atomic states.
> > > 
> > > I think there is a significant difference between mentioned fields and
> > > drm_bridge.encoder: the former fields are variable and can change. The
> > > latter one is static and set at the bridge attachment time. Nevertheless
> > > I think it is a good idea to deprecate it.
> > 
> > I'm sorry, it's not clear to me here what you want here either. Do you
> > want me to change anything to that patch?
> 
> Well... I was thinking if we should expand the commit message. Most
> likely it's fine though. In the end, I've r-b'ed the patch.

I think this one is wrong, since the bridge->encoder link is static. This
is unlike the connector->encoder->crtc chain, which isn't, and where you
really want to go through the atomic states or you get funny stuff.

I don't think we have bridge chains with multiple connectors though, so
this is fairly academic and so maybe still a good idea to make this all
more flexible? Unless I've missed the memo and atomic bridges have
flexible routing, and in that case yes this shouldn't be used.

Mildly confused ...
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

