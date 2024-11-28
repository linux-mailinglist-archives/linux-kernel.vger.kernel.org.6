Return-Path: <linux-kernel+bounces-424893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3B9DBAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A433281FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56491BD9CF;
	Thu, 28 Nov 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPgJGwDS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41A1AA1D5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809230; cv=none; b=Rkc8Two7lKzRVgPp7TKZAWuhQm+DuyLfF16SEgsNjvA7hv0CFRsONJiBI8TlFm5KO87XC3twUwjdeRWknE+GBlJMZejpSaAgJu5X7wYx75wzaudXdIdi4rog3EQYS2bmm6wCtaGuLkJiaALQ3aeU//8Pm2OTDiUbv+HB2jWLZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809230; c=relaxed/simple;
	bh=W0nbNECqaoQgQy8wCcT3w89EsIp4bVSjckOvFyN+LiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9XmC50HbYINsqnFzYbudxHEBnzBrdXNOk0GlaL5T16BX81TEeQFHMyNdo2Nv660Sfwxpai6DlZWLXfocoQ22lUuwILfxHYWma/MTKhoD7SrdGab+jRS3Lt32jSHGmgVUb3LpwImiLzSZCzKUiSCs/fFT4qb/nkn6BQN3xF5zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rPgJGwDS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so8377465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732809227; x=1733414027; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJcLS7Y+TNZg8kTiOzR+IwHTehRXvL7IIhIVM5JxoUs=;
        b=rPgJGwDSagSjg3rwMDWPAjXFUZGP4uXbrnvLSe5OPy/p0SFIHy9NPRJfYtQWwvWpAo
         PuDsAxU+ZBomCoz4oIeqH6K2oTFmyczehToqlNFKQ5zM9HjptliYNRyjRPIplWx5NHkP
         PRKtmAO9eFCEsbTmfxH41OBdj/t/dHpszPk+oBP5dlrF95oLxZtBz7pfcL6zUo0AS9Bf
         eA0eaWZU/OtRjSGaHV7IlkviTWzplHqdCdypNJiXE3cek6wvbzpAgiXOK1fDKt3e60Kt
         nlVdaef9EfIDelt0PyFLlK3CvCNPftFYPgNRabubC0CIIXXYgICTcRjdBBjmmwxedANL
         XBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809227; x=1733414027;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJcLS7Y+TNZg8kTiOzR+IwHTehRXvL7IIhIVM5JxoUs=;
        b=ZfCsAqqY2q7cl82bSDwGXPH0k4Y8sf/aT1t076COBs0brOJjD6wh3XbsiNxtTAoZNN
         P4hIRl306g8qpv+nBRTcE9LUXMVRdHTAbpEnfVoPFOPz9MiLohkSwKltteLQ69vNYClF
         fAPSW+2UFXawW5A6tgiCd5xuyGtuP3UyiN0cgVyOmKgJ9Qsakk9ELWknP0JIQM7B0uox
         35GQOg3a7DS6mx0qursyTkeEfnC24huqiRDk47YhVjdCvugHSKNPywTbqWIEqIqLIUed
         YSMaTXXB4OTg8y5DUsuBo/6AHGCQVKcNnE9CLE57/yP2uvSagJM9ccLQP+lBzddM2FO2
         GqVA==
X-Forwarded-Encrypted: i=1; AJvYcCUE50GCjh+T2pQtxzjbItusopqEEWS9I/6DQR9ZWRIkmpuwjdL9qWSLtxF3WiDf0xumTp03l8GprcaeQZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTs0EuOKfvzqy+Jh+NDqSYcvkFFKB86bocsVHFmMXuUUPMDcX
	BN4VdpHnWIjgT2hFExdNmHnoi0IPBZZVUqoZoaVNKl3irzfqgQzFZtaVe8b1tH0=
X-Gm-Gg: ASbGncvcRmghqHh/bMtjAzi1xe2o1V4l4TGkTHESSSIMEZWEvSiNd9cPyXlVxxkAEcc
	yV9/ef+kgaKawn3nK0Fy1Fy0vAZAJctjNIyZGC1IbAX9cJp3eLd20KaU+Ofv9o+OttbXLjONNZC
	CV0rHxLBYblQUw3qkVdSCCU252YeQ5JvkW6BR6wbDUE5zcq3bQqeF3ykRDebH6yAQ/6/Cl13Zf+
	/R1kTnn/ElBotXx7fQrTMQ3Bm98wTGjA6B1wEfFGKV1c9v4kQ==
X-Google-Smtp-Source: AGHT+IGniJq3jqV+EYYIMc2ZyU15P38lX7DI3pP8iwwIHzl+aDRDGlHZnT2XwseXds/67vDoiz4FKQ==
X-Received: by 2002:a05:600c:4747:b0:434:a07d:b709 with SMTP id 5b1f17b1804b1-434a9dfc3d4mr61829395e9.29.1732809226700;
        Thu, 28 Nov 2024 07:53:46 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76b52bsm57165365e9.18.2024.11.28.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:53:46 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 28 Nov 2024 16:34:46 +0100")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
	<1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
	<f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
	<1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
	<306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
	<1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
	<c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
	<1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
	<ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 16:53:45 +0100
Message-ID: <1jjzcn1hiu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 28 Nov 2024 at 16:34, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>> On Thu 28 Nov 2024 at 15:51, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>> On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
>>>> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>>> Eventually that will happen for the rest of the reset implemented
>>>> under drivers/clk/meson.
>>>>
>>>> It allows to make some code common between the platform reset
>>>> drivers and the aux ones. It also ease maintainance for both
>>>> Stephen and Philipp.
>>>
>>> I don't understand how this helps: the entire point of using
>>> an auxiliary device is to separate the lifetime rules of
>>> the different bits, but by doing the creation of the device
>>> in the same file as the implementation, you are not taking
>>> advantage of that at all, but instead get the complexity of
>>> a link-time dependency in addition to a lot of extra code
>>> for dealing with the additional device.
>>
>> My initial rework had the creation in clock (note: that is why I
>> initially used 'imply', and forgot to update when the creation moved to
>> reset).
>>
>> I was asked to move the creation in reset:
>> https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org
>>
>> We are deviating a bit from the initial regression reported by Mark.
>> Is Ok with you to proceed with that fix and then continue this discussion
>> ?
>
> I really don't want to see those stray 'select' statements
> in there, as that leave very little incentive for anyone to
> fix it properly.
>
> It sounds like Stephen gave you bad advice for how it should
> be structured, so my best suggestion would be to move the
> the problem (and the reset driver) back into his subsystem
> and leave only a simple 'select RESET_CONTROLLER'.

Okay, though I don't really understand why that select is okay and not
the the proposed one. There is apparently a subtility I'm missing I'd
like to avoid repeating that.

>
> From the message you cited, I think Stephen had the right
> intentions ("so that the clk and reset drivers are decoupled"),
> but the end result did not actually do what he intended
> even if you did what he asked for.
>
> Stephen, can you please take a look here and see if you
> have a better idea for either decoupling the two drivers
> enough to avoid the link time dependency, or to reintegrate
> the reset controller code into the clk driver and avoid
> the complexity?

If I may,

* short term fix: revert both your fix and the initial clock
  change that needed fixing. That will essentially bring back the reset
  implementation in clock.

* after that: remove the creation part from driver/reset and bring back
  something similar to what was proposed in the initial RFC for the
  creation and finally switch the clock driver back to it.
  That should provide the proper decoupling your are requesting I think.

>
>       Arnd

-- 
Jerome

