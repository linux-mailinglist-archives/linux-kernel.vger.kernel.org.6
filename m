Return-Path: <linux-kernel+bounces-186684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95D8CC77D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E151F2215E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C1146A75;
	Wed, 22 May 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/fvyQmv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2C146004
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407445; cv=none; b=kPD2fjfRmrSFdH/Ui6jMHpmOVpdpVzlne7kqEZj8qUUgGYwJxug7+LWFqqodHCQa7JYYzdvPNGzfdukE9mlrAATUvdnwpcMp4hlkQR2/4aOa5MdPumooibSAiyiovAD+gXpzKY6ovfA4NOQy/SbVrt8XIsBo0N457FCoZMeMjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407445; c=relaxed/simple;
	bh=41QZRP2M6ZrNrPrgiuljuIVenZO0ltyNJsZJOOtTM38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW4ixRw06hMHVthISJ5nf4XvvS2rw8IzL5GWuCKCV8Ji8b4RvUI2GPXo18ythMiHKDnGyWitKEybnsNUzb7WX6Cn5xZFIXLZcUKPNcclxdMp9qIGqF1ch+EXhagG9VVdhEWvFVCOjUD/wEOTdRZTbAGTD9al1MeQHUAiEwyleBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/fvyQmv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f57713684so8488410e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716407442; x=1717012242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDQjgWpXJk9D29dvxyUKhngTYIc5cNvHghe8rMGJxk0=;
        b=S/fvyQmvcvXguhQoJlYospg6XrkZAvIKsbk0DnkBKejwmfPWOLlDonGxO3q+7YdlDn
         5f05Ul76iEe7Z2alN3kcBSXRfSYTUPVKre/sCK1AB0PR/NTxPh1KvuBqAnEwsmk6mZvK
         9BJiAb6D+6zYIv9QHDpZK8viBc68+0kDQKHw33hFJZ/U+WdS07UH1zggnr5Lsf1W9JG3
         WUw0bfX4F501wdJuWnTPdtTGwvxWzbf/orowSxDWXb2C30P2n+GWiW4ufxWL4jGt3med
         GiC4gtzqdfJ7T3E/8JqTw+VHVtRS/Hasxmb5dZb2joFPCn4jOvZAj6RTTW3tE3xWBBv0
         uh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716407442; x=1717012242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDQjgWpXJk9D29dvxyUKhngTYIc5cNvHghe8rMGJxk0=;
        b=WDotxM9XC/ENDKfFg9Kjtd5c+lY5n71bfFyAwYbfx+t1peRjjBPluvZpivgT68dWUA
         nmPR8GxcvWqeUyHoJB+GDwS4MR5kY/NU+wA8TkfjT9ClDPIPj52JUvkVyK0TQydsamoB
         /weJz/fRnfb4UY2qHj3wGFC1aQpJWlW3cwkLqdcOIU5kH3+dRhuh7I0cu33gv8Ctwh8a
         UaS9RQBRnuCu7rJmToihTdJO/kkG7Wy/LYTZfO/dSrDjHwymZbetFIAzGICobF94/snb
         poxUTeV4n+DXMfl7OC8/dOgllPm0HAtpZ95Lyz4CIoxLr5xyKcmMNDsUMWZlRRniIsiX
         ox/A==
X-Forwarded-Encrypted: i=1; AJvYcCVcZAz7jGedMYeL/VuOIM/V49ZeoTH1BHpfC+zhlDnv75ml3hkAAM5rjsS0Omn0qbsXiBypBANl2D54ediEZhBzLc3ouZs6XIdv9yDa
X-Gm-Message-State: AOJu0YyH83xwQg9y46Ufs6hdGgvtW/Nv43oiCl/As3lJ2BfRPjfqJFC0
	cM6YTj492yjLmBtBSnJ2QxPqL0TkqsjVNxGy2aBd6/5Spv19MlYAEhoUbHHVUBAzGpLTb2dMHGt
	WVw==
X-Google-Smtp-Source: AGHT+IGXCSF2B3Drn46KcGjpfKvi7xXveSGP2JEX+K1phDMqODF8OQ0EYepBQOcDfFeAD/VSZom6Nw==
X-Received: by 2002:ac2:5506:0:b0:51b:6f06:92f2 with SMTP id 2adb3069b0e04-526bf35cd13mr1623624e87.33.1716407440655;
        Wed, 22 May 2024 12:50:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:abd9:eac1:986d:5b77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-526f36a5cedsm234196e87.132.2024.05.22.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:50:40 -0700 (PDT)
Date: Wed, 22 May 2024 21:50:35 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk5Mi7SliDOd8uO4@google.com>
References: <20240520083048.322863-1-sesse@google.com>
 <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>

On Wed, May 22, 2024 at 10:27:06AM -0700, Namhyung Kim wrote:
> I think it should support other DWARF use cases like
> unwinding and type info?

I don't actually know. I had a look, but could really only find
documentation for _writing_ DWARF info. However, I've hardly used LLVM
before, so it's entirely possible that I missed something.

> I remember bfd objdump is sometimes faster than llvm-objdump
> especially when no line numbers are requested IIRC.

Hm, I've never seen that. But it's impossible to say for sure
that no such case exists, of course.

> Anyway, nice work.  Maybe we can implement other use cases
> using LLVM and reduce the dependencies.

It's possible to remove the libbfd dependency entirely if that's a goal,
at least, but I don't know what the current thinking is. I'll be happy
to take a stab at it (I guess it's possible to test the PE support with
WINE fairly easily?).

I found out that if compiling with an older compiler, LLVM changes to
llvm::Optional and doesn't have .value_or(), so I need to fix that
(the patch is trivial, but it means I need to post a v5, I guess).
Is there anything else I need to do after that to get this merged?

/* Steinar */

