Return-Path: <linux-kernel+bounces-206346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3635900832
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90071C24FBE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A219CCE3;
	Fri,  7 Jun 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7vd4E9a"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB919B5AD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772590; cv=none; b=i74VZ1t+05k4/SHpDyu3jiHAn6RucdR6DTaCHg5n2ZESQVc9032lY7cEZZQFYfAKbRNNqK0UOMsTgRpBJUXZCzzy55e7P3cEjINNbCAaag0xlhycjDCQYoIN7O8jBHuJ2dUJTSxOb6Bz3qO6Xx7HyGqhUygaaoT3jVYFdSx8rDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772590; c=relaxed/simple;
	bh=NI/ttPCPe8SGxCnWOxsUcNu5Pn+lQg28hSM5AJm89cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhN2xXAJvKgGlFm0sWV/bS221vvUst7IHPogCfpB8AZ33D04cWg4RhtdV41mniK5wtJS2LyVelERm/sYQ/epJq7EzqnOjs0kNkaUDW7prHOH5jX8m07O1Ak4FiTvJqjRVqc1j7WFEDEhYPQODqfB3TQf3/6lpRcVDn1oaI7JFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7vd4E9a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7025f4f4572so2528084b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717772588; x=1718377388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRf/oY4tHfL4Wd/KvWxDSgX2je52MyvWWq8dE0wAq3E=;
        b=F7vd4E9ayJ11BkwWt1A9rA4Xb1PMAv/K1KlhHhnUVqMcEspJQqF7G11+7jSGvBDBjS
         04Pdt8Mc2lBVseiVNiQ9MrSyBj6fZuzKwgWX8L5It2gNRN5H2lSaJHK08Yo63zi6XCwh
         kix67Abd4TPWREsPle9HS/52ta1PHszAYN0xgO50fkIu/73AWPxwksOiCh+hX7lA9SV1
         0eRk4vW3bYjk7v+7WR4zGeQBGgWf8fAxAObKbHqF8p6XJJ2Gw8VcqUCJz/yXQpPGYmZY
         ay+Zk6v3MG+TWEOyK+62JiO6YMlJTacKlGWZENFQ0e6ccD6Pr5850+Am6S0KsOdE8UDo
         h4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772588; x=1718377388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRf/oY4tHfL4Wd/KvWxDSgX2je52MyvWWq8dE0wAq3E=;
        b=o5kccfPB/lfG28zVVQsvDkIV21tF1JUitorHb6gexIu1HvMCfJ4ZZF0mDoiQZGrwF9
         0ZGa+e0cHv/VrwKHnimGoBaF36dD8nqXV6zVqVqMG1LTXeXZRjXGtWLYZ0cw9HSiPobx
         j02fFJRN4Xxc/0xtP76iNE4mNTki1kItOfoMMkqN4l5Bv0XJG5OGl2tE2gIfewyVo/pu
         nr07nwY2qw6oRjgeBmEfTs6BJiS3riptSSscOIa6RtzDUSvMdfF/GNhSKPRQR9c1vhSU
         QgB9I8ZOIo4Otu7pzSPfJ5a07FrlP6eqGMDYlbbBfWbCbKX+aXheIeYITxW0qxyP9LFS
         qGTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOVxYwCDX16jpZPoDiCYxqCKo9NoUlugvUVTm4VePUjKMJE1MUFNmyhoYJz6sDTJ8up8PFyN7SIY3lUS7lbqEAex0++Mh2sW/zwfBw
X-Gm-Message-State: AOJu0YwuUac0zGQkmseC0og7VR2/8DWyb6YgisMApU1mHZOc2jTNtYjM
	MPqsx8hVPDtHJN6qPbSyaslHKrIt7a+YDgaw74AydwexAsa4Yc5Le5CWwd79hw==
X-Google-Smtp-Source: AGHT+IFXCKFu/IlWHQySet+WNDAS0ItyhZSgv46yBbo7aKQzQitGfnGJDgfGp0VrjBaTG/BqHILrKQ==
X-Received: by 2002:a17:90a:f2cb:b0:2c2:c991:346e with SMTP id 98e67ed59e1d1-2c2c99134edmr1955488a91.18.1717772587137;
        Fri, 07 Jun 2024 08:03:07 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c494a51sm3779545a91.48.2024.06.07.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:03:06 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:03:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: walter.chang@mediatek.com
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	John Stultz <jstultz@google.com>, wsd_upstream@mediatek.com,
	stanley.chu@mediatek.com, Chun-hung.Wu@mediatek.com,
	Freddy.Hsin@mediatek.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 1/4] time/sched_clock: Export sched_clock_register()
Message-ID: <ZmMhJlQwBTAUzyP_@google.com>
References: <20230517022557.24388-1-walter.chang@mediatek.com>
 <20230517022557.24388-2-walter.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517022557.24388-2-walter.chang@mediatek.com>

On Wed, May 17, 2023 at 10:25:45AM +0800, walter.chang@mediatek.com wrote:
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> 
> clocksource driver may use sched_clock_register()
> to resigter itself as a sched_clock source.

nit: typo s/resigter/register

> Export it to support building such driver
> as module, like timer-mediatek.c
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> Signed-off-by: Walter Chang <walter.chang@mediatek.com>
> Acked-by: John Stultz <jstultz@google.com>
> ---

Reviewed-by: Carlos Llamas <cmllamas@google.com>

Thanks

