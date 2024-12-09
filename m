Return-Path: <linux-kernel+bounces-438036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB4E9E9C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB31163B73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264814AD22;
	Mon,  9 Dec 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3PqcUfy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAC5733A;
	Mon,  9 Dec 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762906; cv=none; b=GJzw36X4h+ALoCL/0TlsdlKBW0z0bMvHK33aUvXp0wD/cXXG905tpnTcdRG0T39R6oefcUeLc33GTzjTaOSygiu1L4o7ahdyTmqygEq4D8FC+YWqrTXb7+xrBcnKAiaQSCON5TVuaA263mJ0fuMK7r1XecisL656+6M0/24zdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762906; c=relaxed/simple;
	bh=cbi6k9Bc7Gd/b8fU8fGmkx0Qz40bgiMRK8ty+RVwV8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt6v/65Yil2Ale+K4x6FoDaXbf12LUec2MN278F0+fVN9kU+GAGbK3jrQQvEOLqY/iAU8bZCIVmwusvs/VPv6SlpSHW0QHnnbH+4LvCzh0hcIX+OOLSqf4fUSY4JuIlnMQJ+w31XcFh94ma+IjTDCNnF9wAebZnckO9weEcMOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3PqcUfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784ABC4AF09;
	Mon,  9 Dec 2024 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733762905;
	bh=cbi6k9Bc7Gd/b8fU8fGmkx0Qz40bgiMRK8ty+RVwV8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V3PqcUfypzA5J6c9XxLO17WWI0Ai4P+CvQgw6u2xvqJ8cVdVJpDkNNLUZM+evELBD
	 mILx7tGapCuE+QIqEIhS3zGO9bHVVv17eGqpZ1ahLLEYjadzXtEYlsGeSBKMMYSqQG
	 W5TZgQYRp9tnIpXg+A3vls1k9LfCrJbK1jChfTxSoIQ9k15Y6jt+QaqrHmQOffGiRh
	 K3CTeqCRt9HPdbyO3XMlwmWIqZ9jhvt1EZAGfgYn8cHGLacliXLugNrHuZY/rxELs8
	 wsA69y/Qk7dJgCW1C9UePQ0xHIbAFQzMNyrrE16bTlK7Y83sv3PkZx1g+9D4+uqK2t
	 ItRqPnPUF8Nug==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3a26de697fso1476320276.3;
        Mon, 09 Dec 2024 08:48:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHuvx4S0K1TD/MrWtiV8dmEYjf9okSQuDTGTjtKajDXSfiA3JBvNGT8AxZofUQiKIXR0rByqVTHk13nIiM@vger.kernel.org, AJvYcCXpJx15isEcKWySb0GgVmAdT261QTTGfEPc/2YC+nv1wUcs6xQZnMTgHswFYbWZ2XhsBD1OVmtoxj6t@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDEvKqpfJk8aaCkVHQDhi4lZD2yKeUIJLGNXgXEnfclJTcrlg
	fI+45r6dh3wcvTvKVwAqYstN601H8stCOBYgsFTkH2hSlfNKpGgvNZqYtz740iiwcSetuXeLtiA
	l+hRKtl2WFvRnhwxyAmYiYaKOtg==
X-Google-Smtp-Source: AGHT+IEyVWep2IfeNQaP0+fdSaPz7+aNxs+ZlzyBIx1DSeUc4rTWVPXmTco+bIOFvCQB0GKmtqHWtW35EYdbzGfpl7A=
X-Received: by 2002:a05:6902:2d06:b0:e39:8b94:16eb with SMTP id
 3f1490d57ef6-e3a59b2bf08mr816396276.24.1733762904715; Mon, 09 Dec 2024
 08:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com> <20241206-of_core_fix-v1-9-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-9-dc28ed56bec3@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 10:48:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvh5pddoVEgaKQvGth0ncgtC9AAGxMEiK__NiZKrjmxA@mail.gmail.com>
Message-ID: <CAL_JsqJvh5pddoVEgaKQvGth0ncgtC9AAGxMEiK__NiZKrjmxA@mail.gmail.com>
Subject: Re: [PATCH 09/10] of: property: Implement of_fwnode_property_present()
 by of_property_present()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> of_property_read_bool() is deprecated for non-boolean property, but
> of_fwnode_property_present() still uses it.
>
> Fix by using of_property_present() instead of of_property_read_bool().

of_property_present() just calls of_property_read_bool(). For now. I'm
working on making using of_property_read_bool() on non-boolean a
warning. No point in this change until that happens.

Rob

