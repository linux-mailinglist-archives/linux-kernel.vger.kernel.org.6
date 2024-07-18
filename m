Return-Path: <linux-kernel+bounces-256305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D29934C45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4AEB221FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0E757EB;
	Thu, 18 Jul 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="QsuMcjAz"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5D80BFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301314; cv=none; b=rQGJZGvuCr0kk1fI54f+i7YW1BiF/HgEaeRdyzz5Zc4otBMCnbqDOTmHDCXrZX3DYQRzrUFJpGHlFAQR3Ob+0oM5v+crEKN6Qa4LiGAboFyeDEsLKRyBsFmloTal+HwQpPtjtyfQXWabk5EqmRlcgQfizQjGVNhvq5Ju0aATWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301314; c=relaxed/simple;
	bh=fvLtlvVLIc2uX9Mv4C24Hw1TFHGs1i0AqLl5Tk1HA1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECwOsU/VsEc/JJaCi8lBKbDPT1wzBCSfW7+yBo4b9GsyW8OXN+zx0iOSMguZ/4U/esYEcJzEN/aYOxlraWCbJoY+VfdQ5jIFNsdi6xmsjnw7aL67N7RhzB3WCy4jGtKO3LK5T6HjJ1xIsiHyKZ9LrMfyFqoyx+DjetE1a1GCT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=QsuMcjAz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-643f3130ed1so6439917b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721301311; x=1721906111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvLtlvVLIc2uX9Mv4C24Hw1TFHGs1i0AqLl5Tk1HA1I=;
        b=QsuMcjAzQn/kEzFWU9IjeCMifSJHAYP3rsMwuVolTUWtOJzM1/pdjSvdegQib2lWSD
         /8XjTjNXs9qbUN+wyKiC6Jiks3+Z73Y8msuS/FFgYVT9aF0TmXgV8rlWC//ba2LR6xbj
         9l++OoK0E4nHPgUIxc7oPjTVvFfvqigaIXmCkHVWUWr/nL4CgEm9DLczIPNrjVMpZVgf
         4aPE5+m1BHNqbGjO/NXWVlNc+PXAfxoWVhg08SEsNEU5wkBmr6A1sJ87MBHBOIomzZoa
         kPzb9KJPCztCjGL0vkeSQxRPejparcRxPeaKZ9gcttTXr5TMVy+OyfXThUzzRcPCvy3j
         NZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721301311; x=1721906111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvLtlvVLIc2uX9Mv4C24Hw1TFHGs1i0AqLl5Tk1HA1I=;
        b=mf98VDdgW8nHKNDSx8uxzQCyRyu9GSnsgFhKNAmH3dkFgmVqIQeWub7rj33OGW70m4
         yGeAqLLqRKbXoX3FFSUWx2gV1ilNawBMebiZ+Oepd/idEQ7tHSEm61K3JfvIyTJ7E1hn
         D+TCMRx2G79KmJes1cV47hUJIOaWyn9IXIsHuwSu0wjDokZFZTfcwsYk55dirGWiZhPS
         o+0G7qdDo1ETCFmN8MMyc0RA/p+n/9m88/zOpsAiePbZ5wEkFt0T+KQNpUo26SstzKdH
         NjbK1S1y7t8UAEj0dk1c+1YsEpG3xfy9GJgoYe1liXXi7UPgV3QTYvyA9vH+B8BcCBj0
         Fr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy1ZoH5vKAg+e4+UIDFcJ+M/03PGkhXoQgBU8JDUhxvP/RE6HDmHtlBExJ5oAINTYUkl0GQ2w1JrMNLfx0C/DR3URhE9YyzpdegjbB
X-Gm-Message-State: AOJu0YyvuMSCeQnfqPlHa3PWVyQO+3vDidFhqJ1Ev9OzkIeSEqZIJtDh
	13bbKZYaye1rdGH5oGrUgazKXyH600hYv8cPZXLd1bxnwUwny2pmIXlEfnA+Y89OtSbFBBKQtTK
	M9omg6gCoW7Ansy/OF0sAHO4KO7/zyu5DHIzadA==
X-Google-Smtp-Source: AGHT+IHg27/h28x8cH6RNystKqwtN9ObuunzW9wLXPCT62zkr9oqTMXzH3ODAVfWE0/MOqv8X7Ek5YsHXkLmGxcCKWA=
X-Received: by 2002:a0d:da07:0:b0:64b:630f:9f85 with SMTP id
 00721157ae682-664fe45113fmr49718207b3.12.1721301311396; Thu, 18 Jul 2024
 04:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 18 Jul 2024 12:15:00 +0100
Message-ID: <CAPj87rM1dbawwtRnMzDRLLCt6FuOU+851hcJhKDsg1ioRM2Pqw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Declare Z Position for all planes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, shawn.sung@mediatek.com, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 18 Jul 2024 at 09:25, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> MediaTek SoCs support multiple planes, one of which is the primary
> and all the others are overlays (and CURSOR is the last overlay).
>
> In all currently supported SoCs, the Z order of the overlays can't
> be changed with any fast muxing action, and can only be changed by
> swapping the contents of the entire register set of one overlay
> with the other to internally reorder the layer properties, which
> is indeed feasible, but probably more expensive than desired.
>
> Declare the Z position for all planes with an immutable property
> at least for now, so that the userspace can take its decisions
> accordingly.

Thanks a lot for this fix!

If I understand your middle paragraph correctly, please don't ever do
that though. I think what you're suggesting by 'swapping the contents
of the entire register set' is:
* plane ID 40 (normally) controls OVL1
* plane ID 41 controls OVL2
* userspace configures planes 40 & 41 with a zpos suggesting that 41
should be below 40
* the DRM driver 'swaps the contents of the entire register set' by
making plane 40 control OVL2 instead and plane 41 control OVL1 instead

If so - please no. Just declare an immutable zpos, because that
actually matches the hardware, and then leave userspace to configure
the planes in a way which makes sense. Looking at the zpos property is
already required in order to handle overlapping overlay planes, and
any userspace which supports overlays (including Weston) already looks
at zpos, handles immutable properties, and will dtrt.

Anyway, this is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

