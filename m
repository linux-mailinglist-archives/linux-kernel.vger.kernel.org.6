Return-Path: <linux-kernel+bounces-401294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CD9C185B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579D5B23AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD71E0DE6;
	Fri,  8 Nov 2024 08:48:38 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45B1DEFEA;
	Fri,  8 Nov 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055718; cv=none; b=J4J81BPiqixW09lyvXoQiMq4l9u5nGkWR3otAV9ee1VL9isYZwinkx8rH2RSZuYxTjsu5eLkgNWUNlUPcir5QWiEtjz+r2GQxHkHXAh+jeB+6cfwXHCMpqsqnKDNNmp7vyRgfkJijiVnagrdbT96sZK0FbHyp8MiOT0S8wRkWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055718; c=relaxed/simple;
	bh=1qAixj43NVFBvzsuUWAIQWmgXDo5KhH78TyCF5Iew/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLsYvtb4s8S9aZYcV5jCDw87/ByQ7d6IJv7PxGc2sWmdtNMqUBQBgSabiwegm5GycWJ9y77xVn2EqKDbUjRN89dmJgAyfjiug+X9C1r52fGo29yzTOjxXT6wfVSmTPN7/kPp/7+ARX9zVjnrR48wDtaVc7BkHoytdeJrga1LKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e290200a560so1887754276.1;
        Fri, 08 Nov 2024 00:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055715; x=1731660515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecEDt1lJOmPu8q4ArxHuiYSrzWLT2wQdzWYf+ZUa9tQ=;
        b=gRs8WAMbDafGYFwFz1fbqciISHGh2lpNUav70htaEDVxri8SWL47l01zbvK+zB3tmn
         bCTbfTFa/h77lQ9wShdE0SuSA2f0DvM43bPE9dX2j01bgEPmJ3paz6yWJ+EZ+qZp66Vu
         i3SKIa6+B35LDZSR7c7kqyL69WGT0FjYlnM9Owu+EOrZ3ee9SYPv/RypGhf81SUp5z0s
         A1Eu3dZYd7WhDlbkNfWqvVih0zo+jPUnP3321Qkw+SyXyBd/Zw3U24flYZ9pucCmKnOI
         pD6/7K9x/Gk2JYypOv19yiuHl4peG4bjf1gp3NQA25rGGMkGCVLrv+jmFq8D++A2c2cq
         Tg0A==
X-Forwarded-Encrypted: i=1; AJvYcCUlNfPPk4j0pnVczqoB5hq3crd0DV5bgdscgOXpCh2x/tcXbmC1W7lhn8K7MuZ5y1bIKpaivXs4bvj2xk33@vger.kernel.org, AJvYcCXQ6MQk/ZZddcrw6T2PRvqzj/iN3I6rKAoEQsHjTrLfPe/Nlw2MSXVcqHm5HRjUGsOuC9Iw9c/UKzEt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7CY7m4V728AwubXmlZJ5Zo40f5DKmbu2Ffgg+5Q9cLSzXxwd
	TkFZVuR/0QQCTzIcp7PBJ7nQWcRYGagvNrqL679oZj1AA4Mhecwun4W6F703
X-Google-Smtp-Source: AGHT+IGspKFfiqyL2wYQxw2XmN4TgucJ1RzYLDvHmzEYKNDVReuvUgme6jtR5GFyxKCoAb5qwZgeUg==
X-Received: by 2002:a05:6902:2b0c:b0:e30:e2c1:cf4a with SMTP id 3f1490d57ef6-e337f83f0c3mr2361825276.2.1731055714855;
        Fri, 08 Nov 2024 00:48:34 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee155f1sm652916276.11.2024.11.08.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 00:48:34 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e30eca40dedso1864361276.3;
        Fri, 08 Nov 2024 00:48:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeAnsw2xQbiXScWg1nS8k4LdJ/5tqTXkOct7YoXbwhWD2R3E9Gu/2s6+Z19EY+r3xLYeXLv6C8a3ksGSDF@vger.kernel.org, AJvYcCWetFctMRNHT9OD8c+4Kp5m445G8hP1c67HtTkbUo8+7quiQghvCU0wKj4m3EVcn7+U/EJWA7xYV2Lh@vger.kernel.org
X-Received: by 2002:a05:690c:4c0b:b0:6e3:31e8:7155 with SMTP id
 00721157ae682-6eaddfb8f93mr20220047b3.40.1731055714114; Fri, 08 Nov 2024
 00:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au>
In-Reply-To: <87jzdfcm3l.fsf@mpe.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Nov 2024 09:48:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWk83QpTcbuBz=m6UZ+ShFM4rTt_UL-frzR3LmAf_Tb2Q@mail.gmail.com>
Message-ID: <CAMuHMdWk83QpTcbuBz=m6UZ+ShFM4rTt_UL-frzR3LmAf_Tb2Q@mail.gmail.com>
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linuxppc-dev@lists.ozlabs.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:37=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> "Rob Herring (Arm)" <robh@kernel.org> writes:
> > While OpenFirmware originally allowed walking parent nodes and default
> > root values for #address-cells and #size-cells, FDT has long required
> > explicit values. It's been a warning in dtc for the root node since the
> > beginning (2005) and for any parent node since 2007. Of course, not all
> > FDT uses dtc, but that should be the majority by far. The various
> > extracted OF devicetrees I have dating back to the 1990s (various
> > PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
>
> I have various old device trees that have been given to me over the
> years, and as far as I can tell they all have these properties (some of
> them are partial trees so it's hard to be 100% sure).

Apparently CHRP LongTrail only had #address-cells in the root node.
Interestingly, /cpus does have a (zero) @size-cells property.
http://g33rt.be/migrated/Linux/PPC/root.html
http://g33rt.be/migrated/Linux/PPC/DeviceTree.html

No idea if any of them are still alive.

> So LGTM.

Indeed.

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

