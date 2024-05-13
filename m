Return-Path: <linux-kernel+bounces-177475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C88C3F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D659CB20982
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA014AD20;
	Mon, 13 May 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RLo707rc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367A5101A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597501; cv=none; b=Nb+fWVhj3wbbXm7P941HzdSbFgwNyEWXwgNy/UAPn9z2Kf/bk8pnTZCsMQCFmENAW6bLnNmHhAGtdTRgjbxZUc8jE7YLdkXK5ILCxbR6rL/fHbx/BpxQd7ztsLdPH4QH/pJHMOhcjtov2QdQmrHIqfpb+xEsiyy1M88X+8LAxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597501; c=relaxed/simple;
	bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmcFgVVYl6u7D8yWBkU5xdgnPNceP8ymUB+PjxqVjPhjKPJ0JujfCqmzE6wdLea+HZ1oHWZxSFu7//CuZl8ZHNQ/sib64o43f6JHwEkRVtg7EJ/xDCjQ2Ac1QpE3ajqv8lA0mn1w3xojBuQ7C0gdXy+pQZrccjUPTIWduqI9L1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RLo707rc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so59707481fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715597497; x=1716202297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
        b=RLo707rcr70hGgPflutR5GOra73HeeRTrd85x7QhlBxpi1zKqwjsfrFebnRQbAu94e
         jgz0jfWywMVu6hTCQ33VjIWzMo+bOP0qdydGtjVXfGNZBQv+9vy3cWa5no9LW/+GIQX6
         RtODutxRSmcaAxOHRJCP595mPdgzkoGiu2J/wasZTpdJkTmBVMGnyfLWjAEVFzq846QH
         UuL6qcPwiEy9/51TmOXYUglpA1RuMAHCZ6izhhxL+BqOwaGxIcb0Ubo9LY6QFOV0o8wu
         DhRdbNvGTNLgadPeFjMJF6ixwoWAHzZqQTPqRk7HlEKV/Pjj8y2u5N4GVEdbgfwE7jS4
         eSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597497; x=1716202297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
        b=UqKwvwys+YTFy5NOW4xVVNi9yVc13BdGvPu9Gj7RXpbdnzgdHl13Xspb/aWhuEWpxx
         GyzSwGz/D+vdvuwWIQ44g85PeC0d4slWqGStAux3C9JHfe65muJTHa91G4+paGxtY13n
         atzj1b3PYvxdkiUWhG/EsKTdBXUUM+a5xz6M6OhEnD6laRJDnb7zI/v6khwQheVeZsqy
         gxYjkXpEdoVCWzaROwZIhS/nAX/59A8CYmQCJc9+y12NXDddF3uAzHtpvD0TDu7RuUeo
         bOF4pWvOU1hLkafRIK6DfYJPqsB7/vpUIJ30HoVxSpS71zheIIM/CfqkF06DJ2/pY1Cv
         Tbxw==
X-Forwarded-Encrypted: i=1; AJvYcCUWdly0uYRP7QXAOtWDjUl7Xhj0jFKKVwD+YEOAmo+kY76ocJGc8Qc/hlPJ5t6FrPKz4Xt0/WT6jwil+PmAv/Za2VLzh9Boo9uHLvEb
X-Gm-Message-State: AOJu0YzYPRzpiNz4BlNO1BLuhgHxXev7i4wa9TsbiI/wLE2VHB3teEPk
	+neuzTesIiJowVSafw84/rsIW8ONtMWJlFaDg35SOnaLOb151V1sO5xPqlDDkDA=
X-Google-Smtp-Source: AGHT+IH5b3wM3G/QzQQQQ1D+O7yic92VzTGPaU/uwpXl/w16JmgMhK/QcRk8EE0GdFymayjqLCFQyA==
X-Received: by 2002:a2e:4602:0:b0:2e5:59c5:34e3 with SMTP id 38308e7fff4ca-2e559c535e1mr40734951fa.29.1715597496629;
        Mon, 13 May 2024 03:51:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201088fe8csm72571635e9.32.2024.05.13.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:51:35 -0700 (PDT)
Date: Mon, 13 May 2024 12:51:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	davem@davemloft.net, jan.glaza@intel.com,
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpll: fix return value check for kmemdup
Message-ID: <ZkHwtKzNN8jlKMVA@nanopsycho.orion>
References: <20240513032824.2410459-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513032824.2410459-1-nichen@iscas.ac.cn>

Mon, May 13, 2024 at 05:28:24AM CEST, nichen@iscas.ac.cn wrote:
>The return value of kmemdup() is dst->freq_supported, not
>src->freq_supported. Update the check accordingly.
>
>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

