Return-Path: <linux-kernel+bounces-390598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D59B7C00
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298A01C211F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F91A254F;
	Thu, 31 Oct 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZ4OLf7c"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C219E98E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382209; cv=none; b=AqLzgyqw+mKO94y2TV3ho67kQUELBQxO73cSqy3UmkNaDZg2usSOyQmaVCSomONjBcpSegE0f8dIlK4OGbNgFExcZnPUnBv5aF9OnAJedWQhjdOZqi/fAszbJhRNQ8MYkXgTemWZsE2vBjmA/7uz9OS2K73Xra02SFxn6i5EFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382209; c=relaxed/simple;
	bh=a0mFecBgNuD9c1b6XGh4mZAiv/pFVHebfT+E8XzHrNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVMoT8U5XM9ZH38w4mwmTzqJaoKD/2IUCkI3UwHUS31UthpBJudTGB/Mvy8oGVVh2m6wK3EAnUu6YCBUdjKEaJoH8FoIPgB2Z8kO6gXIUJKvGjvQ14WZgc9nDOgvxHtda9h5wFhTeXjWIcNKYJsgG/2q012onGOIrTc97cr+rAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PZ4OLf7c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c70abba48so8246805ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730382206; x=1730987006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgqLVJtUS6V/VxSplDk69LNhyYJQoAiM+I9RcwTlMEQ=;
        b=PZ4OLf7crmDp0BMd7Jg07829aytoy2bXHNAuEdA5BVQ2gbiEu0dqEpOwYT8pHOyBmV
         V+SKuCZhILxjm1e8SyJ6AWSouSSJ2NBiNt2Oldttd1TWbPzq3Ivs/+6xUWknwijya/6i
         uSxn4ZP615mdAleuZB6K0u7KmyBSYwOUrzNZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382206; x=1730987006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgqLVJtUS6V/VxSplDk69LNhyYJQoAiM+I9RcwTlMEQ=;
        b=f3ScZR5FnaQjt6rFBbfeOFeQaXbUpAJZ0qavxzpljsHcvdaKt/NWrBZS7GPSZbnhT5
         t0AHXN4UBnG4v38dnayYL3rG2Oa9iU4397J6NM06PcR4ebYOmnLxFWJQ2tAo1NoLpWLW
         n9LjWBIVvi5CZGwhZBWMCo5YwSbxAsTfB8FIA39EVCT0QWpQjyOy51XvfdD/zdc9QcIG
         Qg+2xQ/9hgd7yzOTzqDVsx8L8O4+BhTHtGBRez0J56YRNAAAnCRn1lTQViib4qxlR436
         kBDsgQr/s5fALsOgBVWK3bxgw7iZqy8SSfPv0LDY2xLmKRdBombt44xvFWvXu/unaNAC
         rkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYcAVM6VeG9axHVv8AQSbHNT9EP9MJPR8RHY7KR1aMgZ6lU+GhHt7kLplVgZxfpXeDI1ig6t6gAs3tOQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1O9Yzm2RU+aX9Rvkw2eRF/JVDEWHYILaR3rG5MKJocCoc7Ou
	NlADkVJpq8XTGj4QrZ7p+932KmuY5ufTgD5jH59t6cnOOBNq3DGVqfqlc/sbmg==
X-Google-Smtp-Source: AGHT+IHG9QcftBtYNodIEgxQElxzpG4w1S/ex0D6O3laQzIHMUa8PmFjj80z7pXz8hO02AkecLyFPQ==
X-Received: by 2002:a17:902:e74c:b0:20b:7ece:322c with SMTP id d9443c01a7336-210c6c16965mr264141835ad.29.1730382206203;
        Thu, 31 Oct 2024 06:43:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4470:8fa8:957a:6c05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707e43sm9009905ad.97.2024.10.31.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:43:25 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:43:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] drm: i915: do not NULL deref hdmi attached_connector
Message-ID: <20241031134321.GW1279924@google.com>
References: <20241031105145.2140590-1-senozhatsky@chromium.org>
 <87y124jyl8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y124jyl8.fsf@intel.com>

On (24/10/31 13:33), Jani Nikula wrote:
> > intel_ddi_init() may skip connector initialization, for instance,
> > both intel_ddi_init_dp_connector() and intel_ddi_init_hdmi_connector()
> > are optional.  This leads to situation that ->attached_connector may
> > be NULL for some connectors.  For instance, on my setup 'DDI A/PHY A'
> > and 'DDI TC1/PHY TC1' are not initialized.
> >
> > However, functions like intel_dp_dual_mode_set_tmds_output() and
> > friends don't take this into consideration.  This leads to NULL
> > ptr-derefs:
> >
> > KASAN: null-ptr-deref in range [0x0000000000000848-0x000000000000084f]
> > RIP: 0010:intel_hdmi_encoder_shutdown+0x105/0x230
> > Call Trace:
> > <TASK>
> > i915_driver_shutdown+0x2d8/0x490
> > pci_device_shutdown+0x83/0x150
> > device_shutdown+0x4ad/0x660
> > __se_sys_reboot+0x29c/0x4d0
> > do_syscall_64+0x60/0x90
> >
> > Add a new helper to avoid NULL ->attached_connector derefs and
> > switch some intel_hdmi function to it.  I'm not sure if we need
> > to switch all or just intel_dp_dual_mode_set_tmds_output() (I
> > have only seen this one doing NULL derefs so far).
> 
> I think the question is, what are we doing running this code if the
> connector initialization was skipped?

I'm not in position to answer that question, I guess it wasn't even
asked to me.  But...

For instance, intel_ddi_init_hdmi_connector()->intel_hdmi_init_connector()
can "error out" and leave ->attached_connector NULL; I can count 3
conditional returns before `->attached_connector = intel_connector`
assignment, yet none of the upper functions would even know, because
intel_hdmi_init_connector() returns void.  And this is not the only case.
So there are several ways to have ->attached_connector == NULL.

