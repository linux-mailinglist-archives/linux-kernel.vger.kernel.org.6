Return-Path: <linux-kernel+bounces-524968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A314EA3E954
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC707A63E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE651BDC3;
	Fri, 21 Feb 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPbadOSg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94F1DA23
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098847; cv=none; b=fwpzsI4NYsKjWa+sELFaW5HWC9L9jwxZCj/203RN0OopFjGf8RotHhJ8lsMo4hgUPpG6TK0gSJX8+opkg+NJw47eHoS1w6ZtB9GoK5/CM063c0g9PvAR8UO65uHsRh+8k49hQRNRU5OBJn4PwWvEyFeZY6tPjdP2zufeTyhPoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098847; c=relaxed/simple;
	bh=AFMZD8xA79SrcF7qdF9M6LpkATxyi3gQbmTSSDjdeMU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nIR+0ecviwkWRT/8EunpsRR/9SeqPg81UCrwuB7Or2ZHYv2XgU0XKWvoBRdYNSKJydZL15ppxQ78PiS9l46+pXaaZEC5/MrgFzuW8jMTJzXthORDmTV89oBaWNm997rEXnCAyoMmHYXovWlLWCcWx6NztIT8T8Rirvwo5lttepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPbadOSg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so13497975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740098843; x=1740703643; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uwzXKEnNeEIPu52I2DCxojSGUOWNSCkUNKbC+s6sxg=;
        b=SPbadOSgWdR2bVUHmyVLYXoeXl5elxDHAqEFCVi8kUac67RWfOTSOTVAjcAXIvg1bj
         RUjJhIhMSgC1GCisOCUZ30bu/h9ylImmJ5y/R4Yv6TNX4WVzBTrgiDW0DH+n3HbzzH0B
         OjERvsJxu3TgXmgijW5o2RqaHPqEQgLbXYnETfqQJk8xILLLwa10032crjdT0hYeGlDi
         rMdakWDjCpL6Bt34zMn7L59lKTER5FTJG1p2baViBqWszVeLTObf1pPdYoNkP4EbDwq+
         7rsMGz1hdw7RgPMaIvBoROQ+XphYhwgXF8HTIgey+STtdeZYz58xltzxrharMTVrAzDO
         o0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098843; x=1740703643;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uwzXKEnNeEIPu52I2DCxojSGUOWNSCkUNKbC+s6sxg=;
        b=VBx7/Oo8F63S+zFGz0UwEOSDXNe7Hn5qCVhlHPpgCvin6TYnqwxBTBXdR+S73O/nQe
         +MAKRdu3NUm4AHl3RGH60fveLm25TBjaPj6xGPcpSznWWdzl92KiPfjRP9TxINUjAuUA
         EkgX41DZxfKDCQybILYhNSTPyrFotBmlR/2ilM+9/71ziIPqfLyx3ZOWu7sr6Xsvriar
         RHA3ow5jk5jlaHAPSZGLub5cDPfc26CBqaGuyhPRccrfGP6cxH0kRiBr2Wm9QN6D4F/8
         24sfCRVU5nC/WmB8lI7LtlZKcJv0QFqqHWolRwN+SPkCbmruUrL5z+5iq0hJvrmALIQ2
         geTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOLeQJfLCpvjygYLaQJimagxLhYVKZhrlZ893ihLtxGeGiqh+GDU0SiNf6wCpZvmx9L20F2xJR6KrnFM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6Gw02dS54ZEZWkLerKp4uAQOrhEBfqiZ3MwPlY4c4J4/hXNY
	PcG2ViFKjIqsFK1MRKILu2hho4ZGhGomEKH8vH814SvWyhSKLIO6+oGWV1ss6LE=
X-Gm-Gg: ASbGncvCNUbzSEQNKJ+R2dBy9UsddOO8rwHaHKuOjRjTt/MXUxLCUe+RIeK4Jq8WKtr
	Zslqrm3RFD5UoHo7XNibFizsh9/9CAw1KPSCyhDYOyGjDTMFOnc2BfI2JNGHuXZsNK/Tvh01eBB
	WpSgdTxdXSaC3PXZzgoFcGzAVX5ALf7fLZkhyCWRTqm8KdyzEkkJiCA1uqBIPme1iThGNr2ObRB
	Y8fw9AfvGwoXH/5xZn3P98QoPicJ7X6RoSzAWP2G6RHStBZdDjh1boaDI/qvWwFTCMN2bfFlNHx
	usZWo/XgatnkT+eI0g==
X-Google-Smtp-Source: AGHT+IGP2COMTFmCb6NZD7IEUpBby+MJg1OI/LvEAFrSspNS5gqFhyuY2jzlf6BtHJjV5QSFOV34JQ==
X-Received: by 2002:a05:600c:1390:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-439ae1d7e97mr9688025e9.4.1740098843201;
        Thu, 20 Feb 2025 16:47:23 -0800 (PST)
Received: from localhost ([2.124.154.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371c51sm877805e9.35.2025.02.20.16.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 16:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 00:47:22 +0000
Message-Id: <D7XPK4C7YYVN.2H85SNZIOOPAB@linaro.org>
Cc: <srinivas.kandagatla@linaro.org>, <broonie@kernel.org>,
 <lgirdwood@gmail.com>, <krzysztof.kozlowski@linaro.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wsa883x: Implement temperature reading
 and hwmon
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Steev Klimaszewski" <steev@kali.org>
X-Mailer: aerc 0.20.0
References: <20250107114506.554589-1-alexey.klimov@linaro.org>
 <CAKXuJqihpwnOTepgTkH3FaGB5=kXVCDOckPGpacJ7JWZXxsKWw@mail.gmail.com>
In-Reply-To: <CAKXuJqihpwnOTepgTkH3FaGB5=kXVCDOckPGpacJ7JWZXxsKWw@mail.gmail.com>

On Tue Jan 7, 2025 at 10:25 PM GMT, Steev Klimaszewski wrote:
> Hi Alexey,
> Thank you for this!

Hi Steev,

Thank you for testing. This really helps.
And sorry for slowly getting back to you.

> I've tested this on my Thinkpad X13s which has the wsa883x, and here,
> when idle, I see an entry, sdw:1:0:0217:0202:00:1 which shows ~26-28C
> when idle, as well as sdw:1:0:0217:0202:00:2 which has ~22-24C when
> idle, however if I play audio, both of them drop to 1C and do not move
> from that while audio is playing.  Is this expected behaviour
> currently?
>
> (out of laziness to repeat what I am doing here - I have bottom
> (https://github.com/clementtsang/bottom) running in 1 terminal, and
> then in a second terminal I either play an audio file with
> canbetrra-gtk-play or mpv a video with audio and for the entire time
> that there is audio playback, the temperature sits at 1C.

As far as I am aware there is some hw limitation resulting in that
temperature is not updating during playback/when amplifier is active or
that it is not allowed to read temp registers when the amplifier is active.

However, we should return the last good value here and not drop temp to 1C.
I think I found what the problem was and I will resend the new version soon=
.

Also, on sm8750 I see the 4-5 degree Celcius temperature diff between two
amplifiers (30C and 35C for instance).

Thanks,
Alexey


