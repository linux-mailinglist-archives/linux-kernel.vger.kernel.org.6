Return-Path: <linux-kernel+bounces-337007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CD984416
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B741F21734
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584E1A4F09;
	Tue, 24 Sep 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBZKL9BO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DC1A4E78;
	Tue, 24 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175630; cv=none; b=teqipd5TMzck9PUXMSM9luJq4G+Vk4pIP6PZvqKOUDTHFVSLZV34nePv3TDy8GYG5HYJgZIRdwO0ocCfOqtaSiV+IDV/hXLVsXbgf8+1ZvDkRbpc+Q6VR387aUqWowa0YiNLrGc8GB58d/DPa0QRIeuBJrEkuGSlmoECSsK52uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175630; c=relaxed/simple;
	bh=GbmWYbVrXDqfcKXu40KvK679jdBRGxlxANqdEUUoGXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT4gFgkbNBIEyTQu5owIW8QgWqIsktP99G1KbkOYZXRefzJx6bBRCj3TJT39nCrod8J1nJGCI1WPJVe3sE+W0JD+7rdiCCBDn0/F1lkgyA7BmTyCjR1orhHkGTSaWrFcDR610FzZLqQ9NU7B756dQq/xYlzlbwkVTdoPRXK01bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBZKL9BO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso211398266b.0;
        Tue, 24 Sep 2024 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727175627; x=1727780427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbmWYbVrXDqfcKXu40KvK679jdBRGxlxANqdEUUoGXw=;
        b=PBZKL9BOp5UfGeLwDwW9hHqwmCu6oFMl9Ju20im397p4mFlqmL0aMRL9OPk3Ut30aY
         TJ74AnaOSJEdamVqyE7z6UDdO0xpPzuPud/RfdYF5xAnnLmoWf0eYxfxWKK+qKiTH6g3
         QhcjDZXz2RfyiEkvV+LQ/0qx9R0Hng01/RQVRYpeBVU8/rNRafVw1LD8zl6s3L05gC7m
         UfKzq43HavSktKcBtUJBzabd0OkGhQw27VmDShkz6IjwXdePo+a0KzM00Ux59PSDB0aj
         PJCkD7S6N7iL4jmzj/D3kC+hyvZnXUrXpWgHjknOlduy6gekKyRTxK0LIwzshXFTHX+r
         F/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727175627; x=1727780427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbmWYbVrXDqfcKXu40KvK679jdBRGxlxANqdEUUoGXw=;
        b=kiETyc0STgkqSaiZ82zxCyjw37NABXK4NlBt4yHgzXfd8nV728NrSorqbQ5MzgL4/b
         D6+exHHoU764+FTK+OsLm6JOEvULtxt4NmwP3i73jCXlHGhfjtLM/tFYy8NKYzK+n443
         R0DuXVLRUX046Zw60gnqAStkEVHQEaD8AML4uG0v4utwCCW5f9g9C7brqmb8Brkatljw
         Km4PX6LN/JMrMoZNzGvHjFCO+wEIepOJCzuiyWCtPQj+rsPmDtypZ6Bw2TPnQeM8oZWb
         MP4yjAJgJAiCcjykVSG/xwkbzMLlpu2x6jJ8p1j6Fr5VUIaHIxMNk9duXulKlmrcKQrP
         XE/A==
X-Forwarded-Encrypted: i=1; AJvYcCURtGNZ90twtfLtrBfZlM5afNS5izhl5GI3k0RKtgABXwfh4vfbtI8MNko2vYBdc6G5oSICvWmv6drwjcAR@vger.kernel.org, AJvYcCX8HRnBq49wk9isGM1+0wYfjMrHvu+XSgqdslPs9d/oiH5o3NBV55yMuuFQPrEm7PaBoUBS0l4XnJR+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3mVrWZPhACnbNIh4J5tIlOe4xJqoBdS6BWeksYNqO1YmHbST
	fI8c1+crz+bLyth/Ww5IEYB/I5gEvzJZI2DvFPHSr5GSBL0FZDsyIywJUiCNQkHWIP+Yy/HkgSC
	qn7DklQ2q7KhKBlp3tLWfJCTCsT53qbGthaE=
X-Google-Smtp-Source: AGHT+IHuqCHZSGsKafDZKaGLwyJCG2HLKGG4gjq97V9usBaBNmiBz/4O+Luf8Md/RJg13H0HZ247pfcLB0mwwuTcf/I=
X-Received: by 2002:a17:907:9447:b0:a90:c4a0:9b17 with SMTP id
 a640c23a62f3a-a92c4810ee5mr311312066b.9.1727175627157; Tue, 24 Sep 2024
 04:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-3-laurentiumihalcea111@gmail.com> <ZusjwTdf90J3BMH/@lizhi-Precision-Tower-5810>
In-Reply-To: <ZusjwTdf90J3BMH/@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 24 Sep 2024 14:01:26 +0300
Message-ID: <CAEnQRZAdKdZbOgqBJbpLbfjtpwPt8qvR-hJkduuuw9hrwd5Phg@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: imx8qxp: configure dsp node for rproc usage
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 10:02=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Sep 18, 2024 at 02:21:14PM -0400, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > Currently, the dsp node is configured for SOF usage, which
> > is not the "default" case and should be done in a separate
> > SOF DTS. As such, configure the dsp node for rproc usage,
> > which is the "default" case.
>
> why do you think SOF is not "default" case? where sof dts?

SOF DTS are yet to be upstreamed. We use the DSP for several usescases.

1) General applications using the DSP using remoteproc/rpmsg interface.
2) Sound Open Firmware.

We would like to have 1) as a default this implies that Audio is done
via default
ALSA path.

