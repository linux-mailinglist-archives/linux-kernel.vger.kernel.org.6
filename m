Return-Path: <linux-kernel+bounces-384595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C19B2C10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFAD1C213BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35A1CCB54;
	Mon, 28 Oct 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpDKFW4X"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5618FDA5;
	Mon, 28 Oct 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109301; cv=none; b=mwTeKC0skb6ket352wtHTc6iLHIHcLxIEEenswmLRTkDGQoC6aQPfbaWLt0zwEjWJvdT68iatX/1LuZTFwuWQnkZuB3ezl03ScOU02ENjCguUBo714sYGNhRr6lSmFXXfhGQ2lqqtkSn0hL9aAkM3/HY8IATUCosg26MVkvmdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109301; c=relaxed/simple;
	bh=P36JkBYQDHEqLeT+pG8XWk/w3Yl0a7/KZ5gLE/mf5c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=pyIJdkYVmJA3dX9UVCekL7aihHK/VHJE+9zoHLGQbbtmpuhesnE6tu4Z0NtMAvMgjC871tLsBY1d2r4xTbjHAFvi8HI85fmzNB7VAfLjRe7HuFHa+mbP6l5HXkmHCQJDuvfO9NRWLHgKalr9oys4sid70gDOggVv3xVTD9sPZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpDKFW4X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3547370e87.3;
        Mon, 28 Oct 2024 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730109297; x=1730714097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P36JkBYQDHEqLeT+pG8XWk/w3Yl0a7/KZ5gLE/mf5c8=;
        b=NpDKFW4Xo6EuCdbMtbo8W4Tf4fZ1dLd8yHBT5B8ljz9R1i67FldXvnExK+kzWxSolr
         i3sMuytRoSw4Kn933U7ioCBeqsYOxKXsnw8795iuRDQgQ+QLxf3Ht6uASrMsZhPd6jiB
         +RMsF4Z0iEyxYyjF7ClF4tpEh9MA289t4S+Ft9fnzF8vQSo6jpRQjbXtFnSotyNgEVDj
         0pgJ3II0S0mhdornGS+1pC+cQB00Bchg87HIaCbahqh3VVbNkDhy9tx+PftmUUQj2Mwm
         Drl2r37IX3KDLlPIgks/ODQJDbSLB29a9bYvgc4O1q7RZ5CUtZ3jYoJKvuuZAMNk/pMi
         JQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109297; x=1730714097;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P36JkBYQDHEqLeT+pG8XWk/w3Yl0a7/KZ5gLE/mf5c8=;
        b=Pvjj8NlHFwDIwlU3pdYBI2UvxL+9/kdmWEbijwEL7woM8hTbY+FY5/Ky5Ldy8Gh0Y0
         giXE4SPkxC+fz+/1/nuyLz988ps7QOZd1kIXVqkO40byrWmscq5A38a+6RuakBE+PGYN
         3LAHi9FSx2x4gtPhELVzRo7uPUOXRU2fGEIfOc0/LkHEvGkDqU8I/QVOg2eMphuxYGk7
         Ei8+PsKsIUFiy8Dnie9zkNz/HYwSerrMsSXIdcsNfPTUR1dlBHU9Qk3BVl0q5wdL4dA4
         oDQxabnz7dxGxJXMdEOdeWdW0xWvrF1i3Gbe2uvwSSrqcJ3Ijbr8Qs0jK8uQVL3b2LMr
         Ztbg==
X-Forwarded-Encrypted: i=1; AJvYcCVzrDKB5IZhm99g8KugRaKXPM/u5R4sHETF2vx2U6ppH8GoaQY2yzVFx/nAr+W8biEXytLenYOiJ+BlMJQ=@vger.kernel.org, AJvYcCXFRESYQIkcJ8kdcRu+ODFmODv9hbwZCBMEdnZp1QY1tH6GyeQ2TD9zhvlVj0b5cAkzbsATnf9u3Mtf@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQUZXQBOu3OzdP76NYRUF4BlZ5/KahwRApje14x4b6SlaibXM
	94n9pzzHDe5AnSw5NoTu+dZ09j2jMJ8SiFylaDzFh3UEb0dB2ZnE
X-Google-Smtp-Source: AGHT+IGZrleTIdqaBkZyctSCWmO/L2jXA+IF+uqKtfLWnenY7xRCCz9dC1JfC7k8oOJ1a9ZzCJw9Cw==
X-Received: by 2002:a05:6512:3c90:b0:539:ea54:8d22 with SMTP id 2adb3069b0e04-53b348d2696mr2835654e87.18.1730109296730;
        Mon, 28 Oct 2024 02:54:56 -0700 (PDT)
Received: from foxbook (bhd254.neoplus.adsl.tpnet.pl. [83.28.93.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1035465e87.73.2024.10.28.02.54.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Oct 2024 02:54:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:54:51 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH v2 5/5] xhci: Correct handling of one-TRB isoc TD on
 Etron xHCI host
Message-ID: <20241028105451.0e2e92a7@foxbook>
In-Reply-To: <20241028025337.6372-6-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

That's a bug I'm familiar with.

> Unplugging a USB3.0 webcam while streaming results in errors
> like this

Not only unplugging but also any random error due to EMI or bad cable.

> If an error is detected while processing an one-TRB isoc TD,
> the Etron xHC generates two transfer events for the TRB that
> the error was detected on. The first event is "USB Transcation
> Error", and the second event is "Success".

IIRC, it wasn't just Transaction Errors but any sort of error, like
Babble or Bandwidth Overrun. But not sure about Missed Service, etc.

And IIRC I confirmed that it was *not* the case on Short Packet.

Also, I'm 99% sure the problem is not limited to one-TRB TDs, but
it occurs every time there is an error on the last TRB of any TD.

> As a solution, we can set the flag after the first error event
> and don't print the error message after the second event if the
> flag is set.

Yes, but I think it would be better to use error_mid_td instead of
last_td_was_short, so that the TD is only freed on the final event,
not on the first one.

The spec is clear that we should only free TRBs when the xHC is done
with them. Maybe it wouldn't be a problem in this case, and it surely
wouldn't be worse than what happens with Etron today, but IMO it could
be a real (even if rare) problem in other cases when this flag is used,
so I would rather remove the flag and handle short packets as per spec.

Regards,
Michal

