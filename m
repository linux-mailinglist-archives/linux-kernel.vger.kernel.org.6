Return-Path: <linux-kernel+bounces-392462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5B9B947D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23378282DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334261AA7A3;
	Fri,  1 Nov 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EXDTyus9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C471C2DB2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475333; cv=none; b=Rk78Emm1RRXsj0SUPE+K5HkmHi0qbrIDqnDBCk4qnR7xAhAnAzGSC6zDEDSNETILXQ/POP2qkuVR/jBMkUUND7eLRgX1sMy/R8SPl/VA2DLvwhGNdNR0OewjpWF2k+uXYoDO4B2aZ+4S66b6Ps5Gw8UcCpphMNs+v8EI2qtfSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475333; c=relaxed/simple;
	bh=g4L3ibkH9jQ+qQRrFR7Kgon/qgAC5gRqo2KZvcNUwQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zu4+HwhOJEOqRKQH+4zadWArqtpUJdllqAVcXVsaWNtTR+1kHr5X/fLbT0qhvghz1+Ri6AAaK5FVWCxxUddxwG/VoycvC5LbOeO55zPxssMeXrYy1O11Bxs6643RMqw7Q7oanAmwMiEc4xr3//yS+9YVEbpZsL2FlirPIu7z7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EXDTyus9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c714cd9c8so22869895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730475330; x=1731080130; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGN+519eYtZuRigBuYtgvVW5FkfJE2dQGYi4tNlzHFY=;
        b=EXDTyus993OdijbVkH6CpDWxAio9f6bcfBluigxBnlYcPHwYJQrI8bSPaPeM/IrzIH
         E5h9lxXzpp+p11fx2S8tNl9mRncy6/iFrblNXRX95XDUoMFeL/6XTg21o8/vtUQREJLa
         JEromTe/wCB+Txsdm0JvrYMRmnefkMBYQomcqCATlJBD47twM8qvOZaGEmkaS+tqOpWs
         VYJVZDgeN3BU3mXgYUr3pElCfIdwtpreQ2EdObBL17SBaK5ORATNoE/++1o4KMB1X7yR
         bwh3GNFKISlL4pYAHrMgYLLdBhh1277Ayo6PtEWzvtuFHwfMLbNnYLIVw/XxgoQ4uV4f
         t6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475330; x=1731080130;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGN+519eYtZuRigBuYtgvVW5FkfJE2dQGYi4tNlzHFY=;
        b=fSzNXkPvaibf5S4pOatYCtFiu/BHctEVv4+xH7YgqnOoPy9c0WMdTgk/UKKhhzhgYL
         Cx215D7pQXK6meCgV/o4zYHq2nvxoxxy/iutiPaf0qAndjKZRGhPaXdTLyOiST0WNd6X
         mvfpqxg2cnFvF/a/1nBDy5VLYCmym00DchgB9ksZTkyz95+P94bvmShKCCBR2wLU6en/
         L2JnntGxZ5oingFCqSUyLs0CR4hhY9H1RjFk89SJNb4I8dgIFzIxkJXVsRCTUpf3YSF2
         9X/wQf5Lod1MdibgAb9LcHJps2vBuPHXTtwobkYYeTfhfAiGgUFXSzVOzEDZSXSpDIVs
         dOIg==
X-Forwarded-Encrypted: i=1; AJvYcCWkwK26XYEx0igS9aAb8Mst+J1CiIaFqHx5YAF0r+wI/1xGBb9YJiRf/fYEZBA4yMIYhcZ0Zl9Qen5UWhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNuqbJFUbp1jx8djI6KfAYBn8KOYiK7WQK3QVUmX5KhGjriC8
	N/YGqRUwy3ADWSrd/+aISAm9ZEcIEOsyF3tn/VDknql6kxj3FBmGY1yp//47MuA=
X-Google-Smtp-Source: AGHT+IHdRk4WtBzIprISHrwlWueLoJHqAZ0Hi3OqocknTJdFlMfcN7iB86YkUJpngGBacYjvD3vJvQ==
X-Received: by 2002:a17:902:e74d:b0:20c:7898:a8f4 with SMTP id d9443c01a7336-2111b0276a1mr44569875ad.60.1730475329852;
        Fri, 01 Nov 2024 08:35:29 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057effcdsm22717175ad.302.2024.11.01.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:35:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Vibhore
 Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power
 mode constraints
In-Reply-To: <20241101144445.56ejnuoxshqwns37@boots>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
 <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
 <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
 <20241101144445.56ejnuoxshqwns37@boots>
Date: Fri, 01 Nov 2024 08:35:28 -0700
Message-ID: <7hwmhnnf0f.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nishanth Menon <nm@ti.com> writes:

> On 11:11-20241031, Ulf Hansson wrote:
>> On Wed, 30 Oct 2024 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
>> >
>> > Ulf Hansson <ulf.hansson@linaro.org> writes:
>> >
>> > > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
>> > >>
>> > >> Hi Kevin Hilman,
>> > >>
>> > >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
>> > >> > The latest (10.x) version of the firmware for the PM co-processor (aka
>> > >> > device manager, or DM) adds support for a "managed" mode, where the DM
>> > >> > firmware will select the specific low power state which is entered
>> > >> > when Linux requests a system-wide suspend.
>> > >> >
>> > >> > In this mode, the DM will always attempt the deepest low-power state
>> > >> > available for the SoC.
>> > >> >
>> > >> > [...]
>> > >>
>> > >> I have applied the following to branch ti-drivers-soc-next on [1].
>> > >> Thank you!
>> > >>
>> > >> Ulf, based on your ack[2], I have assumed that you want me to pick
>> > >> this series up. Let me know if that is not the case and I can drop the
>> > >> series.
>> > >
>> > > Well, that was a while ago. The reason was because there was a
>> > > dependency to another series [2], when this was posted.
>> > >
>> > > If that's not the case anymore, I think it's better to funnel this via
>> > > my pmdomain tree. Please let me know how to proceed.
>> >
>> > The build-time dependency on [2] still exists, and since that was just
>> > queued up by Nishanth, I think this series should (still) go along with
>> > it to keep things simple.
>> >
>> > Kevin
>> 
>> Right, that makes perfect sense to me too. If we discover conflicts,
>> let's deal with them then.
>
>
> oops.. I missed this response. OK, I will let things be.
>

Oops, 0day bot found a build error in linux-next when CONFIG_PM_SLEEP is
not defined[1].  Need to respin to fix this.

v5 coming right up....

Kevin

[1] https://lore.kernel.org/all/CA+G9fYtioQ22nVr9m22+qyMqUNRsGdA=cFw_j1OUv=x8Pcs-bw@mail.gmail.com/

