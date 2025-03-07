Return-Path: <linux-kernel+bounces-551454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E0A56CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D85D3B0897
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25321D59A;
	Fri,  7 Mar 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VhmS9mFp"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F21D3E1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362907; cv=none; b=slVbETgrYjweNMJIzidXrba49dSwk26iwMVAXQDT52uJYahA3qg1fZoZsObB15ZJHmGhBcS9WVetQXU8kgR/KB8F+FD5p0olwX/eJox6Nrrlm8hUMyNqtAathTWOxfCb899J817O/Z4xkGDZN7r4zvvRHb8oXZtobeY/o81yyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362907; c=relaxed/simple;
	bh=BqAgNNhHmr48CV5Lby7avsDCaaonSWHfakhBkcS8Gdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVQtHu0mNsc+UrO46/WiLEASP6qhLBWiust4H/Qcv7J9evZ91LE1MVXK+BmJI4qv4eXFVyd/J48cQoJ7EavEjOcc3Prk2NMkCLEzj7xPYlr7wSvJ6ONC9dtKT4Fn6KWtR9yQymAYLTAQAHs2i4KZlhWeaxaB39GMfJSxlzQm1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VhmS9mFp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso12586405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741362904; x=1741967704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTIxiohPLNVVB9YfiDexvU2RO8Xj7BqvYc16wsDl4Q4=;
        b=VhmS9mFp7xXLrwV/bt9zLXavw3cjAAiVpyvpnKGEz3vu1ILQb8KIQ5Ej3quJBqU8b+
         nulHKKaYwt4hqjlqQYPnD/8NIs4wIEsqrK3Xh7sY7dI735fgdGx3nGCIpb1NfHXojs/O
         E75dvz+zp8SUyJz4J587FAUc46FE6GRDQU+bnbEMdA+AucxCp5LL4wGxIktIpfToRv6i
         mzAi3KwTXMm5KLibmVveyxaeQaITGKuxL/Likb++vzbaWGYQS6FbbDKkrHLxasJ4102n
         xsUY5R5Kll2Y1amKy9IJ/KMfna4HMv9654QHwjufdsOuWPao5iY/EPowWU7JEI5BY8L7
         bLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362904; x=1741967704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTIxiohPLNVVB9YfiDexvU2RO8Xj7BqvYc16wsDl4Q4=;
        b=omaz5Y3PQYlajcgG60uygdfyIrt6UtxpwL4dUkcoCkRqcNP8X5E8pR1oRzNwzRzxOM
         EkZwwlMJXQduaUNaAP3P0JLQjwTKcZrnx1IIVlVZ0p5oq6vcyergrysZiHxqx80CFG59
         b/rp80uUeRAJcbDH77qvH5Rfh/iaiJw5PyDLpNYsoVxgJD3kGwYm/I1z1LkcFG2InT5h
         2unIwtd5LHX5l7cO0JE0232fbh3bMk6appWy87bDwsjEK2h7V+WYx4yQji+dP4hTslJK
         qEu9kk7lSn7UlQ9MjqtRTh6OnpD77irtbCK/7milzN7TSGGl26+IqKmfQuqaRAmlHVY9
         wGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQyh8A8gS7ebBeyv6fBHhoLKRK+IbjF1k+L4/QVd5/xPPqk+96QsKw+1EQvQudHwZNsYHjPLFIilx0GCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHphu/N6OTXr+E8ONk+YlqssyUmQjg1ZPo2cOmzIYazGRXoaR6
	3Qa0v6kSZgrlp5aWWipL2xQ/8xtJ4/wGPqI0feeRtBZP9H4vc69Co2jcTxAzubw=
X-Gm-Gg: ASbGncu954ionaG4eNkRU2pULxET9yVSuNop2GMEO5XQEzKKtUN5ipeDELrNIaM/9PQ
	OCGtBoJ82U5O2m+P8NlS4nRLBi+gJOSTiuiOcmJGX2qDolIRVbE5THrudtNLhwasMtQfMU9pLh0
	u/jHTgRLnPihtBhjDTkbGF4C+JCUXa5PkTz/bFCOHN9uE9OZamxgaQkwIh5tsn+Pr2BX/4tT5j7
	KdsHRXqfrkZMlhdYJV8sfGTHb0WkB3TYqFy7p+6aldSMfT6ztkfUpNrHx8uinm+wTPEw83w+OZV
	yk0bpw/eGZ9B60LOCTKgwfTzTAjsLtVN62Qleu/oC7Mk+z0=
X-Google-Smtp-Source: AGHT+IF1iPA/Ntx7JECcdwpFF2+Wr14YZrGvchT9BSUSo4BM6xsm3uEkcR6M6E/FoWaOSUozXYVFDA==
X-Received: by 2002:a05:600c:c6:b0:43b:c1ac:aeeb with SMTP id 5b1f17b1804b1-43cb91c58abmr23566485e9.2.1741362904110;
        Fri, 07 Mar 2025 07:55:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dad73sm56612925e9.19.2025.03.07.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:55:03 -0800 (PST)
Date: Fri, 7 Mar 2025 16:55:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 1/3] printf: convert self-test to KUnit
Message-ID: <Z8sW1QBgPVUmEzUd@pathway.suse.cz>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-1-5db840301730@gmail.com>
 <Z8mUH0comOCpycpK@pathway.suse.cz>
 <CAJ-ks9nFSzRXFauavzSWhvhr2Rou7qqkWi_LZ=4e1Tyr4_bn3g@mail.gmail.com>
 <CAJ-ks9nDLGvzZ+NDAJsk2Hy1=hsCzayg4-65gk60T_WJZzOUzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nDLGvzZ+NDAJsk2Hy1=hsCzayg4-65gk60T_WJZzOUzA@mail.gmail.com>

On Thu 2025-03-06 09:41:44, Tamir Duberstein wrote:
> On Thu, Mar 6, 2025 at 9:25 AM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Thu, Mar 6, 2025 at 7:25 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Fri 2025-02-21 15:34:30, Tamir Duberstein wrote:
> > > > Convert the printf() self-test to a KUnit test.
> > > >
> > > > [...]
> > > >
> >
> > > 2. What was the motivation to remove the trailing '\n', please?
> > >
> > >    It actually makes a difference from the printk() POV. Messages without
> > >    the trailing '\n' are _not_ flushed to the console until another
> > >    message is added. The reason is that they might still be appended
> > >    by pr_cont(). And printk() emits only complete lines to the
> > >    console.
> > >
> > >    In general, messages should include the trailing '\n' unless the
> > >    code wants to append something later or the trailing '\n' is
> > >    added by another layer of the code. It does not seem to be this case.
> > >
> > >
> > > >                       bufsize, fmt, ret, elen);
> > > > -             return 1;
> > > > +             return;
> > > >       }
> > >
> > > [...]
> >
> > I noticed in my testing that the trailing \n didn't change the test
> > output, but I didn't know the details you shared about the trailing
> > \n. I'll restore them, unless we jump straight to the KUNIT macros per
> > the discussion above.

> Ah, I forgot that `tc_fail` already delegates to KUNIT_FAIL. This was
> the reason I removed the trailing newlines -- there is a mix of
> present and absent trailing newlines in KUNIT_* macros, and it's not
> clear to me what the correct thing is. For instance, the examples in
> Documentation/dev-tools/kunit/{start,usage}.rst omit the trailing newlines.

Honestly, I am not able to find how the KUNIT_FAIL() actually prints
the message. I can't find how assert_format() is defined.

Anyway, it seems that for example, kunit_warn() prints the messages
as is in kunit_log(). It does not add the trailing '\n' on its own.

Also I do not see any empty lines when I add back the trailing '\n'
to KUNIT_FAIL() message. This suggests that even KUNIT_FAIL()
prints the messages as is and does not add any extra trailing '\n'.

In my opinion, using the trailing '\n' is the right thing to do
from the printk() POV. Please, add it back.

Best Regards,
Petr

