Return-Path: <linux-kernel+bounces-410152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE529CD535
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4631282B49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187513B5B6;
	Fri, 15 Nov 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLuWA1/J"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A33A1DB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635703; cv=none; b=PmIzHGXzSk04f2OEphOpxSJZ88szXNlET2Hc58bqtScx27aBomtYet+COlR3mhbv+NxNO1A5Bra0VJpQrE+iyYvYMdTckRwFK+bLP+oVKN3nfGJOCoB6PrZqljgxgH93BsjAYAAyPatuHF9ntazVxbkzvDV+2WUxPF5gjNQEeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635703; c=relaxed/simple;
	bh=8JXaLFBg/yxJnCtgKoYpKvzhqj6rYCBZCmBpMXE12pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCjberqlPOsXeQ+SmDRfHFQ7Abr3HQQaqjqyHzV4CrVyic4mP1aaIwy9kntvrp1HLJ0OrL/Bs7JxVSe0Q43c4tj2PiBcZlDRNjzx28SE8nDgg9548VXupx2fcgGP4F0/qbYFMM/S8jqJyONbT1D5Bw/RoKBzcwJU7alkjASwBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MLuWA1/J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1082095b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731635701; x=1732240501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ax2nCJw28+cGdzTpn+eQtOhpC15VKouPR6tFXcvFPcg=;
        b=MLuWA1/JMTvEApzxEfDtGM/JPYUzDjQWFedaHyo2Ju5DC2ZBDY9l2qSHwC42RqU74a
         59yb1oDQ0MKnj5M9D1g6jfozG4bjwaYT+Zq5khxa3jM4zTxx7rQplikTZ//o1Qj3RQlj
         6MCNWuK2IOzeOusYI8kjPhUD00nxfESuWH5EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731635701; x=1732240501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax2nCJw28+cGdzTpn+eQtOhpC15VKouPR6tFXcvFPcg=;
        b=vzwtMuscaCPcLXKMpq0hHMfUL5h/EGf2bmUyTgczYR3W5cqapK61wBPcBKk9r//68U
         er40RwYkpfbG+o/0UIuNgK0oq00Eb91CGH421UamdRdRoO3hAGPhINNPhTLstUstuCIP
         gPMZbA3zoSH+vPEU9+vLaOVQeGhEhblZWqsrouUEEWBedBuoUuqEKl01knUs9mfSW3bX
         D/c2X3zY6j3GHpj/UP79sufdlMEv3SoJBmXDxC8zAtp0dIGs+1RvDxyxjLrRxuNT6KMG
         ELc0pMWcjy97g0eiadZh3kN96Vk3eO0COjoSepSiunglpaacwSPcSaNyyP1FLp4h+MmB
         gDxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3FYqUFi0TXIIaziRwgNBJ5nEkjj1gmmlImWThOgTurOwPevV+3Q0Hu5fq6LFEYh6tPiFdHzdOgCiSUbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwwr4RO9316JPC0KGTG76Z6sDdkiz9E6R2WIpcc/gcrTYc/PQ
	a1hZpTzYigEhSewIPNf4m+jCqsKIDP5pj9C8VJ4fFagMcoIyYMrPIGjpWRgf+w==
X-Google-Smtp-Source: AGHT+IH9aUdvAddesq/jNiojGAkb+nP6hjJUYZ/lJO+dyebRL5FJ6mciWhnqi85JGGRzIRwzHv/k8w==
X-Received: by 2002:a05:6a00:1413:b0:71e:1722:d02c with SMTP id d2e1a72fcca58-72476b726bamr1503003b3a.3.1731635701196;
        Thu, 14 Nov 2024 17:55:01 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f2ec:a79f:1362:3ac3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711ce3esm318534b3a.48.2024.11.14.17.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 17:55:00 -0800 (PST)
Date: Fri, 15 Nov 2024 10:54:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	ville.syrjala@linux.intel.com
Subject: Re: [RFC][PATCH] drm: i915: do not NULL deref hdmi attached_connector
Message-ID: <20241115015456.GL1458936@google.com>
References: <20241031105145.2140590-1-senozhatsky@chromium.org>
 <20241113083920.GH1458936@google.com>
 <87msi3bidr.fsf@intel.com>
 <87cyix6cc5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyix6cc5.fsf@intel.com>

On (24/11/14 17:53), Jani Nikula wrote:
> > Ville, we handle intel_ddi_init_dp_connector() failures but not
> > intel_ddi_init_hdmi_connector() failures. Do you recall if there's a
> > reason for that? Something like a dual-mode port where DP works but HDMI
> > gets rejected because of bogus VBT info?
> >
> > My gut feeling is to propagate errors from intel_hdmi_init_connector()
> > and handle them properly in g4x_hdmi_init() and
> > intel_ddi_init_hdmi_connector().
> >
> > Of course, we have cases where hdmi is just not initialized on DDI, and
> > those should be handled. But I don't think hdmi->attached_connector !=
> > NULL is really the right check for that.
> 
> I'm hoping [1] would solve the issue.

Hi Jani, I'll reply in that new thread.

