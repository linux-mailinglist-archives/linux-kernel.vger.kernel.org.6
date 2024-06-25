Return-Path: <linux-kernel+bounces-228643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A05991640E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D764CB26A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643B14A0B6;
	Tue, 25 Jun 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i07AcjVU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34153149DEF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309197; cv=none; b=Y3nPtRGHeqqdYnbKj1BnBYXB9WAcc0LdXLF//p7p0cCLT9x+FfZyH9obQBNP6RCclDzUVrhx+frMXKblv9dXVTB5yZ+qDFagDjAvDwGoKnTfMfJHqgzPYgma3MZxZIEjaobN4cIyasGDmusVdHJRXB2GRfQFkJqmi3gsdfnFqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309197; c=relaxed/simple;
	bh=5fOsMfA//a10gbMrFTNNN7q0nF/8Yis07sAIUeCpLTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ke94Wyu2EuhC/YLnSvLKGARqeqTpmwm7QDzHkx2wDnmW6/yhrrRrtcKsHp0AJ9OnEn9P5EmRj56Ero8yFnkFpyeO2F4oGPj90J2mFQlqLUkK9aD23JZ6yUUGXGl3GeJbKS8SmjudS9akE51e9WTgb5YiKd7gOlWz/SsOEWGZm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i07AcjVU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cd9f9505cso4234388e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719309192; x=1719913992; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RqUVVAOM1tDnUN3dY9Htp5pIdnqRxsviToP8WQQNb8=;
        b=i07AcjVUs1neguNqZa0t2Uk+lRdQUR12OZIMEny1LnLpwJNQSVAQKDtmpOG53FOZAb
         5vVOyxDAFEqR8icqhSjV6nQBJdZBN8XULJEDO2QkOL0YFhB9AEGMOKr20FHxrNkYGgYE
         390iWRbr5Z8iqutVqaMPutTZQTuZQr7fV6GVLpQzkA3MdHiax9X8PXF9QP1nw2i6nTLG
         q0qnilEDcE3v0O7DBgg4DM34KAIoe7WyK35iolAD/v7D1IpgKplxTM4IElxtfSJ1PP26
         cLYo3ZSAkYnOjYdHgSa17uX75+I6JEXRT9uzi5mMSMncFDMOqENf4S8NRXbZwaDsYHuT
         1hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309192; x=1719913992;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RqUVVAOM1tDnUN3dY9Htp5pIdnqRxsviToP8WQQNb8=;
        b=Eywy7ikgIrckGAfWD2l7nnvqRbI6fnCwS92ZXxzoFeuolesLGe6DmNAB8XQKZ/QYPY
         qk2GPAfA3kgFiPcls8gF39OIBKMtm0Db9nBS93O9bL7I3/VkB0Dzy5Kt8zas3nRwe7B5
         Sjp47OSZRgWP4D4c8BZtu/CI+MC2tZXRCvJ6vV5oGEJ22FsBqO498IUa63sp008t+Fcm
         Y7JUoEDo5BEkRnUFaKmHVojsUyDAWdFaKaBaMjQYM7U9P0sTpEvIlchzu+unUKLnQ4dm
         Q44OHa9/LlUEEKa/3+0w1xeq444Hhqs4MDb8S7rC5aKTTBwn4LK0GdVfwkzaA8ZJdYPR
         Lvlg==
X-Forwarded-Encrypted: i=1; AJvYcCV3iSqbiVe7T+i9a5nMvG7o3QBs4y4ZUnQQukBG/biNOGvOp/NN22GeQ6ojgGhEuV3oPgUoduBWLnagSSKkBN33wC1dwYpN3rrFEW4B
X-Gm-Message-State: AOJu0YxRN99G7b3gm42uiy536P6KpU0tu0meyBcBATrBZDWMk6Lh+qhw
	gUSQn7Tr0Ls1zrnOPc9lJZft+WPpYgVwVcAjmq2s/8BbbQdl7vzNwX1VfcM9rQk=
X-Google-Smtp-Source: AGHT+IHpM8BunwwPdvPiWNmjKmtzMLfC9/Piq1T7ZczlkFsx69QObhWgnzrhF+eLaMHFOp00zaHOrA==
X-Received: by 2002:a05:6512:2399:b0:52c:e36f:369b with SMTP id 2adb3069b0e04-52ce36f3750mr4669582e87.17.1719309192280;
        Tue, 25 Jun 2024 02:53:12 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b57:b4a1:3d50:32a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d8e0sm174183925e9.3.2024.06.25.02.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:53:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Kevin Hilman <khilman@baylibre.com>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-iio@vger.kernel.org,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock
 measure
In-Reply-To: <52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org> (Neil
	Armstrong's message of "Tue, 25 Jun 2024 11:38:44 +0200")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org>
Date: Tue, 25 Jun 2024 11:53:11 +0200
Message-ID: <1jzfr9gxh4.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 25 Jun 2024 at 11:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> [+cc people from linux-msm]
>
> On 24/06/2024 19:31, Jerome Brunet wrote:
>> Add support for the HW found in most Amlogic SoC dedicated to measure
>> system clocks.
>> This drivers aims to replace the one found in
>> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
>> * Access to the measurements through the IIO API:
>>    Easier re-use of the results in userspace and other drivers
>> * Controllable scale with raw measurements
>> * Higher precision with processed measurements
>> Jerome Brunet (2):
>>    dt-bindings: iio: frequency: add clock measure support
>>    iio: frequency: add amlogic clock measure support
>>   .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
>>   drivers/iio/frequency/Kconfig                 |  15 +
>>   drivers/iio/frequency/Makefile                |   1 +
>>   drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
>>   4 files changed, 868 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
>>   create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c
>> 
>
> While I really appreciate the effort, and the code looks cool, the clkmsr is really
> a debug tool, and I'm not sure IIO is the right place for such debug tool ?

The reason why I went through the trouble of doing an IIO port is
because I need that for other purposes than debug. I need to to be able
to check a frequency from another driver. I don't see a reason to invent
another API when IIO provide a perfectly good one.

The HW does measurements. IIO seems like the best place for it.

For the record, I need this for a eARC support.
eARC has a PLL that locks on incoming stream. eARC registers show wether
the PLL is locked or not, but not at which rate. That information is
needed in ASoC. Fortunately the eARC PLL is one of measured clock, which
is a life saver in that case.

Everything that was available through the old driver still is, with more
precision and more control.

>
> There's almost the same interface on qcom SoCs (https://github.com/linux-msm/debugcc) but
> they chose to keep it in userspace until we find an appropriate way to expose
> this from the kernel the right way.
>
> If it enabled us to monitor a frequency input for a product use-case, IIO would be
> the appropriate interface, but AFAIK it's only internal clocks and thus I'm worried
> it's not the best way to expose those clocks.
>
> Neil

-- 
Jerome

