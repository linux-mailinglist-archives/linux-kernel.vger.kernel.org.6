Return-Path: <linux-kernel+bounces-282309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D663D94E1EC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943F128150C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6814B09F;
	Sun, 11 Aug 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jamauXzR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335614B075;
	Sun, 11 Aug 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390710; cv=none; b=nBY4ekyXYTnO3skCn5jbAgBBWIeTzq+PgMJ+sgJSiFhyTvfaBmeGXMew9/7Vmzpj16JfQswzMEIm28xycBE0FQERcBF4gIL0Btcw2KP/Lq9EQYdDTmHNDtHyg4WZldVIl0PLaoA+a/wnkYWCEeU+XlimW8oyxDeami6w6fLeCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390710; c=relaxed/simple;
	bh=5hGN7WflQ5EZQjRyhK4V1iqFW23ZXFR8cQuySGK5xrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBxtFrh+SXu+d1EcGxvqssy1IhaqJ6LPg52Dy0BoT7lDJeu4hq3J0eoLq3mTcLo+6ZkZ0RvpZazUvvomoACQtddOfPX6WqVDgZ63pFfDwQzeQZAitqCTaEpzeB/uxJlJ0LaSW0KNLXgNZ+hgwvoDWt76STHOb9wK8COwd2Dokvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jamauXzR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01613acbso5147538e87.1;
        Sun, 11 Aug 2024 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723390706; x=1723995506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OLvnb+N9P+uhJbGu2w4OEI5SSyXCe2qOnrVziXSqYE=;
        b=jamauXzRSfZOfrA5ngQMH+btQ1n4+NO1wQjQS3+yMUeDHp50R532jvN8goVAGsgKMN
         geEOhSgdsE+J1lJ4XoDL7LZrZvmTUOvsnSQVJi3/qwqEHf1y6JbIQrL0em3L4EN6IITA
         n4NFuzWdqQC9XAFz1KmcX0KD1aZOxUI9/XcdPUyoJdmUU5wLkpQeQYwUE/kKU5V/mxNG
         cjCgxIm7gGlFebl8gBnZSD0PEHqWdTmgbl9H/V/jBZ1gdnxOKL5+K5WpL1SiK+0Uwyi+
         RN+PhZwt376iTu2j71X1NtnhAVI/WYqUxNdSREL3qxnaAcP3IhxUulqKFel9Hx1eW3Y5
         9XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723390706; x=1723995506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OLvnb+N9P+uhJbGu2w4OEI5SSyXCe2qOnrVziXSqYE=;
        b=NN+S4Xd/qm5GW4XTwZkrbHQkVCXHPIjU2giADZ2x1fN5uXANytt+ydnpD4QdcbWLBv
         WFq32M7uhOTSz0GACwpGc6UzfGsTDtS5C14mEB2SDD/k0xvCxncbJpW+eeQA6cruNG5M
         4DaHVW/o9r5WHqeLS/0GETT2dpBG6NNM4BPPAnQtdOkp1xDexuGKNS0WutaWlKZiknen
         7LkrscslS7ECmxtYQqEsJh8zyXN8BXH9nKIAUK+2g0d/CzHvvtka030bGE6wQGjVgZct
         eJRL+VPf6LA3zcuUBIyI90hJHTffYVMZBnQI0KOEo/4eVl72SH/r0J0Bf6jwn8z3MXXP
         Xg9A==
X-Forwarded-Encrypted: i=1; AJvYcCXN4GIqIKcBqATwHZKqlmo7CX9zdn/I7Fqk5v427g18A4f7qpnaSysY952pRklCIZrNCKqfDy290BjSSuGPr5bhkiCQPxAjW1L2nwm9RwcQCoRKff8663rh9sr1OFG5UapQhInP3JJw
X-Gm-Message-State: AOJu0YyG42CARXBwAW1OobVn6vmFCFWOBGPNgoFG9K08DJznr/IkoNq8
	F3Jxa7aP1tU9vbaTKvOiANHP4ix0/cN7YsKBh7x4JfGviusWaAZlrR+bW+MiMiPmKbnV9KXuSt2
	0xhTOw1hsipl3hMDNfHDHULTQnnk=
X-Google-Smtp-Source: AGHT+IHONeTMTlZc/dhFnreDah0UNDLz/HzpUCqKSjmy0y7Sd85L8afYHGu/06XHa6sOG1l59lYvFZYabGpurtEARPU=
X-Received: by 2002:a05:6512:4487:b0:530:ae99:c850 with SMTP id
 2adb3069b0e04-530ef5212e1mr2171188e87.1.1723390706070; Sun, 11 Aug 2024
 08:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726120930.3231333-1-leitao@debian.org> <87plqkrwns.fsf@trenco.lwn.net>
 <ZrR2rlVkLqp0GXgt@gmail.com>
In-Reply-To: <ZrR2rlVkLqp0GXgt@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 12 Aug 2024 00:38:13 +0900
Message-ID: <CAC5umyixKAYAdpBKd+O0Knb_cGGzFcQ8yJQWFNtnKCWxpiEKyw@mail.gmail.com>
Subject: Re: [PATCH] docs: fault-injection: document cache-filter feature for failslab
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, kuba@kernel.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B48=E6=9C=888=E6=97=A5(=E6=9C=A8) 16:41 Breno Leitao <leitao@deb=
ian.org>:
>
> On Wed, Aug 07, 2024 at 12:54:31PM -0600, Jonathan Corbet wrote:
> > Breno Leitao <leitao@debian.org> writes:
> >
> > > The failslab fault injection mechanism has an undocumented capability
> > > that provides significant utility in testing and debugging. This feat=
ure,
> > > introduced in commit 4c13dd3b48fcb ("failslab: add ability to filter =
slab
> > > caches"), allows for targeted error injection into specific slab cach=
es.
> > >
> > > However, it was inadvertently left undocumented at the time of its
> > > implementation.
> > >
> > > Add documentation for the cache-filter feature in the failslab mode
> > > description. Also, providing a practical example demonstrating how to
> > > use cache-filter to inject failures specifically when allocating sock=
et
> > > buffers (skbs).
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  .../fault-injection/fault-injection.rst       | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> >
> > I've applied this, thanks.
> >
> > It seems to me that the fault-injection docs should really move under
> > dev-tools; does anybody object to that?
>
> I don't object at all. This doc should be inside dev-tools.

I also agree with moving the document.

