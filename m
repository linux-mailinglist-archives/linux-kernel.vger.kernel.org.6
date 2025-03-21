Return-Path: <linux-kernel+bounces-571253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34ADA6BAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A901B189429A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537F22B8AC;
	Fri, 21 Mar 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="coaOL9u/"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011822A80F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560893; cv=none; b=upLR7CYpDBN9+CbgJVrJqsoUqzgnf5fPNycrd+DmOGKfhtKFf+taU0T3US0KnGzZgPf9/HBfc1EZBlnAAX2k/1eaA6earRygdffKzruicfF1taFtfXKGd2eFIWTwd8C6MOZqQAnY/rUx34PshorYOj2PWZnGjznOWGxD48q/jvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560893; c=relaxed/simple;
	bh=kYV2tU5W6W7PRa7BY6P3Gb2pA6tdcRdBC8mO2lgEAHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF8eX0Np5Gtj+4xiVvrL2bwHEBB7JcApUXNzx9JCRYkwXAr2KFjsOBKvQorfeydNv7Xn/iAn+854SZODsfxLHzFc7E9EjK6XoZ075ybrT8aRbkapKtBHa09zKo8IC39HjbBitSKKQ0uZt/r+c2yh0aQd/WT0yYGyNK4OUYqqQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=coaOL9u/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DD293FCCB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742560888;
	bh=w5dmGg1Zenb5iMErOVl6vrTRYdAblyeideLHWERDpFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=coaOL9u/71t2eFlhch0JwJyJ1GmT0wRmBxLGLHLgWGmuMt03vGVtefgeq6NcpVAMZ
	 EIC6piqSb12Uta4JbrxJcPRqVHgkW6J95j4fBee1pyNCi6ktDGh5DKj602lD/VBC5d
	 i02Puap4kjruAjWQD97LTnYwe0YvmRHs/ryOiWEoFUR9II6TwdQMMhbrqZ+i6tS1oD
	 pEm2bSVhs/0OFjFhoZlrm9ubWVMCvT24T+1Ct5oRKJi/b7faJ366AI26P90o8Y++oL
	 +QdXHmdPZSf5wAzKHdVzCeoSXvC6A0vcmoHfY9RLq/obRByEFpHsQKZ+gXHcqrrjai
	 K2if0ChJaQTGg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22647ff3cf5so26315325ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560886; x=1743165686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5dmGg1Zenb5iMErOVl6vrTRYdAblyeideLHWERDpFM=;
        b=R1QNejuFTcHQm57SrQHa8akyk2ZtFUZ3W+dJt+Lsoi1n78fwfnGb/hsHngvUmSRpyT
         P0ZZHIkkxx4NLBQ8aiethzplGi0iF9DvVNnvGViR34iLpTKH+c+qSGq+T1GSQbfi/Yfw
         fta01iGirfHvUinAE5zrAJredvjpzXV7akyND2ORbxt4mjXto0uPORc7z7E/1NS8RqNM
         codKkVPKAKzdw5JiUJPJuddNkmwNtMA3zm/QEqGBcx8YgKLMwDd1PSELsScpbadG3c3W
         9uGDl6qt2s/lerys4f/BdOk6KjkjpqWE1Zxk5c1ihWrB16bmA97yQSmtLA6oOEtOoxS4
         /qmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBs5R3q6lfvEuRCGfJs1c3PWHIbDi2262cNFt4uB4OyWR2l1QT7j8o/9Gwefsb0Z5fnQzmpHkNjHb+46Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnv+DecezTJE94nc7fki74E2wF2lG/hIJjzzYV+OBvviOLgaIk
	V4fMuYRpC0qQ5+VOKSvtcoeEqFH6Z5gO3JnTk436VrM14hLb2jtdYKEGrm8v3JqACcMi6Iak7tZ
	GDwxaaXGdCBbFUBuKhYOBtSEaodOfzwjGG/lHX5Qd3ed4Wc8hGH+L+DDVfvb4fP0xkW9cmRvkSl
	zs7A==
X-Gm-Gg: ASbGnct+kFFb/CWLi+NyDd1o4F8dbce0HFuV2Aamqkmze8LYsGneYT2cfYxyO4UPjzg
	CZAj9fO8MvoL/M9AL5zXhdRXV6GN1OBV7U38UTlYiNihfmvbLzvnWSu1qBFzanqRr1DcQhKJpqz
	zgsUdvBlbkwTZVnNJQ79dngjzQop6YZc8YYK6ByxcxMy6sY8FpX3z6gplbcE75agRF4FwoIQQ4t
	dHvez2M9sOA7bWZ/1w7ZgKqjI6DycIttSgg7FR+B4QtA4STtVoFG5s36xpm+NwLDLLYY0EmkfuG
	yLDxzvHcyKDjVWH9cw==
X-Received: by 2002:a17:902:ccc3:b0:223:3396:15e8 with SMTP id d9443c01a7336-22780d9b9d4mr56470725ad.22.1742560886563;
        Fri, 21 Mar 2025 05:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGptLOm8T0h+3/usNzsqJQv/3kloJ7tcIjHNHv1LCT314QI7cJQSD9ZqqoAAnmCXXt+Kbwy3w==
X-Received: by 2002:a17:902:ccc3:b0:223:3396:15e8 with SMTP id d9443c01a7336-22780d9b9d4mr56470305ad.22.1742560886100;
        Fri, 21 Mar 2025 05:41:26 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:2dba:1af7:27b6:24fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b520sm15391125ad.6.2025.03.21.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:25 -0700 (PDT)
Date: Fri, 21 Mar 2025 21:41:24 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
Message-ID: <t4lng24vhim7pid6c5gafdk3mawnvcit36hqsa64qoe2gozdz3@jcjsh5b7c3bx>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-4-koichiro.den@canonical.com>
 <CAMRc=Md8nB1U--qcZxpcKVzxTcON2hi-pmsUKFn+aBEqHuBzcQ@mail.gmail.com>
 <llbybv6dpkfrtir75dveqnphrj6nuephvkoyywy6tx6vfbunl2@ft5io3thby6v>
 <CAMRc=Mcng+jW2WrAREOf-GC1mCbGEyAiMP_Ms9B3BzXnCoFGFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcng+jW2WrAREOf-GC1mCbGEyAiMP_Ms9B3BzXnCoFGFQ@mail.gmail.com>

On Fri, Mar 21, 2025 at 10:32:33AM GMT, Bartosz Golaszewski wrote:
> On Fri, Mar 21, 2025 at 3:37 AM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 04:51:04PM GMT, Bartosz Golaszewski wrote:
> > > On Sat, Mar 15, 2025 at 5:41 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > >
> > > > Prepare for the upcoming configfs interface. These functions will be
> > > > used by both the existing sysfs interface and the new configfs
> > > > interface, reducing code duplication.
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > ---
> > > >
> > > > +static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size)
> > > > +{
> > > > +       struct gpio_aggregator *new __free(kfree) = NULL;
> > > > +       int ret;
> > > > +
> > > > +       new = kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);
> > >
> > > Please prefer declaring the auto variable and initializing it at the
> > > same time. Should be:
> > >
> > > struct gpio_aggregator *new __free(kfree) = kzalloc(...);
> >
> > Thanks for the review. Should I send v7 for this change?
> >
> 
> You should send one anyway once v6.15-rc1 is tagged.

Alright. Please let me confirm:
- After gpio-updates-for-v6.15-rc1, will something like
  gpio-updates-for-v6.15-rc2 follow?
- If yes, after v6.15-rc1 is tagged, I'll _quickly_ send v7 rebased onto
  gpio-updates-for-v6.15-rc1, right?

Thanks,

Koichiro

> 
> Bartosz

