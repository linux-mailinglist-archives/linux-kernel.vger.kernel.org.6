Return-Path: <linux-kernel+bounces-518115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A8A38A24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2F116483B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E922652C;
	Mon, 17 Feb 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFhTmS3X"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30911226522
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811406; cv=none; b=ODbIDfjIi0/G0s6C8pbzG850XGvcteMsAv1sguyrFvWEAIDV5W5RuIQJos4M+3pl2+HMfBz1KIzTwrAtUReNQ/6uDnsCeAi94JGuQyBJ+ohQ5RIIUryzTM0zZP3/UDbbfi0brV1TnH4vn+no2fSLlrOC96OgHUeKgo2N/8Flrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811406; c=relaxed/simple;
	bh=+1QvmTeltNCy0ewISfLGnEHCX0liAeBHZC9vjnmbvGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlpVkBqPYEIcvwP9BqE7oe4TwOt7Md9toOt3qabP26Dro65RqHDgyHwJjkJHuByYlF9Fep8FnnosHLgeBW595QMULZmwCfgXPrqbuTCOdrY18YCXD9T153OkOQzIyXscoauyCEZie3jKXoOZf9aZWf1gwqaD8lXIvj5LfrmUUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFhTmS3X; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471fbfe8b89so88661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739811404; x=1740416204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qSRpBN359hHX+cCE/TztrmjJSk1+HscqPfr/QXbduM=;
        b=RFhTmS3XyGNNFtKnyy7CBpgAD4vGAWzQbfz3Lv7wF+ULUyiSAi7GMglIlUhD61JK0T
         9r0/2hoR4i6gnqPZHLT9rhVJ2kuKcE49Ho5innQO42sOf3xoxDlc3u98aqWYh1bubqCf
         h48CSx2YY5hDfRcl+umICAH+aGLQAGrPObiZnahHGDquBdeR/9O6lvJzJxGYQP/kDXIn
         1jUP0DjYX2RZYpfnkKhjza4JIXePNBEGWLze2MC0x5/HjRtAgIKYkM6qVyD5Z71YfquM
         dYFkkqVRLVT05jwjVVax28cZrVzbI/Elh8SwYT8ykxwkVSNAsotZ1+wxe8NDh+lvUVJU
         ZlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811404; x=1740416204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qSRpBN359hHX+cCE/TztrmjJSk1+HscqPfr/QXbduM=;
        b=cozJ/hpnE2fPHVfAjbWTdq1lUEpEPi+5zM/tY7yFviOFRj3vKixvgBawD4w5n7Q4HH
         ReBh3EvbABTaBBVTo8IQtkzZclJcbaxATART8Ta1do8mxhwIltL93i1ZsFLlOH0CZ6lZ
         MZmLXyFUcwl1KsZC28Tqkk44mzinrMqaJGZDsLxZRSDCNsSx5Ms0yRG2oLl/iRa0F+YR
         CuwIq18YaZJVwgushR4L4sjrgTkFOQimww8WHDJPjCz2ZNWO0j8UBXKv4NLO9+aVRq/m
         yBrHqyXo/GVhkGjT9C8RrlCcROvViuVR8sUZvu3RcjKpb+klPpZXR5ZzlE/370P0tn34
         fGwg==
X-Forwarded-Encrypted: i=1; AJvYcCVAyiZf/nN8ubVgbF/v56C7qwxDdq+5hNJM1p5NGO68BvleL+Sh6Oi8NTd/o7esi1fIZo1NdC9HNmNd7us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hP+Va0fbVGbcw9/zwkb5o9j/23OUy7CRnRXo7LaBjmoxYfIe
	p7QZp6QII8TI9buRsEsUGJhLfcvdHNVzHE4wOKPEjpfFWlsQ7pESs4BiVx20CiaiEGMVfZhWk3v
	mppy0ACfeQVh0IyQe48uNDs9PgaXT+7DdrlZs
X-Gm-Gg: ASbGncsC29H+4Z/PgYloHOoDxweo28+0IzHETBM/Mnn96526QQlphL2LqWWNtZlsa1U
	Unlx9f3yjGNSAsBNmpX9Ezt6a3Yrog2GcxCVkpoCGyP5oJKJJ3qIcVJrmJGlSGWQG0onwBxjdiz
	GgXTsIxTHP89BkOajbQvne1DrYGb4=
X-Google-Smtp-Source: AGHT+IHCtMfDw98unx789UAqr8x+szvL570MR31u78p51rZTiegX2ScDlDe+ywsfBL4Sg33XW0YMbvVNgXrwIIoDMqc=
X-Received: by 2002:a05:622a:54e:b0:471:badd:bd2f with SMTP id
 d75a77b69052e-471dc6602d2mr7637521cf.0.1739811403868; Mon, 17 Feb 2025
 08:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-3-5637b337b443@google.com> <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
In-Reply-To: <20250217111029.GIZ7MZJUGJRoeiScgn@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Feb 2025 17:56:32 +0100
X-Gm-Features: AWEUYZl87gmBfs2wNkKiO_BAOR84Ep0eGh95DvqtW1gZo2AtnCOxVeh-iiek0-Y
Message-ID: <CA+i-1C3fetiBYVbfpAbQEAnogzdza25pu2DosCiTT9YkXwt0yw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] x86/cpu: Enable modifying bug flags with {clear,set}puid
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 12:10, Borislav Petkov <bp@alien8.de> wrote:
> > @@ -1492,7 +1492,8 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
> >
> >               /*
> >                * Handle naked numbers first for feature flags which don't
> > -              * have names.
> > +              * have names. It doesn't make sense for a bug not to have a
> > +              * name so don't handle bug flags here.
> >                */
> >               if (!kstrtouint(opt, 10, &bit)) {
> >                       if (bit < NCAPINTS * 32) {
>
> It did but after
>
>   7583e8fbdc49 ("x86/cpu: Remove X86_FEATURE_NAMES")
>
> this chunk can be whacked now. Please do that in a pre-patch.

Er, hold on, what chunk can be whacked? Do you mean delete the ability
to set clearcpuid by number? There are still features with no name.

