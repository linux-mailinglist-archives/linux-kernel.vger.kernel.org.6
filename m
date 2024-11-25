Return-Path: <linux-kernel+bounces-420684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F49D8221
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DC6162B04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C218C92F;
	Mon, 25 Nov 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaIOkTBp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64A18FDBE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526559; cv=none; b=a9NH3Iy6pVU6E13umhXuHBcvJs5f1MSI1G2KfVfYRn4bBK75xPCrCH33A78Ix1gHi0AbDIIr8BIDIV/eNt+6z4UkifsF70PJuGzLJw0upTREqTsSCylS0Mu38MCOiY57NuVDvLgXMJbFu4+hESOoZpX+t9fzNnvR0xhdH/RAWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526559; c=relaxed/simple;
	bh=CexHKQl3FUmR0SZEFg5iSm6K5rX5Gc58iLRISMa0v0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpQxALrEfwwv7WWscQ4oJOfOlzl+vFT52VK4h7WtHI6RiHhbDvHVG+rLTUgksLly9Daea3cLfpQxrShjFBhRXG3KjoVmyXoH7oTO4xZUk95W7d35povq/ZaChUYViAF9tg8OJe88qdJne1hVOOS4cAFkjobvQJL+aJxWNBhArN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaIOkTBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732526556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OjrF0F+IpPYISzGBZP9zSBbVNmXB9V/jVcRVnoDrnQ=;
	b=QaIOkTBp33XLCwW7Y5/R7ADuUQWJqpy89LugJtLbTc+UEWHPkMSOL1Z8DuAPQExk5GMyR8
	5UswOQDJ2bUW7rYks+xiWUTj+vGNe2kVr0TgrTNH9k4fPBZR1BAW/lwJ7LaJ01GwSQbz9o
	Cg5LUTs6sgDZbd9UNP4HTv/UMrMbfTo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-hd1ipsGlOMymrFphMq5AdQ-1; Mon, 25 Nov 2024 04:22:33 -0500
X-MC-Unique: hd1ipsGlOMymrFphMq5AdQ-1
X-Mimecast-MFC-AGG-ID: hd1ipsGlOMymrFphMq5AdQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382341057e6so2107625f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526552; x=1733131352;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OjrF0F+IpPYISzGBZP9zSBbVNmXB9V/jVcRVnoDrnQ=;
        b=v0sPffvwLc7D1eY4+bbb9vVXtXBWvFCyzsdlU791jO5W5TOroHJ8F0SHX7xfmaKHr/
         zqATrKqE5Abh/sh9V2LCv4j/909PvdOT7Px1+P7/rdDQ6b0/4/638WxXSMAgmBW8b42d
         Cq9PZjcIZKmwmHQar+juizEcYsV/u/JqTtbst4yGikUOQ6B/VKn2Kvj2LYBzN/lwqhRL
         TyUdgQQul0snwEwLnJSxhkLCIoAD1ts9gMAOS5nMPETveCr959GiK6IIVr7cixiNjlw+
         YMXDBWsUucDjbbBChF4Z9I3vRQlVsPIjOsCySjw0uO0pmtzMXUExiDYP2M6k+juZHtfC
         arBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHDOmT96DKLx20yRgsYp9Ktpu9gCFDo9y9luWQXnuFeHUoFR7MXEGz0fGg1rDCFe7sUWlzpiKF6O87vpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Q66PhQ7pR8Fn3c06sxb7HwmHiO6C2xPPbhd+oKq31pFYXtXS
	l/LiyA8cLdft9GzhNQpsgNVgHCXBq2fuv3qBedoKUy1uAhMXgnbRgU3ua9szlgmI8dkRWTeWMBg
	5ePJ1J8vcJd3cAyxHIWjmyBdwYfcyd9YwNPFI+5ucKwDpOWhxpFFCwSzBCLdiBA==
X-Gm-Gg: ASbGncvJ3c3QRRc2M1/Tm4UEoaYg6L37k4W1ShT9CSTLCX7rglDHxAM9eTSDCYLn7lH
	C3XRS3mUa+i5PP5KjW7FNuL8DN6VMNgnPVxi4fQfwNBHMvVSOo4dCcr+7BtLVL5DVRcG2ZFkZdr
	29atIMhicAcGYqZ86ZUXCHKRm+e5c1iNgG3PJnCzGAvyixOjYufWJCWZ/UGCpBQj9bD4hlYOKmx
	b5qbpn5TzAC8ExsKDRx6+JvvzzPDqZMKvco6CUzNoOfeh0jTK4d50zmaDxXDnoo5Re3yCPmTb95
	u/P31pWx1cIgccUqwceAa+nFoVhtlfOj
X-Received: by 2002:a05:6000:210f:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-38260b486ccmr7455001f8f.9.1732526552585;
        Mon, 25 Nov 2024 01:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwyCHgi6TDm1d8egePLc7qwiwGO8MXpIKcAGGB2QysITZzSXmv4g+RZJTgzvGV+e5dLLCdDA==
X-Received: by 2002:a05:6000:210f:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-38260b486ccmr7454979f8f.9.1732526552281;
        Mon, 25 Nov 2024 01:22:32 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9dd2sm9735534f8f.26.2024.11.25.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:22:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Radu Rendec <rrendec@redhat.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, robh@kernel.org, arnd@linaro.org,
 linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241125-eminent-devious-zebu-ec2caf@houat>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
 <20241125-eminent-devious-zebu-ec2caf@houat>
Date: Mon, 25 Nov 2024 10:22:30 +0100
Message-ID: <877c8r4qi1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> On Fri, Nov 22, 2024 at 06:09:16PM +0100, Javier Martinez Canillas wrote:

[...]

>> > FWIW, the OPP table is defined at the top of r8a779f0.dtsi and
>> > referenced just a few more lines below, where the CPU nodes are
>> > defined.
>> >
>> > As far as I understand, there are two options to fix this:
>> >    1. Revert the patch that allows the cpufreq-dt-platdev driver to be
>> >       built as a module. There's little benefit in allowing that anyway
>> >       because the overhead at init time is minimal when the driver is
>> >       unused, and driver can't be unloaded.
>> >    2. Modify the driver and create an explicit of_device_id table of
>> >       supported platforms for v2 too (like the existing one for v1) and
>> >       use that instead of the cpu0_node_has_opp_v2_prop() call and the
>> >       blacklist. That would of course also eliminate the blacklist.
>> >
>> 
>> Agreed with this. Likely (1) is the easiest path and (2) would make the
>> driver more aligned with the rest of the kernel (that have a list of OF
>> device IDs to autoload / match instead of some custom logic).
>> 
>> But I guess that (2) would be riskier, since not adding a platform that
>> uses v2 will cause a regression.
>
> Also, 2 probably wouldn't work. Devices under /cpus don't get a struct
> device created for them, so it wouldn't probe.
>

Yeah, but the cpufreq-dt-platdev driver has a of_device_id table for the
OPPv1 that matches the actual SoC, not the cpu device nodes.

So for (2) I was thinking to do the same. But yes, agreed tha (1) is the
best option here.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


