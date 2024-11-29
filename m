Return-Path: <linux-kernel+bounces-424862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959ED9DBA65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA9281746
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290019DF81;
	Thu, 28 Nov 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWo+Lk5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DA1B86E9;
	Thu, 28 Nov 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807283; cv=none; b=nDlsgcuaZGatBT1LiqJ9oSd78uVInELyWStFZtT9tOqVEbBHyerIxnf6Wn7Zy9du7needhje81FLe1rwY8Dend2CH/kxRdnBMQr0m7Y9rDre0r6VcHuC0apPaY/bYjJDRP1UFIehHw7ReaenKCRAarxUZaP+wBDa33oRNvXzYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807283; c=relaxed/simple;
	bh=KwPswigeoYrfDYJtdMcEwRzcAGQAejZN5dhixRMkbQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhU8HgDXN7FBw1uOJpu7kNVpR5E8aEUXJAHoWwzE8PJfadg62Ajevwq9zNW7+NfMv2RYHNdZN7kCCv2mm8PTKEaWgebNZTy5JY4ueTKhVRoZKKTKnpI6fgZf9nNGV4nmgo/JLtcdFkeH0Rq3GkoWhcnQZd8Gbdj8atR22kjldxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWo+Lk5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6266CC4CED2;
	Thu, 28 Nov 2024 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732807282;
	bh=KwPswigeoYrfDYJtdMcEwRzcAGQAejZN5dhixRMkbQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UWo+Lk5vNuDy8tBOM3Ww+BPuyIt360DAkV9VWzV16v6Vu7OQzD6zf5o0T2UAII2XZ
	 Rf1v1jaNZoQMXTQUH1vuAPdLbNLDkEWj4P457t0j971xTFxfz/q5PJv6ohO+7DDBet
	 djQsZu+/QKETqRULA+VPz1YtXfAtbb2tCD5lwV5mhFF0dRFKA2p80moHjQjxmvTIva
	 COfO8GkJl4S0pIOWPicXB4fFjL3eJ2qfdoCeSEmzF4gSX+t+SQ3wpIwDfMOuB8ce2q
	 8/N9NbTCfQvT/4/QrLUS6mjPHI12PFqFLrwsPIuWa0lG793OokYnjzd0JfcM0SuF71
	 hCDkZfYzUSa3w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df1d1b726so1088785e87.0;
        Thu, 28 Nov 2024 07:21:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJuAvYFcm0t30QsOhWkQk+BqQCi8TFWeGoOgoPn3ES2uNnXXpuVLALiJBJXkAVT7h6nXUS0VN+sNvFgq90@vger.kernel.org, AJvYcCWWq+a6jCFThDecuGpR0rSCDekDbuKHEho+mHMqkyLjQfiElXX8BnQD5leYnQFYhkrv0Aj6HLDyZZPh@vger.kernel.org, AJvYcCX3BwI9HcBiT2V5Ca/QQrsBNn50mDIEFalPXRBcJfpdcAQrXMaa8ug6pbAa2p1rNkYpILwBNrs8/KOaBCDf@vger.kernel.org
X-Gm-Message-State: AOJu0YwFha0rD9bzKA9l2n7foJB6fS3a9IokI61zWiP51WKWrbptz763
	a7h7zeo0LSHeW40f2L7RBpVsgEa6xi3eswEqv88hvdqShommKv7HoLjxtV5epR3uL6AXAQO8lBn
	45/RA3UJszwkvFCsNnJZkf2gQa4w=
X-Google-Smtp-Source: AGHT+IH5AzxePrQfm/g3C9Rp5Yo42677DLUre4lr1G2GByUnqv2vCF3ncOHe8H5mYdDAWk6MQDbEnY2XInxuuPyirs8=
X-Received: by 2002:a05:6512:39c9:b0:53d:c322:e782 with SMTP id
 2adb3069b0e04-53df00d9c87mr4513660e87.28.1732807280609; Thu, 28 Nov 2024
 07:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com> <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com> <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
 <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com> <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
In-Reply-To: <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Nov 2024 16:21:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF0Mmr5CyyeKXO6-Ot+5cfSV6t2jPmn+TGVyjUsoYwGtw@mail.gmail.com>
Message-ID: <CAMj1kXF0Mmr5CyyeKXO6-Ot+5cfSV6t2jPmn+TGVyjUsoYwGtw@mail.gmail.com>
Subject: Re: UEFI EBS() failures on Lenovo T14s
To: Johan Hovold <johan@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ricardo Salveti <ricardo@foundries.io>, Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 15:46, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Nov 28, 2024 at 12:05:09PM +0100, Ard Biesheuvel wrote:
>
> > If you're happy to experiment more, you could try and register a
> > notification for EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES using
> > CreateEventEx(), and see if it gets called when ExitBootServices() is
> > called. That would at least help narrow it down.
>
> Thanks for the suggestion.
>
> I see the notify function being called when I signal it as well as on
> each ExitBootServices().
>

Interesting. That means the EDK2 fork is fairly recent.

FYI https://github.com/tianocore/edk2/pull/6481


> With an efi_printk() in the callback ExitBootServices() fails as
> expected, but with an empty function the kernel seems to start every
> time.
>
> Interestingly, ExitBootServices() now succeeds also if I add back the
> CloseEvent() call. In fact, it works also if I never signal the event
> (i.e. if I just create and close the event).
>

Is it still invoked by the firmware if you closed the event before EBS()?

> The patch below should suffice as a workaround I can carry until the
> firmware has been fixed.
>

Ok. I'd prefer to get this fixed on the firmware side as well.

