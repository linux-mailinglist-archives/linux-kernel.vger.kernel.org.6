Return-Path: <linux-kernel+bounces-268217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC09421D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6291C1F2583B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD818B466;
	Tue, 30 Jul 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyLWFCLN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6D1AA3C3;
	Tue, 30 Jul 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372328; cv=none; b=fSUrjZIsfeEnuXVzKIbTnOUACaiRmc50X8XL2H72KaHj2Awn5PNxkfm/fGJtvPItII/oLKzNfMqqG10B8TpR7ZtNFP9QmwWk8x/y03Y49eJQzVTpqPZnBKlLtHrGeBpxHv84wDgyVjmASF6U5XPaBdbxBWp4meLqAtMuZMRyIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372328; c=relaxed/simple;
	bh=0YzjR5c0pbRE+19CcyJEhFSQ4FHcBF5tp1FQmqVJmwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No6ekhL/cJzvP5+M+z8k36DLDzcQYAicRNSUPYv55nHLwxD28cfyQc2rH2LN+I1vZb6MPdclR+l5axo0fNs6LyDETj+7iaKE7PQkALfMtufSlb2jLPOgRkh7HVswMW4BvR7epTUd7bSz7hntxdSKkf1wqie1BMuLm+rBKeThVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyLWFCLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E1C4AF0B;
	Tue, 30 Jul 2024 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722372327;
	bh=0YzjR5c0pbRE+19CcyJEhFSQ4FHcBF5tp1FQmqVJmwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fyLWFCLNqWakfsIiTBp1yll88fVMwPF1THhVBeRLKLjIrtMpfOaVoxfQED1CnDAWH
	 0HJ1g+iXRLh65REHUYX3Ho6299vGK+PZ3td1MFSDHQskAiADQJg7CNqTcLBACeAJCN
	 7RFguG8yIYIK15oAYGBMZM4uPL6UMnMHRXUBjc6Y//5Qvulw/HRiY/t3QfP1qfJQhv
	 oYLpsZBNT/dvWeAq4Fp6lVE/zOq4W+wFKWyXrR5nv1XXnBFDyqFxm3WiahQN9hWkDB
	 QBhqMt566uAQU6Hd41IeVqTZEGJTcl7N5hTDGhHNoO1kZ7P2D+EdfM6Km2DzwKe3Q/
	 l6a5Nc2og+KpQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so2317761fa.1;
        Tue, 30 Jul 2024 13:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+ZXqUc8xhWuVOKJKbdH9LfLrQfHx84zUrcTt8MAX22i+2DgHEHf6WT2qAyxjRviHUSmkiznT58cyMvDM0cUJPUbOX9t3T35C1CXo+LGfAoc0MTzECyRBm5l+r11PGHZSXTwsJhSIZiQ==
X-Gm-Message-State: AOJu0YxTHyyYHqyP0S2s3lfj1sYW26zwGDISKDNPj35ZmaLIqpx/IO1v
	N/VTDLBFsypm8A7nANZZJhWFZ0O5Qr1HhEDeDKWxVZPNhE+LY6m1U9KWDVq7huamEJa8PaDy/8K
	tfotxiqVRRHZo9116q4N0pQBFew==
X-Google-Smtp-Source: AGHT+IHc9H3vnbGCFpvTKGKhBwJPYc5iDfDwYOy/+05XyRg3TD38Wnql8ZYvRTzKUnyZjPdr+ZL/h3FO/93Ays/4USI=
X-Received: by 2002:a2e:818f:0:b0:2ee:7c35:d892 with SMTP id
 38308e7fff4ca-2f14790644cmr9297341fa.17.1722372326136; Tue, 30 Jul 2024
 13:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org> <20240528191536.1444649-2-robh@kernel.org>
 <b53e17ec-fec4-4cf6-9c61-41552188c670@roeck-us.net>
In-Reply-To: <b53e17ec-fec4-4cf6-9c61-41552188c670@roeck-us.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jul 2024 14:45:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLjy=X9_7=UiEwN-uO3+yuofv_xQcmr-1d00w5LuaWWQ@mail.gmail.com>
Message-ID: <CAL_JsqKLjy=X9_7=UiEwN-uO3+yuofv_xQcmr-1d00w5LuaWWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator nodenames
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, May 28, 2024 at 02:15:32PM -0500, Rob Herring (Arm) wrote:
> > With the recent defining of preferred naming for fixed clock and
> > regulator nodes, convert the Arm Ltd. boards to use the preferred
> > names. In the cases which had a unit-address, warnings about missing
> > "reg" property are fixed.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> With this patch in the tree, all versatileab/pb qemu emulations
> fail silently (no console output). Reverting this patch fixes
> the problem. Bisect log is attached for reference.

The problem is fixed-factor-clock driver can't handle 2 clocks with
the same node name (at different paths), and then the serial driver
(and others) defer. Really, that should be fixed, but I'm going to do
the simple fix and rename one to 'clock-pclk' in line with other Arm
boards.

Rob

