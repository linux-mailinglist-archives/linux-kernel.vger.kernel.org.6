Return-Path: <linux-kernel+bounces-564255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029BA65152
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41641888D92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7323F418;
	Mon, 17 Mar 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmZkDjPk"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96A23F38C;
	Mon, 17 Mar 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218486; cv=none; b=BJ0WcXXr7HwhTgjUFUejLWBl31+CklUCfC13igpifhRaHE9pG7avHhRWsIs9XyEFyRg+P+Z2TB832C1HkBvLpTfNjPGSwp8lw9JOUoszmoTAsH/m+bvptdl7CHJF+tW74aVLIlrk3wI+yn8eUKaSwU8FW7GR28DJtgrgUe8R+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218486; c=relaxed/simple;
	bh=VJ+Z1kfUBwbn40YbG9rlTaU9zO9y3+iqV9Uwb36hGeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFd0/TMGcDqzLXoINaxUNgnnT92vex2uIbtrzJe5vUZ27l9rwXpEfyCXE5B2CVKjvM6omcObhuqS0ANGY7XfdSyNh5D5u4pWFlP/7zbJPSzrqBQwJYij5IoqIRdf+dU9alSaZeiBpQWA4PWcr7MZtEhK0MnyvU9q0aeI1DlCeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmZkDjPk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so2789928a91.2;
        Mon, 17 Mar 2025 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742218484; x=1742823284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ+Z1kfUBwbn40YbG9rlTaU9zO9y3+iqV9Uwb36hGeo=;
        b=ZmZkDjPkopKv0M4o0wCt7DCGYFW+3YO/9CAlXiKXrJTkgP0R2hUyfqxOPPcul3AaTz
         8z9oM6qgJ9GWodVo4EzFATvHKXqB+7nX/JhKWcmaPl2u5tK/laahyxJi4TrzwqztVnBx
         /XeaoncjG/ovgwWAwpNFYqxYEcg/HPnE+zGiyLm8TXjw5y+TMSWzqNaOaIXXNQnhkwxv
         UvPJAgu9MtZcjiutEZbf/LzM5GET8tlW6D//qPpJEY5DlL2JLW2f11uVmAsXunho0kHf
         BZd8+h4sUl3FLtxRd5CSEQved8dKPxwVDsXSX1E3IHB+Iuz+CBqAgz6v1XGt6sXXIxzk
         Ethg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218484; x=1742823284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ+Z1kfUBwbn40YbG9rlTaU9zO9y3+iqV9Uwb36hGeo=;
        b=cQg0HkY6m8dRSIsToTBm3kuh0VhOdk3q19G2FQ7ni3McqWDw8gxJFo/KrqCG/sZ3qf
         WfUniNiHdFt1rRfyfvmbDyoaVhndfEenlG/tc4duclzJVrc8gP/TBMNfhD6aUOFA/SsF
         7U0xUkEPUX7xpRdcuae1KpSy2xTSo9zsN9mWBLIxBPPrQC6dmcj7SoKv00en0DLRIWzX
         PpElq7SLR6CCBGOyzOGyArAvPw7v396X0flOcn0z5bTCBO+2DYhppYgKXKPplhw9W5Ap
         /KKjVV8aR4rplkC0R93+uJzxvezLR/XSp1/6j/VwYiP65f893cX6nomcCa91J3fJchCG
         XCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYv/+/1Qos/0HBDv2hn7iYse8eA7iii0AbXDGf/f9YN9rIDdy2m10s3/ynetVqMqbWRquRGxZNpnM6@vger.kernel.org, AJvYcCW6/Og13+nOSTH9/S5xFDW4xEwn44F8HJpPZxN5Ixj+aCs6qwcNL8Oy1PDmwxELaGZHtuZ9iKh/1Oh9DITj@vger.kernel.org
X-Gm-Message-State: AOJu0YxBl4Uq1rnOAv9gpEsPPsHHD/cHd7lv6o+nVwIEzuMtOg2W/wPq
	vYsBxPNXwI6NhYg4NSEeW0JmmWcov7oqkoRECSwL0zRUvdMhJuUHMmlNCtyyDIGcj1qXEzHpCSP
	i6IrEJzRPcEX3o0pkSZt6RK5zDQE=
X-Gm-Gg: ASbGnctUb8mTbN344O8eVA9Y5296tZfajt7Km4aJwdrZQDOIK4wXjTcMbGAbYNSK8Hw
	K/X0GmljA9rxyCE7kbovIDw8VXJ3/aqfmcmN24J8PNH6gBxjkR6TzxLteUvzlRQjx+iYZzhzkt6
	eBQtHjDPWaTYw6YbYbqwJQjzk=
X-Google-Smtp-Source: AGHT+IEeqZ0cJAHn3Brc0MOsXlDdCz7IeLznbTYmwKzft6JI2zwV4TEg69VCl0Ay05c5C9QobxSkS+DMqCY1QxY4NlY=
X-Received: by 2002:a17:90b:3b46:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-30151ca0bf3mr14263755a91.19.1742218484066; Mon, 17 Mar 2025
 06:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317111853.43708-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250317111853.43708-1-krzysztof.kozlowski@linaro.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 17 Mar 2025 15:36:17 +0200
X-Gm-Features: AQ5f1JoJB5F4azgy82hI2MMZ6wYjl0ACVtNOlaZnQbewllSkYy5wctWQcui4Ius
Message-ID: <CAEnQRZBorgPS+P8Yt8irKm=CTpbY3hUdkSpOK5if5xaTpzikuQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nxp: Align NAND controller node name with bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bindings expect NAND controller device nodes to be named
> "nand-controller".
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

