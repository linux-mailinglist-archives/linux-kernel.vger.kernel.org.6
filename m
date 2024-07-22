Return-Path: <linux-kernel+bounces-259267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76670939340
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42111F21EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910AB16EBE6;
	Mon, 22 Jul 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqCNJrbT"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25C16E89E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669771; cv=none; b=tqqbJae2tNJlI+F8Ea7IQMEztY25kzhN3ZpjGiHkenfsFjG7pC2i1tmWodNgOSERgicnNLFRNZOHSYp5jtyFV3/5X8+XplFRRWsMROkwDdmIiBw+H74CldA44JaKrrm6uamzqoiCxWGcpv/OqHasddUKui235rBq9zbuptupPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669771; c=relaxed/simple;
	bh=PW8rxhXZ+UWKe6Geds+5qnoxX+jM+izmdxxMwg08wXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJ98BRH9fqCdXca2wh7qMSiLyWCXOrZQq5r/VJMD8lGiCBGNjXIcNZ2fKb2L6iVcvUywtjlNtaFRRCXSo/6PtuCWDmHTvXCFPXL9UPScfC6rBYZaBigythcNYsdrcpT9qn7Ox0Ty+6MMu8ZzLlM9MIBoO45y9DW32hfWpWEzEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hqCNJrbT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77cbb5e987so412324666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721669767; x=1722274567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKmnFtuUUL/6/Qz31VCLadtYrbr5QB0/wZevNZHeBHQ=;
        b=hqCNJrbT7aFd73EaY8L2ipltQOSxCLS/lJrXrwhXrTu4ZlWpeKMm31lNu62gv6bmgQ
         Qz8IIJB6hR+YXQRZvX5I1wy9VEYSuEtWtiK9RVvH4Sqkbtbjgh7tngJUpViAzMiku4AN
         YkV8LAMyEKlHV8BZfezalbthlF69jF06d2v8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669767; x=1722274567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKmnFtuUUL/6/Qz31VCLadtYrbr5QB0/wZevNZHeBHQ=;
        b=wZNZi+L+lqncoPFSSzWoTM4VqbHLUrLal3cj1kSUbGDGOkt9tqNrqmlvFvTJUwnqYb
         a/OsY+GExBBijZRWWif2OGDcag1IIPVonFmon7/ALvHaLJSKptU4bstoDLDGVOjlA+ho
         uxYXOeeO7ddpLOE21g+9w9nH7J5da76JrlS7gQ0iF21wc2QHrOSg3VPQ+BIE7LFF9FZj
         0B8mwjbBucSBbpc8USrVu+phBRyhcMWSBI1fuMu+Um2MqmtT8Xsy4byFX1TgZnNZcDRJ
         0fX16q3bs6E+AKI3PI6MfMEGO10Hd+mRD0bC+PWFqkDG3zFWPU4BCr9sIFEmBt/g7XOs
         ASHg==
X-Gm-Message-State: AOJu0YxSyOvFvgL6pxQZHOSdC5wmew4tx9/+xfVvh6dhpuIReXvBVygk
	sUIOf0+47x5Esizoc0ZNhaEBSGtJVLoifL68vHmU44Q6UgrjswUbJ7nLXnRNkCPxok8HKSvzzEC
	mSg==
X-Google-Smtp-Source: AGHT+IG64mDnL5gnOB41quDPA09ZAC7pXgnhZhi1OLdzDuOFkQy8QdzuFQPoLrnrF9n3ikVCgGq9xw==
X-Received: by 2002:a17:907:94c6:b0:a77:e7b9:fda0 with SMTP id a640c23a62f3a-a7a4bfa342amr533985766b.14.1721669766812;
        Mon, 22 Jul 2024 10:36:06 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785c6csm444397666b.20.2024.07.22.10.36.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:36:05 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42725f8a789so2305e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:36:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3b07:b0:426:7018:2e2f with SMTP id
 5b1f17b1804b1-427dd16e865mr2883575e9.5.1721669765333; Mon, 22 Jul 2024
 10:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721100449.8280-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20240721100449.8280-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2024 10:35:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJQaf2H8M1D+UoJGtXy0yij86atX5Rk70njW2zGCquZg@mail.gmail.com>
Message-ID: <CAD=FV=VJQaf2H8M1D+UoJGtXy0yij86atX5Rk70njW2zGCquZg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add 6 panels used by MT8186 Chromebooks
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 21, 2024 at 3:04=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> AUO
> - B116XTN02.3
> 00 ff ff ff ff ff ff 00 06 af aa 73 00 00 00 00
> 00 21 01 04 95 1a 0e 78 02 6b f5 91 55 54 91 27
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
> 36 00 00 90 10 00 00 18 df 13 56 e2 50 00 1e 30
> 26 16 36 00 00 90 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 50 05 18 7d 20 20 20 00 67
> - B116XAN06.1
> 00 ff ff ff ff ff ff 00 06 af 99 a1 00 00 00 00
> 00 1f 01 04 95 1a 0e 78 02 9e a5 96 59 58 96 28
> 1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
> 46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
> 30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 0c 0a 2a 7d 20 20 20 00 3a
> - B116XAT04.1
> 00 ff ff ff ff ff ff 00 06 af b4 c4 00 00 00 00
> 12 22 01 04 95 1a 0e 78 02 9e a5 96 59 58 96 28
> 1b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
> 46 00 00 90 10 00 00 18 df 13 56 ea 50 00 1a 30
> 30 20 46 00 00 90 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 0c 0a 2a 7d 20 20 20 00 e7
>
> BOE
> - NV116WHM-A4D
> 00 ff ff ff ff ff ff 00 09 e5 fa 0c 00 00 00 00
> 12 22 01 04 95 1a 0e 78 03 0b 55 9a 5f 58 95 28
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 96 1d 56 c8 50 00 26 30 30 20
> 36 00 00 90 10 00 00 1a b9 13 56 c8 50 00 26 30
> 30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 40 ff 0a 3c 7d 0f 0c 17 7d 00 00 00 00 1a
>
> CMN
> - N116BCA-EA2
> 00 ff ff ff ff ff ff 00 0d ae 5d 11 00 00 00 00
> 0f 21 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
> 30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0d 3c 7d 0d 0a 15 7d 00 00 00 00 0f
> - N116BCP-EA2
> 00 ff ff ff ff ff ff 00 0d ae 61 11 00 00 00 00
> 0f 21 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 1a e7 13 56 e2 50 00 20 30
> 30 20 a6 00 00 90 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0d 3c 7d 0d 0a 15 7d 00 00 00 00 0b
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  Change from v1 to v2
>  * Modify the description of subject
>  * Add the raw EDIDs
>  * Sorted according to the order
>  drivers/gpu/drm/panel/panel-edp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and pushed to drm-misc-next.

[1/1] drm/panel-edp: Add 6 panels used by MT8186 Chromebooks
      commit: d4b9b6da5777bb03f36f01bb6b05c6cc303ededb

-Doug

