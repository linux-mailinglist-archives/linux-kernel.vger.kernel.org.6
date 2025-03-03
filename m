Return-Path: <linux-kernel+bounces-542898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E16A4CF37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125BD1895D81
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52050237185;
	Mon,  3 Mar 2025 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGuhl08/"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FD1EEA2A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044526; cv=none; b=TD6VFY1Ykn/A3FdO8C0nJsBu9jC6eeuti5p64flH/HeNr7/hJWgGImOqSwDdFEhjRUD3oPtbOjijSjLRl7bR+34Q6i4S8VHjHBDJ6Ga67IW7ckJoBRb6LirU+J0z5I6YTgB917JaDKMfwpjqkY9SV+82d3uWRehQlDzRMgJtFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044526; c=relaxed/simple;
	bh=8E7LfSyif3VgesHWuCU2ldbd3kmak11f8kiX20KMtUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOryn/x6tXm34zOIwG2p/h5naDb0RurHEOWziOIczqPwpR418AtaSgaMYrHilwVbXX/yuhqdJvIsJax5YXksCnwnlvZ45se4p6sVAGv+tyswuw66+rr0nLnkrHNW8CkkShAJC9Pgzq6ELpUHnnHsRwj7qyQ8w2gcPbeYjb/MVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGuhl08/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd049b5428so45894306d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741044524; x=1741649324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGjr7Oa8WXRDynLG7DHXT9g5o8RV9GYmhggtGAtGgyE=;
        b=aGuhl08/evy0u4TnGSTzUbqgFwC4Gz7+wu3GFwJ6UYhvA3y3oN5jOfTV12PrKIVYEL
         beWRTS8vuVehtLpsW7fkRFJMuCrqK9n5i2YAa49z7hsAOh47iwCom0cwRTVaFJ2OhnBH
         HVK8NnbiCpjYiwv1rHPGZsPuiEhjwJrXYOvYjqgipDyGZnNAQors0Mb0UtKvc5d+T11F
         pqmn+XM6SFq/8+1OuzMC2qQ9rfWc2oAmoKzwQoQitLWn7Qf7jRxO5XGhv0nxG5aLGz1E
         H7nI3DISx5zfxedLRgyUBLyTDj5KIwx4JpBrToMgkp6pIqeqnCH/Nx3qx1KOE7IbnVyV
         mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741044524; x=1741649324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGjr7Oa8WXRDynLG7DHXT9g5o8RV9GYmhggtGAtGgyE=;
        b=c2RMIxR7sIFmX6k4XzuSE+EZHv1+g0LXA660awJSR/k8okMSnnn5k1GoCOGrDxSwFb
         Ub9MLcDJTYMTrnUehvrCmMVICs7emErwCVIQ/GWTqIPSV2/m9F+X787Guu8LayQqx6f0
         Fw1ECId8UQe+lQ2XTq0k32UoxGAFFtFCckaERVqhu4hSXB6PTAy4eiGQgljCl38CJ/5w
         d3lvEz7LwH/IYNGlDaRpU4fq9BdmhCX27wZ7k308Pint5S3P5TWEm1FWbx9PXLIUw2Kx
         Nls47bTDcp9SqaUkHoHkL+ewnKIrxhl5VcluPCiHT40KpiUqO9EVgTAlorGQieCnlPrK
         lkjA==
X-Forwarded-Encrypted: i=1; AJvYcCW9NotFYQcx7fFFQT68m+FNW5mnyPncrit1KapRLv2qjvrqIjoN1Nt/tajAm+YVgce+MVlb7OcebnJ5Ifw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5gKmzQqQwiqQCllzpPTybwYQT3ar4TetyMqv89V4E+lWagTb
	AqraUhmkJa7qs0MWQpkVh8oKFv+7o35v6Ws7AAnBcaULQaFeKl1B6njKtn0dRo2tfw2gNHuh1mc
	cJAPvPQt+DNAD1UkWHZC97EkpQ+w=
X-Gm-Gg: ASbGncvvgwqUBjvhaGTWK2rBfC0X9a5VN1BC5gMk73L/DvsKMrV8zwLpIap1fjyIj5R
	bgWss0J2B5XcFgXYKCrXkff4aLTwWdcxIOFejqZSA9FgMt8n9DyxudJZuA9Gz+94bHCr4TVCoXA
	miskOS4EQOHhKCgOJSL7cUKyampBBEizVTggYwOPwFpA==
X-Google-Smtp-Source: AGHT+IF/nfEV3GTTfM49pFfn3pirjQtmH/n9CTKPHC8wO0WydZ9KrqM1JzDqDCQ5is0NC6ier/PZ9QCkzqvmjd9UbaQ=
X-Received: by 2002:ad4:5c6a:0:b0:6d9:2e0c:56c4 with SMTP id
 6a1803df08f44-6e8a0c888cbmr216672176d6.1.1741044524000; Mon, 03 Mar 2025
 15:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200627.2102890-1-nphamcs@gmail.com> <Z8YdV4Vqju2w7hqI@google.com>
 <20250303215524.GD120597@cmpxchg.org> <Z8YuhvMZkE7CoYRN@google.com> <20250303231654.GE120597@cmpxchg.org>
In-Reply-To: <20250303231654.GE120597@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 3 Mar 2025 15:28:33 -0800
X-Gm-Features: AQ5f1JrLueY3cU_Xzs4E-j36PMU_qvJ01l53c2jpyuOndFMHn6UNVh_YRZ0ljlQ
Message-ID: <CAKEwX=O_EHud_6SUJmxP7cwoi0NUcLPjUqz+s5=PTdukCxQrhA@mail.gmail.com>
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 3:17=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Mar 03, 2025 at 10:34:46PM +0000, Yosry Ahmed wrote:
> > On Mon, Mar 03, 2025 at 04:55:24PM -0500, Johannes Weiner wrote:
> > > pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%=
d)\n",
> > >                  swptype, swpoffset, name, clen, dlen);
> >
> > Yeah this looks much more concise. It's a bit harder to parser the dmes=
g
> > as you have to cross check the code, but hopefully this is something
> > that people rarely have to do.
> >
> > I don't feel strongly about adding a helper in this case, unless we wan=
t
> > to add local variables (like Johannes did above), in which case a helpe=
r
> > would be a good way to hide them.
>
> pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n=
",
>                 swp_type(entry->swpentry), swp_offset(entry->swpentry),
>                 entry->pool->tfm_name, entry->length, acomp_ctx->req->dle=
n);
>
> Seriously, this does not warrant another function.
>
> It's also valuable to keep warnings inside the problem context instead
> of socking them away somewhere. It makes it clear that decompression
> failure is a serious situation. We also expect this to trigger almost
> never and it won't be tested routinely, so the best chance to fight
> bitrot is to keep all those derefs close by. Imagine if this triggers
> and the data is misleading or it crashes the system because some rules
> around entry, acomp_ctx, the pool or whatever changed. Or if the work
> involved in decompression changed and this is incomplete/unhelpful.


I was actually thinking along the line of Yosry's, but you make some
good points.

Anyway, let's just keep the printing in the OG function. Let's not
overthink one print function call. :)

(sorry for the duplicate email, Johannes. I accidentally sent this
email to you and not cc-ing the rest lol. Resending it)

