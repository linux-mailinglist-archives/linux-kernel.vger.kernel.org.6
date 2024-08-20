Return-Path: <linux-kernel+bounces-294584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381F3958FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E099B2863AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA691BD512;
	Tue, 20 Aug 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STd6VV4f"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EE38FB9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189132; cv=none; b=tfRG7ee0A1MrOOQyus0zMKTPS1QwP4eDJDd0H5XgLFB2OdvVmx0JgsK6xZnVFL3rL/DDY1aBbvZd+Tza/iQAuJMuFx64qbePTrPkS3911WJbk6tHu/vht7i9IQ1+P6IF8rQ4L3/PQkfeNqlwNcQipAYou02+489TiGPL9RqQPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189132; c=relaxed/simple;
	bh=vqDj6QyJDqKu5Z6EkY7QUUx4PyOyNqgl6gzUocJ48vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfPeEpXLSwpL0OTTLQ317Ui4IisARzpwbnn1UV4MjRi5M5XtXOXC58yyznRZN3AdqFapdBPKiNLX4kGGdMWHXb1e72RQWtdlGm9vWgpRBBjaVjh9BmwCTl9vbq/XmTmi9DyAgmfjagxLYpMPxhQnxcquspfjEKAGATMpblk5+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STd6VV4f; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e16518785c2so1290846276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724189128; x=1724793928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtZ2sSwFiBCzqCGNkFlK38jZ9U/su0wXHP9hhJhttMY=;
        b=STd6VV4fT29vHx23z8eEI3cG3NSWZhIJYs6+Xc/Ys+0iF7iapwM73vn1b8Bx+zKvr3
         7CViD8eiT1aiC8aOW8E2wvHJkm09hhcSQ3/sCJjxd7aEiFhkOk5Yi5uo063NE0Vb1M1E
         PUjY43kTYmwYaKg1eBN/YwksGWcLsoS+6sMHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189128; x=1724793928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtZ2sSwFiBCzqCGNkFlK38jZ9U/su0wXHP9hhJhttMY=;
        b=jrJgU3ITTZBvrsXt0ZlIdWtOMwHxjU+XN/dovTZ0l9LnlkbP+m60gFNNSstQszHzc4
         nvr7VQyKURGAywmICFZ6mHAh/AgyXkju/a6DEN656/mmj9+NSHL6dmr/YiOJ3E1HHZKL
         v6UqdsZhjWcx6HbzL5gzi/voRDrLENKgfOPw52uaZaRNphE0uPefQeZPs3P0dTFTIh3N
         PXus1c/K+R2OunWwYVtWX7CygLjjyGAFL0TUsWnEFV46fUWf3rq2hDGzhjg3urDEokov
         QnlaBTQy4lyhJB0sNl3Adlm9xG7D8Nj2p4+ciIkv8Z9iFw6QlMl9j96k7KkicFtcKMVG
         lXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVCjtldfVVqcAUtnnB25w9lAQCxf9DIbhpSCBc2Fh3zDchfJs8d2YSEFR9udMtMsgE6DZPaxBh9/Lyk+tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyloribi9icIwGHzsL5o03E/iLo0nMSRTJblbwsRl2VjcvZoIkc
	Q7jROTa5dJgzrXHgVpa5AU4vMPeLWMDXBIU2obyTCnhmR7WhYGSHmvPYkwclE+MjrKEnPzsPwh1
	bWA==
X-Google-Smtp-Source: AGHT+IHo7wNLejykXrc3GyeEO/RIrP4hQsvA4ItFIeMwcugAyS0gzOMnSfmArwoQVqMHfbd8jY4b4A==
X-Received: by 2002:a05:6902:230e:b0:e0b:e1da:e711 with SMTP id 3f1490d57ef6-e166552fd3amr527718276.40.1724189127942;
        Tue, 20 Aug 2024 14:25:27 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e11720092ddsm2754495276.42.2024.08.20.14.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:25:25 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b5c37a3138so30523367b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCwdWaYve4bOTvklZIEu3k5b+kUJJ+6Cfq1IriXjZDAnHhLCz+NJAsm3Hzb1iiPtiGFcF1ET7icminJHQ=@vger.kernel.org
X-Received: by 2002:a05:690c:3409:b0:64a:ce78:4f7b with SMTP id
 00721157ae682-6c09cd4ef19mr5958917b3.12.1724189124246; Tue, 20 Aug 2024
 14:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818060816.848784-1-tejasvipin76@gmail.com> <20240818060816.848784-3-tejasvipin76@gmail.com>
In-Reply-To: <20240818060816.848784-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 20 Aug 2024 14:25:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V80ZfFL3Q_iqJsTW8x7hxupEqb7WjWE=gvGdOjERggSA@mail.gmail.com>
Message-ID: <CAD=FV=V80ZfFL3Q_iqJsTW8x7hxupEqb7WjWE=gvGdOjERggSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 17, 2024 at 11:08=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the jdi-fhd-r63452 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 149 ++++++-------------
>  1 file changed, 48 insertions(+), 101 deletions(-)

Pushed to drm-misc-next.

[2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions
      commit: 04b5b362bc2a36f1dfe5cad52c83b1ea9d25b87c

