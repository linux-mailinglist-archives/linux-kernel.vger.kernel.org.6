Return-Path: <linux-kernel+bounces-415781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959EF9D3C48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AF7B25F59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526751AA1C3;
	Wed, 20 Nov 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSLM67bI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1421A0BE1;
	Wed, 20 Nov 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107904; cv=none; b=S3mKEdLOvvIueNHnOgtbJDjk9XNUhEzMGY3zEa3J6wbm3ozKeixiitnZUcBGV6t7+H8LGHy8krN4y7NF0YQnPFw9q3+pVd1eU+1l5h3aHIGhK5uo4OGgiyUVme4ZUIfVt7LN/2UM3Y7Nx0p4PZCbMPNaNsWyiihyWiXIEThDJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107904; c=relaxed/simple;
	bh=9m6mTSvMbY55RNATfYzda/Ir2l7gqVQoQfp6l6VtBgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptVR7E55DpPx4hgBH/5uwNyg0WWmn/HGiYKAZkIFOi90dikqMjENav4w3qCk12YlFwuShlIGjyiSZX9pj6bvn75pR05gd03wJqlQiY6XPHQ7zqWwfWpCzc9ZsT5YchxSprVHX+FffvhcPw+ZIYLY46bA9bYdjO/QSbPThh11cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSLM67bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F89EC4AF09;
	Wed, 20 Nov 2024 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107904;
	bh=9m6mTSvMbY55RNATfYzda/Ir2l7gqVQoQfp6l6VtBgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dSLM67bIIFYMoUiRgVrE6M1rVc8WY+NP8Zairo5Hc0OeGzwwoDZm/MiO7WA2gzU0h
	 evp/q/ja+Zzf2mv2KQf2j2k/wQ6XaljvA8rz8LQ9bsgYW8CM5S/dDODi8RKA1u8Ql5
	 de1nfLnrYFyrQRxv082Kc4i0s261G/ZHzZ+ntd8NRPmAjnRIQjEZOOjTebao2mht5X
	 jg+oI/VpAEihcIulFbJnjmHigqwKT/UIwvBpPa5810yBrm/w43HLWN+D6dbPFneIH0
	 eDzrWGt3PvaZx+rE7tBFiLdv767ZU9uzp8MgQYDLe0DbreKd21wczNkYFOM0I1tUmi
	 PZLuLnZoP6MpQ==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3889bc7ec6so3989359276.1;
        Wed, 20 Nov 2024 05:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUcGyrH7WAU4LrY9y5QNuXVThk0wrlXykFlqP+H4Ygkkfwmz+mxgAY3e/xE/3IxHdC3Su1rhvNiZy/yEGJ@vger.kernel.org, AJvYcCUYU/QtS4gbFr19I2EJdJd7IBMLAJZVIC8ZiWdRop2KH6IkWHKmFDpdd4QbXY6eh6Qlv+xPlGcWFjtW@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBremTl98a5OYcjKQA/rIE8ornu44gz7/7reItLdj9BKR2HTN
	OgDDumvLKwtSEx2TdxaCYBnD5hc3yW65lhHfq8iFwUEqFC5uV9s3tJ7Wxj9N4+V4EDmx20O937t
	alv9XUANWgLpL6IKPSx0Jp4Tiuw==
X-Google-Smtp-Source: AGHT+IFcwkV6ydMgxFk41YB5EkLftzzYmqmDGjwice/c/i3Y5Agbyng39V9RyUpcsU7ffDvAxoG+cGIjjidoFoDdIR0=
X-Received: by 2002:a05:690c:9987:b0:6e5:bf26:578 with SMTP id
 00721157ae682-6eebd121400mr30868957b3.17.1732107903371; Wed, 20 Nov 2024
 05:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115193409.3618257-1-robh@kernel.org> <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
In-Reply-To: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
From: Rob Herring <robh@kernel.org>
Date: Wed, 20 Nov 2024 07:04:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7_T2TOgpk54Zn-h4DXQyD5ZzHAZKtULjQxiY_WyveXA@mail.gmail.com>
Message-ID: <CAL_JsqK7_T2TOgpk54Zn-h4DXQyD5ZzHAZKtULjQxiY_WyveXA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: baolin.wang@linux.alibaba.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	orsonzhai@gmail.com, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 6:14=E2=80=AFAM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:
>
> Hi Rob,
>
> constant-charge-voltage-max-microvolt is a valid property, which I assume
> was the original intention here. I've already submitted a patch changing =
this
> to the documented property:
>
> https://lore.kernel.org/lkml/aa557091d9494fdaa3eda75803f9ea97014c8832.173=
0918663.git.stano.jakubek@gmail.com/

Ok, thanks. We should apply your patch instead.

Rob

