Return-Path: <linux-kernel+bounces-564070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D66A64D29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A083B2830
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AA2080C1;
	Mon, 17 Mar 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="eO1kXvMi"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48A21A42C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211991; cv=none; b=NvVQW5KJ10X9G9O05WG1CK1DGQFRPMmMhkR8LCqsD9MJ6onHJRaEk5ZaPX8HyhwmgHX4Mn3mXRdunJTftx6ZCRfUlOcgagKNG7dHfmmCgPrKflRMkVtf0N0S4ilxMrQfZZ7D/ZLNbtoA+sKbUtGwZDbAL0q7LhI8w0hndX6TreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211991; c=relaxed/simple;
	bh=JevZzyfTcbHeugB40ivEoPSaxiJnj3O7ha+8VEzlR7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2ty+RBqPjgXR/WxrL31opweMM5dZwbaLPD6SZOqrgzfyH0vxS6F8HFD3OoM2xahKn52fVt+DP9VOO7UDozsJ72XwqCkxU+MtuOsuxoFTVb+5Z2d8MBrz+ADivYPpNHEkZukG+ABniOt9Y9uDRIsJ3hMAjeylwbRxJtGV71qlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=eO1kXvMi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso3715997a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1742211990; x=1742816790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH6tfS+5j8OUG/YFOsI/z8W9XiVewil480YlgnfUj5A=;
        b=eO1kXvMiCB4khfrpCpmTGLHvk1CH9T6oj+ANk5UOPMKZyJytYABkbAMhFUwMhWCytb
         vNZqmSmYkP0aqRKqs5eTD7So+AkVeumXzFFP8cD3wAvYKewKM7liUJDyzWTNizxgz7gC
         cwfQvUeHrS42a8GDubqIm9fcrcbEyv/E5Yg21Mw654ywqDRpU+Ul2cWzyAjZNH6DIRm5
         6Nwr3QcBll469Y3vJUlnPI5MOTWd8UdDmoMNf8+SbCjYsWvzN/Qhitw5Ty3eOovnaiga
         2VleUcEu4GrTfSQz28vYC+r4m6vLWXJ3owK2jxu40KM+NrnLqBbXQtoN3ajOYnlj+nWB
         PCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211990; x=1742816790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH6tfS+5j8OUG/YFOsI/z8W9XiVewil480YlgnfUj5A=;
        b=twYU5POnex8DYucyH1UcmKRxoD4fkN4H+vdCW0dENv7FN/pgpjSF49Q/P48ZaeA5BD
         vlImCXLFti+kN+NMg7VzSyjpLOGQ5N1uZLD0JwWQD4tfac9X8CTID5+HqeEccbnX/uvK
         dx8n8hs8sKyDJnFR/4WWI4SIRxuMHiDe8K1fm+r6fGg7GVtyVOMriGV/gBQE29nQQ93H
         GlY7bia2civ7w/ecIXpVeTZvzy/mKe1b6BJZZ2cb527Az1NOu6TO+HKkcTFI3hNw/DTf
         /7hVOSmwLaoC1O458+sZfY9J6bdnafLXHaYaRhbsVBn3osWfUfdimTyQnPqWU77AjR0E
         Jlcw==
X-Forwarded-Encrypted: i=1; AJvYcCWXdYZXPFHylbjOcBV2U+f4hdwanfy7ex0+B+AfWiKT7n2uLqccSqniCSp39osw0fh5UbWR8L+WZ0WmRrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvPPFvJDUKSrWRQ7zujbG/5kt8pFIHi5HyW7sdjKe1YCytmcJ
	WzU4zMLr3m+yXCTt/Gv/+NyTXcGAJPohaQc3mq+pN9vCrdZxhCNuecj//SLwioIcnIs6t9SCqn3
	QPw/Ta64cG9vcpt6GdS2Z7DVD0FzBzLBm+yGoaw==
X-Gm-Gg: ASbGncustRdP7UovNkWJzqu366FrlKHELlfUCT2w6/zfeYb8teHPDA1eEUb8aKigpUj
	wCTzUZUE3lg7P5gdpzWPVVHzWi/3ZMlOcSAb6eRJBFfDA+WjHqc52dMw9AyKqn5rAajSfqwybOo
	rUmDfJM3ihKoW6fXnhLcD0ZJ8w70ge3WW0og80v1ApevNooTEkI+I/trU=
X-Google-Smtp-Source: AGHT+IESCWpyJuNduk1asGzI0qATkta2ZCkb9Xjh0/OEfDUVC9ScmHT7hwANhkSUSFp7nPtTtNeiPSYikzwjhMSfw4M=
X-Received: by 2002:a17:90b:3d50:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-30151cd5f9amr15532322a91.8.1742211989805; Mon, 17 Mar 2025
 04:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307150940.1309703-1-matt@readmodwrite.com>
 <CAENh_STT90u1G1rqiXOarM5O8Ls5CyxTbrh+Sqi9PBqPmg9RXA@mail.gmail.com> <CAK7LNASyyoJJV==wy2KkrNYOHn6xr0-Y780jJ4cut-wvkvh4Jw@mail.gmail.com>
In-Reply-To: <CAK7LNASyyoJJV==wy2KkrNYOHn6xr0-Y780jJ4cut-wvkvh4Jw@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 17 Mar 2025 11:46:18 +0000
X-Gm-Features: AQ5f1JrYfVs0mGshIcm9lByJl9y9FfZ4cDE16tE8N5DfnlyqKwYmXF_K6BUGqcQ
Message-ID: <CAENh_SR6A64hnwxYOeDOm_697Osx6aydSard-1CmX-mxB_4U3A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add KDEB_COMPRESS_LEVEL to control compression level
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:07=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Sorry, I missed this.
> I would have missed this completely without your ping
> because this was not sent to linux-kbuild ML.
> (sometimes I still notice, but sometimes I do not.
> Including linux-kbuild ML increases the probability of my notice)

My mistake. I will include linux-kbuild in future.

> If you use dpkg>=3D1.21.10, you can do
>
>  $  DPKG_DEB_COMPRESSOR_LEVEL=3D1 make bindeb-pkg
>
>
> KDEB_COMPRESS_LEVEL might be useful for users of old dpkg
> versions, but I do not want to add an option which we know is already
> duplicated, since we would end up with removing it again sooner or later.

OK makes sense.

Thanks,
Matt

