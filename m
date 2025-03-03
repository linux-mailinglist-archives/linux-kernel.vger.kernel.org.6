Return-Path: <linux-kernel+bounces-542669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD3A4CC39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892AA17470D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9D233D98;
	Mon,  3 Mar 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3C7Fn64"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48D1FFC60
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031509; cv=none; b=MpzkKODR5k+2wqhPe+PxAeozxCGLLIdGDT36PKV5R+N8AfGJ19DlCiSBPZFkd13YRo7Y/rRcyZaDf5C2jIXyVieP2VphWsnhFDtJddN3mkLJ70zinzWLf2lWiLnEB7iMSkQ6onRT8zvAZIdfofHYs8YXgn5LjfCtr+YFZep8l8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031509; c=relaxed/simple;
	bh=GsQ4AlMHXflwhjl3qlPbMr5mgvvbV1JUiFvFXS4uYGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQKR7Y9L+6CdLUwhZwdh4+Ls0Jn+tXmDo99r72tZqGb7Kh69vs8X4SGd/IUjQzQ3OiWKnW2Djo8OfPuS/rhVL+OKIt+i3nkUBdVCqSoQQtXmNJC7gVGpptU2pS/UjUGalRWheAvG8Yv5r7+F7CLtDvjU1D1koc/pygo9zj4IFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3C7Fn64; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54298ec925bso7292540e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741031505; x=1741636305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOeEe/vKXmfGXFSe4NXDP7rT5PatmaYJmBeo1VUXgeM=;
        b=q3C7Fn64y2JLH/pjzso65AhmdA9PZr8/Mnc2Rbg666gGcfMoD7MELHt7Q4vqPovuhY
         3Ny89+/JGVfkJFUL0arRtdihgM1uqn9YUhr8Y9LLgx2Z2xK9IemRHM5BNt5sEh7CHxPA
         0pE6mbQY2hpnA0sxMZnE1JbH1LPZIXEjyjo2ey0AHOD1RtlwojmWmiQSTPVlNQbotq5I
         rfK+rGnb+D7uVMrGogozAimvBdxTPQZYTtvcZUj2eFO7DLCtnu5C8QFpaXJE1AtcECkl
         M7npQKwglNKyz3cB5J5kdaxLxc2lM2dX+1CPCUWvos/8vyEp1jeCCzYIHof1KIKU8BAM
         onfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031505; x=1741636305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOeEe/vKXmfGXFSe4NXDP7rT5PatmaYJmBeo1VUXgeM=;
        b=o4GUe7IeJ/lnLIn3eeQVmpLPUthbqWb65pbuaSSHftKYj00lJU0klQ5zZVEOzEw1gg
         kgdMaWpN9DxkqMTpJ44DYIFp1Mv8U+Gh9nhJV5HGRM8DLA4RUwMqzAoAlyvYT5ovAhbS
         si4sFG2rUhfGayhhdMpjfM0wuIiCcr4xWm+xR3YzWLC1VVYFRifFS7HLLFRmCFrvWll8
         TsmbWdK1TqZdgJ03In+rAHUhe1JhUNHyst3zhp5/+2ngmjUGR3DSwi1mm2amEkzht+cw
         PbVvZGO6cKo33aOQuPkUzy+CtC0McJxB0suxZ8IjxEZBcrN7UBSnwF1Ff9djZdw3KN2X
         YBKA==
X-Forwarded-Encrypted: i=1; AJvYcCUxTLPHii0cOp8ODBqXzQzsVp2qOUghpr3k+aMSLUZvS3vzopEx91l8J+M+F0By84fHxb75N1x6QLg5Mdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlXwVNuCzMClBGpd5TesiF1PilCo0g8fYekO40xx933sWVWHe
	s79zox9c0RjNhl+NaCZFC/51zvfiDUzAaUo3g89wkPAaREZtFXrVX+/0D9Eu/AVqxkkJ+EihWKy
	82Dx3aQqK0IUSVAxA+o7GeUzk7G+zykZJAKIqoQ==
X-Gm-Gg: ASbGncs+TVaX7K8x4XtvlX1ixG/DHNhY1ovPymigLSPMbnMmp1Ja7QCZK5thIyxTopz
	aOqWSbB1Yg2QuHUG/DVsqcS3h1zvgzUx1HNPv/i4kZCNVopD8DKOuuKkbdrJF6NaGZZXWPHVzHq
	tE7ovV4mPliKHXPlfBzdUFyiVHAg==
X-Google-Smtp-Source: AGHT+IFsGbvesnjWbfEk8+qcnhMhpwSK7rY1/+23lfk9h761ve12/onnm+C+Kg2oHwbcpQo6jWrgj2PsmOSffLjO+Lw=
X-Received: by 2002:a05:6512:124b:b0:549:7145:5d25 with SMTP id
 2adb3069b0e04-54971455f79mr1443819e87.34.1741031505444; Mon, 03 Mar 2025
 11:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 20:51:34 +0100
X-Gm-Features: AQ5f1Jr4_oqgGu33I-byOxU2dX3oyVoLqRbYUQ6KaoKwKXnjUNMYEaKqTtmoBw0
Message-ID: <CACRpkdbm5RQ-YOAaU7Mu2dyEjM12v8mP7rTTmW9-V5EbOPTJPA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] ieee802154: ca8210: Use proper setter and
 getters for bitwise types
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Sparse complains that the driver doesn't respect the bitwise types:
>
> drivers/net/ieee802154/ca8210.c:1796:27: warning: incorrect type in assig=
nment (different base types)
> drivers/net/ieee802154/ca8210.c:1796:27:    expected restricted __le16 [a=
ddressable] [assigned] [usertype] pan_id
> drivers/net/ieee802154/ca8210.c:1796:27:    got unsigned short [usertype]
> drivers/net/ieee802154/ca8210.c:1801:25: warning: incorrect type in assig=
nment (different base types)
> drivers/net/ieee802154/ca8210.c:1801:25:    expected restricted __le16 [a=
ddressable] [assigned] [usertype] pan_id
> drivers/net/ieee802154/ca8210.c:1801:25:    got unsigned short [usertype]
> drivers/net/ieee802154/ca8210.c:1928:28: warning: incorrect type in argum=
ent 3 (different base types)
> drivers/net/ieee802154/ca8210.c:1928:28:    expected unsigned short [user=
type] dst_pan_id
> drivers/net/ieee802154/ca8210.c:1928:28:    got restricted __le16 [addres=
sable] [usertype] pan_id
>
> Use proper setter and getters for bitwise types.
>
> Note, in accordance with [1] the protocol is little endian.
>
> Link: https://www.cascoda.com/wp-content/uploads/2018/11/CA-8210_datashee=
t_0418.pdf [1]
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

