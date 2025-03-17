Return-Path: <linux-kernel+bounces-564378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E436A653C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD231888DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC0243364;
	Mon, 17 Mar 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ck7q2SFl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4B227BB2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222264; cv=none; b=fT/rqAFVgYrCZJ/ZC/yzbjp4NI69442iSAz8DXRlD99jubEWmVyYsGxHqxDgg5FdjPsb/YbG43jhuxnSNdlkSIJPZ0HCsPoATPsvs+mhbDrk2qOYqNXb5YMmaZ7pdyRIIaPcNQ84eiRT29+FRJyXpNK3GtBaEc+5/ydLzP4wRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222264; c=relaxed/simple;
	bh=4BhL2Yaks2q5eYLwQGsQ9FtBVskiaGmEN11DByoOu+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSlS2/qKiydcbO4J4OgJ1G3G51YLvumV2Wc9JIwy0QSeFh3FT84pZLbd/6YM14OXCeplKETjrfBAmOBxDum53q1KCX3S6+02iLO3tWF3mYHdhLn4pSrqtUcwiEe5d9vJPVzcfIsAfk5CGMK7EpU+J2UOZLdY82kwTgpCfXPZLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ck7q2SFl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so38561005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742222261; x=1742827061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BhL2Yaks2q5eYLwQGsQ9FtBVskiaGmEN11DByoOu+E=;
        b=ck7q2SFlzZKhH72tipLkB131Ac+CWFV3xAnhP6x18aaITVxRA/64XSkiVMnrKsQNv2
         t5ukTltRESTVb1R1CfYYxaKBlemXfUWrmMP3RaKZ2A3FZ0QtVYiS7JkKllwbpdEG5BYv
         BA/HXoB8zp5QSAgsv00LlGJgkLTAi+0sAR1a1j9yvqNlg+bz5DOxoRhwq4T8Afs3zi1Y
         vyiHE5No+jQgbUbnljKWGl1ILhRgkcovD6DjCDBjeoiBmVIAOFRc00bh63j7uLLs0FhD
         QMOFcSBS9N7ALH8Qr4QMC7sZJoorwk3s/7Ep8jh+eKSe3xbhRTQYc3nL16tTtbQNH/Z1
         Gt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222261; x=1742827061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BhL2Yaks2q5eYLwQGsQ9FtBVskiaGmEN11DByoOu+E=;
        b=gXig+xR06ELmH1aPlSO0sQhcCXgGusen7rH4YC540de7jfogDoOmxmSHiQKOnZJfZ1
         C38wcfQqmaED6TEZRIpTRUzp2zdzcxrgVPXvXlzm+pME67bylju2IMNtkHtZh8vMJa4p
         FgUCw8DHZweiTN/xBlx8uzFsPIVaamBf9YsGwtjcDDRMeKLJHro7gwUi7BTTDd/vmX6V
         YicquNeFq/XJrDUVHc156JW0uS9Kqjy61ccX7FZDd9qfAQ0tO+pIoSMYcVTFGzoCJcVU
         8yiddqggyIbjLYtLuLLNJQ2TmJfB5cIfMfe5lq/GRV5hl4ggYcz8W6G/TXIKIdUKOOes
         JXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVA3yJ0m0GHROggInMu0XSfLX4z3FFbyAhpgwaP+q/39rEVSbaeDjmqzGIL56KbSbNvtyEKfHp4n4JMSa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm5pM/fXpSLLuk/Iuy9S6WDSJnBZgGeS3laOsYlqznW5ty8rq
	nmdWAwZuG9LyJ5FDcK8Q20heErOoIjEIJeQMY41ic/DphyEFA3gU+k6LdUkRr4jK7wdTKZoxFOC
	Ai4Dr69zQTyxJ9duC/dudbJSYHXOk8b2nPKXMjQ==
X-Gm-Gg: ASbGncsjdkyPbySi3XipqCOrJKnZJvzRWICvgVf4jESe4TLrWvT2khlZXXeGvh8MQNO
	c548aCEWsOFp/zcrGMY7VJ/WluPZLVwCJVWCEPGHqtTTOWfTK8ViPzAmkfE0rzvyADMNTZscGlo
	NJLBs42LZKKZJoB0/4zCdNyY113JjxQkr1KaPpn2PWdCTTdK3yZyBQGnRGxHVnr+rHLXUr
X-Google-Smtp-Source: AGHT+IGbXl28itf7kvvrqy540KzfJLaX7CDKqwGYMcvVjxyK45BPZ4IUPj0mY8ZSR8GW/D32D7pW6DWKUA8JlPuFlUs=
X-Received: by 2002:a05:6a00:2309:b0:736:4b08:cc0e with SMTP id
 d2e1a72fcca58-737223ccf1dmr15014447b3a.17.1742222261342; Mon, 17 Mar 2025
 07:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
 <20250312-vc4_hotplug-v3-1-d75878677de8@raspberrypi.com> <20250314-armored-tourmaline-lizard-cee8d8@houat>
In-Reply-To: <20250314-armored-tourmaline-lizard-cee8d8@houat>
From: David Turner <david.turner@raspberrypi.com>
Date: Mon, 17 Mar 2025 14:37:03 +0000
X-Gm-Features: AQ5f1Jpk2qj6wLi6ea6sCKp_tWqRzPOuJWPTh71dRl9BYdVEBR9Y7uhNYp72rwI
Message-ID: <CACXvZi-3mkusGHkZTz=kDo8WcNQZR1A3bddajh+CFT6tQxJSCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/vc4: hdmi: Call HDMI hotplug helper on disconnect
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"

Hi Maxime,

Thanks for the reviews.

On Fri, 14 Mar 2025 at 13:33, Maxime Ripard <mripard@kernel.org> wrote:
> I also think that it's wrong, it's not just about audio. It just needs
> to be called as part of detect no matter what the status is. Audio is
> one thing that it will possibly handle depending on the driver, but
> EDIDs, CEC, etc. might also be dealt with. So I don't think it's right
> to focus on audio there.

Does this wording sound ok?

 * This function should be called as a part of the .detect() / .detect_ctx()
 * callbacks for all status changes in order to update the HDMI-specific
 * connector's data.

Best regards,
David

