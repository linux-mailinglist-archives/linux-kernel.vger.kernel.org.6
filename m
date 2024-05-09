Return-Path: <linux-kernel+bounces-174593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343A8C1149
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24F328476A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B482941B;
	Thu,  9 May 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvVVIbMF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569591E48B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265323; cv=none; b=tZB63IOjyQMz87UnFQN3isd2uWCiXmxglHsySNBIcwA9BumZBeiuGV2CAqrXStp7oqwC2f8LpY5UC4f6yl7OGOm+9gP8050q7U5fOCJASqblQs/ttZkQHgkUUpKKimx4MhQ8QgMHUntIw340zZG6exJWsiNQZuxXS9ofGUuQEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265323; c=relaxed/simple;
	bh=EntiUyXCDMlVzLn7liXIjJ9qVPEcZjbVhmx7J3iQjIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ171wVEz6MMEUEm1XcHBY7dQf+Vw9yMiuttX3QnC2mRYaDaGIZirMMq+EIwEzUSQ7Vv4zOVhcMwovpCWn5IVglT7A1wqTo2nyBUWcuV/+ABiJFh4ASEUT1qgzuA9+ilWX/YJ+kLNb/3L2QLnF56PUalftkW0JolKZbb+F6+iYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvVVIbMF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so85065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715265321; x=1715870121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJeFE0WuwLySQ0WLtZlpt2n7k4kefS+JJOJPYozhu9Q=;
        b=fvVVIbMFbhGMWOO7Z7o76Tg7SNCrb/QGR9N9TMjX2EEkU1CidhW44Rwq9BCq9llSCu
         XnU5hxa7Q9NAgrnn0RSwf8iiTdu+X3TzpTZh1/dIP06u87H9JlKMu8GizxYtqTHvdWjp
         l5VnPvuArfLsZn/NCqPsQDW2HyL3Y6h4B3H6FUe3bSwJkjTiacHn6afRsZSXxrX1G3i9
         B958fxe6bPrdT9W1aLgjTBi7c0rdke7oAkjs6whBfdQVASaMtmpoWak98dMZRVlSvkgN
         ni8sx8S69aXi49n9yD1KjvxRucMdhf+vC48Cj9wCmBnXDF7DHykWoIfoN5foK45BnqcC
         Wihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265321; x=1715870121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJeFE0WuwLySQ0WLtZlpt2n7k4kefS+JJOJPYozhu9Q=;
        b=CcpnoasAZrAc4TrC7hd9eSK3G0SOEJUKHNz238YAdjnxMrDlbQXEKhrdXTJiKajNiO
         BK657ZjFWArsgtLO1OhQzMY6Wl3GnAY9hlv/s3pRiyMxHP7VbtqaS1coy4h96pUZDRtk
         Sj1+BwWNxO/Cf6u9v7GlSRqaNrO6vkdurvLd6SzDf6ouBd7LHivd+P6SEd8EsZowEMdu
         GrpFSWE7HD2ImxNO5IkNl6mvCcRwilTSDFfht0uxt+khFkPNgffrcKWJwkgg+xLlPkGs
         7Wt3xx7+oIxhKf9b+hD2JPaLQ3BKbpuroAEesuN3A2AFHQEcwjcVQnlL0Of6vzRaPgZQ
         L/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX2fNzaX7jfkPOJVn0PEmvnKRgum5HHdYZeKRTtRyBr4IpiKdvttIbZw53p8rPlMCeowRfqIWXF7ceU7uesRHpnkYE7oyYKefXP64ZH
X-Gm-Message-State: AOJu0YxSsljJslMidZEA533OGkwLywe9cgG29jr6G0LRnQgviqEJiDRB
	nDtOsfjahSmU3amN4E5mFmB3DxMGxrCNfAj6pn9RUREJoCYQN1w0fCWJiFAEuGXjyFT5TdIwXkU
	Vg+Ilw8BvPoOE6fOuL48ERDRpJx11UtHQ7a7E
X-Google-Smtp-Source: AGHT+IFrxb8EZwM8awOjCJtuIkTKILys6t3R7G703AmTYA7D4K8O26Itepd9/edJho95LxphvCI4NfYSMfrG1KjL+Yc=
X-Received: by 2002:a7b:c8c9:0:b0:419:fa3c:fb46 with SMTP id
 5b1f17b1804b1-41fcc211f99mr1451285e9.5.1715265313018; Thu, 09 May 2024
 07:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com> <20240509064336.9803-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240509064336.9803-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 9 May 2024 07:34:56 -0700
Message-ID: <CAD=FV=Ugm+-ziY+8f93KOChvmkbf_MdxEOoyJP5WJq70m-aOGQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: i2c-hid: elan: Add ili2900 timing
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 11:43=E2=80=AFPM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
>
> ILI2900 requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 100ms,
> so the post_gpio_reset_on_delay_ms is set to 100.
>
> Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

You silently ignored pretty much all of the feedback from the previous
version [1], so I'm not planning to review this version.

[1] https://lore.kernel.org/r/CAD=3DFV=3DX5tk0tCcDa+vLnu0aoas1TDWuqvkMzM-27=
8dOCX8K1gw@mail.gmail.com

