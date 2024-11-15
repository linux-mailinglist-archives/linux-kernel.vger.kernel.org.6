Return-Path: <linux-kernel+bounces-410174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE49CD5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE71F220F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8648414F9D9;
	Fri, 15 Nov 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToduCgdN"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB64126C10;
	Fri, 15 Nov 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640453; cv=none; b=Q3QkhxlSL0GdKhkpv/Kyy4cFKh2dbBndUIMG13tNsmO9pP8LHE74HYwl88SXD8THr5BKOKYok8QzhDmpLhX2mT2ncC8o5IVKNZm/DiMMhgp4QzcuSTG+rEKuY7z+t4k59z+lsYrBy+mzC8r8wnjw/cUXHOWXop3DACxxvZ14/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640453; c=relaxed/simple;
	bh=/l6IdxviicpZLYmAeqefRSiwgN5K0poQeDlPVgsCJis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxNHxTp1Gi6C5MEcZrIOK7BmLl2IGNo0rT99X9foMiS9xhHzqbYjLZgecbx6DaD1ymNhbJonxBs7QmOeehW2IVX7NnM8ycbS6UCGFZcIJfVpSbULP4w5icwImrG6NfUgnvrnObkxVNkJUhVIk6MJT8AK1/6u7Z2GiGMAXZekFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToduCgdN; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83ab21c269eso45459039f.2;
        Thu, 14 Nov 2024 19:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731640450; x=1732245250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCro3fmqeDuWdpLH9M0YZh3SiFmqpG56moMEi9XJsQM=;
        b=ToduCgdNLGNHaIfNeRSeQs+j6klXTSzzFRRz+eUvspxWHjjVdVUp34H8EZSREUqtOK
         awhvfqjWowRS7zEnqMSHoK+jx4t8Y102vz2bCAW08B+Wd/UTqxGgzzKD1ta6FOhMTyKQ
         gj+75ptmfkEz4DVz/BdIYcXV6DRpBEqg39/2ZWqVzDckDWqs1Oi06b6IXvi2whItjbSG
         kl2p2iXFndTtFYIr/rJvdv32EmzxB7a9tr/blSaNw1JPuv/PC9WCOw39vrhVLf9X1eU9
         m0iYF+tQY7iFH3udUOrwx1yUfzE/nHZ2MgvK9awLSJWqP9MCPK+yg8gDXuKC5AhJxHu4
         ahmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731640450; x=1732245250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCro3fmqeDuWdpLH9M0YZh3SiFmqpG56moMEi9XJsQM=;
        b=XNV8jwyIBjXH3rExOwGCMmbSMDjuW573lxO2ARNT201H15miSXiz177hoQP8DcQYtA
         GUxP6Y8aSAhtzMQMO5M/CZpPkskMEGvDnwVBjKJp1zNz/miA166bKZxylv2BuKXvsysP
         wwppUoQcTn5P3g6rPC1DOARVe28IrFBZeb8Af0wwPEJ96EwCEfZjM83OvTny+Q5hWcmO
         uMnVT6Z8eDil+er+tmqW8epNuFAly7Bzn4EMnarGaLIye/DaJQIS/qRl+pZlZ8DUZwNp
         f74h6z7ONIkI0Nzy41xu2GtHq6uU2qjou4UHn/M8JYmWQ86XO5GQDsGAK6nPGjNEZpIx
         EE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxwt5D8snOPqfjF5UUh9XiDFWCzV7w5MRjByNRBRWE+jHq3t7dqE3YfFPJi7tg62Op/GzN7rCYbphzqVZZ@vger.kernel.org, AJvYcCX+k3uS9x24wNk2DRXHv17H1OD0GtjvgYzWJKNEI3jRKk9s6OZcWTqwKj6XgsuQpAnWfXuffwrBDZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9og0KhpwiArQwGAgCR/YMwp0c+DWOqaDwzboikZSvi4qH9SL
	59SmGx/pS052B2p6vGKM54LVgeYW163lp2BwXtwdkYl0CBo/S0NjT23aDceWk7iF2Nfx7wb1Wqp
	jJJs9VYXA7CC69L0hXkh3afBYgVk=
X-Google-Smtp-Source: AGHT+IGakNHerU2OxullmdN7ZvD8921ch3v64i1UwmySjiuo3QMqELJFXW71OGYOz/AjpdHrTb2E49J9y4Mvui7ae/k=
X-Received: by 2002:a05:6602:1686:b0:83a:b645:c902 with SMTP id
 ca18e2360f4ac-83e6c0c9d09mr170610539f.6.1731640450207; Thu, 14 Nov 2024
 19:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007132555.GA53279@francesco-nb> <20241112075958.GA8092@francesco-nb>
 <20241112092054.GA18139@francesco-nb>
In-Reply-To: <20241112092054.GA18139@francesco-nb>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 15 Nov 2024 11:13:58 +0800
Message-ID: <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Adam Ford <aford173@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mark Brown <broonie@kernel.org>, 
	ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 5:20=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Tue, Nov 12, 2024 at 08:59:58AM +0100, Francesco Dolcini wrote:
> > On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wrote:
> > > it seems that an old regression is back on v6.12, reproduced on -rc2
> > > (not sure about rc1).
> > >
> > > The original report is from https://lore.kernel.org/all/2024042416472=
5.GA18760@francesco-nb/
> > > and it was fixed with https://lore.kernel.org/all/1715396125-3724-1-g=
it-send-email-shengjiu.wang@nxp.com/.
> > >
> > > Is it now back?
> >
> > I was able to reproduce this issue once more, this time with 6.11.7.
> > As I wrote in another email the issue is not systematic as it used to
> > be.
> >
> > Any idea?
>
> Frank, Shengjiu, could it be that the udelay(5) in imx_pgc_power_up() is
> too short and therefore we have such non-systematic failures?
>

Francesco,  it seems hard to reproduce it on my i.MX8MP-EVK board.

If it is easy to reproduce on your side, you can try to enlarge the delay
time to see if there is any improvement.

Thanks.

Best regards
Shengjiu Wang

