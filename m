Return-Path: <linux-kernel+bounces-245016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509592AD09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965B9B21EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE72594;
	Tue,  9 Jul 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jTi6hdUf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B1EA4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484463; cv=none; b=nTACDb976VqBTVrx3uLUhUwz2G3OaDTn0vHrAGjIg9vdB4/WaW2Vp3UYEX9jPzrkwqX2x063fvY6NmtY/cNUIbbUorIAo+SLpzTJRiAUY8NVP4gagirKsMYo8cnFDxy1YXLrBdfHaHXLladjhkaLnoirQVDGqe7wuN8LWNLNORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484463; c=relaxed/simple;
	bh=JPryGkeVnQXZKoT8E8gFpCO6dUz1mD9ov58PKxpQgSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGGOoELy5MDL/1EUuu+tSVMC1Kh4W1lw3QIQx/vFOO4EYepmJZ2CepSEWHR1dbVcbJ6GHFIOlRD55RM404j31DfN+leiGFFJy1ysl8IUvlCmBKKfwT3nM5FWoksmgxzfe1bW/QEe4NPRNns9fI7ectwCc/ZnNTF7V/LS9GOuYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jTi6hdUf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79efb4a46b6so188956685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720484457; x=1721089257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKGxru8jlEhy9VDpu0M8oQtUNp25i0UIEibzxizl6pU=;
        b=jTi6hdUfqVwWpPGsAKAqfL8ZKCUHq+ySpYd5cZIf0f0YrDXyc3l6rLtRp90oRcc3QC
         ARcJwZJgWsItkhdGCyoMT0cNhHLtF9uCG6FJR3nKAQXqAhLCvE5BKhM9IdrndpFDRMA+
         Ral1NCMM7djdQuAvHgb/KwGC+BHD9iUNrkoDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484457; x=1721089257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKGxru8jlEhy9VDpu0M8oQtUNp25i0UIEibzxizl6pU=;
        b=R91fxNc1XOQZn1jO2ySbrtXXavTHZayPfb063QMTivuf+DO3UKgkArFV1Co91GdIRY
         ZgqdMav2UDoXAidrXIv2Q7XVQkJRZ8stMflzzrG+M5TxB21zTriWhv5s7CqZIJwCYGSD
         RdIw5q7tuqFwva+TpZiUGnAfoHv0qaMKcokZSCVK7M47fUxPZ89Dy19TSe89oVyWV1FB
         v0zQ+6x0awczmWcqquUiRk58DSdfnMY08Fa58D53OtDa95zdi617ScqOdndym/7c/pls
         otsSpowKCQUjDo7mbGabXEFpL79jC6277jFohdh4Yb2K48F6u94TXnFwaG8y7HR22ziM
         D+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHqRorlr8T6AjluhnwdEsp1DnzHxD26RHCayZANOMxSwFF05r4za3kO5FiQh95oiJZlTMK8cd1yOL4kXtEW/o4tZtOahU3Wxo75Ac
X-Gm-Message-State: AOJu0YwNvjmPpYtLQ7MILLxAOVq/gvr5ZDfsEyhRuyhP8ee2jKjsIi2i
	Fdany52IkXunDxKKicxOjKQYn/Ahu12YheEYEspVI1o03pcMkB2Glh5+HJqlLeCVbYMIEJP/OcR
	y7YZ3
X-Google-Smtp-Source: AGHT+IEuLjxZ1dII0DOZGpI1fm2FQ6fnD25n6UaG6Y5k1Zt+AWSLaZo5QDCEgJBXPmWWAWphleT+wA==
X-Received: by 2002:a05:620a:14b6:b0:79f:1873:5463 with SMTP id af79cd13be357-79f19a0fd43mr116888185a.6.1720484457434;
        Mon, 08 Jul 2024 17:20:57 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190890e4sm41734985a.95.2024.07.08.17.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 17:20:56 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447f8aa87bfso176581cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:20:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUP1cO7Wpuec4z/639EHHlUMb9piieS67DpZidVSt+e4o5pAd3NreCfr9nmujTbmxhOQ91rEkGh/CXUeCJx0UznLaBF6fSeVlVBrpoC
X-Received: by 2002:ac8:6b85:0:b0:447:e393:fed1 with SMTP id
 d75a77b69052e-447fd03dedemr883021cf.7.1720484455811; Mon, 08 Jul 2024
 17:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628182428.171031-1-tejasvipin76@gmail.com> <20240628182428.171031-2-tejasvipin76@gmail.com>
In-Reply-To: <20240628182428.171031-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 17:20:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKiEjDfeK8pCqAk8+YWBD2U4ESLik8kiDbvgrZz7o1NA@mail.gmail.com>
Message-ID: <CAD=FV=VKiEjDfeK8pCqAk8+YWBD2U4ESLik8kiDbvgrZz7o1NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, LinusW <linus.walleij@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 28, 2024 at 11:25=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> +/**
> + * mipi_dsi_dcs_set_page_address_multi() - define the column extent of t=
he
> + *     frame memory accessed by the host processor
> + * @ctx: Context for multiple DSI transactions
> + * @start: first column of frame memory
> + * @end: last column of frame memory

nit: "start" and "end" comments should say "first page" and "last
page", not "first column" and "last column". The previous function was
the one about columns.

> + *
> + * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way t=
hat
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *=
ctx,
> +                                          u16 start, u16 end)

nit: indentation of the above line isn't _quite_ right.


Other than the two nits, this looks fine to me, but I'd prefer if
someone else provides an "Ack" in addition to me that they're OK
adding these extra "multi" functions. Both Dmitry and Linus W were
involved in the original "multi" functions, so maybe they'd be willing
to offer their opinions?

