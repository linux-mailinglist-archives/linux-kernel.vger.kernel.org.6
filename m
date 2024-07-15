Return-Path: <linux-kernel+bounces-252692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3C9316E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F31282860
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05A18EFDA;
	Mon, 15 Jul 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvna8mVA"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578E18EFC8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054068; cv=none; b=PIPej9OuO9TDTTEIVJLGOm2dpc6gmTdUshcRrPqJrqe5WVgdB9c26NlhFUTI9Fqb/1/Kgz2npM0FKb3PDINVzlIeLJNH6KJcpVU9dW5+TDXQMyiM3gjmoisgkJXpGeIh8eZvt9a4SuzuiFihf+FNqIT1VzMqa/0RkQy1wehMv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054068; c=relaxed/simple;
	bh=MB4rQjmug6N4wcn/SME+GV1BbTnQz1HQixJgvDFjtTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXZXL33DE+07PIb9JhZ9NgCey78hsh8Qjm0K3+GNTRMvwsz4FeTeCGlVHChwQe1YiOjQe3biLl3YzHBoenV9Q9bVC3IGMoI42WZajEOEGiy8JQNeH8/nbR7Z25RxBid1QDD7ff0LO9c8sZ3yH8rnlW5uRvGMN7095WnuFx7KdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvna8mVA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447f8aa87bfso604121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721054066; x=1721658866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB4rQjmug6N4wcn/SME+GV1BbTnQz1HQixJgvDFjtTc=;
        b=rvna8mVAf2thJQdKp5U8PP8f0UmyoEHnI5XA9I+zVVAEq4K9nM4xS+ZK9hfA9QX/eS
         AMEX+D8ELRX4vt7jRR3I39K4cPFX+5NX+feQlcjMuEEtcImhsawgNDQu25DIEL2YSzgF
         DFOm2bqn/JM2rIP1hqRk3CH7aJtVeDykJqI06OG/7UiqGKDsjJjKfjxPwkcoUWOfrXQ4
         nBQWG5L1nXRzap+AxFG5uZbTLkWYzC4Wmwibn+1rJOeqRy17oh1qkonYn/tlbnKTPm4a
         a/VvGcqY6Xf3acp6C3lpFtZ0CFzHSFf3ALMjb65Jm4VGLvu7vZIZZqOuR4TUPb0kVcnX
         10Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054066; x=1721658866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB4rQjmug6N4wcn/SME+GV1BbTnQz1HQixJgvDFjtTc=;
        b=UpFjuyu0ib0SbVpKl25vS+Nw0h6F6PNRzKw5YxGTwNPZnhZXhlAv/ye8mCfeLr56u1
         vUHVfk1iJ0+vM4+tlwrE3AiNEwxQAuZsJs2abvrTn8mhDEmzEs7XNsyllJzLQmtXXVSX
         6u/RN/V2CN241Hbd6LY2rTRfSjQ0btGU+YmFeA/i1kZdYAbgnuPxZ6szXbA9yxwL+Mar
         71G0me4PgvPFq+J/c9P7JWw3W7wrzOq1mwg0pjh4dE+FLaJnRp8pe8EUa2Q9NU6e+uYi
         j7wZS5WsPm1FOAXhnWw+pVTOnF6A4JeQDbMyhPROmAV50DCtl65Pxlc5cJhvhzZQqwy9
         Me8A==
X-Forwarded-Encrypted: i=1; AJvYcCV5d0mUoLSrIkp1wt0hMbtYKqVAQGCsu1gtKbiCETtdu+PmYgJkQftOUmIjsElJzsnzuMUy97tdEFzyazcM4rk0GvBbfMRUNgEzOYPg
X-Gm-Message-State: AOJu0Yyw/06GORKTNbwQllA5bs8C58z+yJI+tgXZMjDuR+6S99/3okSg
	YvqsZDD61sAYgtETxPONcDNnw4s83O4K0bA86F85UtEpsQ9NGwB6H3OMdU/oStU9Byr1hdSsvmm
	/2b0J82HCM5GybMMZiiI2iuMcPdS+xFzwbeDf
X-Google-Smtp-Source: AGHT+IHX3BUsteHRiWVEg9D4BeNaoIXbyh5/FHeFNn3GktcpmPw80Bqv38Kic6vZA9oZXwMEVS705n1HBIXsOi9XxDk=
X-Received: by 2002:a05:622a:2591:b0:447:f5de:bd18 with SMTP id
 d75a77b69052e-44f5ac8f6b7mr5296781cf.9.1721054066218; Mon, 15 Jul 2024
 07:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <CAD=FV=VHDksKiZXrauiipa3HjtK4sE5+dbmXmVfhFoM-RKQP6A@mail.gmail.com> <20240715-bunkhouse-freeness-c4367d3c298d@spud>
In-Reply-To: <20240715-bunkhouse-freeness-c4367d3c298d@spud>
From: Doug Anderson <dianders@google.com>
Date: Mon, 15 Jul 2024 07:34:14 -0700
Message-ID: <CAD=FV=UtBhbfAAx41WWpQspK6SpCh6W5w+ogqFxogPm3omMn_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
To: Conor Dooley <conor@kernel.org>
Cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, dmitry.torokhov@gmail.com, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jikos@kernel.org, linus.walleij@linaro.org, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 15, 2024 at 7:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jul 15, 2024 at 07:22:30AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 15, 2024 at 12:32=E2=80=AFAM Zhaoxiong Lv
> > <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> > >
> > > The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controll=
er
> > > has a reset gpio. The difference is that they have different
> > > post_power_delay_ms.
> > >
> > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.c=
om>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > FWIW things have changed enough between V1 and V2 that you probably
> > should have removed Conor's "Acked-by" tag here and waited for him to
> > re-add it.
>
> Yeah, good spot. I wouldn't have acked this version would asking
> questions - in v1 it made sense not to have a fallback when "they have a
> different post power delay ms", but now there is a fallback. Is the
> fallback actually suitable here, or might it be a naive rebase? Does the
> ekth6a12nay work with the ekth6915's reset timing?

Oh, good point! Yeah, it should be changed so that "ekth6915" isn't a
fallback. ...so I will rescind my Reviewed-by until that's handled.
:-/

-Doug

