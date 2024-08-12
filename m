Return-Path: <linux-kernel+bounces-283692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D249694F7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAD4B21F46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AEA192B8A;
	Mon, 12 Aug 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PUGVSxHl"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0981922ED
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493083; cv=none; b=qsGvLDxoMZW1qtOmC0w8GFH+nWa/uS8lxURZQYgiM906AQnjh5q0F+98h4nujSvYoyioiSiFhzhPKBiX6LZ0+hwsyUO8gLW1fPbdmVAL1+0LXzaJXBQCdwyaOkxC3qkf8Lx5coG2ouJDzLwpRqcXR2f3MbzYK4veO9o8EZM9xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493083; c=relaxed/simple;
	bh=OpNM1RYymoPeqC3y4MRqedb+EbMg6Loz9coImL6/6/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VM9th+DAk+gVV8pNdle4cm7nJw4iDJmDqddiUusTh6Mpv2tP/YhZk+H2nVlQksByyCy+p7A8D5aeFwVJKh42euxAh7evP3a4EMWlbr3YDMolapeeWrYkV7TaSmbOA9nuVSyTlESRF+L0WNN3w/dzF7kUsAAhRXjnvylEPRiy+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PUGVSxHl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1dcba8142so421378185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723493078; x=1724097878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmvIt3Q3hRp07dfKBkbkpBI1nxzWKnrXiTKUARXGJck=;
        b=PUGVSxHlkC6AQtZMBm8TutHsb1mnTxwXfsoq1wSlXjs+u1eJIpT05XZC0YcSfwNR6d
         gQOr7E4jet2yEET13xmhnfgT+bpC/XouHx62li59eNWNeQ+GBUnho/TH+IWkh26VjytV
         cDcW57HCV3kj8Iz84EAkEcjAyq5byPY0GtgIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493078; x=1724097878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmvIt3Q3hRp07dfKBkbkpBI1nxzWKnrXiTKUARXGJck=;
        b=Xh3ddjEiMUUBZoiucmT6PZtHI+NMKlA7OBgN2F0b7oexCZKXj/b5JkYvJEF4H18xra
         EBlS6Xe4Hgy4umpmkRJ/Otsbe50W/1/aq8uTGgw0W1BdfHoz5AqvBTt3sNirckovrvt3
         KHwWcD2sfaduMS+hsr8mrjJ6xWbD4SC19adag9cJ7WihnVRS166kAHeOJ0FvoltigXWp
         Hourpg2l4HBr42yvBtGkwKQOgDpofSpDrOBvi4iFtt+O5gOPTyhIf0gqpi/5//LVlhii
         3wo5w9s6DIwRFhYrX+K8BOlKQKwReTfhqOmjQzjSVIp3WFzIGED1xXbkY7jgrDAo+Fha
         dCrg==
X-Forwarded-Encrypted: i=1; AJvYcCVzig9vlKa2opXgsZSR2qCybzjQFCITLcV1MDk9H/Qyg3hH/eddK4oIPtet0b+D2LUw4/HUHYFQ+Pzzf768/y7J0YenVDCl/60AFXFB
X-Gm-Message-State: AOJu0YyW4eJrIXTvgAcJkvo1hrj5qvq/0wtHST2bH84bUzaewBl71N/m
	uzQzg0VyCkH4xzW+kXN4PLbjyRJKckzjZHDXu8/JJDRGlGUPku4ZIK/n9neSM9LK4MalBazbOmc
	=
X-Google-Smtp-Source: AGHT+IEwxMj8tYzu7me4g1X2hpkLgrGwWrKhsv0dwLq9OVyole+/uUdHdM0xbDRFR+jvUGaEp/1+8g==
X-Received: by 2002:a05:620a:2913:b0:7a1:dc64:59db with SMTP id af79cd13be357-7a4e37a34fbmr120805785a.8.1723493078534;
        Mon, 12 Aug 2024 13:04:38 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d829d1sm274701585a.68.2024.08.12.13.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 13:04:37 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so40294456d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:04:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIOYx9B80uQ5a4Zrbpo2K3sd0Wt9sYboJuGo3kWYLvuc+GoWHUgBLEm6SsaDXzSheVPNUUfd0JSsQRsWZ+63qYVuh91+4c3aulyyVn
X-Received: by 2002:a05:6214:1c83:b0:6b5:e761:73ce with SMTP id
 6a1803df08f44-6bf50c08da9mr13788676d6.16.1723493076757; Mon, 12 Aug 2024
 13:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812085459.291741-1-mail@florommel.de>
In-Reply-To: <20240812085459.291741-1-mail@florommel.de>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Aug 2024 13:04:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VC20PvOPSf9quqghA8SKKkCduadtU7nso4wkSwVKH3jQ@mail.gmail.com>
Message-ID: <CAD=FV=VC20PvOPSf9quqghA8SKKkCduadtU7nso4wkSwVKH3jQ@mail.gmail.com>
Subject: Re: [PATCH] kgdbts: fix hw_access_break_test
To: Florian Rommel <mail@florommel.de>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 12, 2024 at 1:55=E2=80=AFAM Florian Rommel <mail@florommel.de> =
wrote:
>
> The test for access watchpoints (hw_access_break_test) was broken
> (always failed) because the compiler optimized out the write to the
> static helper variable (hw_break_val2), as it is never read anywhere.
> This resulted in the target variable (hw_break_val) not being accessed
> and thus the breakpoint not being triggered.
>
> Remove the helper variable (hw_break_val2), and use READ_ONCE to force
> reading the target variable (hw_break_val).
>
> Signed-off-by: Florian Rommel <mail@florommel.de>
> ---
>  drivers/misc/kgdbts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

