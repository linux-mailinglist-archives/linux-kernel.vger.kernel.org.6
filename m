Return-Path: <linux-kernel+bounces-376962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639B9AB820
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B6A1F2389B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7E1CB530;
	Tue, 22 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr0YumDK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11B13AD2A;
	Tue, 22 Oct 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630886; cv=none; b=rgkyCexiHNnYkT84Xy9kKSPBhIozP7C4psqtjIPH165+xmmHU2sj+QF2QX/t1Ghd0TJ+po6qAqaeKl9G36PcIBEmTHoASP1Wv9tozhQoYHGd2iAHjw0KCW7kIbeQ2bql/lalrav/1GmEbXkZBFpHPRE7eiMC8S/+xCeivAOvg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630886; c=relaxed/simple;
	bh=/Eb8Epx6wfm9bBzZZn0HhtMt385+tm/cZYTfYX0sSRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyvDnKhQWgxqrmJ93A/cY2HE/6P7IWhFtNhs2fCDaPINPFajjnCylxvl68r9Jr6tbe2k2n4UjiEUXYJoD8UhCsynH3rv32hgmOY3pH2PttfbATbT2MSPFuOcec47EQ1x59ddlM/j6eQj721YVMYsv9suANVsIJSEQiO+Uk+qtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr0YumDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FC0C4CECD;
	Tue, 22 Oct 2024 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630885;
	bh=/Eb8Epx6wfm9bBzZZn0HhtMt385+tm/cZYTfYX0sSRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rr0YumDKrBJtuc86LhNq7CBmFKLJizJeRi0XHohygfowhFAPjF8U5idf9IlcIDzyw
	 I6Q/aDHzyKejDEZMvhx0Ysgb7+SCNviN+uNMkMarATVVDefl4SzO0VqTAd1t1xRp+J
	 AxV+ZrLZIdceHs0bSzJ1Q+9nhj9oIA87oBUYqWDQWUaRKI1eFH+sPhIGgj5ebde4NT
	 hyCqz0BwyjAqV8h3JGLlvEsvbISz/VjPF6cwkojh+PYWqc07zPkRa0RB7K7wAnyK+f
	 B0W2xyUimhtc8m/wXT1VeNi5HfHdVGUbVejL2eu7ne7FaBnkaMt5z3izJRjvLgw0O1
	 uzKT741p2Bhaw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fe76e802so7000349e87.1;
        Tue, 22 Oct 2024 14:01:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnvpfNFGFsFsr6k+rPW5h8T9+zoHJvDhznjtzsBSdv9nVCnGWgrGNqntnGn2daAS9iJnGH2D54IgRn@vger.kernel.org, AJvYcCWkiNdsVInMzrtprim5ZRW9Vo9YLIzRwf2rFr8lVgmg9dE154oYek/O2fNz7qaA6lGs2hL/iZLNW87YtbE6@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZoIf6k+gLzTFdMvR6fy7hNTye1aisYB9xJeg2uwRZydhspyf
	hETZJXIa5ivq60pw3UeQBEMoIPV2mfegXgrJT56XYUwz9FqV7bvMesx6NCqxD9X+/Xv9uFg655C
	YQQlqRUCz6aJiU7mcMl1/2xsoZQ==
X-Google-Smtp-Source: AGHT+IFMewjcXqmLqdhk0eJoJ416asx50Q53bJsigv4hfQaxhRgbhx/qVQoe8z9gkYT5WTjL4Lqcd1xnc8Rf0gKC4hE=
X-Received: by 2002:a05:6512:1583:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-53b1a315eeemr101458e87.25.1729630883921; Tue, 22 Oct 2024
 14:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022133040.686562-1-lukma@denx.de> <20241022133040.686562-2-lukma@denx.de>
In-Reply-To: <20241022133040.686562-2-lukma@denx.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Oct 2024 16:01:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzeLMd+buYBhp+UJEX9RiTQ92dWxXB_TYWp0fUkX0Fqw@mail.gmail.com>
Message-ID: <CAL_JsqJzeLMd+buYBhp+UJEX9RiTQ92dWxXB_TYWp0fUkX0Fqw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dt-bindings: display: Add powertip,hx8238a as DT
 Schema description
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:31=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> This patch provides the DT Schema description of powertip,hx8238a
> 320 x 240 LCD display.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>
> Changes for v9:
> - New patch
>
> Changes for v10:
> - None

Perhaps read my comment on v9.

