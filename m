Return-Path: <linux-kernel+bounces-278569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B738F94B1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FF61C2177A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E1149DFA;
	Wed,  7 Aug 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RgsYxAUF"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF404D5BD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065455; cv=none; b=cr6iDu3rMsIl2HEkTxDMKp04arh9tnsXGBpyMXUI4C3YxusoiEp6MfgNbDnAtpixfRuUYNcdTk0uMfYQejr2+6mVQcp5iR40Jdrv2RrLv5LbVoYVOHwy4qm2JJJWuXMxClZ6wTS/6tuNtv0fmmZIIYi+uu9BgJampyUZTFssnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065455; c=relaxed/simple;
	bh=2n53VmoItSggaSYimCAgGak0sp1GPgXW4GCSJHqW3mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJXDrV4ltjs+JJyAGjhtKmUlLp1lPeDrF/CPLu2WabRsBB7X3DgWN1T4C3CarqXgoZwdyvDa/i9WIb1m0XpQ51x7Njxbvw7j12FrxJTVeDIDsH2bolLV4Gc6HGfxI5RLWSOzXdl9K4DOvhtPHT6APCxcenYVg4OsAtV6JohXxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RgsYxAUF; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-26119999171so230410fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723065453; x=1723670253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEMfhaD3iZS6libAi5LdeUZWnL4D3sNthTXlqkt7J+o=;
        b=RgsYxAUFb3vF7MEapkU8/f7bo4nBK4AoAa69t08Nw7S1njF32+FhViA5Z903qWQaOo
         InLXKFFARAlfmD7tL1HyWN1joJt2nV+YAkExkin03VEZay1hxDWErCkDjmEMu44FMH2c
         TQ5S0v7kULOuQtbZsZ3qbPomaMbKt/Y9r9/3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065453; x=1723670253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEMfhaD3iZS6libAi5LdeUZWnL4D3sNthTXlqkt7J+o=;
        b=ZOl4UbqmWtje7dO6HX+1e1H/d6EKKQKw/5tjjY5IxIWeZUKPrwPQiT74zgjeNzY6rt
         pPg9pa9Q7hl8q+s2wPTA30rNp7T0PuHBd/OCoea9VizqhWhNtpPNecfO9j0b1RzUGBDK
         kxk24uNXwhvVn/l/6I+i5kciZP/SRp8SF1HLzD9GV0NMj1vtRzR3xBrW+0k9hcZk9JNG
         BUWZ5dr3b6Yxpzzq6zO1o+N2aWlIL3KcCbSzy15SqR8lrbV1ORvJbvsP/2k4mz9vwPrV
         FRRe6K7JPBNWHAW38xVo8mSZ/74QAM6waMv3u296w7YjjWjRRaFhr3GMxICiIpAyO7y6
         0+JA==
X-Forwarded-Encrypted: i=1; AJvYcCWo4ODAT40l7Uj15nFJlP2fD0w+QzCEppJMBbb5IVs2zBW1UaIpNzekjljJZu4fPVgGcvGmD6TiqVfMcyhhpFN2KddfJ9IHkQBmjH2U
X-Gm-Message-State: AOJu0Yx094bQGwCedQRupZ3fRLlrWzlmueXalPX7yH/8C62xS0bYnp7Q
	2QLfYS9PFoW2ySjJFACEDZ89h4rqhT46g5pbj4sLmEvAsjk1HX/6w3Ki+97pm+rRY+NHdomC2Un
	F2J9YPzwHr5U6kCc2yL90lRiVZ0V28xbHmoqd
X-Google-Smtp-Source: AGHT+IF6nRdQdz7TIMlJ9a6cOnBfC0hw2S6xURKbDI/V1eg6MB6WF3lwcShTqYmv04cerkxFNnvR4myd+GHXuH35QOE=
X-Received: by 2002:a05:6870:b527:b0:258:42bd:d916 with SMTP id
 586e51a60fabf-26891d3cba2mr24275815fac.14.1723065453168; Wed, 07 Aug 2024
 14:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org> <20240806220406.GA80520@bhelgaas>
In-Reply-To: <20240806220406.GA80520@bhelgaas>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 7 Aug 2024 17:17:22 -0400
Message-ID: <CA+Y6NJHeYwikO4UFzHcchjyF6qws2zaFXnsPLMO_NKp_MEXvxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:04=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> So is this fundamentally a firmware defect?  ACPI says a Root Port is
> an "ExternalFacingPort", but the Root Port is actually connected to an
> internal Thunderbolt chip, not an external connector?
>
This seems to be a case of neglecting to add another ACPI definition
that distinguishes internal Thunderbolt chips from user-removable
ones.
ExternalFacingPort is not 100% accurate all of the time, as we just
discovered, but it does clearly describe what root port we are talking
about.

>
> I need more context to be convinced that this is a reliable heuristic.
> What keeps somebody from plugging a discrete Thunderbolt/USB4
> controller into an external port?  Maybe this just needs a sentence or
> two from Lukas's (?) helpful intro to tunneling?

Can you point me to this resource?

Thanks for your suggestions and requests for clarification! I'll
incorporate them into the next patch.

