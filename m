Return-Path: <linux-kernel+bounces-407243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431A9C6AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B256DB21949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9718A6CC;
	Wed, 13 Nov 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8A+GEkI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE91185955
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487169; cv=none; b=BjReHUDb9ywgowMXnzvlmiyI4wYg7h9+yz+lUkOWa7z8SfqrLW7qE2ETIe1V3JOt1thwoynfTDYGaJzLaYia4pwvatGyhTI+/qE8v94P0zqYKlbHDUSH2Fevg++OP8px8qj1PDcuaef8RgUKliiyLubgtibqRU6uqeBDzcHfUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487169; c=relaxed/simple;
	bh=Jqov2zQMAO9Sr2bnnkqFB1XWwqVX8VIxrrgU5n0LkAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unLNNCCCSA3LNXJ9b/yQg6D5DnQws52laeNFFDiMU7RaWPVj0kg7hKHoCZTspSR60iK4qCMdJLBG45y38GfZZaNqyREMgmVZAzm6ZLtR/CcNh5iV4A30YuxPj3Ktkhgn9rPonoDjnqfJHRE97qjq2iP2zH2gx2mFl5KYNnmXFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g8A+GEkI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e576dbc42so69622715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731487166; x=1732091966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCh54mJ7akDtjRQEtrxBL2HcuujeMrTCRb2aEAuUOGg=;
        b=g8A+GEkI0MOQnbpM3EYx90UfKmULdyjfSkA/MmyDnhlE7rg+yuVuy5CqxaacCoAX2R
         LY/9Ny8VRUyhVuo04ADJ4NXlG+TM0xfrrkIqkLNmAshMmUBein6BT+z0tPN9TgqFMwd9
         V9LqsvdW3LPja0bkUjKOAGn5gyJzqhd2Bc1DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731487166; x=1732091966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCh54mJ7akDtjRQEtrxBL2HcuujeMrTCRb2aEAuUOGg=;
        b=ZiLKd3hu3FILUngbnDHM3mAGHM3uchWxiGmWRNsBuqflX3XbH7gAspPzzM/c0gmjRj
         qfV1ETAXvEG/gD/lr5hB8c2A5Vr7i3/UD0pQhnRqoiDukCQZ+ceV7+qOxP6W8TFqfva/
         5lCOkiCCY80oN7qIX2p8f5GTUox81t5xXuS1Z5kTtjEN81z4BWuo2mX5ZLr0cSwrk6L5
         7ziTrTNSM3ROmtBJSp7gXqs3RQ6eZJD6gcPjI+dYhuNOg43HUbKxG8SgUiN2l571Nc02
         Bekpx6iOnkaqsxrfOdKQepXDxpr5g2715omcNhY9SoygPWp4Qcz/FEk0Bxbxq5pA/E4F
         0GkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbyCxS3OjseXoMCTvS44QbXhe0mAur+qZBoWVJWuJhrFf6fdW66WgmdUxH/ZzuyibmD7ClA8cn+RGEjXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dSguuIw4QqAiVNaQBUWH8oC/3yGhYHjAMIeI9iNMe3V3H76C
	cCyGivnHicknzSK+AqUj67SNSUZCqAl+LcfvzcRXco4p3C87kyEIgE+aTXssQQ==
X-Google-Smtp-Source: AGHT+IGofwp7EUeDXY7jIEE+cvpp5/5zwkzHjXcN1QEH+3rUbiVmbD0XfKX42r84LsLTqCr/8CqElQ==
X-Received: by 2002:a17:903:2ac6:b0:20c:e169:eb75 with SMTP id d9443c01a7336-211b65d93c4mr20172145ad.2.1731487165765;
        Wed, 13 Nov 2024 00:39:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c:65db:bb29:3cca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41890sm106064175ad.147.2024.11.13.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:39:25 -0800 (PST)
Date: Wed, 13 Nov 2024 17:39:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] drm: i915: do not NULL deref hdmi attached_connector
Message-ID: <20241113083920.GH1458936@google.com>
References: <20241031105145.2140590-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031105145.2140590-1-senozhatsky@chromium.org>

On (24/10/31 19:51), Sergey Senozhatsky wrote:
> intel_ddi_init() may skip connector initialization, for instance,
> both intel_ddi_init_dp_connector() and intel_ddi_init_hdmi_connector()
> are optional.  This leads to situation that ->attached_connector may
> be NULL for some connectors.  For instance, on my setup 'DDI A/PHY A'
> and 'DDI TC1/PHY TC1' are not initialized.
> 
> However, functions like intel_dp_dual_mode_set_tmds_output() and
> friends don't take this into consideration.  This leads to NULL
> ptr-derefs:
> 
> KASAN: null-ptr-deref in range [0x0000000000000848-0x000000000000084f]
> RIP: 0010:intel_hdmi_encoder_shutdown+0x105/0x230
> Call Trace:
> <TASK>
> i915_driver_shutdown+0x2d8/0x490
> pci_device_shutdown+0x83/0x150
> device_shutdown+0x4ad/0x660
> __se_sys_reboot+0x29c/0x4d0
> do_syscall_64+0x60/0x90
> 
> Add a new helper to avoid NULL ->attached_connector derefs and
> switch some intel_hdmi function to it.  I'm not sure if we need
> to switch all or just intel_dp_dual_mode_set_tmds_output() (I
> have only seen this one doing NULL derefs so far).

Folks, any more comments / opinions on this?
What should be the way forward?

