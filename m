Return-Path: <linux-kernel+bounces-529919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677ADA42C86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EFB174AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7281A76AC;
	Mon, 24 Feb 2025 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nn+WFSwW"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC71519BD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424544; cv=none; b=P2Ztt8jsmCI0/NylVxk6vc6ZzZd06vdoP355mpOodCb59ytddalKc3cylcq3IAq991s6f9eaUlRMSjT7izeB2hb+5Vw0IYfykXxkr4P9UIaHzzShkC0PdvH2ueNMkxjHQP1Ws2XcHEPNuAhx5j5eE+pvlhTMIA8YeNlfgdTvNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424544; c=relaxed/simple;
	bh=wf8I/lImsF0WeJpZeysrIvsQD5AqJR9QspdyCiyuem4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBn5Jti/Yl+TpTWjqIXKNpABanU/FWdqxajzjJc2ZkB6gc+vSK8bIzGaCbRazxHprmrIjz+bimBEAWWv8RlG1PiMPMKHrwSXcS4bBWeRtylgRUBCTDUz+1E4urpFvsOsezGfkcERXItGWMGxqHR3NGCuSUAf2nubq9xxrP0Mp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nn+WFSwW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-546202d633dso4810477e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424538; x=1741029338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TzgdVT1U2w63C1ytH7xYdb5XCyf7BmjRmhuaIOdGmM=;
        b=nn+WFSwW16HhkzKUCQlqy1SxtovAvCjZ6JxZDx5suqQELWyQg3iJzL5hFM3l6g5AKG
         aNTMoYXeBX9tJad0wycahxvv4kuZ1u+mrBLTODYzSzKOvGxbxoA8NH3hb0vbjn+IWwc5
         cekqEP/uubZTLFeWdcwQ8e+H5Ay+FgM8l2IqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424538; x=1741029338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TzgdVT1U2w63C1ytH7xYdb5XCyf7BmjRmhuaIOdGmM=;
        b=hZsA90veiHcRurrmLy5LeG87LEls2yQGZrrDCp4PwcRlrszpudR9zneQLl1tQT1v0H
         /V3XZvrW5y/X0DlZahIxEd5TslHCUHqrGQX3UGd1cj/zpgHXyEooQ7Ydv+a3CGaTUtrJ
         a69xARXJzFarJJW4i+Ky+yU29PfY7zjz+5e3dpFLA02vio3UzQJzMjfPYWoX9oKzVQ09
         oA8pTyQMK8fuaMXrr+/1bgE+ODJfgyTz7el/5DTBaxw3oJ8AMTNPBriXRRZ3OV7MR9nx
         tYT4yiKYnBc6r3TU7jle4My+Ft5KyYcOqPIBPHa8LVarqwjJg+5kqG37YGRVPK0QNFkQ
         TGvw==
X-Forwarded-Encrypted: i=1; AJvYcCWl8J8ZJyUEd7328/GXLeNjImalFH/lsMVNaoS3xLxLLvRc98O2nGsW/YtB/DId3xgO6UQ8b6MTFRPpBww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Tkokcf5hck96e4qbmAnJ1iQSemc2qaa5fvQvnfVuk8ouo8et
	Unc3IAlWBmUd0ihkfC5L2U6HjKbRpeuZ7COCu5liLsUWCooMu0HbbCdPl/XLasnOi3BnruRorTd
	GVA==
X-Gm-Gg: ASbGncsC9qUcBUiWvYUme4OpT9F7n23ldIo6+9PAGHrKk8jRvUzbasrvzmWJ+czyllD
	/FJTraqyZksxFDEpr22M4VgsB2Ervt/LT284AMlXgHHvwgukIa38a3DJ/Xzdt5MFzGMP0r3iQEx
	+K7jITOGNGwJQt4x8GKJtcTCSgQs8yazxLcfVRubnnKPj1rwVO24v24fd25V/FWlAOvNHmgeAod
	DkJW6HZiCH9DkfD5a/q0oZrNoCbyt35B6LDXmZJKwPOjJm3t+G/qRQq5FpaljAa7FwKNG3iGHwt
	4vaDaPD55B41KsdZh9YfG9rPzEp6dXFkUiurHosx48v/8Zj3oHj0S/zMmqEw0TUOHw==
X-Google-Smtp-Source: AGHT+IHpKGJ6w09+epy+XbtHqchWFf/tDv/P8rxmiRBe0Mm+0sE1N1bwt+eA4DffczIm5B+dxSls6A==
X-Received: by 2002:a05:6512:128b:b0:542:213f:78fd with SMTP id 2adb3069b0e04-548510eb08emr66138e87.40.1740424538043;
        Mon, 24 Feb 2025 11:15:38 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5483fdd80acsm821176e87.136.2025.02.24.11.15.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:15:37 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-546202d633dso4810411e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:15:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6aI2ztdkMSeaoSDaGOJrML7XdWjMiM6kQDW+V/iJG3tsb9jyj0+NBRexs2kUqvr8otqe64vqSDzxGW+s=@vger.kernel.org
X-Received: by 2002:a05:6512:12cf:b0:545:5d:a5c3 with SMTP id
 2adb3069b0e04-548510ccd73mr93794e87.4.1740424536187; Mon, 24 Feb 2025
 11:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220045721.145905-1-tejasvipin76@gmail.com>
In-Reply-To: <20250220045721.145905-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 11:15:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UAX2wRBwZxEjFrETfi7HTrOc7cs3o6qJ2VZJ-F2bJ3bw@mail.gmail.com>
X-Gm-Features: AWEUYZl_4QZhQ9m7dCSBsVynW99879f9gxkGsKZXdk6G-yBZ_BrfThciwM_kgsE
Message-ID: <CAD=FV=UAX2wRBwZxEjFrETfi7HTrOc7cs3o6qJ2VZJ-F2bJ3bw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mipi-dsi: extend "multi" functions and use them in sony-td4353-jdi
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 19, 2025 at 8:58=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Removes mipi_dsi_dcs_set_tear_off and replaces it with a
> multi version as after replacing it in sony-td4353-jdi, it doesn't
> appear anywhere else. sony-td4353-jdi is converted to use multi style
> functions, including mipi_dsi_dcs_set_tear_off_multi.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Squashed panel changes and mipi_dsi changes into 1 patch
>
> Link to v1: https://lore.kernel.org/all/20250214172958.81258-1-tejasvipin=
76@gmail.com/
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c                |  42 +++----
>  drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
>  include/drm/drm_mipi_dsi.h                    |   2 +-
>  3 files changed, 47 insertions(+), 104 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

