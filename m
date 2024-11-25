Return-Path: <linux-kernel+bounces-420928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE39D847B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AC7B44976
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1B1A01BE;
	Mon, 25 Nov 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNk7wmox"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FD19D8B2;
	Mon, 25 Nov 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534111; cv=none; b=h9TNrDwHOvV1rWl0/DJ2mIt96vsZDg7/Dqu5mVobNnAE34dZm3rYOqrKXDw32FeJaLQhCRxPKrfvgeXN3IP3xH2qdIpyCHW4MBnn/96rXItizcD2mbQDt+r7LAhD3ZKXMIlkWVGCum445wrfzQ6z+FvQfgNWWvEVWvZdnV8mFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534111; c=relaxed/simple;
	bh=W07z30b8rfRq3CgjyuyiqZnTwm7THv2X4yGm/T/qTMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOS8frMqbnz2tampPCpA0/d+oUFrk5IFs+P+MPzMI3jDBn8BEDv/nzViS1V2LplYTzICVPeTggGDsoPs2gBvdWx9aSBkbjDs7dXd4lMULKspik0XC/8BRAE0Qqkpg0daeLLIxNVVENqxUSwx5Kmo8OKwEJ9fF9Cpo/k4A8nszP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNk7wmox; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3873c7c9b4so4694272276.3;
        Mon, 25 Nov 2024 03:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732534109; x=1733138909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SFECZUVYn+5chgSQNbqMPjSGONkR4VwEA2mP4hQOs0U=;
        b=dNk7wmoxdqDkNV0W0ifJ7doXL1e8dllVbdd9A2WBkxBjpqr4P/qa2JHZGfyMviYzPr
         sZc46SCL9s2irUGtpcJc4Wh25AzikopBtUz/eZXfD27Nvksvs+peHYtjVzvd/xbV3nHh
         gj7VJWeOtufODls8PgPlNogfqKn1u3dc2PN8Y2vsA4HrzhpZWs1CYbR0uQ/j+y+oB1WQ
         4c8LolhlJC/zBQzZ2lC3rKDzXk0+FYAAT2h6lB5vojpLUGrmryd+vhwtcxLwuIyHjFuB
         YnXEKnHVYpk4zBWDeGmM7xw879ywQxk8znOv97a75CMlqec3MZ+2aLoK06GFmEMtBHCa
         8VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534109; x=1733138909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFECZUVYn+5chgSQNbqMPjSGONkR4VwEA2mP4hQOs0U=;
        b=xJpfRRmolpy7c979i36U5yM9Cet1OVY0DsA8KbVqb2gqYQ9zBr/6xdE4bpelez1rlC
         jLjHCP5CNun1g8ePS+5KyZBJMz4IFzrbK6aDgKfsqSwJu/M4sPzTKwqGPR19+DMJ2UjF
         LGIR/+4XL2hqSnYfrcSg+ssYOec3B4LwbdSgwAvedyvDva/DuGltnap4I6n6qwnqWu+L
         3jmH1xFuUp5o4/POmHXsP561uCKAtwJgJKZVjp9PjluwV5WGvcmwck5CMhmxl+jNuDQ4
         Ebv5bx08mtjBMzgqSI6ANVhPXydDrPREetl93y3CiHd4d/saOvXEM0uCHlj4QQT7jx1O
         1ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCUpwatpjvj9ZkTsqbaLwcPSFZDB/QcP+xK3ctZ2XodWlO8+tyVb8QqgM0iAr8QLFs1uanxuwjhv+wQn52y1@vger.kernel.org, AJvYcCXxWax0b+wTeFzst8gAu/xOueXofsd7rCwa9lvHImkdgctsfrXSv78gVbAYhsl9qtEGsNA0sg2VPVDn@vger.kernel.org
X-Gm-Message-State: AOJu0YzeY81sW77OH1IYiRORwNdI5TifnquYcbB+SWmN+Ht//AQKenOs
	LxzAALSeHb/amtOOSTFRY6RkCYcjX4eZwVpmfEs+J0h8I2/4zqQFklHWF4Vxn4+QOhKN5AMK1ab
	no8i3nxL4WEfIv+fvtHowY9SsvW8=
X-Gm-Gg: ASbGncvvAS5R2yjcUuvG82LLROOEZZ/hw3Lh+vsndZ/ippM3pLFlhygQ/GXzYLWM2xc
	nNU7l49UEGCbiPSAKybqURov8yy+TBCzU
X-Google-Smtp-Source: AGHT+IEvMXbz/ATLbtPNpdoZq7utk3jT6G8l9B0pfvfJrNTPtha9rgk1sBFORpJxaDQfmVMujvdo14mu83hAF3M4v5c=
X-Received: by 2002:a05:6902:1503:b0:e38:a34f:ff91 with SMTP id
 3f1490d57ef6-e38f8ad814dmr9422644276.6.1732534109466; Mon, 25 Nov 2024
 03:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com> <20241124-adpdrm-v1-3-3191d8e6e49a@gmail.com>
 <3bac31fc-57aa-4234-b10b-d48d3bbfa344@linaro.org>
In-Reply-To: <3bac31fc-57aa-4234-b10b-d48d3bbfa344@linaro.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 25 Nov 2024 12:28:18 +0100
Message-ID: <CAMT+MTSDWK1dwgMHbNxAHab5_45xDn7YTfZDUdUL5Zjx++X4kw@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpu: drm: adp: Add a backlight driver for the Summit LCD
To: neil.armstrong@linaro.org
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Chan <towinchenmi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 09:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > +static int summit_suspend(struct device *dev)
> > +{
> > +     struct summit_data *panel = dev_get_drvdata(dev);
> > +
> > +     int err = mipi_dsi_dcs_set_display_brightness(panel->dsi, 0);
> > +
> > +     if (err < 0)
> > +             return err;
> > +     return 0;
>
> Just return err here, add a common function to set a brighness value and
> avoid duplicate code like here.

I felt that mipi_dsi_dcs_set_display_brightness is common enough, is it not?
Ack on all other changes, will be done for v2.

