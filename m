Return-Path: <linux-kernel+bounces-191243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A08D089C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FC12882F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0B61FF4;
	Mon, 27 May 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHPfZ2mb"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184026AF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827448; cv=none; b=dGBh6jcQr8cVhcZyoZhe7FNCEG4o/MQWNvpIZMLjmAG3UQJsHkJBZTcwQBEV+UYJrYJeONn4exfLyrHe9KOLW1mrFbJgo4ZVCE19dPN5986n2R5dLwtNoHkm0VSL0WIZ7tlO/na+xcMZ8h9liuaWPk4cRqDzsz8Von/0JdA/tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827448; c=relaxed/simple;
	bh=R2+/Bqc+r5OlJN22CbB/Ce+CH8yiRz/LGoONUjCnr70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or4PtKP7GFXvEN6lZkPC/lWmhH5Z93L0d+/f47hdwrlS6cgITwuhiN0+yIrjjzZybHsIp0UmD9tRUPWf5smw1xHZkrl2STQpZwyjdIrkapw8qJpNvaESZPhOESAz8ye9+3OoplovkMrsHcax+8tv5DbmsyO/UU9qqwB7Z9BhRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHPfZ2mb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a087bc74bso32889217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716827446; x=1717432246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TooJjYc9+ZvZldvvOeHGVx6l39vdG5OagEP3ueKAv+g=;
        b=mHPfZ2mbxNqerKtTu3vdgXIJ3o4cayKRQPPVD/27C28ROWOIqrcRngD6ksa56Cyjol
         ciK0aQkuFIL4PtB+GEdQhn24BPj4vJhMIPqV4Q6IqTKgAPDYkcFLd7k4SRoXCsztEabP
         cL1Eoo5PZJNN9CDG5/mCZcg65UqNM3mqVMg4JyN5XhmQRTLO/qHoQUOYXNpWhx3DsoAW
         wcac+FYLhDgGBH45rPEgyXM1WGgSjVvQO+iYtj3CIvLm8uFcBvBLs9R0upnchcusDd2P
         Bh1MDFgCrc/dMvw3pbSW6lEBT3P+VU+bW0Pzfgi/F9HpEvGM0ak+1YdtswM4Tzuh4L0G
         ihww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716827446; x=1717432246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TooJjYc9+ZvZldvvOeHGVx6l39vdG5OagEP3ueKAv+g=;
        b=wFo5JO0hhVP21S/b17rOJtvJtswyoqQMogzA7TVQ+y+cvVtO81iSnII/x/uCNdtK9t
         D9jOse7PDycOHrXl1DUe2EMSTZA+nUCoF8hihgH5Ofz4PvQo+Xlpxu6cnkXKhHakXbNl
         79dxE743Zm5KFipYIYbGeUf8egeMmcaTqWAR9f4kDzR9Fua+9Yv2YvY546q6uy5ARM2r
         mZ0+5gHqUtWBM/yg8j0SxmFV4DfXOg99dhsGwJi89RyQXsBmNqTRVUf2nLtBQSRbudzW
         7KI6wun2S4WdjIr7UnBEqU6ZAjdm7UpDlvJhXCN4nuSYRwyGiNzK4MgTtD5oD/bAkrIj
         G9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUoNUTST7VsO1v7wDV8jGAcCesaTFHHyb0FUNjbWJqaJ+OkKEE6tkInAb0Xuf+YqPMdB/qvo18HGCGRJbSL5W/AMTEqvgpHyJxqZStu
X-Gm-Message-State: AOJu0YwcVK21H4faHBaoUAcHnLi60zsLda7dOyHZOWrtkuTNzR41TTLw
	i2Kmcc175cbkW4oW0ObnO//atJnK75UGu5qdr3q98wRNTPQV2rbANuFkeC2j3SFwZXadIwjk0mR
	UQfWKCWaYp2OFPRNwWNHQ7qmiRPc=
X-Google-Smtp-Source: AGHT+IEM4bi95EaTV8h1FgKgrzX448W7L+5D5l7ZUOFNS+/Ko7+gOTIRnKVdNXvixhChnUcRfqjaRN0leGF0t/i2Sxw=
X-Received: by 2002:a81:4ed1:0:b0:622:ccd5:3fa1 with SMTP id
 00721157ae682-62a08d8871fmr100295777b3.12.1716827446031; Mon, 27 May 2024
 09:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142311.3053-1-mario.limonciello@amd.com>
In-Reply-To: <20240527142311.3053-1-mario.limonciello@amd.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 27 May 2024 17:30:34 +0100
Message-ID: <CAP-bSRadDh0=WPepQUC3QhZf5x6Y1DdDT=qcEGwRrHXkOD8zmw@mail.gmail.com>
Subject: Re: [PATCH] drm/client: Detect when ACPI lid is closed during initialization
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 15:23, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the lid on a laptop is closed when eDP connectors are populated
> then it remains enabled when the initial framebuffer configuration
> is built.
>
> When creating the initial framebuffer configuration detect the ACPI
> lid status and if it's closed disable any eDP connectors.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Thanks. Works for me.
Note that I tested against mainline commit f0cd69b8cca6 due to
regression https://lore.kernel.org/all/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/

