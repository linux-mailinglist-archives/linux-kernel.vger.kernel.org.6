Return-Path: <linux-kernel+bounces-249576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B892ED7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08573286BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC416D4FC;
	Thu, 11 Jul 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JTAGb/1u"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A5262BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717832; cv=none; b=V6R/wO5l2D2nKQDR+zPElj7vJ9vI4aVN8dmph1/wGRotB6PchTZMepVEtCKIolezwfbuzl683Nlf/U+4bmUezFrnz67ObLkY4KO25S1b90ooi/icsElpyLPfWNjp1oXXKATedFPerXw2/hIPdUuaA7m5ZZJHMtQ3Wfi1sjKa06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717832; c=relaxed/simple;
	bh=s6j7xeqBtWGlM1klvt8ONdlDq3uD3/K/kIeCRet83fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1UMZZa1iEwPTEMoJV1ubkQAL2oGnYZ8iJ5JupmCB4jJ8YED5Z9lo1lnV8YjWOOdt7dFtOYB8kSVgXZOGhSX+8DnZoUdbUIGgwXhmZLWAUXaTbieciEVqrdeHyVhcIRVIihGO58XhhSec0tXfjXSgkSaF98f13v1TTZz9Xi7Ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JTAGb/1u; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f2f5891cso5953201cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720717828; x=1721322628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMrodmUyUKlhvfzT8TSP1NFfD9HljVlU57hBQAsrNU8=;
        b=JTAGb/1uUXjHVDJHJgQub1nupNkta+HetcpFQKpQfKqgS/+A07VgaQPKNolA1TWv3u
         T1v6/3mss0QvC4VGeAD0H7vqu93a/yvkxnjJLDHLX3snCa9eG1uwj34Q+CzhzoT/n/p8
         yDhr3VnVVWicKuPwYknofg7JCipzDtx7goZZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717828; x=1721322628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMrodmUyUKlhvfzT8TSP1NFfD9HljVlU57hBQAsrNU8=;
        b=j5cLJUdnt7HUvHBA1kWYsyekAQXK1Sn3gnuMWkdgSbwOnzX3/Vb/NS+1B/VtRrTURb
         GI4Fyer0bYrt/pg1GT9RpWKuW7UCTiJdfISxMM2no/6z9acdR5dl9uQbTJNRkjkX9cFx
         tkv34lhU4t3kbtS853nUycIUa8dDx5VE5TRgNSliFaViGPgYUE7sT4vfulIXISFhJr9k
         3iFtUFUj2ywRIBSmYCjmIPk45pXfHS8Q2Z2wEwdCGOBRhlUog91MAFid+DKkGPaEp1lW
         rZvNJI3yp+w6ahTkAh/iaVDNbt3xUOflBFRgYm1RMMvoK+7Vfn6HS2Q5/Z77jWV3OVtl
         zIeA==
X-Forwarded-Encrypted: i=1; AJvYcCV6MkcYJhJ9kN6I2rP0Vvm/suRTViYz7ID0p2CAX0K9F7oTAzlcOMka5Mcv17GuYZsuvJ92wuco6Dp43dva0GUPqpNBmuYlr7jqzTV5
X-Gm-Message-State: AOJu0Yy4v3d695kP/wP2SyjLaCUI6uDe45qqHePFh/Ga9QHVZ2fshjuS
	I6yCcVEICNar3h+fgsPhyqaRckgl05Sy8jdgdLJSYKHMgvIQaQWUEwy7kUuyviur+trPT3jH+Sk
	=
X-Google-Smtp-Source: AGHT+IEqpDCXQLFw1LDILgBK2DhtmDHu4vTZ4xYJkVPqxYkyGWJOwK4OzPX4XIZOe/THivgP49d4og==
X-Received: by 2002:a05:622a:3c7:b0:447:f285:9262 with SMTP id d75a77b69052e-447fa908ba8mr105048151cf.42.1720717828591;
        Thu, 11 Jul 2024 10:10:28 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26badsm31878941cf.17.2024.07.11.10.10.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 10:10:27 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447f8aa87bfso9341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:10:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzV0g2hXqV0Z+st2QXiFmPZFE7XtyrKau7qM5Nr648YhkEOpmR/pHD666pTnuSCbgnVW+HmJMEWfrSzjULRlhfoxhH3MaAq1f+JTML
X-Received: by 2002:ac8:4a15:0:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-44d35468174mr3719571cf.15.1720717827112; Thu, 11 Jul 2024
 10:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710190235.1095156-1-hsinyi@chromium.org>
In-Reply-To: <20240710190235.1095156-1-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Jul 2024 10:10:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_KS2KXVDLFpNcgYpT9NJwNW-S-3nWfpfT-gibJVJYcQ@mail.gmail.com>
Message-ID: <CAD=FV=W_KS2KXVDLFpNcgYpT9NJwNW-S-3nWfpfT-gibJVJYcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NV140WUM-N41
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 12:02=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
>
> The raw edid of the panel is:
> 00 ff ff ff ff ff ff 00 09 e5 e8 0a 00 00 00 00
> 2a 1f 01 04 a5 1e 13 78 03 fb f5 96 5d 5a 91 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
> 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 56 31 34 30 57 55 4d 2d 4e 34 31 0a 00 26
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!

[1/1] drm/panel-edp: Add BOE NV140WUM-N41
      commit: 993d36ac99efeafeb7b5f12353def6d7d20d6389

