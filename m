Return-Path: <linux-kernel+bounces-274623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8F947AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFA282064
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D6155CAB;
	Mon,  5 Aug 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzBy97Zm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810514E2FA;
	Mon,  5 Aug 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859776; cv=none; b=ciRcxazLRlue4bmsd//2o6+rCUvUb5Q7VaC/35NtorN3nQ374PAsLhmjPx2Oe/L9Oc8R14hFFBDAXlb9MrYHnzT4ynNzj/6867taU+cTqe7qHpP2FQ0kadhi+tf+iBcptt0R37n3GlG3BXCACQba/hpFrvnj/b/aEh1S4OvjTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859776; c=relaxed/simple;
	bh=ogmJyvZfxTS06hH32tvpvQqedGk3fvnc27s7vf6JNi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s51NJHBt4xFdpCy3ZlZu8GAz/caqF1mKVD0Zi3jgYc7QWRV1Ud6NjuD3vNqHdAP80mDVC/5NOlLOAogiKbUudweTdxSqKhJ/pJXKwroD+ed24S8qJ6W3RBrqEYAvPsJM60nfDJcGQfGjlTD+n3VLP9PsbpmM2EQ7W3bID+yQSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzBy97Zm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef243cc250so19668381fa.0;
        Mon, 05 Aug 2024 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722859773; x=1723464573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ7lo8YqKFEMphHR81LMQMxm/RrbZDOgGObtyKf2yQg=;
        b=FzBy97Zm9iw4kpphKdnJRtRmStG02HPUhBIy0cC3w92k5+D4IlMSCknpxhjz/97gxX
         7WzqBn+owcA0f2uJKqGcz0VMZCcgCcdJBOAmlbToC24UbpdOpYkLQgu319Foqv4T17AS
         5Mk5fUAaZ2mo8wq5HUICTX4sz76JmyKbqbzQM393JFMxf32hyarATn5tnX7xzX1muKxE
         gSI428joa4e6ORs3Np9isVsWc70U2w2Dt/P6Fk6zgjnXjtiKKgOQEJ600BAq/lPFGNsZ
         JYb4F42qb/nzEy/0NXoLpX+DDOLODZIWKQxbVXAFZ2kYWbYsxOebz6ifzgLW3DQJ+vwa
         /+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722859773; x=1723464573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ7lo8YqKFEMphHR81LMQMxm/RrbZDOgGObtyKf2yQg=;
        b=ENV+diOu1xtTGV9mVMs7liuyHQ7h7KBAzL3SpMUnpIriylOnScdNqsCPuSPlPbp1oR
         huJGHAIM83M36Lu0v0Pou+VJKNkVh1Wy5uOS8CHwdPOZj8r7J1mzy+nlD5t03OFWb+mE
         rCuUTaLW1hTWGr15qHyObyWhoM/DNmpgWTGsFw8C9HmERn9ArW2l2iQ8tJLf6n9veWiA
         mooPJh2aZBWCY3y9STPUL4jPlZ07IV2QZMaBrkEGlkhXonA65FIeiqXgaDEMRsKBWuTn
         EXU3zChZXLF2Fev+wV8Zzfy2GDSX59kN25E8/Am11TH8RVphF6wG5v3v1uqg8CTOI2Ct
         VwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXDU157OENiJcYxr9Hs3HFsYfMzBevgXuWlqRb3E1lTaLqzo4TUbg7iqpRWWYlUi69Gh8CJj7ixRhvDd1+YzdgZ/Gmpyysiu01OP8R387jhuRO3BT8PXwD5+PuLxt03+usoH3snt6RkKA==
X-Gm-Message-State: AOJu0YwAnRe0PSgx14aI5JGZdLegPuK9tOJVk/XFd0HvRNUNCfZIHJMK
	sEb3BEnqtjXVuNRZ0Fz1LHi98OEgaQQ6WemU6b3HzIT76/9T+4hG+JdBh1ebjxSMp6nlKV/u0eO
	AKsQHmrZMPo5At5Ug+NRW+vUgNQg=
X-Google-Smtp-Source: AGHT+IHKQRB2DjDls5YqMHmNNIrRhBRmAg/WzIBHkG4d10FoiYze3cdrfQcwsmexvq1O9fFVw6vjs7v/P7nnuRyVTPY=
X-Received: by 2002:a05:6512:2811:b0:52c:ce28:82bf with SMTP id
 2adb3069b0e04-530bb3b0e3dmr4358798e87.5.1722859771204; Mon, 05 Aug 2024
 05:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804220411.180264-1-aford173@gmail.com>
In-Reply-To: <20240804220411.180264-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 09:09:19 -0300
Message-ID: <CAOMZO5DGB8LSvziHTCTEfM+hn2GOhhUA9juautRPibVK_a3qNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon: Enable DW HDMI Bridge
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Sun, Aug 4, 2024 at 7:04=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

> +&hdmi_tx {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_hdmi>;
> +       status =3D "okay";
> +
> +       ports {
> +               port@1 {

@1 without reg =3D <1> causes dtc warnings.

Please fix it.

