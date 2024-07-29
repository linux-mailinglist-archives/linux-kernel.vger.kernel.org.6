Return-Path: <linux-kernel+bounces-265435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C193F130
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C7F1F22DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D981770FA;
	Mon, 29 Jul 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fAGv9vHV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD596383
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245572; cv=none; b=S2AGC7vOVWdzLCCDZWI7d8+y8lNQ5rgOPbClY/xgdSQDWmfULxQnj68xp9K9ODZ/gUq12Eo6htjWBes3iRsSuKohaa+MLpWdpTTtWUALxNsvimsLMZnuJn6LUl4D1vflm9vxTFy9VkxQW0jMBknMsAVPufbElSk9lZ9LJu922bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245572; c=relaxed/simple;
	bh=LD744I5SwsgYnwMkGqrIP1GhP4ARkGlFsjd8ICm0CN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdSkqq7B/0lEGDAnYNMht0W622higfC5USALjgZ1/YbUkOmesH9fMu+zLQNi+3QWotn5qRh+tZFQpvKjMpB0K+5l8mMLnfd9xcSzPAMf2PMbYPrOT42sGKixU+gbZg3MlJ91z3J8VcfQYKZWYomENcCfiF5dLKiZsLewfmrNw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fAGv9vHV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so37769561fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722245569; x=1722850369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VooLxPhLo0Q9KH80XmOztltDv1lC1/E4jkpqav+yH84=;
        b=fAGv9vHV/4+x3CNY1vlkjK31LM8dcsmISySASbEWlWYdytslQNZyTx3YRBC6xinduV
         5SmMgc0wxUVRmkyvCxxpc2gchea9HvDPpB3xvgXSQScepoKPuqIdaIBJvekCSSklkpLZ
         p/c6VLtQXYjDqNpfaCdpWIfuOn6+/UF5Ziw5yTpC3e7fTIQngHPJkgVwT/ubSDoMnVEi
         Y0Wjy0vxq0bVbMae6/ZzXlKcpgSUrv4RV6VsgOJ7EgO+Cj1m6xeAdPzEJXG5/wxR5hIP
         bwAHbnqeynJGzL77A7fBLIh8qOK7iKTS2dAItx3yz57KNC6PFfx9CqWc3zWNyZ1bB9bm
         WRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245569; x=1722850369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VooLxPhLo0Q9KH80XmOztltDv1lC1/E4jkpqav+yH84=;
        b=dnq14TX3PJDMh26vRWxEsdrfvShW//7ejGM3Gqt+5rd/rwBRb1q7kkREtjW5Amk44p
         TnjD4XU6ZxkRSzYmV/+xc0cabpJuIYbtadvHnVewia1osbxyeXJ62WahWDXl+3L7tHKT
         ZoXwGw/4RRowtmpHMVieu08DVgQ7MWTvBirfIUJDnD6yKez5HtR71yBqyOhT4Psb+l9v
         pmaYQtSy+NKZEbvX9rAydS3suipEa/F6raFxw2sYeb3SuHC9X27cyrH6CRmbOdapqYjt
         n7tMWGPy5rbLNdbrOwNAUBwhWU94PvvWerBu4RSwug/St3asSTPnCSRWwPj3nFZ+O3yb
         YuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWZWvfoBsGne8Hpx169yKKmFMj9XlI2vLoZ2PGYtlAbP188QM3APJd9pFYO/jvDZ8+ax4EKrH9CoGlMCrLE6Mh183keSOrfFDlSwq2W
X-Gm-Message-State: AOJu0YxJYMsILBqmizvMVA586UtZfyakC8A+8t5dVlrXoemUIZgO7/k9
	6a3oRqBS6cjVJI3o2hzHbR3jXV/HU8ETRbs/ktiagRXK9WYUW4hb6Te7iMxs/94=
X-Google-Smtp-Source: AGHT+IGhC4zS/Ai48g4kaHmgQl5QMFgLFwyG8C1W2+LRRjokihkUWvW4Us97NL1N/YK0hTGLJgQhhQ==
X-Received: by 2002:a2e:9646:0:b0:2ef:2cbc:9072 with SMTP id 38308e7fff4ca-2f12ee6ab81mr46263511fa.49.1722245568784;
        Mon, 29 Jul 2024 02:32:48 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7d6bba6sm6895358a12.9.2024.07.29.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:32:47 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:32:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xavier <xavier_qy@163.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RT sched v1 0/2] Optimize the RT group scheduling
Message-ID: <acq6wg6r63nhbxsl5xci3gsow2lwmrongn57l5642h4gnreiol@jz6a3jdiviov>
References: <20240627172156.235421-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5ebnjnwsjc7okjs"
Content-Disposition: inline
In-Reply-To: <20240627172156.235421-1-xavier_qy@163.com>


--s5ebnjnwsjc7okjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 01:21:54AM GMT, Xavier <xavier_qy@163.com> wrote:
> The first patch optimizes the enqueue and dequeue of rt_se, the strategy
> employs a bottom-up removal approach.

I haven't read the patches, I only have a remark to the numbers.

> The second patch provides validation for the efficiency improvements made
> by patch 1. The test case count the number of infinite loop executions for
> all threads.
>=20
> 		origion          optimized
>=20
> 	   10242794134		10659512784
> 	   13650210798		13555924695
> 	   12953159254		13733609646
> 	   11888973428		11742656925
> 	   12791797633		13447598015
> 	   11451270205		11704847480
> 	   13335320346		13858155642
> 	   10682907328		10513565749
> 	   10173249704		10254224697
> 	    8309259793		 8893668653

^^^ This is fine, that's what you measured.

> avg      11547894262          11836376429

But providing averages with that many significant digit is nonsensical
(most of them are noise).

If I put your columns into D (Octave) and estimate some errors:

(std(D)/sqrt(10)) ./ mean(D)
ans =3D

   0.046626   0.046755

the error itself would be rounded to ~5%, so the averages measured
should be rounded accordingly=20

 avg    11500000000      11800000000

or even more conservatively

 avg    12000000000      12000000000

> Run two QEMU emulators simultaneously, one running the original kernel an=
d the
> other running the optimized kernel, and compare the average of the result=
s over
> 10 runs. After optimizing, the number of iterations in the infinite loop =
increased
> by approximately 2.5%.

Notice that the measure changed is on par with noise in the data (i.e.
it may be accidental). You may need more iterations to get cleaner
result (more convincing data).

HTH,
Michal

--s5ebnjnwsjc7okjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqdhswAKCRAt3Wney77B
SUlSAQDUzkTGP8qOnB0/4JjaSyvpvNkymchrpjmI0j1m61++gAD9EGuxrvAjrtlT
kOykhYaLs6BTVyDIBnbidp9SsshiAAA=
=gTQV
-----END PGP SIGNATURE-----

--s5ebnjnwsjc7okjs--

