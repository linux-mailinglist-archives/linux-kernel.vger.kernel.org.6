Return-Path: <linux-kernel+bounces-211917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310BD9058D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83657B25C21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80572181313;
	Wed, 12 Jun 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZ7rqg6c"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415317E915
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209753; cv=none; b=mIscUbKmf1Bte902ThJt1i8fT17wbUqSXYld8dXklIFp9yt+79bZ7iC3zfcpy+orNwfVdxt28PznKt7Oz1xiPD4zFwxDgvaIRgMi/N5IV+hAStFGAf1hy3VOVLvqm4eT3SWkeyaHKHJnkic++mgVeVD2ey3XGCLw5pa3ZX1Ijv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209753; c=relaxed/simple;
	bh=TRobG/Dgg8lfifwp1Xf05nQsi34ezrs9G7kZNro6PKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGM0yVvawB0Seo71nG/1JruqSGha510RqkuxJeXt96033DO5+s5gBrPipoaWqgo2oixMbqOmsXSKAON3YokV6Tm0ydwD1Tq57TkPQx3u1pcdhKUpjN0P/3fEe7+8emWBO4MZtp97cceunl6oSFqjVyxGeq6o2DrMWiIg+tID5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GZ7rqg6c; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so4736972a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718209750; x=1718814550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5KZuCOQU21ybYvWRh7CztdrCiHdcxNZjpnQYkyIhIi0=;
        b=GZ7rqg6cL6qQaRENwtkmocfuHFaGvQDXnNLXB1+VKRM5pIxihGmQ7aksBbMN4pPS+M
         QjiTfw60Wkdq1wuwdVt0L5EUWUgZGXALVzTwqFx+RupPAGuE3DY53CjTpKdeEYGm2pga
         KD2A6xifraQH3YVFIUjuAO3e1LMQjbnhgKJII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209750; x=1718814550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KZuCOQU21ybYvWRh7CztdrCiHdcxNZjpnQYkyIhIi0=;
        b=Uzqhi5U4qRiln7e14UmYAlqWCcNWgmXTLyEoH7MB6zrQlXWWM8lwp0GIYBWtr4/Y1W
         6MUqV9/aRyEzLcZzmB3G2RdmIzm7KbEEnxYN+7Prdcv3GIgCiXn4l/tmtFKdCU2r9ymi
         a8l/CJ4dG+THwP3e6XMLS3kRhjav/b7IH1hVUQTYQqyxz5PrZJ82DSsM7F2yvB1l9pR6
         nZgyKLuOtnfryV3ipJbA2cZkBHki9D8Ewm7Rt5vN9ba64znWR9VxH4VqSxeV4cb+sv10
         XV8gdgnobhfPQX301XJRuBlA3Ij4bsnpJzCK+4S5fpeyufkJ0KJtGVjyrqQwty4ECe/L
         Ah7g==
X-Gm-Message-State: AOJu0YzpuhtX7U2tpbUHVD219nl4s61/ymPVh6x2bf0uf+gO2fJokanP
	Vts8RMMAgKhZN332ityfOqBxYM7dUyeVBe9YNik2bTazgwJZKEIt2fOMHq0fkQVcSkPfyus8quC
	f/a3TiQ==
X-Google-Smtp-Source: AGHT+IF2Ca9Xxwx1//kON828sqKlFEXYquwG+Bu0CB8Xv20W/bwLQBh0w6m0EWYHo6Fj4quGHH3j4Q==
X-Received: by 2002:a50:c181:0:b0:57c:74a3:8fd2 with SMTP id 4fb4d7f45d1cf-57ca977e887mr1774444a12.21.1718209749733;
        Wed, 12 Jun 2024 09:29:09 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8492fb96sm5277858a12.11.2024.06.12.09.29.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:29:09 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso10451466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:29:08 -0700 (PDT)
X-Received: by 2002:a17:906:aec6:b0:a6f:5202:3dad with SMTP id
 a640c23a62f3a-a6f52023fb8mr14297166b.55.1718209748540; Wed, 12 Jun 2024
 09:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611145940.3879610-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240611145940.3879610-1-andriy.shevchenko@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 09:28:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMeTB9i5uZGoUMWiFDCYCwcfe6jp0dzx2OJHyeZ29pEg@mail.gmail.com>
Message-ID: <CAHk-=wjMeTB9i5uZGoUMWiFDCYCwcfe6jp0dzx2OJHyeZ29pEg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mailmap: Add my outdated addresses to the map file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 07:59, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Cc'ed to Linus, since I have no clue who is the best to apply this
> change.

I've applied it directly. Thanks,

                Linus

