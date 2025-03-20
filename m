Return-Path: <linux-kernel+bounces-569116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10304A69EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F559460423
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF631EB1AB;
	Thu, 20 Mar 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR5mQLw5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D3157A72;
	Thu, 20 Mar 2025 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441137; cv=none; b=Vf/+q1rqhoDt4HoOVc0plWT9Ytk8NShbsdWfkT8949PQML+Ao8dYMKN734MxvlsgYntN5kXfysWRrZ8W3C8LyjuGll+pedAaUdBu4XVv46EimTjqkgEj3rt1r6bc17gWONhDdW5ggfFIs25uoihs0ipYR2M87DsPMeCWLPTYMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441137; c=relaxed/simple;
	bh=H7lnaBN5SZm6OkgoNmP24ilkdoieYSGpSoSXBz9EiNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVTbMqtwgRab41Vtgwl8q4jme06DQ7BEnVNT2tg9gYiJAyZdf1QAYVwiDOdGQYmm9BOYqSeNCT/OwYFX4OJdX6E/J6SrKNtBUApaQa5RJUlsBKFTyoGVKEXA2dSuUDZP9/ui09AzN7uXzjWQIQQr6rLS28Yo9yN+OpByRi9rMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR5mQLw5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso506503a12.0;
        Wed, 19 Mar 2025 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742441134; x=1743045934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7lnaBN5SZm6OkgoNmP24ilkdoieYSGpSoSXBz9EiNA=;
        b=JR5mQLw5VZ4adcw+hk8StnubjbCsvrI424Kws24/XFkS3B8DRjZPRs5m744DkTeCI5
         K3s/QrO9/Dt2gn0eTDRH3ofp2axOp0WiYODzDB6inrMnOpZ262F2QWLKlz7XLwwEAXDS
         csNy5y6nitpp/PDxOoUaqAUQp7nyAnij3J7IELtWm/NCYAd/RQEsoQi9cisTloHO89/P
         xoflydu5qgtmlNOSIFNWObl4RSMyoDjKv/AZtNT41XZlygI1QZLo8S3nztfNu77CJ7em
         N+4fS2PzqpyXWiLLElL2kxzMQ7tSqtXCMa07nYq3AYvayOM5VEMG2WP7PWz5MiS5F3Gx
         nXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742441134; x=1743045934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7lnaBN5SZm6OkgoNmP24ilkdoieYSGpSoSXBz9EiNA=;
        b=uoUORPk+QFAArhVz1skWQYLfo7Z7ZodeMA4540QWf/K+grB9V/mw85aYsJNdf1hil3
         kCh2Yz/DmoC4JQiEeGkZmRUpumu2h/zJu3Wk4C885NvXVSAVhMdznrrUDyNWNFnOVu1H
         GEM05O0tqhCAun/VlKN1RgYi+FLqVUZ4vygb9K9C+yJaDQDlFp9omrGokr3Y+O8Vnfza
         Ts/M8++5DA+GlcSZ/58aW+rZI8ri0tGgDtHIkxMbXfbR9HY6VMWJAz0pmL+W7gBMW4E8
         FuNb2gwqO6a+9yV8s55+sYif7JRK2M42e4hWJKfDfsjmTJ321yJun/j/RlY6sDyvduzq
         6SLg==
X-Forwarded-Encrypted: i=1; AJvYcCW/5h00RsJB92Q0eFfQvUKx9xpCaLI2z18nLrXMW5K9+tAMA9/B2/RNWRCT+3AhBlGne74rXcu1WO8=@vger.kernel.org, AJvYcCWmZcJbk7Suk86aDzvfpEWChrHvcAqv16Gy7yDSK1F+hW4svlBz8TPP51B2mcferPQUcQ2lx3OjHBTGF6ZM@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/bZbzaLE+mPG6GlEROqwC3HzfURk00ENpdBrrKKBsbRIVsn8
	4hZ2L/OrZpbOWSm+6B/E5QJ4SJ0ZkiqDYCp4XyBd3Q/ntVyJMRT7zFXHkW0VmEiginCy5ufbLa+
	3TNMajR9/nrldrjdYsokdhlZYKWw=
X-Gm-Gg: ASbGnctPFIZy58ST0/z2p5A8/EAfG+JyMcWdvjFokzsoaH8N6mAti5ZsrpwtXJeV4zx
	KNZbZpMTdvrrgDk3Mz0DUwcjRfZaoZdlgqi+iGeLJ2WxKEHChSQzyPj1/+co/KlnSwesBNv4kpH
	DKyzT0uPxAJQImeR/SbfghG8weeg==
X-Google-Smtp-Source: AGHT+IG52k4ca442AWo/QH7lQRw6KyfHF7U1QMXqi1uSwYO1EebwnJFsud5lcaJQAjQE6fqSyOUSA2tlHYQVzEDA3gg=
X-Received: by 2002:a05:6402:3487:b0:5e5:2c0a:448e with SMTP id
 4fb4d7f45d1cf-5eb9f1d2a6cmr1716099a12.6.1742441134043; Wed, 19 Mar 2025
 20:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319155237978a-_o_XXMLszvXPDlyRsb4@zte.com.cn>
In-Reply-To: <20250319155237978a-_o_XXMLszvXPDlyRsb4@zte.com.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Thu, 20 Mar 2025 11:24:57 +0800
X-Gm-Features: AQ5f1Jpl0KnmmzSMsJlg3wjX0rLTgUXiXWmaIE2JlpCps6TgFEmcyiR_mZhBYak
Message-ID: <CAJy-Amm4qkwffCAnOb8oz+24-jG-7NKT7zmfcNjrpyMtwmzyXg@mail.gmail.com>
Subject: Re: [PATCH linux next 2/2 v5] Docs/zh_CN: Translate msg_zerocopy.rst
 to Simplified Chinese
To: jiang.kun2@zte.com.cn
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, 
	yang.yang29@zte.com.cn, wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, 
	he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, 
	zhang.yunkai@zte.com.cn, ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<jiang.kun2@zte.com.cn> =E4=BA=8E2025=E5=B9=B43=E6=9C=8819=E6=97=A5=E5=91=
=A8=E4=B8=89 15:52=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>
> translate the "msg_zerocopy.rst" into Simplified Chinese.
>
> Update to commit bac2cac12c26("docs: net: description of
> MSG_ZEROCOPY for AF_VSOCK")
>
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: He Peilin <he.peilin@zte.com.cn>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> ---

Both are aplied. thanks
but a better way to send your patches as a patchset in one thread,
You could use "git format-patch -2" for your 2 patches, and then use
'git send-email 000*" for your just generated 2 patches.
For details, check
https://www.kernel.org/doc/html/v6.12/translations/zh_CN/process/submitting=
-patches.html

