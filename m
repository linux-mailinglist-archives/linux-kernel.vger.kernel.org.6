Return-Path: <linux-kernel+bounces-195528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A068D4E10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F451F2123C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62D17D890;
	Thu, 30 May 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwKducPX"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67417CA0C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079671; cv=none; b=Y/3RenSLnNxVd0quhrRg+/Fd1Pp9X5l2fJ5J+QPhnCpt84GBhIU9haZRGuKlXIXoDGZabif7nQT3X4AdCghR8lqBZe3081t85DyFTRP01Zm2WhhU7nLvK9dwhVX/VkWNUGoSaWt0jUi9Kb46fnQRRIL43qVkRWsQC5U7NEWw67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079671; c=relaxed/simple;
	bh=Lwga7v9P8IhYm9C+t/qXY4lKZ6jl1JNqRADDxFAQ/SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeZkcMGJqBi5EwAui/WRFfl705LNGD3UKBCM3OBMwJNp/C05mgdyNEPcUZ5MR0xFFp7WeduhEWU0II3m3kWo977vg/zb48xlYMOiS8kc7YppxYOeZ14Wt/HZw+xYKJSUp+UgYnhUJ37cd8pTyfV4XJW5U5ct5nQDTB/0IrlAhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lwKducPX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794ab4480beso72999285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717079668; x=1717684468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX/wC7qXXog0qac360LVKqW+SM9R51AMBt2HpIW0OBk=;
        b=lwKducPXMF0NtUzOmFfFJQq2AXVUvJ98FlK4Hlx5RwluCd5xO+3V1SNjqP7Zh9pgeo
         sYco/dkiTn0ngDCMRw1vpJaDc8IEbCSNHTGkmPDUT1VqwTJGO3WA0rY9LYqdfYRKlO8O
         /C9dw3ZMRS4GSjAvQR5PeGm+7F/JCPNws74Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079668; x=1717684468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX/wC7qXXog0qac360LVKqW+SM9R51AMBt2HpIW0OBk=;
        b=YTXKdPNn04XTCtTUVCH2Yk4yG+gx1lWPqsuZhW3s1SmZjxHs/V9nfWqMNU38NJ9EeZ
         CKV9jl+aI69DqTQJXQcYEXuJxtLxy7UqpCy8I/o06/fFrnl+MM0PvDiuY9xIZLYoZK2r
         eS+79nZgIpi0XhvylOQjHVj1drtbI7rcLQAm/2oNyj3+N7GvwTxjbpslbFcmJaYi0/0A
         KNR2Iws4XYhnP39g9PfF1Gj1pEi91TwY9FRZEw3XIv6QIuHVfXRIsqxh20cO2HmiKa2k
         jQm5mMBBRJWaQDiC3jchMIS2N0FejvpWrt2bXmAWaxoLpnf9TT7AJ+oKHpm9M1Sx4WV7
         tuzw==
X-Forwarded-Encrypted: i=1; AJvYcCWVlyJqmt9one7Kwjlo51YA4ruIZsOq32nN0Jg3Xnb+3fRSBmIcUPmAN1DKXmJAsFBq0G2SXKGirTSchdYfEEsFOF/TK3DGXJJ43Yln
X-Gm-Message-State: AOJu0Yx2nRYTdFAbVr/G8Dy6jSLXVW4P0ZLEnqg1V5DuZqe8A6KjijoR
	XgQ3ShGGbScoX+DyrFlMl+Kd9Jy0g9D3Z20My5bemNTZD7YPmdtEBxrlydhQiKndD7Vwx+Pj/i4
	=
X-Google-Smtp-Source: AGHT+IGzv/vH3cxicTl/543Gbgs3gfHAD3MFs0b+xz+ZkYN322H7BfhsfYODM62/AVOKgI3/ZtjXrA==
X-Received: by 2002:a05:6214:2f83:b0:6a0:6676:f1c8 with SMTP id 6a1803df08f44-6ae0cce535amr20461486d6.59.1717079667789;
        Thu, 30 May 2024 07:34:27 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070c2d12sm64113876d6.14.2024.05.30.07.34.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:34:26 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43e14f0bd75so282171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:34:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWDFx3RDj/q29P+VS8fECRS2+5AfQ9Kk8pnplmuVKhgrPkJa0uTqAl+HFzd6ewuW661FC5BStVgVaNR9YtsOnAkT8nGEXUBUA3FpM0
X-Received: by 2002:a05:622a:260c:b0:43f:f0e9:5f25 with SMTP id
 d75a77b69052e-43ff0e96040mr383391cf.25.1717079665507; Thu, 30 May 2024
 07:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org> <20240529-edp-panel-drop-v2-2-fcfc457fc8dd@linaro.org>
In-Reply-To: <20240529-edp-panel-drop-v2-2-fcfc457fc8dd@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 07:34:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XjkuRQ_bPYiNi2Jab2vDpegUBA2PesFfix5NgvF-pF+A@mail.gmail.com>
Message-ID: <CAD=FV=XjkuRQ_bPYiNi2Jab2vDpegUBA2PesFfix5NgvF-pF+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel-simple: drop several
 eDP panels
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 4:53=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The panel-simple.yaml includes legacy bindings for several eDP panels
> which were never used in DT files present in Linux tree and most likely
> have never been used with the upstream kernel. Drop compatibles for
> these panels in favour of using a generic "edp-panel" device on the AUX
> bus.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml        | 10 ----=
------
>  1 file changed, 10 deletions(-)

All of these are fine as per my research [1].

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DXz1VsF8jG0q-Ldk+p=3DNY-ChJkTk0iW8f=
q2bO=3DoRFvXRA@mail.gmail.com

