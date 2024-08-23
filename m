Return-Path: <linux-kernel+bounces-299389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0295D3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DC51F24052
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AEC18E030;
	Fri, 23 Aug 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fn9vr9UG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FF185926
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432488; cv=none; b=Kfl2ridvskEdTS0s51hemtrhFqKTguZ0YhAZ9Vf0OM17amkJZmbFIWCW+pqKEwXIWWRBa3t/qjPfRcL3Nb5D+VncFyiffd/NXcxBG+5gBidznnGLju/85OZ4/QRRXqHYzlF2x0baBSNg7RBLgJ0/SCGHJiaV9Xb9VhxPFRGDshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432488; c=relaxed/simple;
	bh=dRWOQakGWVPeAiDAWQvLCol3//JYeKAxaHSWNjBbGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljDor+bFn/up2+xT2/FsgVAZU+14nnvIlPtD/65dhTKVZggsRq4jslfc9wds2mv+ImlgxZWhba2btCXFkT8sYB4RTZ1Kz98LzuEShkFmmdT1ZWgNEbevPIIObohaQhwoC7n+vMH4yy8uvb6kEa3rAO3OV8oqmbyS6+mAbm8waS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fn9vr9UG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so16342165ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724432487; x=1725037287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WXvTj5hKPGYaRuXVlmgpULBUstvUKA2aKGRZ6UgIo0=;
        b=Fn9vr9UGfXbvGLBbgVibXhSquT5A11cqfrVlsch5KQDe6nz29EF47iO5+6SHIva2Ak
         NR2gK2L6Q6dd+NctZW5oDnAphL83RPU0gnZl+qKVQOaUwAevZMTyAIEVTXGgoh94sPKW
         Jx8BpbsihbqyRtEJSexmxM7FL9phsc+mAmOFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432487; x=1725037287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WXvTj5hKPGYaRuXVlmgpULBUstvUKA2aKGRZ6UgIo0=;
        b=swF+cmiJrNGlfJaNUF6RqXMI3T0V4GZOzFtcNdr2LImyGDHjTra9/HdkYq+6YECVQZ
         FMTL58YoWbsuNnC3VFm+ooSBFoOlvCelA0Wd1Uyabyw/xBqxarVMjFjtPeLRr4gEeRQ+
         uIFS5gHByejTx+nY7Uh2TYpTlqTFyD08GKt9CUyzcGdJI8aXtD+VgoIjE3yJaHwGBPQa
         3L3hZ4t13UEC4ApbWFlnoCukgy2EkDilPAKDysFx7/prUHKCdivyhlOEshUr+Hho4iRc
         5eeCDPAouV6GxCEmqibXo33ARuwI2Kj5LJGcrdKO1r+tm5B3EIr8tXk+1FZZvFQFWOsl
         X9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd0K3VPkd1lDAIJYZxkbnbiu9aVV5iBfTeyldcmV8dRcmQbX9Blr4emr0K0zzFcVIMAbV304ENsBNvhhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDR+yuIgFQKHvozo5y2+r9AjZOlaTyypKq6Ul++7pfH3JUnngW
	ipxaZsqIgx8PE1/EB2pnqT/aIrZ8AY20rStOTiqAYclKuvyd/WLlGoLASGuH6w==
X-Google-Smtp-Source: AGHT+IFxRy7sr8mxRW8Kbetw0svXm7PUYpT6Tayz5pujoftJtRZ3iDb8TFyiMd53gOAIZ0FG6Z7KTw==
X-Received: by 2002:a17:903:188:b0:202:c33:b7a5 with SMTP id d9443c01a7336-2039e469d36mr34601425ad.14.1724432486885;
        Fri, 23 Aug 2024 10:01:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9d43:7af7:9970:8219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2038ba35d3csm28333295ad.19.2024.08.23.10.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:01:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:01:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Chen Yufan <chenyufan@vivo.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Message-ID: <ZsjAZJjBvjGLkG7f@google.com>
References: <20240823070320.430753-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070320.430753-1-chenyufan@vivo.com>

On Fri, Aug 23, 2024 at 03:03:19PM +0800, Chen Yufan wrote:
> Use time_after macro instead of using
> jiffies directly to handle wraparound.
> The modifications made compared to the previous version are as follows:
> 1. change the type of mwifiex_auto_tdls_peer::rssi_jiffies to
> unsigned long.
> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>

Changelog questions aside, this looks fine to me:

Acked-by: Brian Norris <briannorris@chromium.org>

