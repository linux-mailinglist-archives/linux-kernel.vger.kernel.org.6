Return-Path: <linux-kernel+bounces-304706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2AF9623C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556EC1F23BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53006166319;
	Wed, 28 Aug 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ORjQ0chN"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE915E5C0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838103; cv=none; b=LHFSf+AyBrxWO8DnX922N9pMdPiGac92NAi7egmqVT2Nfy8kfK8cbqlwpJSsMYjQ9Z9uV7uMYBgHmXEty0ofa10LS4F3xySMYoNHQZz44qn6IgMFR96C1VuI9YxbxNDkFEefM6/0wsMIThx8EhKBKMbEheYcecREo4ZPYUQb//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838103; c=relaxed/simple;
	bh=MDXXPoP3Ql2ed4Kq1NPFVHjXHxrCWpZsHv/VA9HbH3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1uFuFq8lkuV/OgDTHgmVpcr79cs7RAfagkDPRvq+YE+2cpxg6bFhuWDGE/JqNCRnlBGkoTWunbzLExol345GFvIMW8B87Yef1gV0FgEOz7h6A5fbMgki/Yl/dUn6BSkIPiMPrud0qjoE3V6PvvtPyyrtRAJr80McT/oJIp9nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ORjQ0chN; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-498eb25d247so1883482137.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724838100; x=1725442900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXXPoP3Ql2ed4Kq1NPFVHjXHxrCWpZsHv/VA9HbH3U=;
        b=ORjQ0chNvOawVRZrM+477x4orZ1IZ00Hmoe8gp6OLBsdyjjnj5PGUVT3Vq4qqlIhB8
         7iuhpVbogbMHVAy3vphRE73YbfX2zHvN55l7WvkWNMjgUg0uErIGhLXrMU3OOqh5t4WM
         5QJfsNP1zLp4xZMzh/I23sii6RdDLp0M378DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838100; x=1725442900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDXXPoP3Ql2ed4Kq1NPFVHjXHxrCWpZsHv/VA9HbH3U=;
        b=v6nCArLjC4YXmmOVyEDVuSeGdodg9LxEn3NZElEqAsEFKLPKbn5vG1HNBafovMShIc
         R/X5R/8ldRF75cYV9TIy3k4Dx/NISj16vyzr+eFddB/xUJmxTBMpC2a06FebpkAdFuu3
         HvgVQ59yIaz2zGkEipoLhUVhpGcxs/0hkKJxmuUN0v143a6tIsX7QCATunsz5SittYSh
         ZhZ9FaEc4ni4uyWivTa5mrI4uc9MOU/VGES+gSq1N30WEb9bh5qCAPnzIvw6VMwHe4aK
         B6VS0awdeQcUwZirrRjBHCRG2crWKiMAoJaQMY1iSJEIkg7DcVxbFJ6N+nULdNsCQfcP
         QTGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5KTW0EQA3I6NCzS+8JnsZ52Bmt8BCVP83m+NaerNU1u6Vk0T3bUGEbIUpvqO7R8zWOASVGXopFZzn8UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywva+rA1ASnKfcKKJ4nEXnQxE/Tpy9m/2I4x+MHQrXmOvjBR54m
	P8n4EJ0CP2yNF0T3fFR59MUerWX9dqm2Quk7A1ZgCfckJT+cWkX99TJ5hJXt0eHgauhH/uc+s/E
	=
X-Google-Smtp-Source: AGHT+IFb1XFBVV/bwkUfiNCTzVq086+PtTqr9ywK2zqmW83Ok0+FatIppeB08iYEYGRjX65EpXKF5w==
X-Received: by 2002:a05:6102:c08:b0:492:9960:682a with SMTP id ada2fe7eead31-498f4680ec9mr14918011137.17.1724838099506;
        Wed, 28 Aug 2024 02:41:39 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce4eaaf1sm1528343241.11.2024.08.28.02.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:41:38 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498d587c13bso2036413137.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:41:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyKSeDtupfyCvDgBUk7XMP6EJLZ7iTv/3ZZ4FFiafNJGN6fEkZ46QSdDhWdOhV5ftg9XaYYgaHEsRatQs=@vger.kernel.org
X-Received: by 2002:a05:6102:50a9:b0:493:c81c:3148 with SMTP id
 ada2fe7eead31-498f41cdb2fmr15317053137.0.1724838098095; Wed, 28 Aug 2024
 02:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com> <20240827-drm-fixup-0819-v3-2-4761005211ec@mediatek.com>
In-Reply-To: <20240827-drm-fixup-0819-v3-2-4761005211ec@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 28 Aug 2024 17:41:00 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngpXtsLUF=A-MxVnmWY7YgwvxHKSe0NuN_n=G+7-kpG7Q@mail.gmail.com>
Message-ID: <CAC=S1ngpXtsLUF=A-MxVnmWY7YgwvxHKSe0NuN_n=G+7-kpG7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/mediatek: change config_lock from spin_lock to spin_lock_irqsave
To: jason-jh.lin@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, Aug 27, 2024 at 10:58=E2=80=AFPM Jason-JH.Lin via B4 Relay
<devnull+jason-jh.lin.mediatek.com@kernel.org> wrote:
>
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>
> Operations within spin_locks are limited to fast memory access and
> confirmation of minimum lock duration.
>
> Although using spin_lock with config_lock seems to ensure shorter hold
> times, it is safer to use spin_lock_irqsave due to potential deadlocks
> and nested interrupt scenarios in interrupt contexts.
>
> So change config_lock from spin_lock to spin_lock_irqsave.
>
> Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet i=
s done")

The appropriate fix tag should be:
Fixes: 1bbb2be61bbb ("drm/mediatek: Fix missing configuration flags in
mtk_crtc_ddp_config()")

I don't know if it's worth resending though.
I guess it's up to CK if he's willing to replace it when picking up the pat=
ch.

But the change itself is valid, so after fixing that:
Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

