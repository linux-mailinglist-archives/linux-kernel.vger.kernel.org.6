Return-Path: <linux-kernel+bounces-275106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED09480AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB11F21D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E115F3E8;
	Mon,  5 Aug 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug529BHH"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D213C80A;
	Mon,  5 Aug 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879951; cv=none; b=UVfR9P47AtA+TJB2xGAWTBLOTgv/++L1SAqDJMjkW8erb4QHRDC3clwVzNDmWrUEgGvS/uVjXm/oEiCBq3GO/gWIG862RVCeCBu9wRa+5/Cy+z13yugeaIg8ukuGFbPUdWv6e/6BKnznUJbx0Nr5N2Z3EyicNjK+8T7SlhwWvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879951; c=relaxed/simple;
	bh=R0ij0TpmdhIJn5jKNmeFNCjk6XB6VE2j/jtnDm9XQwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwHNYAG4HNlxnk3Y6EExq6M7raJAHcxCTL6iWYi6LbBfPFJbUsiHYnZ2QOHMX1Prhbdh4o4sRfancgNRs9fZHGqtWYj8Yga+rxEnolsvODr+Ejc8AQ/PU3tDEE+y+UkbHFQlAzrEBlofnnaAB9PrGyMtA9/bjZMevGFnC1xkKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug529BHH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso7787198276.3;
        Mon, 05 Aug 2024 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879949; x=1723484749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OX+PY7gF3U5W8FwleDOndTOyh6TKnpOOiqby/oVYKps=;
        b=Ug529BHHEdTHudV30NhJe6LH/418i1P7oATsZJXZWnh7drlaKQ8XJFxc71AoqzxRgZ
         kr7RvtELLazNWRTFr4FYDoERlOd6HTnWGRge+ghJe82Vb+VWeDb5epfUaXanu5nShZEx
         c+DvudXZBTH97YYXS0fnxdyAtbMA13Yo6UCyR6GoENcB5HBmEU5HvCgI8mtJScgqqu62
         vABg9LRgfD1ZxtBSgZbQ2X82sDG4UkaE0ClIKsuPbgNtPLF4wmVeOxYaJgnnKwC0ocxQ
         jCThgndajAWdKE6JS5cHxMlCOqZ1ojX5rEcQmGcagRcriuv3VqYucrjjbgOkOtIukf5c
         UVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879949; x=1723484749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OX+PY7gF3U5W8FwleDOndTOyh6TKnpOOiqby/oVYKps=;
        b=NctiXTTB4PD+heZOwJ81BDLdNzCnsKrYNdUWwoDraOJ4zcTa2e3AKQWCNtPi0weztf
         09OXL63X/79WXBJMsM/raqlHB5PrTTvYhdaVpXLH0kVQxt2Ot/9HttTWnlYjrK6OmNot
         awbA876WOdBfYZfyCnk2+C9r7HHLMJnJ4SSbsAZSHDIUxV0Rl7/6Cim9DOTkZMePp4/H
         9q3awSIX6rZzaVJqAzR80M7xhnyMyEUm6HKsG5VSrVxph8RupmVxGCx53f+wsMEITm5e
         zYv0G3dyD9rCabLfSKsujecu4XBWBFZYaHJcmjuQRnzT/aITivlJ9qOgYhWj0WrkbqO8
         bU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu5mqugMGpp7rjUjdR2WSWKWLpbYs7u4/oKjyFFSwYR/D6Na8Z8I2B3s0WE23TMXZbvc/6YL1jDUddzOne+JR4zEZM1F5h7vBZYdsZA1rofMnWRyG59EgcHXq1tDBEm9jKFH7vNhrwQLao3Hop
X-Gm-Message-State: AOJu0Yz3UsPXrYFmRgt0TkFGwyHbNUO6C/IgPzQ0yUptt4g1vDn+9QRZ
	Yf14edTfAVOPLIFxxNQ8rnSs/A+KKu9+Rs0uwM6yn6EEKyWvo9Ha
X-Google-Smtp-Source: AGHT+IFbbScgWJ3FZrPKiuR3GszwrMjkfGx6vro9oZ10wFRgK99FTq/zPxkZIzItl9CrOoJilMd5sA==
X-Received: by 2002:a25:e0d7:0:b0:e0b:5b37:d0c9 with SMTP id 3f1490d57ef6-e0bde346ab3mr13816149276.14.1722879948852;
        Mon, 05 Aug 2024 10:45:48 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6ffdf7sm372917385a.71.2024.08.05.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:45:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 184E9120006C;
	Mon,  5 Aug 2024 13:45:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 13:45:48 -0400
X-ME-Sender: <xms:yw-xZlB_g4xAHK1qh2uCfPgtxTeicCg1mzfSl8x0PEcI_AWX0tpEZg>
    <xme:yw-xZjgxFf6gzuYPPQj2RLJgH1yZ0TdXmVs8mtv0TJ0BxhOxJKTdvwVYMekX9enXM
    5HfM6Bsd1G_BfVcWQ>
X-ME-Received: <xmr:yw-xZgmdPiC1_o5jzdaOgjRryTHxcAlo0jMr0uJU6iu5zrDtsQoz2nmmv4YUd4kjqD8YL80m8P63KIVoc2wx4nFcsLI30-Rx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfedtvdfgudfftdfffeejvdegtddvvdfhkedugfegkeeftdffledtueet
    gfevkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghp
    thhtoheptd
X-ME-Proxy: <xmx:zA-xZvxe7tL8fxdsdDet2f0z-_wBeJu08Kc8w_65i58OyDZjo9cvKA>
    <xmx:zA-xZqSdaE0V3M-gETq15x7A1X7LSAr7WPKGjBzQrBfPyHUKhVnf5g>
    <xmx:zA-xZiYTQ_-_Z2vHMF8LBECi5tDBVc5IkJ_of7DJaMmo7Cmx1NpIoQ>
    <xmx:zA-xZrTcaABZkrX-AaI9GlauEfuiwaxjTdCYNhYqq9U6m_60cxhvIA>
    <xmx:zA-xZoB9kPk9APgdNaGM6yqfzNwiosbKmk4TKaKc8Ky-auGTeYAyxVBw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 13:45:47 -0400 (EDT)
Date: Mon, 5 Aug 2024 10:46:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/lockdep: Simplify character output in seq_line()
Message-ID: <ZrEP8QlnhztnwvWy@tardis>
References: <aa9e1986-8631-405e-96f5-86a0f5a1eab2@web.de>
 <975d2b0f-f84c-4c84-adf2-098fef59d90b@redhat.com>
 <7560b341-27b4-45b9-8b73-202ec7f27200@wanadoo.fr>
 <e346d688-7b01-462f-867c-ba52b7790d19@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e346d688-7b01-462f-867c-ba52b7790d19@web.de>

On Mon, Jul 15, 2024 at 10:51:44AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Jul 2024 10:42:17 +0200
>=20
> Single characters should be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one se=
lected call.
>=20
> This issue was transformed by using the Coccinelle software.
>=20
> Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Queued this at:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ lockdep-f=
or-tip

Thanks! And given Christophe's comment, the original one is not needed,
so drop it.

Regards,
Boqun

> ---
>  kernel/locking/lockdep_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index e2bfb1db589d..6db0f43fc4df 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -424,7 +424,7 @@ static void seq_line(struct seq_file *m, char c, int =
offset, int length)
>  	for (i =3D 0; i < offset; i++)
>  		seq_puts(m, " ");
>  	for (i =3D 0; i < length; i++)
> -		seq_printf(m, "%c", c);
> +		seq_putc(m, c);
>  	seq_puts(m, "\n");
>  }
>=20
> --
> 2.45.2
>=20

