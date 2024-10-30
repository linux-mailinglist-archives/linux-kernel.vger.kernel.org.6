Return-Path: <linux-kernel+bounces-389431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A49B6D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DD1F22664
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA671D043C;
	Wed, 30 Oct 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w+BCXCiX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C21CFEB0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317386; cv=none; b=sDV5ADv00CjTkXrpU7JQyS8KKuzUYJe5Hitb53LVvBr8+ucLTTus8bnFxisdqIzhJGHHh9iWkcIYb5E4ZA4triqAXf/jdlYU8OOGRcwCGt9kY39UIjpya7QXD9SE48P63UZ7OZZyFylBnla6Guu4GAYY032eeCW9FIUA91b2vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317386; c=relaxed/simple;
	bh=U0+7COKqo02RjpF7uFnt4Rsajv1k7jn2NNQjdlE+ZCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7EsMzsh7z2J9jJKDh1JefvAlRSJWgEK33XkLsTozJXIIuC1wTWDijYSnlh+NApnZCaHd8BN0ddFkE/j3uNvUXfP+gexgpIrJ0GZj/6t/wjRrx9MRgaU0EeLDjsmI6rqJWCRvMHUWzjpuTUP6n4tEhWP6agA296uZPrjEKSaP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w+BCXCiX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so2453055ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730317383; x=1730922183; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3le7Y0Gii5QDreHgxxhBrDb8aLPtkqMWBJFzizIbbqs=;
        b=w+BCXCiXaezUtCfGkRwYCbCrkXI3CiT8SEQsjg9tKPgzheQIh+ypufB1ocu6PIOC/c
         xK/4rjn5C/nVkhmNiY2Io7hUx+hkhIxEjyGfOSkE3FBlxefcZX9qxG85yeNxCvwYGdr3
         ojOEmuq0DLGhZ8W9mWMduvodHcI2bNot2TPABoSSoQwsxseX8ThWAdsiRjauy9FmC7rB
         2e0LXQRInFfNqorhJh7uXfRfuDjsLSEYXCa2HgdpiLWGMImTIICb4oPbzL6GMF8Wskkg
         pRmq+b96pIuJRvLYTpog9fqjE67y0u4bIyVRSAblnjqj8mZpH8lvdwZsGhVJhRnufVUD
         J7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730317383; x=1730922183;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3le7Y0Gii5QDreHgxxhBrDb8aLPtkqMWBJFzizIbbqs=;
        b=lGUBQEQSp67ra+zt/JtgxBMKyYVtZsKi9kQWWTvg4OU+/ZKmzKbHpu675qS+4Vq4ZV
         jKbqOpUd8PcHaxUAwD4J8d2z9V3ehQFHtPUbWVAcffGQsbbvCuOrRwMsOHaSBaFLa6RC
         X87xWh2A244+IKx9TkhWL1OcKOnZGDYwTX3VQUXNi/supAp0K3VzqT7Mjt/OP9LZ2qKp
         VXE7LxH5pV0oRmst33bwIgIRA40/vrCVl8e7VsEof6/RLpUdxQH3fZUNWGzSX+1uuKGa
         48IRSPjwXqmvpOh09HWS7cOhQgN8aDsXlKJhz4x364s3qggLASOCAHMs96qAAhKQNbok
         /6vA==
X-Forwarded-Encrypted: i=1; AJvYcCXYXo2nPObNYeF/9mbwNIRQxV1+MRFV2Ze2WOCtLolFJu7+eP7x18LURI/ewAIluWpMhBEq/E6wixevbKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQx1x+c9HfAE7pH0dGPWq4pZe+CwTIiYs4dSd0XKxg/YKAnZ73
	G4dnEqvIV2oHJT/Mb/ZUl2xTi0bCYrEk5z2Wd43KLr/nifQx36RUJ0vly0Xrb9A=
X-Google-Smtp-Source: AGHT+IHk8AZ9wf3uzoDfMby1k5RqREUDlcflFSi9zNXpPdV/uu6krYbXl92mEIypZxjKId/zeo/NXw==
X-Received: by 2002:a17:902:d4ca:b0:20c:a387:7dc9 with SMTP id d9443c01a7336-210c69e32dfmr232900685ad.29.1730317383199;
        Wed, 30 Oct 2024 12:43:03 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4332fsm85099085ad.16.2024.10.30.12.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:43:02 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis
 <sebin.francis@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power
 mode constraints
In-Reply-To: <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
 <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
Date: Wed, 30 Oct 2024 12:43:02 -0700
Message-ID: <7hv7x9qsvt.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
>>
>> Hi Kevin Hilman,
>>
>> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
>> > The latest (10.x) version of the firmware for the PM co-processor (aka
>> > device manager, or DM) adds support for a "managed" mode, where the DM
>> > firmware will select the specific low power state which is entered
>> > when Linux requests a system-wide suspend.
>> >
>> > In this mode, the DM will always attempt the deepest low-power state
>> > available for the SoC.
>> >
>> > [...]
>>
>> I have applied the following to branch ti-drivers-soc-next on [1].
>> Thank you!
>>
>> Ulf, based on your ack[2], I have assumed that you want me to pick
>> this series up. Let me know if that is not the case and I can drop the
>> series.
>
> Well, that was a while ago. The reason was because there was a
> dependency to another series [2], when this was posted.
>
> If that's not the case anymore, I think it's better to funnel this via
> my pmdomain tree. Please let me know how to proceed.

The build-time dependency on [2] still exists, and since that was just
queued up by Nishanth, I think this series should (still) go along with
it to keep things simple.

Kevin

> Kind regards
> Uffe
>
>>
>> [1/3] pmdomain: ti_sci: add per-device latency constraint management
>>       commit: 7c2c8d2651b5ffaffb2d5f723bd5b0493bd66f36
>> [2/3] pmdomain: ti_sci: add wakeup constraint management
>>       commit: 5a2d997b1bf8b05379309270063d7b9bd3767dd2
>> [3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
>>       commit: e8f35dc8de8c3216d28dab51b962bb31f20934c8
>>
>> All being well this means that it will be integrated into the linux-next
>> tree (usually sometime in the next 24 hours) and sent up the chain during
>> the next merge window (or sooner if it is a relevant bug fix), however if
>> problems are discovered then the patch may be dropped or reverted.
>>
>> You may get further e-mails resulting from automated or manual testing
>> and review of the tree, please engage with people reporting problems and
>> send followup patches addressing any issues that are reported if needed.
>>
>> If any updates are required or you are submitting further changes they
>> should be sent as incremental updates against current git, existing
>> patches will not be replaced.
>>
>> Please add any relevant lists and maintainers to the CCs when replying
>> to this mail.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
>> [2] https://lore.kernel.org/all/CAPDyKFr9isnz66B+n5y3=QO-ndB05JKZN3kgXO+kXBn7ofcwMw@mail.gmail.com/
>> --
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
>>

