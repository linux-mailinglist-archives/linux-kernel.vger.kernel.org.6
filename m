Return-Path: <linux-kernel+bounces-171628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA43E8BE6A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75048284DD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5216078F;
	Tue,  7 May 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnDutfrb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83691155A55
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093638; cv=none; b=ezE/P5HV9or7XaeFELvEY2bat3NaJemyFC8A7Uct2uWHwkL+ko+oIajEIz7KAUiLR2eKugSWFCuGuawMcuHKMv3p5cBJGwsvMCBRgl6B5U8VVoQxlwcWuCkIH64nsBzMfR31016EOYHPVSLv7jbMHjUPhyuLmHVv2x+JlWq3Doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093638; c=relaxed/simple;
	bh=R3rN9uuCSrcyQrLmqe+2GgL8E4NP/EKwpC06F+iLVk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVXTl+oi/2emhZinm9pkPK4MRXhx0RzAKky/rLpUIxRC+Ss6WNfTqyWsMFebYkwH66xKCS+pRsi5dw/3HK3k3afdOrwQYazYOqoaTDWrxEQIf7zmrcq57sqIzTcMJTPVlHPCcBzF3bCMNMmjygPqu5ZU8KNH5tKdIxAKTjbAzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnDutfrb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a387fbc9so807654866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093635; x=1715698435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8YKg7NkiQQzPDt2U04+751t+jIfci6F7qG1eD549Yk=;
        b=WnDutfrbn2hxldjCn6KkP7RuBq0/yYvfn7AQFlJWkTYPbCMfn9O2KhaFk8CC0YYLP/
         AS10+3oUahOjcOAGZV2H9LzUeVk6YIONA64oru6sVOq1uMJCKwBc9Q2CnfBoNBc3M1vN
         XbdiASNb2Od+6wNqrPeQa9WoejEo5KADFVWIXlCfOyI5OMJnaNWMAuXE15f7icG+9uvt
         44uzciAfAzldnY8h7voe6e20fUJcdIB7lUErFMpsujf9d21/d/3PM51HFx/yq7ll/yb6
         NtAd7e8P9BHoY8u6oDOk9F14xKve985MywT1e6gGUKN8H0VRoNLCI+16PbxK9WGuknOu
         JFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093635; x=1715698435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8YKg7NkiQQzPDt2U04+751t+jIfci6F7qG1eD549Yk=;
        b=pGx98kF5DC1ZXUvIyaE63lUP1aUxt6CLGzI8kIwvZg4CNmBkFOQU6KiYzCXSjJ/4S4
         aXuIT+jdmtBbdJdZ4zp/mmmGUnNBjG7hobYJFJHM+y5O0nbvG+XU7MVtcEzM6t3K5fAp
         oN7Q6rzyCJfWJQ6w4bKL30w/BRCITEpiQY4iimWWXkikilXxYonfyfH9BknPZcXe66F1
         BQS+WALeQ2YeQ9oSYEsGj5k95Ncj5mjVx63ILe/pInKADm8lOzL1a9fOmKtl1GQC4VYh
         7dH6NPfBoIqPo8riVU/Zf3WUyw+IL9YZtdG3A8m7LgLsDRzdLq24S7kjRX8IfKvAsCUA
         mp8w==
X-Forwarded-Encrypted: i=1; AJvYcCX8DpHb72ANfRChwBdF7jyXXCm7qJiVDBodiLlKzg+tzw4ABFCLDAU70uWl9ihxOx/0EDe5SwHpPCcqqsORhnS0JpEzIBBHXD+OPHEW
X-Gm-Message-State: AOJu0Yy38tDC5YYRE+xYV4+P9mwYrHqiRJxAfmQCU8eNFnRZ7N7yu9Ov
	2ARtEk0mqif+NE0zd6otjoPP6gW8LyGetGEtpOdSF3iZdxVGhqkAAiXodFAOFLZw/tROD6Sp39N
	fbWb2/ah28tU0XBJZbT7mAytxu9g=
X-Google-Smtp-Source: AGHT+IFJ2ytPT0Nj7uGwYAQ3jKNVVBO7o8DONColK6Cp7RSU+lk399C6rgC/Fd7qavxTIn7Xi0esXHZBYS89ODEfi/c=
X-Received: by 2002:a50:a44f:0:b0:56f:e75b:839a with SMTP id
 v15-20020a50a44f000000b0056fe75b839amr8760934edb.1.1715093634415; Tue, 07 May
 2024 07:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-2-ioworker0@gmail.com>
 <0B21BF2F-26D1-44EA-B5C5-D0D490BB90CC@nvidia.com>
In-Reply-To: <0B21BF2F-26D1-44EA-B5C5-D0D490BB90CC@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 22:53:43 +0800
Message-ID: <CAK1f24mmhd1FT_YBZ=N27pzDCmaL-NJPP50pdmp=CnVG1kNPng@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:51=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 1 May 2024, at 0:26, Lance Yang wrote:
>
> > Introduce the labels walk_done and walk_done_err as exit points to
> > eliminate duplicated exit code in the pagewalk loop.
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/rmap.c | 40 +++++++++++++++-------------------------
> >  1 file changed, 15 insertions(+), 25 deletions(-)
>

Hey Zi,

> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks for taking time to review!
Lance

> --
> Best Regards,
> Yan, Zi

