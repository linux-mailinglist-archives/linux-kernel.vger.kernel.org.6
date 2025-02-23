Return-Path: <linux-kernel+bounces-527525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BBA40C53
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1E18904F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD2A469D;
	Sun, 23 Feb 2025 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DWZY8LCc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766F17D2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269343; cv=none; b=IWcpIR1qPYzTqtKtv9wco/svQUvTJJUivkWU2YO9+2uFEC6ENCTcpIlZV1GLe5nbEnHMv01wZ/Azk0W0gUMlcOxfOivCHy3nRMydurqZP61OeEWMCdcT9RVR1Jy+FpRj0wbGHV9LtkJ1VCV4a1CmylWOhIlqIARiQ1ee0GzaPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269343; c=relaxed/simple;
	bh=/G7JkzhhbBqu3vzwNv7Hppj6SkBW9ihwhJ+/SwTOeBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu+NKZuRegz2s5CYVduBjA5XWgnwoh3JFf+qZWVYe0cBCjd3z32Iasf9xDOiN8o21ODZiupkCFOeSOOGDwL/6nU+SVDlmFtClsEfDhd+I/Gqlzgf2Ga8bz0rS/NsdbEKwqiIBOdIaufMfb8ZPGEOYCtHTwSxFjkwpUdDDLfJPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DWZY8LCc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab78e6edb99so463040366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740269340; x=1740874140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxqWzlIi0izSkI5YwnrgtlxsOHIYmRbLQ1OdfXpfAKI=;
        b=DWZY8LCcac2GihsordyE2hpWJE7DmUkIPvGZceK+0e5QyflQtoZkoFYUGYp7HkDZqT
         eirFgMDTNDBSE+AQIlmJwAZClXQ47ZAj7mv5iwK2lcgJFiYm6qjgZ6DeDDJuH+cQAW4A
         quwYvS8WifzeOZZNmTjzgxW27a8ptyNmIJRZPSTn8Eh+ETu3e1UNoGif5jOGdAr2xHyU
         bUANzsyIP+QchwOoJdNH9ru8D98WX8fagYebt0fTN390U2RH3GrUul8gMjrXmagGz2ro
         B8TLzkqkYKS6+KFMi28t3A0sj9hgzGClAg/tML5aLNlWosRHAMUizDtXKXddOGrhco9f
         IjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740269340; x=1740874140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxqWzlIi0izSkI5YwnrgtlxsOHIYmRbLQ1OdfXpfAKI=;
        b=j+WiiRSvbKcUr5zN3maSIwi3vcGCiyr/F18nUp4crPRPl5sVFWp3MidJuYZD9p4Tt4
         l/r42mdX1mnutHnyAPexwxnLhsIHyN5S6yu77voBeVIMoje/Z+KWXLIsEtZmlaH6MceI
         x5lLUL5vCouKHW+++TGn/3LuRa9izLIWABj56gtQkHiZ4t6BV2BPpadqqRhxSflNjAop
         3w0GwgDSgnqKaIxHwWNUxqTRtQUh0U/DJb1Uo6L3iMHb2xzTQZ+678LerrdVM8R/ljEF
         uNmppiFlr3AOUGYPmsOBH5FNiTozTp5vwhFSmC42Y6JKy6SwxOrP4iAcqiy1TBDCdcbk
         CsYw==
X-Forwarded-Encrypted: i=1; AJvYcCUkSqS9FixEjJ/Ik9mskgSeUDTSgcykmYndJSMcBbW31+PMEmoQ6lUTT5GWmD89yzqVLXiRAaV31by3oAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLAuoEDYtRgF708ZM0l3S96yO4w3IYBjRr6e7SV/y+KQ2bGOM
	TMtKQt24HWrZOsXlQoMY8VcXQV1Do6uudHTgSSPX2rFQUI4xiUqSGQU0RwRKRUw=
X-Gm-Gg: ASbGnctFFczzIJnjPW4UUp4osVkBi17ZNdhMCbW3ff+7hiDfL7mq1hmJSb2RRH+DCly
	6Q2ehkBCq7k8oNxt6Ii5VjV2tmbw3hRbrsZuTU+xmhUypodBXD9/j/03EigsZdebaC4WCgLNdqX
	I2qzzyQ1MNsVTvS5FovDyNQJEordqUhuK+NL3rH1JLSFLnKltcr7To5JcE7+myHbcJAm8gU1odN
	MY8egkAmeLQeXlkQ0mvcyLWw2JJqh65uPvNubMLA1p9pZ/74E1ivPAUrhK6eYygZQPPYScvkiXX
	60FVRPjoQQrVydzi5uGu
X-Google-Smtp-Source: AGHT+IHObMQjTVseEEmUSPWBFov/2iYO4e2s6YgflelmDTeyhRTB/qM+0SRqfJ19gLiUWuOiTQbeow==
X-Received: by 2002:a17:907:6ea2:b0:abb:bcef:837c with SMTP id a640c23a62f3a-abc09e47232mr801194566b.56.1740269339952;
        Sat, 22 Feb 2025 16:08:59 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532323cbsm1959593866b.14.2025.02.22.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 16:08:59 -0800 (PST)
Date: Sun, 23 Feb 2025 00:08:53 +0000
From: Qais Yousef <qyousef@layalina.io>
To: zihan zhou <15645113830zzh@gmail.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
Message-ID: <20250223000853.rj4wtnxa6iazoehu@airbuntu>
References: <20250210230500.53mybtyvzhdagot5@airbuntu>
 <20250222031945.67519-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222031945.67519-1-15645113830zzh@gmail.com>

On 02/22/25 11:19, zihan zhou wrote:
> > Yes. The minimum bar of modern hardware is higher now. And generally IMHO this
> > value depends on workload. NR_CPUs can make an overloaded case harder, but it
> > really wouldn't take much to saturate 8 CPUs compared to 2 CPUs. And from
> > experience the larger the machine the larger the workload, so the worst case
> > scenario of having to slice won't be in practice too much different. Especially
> > many programmers look at NR_CPUs and spawn as many threads..
> > 
> > Besides with EAS we force packing, so we artificially force contention to save
> > power.
> > 
> > Dynamically depending on rq->hr_nr_runnable looks attractive but I think this
> > is a recipe for more confusion. We sort of had this with sched_period, the new
> > fixed model is better IMHO.
> 
> Hi, It seems that I have been thinking less about things. I have been re
> reading these emails recently. Can you give me the LPC links for these
> discussions? I want to relearn this part seriously, such as why we don't
> dynamically adjust the slice.

No LPC talks. It was just something I noticed and brought up during LPC offline
and was planning to send a patch with that effect. The reasons above is pretty
much is all of it. We are simply better off having a constant base_slice.
debugfs allows modifying it if users think they know better and need to use
another default. But the scaling factor doesn't hold great (or any) value
anymore and can create confusions for our users.

