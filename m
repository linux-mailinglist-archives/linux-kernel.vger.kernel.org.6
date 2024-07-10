Return-Path: <linux-kernel+bounces-247102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B552692CB51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7617F1F23C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7479B87;
	Wed, 10 Jul 2024 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwfghyZF"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5524A08;
	Wed, 10 Jul 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594130; cv=none; b=PoLbupFTqEteoMS1RZfua29X/buFv7rNy9KheeB/dcJnbd22HlpXpMtvMLcwIhCDAkwoY7Iy2KBb9HsPHgqe/E56VMkpcuHzqpgumKiTsvoUWHZsZZzi4rPXj03s81gkTJPTWv9dODQdA4hi4v990wGGqsUzG22YWldr2yUQX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594130; c=relaxed/simple;
	bh=d7E4pF3B/YC1SaQ5hGT1rdhUnlINXowoDQRGFU9KCU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQQQaaEdVpR+wsb5KZcq9YiYRBi8Jb/Ma8HYpd/oIVAYxz6W2GhQHU+9+VXncLs7EYAaAjnbfWhhCQoVIheKGi6kxZgqc71f6qjX6oj38MfVV3n4Kcz1rpEhne/BZnEkV9wtVCv2wzRNRySaBwfRtAg+qZ7nl0fXkstIJGf2wEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwfghyZF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so22610415ab.3;
        Tue, 09 Jul 2024 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720594128; x=1721198928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqJpJlQsOLg6grig5aAIY5nJC8Y497l/ww+yMkv+els=;
        b=VwfghyZF+hXmMZkI7Y9Ovha8lep8DPVrN7ig26YolElhVTFmUxmwvTqdyHDoYwrzBx
         S65ZR7Boo9jKxSXXZqNvlqPmrY5RoKjboCNVDeVtvcR+lsh6Bgta6+nayh3H0miwK+Tl
         2JAN3GxzfWoVMeBUEbbu9xe1J+O4OiNy1ujPLTiuJNzP3rHE5hANsZIf0VhskDP54OYL
         +yGz/x7wayAyB1QDW35xho5gCEZpmw7DqaWsPiTPyawXXbaaTyWzE8GDbhRTSxBjZScT
         +Yv5hSUOPT2MkxE+wyi/rvkNFps1Mv7P64lmbZXbYZmsDlYVvE0784mFrtZta2/48Kyq
         xq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720594128; x=1721198928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqJpJlQsOLg6grig5aAIY5nJC8Y497l/ww+yMkv+els=;
        b=tHhCKLHH9ROeDxxxdvEIR/04aABRbSaxcVcZMZQxxCEUaoT+RRCcy7zpYPFCjbTfn/
         xTeoWVo4e7BPcKPGK5jh/Alz9PqkBY73sbm8jglVxdCWmQZcARvBUmVTyXXVvpSQmSRD
         KAA6BLC9VT8V4yrG9BWnIPOBCFRn/drUEjV+fAXwXmrJ57CM0IjgVyy8cwPL5GBxTXtx
         r6+oNKn9Yy8b/S9VDP91eHvAFQktpyaMUv2q0TIS0XfizoTjuO7xQZYTDiqFUlZm2+i8
         m+CtfoY7KlHZFeygMpqO9s150nbK0Dc5SxYLDm2VfSzCmKgGY5w76uMaZXtXcLn6y4UT
         bzDA==
X-Forwarded-Encrypted: i=1; AJvYcCWk+WWUxsGbFSPFqMN9FlzdmAH++js8iWbMOU2mJLHHqlJuqZtnFeGgNCehOGDWfRiCYSLWsyanw1SJfhC6Cru6KeG17Z8NFwwzLEkt2oMAaL30H/jRN+Ro4Gzp1gmrBLhTuS9InAVc
X-Gm-Message-State: AOJu0YwTtl9FWGzsVFtR6qZ1IEIY8DebVuYGzcvTeFn5311u8emvjDVk
	TFwYpcevO7T4DYnRnIob18Kd3XgZkkFAjX88VyamVyLgzNASz8+XT7D+vxWwH6yLJRQfP87y2vn
	egI6r5I7/FNtlxEscUx00U3oTG+o=
X-Google-Smtp-Source: AGHT+IEXHEmoHb3TCymWx3QQxiI9X8NsPovHzCQ4rz0cdUtcFQXIiu6fSaiQ8WtQeUYBP0xVeQJ1acajWd3skRQPx0U=
X-Received: by 2002:a05:6e02:1a23:b0:38b:48c9:55d5 with SMTP id
 e9e14a558f8ab-38b48c95c00mr29939745ab.13.1720594128346; Tue, 09 Jul 2024
 23:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com>
 <232c2342061b17b9f750c4ad52b0766e.sboyd@kernel.org> <CAA+D8APumdP97QQHObF6NEw6jwDJRb+0R=aAjqftrX1wR170Yw@mail.gmail.com>
 <065ab85945db26eed25ea874fce92524.sboyd@kernel.org>
In-Reply-To: <065ab85945db26eed25ea874fce92524.sboyd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 10 Jul 2024 14:48:37 +0800
Message-ID: <CAA+D8AMvEVk9yLt70ROhDGzdd+A5C34611QnSyfbYr0OrLb75A@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8: Add .name for "acm_aud_clk0_sel" and "acm_aud_clk1_sel"
To: Stephen Boyd <sboyd@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, mturquette@baylibre.com, 
	peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:08=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Shengjiu Wang (2024-07-08 20:20:56)
> > On Tue, Jul 9, 2024 at 6:45=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > >
> > > Quoting Shengjiu Wang (2024-07-03 01:52:51)
> > > > "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this AC=
M
> > > > driver, but they are the parent clocks for other clocks, in order t=
o
> > > > use assigned-clock-parents in device tree, they need to have the
> > > > global name.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  drivers/clk/imx/clk-imx8-acm.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-i=
mx8-acm.c
> > > > index 1bdb480cc96c..a1affcf6daff 100644
> > > > --- a/drivers/clk/imx/clk-imx8-acm.c
> > > > +++ b/drivers/clk/imx/clk-imx8-acm.c
> > > > @@ -114,8 +114,8 @@ static const struct clk_parent_data imx8qm_mclk=
_out_sels[] =3D {
> > > >  static const struct clk_parent_data imx8qm_mclk_sels[] =3D {
> > > >         { .fw_name =3D "aud_pll_div_clk0_lpcg_clk" },
> > > >         { .fw_name =3D "aud_pll_div_clk1_lpcg_clk" },
> > > > -       { .fw_name =3D "acm_aud_clk0_sel" },
> > > > -       { .fw_name =3D "acm_aud_clk1_sel" },
> > > > +       { .fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_=
sel" },
> > > > +       { .fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_=
sel" },
> > >
> > > This doesn't make any sense. Why are we adding fallback names?  Is
> > > "acm_aud_clk0_sel" not part of the DT binding for this clk controller=
?
> >
> > It is not part of DT binding for this clk controller.  it is registered=
 by this
> > clk controller itself.  As it is a parent clock, so my understanding
> > is that we need to add a fallback name,  or change "fw_name" to "name",
> > please correct me if I am wrong.
>
> If it's registered by this clk controller itself then it should be a
> clk_hw pointer and not use any string name.

ok, will update it.

Best regards
Shengjiu Wang

