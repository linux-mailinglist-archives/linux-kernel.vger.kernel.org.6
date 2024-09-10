Return-Path: <linux-kernel+bounces-323552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F136E973F33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90336285623
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04251A38CD;
	Tue, 10 Sep 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gb+sysyK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8D1A00DA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988632; cv=none; b=UOKKNHKKrjR5zl3wLu2JUskPmPJXXxFMGEHO3XpqxWoDCbBZsa99We79W/7orrHna6MBZ+f/XiUJBF5ygcjdlTeDk14FZKUA30LBu1GMj1/3YzvKu0U+5emWbV6uxtoMz7Vm+d/JW/sFBLpCfgxLldLZaXUIdYXHVgQ2f11JNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988632; c=relaxed/simple;
	bh=oSg1jqSi6Gk43occzaUFP7TUotm9lEyrfyUHl9PfiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMiXiD/mvnj1kjmd3uIvakS73guPQpOfF/N3T6i+Z0tvoju3MjVHzCXsWec/JGf2keXpMXwqRHEUeUwL3/aJMAtpZVm+kN9omsMyLFQS0KTj+yMXxvkttOnNV7Ue06JIYfRfyy8RIlwWaJInOfSGX/G6eSTaoBwEuh/evrId3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gb+sysyK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3731071b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725988630; x=1726593430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fn/AZ4xb9LMx66eVPn747xkrVzFL0qyHkUKyAmziAvo=;
        b=Gb+sysyKDpHqS0d2zrV25INJPQLpC/BtfGrtmcy0iV+vNQe0k/4wC5jVHOD3cZup52
         wo0XJztMqMaW0FCGJNuVcq0uSjfwXK36e8G6YStrV5oiMYskOtEyxAyAwZdAN6rg06C0
         dQi+F9kQMJE9PkuC7fnXOgMBCZaul4gNCeueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988630; x=1726593430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn/AZ4xb9LMx66eVPn747xkrVzFL0qyHkUKyAmziAvo=;
        b=D4/ga1bzeZos5KOwWI7LN6z0Mm9TxOhxcRjyDGCVjE7c+W/ORx7qHvpWkqyrmLhHzX
         G3LuUMQiqIZStKWPBBTHeyFb6/oL5sPLHN4qB1Vh5OVvIH1Mv648tCBCl3pOuhzXqqZJ
         CRNXWDK97ymzTw7QXvXirpRnyLjpxpD6H6FThCO5gBvIZn3zF+rl7mx1HsswtCBNd6HZ
         1kv50/Fqpz1IcLvfcP67NyGgqhIYBcY2Ov2SahsVinToSHM2SGSa1NeJ1q96XcCPo1g3
         P27HV53JhO4+ueGY/UUiAt76Hgeejw/U4WX9f8B3m952PfHh6b2tB3UPAEFfHRqkcVui
         gFlg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ60sM/luFRup9lPVll8PFFCcdne0xXooLDHgkXefBw9QkHwtAYDX7Jn3iSzyMysRTdjf854EpMKFz/k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTt1p4WP1i+nslCbi/sHcS9r6Zds8dZd7kgVXeCPQaw0Gi51u/
	U8EVB5Cew1FsV1RGWhrQkyLkgc9WVL5hfjXejDeh5kFPg6Ge2oqpl+RvaHs8Qw==
X-Google-Smtp-Source: AGHT+IELBBH+BVqW4jojD1yiE+U1VTuTVHaLtVLuYuv3KRyDEoVquQilq1awiMvvsKXH0tH0bFH5KA==
X-Received: by 2002:a05:6a00:2ea5:b0:717:97ac:ef46 with SMTP id d2e1a72fcca58-718e3fe638amr14703295b3a.15.1725988630104;
        Tue, 10 Sep 2024 10:17:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a9f8:b780:a61c:6acb])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7daca4d27fesm2743652a12.0.2024.09.10.10.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:17:09 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:17:07 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chunkeey@googlemail.com, kvalo@kernel.org, francesco@dolcini.it,
	krzysztof.kozlowski@linaro.org, leitao@debian.org,
	linville@tuxdriver.com, rajatja@google.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless v2 2/3] wifi: mwifiex: Use IRQF_NO_AUTOEN flag
 in request_irq()
Message-ID: <ZuB_E1XasAVw52q7@google.com>
References: <20240910124314.698896-1-ruanjinjie@huawei.com>
 <20240910124314.698896-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910124314.698896-3-ruanjinjie@huawei.com>

On Tue, Sep 10, 2024 at 08:43:13PM +0800, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Fixes: 853402a00823 ("mwifiex: Enable WoWLAN for both sdio and pcie")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add fix tag.
> - Wireless patches go to wireless-next, submit them in a separate patchset.
> ---
>  drivers/net/wireless/marvell/mwifiex/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

