Return-Path: <linux-kernel+bounces-576031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF63A70A28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474DF3A4237
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B721E2838;
	Tue, 25 Mar 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rGVpWs2u"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0915E96
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930249; cv=none; b=AH5mYLbgWadItQZ0W0BpcGJqHrMQUP1B/raJQj8sX+hjhbxH4X/unEOgNeXWL3v3xXugW3979ywq3hIhExudFAqVKN39wS3huzRUOGZSnzVH3TKlyzfQpQ3kvdBNfAU0oGyJbPtphKGvu4xpijC2m7sX8dXWjrRo4gCF+yxGrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930249; c=relaxed/simple;
	bh=EdSQ8Gd7IzAbS4ag+af6CBIU7QF5DD6S5b+GnDyoFXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwyWN/W2i9M7D4qCFHjRqLfKRjBy6MQPmPxsJ1od9uP5efHDBPU52GrxtEE+3FRERSGaFI7akTikOUTfdQ8qyd4cOjjrCa8ycZoyiJbFj1oWjylNN5Vme1NskR26flOB+o7zB2a9MTdGAdvbTrNdOi/PCT1mu99qc+Mz41KlQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=rGVpWs2u; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff1814102aso1511377b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742930246; x=1743535046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkzfLl2EELX81s45FDKPbh4PpckbL/4ObSjBAqQDCSs=;
        b=rGVpWs2uhg6dhR4gCR+13NI1a/h6+tOHzhvZw3r5EJqfj9VHELsKBl+1hRkoo6VW07
         PYWrsVmPGPhu+u7kynK3efzRoLI0zS0fPJTRleSQnC6wCRoSslU4R+PjdRvJWhMDR1Wt
         RIEZMh0sr4AmWxd/8MdKhRPzls9n1D3Bnn1QkG17ihxn3wtOKQTU8uFSCQe2St7090Lw
         UDmPbeoSYKwB8P4T23SOsnpBEF5c71vbmztHOcv0IGrHH5kDfdRdUjmGS9UGiIru5q/I
         sUX/GbjFrcatj1JmOV4PsO/q8E4w1H/mRx4Ue9q2sbJg1tB9IW65GZ+dX72OLEkFafTQ
         anBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930246; x=1743535046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkzfLl2EELX81s45FDKPbh4PpckbL/4ObSjBAqQDCSs=;
        b=t6cQnxPF7vTxUL0rhADfxC5vvzGbrJ9Xo9O8/DhRwbY1Gzizsmy+PXvhqsO7XNaVOL
         t4DoPvpl1K0dSWcw4EB+xxPfLF8rHrTRhpp9/2yuRj2qdtLXeJxaxlr2pEFLHGx48bUQ
         O8zl9kQvKXAYo/jyQi7lE197CvbeZxbE8w5ZSxmokH3KfD8vg6pcCYlofpoTkjH+tNrA
         /Z1aZibLOu6hFSLPyUres8ScG2aqpvVOHFbBuoX8mcu5J/B0BqN3lEVEmRHJHYUfpfmA
         fIIZlkQqY7n0e7VyYQg612ZDrlScUS3jgSVerTbAP5r4dgE3bgitPEqvcBs5lFzDfuTh
         8PMA==
X-Forwarded-Encrypted: i=1; AJvYcCWXuVebkuAa1Pv+G1gFIOY5ci/3MxN+ZnIpei+ZwvxO+xPx9bHNH17AADqu7VMDtl5hYktYXItf/L2njwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXJkMV/X2KZuLP0jJo7oL5YgzsG6VIpaC2/bRO1ehNldaTkCl
	OcdOgl/tVuwIP/z85wETJseJ2Vbw4NRBgMSWKPwNMaugxz3Wot+D6PuQ2nTQMhz6+df3xoZfsgQ
	h0okUL8ozkRWhQxbbES7mG3C2cI4Mmk92er2ooQ==
X-Gm-Gg: ASbGncsvAlf96quQcuEr4Gdi+nm5nPU1CXWOvyUu83xnLlj20YBSzyGIjFSTag5ined
	9NpFGGdTQDAvX2LX9BU8fM5CCWS9MtvpGztcSzLkvofdrxfVeDkAQ5nQa1oEL75L2MBEQK93ICc
	5oPl90zroOXifDK+jBjRhx1011MSlDD6f+iEP5PAN3DWklqBTRt0uTYop7
X-Google-Smtp-Source: AGHT+IF9QHoEqtScb0DxWu6P+2GXBQXj0+qQ0MB7yo7y54LdVO+9b3BgxBQ/u8rPx1CuXA9HK00F4fXj8rgkVom3WVc=
X-Received: by 2002:a05:690c:24a:b0:6fa:fd85:a2b6 with SMTP id
 00721157ae682-7020fe83e1fmr12603657b3.13.1742930245803; Tue, 25 Mar 2025
 12:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
In-Reply-To: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 25 Mar 2025 19:17:06 +0000
X-Gm-Features: AQ5f1JrGBIAhqvbJ3tPqRrxYHVSuuX_SUuj7ocebvIQPJh6kl8Mwb1WieT6LqkE
Message-ID: <CAPY8ntD8uD-PqGMVRxgWS=_JE7v35CUWtzTr_HHV__wSHtvCNA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/vc4: hdmi: Add jack detection to HDMI audio driver
To: David Turner <david.turner@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 17:13, David Turner <david.turner@raspberrypi.com> wrote:
>
> This series enables jack detection for HDMI audio on vc4 devices.  This
> means that userspace audio applications can detect when HDMI devices are
> connected or disconnected, for example to play/pause or switch to
> another audio device.

Thanks.
Series merged to drm-misc-next.

> Changes in v4:
> - Split the update of the comment on
>   drm_atomic_helper_connector_hdmi_hotplug() into a separate patch
> - Update the wording of the comment
> - Add Reviewed-by tags
> - Link to v3:
>   https://lore.kernel.org/r/20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com
>
> Changes in V3:
> - Update comment on drm_atomic_helper_connector_hdmi_hotplug() to
>   clarify that it must be called for disconnets too
>
> Changes in V2:
> - split initial patch into fix and jack detection feature as
>   suggested by Dmitry
>
> Signed-off-by: David Turner <david.turner@raspberrypi.com>
> ---
> David Turner (2):
>       drm/display: Update comment on hdmi hotplug helper
>       drm/vc4: hdmi: Add jack detection to HDMI audio driver
>
> Stefan Wahren (1):
>       drm/vc4: hdmi: Call HDMI hotplug helper on disconnect
>
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  | 22 ++++++++++++++++++++--
>  drivers/gpu/drm/vc4/vc4_hdmi.h                  |  7 +++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
> ---
> base-commit: eff0347e7c228335e9ff64aaf02c66957803af6a
> change-id: 20250312-vc4_hotplug-3ae4e783484a
>
> Best regards,
> --
> David Turner <david.turner@raspberrypi.com>
>

