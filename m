Return-Path: <linux-kernel+bounces-324265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D097C974A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CD1B2527F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71979137932;
	Wed, 11 Sep 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Os7oUNv9"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F0135A69
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036183; cv=none; b=PL6eXkpyT45Gr80Zw6B/BKqfYM2VMRslOc9AmJzvXE/WK4wzCnoNa8aZUhpa5wtju1kaLL8DLC8V07T6OLPafkFIkhIT43/mIHq4ekj8bSY1O61FN7/v9ziP100vZYDm548mi224Om9GQ9Hq6E+7Dv+PHktap888hOSJi25yLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036183; c=relaxed/simple;
	bh=oW66k3+QWZlMy+jN8zb3h81JKhTcgu/ndVePWG3x0Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QApG6d0sftxbf7d/Ous1dn0NDCfGkoeapnzPwU+7q1POgbYmeB7eZn6g8mqUlV+GHjDLtIZSn0Y629hNeTD1m7bdWlfylA/M8pAqnvXtGSlSRpoA4EB7yDIaFat6Fmw5Vrt4WXmRWnex+gu1Vg6RKHx66FHryRRo/Y3L4R0beBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Os7oUNv9; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-846d1ba933eso1431811241.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726036181; x=1726640981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW66k3+QWZlMy+jN8zb3h81JKhTcgu/ndVePWG3x0Nk=;
        b=Os7oUNv9sMhqPxzxBw+2/jkXuavL38IghQQbvXZdde8AS81R0uju3YvvsQ8lJRADTG
         kgsESUD8bgcSE9IJOox14wHaYmB0SQw8jGoI06P8+1w8S2oPXrgtfY0w3tpubso5pO5Z
         64AwW2soTVMFCd3iIDlbrnskbUgCAnSxBaJC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726036181; x=1726640981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW66k3+QWZlMy+jN8zb3h81JKhTcgu/ndVePWG3x0Nk=;
        b=X56IimMG+yPykjrzrwhwXGoftTKxRYdYOBIeJxSZR59iAFAtSs1FX9sU1MZywH0IJR
         IEvmgHj1NZy3sTAZ/L/fCQNatN4fZxbk9DV7qEymvoGqUB5rq4yZpt5yOW88tfFt4w4x
         Ajb3XkkshsQ2Qee3i/duXDhncY77qzYaTjnItglv9CWtF8bOTfTD8bEGTayy/FvJGXiL
         k89YrgfL1gwl9+dtzkc+LN4pm3CMCU7HKyjbzp5AWS3JjkY+NnrozwY3inuJUbwJC1Gv
         RypjYrQdylcjHItEei9G5h8BADxT5yImSppD1Evz829Jr9gGekybRQBQVfHd/V6x3HR3
         mfUw==
X-Forwarded-Encrypted: i=1; AJvYcCUdehodXdueu6m1QMksYneWA4JNOJ5A+yZGZJb6UOetH/zH5MRmTSH4yEBMKt+98cLhAwCF9AJT1+nS744=@vger.kernel.org
X-Gm-Message-State: AOJu0YznU8Dp5b9C05PvbdaR4oRZQh8C8iWgEPu5gWnhVho5fMX9UZh0
	ADfJw7ALacQc2KHrW4gd1JqI05dRny+JdC+HQo14U6ZGfZSkpkE6tIzDvldQZO+WMgzRbbulErc
	=
X-Google-Smtp-Source: AGHT+IFyeph7AxYfO+lZ6E/05Ha6wiYnFDLuCby0cgwphmv1oIzfCspTi8qD7dEtbqbBEGDCNbyEiQ==
X-Received: by 2002:a05:6102:1625:b0:49b:be3b:8812 with SMTP id ada2fe7eead31-49bde2587bamr14771379137.24.1726036181115;
        Tue, 10 Sep 2024 23:29:41 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49c16dbb3dbsm456998137.30.2024.09.10.23.29.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 23:29:40 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-502b8d7033cso1257069e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:29:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt7UoG+hT1hfbUVwOWlj7D6NFdMD/0wlEWyTL+Cnu2yHSga9ZrPpBp14Apo7JB43z1f07emXfdJi+7vhA=@vger.kernel.org
X-Received: by 2002:a05:6122:90b:b0:4f5:202b:6220 with SMTP id
 71dfb90a1353d-501e7798358mr12652144e0c.0.1726036180309; Tue, 10 Sep 2024
 23:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521095536.3869399-1-fshao@chromium.org> <9f73dffc48394e6304263ac2293a2b18864ae3dd.camel@collabora.com>
 <CAC=S1njnqrdrQqJZYQ7mffgmAUUxtoO7utZumED0dmX=Fa9+Qw@mail.gmail.com> <20240822142403.qz3ia26at3rxob2v@basti-XPS-13-9310>
In-Reply-To: <20240822142403.qz3ia26at3rxob2v@basti-XPS-13-9310>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 11 Sep 2024 14:29:02 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngw0h9=i_sH8BvUqi8hTt1JgyvO6Epq9jA2D_WmqRLQeg@mail.gmail.com>
Message-ID: <CAC=S1ngw0h9=i_sH8BvUqi8hTt1JgyvO6Epq9jA2D_WmqRLQeg@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Reduce msg queue trans buffer size
To: Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Xiaoyong Lu <xiaoyong.lu@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Thu, Aug 22, 2024 at 10:24=E2=80=AFPM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
> So are you going to send a new version for this?

Sorry for the delayed response.

Not likely in a short period. I haven't had a more detailed discussion
with MediaTek about their buffer requirements on this.
I'll resend a new version after I have a better picture of a more
dynamic implementation based on the resolution size.
Feel free to archive or ignore this patch as needed.

Thanks,
Fei

