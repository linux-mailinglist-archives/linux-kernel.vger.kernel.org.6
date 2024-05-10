Return-Path: <linux-kernel+bounces-175764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDB8C248F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA4E28EF81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB816F828;
	Fri, 10 May 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlIJWvEB"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147716E890
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342875; cv=none; b=GmUmtR6g+31CdB9sKjdX6KaxlhbFocYyxvVXikr/FJDkbq13BAsL/Jo8rU7Ctrc2F60fn/+GUHf0aMbJ7le2d50Dg+oaRej54LB1T9+jjLafV9V7f36E6ctYA4QvgEWpy1iYZHRNfHRbpACa9pnNjjlr7+KvZvI/K8IBtc14KPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342875; c=relaxed/simple;
	bh=+rwSFH/zIjdRn0ZdlCd5K4VvXhbl8g2LjsMF51uWTXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orf6l7KyNLSoq4eG6xRQ7JsHeI94tl6lqpL/WfmkDAxbEo/CaVEZ3g0txqIXmmlaB4sL+eP+K2C1XtwU5NDfzAgetKzDZ6jltSkCBUUtPSkRjCaOkFnWSnJpcdbXPEt00RPDyYw/GukZ4TG7zsqxyfP50vrcyXy+ofUfMh0wTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlIJWvEB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so433053666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715342870; x=1715947670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXNTsezNdWYZnRG6QT+6065F4f+qKGd7L1PVmOIUWNk=;
        b=IlIJWvEBid6tQaUBNNY7c9LcsxG3oIhCsqiGNO4uYGdS+YKBGCip9MQNvlRttgZ9g+
         Efzrrf/TLll7+vyoPayi3kmp1WljMoCuCSHE+XolxpLxIt197pXw0DzirnPbxWUVrKxe
         jdNEMAuTI4tK65HEbwHpr49ziTIlg//svGvCIxa6PdXzYY7y2fIgK3SmibEdr5d/lHHS
         DG2fkDQq/ZR8IX1jeICDS/VhhHvWhxJyeqZwSG0U2hKUMGljXpPtr1pscSHcSpLpLnap
         HaILT3b9GZlRLPuR8YFTMyLc2UJc2t81sYX/U1qkCEanafJr8P/s4ws1JBNJLdjjX8Ad
         nN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342870; x=1715947670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXNTsezNdWYZnRG6QT+6065F4f+qKGd7L1PVmOIUWNk=;
        b=VNFkXhOBQc3t/E+V2Aix8ttg4mr3Z8eVWoR8KPxnrh7XSH3Oi3lzvotGNQXbOjlBvk
         4RfoeNmJKZ3lcjrrIe8fgr/veEr/xTFAccP80OyCtHKL0waLI+FT6SWhG55An4LoB7te
         jETZMg7hUjRt7kb7bFfIWoKRja2JUJrqQG9p8a0Kw+NObAIJpLzDSe4KNmIXWsRHGBwY
         EXvlrwEtfeOVo1bozNp7iIO5T2T5JUlRWZL3jW9CbZRzKz/1lGfv8GBW6z5tEiJIvLx0
         q9u4pbKoqPQXMfxxIA4/W23IOhJlWGbgGoTnuoAmrc/4LBbgCHk1SQCro3S+h1qjYjzn
         DE5g==
X-Forwarded-Encrypted: i=1; AJvYcCXprXoexTPOZxIEhNnBoNGBE2qBjvgQ6LTGX3fXjUwFGXrxlMDGGkS8IyICGD5rTvtZh68hxI87onZXhNESiIEgUQXqVtBjTbpyhY5I
X-Gm-Message-State: AOJu0Yw3ZFtwEUiJG4wn8dTGYnSfLZyYbIwgcTJ9npifnI0uV5IQVpoc
	eUbtIrLIF8O5MLwJlP6MTik8X2jZDvb4ZMsblrlbrxj+ehNfo27mEF7NDQNfvH+pFbwSG9TSmnh
	SAWDmtLWrzuJEnj4WqhjuyGL+nzdiMpATV+PDSw==
X-Google-Smtp-Source: AGHT+IEkHxt5s7tS/c4364g3R4A35U02lj+aw795XFRizFnPsmEQIe0dq0uquDwKAXYE18v7icvEqSCP0RKxgMk+VtM=
X-Received: by 2002:a50:9e61:0:b0:56e:23e3:bdc2 with SMTP id
 4fb4d7f45d1cf-5734d5cf9b4mr2375799a12.13.1715342870410; Fri, 10 May 2024
 05:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240509064336.9803-2-lvzhaoxiong@huaqin.corp-partner.google.com> <CAD=FV=Ugm+-ziY+8f93KOChvmkbf_MdxEOoyJP5WJq70m-aOGQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Ugm+-ziY+8f93KOChvmkbf_MdxEOoyJP5WJq70m-aOGQ@mail.gmail.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Fri, 10 May 2024 20:07:39 +0800
Message-ID: <CA+6=WdT=eoh+qc=O+YzxmugotZvkfcdXxiK4S9Mg++6EtR8vkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: i2c-hid: elan: Add ili2900 timing
To: Doug Anderson <dianders@google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Doug

Sorry, This patch was accidentally sent when sending other patches.
Please ignore this patch.

>  Also: other than the main power supply, there is no difference between

> this and the ili2901. If you actually do have a main power supply,
> then you probably don't need a new table. You probably don't even need
> your own compatible string and in the device tree you could just
> specify:

> compatible =3D "ilitek,ili2900, "ilitek,ili2901";

> ...which says "I actually have an ILI 2900, but if you don't have any
> special driver for the ILI 2900 it's likely that the driver for the
> ILI 2901 will work because the hardware is almost the same."

In addition, in the previous patch, we have made modifications based
on your suggestions. "ilitek ili2900" and "ilitek ili2901" use the
same driver. Upstream may not be needed in the future. Thank you for
your previous suggestions.
[1] https://lore.kernel.org/r/CAD=3DFV=3DX5tk0tCcDa+vLnu0aoas1TDWuqvkMzM-27=
8dOCX8K1gw@mail.gmail.com


On Thu, May 9, 2024 at 10:35=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Wed, May 8, 2024 at 11:43=E2=80=AFPM Zhaoxiong Lv
> <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> >
> > From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> >
> > ILI2900 requires reset to pull down time greater than 10ms,
> > so the configuration post_power_delay_ms is 10, and the chipset
> > initial time is required to be greater than 100ms,
> > so the post_gpio_reset_on_delay_ms is set to 100.
> >
> > Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> You silently ignored pretty much all of the feedback from the previous
> version [1], so I'm not planning to review this version.
>
> [1] https://lore.kernel.org/r/CAD=3DFV=3DX5tk0tCcDa+vLnu0aoas1TDWuqvkMzM-=
278dOCX8K1gw@mail.gmail.com

