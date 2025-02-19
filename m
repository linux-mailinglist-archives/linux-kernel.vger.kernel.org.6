Return-Path: <linux-kernel+bounces-521632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A121AA3C02E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F73A94F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7C1E3769;
	Wed, 19 Feb 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JZAMqUHG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780611E0DFE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972232; cv=none; b=ERXRaP18SJubF/V6RdQ99mbq6u4KGM7f2UiycyGgBWNxMLJctFJiO5H5unnaUUJKIlLLbm0lIBI3Gn0jdrUzJXmpWNuFrXnQJqDlR7sJh2RkxIxRoiwXKqYbG94lNcafXOgyukEsTQNRUBdzWCjlscaOvrMLwy8fdjkcMRGJRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972232; c=relaxed/simple;
	bh=YNfMkcHnM9cnBHYQ6JglwYMcpo/ZFteXEw1Uodr81ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNMqnuU6BPAeBKLxWkj47UQLbvlLkEQN6VSu5969t7j4eK5eul+/KXkJXwHctKeKpgf9IL6lKb5ad37UBG4j17FbBCKbLpQHQi18SAJF8N2s44rDWt1hBiMAGu6GurivXV2APFCOS5LJ5qofa43wauyZ+hRcVMRyZjsJnqZy4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=JZAMqUHG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4396424d173so68912805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739972229; x=1740577029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnaSCouzQmNuhqYTcZLJpNbPQUbz2vK2Oob4CBiaQYw=;
        b=JZAMqUHGm0JWg0PJQ0kSEBSIGjZ8HT/ESw+1YnnZ2ZlkoZZxTS92NaJFz16OJu09qh
         JnNW/LIIShw1+XgctYwK2LOf0Ol0hotHSooOlyHNFX8KKbb78J5Zlmc7UdG9lyRFttTN
         4rwA8lDLoMSt2KG69Hx5V2AWus167t4QdegLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972229; x=1740577029;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnaSCouzQmNuhqYTcZLJpNbPQUbz2vK2Oob4CBiaQYw=;
        b=YBmsgwGYcgu1kXKkHV++/iK0T1RZDWBMQ+yYy+jMztcsvHnHkagy7/BPnhf/eEwSu1
         9zKg6apAFJmvZCPU+I+NCSKvaN2++Ii+mZrUaOGZlDXY5CDXYWuyB/xTZa36mrvBkY5K
         VTOpGNAoDBZzLIt1TV3XPdgZIwqBuApGxsqyEiGy0nUCFb2VLRoFkR7W4XtwV9PXG16q
         TZbLtVccfh/YfiA5zCNnl11apV6IUEslLuE/8Pv712TLJj57Q+PnKwpji1RN/fOgt0jB
         62Fg6f4aisTFpQJQa7T7ghAT+ak+e8XCD46+mHBGj6IfRN34ETtzhMey92WpTUmch91G
         nVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD1DGz3c/RtMt5lKCQnnoZOYASxo9/3N/RXI2DiCV1a1jChvhmjSTLTRWdfD/o+Qkn1o/WMTJd82LurRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/gS7Wgqmw37kbbr0raayTBiHmlb+XV/iFGCrsSG10LSQ40/Y
	GUPaRqDcaAZerqdo+X5Hv911IN7ktDyItUGyqI6iwwa3S2AtneeVoXG2y8Qckug=
X-Gm-Gg: ASbGncv5Cjc92qLAhsaIz0YVLsfTrdJ+lX0pMIkMqwkb6+CmfjPIo6sZ2EtFkxZjwc0
	NsUGMGdh4zxtQJIRKWyCWNG7OXqjzVUeNt2g6/ykDBxwOuJg8/q7E4NvNEj4EkCgkrXwuPWI0Ju
	eWxPcaLG+l0f3vSN/tfjkPLP4n51mKt5lg8Ozvg6mdFLha/zXINnTnZ++prrQwzx/Tycr2JR5mA
	QXcHtptCrlfHltdS1hxOz1GbVW+g48RjVGW7+Iyuhh9koBv87xR0HKH8Ty/cC9VXS9jAQ9/Jcpp
	Th2f2IyLrlGxhMhFXJebm00s5Kk=
X-Google-Smtp-Source: AGHT+IGGRfoQHCYTnobHX61n/c8lJyBUwM3cGLFfRiuWQzf+sYUfBk2z/yW3uYQI5OozES3QICOcIQ==
X-Received: by 2002:a05:600d:8:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43986c4ac03mr121856395e9.15.1739972228743;
        Wed, 19 Feb 2025 05:37:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm215410785e9.27.2025.02.19.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:37:08 -0800 (PST)
Date: Wed, 19 Feb 2025 14:37:06 +0100
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
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <Z7XegnwgIy8Xe9M6@phenom.ffwll.local>
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
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <Z7NmtF83adILfasi@phenom.ffwll.local>
 <padhzkj5astckiltvxkcs4xq335crrhf2m6bvii6cezyoyfypq@t535fgjwqzqg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <padhzkj5astckiltvxkcs4xq335crrhf2m6bvii6cezyoyfypq@t535fgjwqzqg>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Feb 17, 2025 at 09:36:35PM +0200, Dmitry Baryshkov wrote:
> On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> > On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > > Now that connectors are no longer necessarily created by the bridges
> > > drivers themselves but might be created by drm_bridge_connector, it's
> > > pretty hard for bridge drivers to retrieve pointers to the connector and
> > > CRTC they are attached to.
> > > 
> > > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > > encoder field, and then the drm_encoder crtc field, both of them being
> > > deprecated.
> > 
> > Eh, this isn't quite how this works. So unless bridges have become very
> > dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> > chain is static. And the crtc for an encoder you find by walking the
> > connector states in a drm_atomic_state, finding the right one that points
> > at your encoder, and then return the ->crtc pointer from that connector
> > state.
> > 
> > It's a bit bonkers, but I think it's better to compute this than adding
> > more pointers that potentially diverge. Unless there's a grand plan here,
> > but then I think we want some safety checks that all the pointers never
> > get out of sync here.
> 
> Luca is working on bridges hotplug, so connectors are dynamic now. And
> at least my humble opinion is that we'd better provide the corresponding
> pointers rather than having a lot of boilerplate code in the drivers.
> (there are enough drivers which look up connector and/or CRTC) and there
> are even more drivers (I think, I haven't actually checked the source
> tree) that could have benefited from thaving the connector or CRTC in
> the state. Instead they store a pointer to the connector or perform
> other fancy tricks.

Yeah definitely don't replicate this across drivers, it needs to be a
helper function. What I meant to say is that we have a way to do this
already, and it also works for dp mst drivers. So full blast fun of
dynamically selecting the right encoder _and_ hotplug/unplug of
connectors.

Unless bridge is very special, this should work for bridges too.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

