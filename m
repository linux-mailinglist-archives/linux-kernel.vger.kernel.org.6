Return-Path: <linux-kernel+bounces-189993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDA8CF830
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7391C20F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29A8F6B;
	Mon, 27 May 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4ClMU5s"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4C23D7;
	Mon, 27 May 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781507; cv=none; b=o34adsX3w8itVqbboUDxy0rTiMRFUCHiTqgkF6UNeDPKAxU+RKxAAOaBstd4EHur0vURQvL/ZO8J1S3pw2HDr7WDJSi/GZ8kmulUcRTu0KQ36heo3FB3Mp1YpVM1/u5GhiBQ19U+A5wRBl5sAopYewH5/g6fMlUCB2Kpn1LD6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781507; c=relaxed/simple;
	bh=tCjs5Eba84WyRbeea3rCmX7AOf6IYq26s/todap2UFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhOlLnNvzf0Y9cWCujj9L3rmsMLohqE9Mtx3+mddxTF7w8aZYOOZowmHD+m0esa8ti2HM+2VN2DkWpH8yJYn+tUPgbcENMcuvdVNeCSHgC3j+XY6nLzqhVewtHHTcbG/xqzXPi6HXyuxeGEBK3XG8BSvWLE41T/fHfDhazPCG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4ClMU5s; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3737b3c56d7so11266005ab.2;
        Sun, 26 May 2024 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716781505; x=1717386305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxnEZqeiz6E5KfZch5QPrkG1bRqZFA0h6HtEP1on5fs=;
        b=Y4ClMU5s3CpTXGFSZsTo4CXC+id/43RpgYo3ARfgjcB3jReJ7yFmc7gUCC1WolvK3D
         u4/pnm2q6/wf0um+cxyATzuXKq1tTS2gggIrGYo7UfErlTWcSAU6goDub9QT6M9mP10+
         lzmLzaIZrfqZF8AocoyUoE8gRo/qOLmTAwZ1Pj1OnTOb4sSZ/snArgtKKsfjIzgwov5v
         zbIth2VjlYHCihyHYPdFksuKpiph9//WyAj1RkvoBPU41SCXkeC1EFQxnH1lW+Z/Q2KD
         i2I350SzwzhkZccqOth+dGLnjXJ89/HdyRgnUSN+eOVzeJkkygvVNof8l6p6bhH0qvvV
         UkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781505; x=1717386305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxnEZqeiz6E5KfZch5QPrkG1bRqZFA0h6HtEP1on5fs=;
        b=Rn+1mb+Vc42ZZn/NFvcCC3lsfsIk3RFqbXHB5ArRMVHOy1+h/vpIPQ8bd2tTEjkXT9
         /cCS2pXa/wDUw9swQU0EAFGrjnKJpxcw75A5ZxC51nGnjNt3hIblkoba+me2MXEUfVwF
         VltUqP26Zzlev98ZnZSQFKCBH6YlWBb/3xHJEoYqpcOdzgigISHSaEZam3R8Q9M+dU0l
         MBt51uUpE2kbPgK3ERMeAeekHdqRn5AzWdfYo8mYmq+9CJzuAHdF7A3DEsze6zK+8i0n
         fwII7UJGXgiuUoe7AQ9LM3sTL+QpV7K+xhFvF4Haw3WbnsD9HCaq4OJzvOYv/HqwsoEM
         ud/w==
X-Forwarded-Encrypted: i=1; AJvYcCWfAjHb7Ph6ZGEN2j/ue4f78xftQIBBA3IuLEfG6fbPmQ1wCRZ6synKTRSEBZ8A0rjTLZ0YwVPTqMYIboHyh7JlwkSKcySRnlveYUURLlNZC5kPRKB5Rk5hKk4W3AnBjMI5dBFdOU6EVJvu761uyCzqkIOdVXziv9ZqEqf3P35zVIpVW8Ve5tfQzIjHJyMvNxMO7VNsz17vwhG7pjQqEeaF8WEH6A==
X-Gm-Message-State: AOJu0YyFvKyMneSAI1dGjE74HVwGPic5fqQZ3kiapJyLGNidH3c7XntK
	QK1kbfWUVDwh9nhupa17QvSvK+/Ap4T4JlgH1GDnbi2Y4Qbp2lWLltVyGT5th1WpSyU5wlbC5/m
	NUL+wbvkOG8Ztu0479vFa+Ydv9Eg=
X-Google-Smtp-Source: AGHT+IEQ5Inmp3v++358a6lbXEUkviSYZMCbFiCuAWuQtWjhewWpE404nqkXbPrvEpGYJ+8RcolCNtdpyxh58qpeWP0=
X-Received: by 2002:a05:6e02:1d99:b0:373:8e8d:58e6 with SMTP id
 e9e14a558f8ab-3738e8d5b18mr56635485ab.6.1716781504763; Sun, 26 May 2024
 20:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716458390-20120-6-git-send-email-shengjiu.wang@nxp.com> <9fe12ecc-c4c2-4adb-a62c-4c8fe91b6613@web.de>
In-Reply-To: <9fe12ecc-c4c2-4adb-a62c-4c8fe91b6613@web.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 27 May 2024 11:44:53 +0800
Message-ID: <CAA+D8AONWV7Msf=FbGa33ukkMLpySH+AZgO8B2O3fz8fhpJ5Kg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] clk: imx: clk-audiomix: Corrent parent clock for
 earc_phy and audpll
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-janitors@vger.kernel.org, imx@lists.linux.dev, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 3:55=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > According to Reference Manual of i.MX8MP
> > The parent clock of "earc_phy" is "sai_pll_out_div2",
> > The parent clock of "audpll" is "osc_24m".
> =E2=80=A6
> > Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
>
> Does such information indicate that the word =E2=80=9CCorrect=E2=80=9D wo=
uld be more appropriate
> (instead of =E2=80=9CCorrent=E2=80=9D) in the summary phrase?

Yes,  thanks for pointing out the typo.

best regards
Shengjiu Wang

>
> Regards,
> Markus

