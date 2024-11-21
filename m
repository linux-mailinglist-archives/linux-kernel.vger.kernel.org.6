Return-Path: <linux-kernel+bounces-416835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF399D4AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146541F218A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9B1CEAB8;
	Thu, 21 Nov 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcLanNHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6E1C305A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184919; cv=none; b=cyaeV1/0HoTP3BviAtIuQmLd0dDmF3HPMwLTxhnOcARa56cygRYJyFRe6520Nq4yHVgQ95enBdmRtFgBsnI9FCa2mbbWq6e3f750GbyFvXZAaF2FWHM5vXEUfFfR5S5k4Lkl0T0QVMpIb9PqfZXcuaRqevSQpo5xtkAurCwA7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184919; c=relaxed/simple;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGEGrx5B0/UncX6b+LJQ4OC3j7In3QEW1hG3GDF3yAqECmAPsYDXA8ZwWetw9Pos9T4UzMc3wYuHvqqBzeRQrREnAWZsUvjVKGQJYBPrKATh6CRWi+QxLKKDodvMa7R3rZiXE0xu/fJCf8Hn+Mu2Iz2beY79Ul5VObr61J3Jxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcLanNHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	b=OcLanNHGy6Fv80WRM3xvdFlONfK4BToATp2/cCEmKkX/JxK5oXHrU4TU0NWBZgEDyjWQQy
	HhptP/efyX2mh+pj2GuvZYoEFl4mXc3VXNmwnLQioISgHBiNqxoiidTa6VkXfSTAmU3TDS
	1HkH3uHpMAJJX/hJYDSe+uUw6BDbpUc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-OFhNSCgmMbqT3Pcwpxzrtg-1; Thu, 21 Nov 2024 05:28:34 -0500
X-MC-Unique: OFhNSCgmMbqT3Pcwpxzrtg-1
X-Mimecast-MFC-AGG-ID: OFhNSCgmMbqT3Pcwpxzrtg
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-85722f5d206so219252241.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184913; x=1732789713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
        b=JgrtzyGvbM9kP2PIaNKrsn8z3j/pemwbHoRgpA73zyOLUendOl5z+9VqPjGx6+cVAA
         EICoRcjlsV6z5rFoRo3fgUL3OKyKyjavFHbsJoGz5cCvRY2z7aB/oKxnc+PX1y+L5HrF
         YMshQ/+4pOphqhBq//I+34fl8xF9oV5dHxDiKdqocFziqgxvwzKZ1pKR2jW92QG7ijjL
         mWlvC0BDLwHI8cEccK6Z2oxgfIDYfwAeTDH7GepgIRK9DzUUVkAr5zNCfWr5PC66VOnm
         s7DCeLdPEIdWFdVlEgskbD4N1jxvU5zW34KBJlUFsEnv8CohIiS59e6A3Hu3ehJY/JtN
         vafg==
X-Forwarded-Encrypted: i=1; AJvYcCURH+rkt+MjXnTiof8Jryxpl8VRnXz0H+axdr0cAG68/zrL0nOYHsA6cjZQkDzMGFA+bBwTuKzCTBsQVx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdP2i078YvpXLJTusdohDmj/EaDw5DPggbrHJBNyvOAUi+HhUF
	w8bR32lTQ16rHPIKzdmfvbV7VvIagnff5b9bRuDf8FrED18KrLdoWm9WoT+CA3UYLWMsC5ZzPX4
	2vGkV2+OsptTuc2bzL8MKeJrQb+gQRbE5HT0LsXzsBVzrJvwgBk1TGhqNwtUyIQ==
X-Gm-Gg: ASbGnctLep357vUu2JaMEIIvujFkbigQ9GtjqTTwgd77+sL+79VY0K6ACYajGwVbJ9K
	Padx6AkpLh1VpK1r9IHsLwHkDapU5MwxTBwGRxvG7c9LakR8TRhHWo/nR2BYCU+KwgL3WNIxI0A
	5lrhZb9xA6cBa/R403aVeGWPoaeLOjeTw8vM3vQDIYYR6X5YaI7G37/w2ZRnnXm+oZxJaZz8sh1
	KDUSGg5wrD9FTpx/w/DzUbH2mk6KzkLf1zwCB90gVSXktq1OuUxXsF/umCd3qFh9L5Ey8sfMw==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794351137.13.1732184913236;
        Thu, 21 Nov 2024 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvNgLLYktvPtaJaBpniqt/2h5wYTqtk6DE591nq3WhjRfvS6UaO9CP9BTTqW5PKVBbtxtxGg==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794340137.13.1732184912953;
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21517sm20273601cf.82.2024.11.21.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Message-ID: <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
Date: Thu, 21 Nov 2024 11:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: Dullfire <dullfire@yahoo.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 10:22, Dullfire wrote:
> On 11/21/24 02:55, Paolo Abeni wrote:
>> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>>> From: Jonathan Currier <dullfire@yahoo.com>
>>>
>>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>>> table entry is read before the corresponding ENTRY_DATA field is written
>>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
>> Why the issue can't be addressed into the relevant device driver? It
>> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
>
> I considered this approach, and thus asked about it in the mailing lists here:
> https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/

I forgot about such thread, thank you for the reminder. Since the more
hackish code is IRQ specific, if Thomas is fine with that, I'll not oppose.

>> A cross subsystem series, like this one, gives some extra complication
>> to maintainers.

The niu driver is not exactly under very active development, I guess the
whole series could go via the IRQ subsystem, if Thomas agrees.

Cheers,

Paolo


