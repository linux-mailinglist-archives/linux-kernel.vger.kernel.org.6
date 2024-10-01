Return-Path: <linux-kernel+bounces-346696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE798C7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18661286357
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342051BC9F4;
	Tue,  1 Oct 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RjwDYzvF"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975219ABC3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818319; cv=none; b=mQ8zCql3DjDWPaBH4pu7l+I76+i7hVMfldclDHVP2M/5bfLdVkJK0iTpgLzwUqzZ+zAvMI/LgugnqDunI6kHFr4zASh7MEhNhTZIr+qYLBsd5CcvK/k8Kftf77jeq7bU6urvL6QP8R+4amiIF0qo6cAjNSZXD3wPlJA2oZEeaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818319; c=relaxed/simple;
	bh=huE5F11SL3j439iMNF11h21eBBNNsMoJjJYyn+S72sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaXNkTQcvSjSfafdoTJkpqFHOvVCWNlvPNhV1Be+ft7osrtwHHfZLXYNOotNi3ayhbPw4DC3rWPkhKiOXiwDbswfaG7NtFuvb9ByLbQquTBbu85HfPz4UWAwd2kQf0MTUPVcR7Lkn3hByFl6O3ENjnTCuJYefA1IpwheRbpdTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RjwDYzvF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso31212781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727818315; x=1728423115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oeKUFf/wvhOU5GpriVxkpEr3FfSq8JD4qSx8kz40jA=;
        b=RjwDYzvF4eLDR5OSUgucjrK9sMgV6iuxuEg09jwcpypDtv0jUHPvrZ+/2QjZy/lVVD
         OzPSZyHfHtezmLAHaivbxBl6pa781MKfMXLl1ex38GonEau4TgEPRDo9MvbamvJ3/xg4
         yQNkBWXZD8Jlu+PGsvgPCH4rjWY2I9LCyDbPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727818315; x=1728423115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oeKUFf/wvhOU5GpriVxkpEr3FfSq8JD4qSx8kz40jA=;
        b=HL8YzdrediXLM+XTIOt3cfdkh3HeCLkLUvymyc1E7eQ13wL75duLGfmHm70ZwJoS24
         amt+J/XcwilBxxFCVYDN7nPUIkHl/7dxPP3R5eeh2INJ4sBUkaXNhq4uDRzHNWOexkVK
         mQ0G8trmI8AcDL0JolfS0IK9ckDp54t/OyFbsqPZQLaSZvsOGuVs7Wp5zLxKh0/K/blL
         xHqRaBtyz+G6mqfD/bN3TxpPPOm3r8WLwZCvklgIYIu79S+8dlDNyURtGJEi82h6aOjk
         roKcsM7V4mCHp8wfgelbjTLBaGy4CE4mxlFQIvEF7rn2XnSs+ZbgsJIzZxbCOp0jOUuK
         EnUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3rq1o1PkJDowKsvUHWGsZYIuajQiq87DzXl9aL3gOrhiO1GL4uaBNG4TlLuZPag8+Hdr8arrIUjGkpFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7d4pcOAWwiW0VxsDVPcCbQ76CsvOco/sI7pHv/nTDTJE4RBg/
	fdEZyRGUl7hCPb/20bpWf7SMTt2OM49J7Enda4PHwojxpRu8mD5coLgaSX2uUplQJWAogj47rqe
	R9Q==
X-Google-Smtp-Source: AGHT+IHHphgxLu9YB+n64wv6rPAwNDQJEpbQmS7a5bmeshXEK23Urm0oBWVnWzXKuBtMLf+YUeV9KA==
X-Received: by 2002:a05:6512:2210:b0:533:4820:275a with SMTP id 2adb3069b0e04-539a07a6574mr488913e87.52.1727818314579;
        Tue, 01 Oct 2024 14:31:54 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04399a7sm1738264e87.195.2024.10.01.14.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 14:31:54 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facf48166bso28968771fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:31:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/ghHfyPpVESdYdUEn+B+kCiELc+LmVGbdfpqAa4/tQLBd8OFgH1ZDU6+8kCDRZvTrSuVsZUe4xj9E7q0=@vger.kernel.org
X-Received: by 2002:a2e:b8c6:0:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2fae1029a26mr7884751fa.22.1727818312721; Tue, 01 Oct 2024
 14:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925080003.1250448-1-tejasvipin76@gmail.com>
In-Reply-To: <20240925080003.1250448-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 1 Oct 2024 14:31:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XorfckX5US7y1vwCuSYjd+8VbOT_rcHVOot=zv4LOP+g@mail.gmail.com>
Message-ID: <CAD=FV=XorfckX5US7y1vwCuSYjd+8VbOT_rcHVOot=zv4LOP+g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, Sep 25, 2024 at 1:00=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the elida-kd35t133 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Added back bytes that were removed
>     - Replaced mipi_dsi_dcs_write_buffer_multi with mipi_dsi_dcs_write_se=
q_multi
>
> Changes in v2:
>     - Changed mipi_dsi_dcs_write to mipi_dsi_dcs_write_buffer_multi
>     - Cleaned up error handling
>
> Link to v2: https://lore.kernel.org/all/20240923122558.728516-1-tejasvipi=
n76@gmail.com/
> Link to v1: https://lore.kernel.org/all/20240917071710.1254520-1-tejasvip=
in76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 108 ++++++++-----------
>  1 file changed, 45 insertions(+), 63 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel: elida-kd35t133: transition to mipi_dsi wrapped functions
      commit: a7b3bcc8e8495ff45128caab7ceee2534d1b8e8d

-Doug

