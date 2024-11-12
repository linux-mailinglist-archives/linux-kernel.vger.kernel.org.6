Return-Path: <linux-kernel+bounces-406457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611049C5F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1878A1F22847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681C2170D4;
	Tue, 12 Nov 2024 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUQhFAFo"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82013212D37
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433136; cv=none; b=pljaD9HTvvTaJzQwE0MdNButQcZqiZZ7g2w+kVedMG1ldbUUfB6EDiJmYMSeYqI9ckwYwtnZzygYFYCKmrExGiaE7A3jyaFuwTQhYJC3dHE33BWe8n581vDb1UA2b4fPvgLe6LsW42XbYEDC6Wn3UWkKesTQeLZ/v3Mf4xcVSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433136; c=relaxed/simple;
	bh=uqvlojepVHG+hFezyBlppjaIAaX/dWBBziS54qV71gk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nMcEQvbaOdkDwacOAkOYpLVaXsurhgIuvQ2ktWLZEgUMMtu18Hgx/hLYFaj+GW7y2zkyEjcXgBY1j958+mx1UUz/BUP6k6w+XG/fAgVWywYLlHNvHnOFEpBGmQE9JlYH96bD31wGFgifIniAb5/XCrQ4D1F67pUJ1laYOkHBHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUQhFAFo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso7382275a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731433132; x=1732037932; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqvlojepVHG+hFezyBlppjaIAaX/dWBBziS54qV71gk=;
        b=lUQhFAFo+kosVQQf4vhJKNHv2I0xXEP5/x11lJhq1lCa2fGFyga0fqQ4uh8IRrex2+
         +cSbsp/AZ1Z7XP/xl0rj0LTRiaZelQ4RR4lqhtJdjXQCIbiGp2f41soQMOsXGsfIvemY
         UQYiS3sP1P6UaMVr/ICbW1HZyhIrnm4FE7LN66WwCQbh6TiWaeUYuOJwY/fglLFC0KEx
         XpSOE1/uRIIjWwl/BsjpBzAzXIUk3qKQTwYybcTGufhqIDem8tg3U59xXDj5LiYf+JVR
         cc7PTk6itDRYQ++xrjICztoloQmUxbK1wHEavP4dU53m3zfaBv5Tes90/f3EWNM8qalw
         Okhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433132; x=1732037932;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqvlojepVHG+hFezyBlppjaIAaX/dWBBziS54qV71gk=;
        b=QOvg5c+rAUc0mCzSTNJyJpcCBR3FjSAfOucx2OAnUjSCDMjWkTTUa5jMUyNOIMNnUO
         CjxHeFJJ3DwpvAn+85xb8vKi8p2VccUjSzJzBl7Dz1AwSIiHJ7S0l8KCl5fKGbt5WQiL
         tWuSVefoQwVL2cwThR6EIbat8DqceOaZGcjc6cYZPqesjPe0+cBzvKhU0fW5Ui3RpY9o
         4iTRshOAX3UeCmp8zdUvzESEQrWYIrP+LNspW7y4evAujpzhE9XQ1emkyaVvL0cv9Y4+
         ar8e0wWY5crfRFMZyLGRlETdNNADu/AEKnZNJpQioQUfHF68FkBvMH1NK+tolzSCOtRf
         Devg==
X-Gm-Message-State: AOJu0YyDvB50+Bpgv7PJkz6P5x6IG9MWwW3xTEKPFzKIAaw3kN1VH3EN
	8k+v1NCQxZGV4iTYB1ZckBTPQS5gJTZDM1PGdM8k6lKeA6BvowhIjSlZGBJUX34DXR88rEAz5g1
	fBQIF1ii+H4LpoCJfNzc4xq2i2sCEuha7
X-Google-Smtp-Source: AGHT+IGKmZK0nn6diUtrh2lUZtNP11nBeVhWBiYU56M/ElCPc28PowSc63cHG3DJIfEbE5WVWW/oVIglFBPRPeGzmjc=
X-Received: by 2002:a05:6402:5241:b0:5cf:9f1:3f39 with SMTP id
 4fb4d7f45d1cf-5cf630c4298mr47154a12.13.1731433131511; Tue, 12 Nov 2024
 09:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: CIJOML CIJOMLovic <cijoml@gmail.com>
Date: Tue, 12 Nov 2024 18:38:40 +0100
Message-ID: <CAB0z4NpWz+_PSrjfd=8Ps-md2U=gB6hRr0vY5o=rCBHG60WidA@mail.gmail.com>
Subject: Thunderbolt external GPU dock does not work
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I bought an external GPU dock from Aliexpress
(https://vi.aliexpress.com/item/1005006121040283.html). The dock work
perfectly under Windows 11, I can plug any graphic card and install
drivers and us the card for gaming and encoding.
However in Linux I get only this answer in dmesg and card is not recognized.

[30249.989401] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
workaround enabled
[30255.865096] hp_wmi: Unknown event_id - 131073 - 0x0

My kernel is
[30249.989401] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
workaround enabled
[30255.865096] hp_wmi: Unknown event_id - 131073 - 0x0
I tried also latest vanilla with no luck

Can anybody help me to get the dock working and allow me to play games
under Linux?

Thank you

Michal

