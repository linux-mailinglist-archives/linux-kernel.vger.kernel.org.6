Return-Path: <linux-kernel+bounces-397054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36C9BD61D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E214FB22314
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430421314D;
	Tue,  5 Nov 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9DTe6+M"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076E1CF295
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836285; cv=none; b=bCbuwmsaIiwtB7EQcld0UjhyA8VjaVGs9PQWaGDRlDcnfZZwFsasoV5ly3Z+qcRQo9NHhAejopAsA/NziQoarzMhkUcg/FmZIttRLMJ3YH6ck8jT5JcxxnRNiaDhcKe5lag2IVy5G8gXndZcdqyeHkThd5ejKoDrOpRjvk1A9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836285; c=relaxed/simple;
	bh=Wd9YBNoCVXAiGuvNwiEzfeC0VQdvvvQXwrwgZDUZCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrL4L71y9ZJa1CL8gdvrjfdDuD45A60phIYNy7im2VYR+tWp3WLZxRTH0vMCjN4umPdl72Mct+Pfc9e2jMFiFJygD3vewYvxWHCIuvXWIOZ6w7I7iaRR2HUudXCdujGkiVP8aZWcPgGUXcZ6JRkY+Ki1bHVSf/OjF1rz2CPE+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9DTe6+M; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e6c754bdso5953129e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 11:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730836281; x=1731441081; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YLBx9MU/RnKu6hw2T7hL3H8SirYRCnW93a3oWsqcq4=;
        b=l9DTe6+M8JYtoBBvqGuLGOBoVUOp+wD5sXdBs3tXg5n1SCr+yVFvfMQG3Wg0iUnwvV
         767YmolseecT9njmhSHmCmOALJRgV2CaBQOmxrkb65Hu72dz2TP7A7bCU/wvRZjEP0/Q
         WfEcRTd7lFit1WcclfT3zxSGk9+nY0K/Jj5GOBcsiJCGCiGR3MX/BVh5lhnPGkLYNNwe
         BNOhlQyzjkxHgWe5vKIRXqf1M0psbX0VaiYIrM3dGr4A2Lq2vR+qhdkzy/IkZLG+25+z
         3rm4EI3NaWJuHNpKQ7ORZldO0K4DgfeP1gH6i3KFBp9dxNsc7tTrct9juixzg4mJN1/n
         gApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836281; x=1731441081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YLBx9MU/RnKu6hw2T7hL3H8SirYRCnW93a3oWsqcq4=;
        b=QPjWZ/tIDzEfoq6IgibrppVbgwIxCA/KCPNgZ8d+Suvxh4SgI/VdphEYHwDC7b9JCK
         6X8OpF/7sOUj+GI4lJ4346C7aV+GlwyUn721bOu5GIjmQSmTwcZp+jD0nKpOKy9WQFfp
         tMVfqaKq95O78qduFo7gy3SzNpuDJjtiKCn9wSoyZQHLoAipefrughNsAq0Y3Ky0Iq1P
         FsJi+eWdIxX4xkc4c9mR0NlKnmz3cjTzKEQpiEMkIB0itQXp3QvaJS1hfS8YLuRPpqt8
         okFOOFDiLQefTOqSW6wCcsfyg92UXQlCx+1VBFEbMx2GGxrqXAPKkd860iTmWjOKh3XD
         fhLw==
X-Forwarded-Encrypted: i=1; AJvYcCWLquRg1Y0ImfUluju/LnQGDUdZmPodQ9BV7gT8u880tCmpreLrFdzjsv6iayD4d0yyYrHIFlcn7auuN6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9N4P2EiFLUaZZ1jdVIO7c1hbqkLf1X5ofOG3ElLxkRuXdX/Y
	uI967tcCR9pqgjkHYSdnV1AB6jKALMVDwfu3x8JIGg5g0aFIDH4q
X-Google-Smtp-Source: AGHT+IEAvEwNFxRTIOEiFD35riTRwne/MzbdGzBgbKGwTB2zttyozqFADQNfZYmsA8AsuGWxLbzgHA==
X-Received: by 2002:a05:6512:2398:b0:53c:74a7:43e1 with SMTP id 2adb3069b0e04-53c79e2f714mr10900704e87.13.1730836280887;
        Tue, 05 Nov 2024 11:51:20 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9580bsm2249998e87.34.2024.11.05.11.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:51:20 -0800 (PST)
Date: Tue, 5 Nov 2024 22:51:19 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to
 PinePhone
Message-ID: <Zyp3N9pGWhLqmtq1@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
 <20240908214718.36316-2-andrej.skvortzov@gmail.com>
 <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
 <ZuazIgLz5PP_Z8Cn@skv.local>
 <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>

Hi Chen-Yu Tsai,

On 24-10-19 10:04, Chen-Yu Tsai wrote:
> On Sun, Sep 15, 2024 at 6:12 PM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > Hi Chen-Yu Tsai,
> >
> > On 24-09-09 16:08, Chen-Yu Tsai wrote:
> > > On Mon, Sep 9, 2024 at 5:48 AM Andrey Skvortsov
> > > <andrej.skvortzov@gmail.com> wrote:
> > > >
> > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > >
> > > > New batches of PinePhones switched the magnetometer to AF8133J from
> > > > LIS3MDL because lack of ST components.
> > > >
> > > > Both chips use the same PB1 pin, but in different modes.
> > > > LIS3MDL uses it as an gpio input to handle interrupt.
> > > > AF8133J uses it as an gpio output as a reset signal.
> > > >
> > > > It wasn't possible at runtime to enable both device tree nodes and
> > > > detect supported sensor at probe time, because both drivers try to
> > > > acquire the same gpio in different modes.
> > > >
> > > > Device tree fixup will be done in firmware without introducing new board
> > > > revision and new dts.
> > >
> > > FYI I've been working on an in-kernel prober [1] for such alternative
> > > components. This does not require firmware support.
> > >
> > > [1] https://lore.kernel.org/all/20240904090016.2841572-1-wenst@chromium.org/
> >
> > Thank you for the information.
> >
> > I've tried to use in-kernel prober from your v7 patchset [1] on top of
> > -next and it worked without any changes to firmware.
> >
> > Since there is still on-going review of your patches it looks like
> > it's to early to submit my changes for review. But I'm ready to test
> > your new patches.
> 
> FYI I'm open to either approach. If the firmware can do it, that is also
> fine. I don't know if it makes sense to have both disabled by default
> though? That would break existing users, but so would the in-kernel
> prober approach, which requires both components be marked as
> "fail-needs-probe", and also requires that the kernel driver be enabled.
> In other words, I think the firmware approach is friendlier for existing
> users that have the original batches.

Current patches leave original magnetometer enabled as before. So only
the new alternative magnetometer is disabled. Firmware prober will set
the correct status. So you are right firmware approach is a bit nicer
for existing users, nothing will change for them with any combination
of kernel and firmware. Let's go with a firmware approach with current
patches then, if nobody 

But I like your in-kernel approach as well. 
JFYI I've applied your v10 patches [1] on top of next-20241105 and retested
it with patches for magnetometer. It's available here [2]. 

1. https://lore.kernel.org/lkml/20241030072229.1013235-1-wenst@chromium.org/#t
2. https://github.com/AndreySV/linux-stable/commits/in-kernel-hwprober-magnetometer/

-- 
Best regards,
Andrey Skvortsov

