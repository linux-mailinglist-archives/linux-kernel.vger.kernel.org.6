Return-Path: <linux-kernel+bounces-254379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762B933277
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87911C22F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E523E479;
	Tue, 16 Jul 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GDSSXZU2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53904687
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159614; cv=none; b=Ji9A/JrxaOg3iyOWr7yU8qnX2H6pMBT3ZHijeoOgDpT+ekbjmOTcmkm3ePGZ+6Jgb6BIAAraWNBwVCrv7GbyElkWQWfSBfuhJJASuJqQsdHyPM2a27royDNsqpDjpDZjKJmPSNBzkulUvMkztmuFM0TI8z4PgGr4MZzy1Zas68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159614; c=relaxed/simple;
	bh=pRo6AxSF1IkxJPz6dpDv3Q0J4euZWx7rRoL63ppWOT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzhV8PdtMHCCwS2s9xJXUkh44oLymf7jUfKmgjzoRV3IVA3tGPoatSVDhSVOHRmbrDKXjNG61yDvaPblWqxQZhP85Duo43n0lAslKuh9BW10SLWfhzRzr1yqsuplH5ukXOMoNPiGSRSA55MiNHMtBKvIJxb1Ymhh8t3HAoaMajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GDSSXZU2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea952ce70so6310420e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721159610; x=1721764410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9A04c1sCzDtDJHwgWZ25LKwlEh7gHT/ykOd5hucUk6E=;
        b=GDSSXZU2BbEBFOwAoGp22qTGk7N9+Ysxiv30Nan7Zy1uw4REu9KXVfWbSrsOn39kNC
         LZOPAxXIs9p/HAGD/dZmHWvOFJl3n12tzEsGq4Xm3ws9gmz8tmx232cs3H+yzMudXRoa
         X1JQS7zt7TLAqGnSoIlSFbHLaO133l9dPfv+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159610; x=1721764410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A04c1sCzDtDJHwgWZ25LKwlEh7gHT/ykOd5hucUk6E=;
        b=d4mA0TjebDqB60mz8vbyK4SSseEGYbTapvDiWkNSVTIxj1fIRgyQxjUq36taKffvZp
         DrQDXGl4xqedazoUkumKGsLO25rRSkmrReTYZ5rLVKUYNkbydTa7t7O84pvcHjxP7Tzy
         nw/5jsUqJ5gPEkPPwgn+rx9q7irbkw3s3yvtCiTTF1ja5+OgQszYR9OviXEl0SsUcuuc
         YOJJBvxWAYnU9hcB4EkiF7x5/KL/03VNNssjkEKHMVlTMH8XlAPeuNvlfBWcLAnPnL7P
         ywB7lb/bnyBzMfxn+YkpGHAkYSndGP3X+MEL55wFVMBX7ek/IG1zqe14QiastcwynCxU
         0ioQ==
X-Gm-Message-State: AOJu0Yz6DpGp1cKxCil85nQ6P5dEjVHZRj9HToHxYXi6ipLwsbtdLlyO
	TlR0hmBqp619JIhkXAc+VwEUwBZcn+v4QffBM8VqP4bdhHzVh4Jqd5plST8vK66x2qlXKpEePqv
	ah5HcIg==
X-Google-Smtp-Source: AGHT+IE6r/xhmkPQPyTJGLZC8tCNb8gGfP09mMPv2HMdvw+pbL9rdPeB5ZJC5BFBDTdI8LnuhPdOzQ==
X-Received: by 2002:a05:6512:39c7:b0:52e:969c:db8a with SMTP id 2adb3069b0e04-52edf030104mr2081863e87.44.1721159610606;
        Tue, 16 Jul 2024 12:53:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff73asm361328266b.175.2024.07.16.12.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 12:53:29 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so1153758a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:53:29 -0700 (PDT)
X-Received: by 2002:a17:906:2409:b0:a6f:c268:ff2e with SMTP id
 a640c23a62f3a-a79ea3d7952mr224501066b.5.1721159609118; Tue, 16 Jul 2024
 12:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
In-Reply-To: <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 12:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
Message-ID: <CAHk-=wg+38EHPKGou1MqXwAAXC30cM8sMgZAGnZ7TcFO4L9J2w@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: driver updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 13:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
> soc: driver updates for 6.11

Christ people, am I the only one actually testing any of this?

> Bartosz Golaszewski (14):
>       firmware: qcom: add a dedicated TrustZone buffer allocator

This causes me to get a new and COMPLETELY NONSENSICAL question on my
regular AMD Threadripper workstation config.

I'm getting quite fed up with all the constant complete disregard for
any sanity in Kconfig files. People are putting in COMPLETE GARBAGE
here, and apparently nobody bothers to test it for any kind of sanity.

This kind of crap needs to stop.

I think the fix is to just add a

        depends on QCOM_TZMEM

to that thing, but on my Altra machine even that doesn't fix this
horror, because it turns out that everybody and their dog ends up
doing

        select QCOM_SCM

and we have QCOM_SCM doing

        select QCOM_TZMEM

so it's hard as hell to actually get rid of that pointless churn,
because you have to figure out which random driver ends up allegedly
"needing" this.

Are any of these actually _needed_? Because while I like automatic
"select" things just picking the infrastructure that a driver actually
requires to work, this all does *NOT* smell like "required
infrastructure".

This smells like random "do you actually want this?" to me.

And the answer is "No. No I damn well do not". Particularly on my AMD
machine that most definitely does not have some Qualcomm TrustZone
thing.

                Linus

