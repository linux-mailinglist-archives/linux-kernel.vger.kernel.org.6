Return-Path: <linux-kernel+bounces-401863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DC9C2043
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC5A1C23159
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87F202F7C;
	Fri,  8 Nov 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XuHsgtU8"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC454202659
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079338; cv=none; b=B0InnHju/6cqI+WeUek7jy8msBPZXoBfmQbI8cd8gbwogT47Un+tD4xEDI08Z0iuE7VVWO/WG6+gyWn11qkB8Q+mpKBCI5D2MQBmSNN8LVpz2e+/lG0coze+0KT2OD20oDlouMtvyNnWbtgjzaMljed6z9siN5MKsogs65v4uzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079338; c=relaxed/simple;
	bh=0kURwNwHJBkQ3AtqqMqkka3+75b3qhZ4CX1aiiQ7DuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fql53GQCHwgviPNJUrwwn9s3VE1WpTJGKnHWwbu1+uK7dabP4C5byrg6W9wNq6c5MrhgDJGFdHN0ZuhwIyKfbejHNALS0dvFTQ7fFMkuqKE4qKgv5FvnUHM+66Y0rFnDXkpPIaZK5e2RsdrQEqhd3LVsdCcN2hl3+ud2LdzHlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XuHsgtU8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e8607c2aso2585486e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731079333; x=1731684133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgfLZptM6/3AAPLv+VlAD5qO5/FWxVF/aNEVYnKiuLs=;
        b=XuHsgtU8ZW9jA3+esi5NL36aBgGmuid0N1GoUbYTpxatGBJn0h5G9xVzm3SOjeTDX6
         ypk2Ev/xaHH7dlJG17v3FVaMudgrw8KPCCBKhjr9AdNXHt6sCBFO8vskRs4sOCFMjj55
         Npu/ZYPcxgCTxFSSeQJ0fx9+wiL0JgI2EqOBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079333; x=1731684133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgfLZptM6/3AAPLv+VlAD5qO5/FWxVF/aNEVYnKiuLs=;
        b=OKNrZF07LLaZWohFJo4gfu2mzO8CI8l0Ww/5FFCyBZuyCwqSDxxFocxtbeiYBTfMk3
         H+Sx6ApG1vFgh2HZAStf2xm5lHDONzcouVkNEa92rwmhJ5zZzNFjpnI3ahkokIbRDqHX
         GW4ODgbdojplNzt0+2pIyLcN62DVr6XK4ctr2pdQLKCAmd9oCPuwD/k5gKsxT93V2w8S
         Ww4E8VGfAa0sVxPobKCDG9sbV9SPe1NL38XEIUIvu/EnqfokP/4n97d/FIn7yKeFio55
         5jUB8TAviKZJMUiAjbF8ZsxcTGLrwH+BNPrboGEoMe+8iZiTEblEm00f0QhYmGEv57+I
         TmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYbkNgcOeuagIsyTwv8yLHeHRhAWBcKi+HspbwfyW9hros4Yhs50J0afW5EYz6/PChmgOCN6aQx6dlaAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGhc5YaNK4HsxcLTEQsmUbSAVh4rd7h56jT88A6ANdOMFaYbQ
	UcRg7IbQWpjp+ciV1AL1v7ra0g34r//be8cY+Ap1IwovO5we+VwDCCZSTHmzOQYqLC68aTQeapA
	NgA==
X-Google-Smtp-Source: AGHT+IE80DqMqN6CTRTrdcxtCQJN0Mx9xEHZ/SvLjrNVUqyHmlHwQw31Ft7k0oZBhp8uvJv9p/RsVQ==
X-Received: by 2002:a05:6512:3d21:b0:539:ea66:597e with SMTP id 2adb3069b0e04-53d862b44a7mr1968763e87.2.1731079333328;
        Fri, 08 Nov 2024 07:22:13 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784fesm644451e87.52.2024.11.08.07.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:22:12 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso2585283e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:22:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeOlMzXtMsQSYFJHoRyVTnjhPbqyhe0Q7gAdd/wwpmx45nrMTc0oQ+ZIaHyKWEYH5cj/Oy/OSVbCIsdmw=@vger.kernel.org
X-Received: by 2002:a2e:be20:0:b0:2f5:11f6:1b24 with SMTP id
 38308e7fff4ca-2ff201b3185mr20586931fa.18.1731079331685; Fri, 08 Nov 2024
 07:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
In-Reply-To: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 07:21:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XSiNw5RKEPg5wwTn=tNVKDxYoqYZLU5C_88wveD29UCw@mail.gmail.com>
Message-ID: <CAD=FV=XSiNw5RKEPg5wwTn=tNVKDxYoqYZLU5C_88wveD29UCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Update with Daniel Thompson's korg address
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, 
	dri-devel@lists.freedesktop.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 8, 2024 at 12:31=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Going forward, I'll be using my kernel.org address for upstream work.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Daniel Thompson (2):
>       MAINTAINERS: Use Daniel Thompson's korg address for backlight work
>       MAINTAINERS: Use Daniel Thompson's korg address for kgdb work
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I don't know if it needs it, but if it does feel free to have:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

BTW: do you want to adjust the '.mailmap' file as well?

-Doug

