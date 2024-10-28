Return-Path: <linux-kernel+bounces-384202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8859B284C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8898C1F21937
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6718FC9F;
	Mon, 28 Oct 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ewz72AmO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDC156960
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098844; cv=none; b=t/t/4y258ZyXtD52RNk9HvUwD1nlzO3imrhzi2o0XavBXZjAdaeaQ4rXUxJpPbm/no3+BgtEfkCusvUbH57udH5/kuUoKVKmoVyWqJcxZuxzH0HrnMek6uX7UoF2MneTvWt1maqJ0V4L1CiGDPfKWQ8/ClUgsVyVlhLiAMD0ipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098844; c=relaxed/simple;
	bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXOnkdxzZu67BIBYzYo34DIXaJbwAQrxC14qRJbGuTAwBzvi448V/77csSYfwefshmWSUwULP4CpTKGgMFMkkNmsjZ1a3xKh+j4fCizTR0qmUVgL/r0HV6/bN+H8mTz9G/qoiScTz5FYGXbhZFPZ0SsEL26ZN46cq4tEeDS0xDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ewz72AmO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e59dadebso4580613e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730098841; x=1730703641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
        b=Ewz72AmOE7o2HKbvwGZTGFqWiR6TFCecQrEUYj/JFkxR6twAB7ULmyBz9jkTyCgPfJ
         f5PI6tkq1bOHkxGira8EwTeDOgf2ciuCm0j9K+8350AQM8EKmY9EFCNUxuRESbZmI7pM
         7jb63oW55pTP6LbqM5M0mSoIr9PNPy4FzbLy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730098841; x=1730703641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXeJH9+dd3cazFRcmOcTf4KQwEKjtruutzeaxtbL0pk=;
        b=Ky7K4reB+iguTnyyuh0+yv/L+JtuN/eTSD6pNXTu8j3VN9Dj2h42lQbB3NZoJMoKDK
         jowR3iRBsmprb/+gMY8sTeOO8/5NUIjb5gyGJ+wfttXPzllyUWjeA6Ey6Y3XWukg0xlo
         4CxhGILtuM78W8bby0GXPEDQuEp2+I6T9d0amieFASzVfBnRLzpDNQclsusJYqXZGAg2
         3SUNssGRL7L+gyauAoHKctNToL36bZ6afhlXmudf4CSknaOIErSNMwhclVOvrIIkbHZp
         Z4HXy5ZO4ZzNdYzJbNZbXKi3DDrimym0mfjBB/RPxniyZtAqdY4pHhUkae6FlQzoWOlZ
         K4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVx52G0f21VNMJuqz7shc3C0G/gU8jLDUzWEK1dPsn4AL6nZLgNzgoKXlhf8yLIhVSMy1C5n3rIlFw8/oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynx3Wg1mj0NEG/RWSHEXx1WogGasMUtCWOMOYaDvrpiRpk26Mo
	CKIF9EpR8moDXuJffu04Z/OZutjDoXxa6PJ/hTSE6fynECybKKopBX4zfOnqXBJJgKGlKbYTLUS
	eOEZG6BIFkVai4x2ThPVYW1sSpWk7WGQgpKa5
X-Google-Smtp-Source: AGHT+IG0bSkKwUt4vIe/DSFsd27a0aZcM775T78oioXCX/0ert+iimxun6TtbNvBDPU5UOHkKZf2rc0Rt4hi62j6fcI=
X-Received: by 2002:a05:6512:3ba3:b0:539:eb44:7ec3 with SMTP id
 2adb3069b0e04-53b3490fabamr2408370e87.31.1730098840615; Mon, 28 Oct 2024
 00:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com> <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-1-2b40c74c8d75@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 28 Oct 2024 15:00:29 +0800
Message-ID: <CAGXv+5Ge_qcXaSBQ9d8QZOWe3x_9-6r9LhDGvAbUHNKYMwevUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: Fix child node refcount handling in
 early exit
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 3:22=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Early exits (goto, break, return) from for_each_child_of_node() required
> an explicit call to of_node_put(), which was not introduced with the
> break if cnt =3D=3D MAX_CRTC.
>
> Add the missing of_node_put() before the break.
>
> Cc: stable@vger.kernel.org
> Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

