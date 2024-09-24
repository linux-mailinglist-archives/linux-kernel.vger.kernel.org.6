Return-Path: <linux-kernel+bounces-337541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EB984B85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B123F1C23120
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271961AC8BD;
	Tue, 24 Sep 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M2iryCDV"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5A12D1F1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205876; cv=none; b=uxkrcYO8V2qMa3MEIIq269ZHGCC7pPgIcgcEl8HBsIaiWRgmeZCHOoq3fjXEOPfJ5abciIxQzvqimqSUKE4zgwqFhmM/z0LR+MHSB+AEgQGvqAUXRL8tkvcegSsQcdikwDX/sV/GkhV+Gw6OhV7DXOHDQ1frqieKLrGW80E+MJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205876; c=relaxed/simple;
	bh=SIeQoyCxYAQebwPctse0ec/xuA/Q6FV0i8cdsXtARic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SS3EyHOXATL8BERR1COklUmkAwiQAtwLAxA4OKFwDIqmpEY+JKSfLFVeysXUiGds3SQfb14m454DkMKQYFwA6yWdk2xHEYDdJt54nsQURrhVc06H8X30DURABACauYbcaK6n7nnbwNlc72R90xxUtecfkSm66/gqDPnXT9NWq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M2iryCDV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so876561766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727205872; x=1727810672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AEQwCgf5wgX6ZTyJ9aWNB159Y5/5DzJz6MiCsxsiWg=;
        b=M2iryCDVtsEKdYu8O2nGvej6I0sqkkIohhqW5UID7zLhSANMT6AXY00zYpwmSlP0GH
         lyIM384hIM0GyC1id6+WqWVNYqFDjVKAlP/Qzlu5yLggWnJxkpov9v4taHG9k57E90eU
         c7NPvxu4q3S1soioAJSyEQnCzjZ/HxGdnaONo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727205872; x=1727810672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AEQwCgf5wgX6ZTyJ9aWNB159Y5/5DzJz6MiCsxsiWg=;
        b=YySS6fvUQ62ngS7A6HizGUtL33gYXfE1nFFX7HqkleSHGm/qFTG72N7X/NVxOOUEA3
         y3crZBXQWJFoU3omRZbp06UDlxbSvbFoidw93drpeD7DIaXEp27cnOe+n0VDuvdn/t+b
         QhCJtW5RpwpvM0nRtyWx4dixthWP0YTBZtf7ZlPWSuxIJANqDkiNvcTghvGDBDC7dwc1
         aUUbxYCQL5Ki0HkfIYtzgR7O7gd7W05MOIGJUAU+L56Bkii89jGqRH4zQ/zmOF4DB3pQ
         jmk6ijG1sL4ytyzELRUZxqRm7N19n8uhDwRDX+lOC+9z8CXU+M8O9YJ5wfr+7wlIE7z8
         MpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0Klim+rS0+jIyQzOfCCCf4Q3NRC/rufAR3LDRStMt5p+0WTqRdHqj5objs03gWVfBq0z3jF5vxocqAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/clHeJPwAfojrD41YQyHG4T2Gl/dpMjGI/9QZREvlnhJLw47D
	DdzxMEhIfpGuypN/lRlkUeDo7nhTLDWydy9gjhd1UayJb1Ynnaw2yhD9wM9qlnuBI/52nWvLrSW
	QWzcvXA==
X-Google-Smtp-Source: AGHT+IG+Q1LVvTaxjSHGQVmIwE1gFw/MceStpTwa3Yqtfsb0IwaAqVcpHHf95FkoyW61Y45aPm5R2Q==
X-Received: by 2002:a17:907:31c8:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a93a063338bmr28679366b.43.1727205872475;
        Tue, 24 Sep 2024 12:24:32 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134b2fsm119351766b.204.2024.09.24.12.24.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:24:31 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c43003a667so8273410a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:24:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDcSAkVVLUYEdq9TX1u+KuHfsjUYLNfXSWaVg8ABRgHdL4rNKrKlohXH1Zn3OgfdUjpONiY6wpOQ2MBOI=@vger.kernel.org
X-Received: by 2002:a17:907:9726:b0:a86:799d:f8d1 with SMTP id
 a640c23a62f3a-a93a06333edmr32505866b.47.1727205871314; Tue, 24 Sep 2024
 12:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZulMlPFKiiRe3iFd@casper.infradead.org> <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org> <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com> <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk> <ZuuqPEtIliUJejvw@casper.infradead.org>
 <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com> <15f15df9-ec90-486a-a784-effb8b2cb292@meta.com>
In-Reply-To: <15f15df9-ec90-486a-a784-effb8b2cb292@meta.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 12:24:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAQ23ongRsJTdYhpQRn2YP-2-Z4_NkWiSJRyv6wf_dxg@mail.gmail.com>
Message-ID: <CAHk-=wiAQ23ongRsJTdYhpQRn2YP-2-Z4_NkWiSJRyv6wf_dxg@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Chris Mason <clm@meta.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 12:18, Chris Mason <clm@meta.com> wrote:
>
> A few days of load later and some extra printks, it turns out that
> taking the writer lock in __filemap_add_folio() makes us dramatically
> more likely to just return EEXIST than go into the xas_split_alloc() dance.

.. and that sounds like a good thing, except for the test coverage, I guess.

Which you seem to have fixed:

> With the changes in 6.10, we only get into that xas_destroy() case above
> when the conflicting entry is a shadow entry, so I changed my repro to
> use memory pressure instead of fadvise.
>
> I also added a schedule_timeout(1) after the split alloc, and with all
> of that I'm able to consistently make the xas_destroy() case trigger
> without causing any system instability.  Kairui Song's patches do seem
> to have fixed things nicely.

<confused thumbs up / fingers crossed emoji>

              Linus

