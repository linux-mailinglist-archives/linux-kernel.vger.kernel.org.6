Return-Path: <linux-kernel+bounces-354633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15944993F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C431F23A55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE171D359E;
	Tue,  8 Oct 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VuYkVGDj"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6101C2DBA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371443; cv=none; b=sNt8zw4nxmebm+eHpeGBwiuBeYcepJa9WLH/2iYIMH9nk3ZfZe7JE1iougCEDfnJCtbbElJLc5eGSSpWEgi7hJ5Ws0NUaOHfzL7a4gWsPwsgp1HxmO4sNciek8/Hm0Dh9NxxQD28abgZ7SIKRSVG1r6cPEwrjyFHVacs4s0GDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371443; c=relaxed/simple;
	bh=BPDeWWSp9i5LlUOnDAuUUB2xgqqYj8TgywJmLv174B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaT5KgRN/H8UjqCAbijWNMcR8C+zHX/wBgjiaM4NIwAlNuZR+tA3ik9pkv7Ar1dYr61gIe98a/CKaGcOv8RLPwKhrKqwbez0HkLOTiYfanpAXGneUp4HIMWmItfqwIqOOvJh7DJj7v4H83adCNFcQpTmcq5oOCloNcmz9anBRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VuYkVGDj; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a3a728804eso1535866137.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728371441; x=1728976241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi3QRDDwcLms1UvC8yNmkM/qLj9SFeO3lw18C6Sbfk8=;
        b=VuYkVGDjWtgMLYcQb8pHVA+wx5Qi6ojm3UGd4c+hliziyiCMiN/jYWVNkLzR/CpiWr
         dDiir/auZbZpGoAtFf3QLAb6d8J/3jS/ZXCugThTCmEagfpXcvCr/DuGnzFOjr4YTJih
         zlHZ2rdT+wkQmHgXg4rAhvfh6+XKVaOAkJxXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371441; x=1728976241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi3QRDDwcLms1UvC8yNmkM/qLj9SFeO3lw18C6Sbfk8=;
        b=tDDLgjFShf0bRjjNKor4WmB+mLVxhOnEBN/2daF5J+ylg9+1dvBpuJPBZvVMyj+Foj
         CUkQef0woo6hVpQwH6fLiR9ZN6itVb3YxP8dw3fL0mX9NyEbuj2Rb8XoWmTcwhepCKw9
         9EeniTYCHFuijaOHj+fcg+Bc8REYCOfO6S/SvIGc26KZQd/5KLHbBb5b75/8Uzn5G21t
         TsdDc6+cFk+7hayDeC7G3WJfloIZjjXJ3x8Ldtp4HNrZ4leuqw3FvqiUSGy8YI0zew7V
         95K2c0/0W17Ua+ggOqM8iSl/85Q6O2hSkgQ9XIy+2KqSCuhpT8IvvudC+VA/d8VluA4O
         D+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH9f2kXct9vTsW/zfnVeTcsWekn6Rio9bH/Q6xE6WTUGdzeLzoZBwxgpnBzAnBueEx9cpyZuUNQQqtyD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72pWE3bw/QcTtqQGgygSX45sqbPZvTBTDpRlEMWpYEjW54m7X
	KfcUeUqC53HLVBkUU44Ypme8bvTwnP+LIm94HTFNuKF4lOCR82J41/4aALcUXjeMlGrteBxL0Zg
	=
X-Google-Smtp-Source: AGHT+IFuWmzCuP585nxNUk1m9hY/rxz7ffYThyhqWYhG5v2xzOUGun5MEk3qvsx2gHNJMNwy+VBWcg==
X-Received: by 2002:a05:6102:374f:b0:4a3:b506:56a0 with SMTP id ada2fe7eead31-4a4058efe29mr9984283137.18.1728371441044;
        Tue, 08 Oct 2024 00:10:41 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a412dd8b3esm1386775137.14.2024.10.08.00.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:10:40 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fa2fccc2dso81223241.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9sCtXgBGUWCz0nxR2FZzpDH2ocAx6KUdR6h3PssqoAkItgrlCdy3paaQz2uuXa6XF2ZfaHzmN0QVtxrA=@vger.kernel.org
X-Received: by 2002:a05:6102:1613:b0:49c:8d2:8ec with SMTP id
 ada2fe7eead31-4a405745478mr7873579137.3.1728371439139; Tue, 08 Oct 2024
 00:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008053514.6800-1-macpaul.lin@mediatek.com>
In-Reply-To: <20241008053514.6800-1-macpaul.lin@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 8 Oct 2024 15:10:02 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngrsDxQ1Fe9xB_EevGbGB5nDoCB_n2oGb2VTLiv1vSsGA@mail.gmail.com>
Message-ID: <CAC=S1ngrsDxQ1Fe9xB_EevGbGB5nDoCB_n2oGb2VTLiv1vSsGA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix dtbs_check error for tphy
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Seiya Wang <seiya.wang@mediatek.com>, 
	Tinghan Shen <tinghan.shen@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Sen Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:36=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.co=
m> wrote:
>
> The u3phy1 node in mt8195.dtsi was triggering a dtbs_check error.
> The error message was:
>   t-phy@11e30000: 'power-domains' does not match any of the regexes:
>     '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> Fix this issue by dropping 'power-domains' of u3phy1 node.
>
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation =
board")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

Apart from this, can you or Chunfeng confirm if we should make a
similar change for MT8188[1]?

[1]: https://lore.kernel.org/all/20241004081218.55962-3-fshao@chromium.org/

Regards,
Fei

