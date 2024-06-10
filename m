Return-Path: <linux-kernel+bounces-209003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF1902BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C261F22DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA7152517;
	Mon, 10 Jun 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD0kM7Pf"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85315217F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058410; cv=none; b=t1mmPo1cvdXFJNwFhcyCYJlyHFb6fqOPK+DtqJC3xPtf6+vWdGE+rdQXhc/yxLznspdxf377odp/G7Z0jsoNjNmB4Zg1i4VcZLi+UUF6irt29mJbxLAnXsD9VSpDqu0xZanS0mI9luWQWv5XWyvS9DczLFu+dxkMJ4iwXkDzicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058410; c=relaxed/simple;
	bh=UkdMo81OPxibP5QWCa3Q4ea2Hnlk2bNprAdwi0u0DcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLsXNhKaPmxPigcpeaeaF7O2R5Srysqq1GKVcEgaHR9eBAqhLy+oXNqqbMd8rNvZ8PN2qupBL8RTkoJ2v+taFvMywSG8izntmhK+C+H9uSWhfT4yLLUvENKmA8RYobO4u5uqDEhcpovIifYlLTaInOnAwaNllT+r8G/CD1abhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fD0kM7Pf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b0825b8421so5966526d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058407; x=1718663207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvmBLiFSEfvE3RppHoP2rx6eSDtIOM7lvuped6LOb5g=;
        b=fD0kM7PfigSdn19dZB8uDlta8rDKE7Mw4qDrsmc7WbziJTpBJ3iqQwLAXWFdozAeK1
         pQqszAxq/31ClC7QKsvwYk4tfyjlzD6ObjQKfNXwvaIMawWXfYl01yiusA3ZhJNLUwjl
         ddH6Z1FLO7X6XOFh78LLRJ4+kYuzFi1l/XXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058407; x=1718663207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvmBLiFSEfvE3RppHoP2rx6eSDtIOM7lvuped6LOb5g=;
        b=v0YqpfplRZDvmC/kTWCFfYLaOXjhQCLCwtFeFh1zR8TEMU8FlbEG3TOh/PUnpGKTId
         NwL2EGFGyBDmDqtZKnCVorVTQMsSOC2sj/GGqGZrC0j3BEPanH6AHxj+b2K79ZhVne2L
         TKF8OQMZVCLMqWenpL0sNMYjZLJn0oyBuKip3z6mUioSAZ708SiqIpNqq3q0LJUwiQIL
         0okp9VBcGxmEpB7rMnoROj/gGCh7daPzJoIUzkYPw6PRVtjLDEkbtbx/yA9RTFcMCfSL
         7IpjERLhnUAjnbCjgX4KaxIjg+mt1/vSwNexS0zO2qxgETPlcvMQJuUfG8SgQdpU3aW1
         HWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKiknZAq1uxwintR0pWoR78Fs12jv7gZqP60x7vlfsm+BJzDg03Cina79KrHiYfbeQ7X8EkbGkafXkUbdBWOxHrwKYXGgbx/i4+k2L
X-Gm-Message-State: AOJu0YxJo6/bVjofnndT3yXP924N43Cg9dS774MovEUsfNrtEyxsnEw8
	qmQiHF+TeqBGEvd0SBcg1xHId9je/2XkEDbqK3+vWe/0dFNwhnv8laj7S0QwYjVOy4mBZajUqMI
	=
X-Google-Smtp-Source: AGHT+IFk7YuiBVXgveBAIpzNTQtKCUlXDv2eJcmh1sHglHTA7+VSPZJZcRvBJJgsgFvUHdtesg0D1w==
X-Received: by 2002:a05:6214:3b86:b0:6b0:792b:5997 with SMTP id 6a1803df08f44-6b0792b5f80mr57706466d6.46.1718058406839;
        Mon, 10 Jun 2024 15:26:46 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08c25d7a7sm998566d6.41.2024.06.10.15.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:26:46 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44056f72257so122191cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:26:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjoutC++zOP8jF2v/2+fMIaGH7j8/sGsbHAwrudcVzfezkw6mV3VJMCA1LCfQUf92x2UHZVfzZdDkXgrUm57j7/eti6qrQs5Hnp2qb
X-Received: by 2002:a05:622a:2990:b0:441:4be3:8644 with SMTP id
 d75a77b69052e-4414be38780mr17231cf.1.1718058391072; Mon, 10 Jun 2024 15:26:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604160123.2029413-1-dianders@chromium.org>
 <20240604090028.v3.2.I3e1968bbeee67e28fd4e15509950805b6665484a@changeid> <554749d5-5709-c740-b05d-bd4957d1e8d0@linux.intel.com>
In-Reply-To: <554749d5-5709-c740-b05d-bd4957d1e8d0@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 15:26:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLa1pZv1gy7WONzThopx6RXf_8Uh3L0wCWdY6_Mo1KTA@mail.gmail.com>
Message-ID: <CAD=FV=VLa1pZv1gy7WONzThopx6RXf_8Uh3L0wCWdY6_Mo1KTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Stephen Boyd <swboyd@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 12:50=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> > +     /*
> > +      * This function is used to poll bits, some of which (like CMD_DO=
NE)
> > +      * might take as long as it takes for the FIFO plus the temp regi=
ster
> > +      * on the geni side to drain. The Linux core calculates such a ti=
meout
> > +      * for us and we can get it from uart_fifo_timeout().
> > +      *
> > +      * It should be noted that during earlycon the variables that
> > +      * uart_fifo_timeout() makes use of in "uport" may not be setup y=
et.
> > +      * It's difficult to set things up for earlycon since it can't
> > +      * necessarily figure out the baud rate and reading the FIFO dept=
h
> > +      * from the wrapper means some extra MMIO maps that we don't get =
by
> > +      * default. This isn't a big problem, though, since uart_fifo_tim=
eout()
> > +      * gives back its "slop" of 20ms as a minimum and that should be
> > +      * plenty of time for earlycon unless we're running at an extreme=
ly
> > +      * low baud rate.
> > +      */
> > +     timeout_us =3D jiffies_to_usecs(uart_fifo_timeout(uport));
>
> Hi,
>
> While this is not exactly incorrect, the back and forth conversions nsecs
> -> jiffies -> usecs feels somewhat odd, perhaps reworking
> uart_fifo_timeout()'s return type from jiffies to e.g. usecs would be
> preferrable. As is, the jiffies as its return type seems a small obstacle
> for using uart_fifo_timeout() which has come up in other contexts too.

Sure. I'll change it to "ms" instead of "us". We don't need the
fidelity of "us" here given that the function is adding 20 ms of slop
anyway so might as well return ms so that callers don't need to do so
much math and don't need to work with u64.

This means that I'll have to add a "* USEC_PER_MSEC" in my driver, but
it still feels like the more correct thing to do. It also has the nice
side effect of allowing the driver to remove the awkward
"DIV_ROUND_UP(timeout_us, 10) * 10" because we know that the timeout
will always be a proper multiple.

I'll also add a new function with the _ms suffix instead of changing
the old one. The suffix makes it clear to the caller what the unit of
the returned value is and we might as well leave the old wrapper
there--otherwise we just need to move the jiffies conversion into the
existing callers.

