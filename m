Return-Path: <linux-kernel+bounces-329351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BC979046
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3606B2345E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24F1CEE8C;
	Sat, 14 Sep 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiMfdwfq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B28F7D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312127; cv=none; b=cJZvaD3EAcuijo+7l2AwWpOWqVHNHviwJdW6Y0H9MBky2FF5iTyjB9LRTLEZ7g/Wv9sYGWbqJYHUch4APF68Tf12Ty8XNCBAhoUtXMfLwZWWHbQb4fpFdOWY7nDMoGX93ZMBvto4CnFrpfmdJP79d48lVzjXDYluVgvqU4Onh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312127; c=relaxed/simple;
	bh=XsoSN9idZ7w1vGfxQcAYT2cp/v55f8wnURfLYiQtq74=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kaTPuDPq91PhDYC/kEPnfH6uxwhO1w4n/BW5C4NAekMBrVmgAvrip9S1fT3g+YWmB7ufD3nbcVX1QdH+nw0/xdEmNgE75gcRvhrf4wKOzigcD4abAtj3Bpj/51S1HD6rw1hVixUE0EeepDhC/frzIM0T8tsrhht2w/wZ6uqIwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiMfdwfq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726312124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5hWv2p2YsLipAZ5vTTG2ulS62USpNXTSCdiYtz6i4es=;
	b=JiMfdwfqujVV8R4KeLo6G1nCe0axctsVSi0d5Apr5no4KmrtiPfO4QmSuMl2xZi6afv+GP
	Agi9TlgiykJuPZMOZI9Of0o4UptPN0KxN7oVpNvX9Ie7wCTk52f3g0/pH/Sa/SHI1q4WYV
	sQymlPWxxYj9CntnIylOWLfDg9I075A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-XjRgLm8TPcaqCplGoVx3MQ-1; Sat, 14 Sep 2024 07:08:43 -0400
X-MC-Unique: XjRgLm8TPcaqCplGoVx3MQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f4f43b818so67417345ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726312122; x=1726916922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hWv2p2YsLipAZ5vTTG2ulS62USpNXTSCdiYtz6i4es=;
        b=ROSqLd5W3nxGq/H9bBd3BToOImpNi2YK+tSgZYjEherT+H4iuR7x9/e3O5N8JSIFy6
         E4l8bB+709l2y6FDzHEkGwL54GVGEhHl6b2J93aWE2Alww7r6jkTg+hlosZHvs8KQ42S
         udZe5FM7ADJxSRtsU19z7HE88IqYUyPFmqqiLeKpSfkTuPFAoQZP2bLmTOk/ZQ7Tgbs4
         lJ4kZoOqgG0sAyWGrpz7vh1upTgT7XrpwyQygNfSFG4Q1BG6DQG08Gl2SFloyNkhp0DZ
         ExOrFR8JS5XMgSmgLHWwSRjWVmEr95D7gLI+NCFO/rx+zutvQv5xXQF1FOUV7OYRhLRy
         2XDA==
X-Forwarded-Encrypted: i=1; AJvYcCXl3zatGBAVO3p5DtuTD4J2IoYAGhPsTngLnvRo/W2N0/N15Qte0S23REVrtQA59fRcIq0EnuUPtDA3Qq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlealnm1huJU4KbMkdA4aOQTuUYoCO0cpiVqTY5+iD878Y9ZgE
	Eo5yDFeL7Zkl2ESd2OTG4BXJy/HBOkpSAo60KHTmcKraSzR+z8s7EijHFqET2wQTNzpto7a7j0h
	c7EKHT4YSg9FBVo3rfcYhgVBM8Kw553iolljyHUB9iaEiD2SBtEPjO89Nf8ZwBJRfJvIHzCA1rG
	HU0dKwh+V2c2rBiu980eo1qS+8SalULkssXp7r
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id e9e14a558f8ab-3a084611b38mr80010875ab.1.1726312122586;
        Sat, 14 Sep 2024 04:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLEgZRYuK78TvhEpzPipQjXBQpjmz90/JWHNwPzBDfQVodpJaRcUvzxokERl4ytbOKVYQGFjB3CUpDJ2OizQk=
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a084611b38mr80010695ab.1.1726312122279; Sat, 14 Sep 2024
 04:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 19:08:51 +0800
Message-ID: <CALu+AoTKBRGgZW6JK19AV6QRTi7_eCzJbh9JCKENxsL7t061rQ@mail.gmail.com>
Subject: question about RMP table fixups for kexec
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Ashish,

I'm reading the code about E820 tables related code,  I noticed with
below commit you updated all three e820 tabes including
e820_table_kexec and e820_table_firmware.
commit 400fea4b9651adf5d7ebd5d71e905f34f4e4e493
Author: Ashish Kalra <ashish.kalra@amd.com>
Date:   Fri Apr 26 00:43:18 2024 +0000

    x86/sev: Add callback to apply RMP table fixups for kexec

...

+       if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+               pr_info("Reserving start/end of RMP table on a 2MB
boundary [0x%016llx]\n", pa);
+               e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM,
E820_TYPE_RESERVED);
+               e820__range_update_table(e820_table_kexec, pa,
PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+               e820__range_update_table(e820_table_firmware, pa,
PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+       }
+}

A question here is, have you tried only updating e820_table and
e820_table_firmware?

I do not know much about SEV,  if you update e820_table, then the
memory range will be reserved in resouces, and kexec will not load
segments into the reserved ranges,  during the 2nd kernel bootup  your
code will be run again so I assume it is not necessary to pre-reserve
in e820_table_kexec and passing to 2nd kernel.

Could you confirm this question?

Thanks
Dave


