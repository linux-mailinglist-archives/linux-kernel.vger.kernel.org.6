Return-Path: <linux-kernel+bounces-376013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C883C9A9E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF5D1F223C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F252198A2F;
	Tue, 22 Oct 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RI1jebYl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFF1494CA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589780; cv=none; b=Gy3hEnesK4loJjCZQqy8dkR4Reob+y3Uv3iRqkWuniMrIePTd5XY8qqQSx9JDsnkUIG6GCXyA9O9hlQcuYMKAzx/2TNEM34TT/JieUsBt3Y0WXtnBs0na8ZvIM6+debB71oz+6UuPWtxqAlCUfYk5R1EnOnl1tmhgUaUOj3Em5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589780; c=relaxed/simple;
	bh=JUOkRks2mm1sbrP2WS4gm3Ys9rxBtJEc0sENLr4gzhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHkml8XkwHsamvHky/52S2hLs6/JTCygQeDWcBL3QqhTKwj3eBD91zAwAwRBTt1mAssozCzuKod6BTEs0bXOQ31nXI22sXV6VsgrrbJwU7JSegcy01ILK+wZJdt9ahGY3AtU3Hpj8y2I/Ca2pe0VCtThPwfAbE2PleyTgx3WOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RI1jebYl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315baec681so55612195e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729589775; x=1730194575; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fsVQUcARuIWhOcGodmkDQEe+tag8Qx5PkTwvtAzDek=;
        b=RI1jebYlmAC0GLK6VhLPfuTn43nTawY+GS1HBE/oE8V8z8OA587kWEqM3MNA3pxrTd
         og788sRvzxXTa6DnwRpi37QsiIJO330f92AcA46e5sLAa8cYXQYvEVfJVWTvrNvYOBaJ
         b/ghQYEhVFCMh8lIUxqxWKJy28QR+1hL2tgnrsynb9u8dfpLxNYTOv5D7dsZ1ZQnUgeG
         Uk4M9t1FAyO4f6IkBqD8pUNjJ+5favqUmKn7tyU5d6h5VyqFlUMpHjLr09IrUGAwIw2X
         NInb1NtQol8CvoPwbo6WbdE95hDfcV8H2CicOJo2+LiChb8x1mtP3S2opfS6LELEZZbU
         Misw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589775; x=1730194575;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fsVQUcARuIWhOcGodmkDQEe+tag8Qx5PkTwvtAzDek=;
        b=E7DAOCZK8HOstX6Sj8UUz58U3ez4L8LZGkX0CaBRnDZf/q9g55XGZwdafYw3ShIO5V
         IAwYnljYX6TEwaI7PswUDoU6lJ4G7SZrAsv2CYuszIhH9VSCZTlYR8iv/vvahf6KGHgi
         dh3LZ66hzF1XxQjWjH+6wv1HyDaTrTNCNVEySQAWs2/X/GQVvM73r8EZ8AyM7iSbB+Nl
         Q0/T9GuY198/PC1ZTWTEURQB9j1rAR9G/2k7rtTITwmzpVlTiB/n8rS/vGqB7FazhpNP
         b35jbu2T2Gj6zuAi8uYetJqBa8LqJk6njCCi+O5XvR+LSPBxu3Vy8qbSB4LhrUlPy2zb
         8JQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCTxXHWISKf8uuyS4ufQ8eNaKpoKb4VrDlBhH7G+szwZnDBzsizBReoJp78vE2+gQAGxWgpsvY1ea/3b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4k8e5yI5q0RdE41bXBRu7aNR4SxwHOZjKrjph1XOlNQFasd8S
	XKWFCQEzJSKF2SeygkuZ2QKRNl9KM0039qsDVnkThNesZIZ/0YnKp4NUU42gTZg=
X-Google-Smtp-Source: AGHT+IFMNwrhj0pJZPkzl5FYhTMDlK96/nSoyfy8b25ehdKKWw+4jVdDPhgV4SZ5tiGqcKSkTMexjA==
X-Received: by 2002:a5d:6b90:0:b0:37d:4e74:687 with SMTP id ffacd0b85a97d-37ebaa7a72dmr8620512f8f.41.1729589775370;
        Tue, 22 Oct 2024 02:36:15 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ef1c:ae40:1300:20c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b35sm6249649f8f.2.2024.10.22.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:36:15 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>,  <devicetree@vger.kernel.org>,
  Kevin Hilman <khilman@baylibre.com>,  "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Philipp Zabel <p.zabel@pengutronix.de>,  Rob Herring <robh@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v4 3/5] dt-bindings: clock: axg-audio: document A1
 SoC audio clock controller driver
In-Reply-To: <1jzfmwjxbp.fsf@starbuckisacylon.baylibre.com> (Jerome Brunet's
	message of "Tue, 22 Oct 2024 11:34:02 +0200")
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
	<20240913121152.817575-4-jan.dakinevich@salutedevices.com>
	<1jzfmwjxbp.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 22 Oct 2024 11:36:14 +0200
Message-ID: <1jv7xkjx81.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 22 Oct 2024 at 11:34, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>
>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++++++++++++++
>>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 +++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> index fd7982dd4cea..df9eb8ce28dc 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> @@ -18,6 +18,8 @@ description:
>>  properties:
>>    compatible:
>>      enum:
>> +      - amlogic,a1-audio-clkc
>
> This controller is missing aud_top clock input coming from the vad
> controller, AFAICT.
>

You are passing it thourgh pclk so it is fine

