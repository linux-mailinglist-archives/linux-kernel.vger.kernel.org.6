Return-Path: <linux-kernel+bounces-353679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD324993112
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05A91C23319
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B681D932F;
	Mon,  7 Oct 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8m2P6sZ"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B51D88A0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314641; cv=none; b=kjkWCYbIgu8E8PeypkflYOYJ2bsktG5xB+MRVruXeDY0wpWuwjq5gIgU8V3EUqD/6mlyJif/jswVavp7yYz2Ada+ukzrhb6Oo7ty6qrMrz3WfKJ9B0JzyPn3+FNMfrIJjt5zsrxC4UCXY+BevkxTwJPZZVzMbkg1YiLUSsoQUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314641; c=relaxed/simple;
	bh=fPuYg8i4QEggqDnqakprNVU79uhZPjB5d8z2n+kb4OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mitMtcwYZkGniwdKvhqyw9uWCzYSvwT+eevPu1flJ7uODdGL/I2UBuwQSrf74pgdETiCLHYrCtD7mq6GbAdhaVzK1joQikgne2sjmJRT5B9VQHR3M2P3UVGbFJhh0oCEDXyVZkJPfPkpIUAyfsdNj8pij4MmpEFb4iW0zb2huJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z8m2P6sZ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a3a6334fdaso1320544137.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728314638; x=1728919438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPuYg8i4QEggqDnqakprNVU79uhZPjB5d8z2n+kb4OI=;
        b=Z8m2P6sZs1gWQ9iCgVGxCVRH8Vh5kRssIlb88DpcJJatFBkhAx+sRr2xG2lFciIdyX
         Kk2Jbd30du6EpEKZmFxM2xxgCeXHiniQf/ACPgD60+QcXinidkmliwovUGtOXiqgoW+u
         /Kj8yMSkOTTJacC7zY/WORcF9nL2gJnLkRmHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314638; x=1728919438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPuYg8i4QEggqDnqakprNVU79uhZPjB5d8z2n+kb4OI=;
        b=ta0wT11U+p6PtDTyOOIcOSwE8SgXBReIuwzoC6O0kxX7BEvoBIZ+ohB+QU4G1AemCA
         Q4Yixx62OSvznk4NEy06S9Mcj6+CXtXPgHVrpIXlJp+SiuP34eWpWcxCPJllUQv04iiK
         JeLWEzQkNC+pf43LCVIZD151KtRwRLoQAthiaFX00V6uDx+hTCyRmsJ7C7OuEBRwuPte
         mYIf5xsYy1yYv0B0d+koTw0Fo0Mv51hxJ9ZJG1ww9JRg4GyhBNigZ3ON0aFuxo783ipU
         wbXjXwFS7sPBfmnHRA2ABPlvt7D7i/Ftlqhs9VdJHo279UDFtfQcGeauj1esT8Ul4WUF
         skZw==
X-Forwarded-Encrypted: i=1; AJvYcCWWl2zUdUFEjw5F47RiiR8tE687dETqN++4zpFENcPW7jZaFuLYhEIcoBgShpIAxmxaDy2ovPWIOeDL6Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNGzNiQMp7BZ03O5Y8Xo96T15zBOV3RXyBcR7MOtqTt9Y6FnW
	193SB6hIbYezxtUKgavJEEWfgFIz8h2QkyZmhZDLDqFeKNAmoy4V7w5WnluYgD3S13Rqym8wjrg
	=
X-Google-Smtp-Source: AGHT+IHqSXgq4+IioFIS2iI/UWPXwLnlmJQgspiFo/MtQqnzNfKQ8R+59XUFhKNF7v1O3Rdt/qGgFQ==
X-Received: by 2002:a05:6102:955:b0:4a3:bd0e:b39b with SMTP id ada2fe7eead31-4a405786067mr6243956137.17.1728314638644;
        Mon, 07 Oct 2024 08:23:58 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84f5c8b915bsm946784241.25.2024.10.07.08.23.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:23:58 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84e9893c457so1425333241.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:23:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSrEaW7vW5uf+4ONAD9TRmpDJk8EqSBDXku0plWHdX9hhu6cXNRZkN9oahA3Pe7dNKaVV32jDC69AGblw=@vger.kernel.org
X-Received: by 2002:a05:6122:1d88:b0:50c:4efb:835a with SMTP id
 71dfb90a1353d-50c85448816mr7156083e0c.1.1728314637367; Mon, 07 Oct 2024
 08:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007024350.7878-1-macpaul.lin@mediatek.com> <381fcbfa-edfb-46c8-8ee2-1386af2ba4c4@collabora.com>
In-Reply-To: <381fcbfa-edfb-46c8-8ee2-1386af2ba4c4@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 7 Oct 2024 23:23:20 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj-hpt9CS1+_Jt8C710KDz1uYTcTS5qGqSZT9qmmVm7Yg@mail.gmail.com>
Message-ID: <CAC=S1nj-hpt9CS1+_Jt8C710KDz1uYTcTS5qGqSZT9qmmVm7Yg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: pwrap: add pwrap driver for MT8188 SoC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 10:55=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/10/24 04:43, Macpaul Lin ha scritto:
> > MT8188 are highly integrated SoC and use PMIC_MT6359 for
> > power management. This patch adds pwrap master driver to
> > access PMIC_MT6359.
> >
> > Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>
> Actually, MT8188 and MT8195's pwrap registers and code flow are exactly t=
he same:
> since they are, we don't need this commit (or we don't need it right now!=
), and
> we can just update the binding so that we can declare...
>
> compatible =3D "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon"=
;
>
> ...hence this driver doesn't get any commit :-)

... which is already the case. :)
See commit 040c3303f110 ("dt-bindings: soc: mediatek: pwrap: Modify
compatible for MT8188").
And the device tree is set as well, so it's all good for MT8188 I believe.

Cheers,
Fei

