Return-Path: <linux-kernel+bounces-182411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D18C8AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D31C229AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2413DDBA;
	Fri, 17 May 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yn70wICJ"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE913DBBF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966824; cv=none; b=ZX7qjHzlslBmtLKrvnbZkcqB8qjWrLe00nTgJ0RePT4V3V46J5NGizU9869v//7Qbf79xbkpo6/rewmX7156e4RfBL5g68wE+Z9c5rPjB3WU2u5ctvbPELaT77iPuMuseyq+gQlFZS94pF3hiQ6uoHzYplLheeGpAzBCcPCXRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966824; c=relaxed/simple;
	bh=48GvXVLJkHq9YxVD/HCR+vRsn8uOcEZMuOz/IOK8Ql0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLRhXpAraBJCVPWmWXa5VIE3ii2yAs+ZAn/HCbX06hwqGJW7nELUstfs07wafKovTAtAFJBGiQKozjKl9F8PdH1RQMQcLZ6W43sEz9J66B8WdsJm3VmoZhEmscJ0ibReuCYYiw6dcNNW542M9gJf/i02o9kfcyLWBoeuAuCJ/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yn70wICJ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47ef8c9991dso90988137.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715966822; x=1716571622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcxVTcFh7NO1RmeggMzvCad9BHQKhjKuD/Oz3pjme8o=;
        b=Yn70wICJeTF2Q+Bgg14h133fFZ5qJWTrdZX4bTBOlOWyAQ5oYpowb9ZWDh8YllmEpU
         BgJ7Tl8oS955OyrnzfEbwiL59RVkz/Yd34dRebFQxom3AyE/LO1z+guOGdspY5qUSR3H
         mMu9bNBreia1vl9TqLTai73K6cJALd5hrTmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966822; x=1716571622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcxVTcFh7NO1RmeggMzvCad9BHQKhjKuD/Oz3pjme8o=;
        b=Xb6h3RHZzle7B7nJhXc41zi+q0COr0iQaW5zKFFYKaxeXnIQAYkhC4iVKdKuDpVhuy
         ilnXs1jDTzRswHDxCQhAIrcXXntVJHSemtyb1ixKuNMqLrroDrQuOUtqWjgyv89+8pmp
         siA/0zkDrRTOQ2PNm/ZHfM7Echqj2xGLIL2Nv3IEJ1QrpMk5ZurJs5iz0w6O+xKDeTOZ
         7UAh1IrKKV2u7KDp7vJAFtr8k8LsJxlw86wnkFuniXPkFE9pewtxDaP/++oyo8e2cl6k
         voZ5jXfZkCEqKtk00xJqjNlgyiG+Wb2qlI6FS293ZfpdjOf4x4UTJx6ijZoVlzoUfrDN
         kFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAlZq5KlTU6EWZBXnKtAiAcXHt+alXCHh2frCWtQc1weeLn0Xgu5iZtQfVyV1dCL30jiA0rY0IxW9WkxCuq7OjW7FAhj0MTQ8Gm/RY
X-Gm-Message-State: AOJu0YwjTJ3+NnCRCY7itJLE4MK2SZQz2BTSJmWfFXzq9mbFZJplFBAM
	SBdFDsJWn0bjtLy3rJl7ghejvpMehdPuO/DqDPW9mcq08Xvl2fkyIeEmSpR+f1n4uoCTW5dCm5a
	79dG75EV1/r4FOsXiUJlIa238VaNJdIZ37dlG
X-Google-Smtp-Source: AGHT+IElyxDzLSoeVKTnHsADhpEMO/j0Y0exiEY0s5o2jQhNssuaMk0JL5QwXxOtxjka7wlQqKZ7P260uLD752jOyqw=
X-Received: by 2002:a05:6102:14aa:b0:47f:2c10:24e2 with SMTP id
 ada2fe7eead31-48077e5bfaemr26084771137.28.1715966822410; Fri, 17 May 2024
 10:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com> <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
In-Reply-To: <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
From: Tim Van Patten <timvp@chromium.org>
Date: Fri, 17 May 2024 11:26:51 -0600
Message-ID: <CAMaBtwFQxeARGyhVxo+WsYCHgmJNJ7ThjtPcFv=LZqRNJtVxsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
	prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
	Shiwu Zhang <shiwu.zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

> Fair enough, but this is also the only gfx9 APU which defaults to
> noretry=1, all of the rest are dGPUs.  I'd argue it should align with
> the other GFX9 APUs or they should all enable noretry=1.

Do you mean we should remove all IP_VERSION(9, X, X) entries from
amdgpu_gmc_noretry_set(), leaving just >= IP_VERSION(10, 3, 0)?

