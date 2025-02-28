Return-Path: <linux-kernel+bounces-538670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED84AA49BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B850B1885DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957526FD8F;
	Fri, 28 Feb 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW2yj7OL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98E26F479;
	Fri, 28 Feb 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752239; cv=none; b=ZLTA8njryTWH42w4KL5mCfSo0FiolNDzDx6DpTC4DMYdE4OuDMiqMV/Ysv35Qqbpws/FsW69LgqbMdsEtep6VyL+HT8i9WZtvkRLE2NwVFAbwUQYoIILdDWxteAxY39/YubnXCYAxVVifBVj1hXW7neJZOS9wBaH8vCED+0Y0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752239; c=relaxed/simple;
	bh=+mews4wqirLVd+SJ74CQGKx7psfw9QW6POpNvpoLYPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGckX+885oPUy1E9Zk6XWyvQj0oMb8TbZ25ggI50mYP7EOPIrQIeqASoflD+eKVVU7/mvZNZObl/LR98mvbPXXblNSl77aIs2luqmvLE5VictKqRbL58skLAww3oOOzzFU59T70LL8bi2Up1n8/NGvMSuPPTfJrthXLLV95yHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW2yj7OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA7C4CEEB;
	Fri, 28 Feb 2025 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752237;
	bh=+mews4wqirLVd+SJ74CQGKx7psfw9QW6POpNvpoLYPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UW2yj7OLDI5zuEJjYp9kTPkjpNgQ5I+5MZ0ngBbIdzWUT7pqtBF/VMUzWoOBRRxEV
	 l+ZuND44lv/fYfOZSZRdQWPfWdCcatWzjFS1YP17PrO3em6I3ASyQw0V7noEb/HxlW
	 InWuj0scBFOSBOpfIDLEEGEaAYDpBNiUEKjBtcVAplnG1SBZPFrsu3ogya5jJXEYBq
	 Tdhe757RdCnSrQBEfNFSymmt722b0CN0nyXuHQqFJfu+4pLQUHnwZTrJhWpw7+7WV4
	 k45eB0y985+vt5zBOzh1TwBi4Bj7PXS488BKzyxpZzQoJW1exvzdiJmyvqnda4R1rl
	 hw9hLPGt6KJTQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e4dc3d22b8so1553482a12.0;
        Fri, 28 Feb 2025 06:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDsf7qboDPEGN4rmx0wWZXcK/y9yf71lLaYh4Tsfyn0v2QN2KAiI6YX1zx/wMY61RuDXE5+REGhQchVaBT@vger.kernel.org, AJvYcCVjyx4e9GtG2qwEMOAzsV5RUWHNx2SQexX7FPILqivdPnUAX6xwJx/iJcGDSnxPE9QE28rM+K3WrQ==@vger.kernel.org, AJvYcCXosqAZWbhUyHKL4dWn5tOw7Xk21FhsvJA1gHmz9eQNlI0xhzdJhDONHL/wEF3rZK3Pv2JpMzOoDO5ntw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIv48UhpqGmL/u6OOeuj6nEHQWQPcT30s66sxo5/tjPou8dEs+
	jNrh3ub/GdITyA5PwPaV8G7ShaAKq+nuMbGUSstdekN8ioNatU9ViBkEHASl/h2xFW9zKDbx+1Y
	e/lMp350Clrhr/QI2xvqx+XmUug==
X-Google-Smtp-Source: AGHT+IHjthQkObX46y0x27qvzkeyln9C3sLlHRHU7eP7TpYLalIfwcDLQqE0mQgUy4ECwFqBSo9/JmpROBFMKVh/A3s=
X-Received: by 2002:a17:907:6e92:b0:ab7:b7b5:2a0c with SMTP id
 a640c23a62f3a-abf2620774dmr419749466b.6.1740752236146; Fri, 28 Feb 2025
 06:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org> <20250227030924.GB11411@nxa18884-linux>
 <CAL_JsqJOqKeDRuASWxCT=EA5LJbONpCX=Re8=XxKUbPToWy2Dg@mail.gmail.com> <Z8HCZQQLofaiGtpG@bogus>
In-Reply-To: <Z8HCZQQLofaiGtpG@bogus>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 08:17:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLePri5m_dE989poUV4auasAxFvgAiYuXVuZHqLcOBGMg@mail.gmail.com>
X-Gm-Features: AQ5f1JqWAly9mibB4Wnu0iSmsxkTmC_yUXZnPBFIrDHBvIgsef3vgrKT7bmbhac
Message-ID: <CAL_JsqLePri5m_dE989poUV4auasAxFvgAiYuXVuZHqLcOBGMg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, saravanak@google.com, cristian.marussi@arm.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:04=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Feb 28, 2025 at 07:34:09AM -0600, Rob Herring wrote:
> >
> > - The parent driver creates child devices. The child devices can
> > either reuse the parent DT node (i.e. set dev.of_node) or just get it
> > from the parent device if needed.
> >
>
> This is exactly what I was thinking to deal with the issue since this
> discussion started. I will give this a go. I believe this must solve
> the issue, but I didn't want to spit it out loud until I tried to hack
> and check.

The issue with fw_devlink is that it only checks the dependency of the
parent which won't be enough. When the parent's probe creates the
child device, that doesn't mean the child has probed. The child driver
might not be loaded and/or probe is async. I don't think there's
anyway for the parent probe to wait for child drivers to be probed and
ready. I think there's similar issues with the DWC3 wrapper and core
driver split.

Rob

