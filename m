Return-Path: <linux-kernel+bounces-442137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4C9ED87A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F51888081
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AACE1F0E55;
	Wed, 11 Dec 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NrQKah9/"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD01EC4C4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952120; cv=none; b=BKLBnahpcSTvk9oAkShZX19RZdAcon4h3+tw39XmnlvwnSqsBEWYcalXGPDM2JjzrTMZT0THRUdSYOg635qmyP37DSMMLLI8hmi4C7AZNFV/Tzk0DR0Q4/Sk1EdkNzrEqE4sFhyXyTmgOpM3kIMtB4lpU+s7eFYdKQnY/hC9lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952120; c=relaxed/simple;
	bh=n0KCyGqSL5oapRSBhlfukCbAuOyAuMPivoVisArJl+M=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUZudF86ekBbsCK7kLRdV6hjCoxnpX1HQJ8Tf/x76HDGtkG9nrgWTV/Hq2SDPvFEEZLBaON7rYvuvoVLrLyl8eOVqXfKepzI/+eHY4BI5LTSn/RMS33072Ll9ZS9Vk8IvZ3NfxUmTNRLVhrd0hP1TDxUxVQfLqACx6SDJFjEV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NrQKah9/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef4b6719d1so59735117b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733952117; x=1734556917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0KCyGqSL5oapRSBhlfukCbAuOyAuMPivoVisArJl+M=;
        b=NrQKah9/GtAbLk+n5naUtjdmTSXP5ciHHBxWB3bwlMO5fbiDJNXe0y7IQAIr1kYopx
         FcXU2UH41S+qnx13K+ygG5ITJ5YsX332Yh8kqf90EtdduGvgm8/gtQtLxojfsK5w059w
         +yZ3SL98Ac34K4Whtv8TWDrluiH6qeiRFww/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952117; x=1734556917;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0KCyGqSL5oapRSBhlfukCbAuOyAuMPivoVisArJl+M=;
        b=GfwcOLRnciKopQnaWtLRDIo1gY4y4yzH7gDqfe8E4ahvHF1Aww6/4YNwaSJ9WXAxaF
         nx4um5g6Y1GIBvRi4+ISECKaBfRM0GgXrTdj9vHjXe38uiahQUqkjsCuycDwOhEWaWTE
         k2gLkFjkmz2RjHm/uY3m+ZokixdsZBet3gBIJfxY5Ok8rEozTiaWyjW4B+IdceMtNpzn
         6fksLjLBxCiclL3wq7GzES6/vlAUNQasrKbgpStOKdww0E8cesjIHTahTbJKsSg242Vs
         ZO+jkWXiEjNzEps8KW+1LLnrFfvfzGiIoaWVnUbS+vTyBSpMrNtWzUNVHJp9jq+dOyUI
         wp7A==
X-Forwarded-Encrypted: i=1; AJvYcCVm6m22xC+zOoigC8vM12Zds1U/8bwde9qHvn0L+H0dAObg0kkJmU8iUEOJiJdg1/gHmTwjzXeJkCmyJMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIC0tDHI6xdTHIJk3svAZQLLN1vEH2S+5Fpu9Y6de4Dvfxg0t
	Hnt2lvIHk67x19F+PudM4340mbcVIEisdeWoMyOET6tyDAWWhahsojPXiE8s8yBs1IIeGU435FA
	kz6v0eT0Xg7k7JxmCb90uErhVSQgC71IbXMPFhyjx93T+QRw=
X-Gm-Gg: ASbGncuopDVEr4zJm8/YDCX7LrZKZjdArFwy1plmiRK84EzQvVaKyxmJjyiTr08uT1D
	LjZhdN5swBATv1Pu6NC660hRffdcVt9LH84gtyKPS5/ttnN1BkiaDgPLpNh3FDm4=
X-Google-Smtp-Source: AGHT+IEOpRCkZGb0mjL6N5K1OyWZ7lwzUq/9xZP89m+PnB//8BwUpGSf7eNg+mNPOjGTasCVPWXdK3o+/j/FVah3RXc=
X-Received: by 2002:a05:690c:ecc:b0:6ea:7afd:d901 with SMTP id
 00721157ae682-6f19e4fe961mr11687997b3.18.1733952117669; Wed, 11 Dec 2024
 13:21:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:21:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAA8EJppVgw1Qb4kGY1Y-A3-KrinKfX2zGUuwMCY_-gG96fgocA@mail.gmail.com>
References: <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
 <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com>
 <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
 <CAE-0n50Bxi2GfnxOmMwe-F+k5jMSiyAVPDb6K8pYm-i6hpJTOA@mail.gmail.com>
 <cartdeijkv6z23dgm7uif4lti3lahfqmuyxcmruzqbefhsp6yk@m6ocjhncs2ko>
 <CAE-0n51-QLLje0f7T4p3xK6Q-FRk4K0NUrVVm4cxkKoevuzktw@mail.gmail.com>
 <kidsjzklpxvvamct3glvoawavoi5mjuyh3on5kbtfp6gavwxxn@eack224zuqa3>
 <CAE-0n52F+cvVyXm8g8idN2eMfx4bpaEpWQRchr8=AO87N7E3fg@mail.gmail.com> <CAA8EJppVgw1Qb4kGY1Y-A3-KrinKfX2zGUuwMCY_-gG96fgocA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:21:56 -0800
Message-ID: <CAE-0n50D40VWOsgnNqKzJR=GG44SKcps5mZb-HM=aix7XYn2hg@mail.gmail.com>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-11 13:16:56)
> On Wed, 11 Dec 2024 at 23:11, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > It is pure DP. Maybe we can have a google,cros-ec-usbc-hdmi compatible
> > string here because this is a weird design.
>
> Just google,cros-ec-hdmi for the corresponding connector?
>

Sure.

