Return-Path: <linux-kernel+bounces-234271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B063191C488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661F52819CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D521C004C;
	Fri, 28 Jun 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSqrSkmc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B32263A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594656; cv=none; b=Cw2k41VZZ+M7RAKLK4jfL4drEV+z+l5M0ubkPlyVxtj7gfZDDe3OCzq2gNURQjx63z1Py4S8c6cv3ONuU/3wtH2/LhdELNUZHlaH7YztWlP2pztRZa06jrFw2YHktxnLgcgpUJqtVPgsQudGEHNramovnqqamL7olkwkNuE868E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594656; c=relaxed/simple;
	bh=xtXeNQngp/V7Bfl150hMSYnxsrRSSnLRns2tFkU6FOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+HHmSvSEZ4OCi9tV4f6h3XnIvhOF9G2l6btEp+4us49UQSpau9bkc5w3sG2h68pnRCSmyQ/H93pM9UBUSh9KtDeEinNBrOty2KXBoZ0Ga++ADae0hq7wTJqqiT8ldUaYkNyzgqAiTQgSdoWWhvswbYuYnVllzf8rZ3qKce2oII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSqrSkmc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9cc1d7379so303645ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719594655; x=1720199455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIE4oI18UW9Qs08g0RebvTYQQUB6+ib0OH13RWotfFc=;
        b=SSqrSkmckec7WNOFLPZuz5eRG4RjOkPcTV5m/eexhNdoKi7x1KTBO2kN4yt/2pqFi9
         mUqdYkJM4ht4xRbLITCTucS1AuzZAkuSkWLoNzd84g/j5ZITi/8Il5Ig1d8u9w0t0E3U
         27gTadkY2VC/bfHXlUltpSCHUzqMhZeEo0UprZk/0XLviu7I2/gkGAV3/H5X5UGPDmLf
         DUr+xkJSQrNFT3WZJ2VfpYYVzDVA1kMXdqRa78IqHfzzTVtcCW8Sv2ePtMw+xltiZE0y
         6yIb6XkQUGsNs+CWpXliWgBXlfDgtj5BqDroUvFUptwBSLF+h4JlkMNTNiTCC9WJDBxQ
         csvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594655; x=1720199455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIE4oI18UW9Qs08g0RebvTYQQUB6+ib0OH13RWotfFc=;
        b=K6ttLrK/bwMiA4gtu1HUL9c3aqSEcwvYDdgX7QrE9UfnBOir4ZBozPz7S3f7lCpmi7
         Y3si7TeVzFxhTBXaVvbj8xE6gJL1hUy55mC758/JhEYEr5Df95s/wYTLeDw9nf1FwlZW
         IJcq4SzhqY3thjwT3hjqE6DPkNHO4sT3Pu2tsUvBhEROza3IlPLmFo/1X8EA/YD6TLVQ
         ZWsW+Jf4fDeOVa/niEnWxIeEy+iMvVMqeysV1PZj347UlCFZoEfKZu4l1dEqx1hbQAGi
         +w51KhUho1S6kLGRGYZS0ya6ehHrcUvti7OVrFIyKShxJUpn+tmcjL59hK72RVBu58Ob
         43YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+oNzxLRhTsFIfXo6PLqBYKI7+8Wl/gw/obCxazbZ2YeOCG3qNG9IMXv4D4oycnj84VuUzvVj8K0s0KA8l8Gtk8HmNp47NnA7Ofna
X-Gm-Message-State: AOJu0YwwsXlsoymJG3/IGEaKFVReDGqx/ogKAWha2mKlUvKRurwh7liz
	EU+QLSHQMvNx2Sn9oChOH7JbER5wDsRCos52FGNDcjToyWyU77Wr
X-Google-Smtp-Source: AGHT+IFXDOCem1AfUDk+Yi7hzf391j0vfuZ9i9eMeQW8K+gnUyE5FmEGrvnKr1r0P2NvoJ0PDchhcw==
X-Received: by 2002:a17:903:32d0:b0:1f6:d81e:cf3 with SMTP id d9443c01a7336-1fa0d70d342mr205348785ad.1.1719594654470;
        Fri, 28 Jun 2024 10:10:54 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b5fsm17786225ad.174.2024.06.28.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:10:53 -0700 (PDT)
Date: Sat, 29 Jun 2024 01:10:50 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, lkml@sdf.org, alexdeucher@gmail.com,
	Julian Sikorski <belegdol@gmail.com>
Subject: Re: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
Message-ID: <Zn7umr/VHtZ/Nhcu@visitorckw-System-Product-Name>
References: <20240113031352.2395118-3-visitorckw@gmail.com>
 <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
 <61f43bdd-7f73-4605-96e7-843483a53bca@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f43bdd-7f73-4605-96e7-843483a53bca@leemhuis.info>

On Fri, Jun 28, 2024 at 05:15:15PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 20.06.24 17:36, Julian Sikorski wrote:
> > 
> > it appears that this patch has caused suspend-to-idle regression:
> > 
> > https://gitlab.freedesktop.org/drm/amd/-/issues/3436
> > 
> > In brief, my laptop fails to suspend completely with the following error
> > in the log:
> > 
> > Jun 18 12:42:20 kernel: amd_pmc AMDI0005:00: Last suspend didn't reach
> > deepest state
> > 
> > Power consumption remains high enough that my battery has already
> > unexpectedly drained twice before I noticed something was off.
> > I am not entirely sure how changes to sorting function can influence
> > suspend, but it is what it is. 6.9.5 as shipped by Fedora 40 exhibits
> > the issue, 6.9.5 as shipped by Fedora with the patch reverted does not.
> 
> Andrew, could you maybe help out here or point us in the direction of
> somewhat that might be able to help? I'm asking, as from a quick search
> on lore it seems Kuan-Wei Chiu has not posted anything since nearly four
> weeks and thus also did not reply to Julian's regression report.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke

Sorry for the late reply.

I apologize for the regression caused by the patch. I am not familiar
with the power management domain. I would guess there might be some
side effects in the compare or swap functions that I was not aware of.

While reviewing the sort calls that could potentially cause the error,
I noticed that the compare function used in the sort call within
drivers/acpi/processor_idle.c might not satisfy the transitive
relation. Although I'm not sure if this is the root cause of the
problem, specifically, if there are two valid acpi_processor_cx
elements A and B, and an invalid element C, there could be a scenario
where A < B but simultaneously A = C and B = C. However, if I
understand correctly, this issue should have existed before this patch
but might not have been triggered previously. My patch might have
exposed this issue by changing the order of comparisons and swaps.

Regards,
Kuan-Wei

