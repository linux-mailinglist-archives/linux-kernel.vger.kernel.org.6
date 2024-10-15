Return-Path: <linux-kernel+bounces-365559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7699E463
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84EA283679
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D81E764A;
	Tue, 15 Oct 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMrk9GQF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860E4683;
	Tue, 15 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988940; cv=none; b=Xs4PLeDgZZEKbpxu7qCjSCxzHDKxT6jN71KFDqwZlMhu+QqplPGds4UnvXsehqQ6GlYYom6TmvrKZqgjX1zHNgH102hsWJapXabhy5RilXwyBXimXq5cFltFPpDKbcUcIeWzMyMJZQbqbrDWTpeAgWRAgkAPK1c1QlzeRCMg7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988940; c=relaxed/simple;
	bh=FH7d/X9CuvyhZP6sCLbIGQ0zX6yX30KlR6RuCyvamuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWyS5bJWtuOI58d1nQX6MPoMB1xls1ZHBb968jE6Zf9MyV+kp+Sp2ntmxpdVG/PO2I9xDXNMz0mhYzkQ+CJc0f7j/pJKiiC5dlSa2DKrACqi+Kxyd943CrRl90pFc43eYnbavCNBXHJTNAIpDIK+YZkXZu8fKrTI/feVGbGlHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMrk9GQF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28854674160so2128151fac.2;
        Tue, 15 Oct 2024 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728988938; x=1729593738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB68LbWblxezMxUH7QwjpS8EFZ8Nmlauv/XQ4sXwbQY=;
        b=MMrk9GQFXSq71Vi+XQ5uTOFJrcX58NZDgLEgqRKOPTANzW/4MrwGlGvYZHexSpmhJO
         AuzlPeGT0UszHUsky6FyRLApjczc3JQSunj5V/YrJKeRnsGxWZSqgCbSGuY07por/urR
         podVbRbeXgb9XOsTpN6DecraR6+92cYPTcXnQBV7ChTVTWmMZi/zjTlP6Z09LOH7+mXY
         /5JBx8E7igrbrDajcBghqlHkoq+qOZt5ZHQLjlniOBMNbI+5bjS3eiul95CRwWS7lIiu
         Y9yugh2hQSdX35Q/M7ih/43dW471gZaqVUrIH/fqz5mGq7ZVeb6GlW+Eipf5suqPC0Qu
         wnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988938; x=1729593738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB68LbWblxezMxUH7QwjpS8EFZ8Nmlauv/XQ4sXwbQY=;
        b=D1DnBxQ66fYyUNU8ReiPJ7scU868WBxF7knGR47HoGMQ9NaAl42AagsViPt/FtvMxM
         fKTaDyRMtZoIF20yBjJMHvGe+LUbcbta8BeGRZTflERBy8KJ8tvTXN/zX986IShe85xF
         m7qXay3sfWNXaHLixBHdeauqkycJVHf9GCK8KSqc7SD2p4U8I1v6sr4R529yKIvX6vML
         Z87YKxvfCEPklz5kslyfVQQW8bGWmyB3H5USEkMk9/VXM7Laut8jIAjO+bNl6ALxctLP
         nrWJAYFrxgUXjZMu2SJzo3AG93kn9KemqZdbjjFyJsyqQfELLpeMAFsUiLBTVGMOIaCu
         xCGg==
X-Forwarded-Encrypted: i=1; AJvYcCVoEMONthNC81ItYiZnPProC5AbWckBtT4lvHvI5dIhCTZdktDR2f+sPDhwwvFhPHNcQM1zznFkOFhuv8Rl@vger.kernel.org, AJvYcCW0aIk7HDNFPHtWzpa8FFzfymh4gGDHEA18EoiXMd3hEuh1NDTQ98r0drg+qkTNkyOkV0pA8oKq6gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyweyOudIq+LruV2W88DumeTPkFbKXyW4hoA4tq9xGG/Hl8ZX6r
	C6oN+XJI0B1OxvLtEaO8YPrdz3YhcMh1ME9BxlF/KnCO0DNoWe1EA9HNQzhEphRGLi1Zm9HU/oT
	4s0+whRAtE8aQWFvZ9v5J8llxuKo=
X-Google-Smtp-Source: AGHT+IF17xy4CcNCeiBvZ0w1+9jATnhSaJcmEDkiO1vwtsnax4UqtS9kx1WwGupe9DuvoKaSjRTLNWudnHepoFvXi6s=
X-Received: by 2002:a05:6870:9a9a:b0:277:df58:1647 with SMTP id
 586e51a60fabf-2886e01a9f1mr9695291fac.35.1728988938095; Tue, 15 Oct 2024
 03:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012171357153parWX6Has5WheQyGlP0kP@zte.com.cn>
 <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com> <87ed4isd7b.fsf@trenco.lwn.net>
 <22fde7ff-457b-4b69-b548-69cff915569d@linux.dev>
In-Reply-To: <22fde7ff-457b-4b69-b548-69cff915569d@linux.dev>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 15 Oct 2024 18:41:51 +0800
Message-ID: <CAD-N9QXKZvj1Yb+3y6R9-ZZj22HbD=Dp-vzwREunq+7T2pZbyA@mail.gmail.com>
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Alex Shi <seakeel@gmail.com>, jiang.kun2@zte.com.cn, 
	alexs@kernel.org, siyanteng@loongson.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, 
	xu.xin16@zte.com.cn, he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, 
	qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:29=E2=80=AFAM Yanteng Si <si.yanteng@linux.dev> =
wrote:
>
>
>
>
> =E5=9C=A8 2024/10/15 03:21, Jonathan Corbet =E5=86=99=E9=81=93:
> > Alex Shi <seakeel@gmail.com> writes:
> >
> >> Hi Jiang,
> >>
> >> Your patch format is still odd in 'Subject':
> >> Subject: =3D?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwa=
HlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=3D?=3D
> >> Content-Type: text/plain;
> >>          charset=3D"UTF-8"
> >> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
> >> X-Fangmail-Anti-Spam-Filtered: true
> >> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
> >>
> >> It should a English word.
> >> You need to send patch to yourself and apply it to check if
> >> everything all right.
> > I think the formatting is OK - the patch applies fine here.  I would
> > appreciate a review of the actual content, though...:)
> <https://lore.kernel.org/linux-doc/1add7be9-0da0-4463-a3ea-80e2fd99bd19@g=
mail.com/>
>  From the very beginning, we have reviewed the content. Moving forward,
> we will continue with the review process, but we would really appreciate
> receiving feedback from the translator, even if it's just a simple "OK".
>
> Alex, I believe we need to draft a Chinese translation guide, in order to
> minimize the review work that is unrelated to the content itself.

I think this is essential and helpful for Chinese translators and contribut=
ors.

We can draft one and revise it in the iteration.

>
> Thanks,
> Yanteng
>
> >
> > Thanks,
> >
> > jon
> >
>

