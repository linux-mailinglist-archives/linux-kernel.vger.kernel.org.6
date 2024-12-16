Return-Path: <linux-kernel+bounces-447376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DC9F3159
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6029D7A2960
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA14204C2B;
	Mon, 16 Dec 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="gXkj01dN"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AB946F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354940; cv=none; b=n33i2GpHdf3LVo+vzg6wONMFfKap9rWecnw1niNLx1/MySa4AmGl9NPPDSx3SYRy+m01sfoUhVf64iqPwXyX8/0nUrt4ce3kBMMtJtNQoklssLGZqxvgR9vOfVtSXCe2gKx0ILD6njqvAncWfJOo02oBlS/JV8RYdDXcROc7LO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354940; c=relaxed/simple;
	bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AZcV3PxvWOEsyRLZeQIM84vyIWdA89RSgO2WOehMAEv69cF+UOqjsk0Tbo6zrCoqmouBNJIzoJ+pgNNgfd8aUFtnph2mN0mPiaoUFhHlowtuKymVwm/wwa9tHEloLQLfCWr4RZLQDH8Tkz2S8D1ceM9d5X9/eG1TOb74lSgfJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=gXkj01dN; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afdd15db60so1022693137.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1734354937; x=1734959737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
        b=gXkj01dNLu0ItVGkRESYksh79NDZtJOwjviwFnlGGYhvqULc/eq80UKO+eJPotxf3J
         1nRbb+w2ktG18yFh6TL08Gninsm5exIkrJc+G3s2WDjdp/LT2F0Qp9hYd3OgRvU9oENh
         UHRhJniptgL3TvpI6VBSXPiUfH46VkfgiFS0jZj/M1fRIAFv+JYmqafCUcpYabe7BLjc
         xr3J3LkK5on301WbB1zacOuwXz+KJN7JfzTBYtC4zXhZrKUTqN3shq8zcNeyVTPYc88j
         n3AFlAssvdjUdPktZcz2U4kUR1P5oc9cusCFihH2PggCIP4iEBbJhvsmgqNgQQBHn4SF
         TE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354937; x=1734959737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbuH35S5nW17BuGhUu4QZP19q/B3XFW2NhnxtO6rfms=;
        b=Onyg4184GW5PglFC5Ab4xBdisJo7GP+DvlCjqkmg9PWlMGv7bYV57v/eHfHzQxlPMH
         I/keaf+/rFTOumzUxceoOFZbLskPM59GzURgdyM98VCCliRcN33yF6JYfgAtrzBVI683
         H8sZWHZudK/AkTQg6+F6GeHt5dbhuibRAQRbK4MbG9PTGV9XO8TKy4TUPPgYeZ1N5+BB
         jpojJtTee2DtoAj+BPi4/WJZ7jp+v2Z1WC0eKqJz8vPCRx90SEHIUbH/sDlI47jOMbEY
         CZdJxQAHb6WdDTF4pq//h5GZZ4yVtZNnv094C9AI5RKMmqRMyPbMx/JldKTrVv5GZnWP
         zDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwY0bl55hdjxAqgamwFo/BB//nZBaqCnr338fxSkAltw4SdzDrisS5+1QCa5HmGbj4Z1OktdIbYe4Wx14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSE4NC7zqibt/+Qg0mqlBNIR0K/W0e1U73OoIV5XaObO4Q6sh+
	wqTUWq/j7mNPHcX6cdOXDOanWp+GoLpUv3WDE86M7WPByY6yjqYV7xt98pO+fNUw323ZPUSlIWQ
	gSYTa1KsfD1r+bw8FehHi903ygwOFPOaZ9qhP2cZnVC9rbnA5yoM=
X-Gm-Gg: ASbGncuekNlshr9wAb2v188UyDUg/+fpfmXTq5AvRigb3oo75lOB8F/c4FXK7nxQfxv
	ppQ07c8PF7bX7Fzz9cKfZoWVebfCsZaONLeUm
X-Google-Smtp-Source: AGHT+IECqcNIM9HG7DmQeCQpQHlXqrnoyQq6GT6H4Sbdz5JiP5NTyQoK0DFRlqfZM3HFpa4cYBgR8nz5UX/0F6tTu98=
X-Received: by 2002:a05:6122:16a0:b0:518:778b:70a1 with SMTP id
 71dfb90a1353d-518ca45afc8mr8931883e0c.7.1734354936817; Mon, 16 Dec 2024
 05:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rostyslav Khudolii <ros@qtec.com>
Date: Mon, 16 Dec 2024 14:15:26 +0100
Message-ID: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
Subject: PCI IO ECS access is no longer possible for AMD family 17h
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, bp@alien8.de, 
	"tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am currently working on a custom AMD Ryzen=E2=84=A2 Embedded R2000 (AMD
Family 17h) device and have discovered that PCI IO Extended
Configuration Space (ECS) access is no longer possible.

Consider the following functions: amd_bus_cpu_online() and
pci_enable_pci_io_ecs(). These functions are part of the
amd_postcore_init() initcall and are responsible for enabling PCI IO
ECS. Both functions modify the CoreMasterAccessCtrl (EnableCf8ExtCfg)
value via the PCI device function or the MSR register directly (see
the "BIOS and Kernel Developer=E2=80=99s Guide (BKDG) for AMD Family 15h",
Section 2.7). However, neither the MSR register nor the PCI function
at the specified address (D18F3x8C) exists for AMD Family 17h. The
CoreMasterAccessCtrl register still exists but is now located at a
different address (see the "Processor Programming Reference (PPR) for
AMD Family 17h", Section 2.1.8).

I would be happy to submit a patch to fix this issue. However, since
the most recent change affecting this functionality appears to be 14
years old, I would like to confirm whether this is still relevant or
if the kernel should always be built with CONFIG_PCI_MMCONFIG when ECS
access is required.

Linux Kernel info:

root@qt5222:~# uname -a
Linux qt5222 6.6.49-2447-qtec-standard--gef032148967a #1 SMP Fri Nov
22 09:25:55 UTC 2024 x86_64 GNU/Linux

Best regards,
Ros

