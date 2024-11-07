Return-Path: <linux-kernel+bounces-399461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A49BFF44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358391F229B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84C1991CD;
	Thu,  7 Nov 2024 07:41:26 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089D194C7A;
	Thu,  7 Nov 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965286; cv=none; b=Jpji6qvt89aTgKFqfmnBfqFlqjoFSv/1O7yoShd3AZZItovkCgxJjOAPclbgRdijjt3HnHPdCaWAXkTXVnyNN8hkBH4EtSpmgSeTgs3RtprnvR/gnrElgqK+cG+IvnJS3E3D+8L/RWDBWWl61OdvEzcB6ReudR8pX4bwuHktRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965286; c=relaxed/simple;
	bh=XXL8Q7XOR5Z9axA5mRP86M9hsbR0wLMYpRTNBXhuPBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaVK6/lHT5DtxHWH0xjCRg+b0wOW8D4Z82FaAKDgjwY/V8/UB5FF6EkTpk2C5vfzN8lmxz9ObmpMHWNfUYoUez4doDPptc1o7gUglf1noG6rXj4H2c1nld7CJFd5mKihdzFQqleYuw/RSkmoTCkPDl2omBBgxN3OokIOzMDd06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29047bec8fso1436257276.0;
        Wed, 06 Nov 2024 23:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730965283; x=1731570083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY2fnWRrBmWwfs0IL3d1VI8YUuUEtOl9zyg5K15/Tcw=;
        b=ZAQF29qNA7iq9lv1xIE5VXcErTAj8hiweUUQyrblNYaA3LHsOudTh0o397Y5ugEe9l
         IjHtHe1Pt5+rDe4vk4aF9DOkyf4xZ0TcdJEv94jredOsaiLTEmMAMDSqsRonvEib0EWV
         xcOxifIr597fH/u+rAVxrnQFcXEg8in3AW3g6nDFgoIBB5XuCkUzKfmtnp1nCEhfjFhx
         1+u4UlS1omhwIlgG94dw2G9wNvgiHaMBXRef9xQYOLXajJ/ID6y4/DNF83lcDVVCW9Q9
         jCic7hEGXUMSCSMSeLDr3vtELVVcuca0qSEC7U4eohj8kHBTn49MKRUKh7Aw7d6bqiTS
         9k5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjGl9KzMA5Tw6HcBg4wgoM+0Mkz2nhj0C7d8ELrDTl4hJkuqnaVOGnSLu5hwIreIwu5FdEg8HY1H1Jv8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSekz2gepz29b7jScjMAZB59h5aw5wylLk4pfdAc9Tx9uafyj
	5ilpylJDhDDvcD31ZdHKoT0Pjvl5edO5gR24ZcPkPCpkgYw9xDtv/x7gLmJb
X-Google-Smtp-Source: AGHT+IFLJFz0dU+NtpIdIU7mELbiJvNjqIi6Q1GdGdfDNJA4VU/VZGp0v71ml+t7B5yiuuolmlE29w==
X-Received: by 2002:a05:6902:2891:b0:e28:690c:8cc2 with SMTP id 3f1490d57ef6-e3378827639mr57124276.21.1730965283022;
        Wed, 06 Nov 2024 23:41:23 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee15913sm164609276.12.2024.11.06.23.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 23:41:22 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2e444e355fso1435849276.1;
        Wed, 06 Nov 2024 23:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcFy/JreV4haU7iWTZLAxK0R/A5TGiTZIPg13Ln1n56b6xeEGVJoF4gCZD432+VEkZnJellc5eRD1k/Kg=@vger.kernel.org
X-Received: by 2002:a05:690c:6c86:b0:6e3:6a76:ce45 with SMTP id
 00721157ae682-6eacbe85aefmr19850967b3.13.1730965282333; Wed, 06 Nov 2024
 23:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR13MB5632F54DCBDA0C74370E531FFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632F54DCBDA0C74370E531FFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Nov 2024 08:41:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUMap1maZCmOqEqaxNWHKRiwg1QaN0W9j+8iPkPyHEMg@mail.gmail.com>
Message-ID: <CAMuHMdWUMap1maZCmOqEqaxNWHKRiwg1QaN0W9j+8iPkPyHEMg@mail.gmail.com>
Subject: Re: [boot-time] RFC grab-boot-data.sh - tool to grab boot time data
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Thu, Nov 7, 2024 at 2:26=E2=80=AFAM Bird, Tim <Tim.Bird@sony.com> wrote:
> I'm writing to introduce a tool that I'd like people to run, to gather bo=
ot-time data on
> their systems.  I'd like to collect boot-time data from a lot of differen=
t systems.

[...]

Thank you!

> ---- script grab-boot-data.sh follows ----
> #!/bin/sh
> # grab-boot-data.sh

It's always a good idea to run shellcheck on any script you write.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

