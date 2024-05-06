Return-Path: <linux-kernel+bounces-170181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB28BD2F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868701C2113E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547A156962;
	Mon,  6 May 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQkUyM9Y"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A325569
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013598; cv=none; b=f8wYVt5dSBmNl8GUyU3hKvqAQkudk7YQYTAMidKnn7/r5p2mqSoBzlnfXU+dlz3hg9R/k5BYMdIXBxQqm3t5AYy8RCunGxfoh2VoiuhlqT40zThOQubuHlnwiKCGSPZgNsKP8kIF7KqLmEjXZS99jxd+iwtBAr+GxwMjEMKDfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013598; c=relaxed/simple;
	bh=Avjc5JEKY4BtFG45Sfhy5z4Vhuv0aBII8xkoLLTxJP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9fg+WQerk5xJVM7ts0IpGWLMnZuGSfHTGBVig/4aoJjwTRCEVzXD7SaZMY7+RjJ9kG0EhRVFP6LshAgnRQKKenZNBs2lrFr6p34ZQCry4u75fIzh0nq+vtKkhSEKJ5cbPNyjyV+JmBod39109kx5mkeJ/V9WjJKRceupKow3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mQkUyM9Y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso986492a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715013597; x=1715618397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avjc5JEKY4BtFG45Sfhy5z4Vhuv0aBII8xkoLLTxJP4=;
        b=mQkUyM9Y8YVs/1b7/hXYxUMLS/jFJT4X0X7XwYbObB29PpkoZgr54EX6H5wfHS8Nbd
         R6zc4siBPpOlmFSUm8U8g3vEZFfp6n14sExTG+4IUD80nh/40o0Us3Hcl4fHKlbVRWEB
         FRsaxeu2GB8EL8yAiUUqjyrBOBeWCqgeG6ZlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013597; x=1715618397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avjc5JEKY4BtFG45Sfhy5z4Vhuv0aBII8xkoLLTxJP4=;
        b=XO1Bi2nyfP/p9TA+V5o/NS+JbPq7Oe5bjRoSYD17PF1OxB5nlLd3tRoRfrCMjUr/Ot
         7ujeGbR5+rq2WIqVemw/ZJwNEmSL9uOXqIeIhwDpQ6qs9Bxc0zqMx8qMlTxNk9ZLWaJL
         yXgM70FLQP1Gw/x7EXFOxbKV7PbYjDHb+8FPOjc1RTFM13sDj7VL8X8TagyEp3iUz9Jc
         yyDMZp0rsDqkp/pWT8aGDyn+e1oOzWkRCqalo6YUSDWXzHmyOrzy7RgQ4wAInh/D4FoL
         +VLw1idb2Sqv4fZ4oUL8BY1h5gyDcysappxy9lzejNpzzI5v0ydabogCdIe2pHVoyuwV
         bidQ==
X-Gm-Message-State: AOJu0YxGLuBkB6I//9Vxwgl/ohKEDz5FQk4dZYrfnCslF8pLSrBSnPoD
	ia7+DQa1uTJRT89yfFq0CxQ5zq9xq25Cmrh6gJ6zCOz2MSsaf+Is5ssZtEkVnpdJNw/B5sj6961
	FkIEYJtaQk96ToxGJUBAua09Fe2V59wvIMywW
X-Google-Smtp-Source: AGHT+IFtiZzUbdyJ7EHE9NaQYgST4cKZ8ciaJgk+hpp60dVzju5sNO9t8ZOCNbclU/AMAZqCL+aHIjcP+r96qaWsJVo=
X-Received: by 2002:a05:6a20:d49a:b0:1af:88ab:e86a with SMTP id
 im26-20020a056a20d49a00b001af88abe86amr8476635pzb.40.1715013596588; Mon, 06
 May 2024 09:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
In-Reply-To: <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
From: Allen Ballway <ballway@chromium.org>
Date: Mon, 6 May 2024 09:39:45 -0700
Message-ID: <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk detection
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Brady Norander <bradynorander@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	=?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, 
	Mark Hasemeyer <markhas@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 2:46=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 4/30/24 16:28, Allen Ballway wrote:
> > This device has an audio card which is quirked for force SOF use but th=
e
> > device does not support SOF so the card is not usable and audio can't
> > play through the HDMI output.
> >
> > Add another quirk detection that matches the Azulle Access 4 in the DMI
> > info.
>
> Please try the patch "ALSA: hda: intel-dsp-config: harden I2C/I2S codec
> detection" shared last week.
>
> https://lore.kernel.org/linux-sound/20240426152818.38443-1-pierre-louis.b=
ossart@linux.intel.com/
>
> I really don't want to maintain a long list of ES8336 false detections
> due to broken ACPI tables.
>
> Thanks!

Unfortunately the above patch didn't fix the issue, nor did I see any
of the change logs in dmesg.
Are there other alternative solutions or information I could gather to
make a more general solution?

Thanks,
Allen

