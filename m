Return-Path: <linux-kernel+bounces-285325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C495950C18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC981C228F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210571A0723;
	Tue, 13 Aug 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNPzN4SE"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404DA3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573078; cv=none; b=O9H1JQQ23y7gcpIQfOW4BxQ1qs329KlvXB5ZDZOkZTmw4Ail11hXv4budLbWhBua0aR3sixK+t75EWM+VVX8u1hGqAEExik0tGXcQXQnMW7SiLVb5iisSG1Qqda3F/bsP5L+vFUwIyISE0imYKnmhVmTwA2QxWA+OuSZ1rOI/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573078; c=relaxed/simple;
	bh=WKUTlCWFoFRq36aNonRuBplmkb3MdWCxlyAbITLbGqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzWDabjxZowHlNxmWhgtPIIfUBu0wTRmV/7z05YIqqhqD0cdOdbB9rDJrojquue36Sdl96Nim3FS/MNNFe3M517nOneKsw5Ka5WafFdgwbqez9sm9Z3AbZCNERwBcy8C/3XFMzRlFGOdvt/ekYDy2WQ7VhP1C81mjdoP6hFF3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CNPzN4SE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-495d1a6db75so1678540137.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723573074; x=1724177874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imsr1IM3T+HpLuQNUoryQ7eKcRg7fznV3Mgf+zxJJ6s=;
        b=CNPzN4SEnHOKFV3+YMxGVtdZ+vm7KiMinBeHdYPdccluRHkR+HPOZzZ+le1R9rnviX
         1nSgYkgc2nYC+fx2vllT4PtnGQy8FyWDGG8DnJBEHTWAuDt3gWs1gFzOhu8QJzK9PFlD
         HZ9UHDRCAv1H9F+/aPBflnrgSrv7HMT41M1Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573074; x=1724177874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imsr1IM3T+HpLuQNUoryQ7eKcRg7fznV3Mgf+zxJJ6s=;
        b=Ltl8t32X53RwlIwMKTqV7uyHWFCM2lVGpo2YR7Pg8jy0Cv7IvV9RONH17fj4G72MPU
         lKNm+2UyVyUR5QGh2/VR0fM/xMtXG5zS/YW0gJN/uY+u1nvV1H0IsRsuzKrcE7fsL8AO
         4szVKlGoFc9rjdphrZg6Zj6/P0BWLGLP3GH6fy63cD5YU5VwdtIEaalMu7GXYHZI8MdD
         iOF9AbWJag33KFHzhnXQ9zSWZrI4jnHSL1jvLNHxdBeM4az6JxvhyJX3m+rGOzMzEF1X
         TG16EdMgClT9Gahg0Z2mzykY2etAJ76fcmyxnXGT53SukCo3t7pyuE/qPsj5DSxlDK92
         nnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz5Tbjd33jzZYvDVBM46vwj7w/rTJ1F8CZ3NpaTZ/AG1Bk9EqPzE6/Ixyb/fm6DreEB7b16geyp+WX0lmtYtv/yCdEkowyGsj5H1ht
X-Gm-Message-State: AOJu0YyGLNUyL9n1SpWV8qYPXmZOUF1C7yiTzUzI5GQqkjxlwVmL2bmn
	eYYCBp46Biqfvz3QB8eT0D7keWyAJSWgSiAsIeiFh68N4PQX4zvGmPnOaKZIX/ISVwoNp6rqT4M
	=
X-Google-Smtp-Source: AGHT+IESkWDNLZDRgI4LsEWj0ey4pflqUURlRnqvOBOxqABTMCbA9Pzp8x/q4wWPHwK2yq6njDsXZw==
X-Received: by 2002:a05:6102:c91:b0:48f:a858:2b52 with SMTP id ada2fe7eead31-497599d3852mr632857137.29.1723573074321;
        Tue, 13 Aug 2024 11:17:54 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49709fa3169sm1197798137.24.2024.08.13.11.17.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:17:52 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-81ff08e24f8so1879287241.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:17:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRSzpookPEx+SXgGaJqbM2oLQCkfAPYAyI9aXKiv2Rya98J+QVU7HJUZp/Us6QAOUn89JP5j87gG76Sv9dj4Q2AUyTDPySZvz3iXDm
X-Received: by 2002:a05:6102:3048:b0:48f:e802:4b26 with SMTP id
 ada2fe7eead31-49759944e85mr582438137.18.1723573071902; Tue, 13 Aug 2024
 11:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813062912.467280-1-tejasvipin76@gmail.com> <20240813062912.467280-3-tejasvipin76@gmail.com>
In-Reply-To: <20240813062912.467280-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 11:17:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UtZdh4hMqT7ATtQ+g=jGV568sCnFgJzFLVDRj2qAkVcQ@mail.gmail.com>
Message-ID: <CAD=FV=UtZdh4hMqT7ATtQ+g=jGV568sCnFgJzFLVDRj2qAkVcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 12, 2024 at 11:31=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the jdi-fhd-r63452 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 150 ++++++-------------
>  1 file changed, 49 insertions(+), 101 deletions(-)

Looks nice to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...as per usual, I'll give this a snooze for a week or so and plan to
apply it if nothing comes up.

