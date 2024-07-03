Return-Path: <linux-kernel+bounces-239966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02B926751
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD220B21B95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C06186E53;
	Wed,  3 Jul 2024 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b3lMPF8r"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B818411C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028456; cv=none; b=OJKLl/yIN0/xm/H069bxV+Ki9Cz/FS1T0s4p06tTLO8x1jUCEeTwVLoHuMVchJlgFeLCl18+hNpMLcC5yFKnRiBU04Q8+Mid64aweuqEuCriUxv+4seExhxb5CSeRwiVBXJGxq4eBuYruRL2Om/FoNM1HGCwSAbdWWMcQACMysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028456; c=relaxed/simple;
	bh=OmJgZmMNMA+vqsqmuMadaQXQgXYtB0kLJuTl566s2uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F14/771q07sACr6IAmcIEf/4QPLb4lUD6JwJlPiNGX36cXzgKx/+zVYK7A4Otq+YjzRSctDwLLqMCvoMfJ5j/W7DFENbRP8CBOiwdZMvlXRJP05Omjc52nxGJOAfqC8be4TqAXN2cCLH926sD8FY1Y08qeXWIfF23SSdkv2xg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b3lMPF8r; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so69435661fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720028453; x=1720633253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNRq2xwEntheuQ6TeaPDnSkqCd5DNGo6bKIeeb/W6x4=;
        b=b3lMPF8rmDP6HzT1KqUaa4AIyeGODUdFmdFEe930WkPhjt+zguvrUa2VKj2HsgTZwS
         8xXbvZsX03DuveKTJdU/TATdffxAFCDBl9gw3Sn6trOqCZJFJhMdV4v/205EzKG0rMVt
         nX1noVjepoTyqstn5ResANwLuH/7GJ9/t7SqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028453; x=1720633253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNRq2xwEntheuQ6TeaPDnSkqCd5DNGo6bKIeeb/W6x4=;
        b=fycvEghhNVoDEjCZSUtQsmROzhL5TcV6xZFFcqcroYyehUnin7oTt4I8zqFxUBiiay
         eEKDcPA47rXGQyUtGrnoFllf8sfs8eWmzN2CWLbYv5f5KWTqF9s8HVdZbgVVr1ujM0JS
         X9wb3/uvO/QI6dFhn/M1Tdyf0+B76RsnNvA0DRQGEUqvwBJ05ZVxN2bvEahLw00CcTxz
         lZL60CAcloMFcoCsDe6FhMUfNCa1hOKgFDxj4Gd+inU38ob4RC3p6mzfndqAYSVUd2Bh
         qQpqHBhVPlFWGIbVhw6tcaPy1pyL3XBRex8My2f7gFiTcEGZeh7TWT8UHxds44tI4EHh
         QE7g==
X-Forwarded-Encrypted: i=1; AJvYcCXOrm08sUzntekm0bzLME66grheKLsS+OIVBNZ9iQigDLzo5oi9y6itquHu5ShWsktOdZQFFuUOiefZtLH5M18GgGT7+vnjhpdOf8Ff
X-Gm-Message-State: AOJu0YyDkTbLUqMQD3AnoDM7bt92JbhUlO/yOoXZC7ZL+zD7KYiNPxsA
	lSvH4E2o44/x2YFgmziyUrl139DUpuEtVKgIh4nuyAjAWKi0w88R6IEWlsjYqqP5K7jqUneIRB3
	gUtsAVA==
X-Google-Smtp-Source: AGHT+IHzlQ7W+2YV0g60NBy0164g66x433anP4Q+w1jSdUOrTSnFFMBchDsRcWdJNwtotlijdBipPg==
X-Received: by 2002:a05:6512:1056:b0:52c:8596:5976 with SMTP id 2adb3069b0e04-52e82701398mr8400278e87.55.1720028451982;
        Wed, 03 Jul 2024 10:40:51 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2f77dsm2211062e87.229.2024.07.03.10.40.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:40:51 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so63907971fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/3KWE+r/Xu8u5qlbT0Ib6vNpeKYLkX/9uBlWP1m/3pnAsbwja+sDXHejOU0f01hSHgqhSD2/OlHNY27GsOPBhrdPzdfY+1gAspqBg
X-Received: by 2002:a05:6512:ac6:b0:52c:d90d:d482 with SMTP id
 2adb3069b0e04-52e827459a3mr8256135e87.66.1720028450692; Wed, 03 Jul 2024
 10:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com> <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
In-Reply-To: <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 10:40:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
Message-ID: <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 10:30, Xi Ruoyao <xry111@xry111.site> wrote:
>
> struct stat64 {
>
> // ...
>
>     int     st_atime;   /* Time of last access.  */

Oh wow. Shows just *how* long ago that was - and how long ago I looked
at 32-bit code. Because clearly, I was wrong.

I guess it shows how nobody actually cares about 32-bit any more, at
least in the 2037 sense.

The point stands, though - statx isn't a replacement for existing binaries.

             Linus

