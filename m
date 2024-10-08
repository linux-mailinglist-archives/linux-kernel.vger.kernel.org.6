Return-Path: <linux-kernel+bounces-355719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D303995605
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BCA1F239BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E920CCEF;
	Tue,  8 Oct 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biMdAer4"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7D20CCC9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409793; cv=none; b=pxlLvfta02TrMajT3CyS42W0nmisoh4vwFcZqJen+Bye8F8hcFBs7AqKg+uW2kC8oFFaODKDUJXFNm93e+AiBmSnNBa4xvXufeiHfTSpXmJjLNYPmdY5+WkynoiULeLHVbPaVbvaaZ3wrhNaxz0pCuQ/hnp1X4WTvsaijhdscw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409793; c=relaxed/simple;
	bh=+gBLhV/8pOjSfZcRPzir2XGnMl5gybT6rPpUR1B+QOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWPefxN81mCbceXyWG8s4koIisZWGtCOusThZj3qNRUkhCrX8BYk/N3X3QTmT5x5AcJPl4MIvjK9uul8OA+UwGeS8RzEeWIWk8rnYHhf/83ah9MoRSXPBES+jih/eTpppIzdJrNkGW/2N5DLbY28n3zB3lp+yTU2kBEd0fsMkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biMdAer4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a994ecf79e7so374979966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728409791; x=1729014591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gBLhV/8pOjSfZcRPzir2XGnMl5gybT6rPpUR1B+QOs=;
        b=biMdAer4Cx2yAPQgijFpEpfLIRVQrJGFZxrVX27q8PdElilil00JMvw1e/btLbfbjw
         x6L3kBQXlfGhRMgbjfksUJ0p3jcPBuWsR2nmExFVPURV4YmTEAq9H0wmb8bmyTZMUY+C
         lqWUHguYXH8CnK/PcudqeQxx7iUczKahiCfrc4JxslqovU3kNA7nyR06T1O/y8MyzsJt
         pYP5aSj8XngsBSAvFHii2pptJSZevr9mKCP03lLxavdIezH0vI0afB4++kj5gqQCzcts
         cqJppxKQmq8A2AYqrskygiEHP1bAcDfGu7Cv/KCI/clorNQ5DA3oX0mUm5jX2NuXKOFP
         HUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409791; x=1729014591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gBLhV/8pOjSfZcRPzir2XGnMl5gybT6rPpUR1B+QOs=;
        b=ldgV5oe7QxKDI6AdC3p1ZdDvIP2BXBZi3D3GQDSZQL73WisU1nFZAzH1Ltpt9wbG4J
         HX6xIKxefVLPfgRsRqL76ldX+GrpjNN0hvfsW3AIA8w2vK1ztlWqWx1mUGAJfSZ1s2X3
         QSzPeSwnUJ7CiCwmyKsTyPjl/BS1KZHdZ6on9FsdxmPz798sSmTwNcLEqySG3m9FDbqM
         t9zivNp/KvsbXmh8aqsmUl3konYEuyt5PSjJZTojaM+NYs2B+Vjk4UranKQ6faoTVbt0
         k3Zeorj59nInUxhTaPuTxkhGJu1pIweQxtkpSurwWcMzBmQ9EoA+YFZ/T8QPd4TQJE4H
         z9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX+o80GhfvbCBqO+MuvjQZe+QpY7/F/6nlx/bo+gxLcLVnKFQYICqESJAilkjn3YCD1DqSffAWF+t5Xw3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9LsIP1VCDXWi5ygQbhLequq0DBcLBlT330/LiYA0wQix6PEU
	A/X2tmTGVJqdno6zoj4ROk+75174m5w5fD4uoH2hpQQseoFmxUUrgCJtbhoPNlpI79ZgxuO0KGF
	jJUWP5vpRiL20cyZIhVVNwvMQ1V0=
X-Google-Smtp-Source: AGHT+IFs4OFWnd8necVN44EwTbzT/gernOUIutEV7jHxWE1CCXH8dgBaeVh7t/xiwS6/ZU3BiRAeEHJ6eX57TGDGL2k=
X-Received: by 2002:a17:907:3da3:b0:a99:7999:281 with SMTP id
 a640c23a62f3a-a99799910bcmr258371666b.48.1728409790351; Tue, 08 Oct 2024
 10:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006225511.121579-1-linux@treblig.org> <CANiq72mAfL7Dukpav86hkjQstcWv2J6y5uRTiRQq2TXEg9bNZw@mail.gmail.com>
In-Reply-To: <CANiq72mAfL7Dukpav86hkjQstcWv2J6y5uRTiRQq2TXEg9bNZw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 8 Oct 2024 20:49:13 +0300
Message-ID: <CAHp75Vd+hciuBCEtvnChEEO9RzaZe3ATLUJ06f186Mgv2vY8gw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove unused functions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux@treblig.org, ojeda@kernel.org, andy@kernel.org, geert@linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:54=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 7, 2024 at 12:55=E2=80=AFAM <linux@treblig.org> wrote:
> >
> > cfag12864b_getrate() and cfag12864b_isenabled() were both added
> > in commit 70e840499aae ("[PATCH] drivers: add LCD support")
> > but never used.
> >
> > Remove them.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Pushed to my review and testing queue, thanks!

--=20
With Best Regards,
Andy Shevchenko

