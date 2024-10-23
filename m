Return-Path: <linux-kernel+bounces-377640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD039AC1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A66E282D22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76B15CD42;
	Wed, 23 Oct 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4aSsA6B"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855915B971;
	Wed, 23 Oct 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672336; cv=none; b=AhMjY9eYe5HTOg+v1ATLTXgOzLcqUnIpt/2lJUE8UwQr2SJkgKy7BCD0+ed8r+0lRFfebtbOjBZe1NFqptV51awVLXP+IQ6DQo0d/1YRJ56OveccnirTcBpxAFRUeDj2S2xVFCRzDS/0tQhX3z1C/4eclFhohXo3FrVsDlgwimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672336; c=relaxed/simple;
	bh=LRG87r0VABLxkfI0lUpZI+Q529UN7lZVxnNuLFx6BTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFVG0hSu0wOLri2G/QnKlSU/Yddz+Hffe4oP4neAtfWmK+3RaKDxqZHuT3fAbL9iFksmNJgou96kuaots5PWorC/wK4Lqx/JV+O+6CHuiYk8lU1ZfPXRttR4Uv835anm9WjwvyMHgO0uxk8EKto8xnIun2XRCNq5j+9cYWyqLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4aSsA6B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so4716897a12.3;
        Wed, 23 Oct 2024 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729672334; x=1730277134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEmrXSvmww7jDp3qvFyibvCH67UbxUU4E5AZdc+eR8E=;
        b=E4aSsA6BCBiaoMq6hK/ixn+vx/9et3/T/KOdS1pwRz+BaBVsL13BbELU3l1xVQm0mK
         k+v1RTmhSPYr8fkP3reTTtifPAab7EaARdL0/f1WcE7z37Ux1eSn9FWOXcn3F89dddji
         9CeGAS8/Z/fpX8jphlROhb0hY5X0hV8O7vy+7aUBxXF0soumD1Zy6hvV0A0wveW6KseR
         /GT+/MuEFd6BD5jgDtkBde0XPuCdMaul0fU49+aurcGE3Pemt20Jie9bp0HV9465uNy/
         Z357wvSxXC20sJmZqsZrkLkmuI4j82wO2r0WaJeF1F+Pt1IqTwFoXVdkjfO6/opVWGB5
         qwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672334; x=1730277134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEmrXSvmww7jDp3qvFyibvCH67UbxUU4E5AZdc+eR8E=;
        b=VqrOpiW7oMzWTWLjuY9x2rLLw22KKCeUCUdAi1e5vM5VAk4akEbbgImO3cogKKrZM7
         LTDTOG3PSBknQ+a6hy27I18x/pCEHXZADvrp5La5EQbz/sBkZ2vtxFcD1dF3UHMmH3p4
         8I8crTq9RbGMU9FDQR5M9zUmpDS18eXCubp3ohqhl1oJF+lj+ou3AUKakUlxSl67ITUi
         FLJ9QLJfisxSuxbdYfasbCq7rl/HXvvN9pk0ubTcWZIVwCjq7UQxgSxaie8BtVXeqdZ8
         WkM1hewjxIPaMb93N7aDJkdbz1qsX0QswBzcjr7qoqf0UfRNywVaMwOgiTTwz/0wDGUE
         micA==
X-Forwarded-Encrypted: i=1; AJvYcCWIU/OtJpVdce+LsGLwJCYvxYj4L2L+q0F4Du0WKtYekRcD/6OAhR+jsvOTyzm1nE/je/4vt7Nbsf2Z@vger.kernel.org, AJvYcCXkeyyTqB5fL4BATM1vAqeUuaseT7CxI6u/kiIHI624CESt96alg2G3SPCRqG5ge/9bk/NJIH8bzbFQ6LhS@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkMAKMhdJnD8wStevYsS7fsYMbWn60jnIpXMKIgJ25GW1M3XE
	h/ORNNcAWkllBmR0pnKrxnAW+LSiunKkQTTnyYilDNyuWgga0yWW/dFydiKn6UNRgVbPd8qS29w
	mSBrq20HisIuIE9OgQFWZQM3qtUnEC+0F6ZU=
X-Google-Smtp-Source: AGHT+IF/PItJtM7Ja7HX6Mi500IRA5tT5f7uvwsJaF5y5YyAG3PZ464sJ3qXFGk40Z+F5fIxyTIUHhmlzstAhYS6wL8=
X-Received: by 2002:a05:6a21:1693:b0:1d6:5f3d:4ab7 with SMTP id
 adf61e73a8af0-1d978b38257mr2467464637.22.1729672333987; Wed, 23 Oct 2024
 01:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022021230.2322132-1-jasonhell19@gmail.com> <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
In-Reply-To: <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
From: =?UTF-8?B?5b6Q5YKR55Sf?= <jasonhell19@gmail.com>
Date: Wed, 23 Oct 2024 16:32:02 +0800
Message-ID: <CAFGtgY3BJcpC=Q0cYZQa01D5BFAQTt6GEr=0_mrPGUntHYVioA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: yang.chen@quantatw.com, jerry.lin@quantatw.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, patrick@stwcx.xyz, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, 2024-10-22 at 10:12 +0800, Jason-Hsu wrote:
> > Add Linux device tree entry related to Meta(Facebook) Ventura specific
> > devices connected to BMC(AST2600) SoC.
> >
> > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
>
> What commands are you running to generate and send your patch series?
>
> The patches must be threaded properly.
>
> `git send-email` or `b4` both do what is expected without any effort
> required. Please consider using them, particularly b4, if you're not
> already.
>
> Andrew

We use `git format-patch` and `git send-email` command to generate and
send patch series as below, could you help to check?  Thank you.

git format-patch -2 --cover-letter

git send-email --smtp-debug --to=3Drobh@kernel.org
--to=3Dkrzk+dt@kernel.org --to=3Dconor+dt@kernel.org --to=3Djoel@jms.id.au
--to=3Dandrew@codeconstruct.com.au --to=3Dpatrick@stwcx.xyz
--to=3Ddevicetree@vger.kernel.org
--to=3Dlinux-arm-kernel@lists.infradead.org
--to=3Dlinux-aspeed@lists.ozlabs.org --to=3Dlinux-kernel@vger.kernel.org
--cc=3Dyang.chen@quantatw.com --cc=3Djerry.lin@quantatw.com *.patch

Jason

