Return-Path: <linux-kernel+bounces-183032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E725A8C9393
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D6828166C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56B10A3E;
	Sun, 19 May 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnVvhlo3"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDD17580
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716099486; cv=none; b=bzS6ShiYfXjTSFC9bxTZh2fSc6z9UnNSKAZAwf+RXMF+badKGWQIxTus7JmIjxVaJZvfq/UsNoLy77r4dYX/XQdkgrkHV76lX4O/d+FznlBYcOmwqFB9KClXFaGhCOyt/lsxipe/h3iihu6s12bcxxamq3xb2EsUKB6fZa5t1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716099486; c=relaxed/simple;
	bh=rXriUzICpDBRNTiZbaNDcq7UfRydL6wZIv4JRQHCJnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyI8txgj+FU9/C+jtOGvaUP1FuO7QaFDn2pvMasMRhiarMrr8ph1AFqAcY2s8C240wI+WMivFsXfM1hOAO7B+JMz8bDn78PTgpHNY5yURPKJ3nbBrcGCkt7wgmL6ZpEMgVF6Xsxc7urBhygMg9MguU/fd3xtN+OqVRVExaAdmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnVvhlo3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62050e00cfdso13037717b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716099484; x=1716704284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXriUzICpDBRNTiZbaNDcq7UfRydL6wZIv4JRQHCJnE=;
        b=SnVvhlo3CjHIOaQ9pCFdqagXF2BXkVf6mbcpSiR0CfPomSg0bMZM2sO2MVVXMLDkPG
         rtizCVqw9zqVpySMWdMPtj1PhIjEz5834wbmf2CWzL+nUb9GidqA3hsgOkLa2x5yvSKh
         zIuOsgbkyq+bfBw9dJ7YKwAdWVotcfHrbvZV/HH5U1AlVEz2r/5bxB+LyHpOkFywTrVk
         Gz7EQBIILGtQZuZ+glXTQGHFCpT9VMFShNDlArZQA53pm5XoVfDBbEqlIwYvRG0n1qTm
         VaWgz81+RCPUwRl0NpvZtFOQ5AW5XoH5gxQ+D7ZTl+kqiKDwUL+raKHjaDkDOCpCo94p
         lrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716099484; x=1716704284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXriUzICpDBRNTiZbaNDcq7UfRydL6wZIv4JRQHCJnE=;
        b=npZxUP92lAZHw4XoWGCx5T/zQ0bJe7qt6YuR8x9fcmq/DGvVgjfeBrwm+4CnJYVhiD
         TAUfYru/EXq1Tv8pynuuRysAk9HLqxYW6iixM0qwtBB4PbDSY2MXg8xZQleWVEAaD6dl
         CP1FNtm71Pm4r/ra7kmLKX89+w1ikbBF1GQhzNMYqqqfsHHAYo9YHKvM5VpipqPiBIZx
         Cy11F3y4L8MdJsZaTZFe2rlgyPVzArV3da/VUq0y7J+NXh0e8Ve6PKc7+FzgcJlqLKEQ
         eBczGR2gfvm62+KJPN0sWnXNGVHY2Dmoasfp+SIf6+OP6zSTvnMEZOwKg8V+5M2CNZOe
         UNsg==
X-Forwarded-Encrypted: i=1; AJvYcCVvn/OGs9vWuhmWqbeblfjoy4JSZBFp13fS+wtWpxfDDAynLAfC6nXk9afiZ7APDPqrglEPpQpnz4BxfVEpAxt4be/qXTuElJy0Vn1w
X-Gm-Message-State: AOJu0Yx5pgs93L/6FuFONOFHZTq7TQLJSCyGkunerr3ZZ7lw/T7yPrjD
	izglR87KTojTvutRUJuvvqMRx3vkVhGdJBTje9VlAPLcvNoK2llb5P3uBKSeyQ+QXRBnZ27/6pv
	sxqaOMm6A837ZKCfcV/Tx5FE7N3b5F6ipQT0tew==
X-Google-Smtp-Source: AGHT+IFJD3Kq3vPuYgkMWKc7CO+LDFPu6iA9WZLK38fvfnvLK5wrb1/eN/GRsNfOPrluONXSLuJ9tQ39/0h50f+M8VQ=
X-Received: by 2002:a25:9d83:0:b0:dee:673f:7a29 with SMTP id
 3f1490d57ef6-dee673f8901mr20976923276.32.1716099484044; Sat, 18 May 2024
 23:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517213712.3135166-1-dianders@chromium.org>
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 19 May 2024 08:17:52 +0200
Message-ID: <CACRpkdY1hB3CABE+EJmkG6X2u7k=ETNB-7auC1EMxGui9f4JOQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/panel: Some very minor err handling fixes + more _multi
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Ondrej Jirman <megi@xff.cz>, Shuijing Li <shuijing.li@mediatek.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Xinlei Lee <xinlei.lee@mediatek.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 11:37=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:

> This series is pretty much just addressing a few minor error handling
> bugs that I noticed recently while reviewing some panel patches. For
> the most part these are all old issues.

All patches look good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

