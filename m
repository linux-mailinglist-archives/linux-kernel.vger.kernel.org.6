Return-Path: <linux-kernel+bounces-245038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B118792AD74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41699B21577
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF02AE95;
	Tue,  9 Jul 2024 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSRNMKuC"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBE26AD0;
	Tue,  9 Jul 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486675; cv=none; b=KpBoGU9VVSLK1qZC8InG1Ui4zX4lVD0paWSKN28vslOtJr1sdsaOWj2YnV2isP9aJdcath1/QkIbWdJYCx19UwRsnLqMSHFNT4Ux2WmVrsf5yUYZ5yDMNiic0h538xi8yjL8836SHT0dHv7vECkH+j8jUabCl3YiAPToB12vq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486675; c=relaxed/simple;
	bh=2RndljY+ojuqqLEThPj9Ebbm8sK/uGI5QU2zT6/ks0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phl5/ZrkHqocHFa/5xK4Kd5r7qQR7wrsd3vuqzuE/jU4X24/iXxoJuuUACFZ40r4ONMPnLHpVPMzIHge/Fh51fsd9r/w4Ox8HMHMdNdZayar/l1boJw2P92k5+Q0/m4/G+xErJaGmEGNsEV6/bqjJE1oLgti1Atbn/pVX2/IiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSRNMKuC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso4550039276.3;
        Mon, 08 Jul 2024 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720486672; x=1721091472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RndljY+ojuqqLEThPj9Ebbm8sK/uGI5QU2zT6/ks0M=;
        b=LSRNMKuCpyIM52BqL+iXfygUan+CZEJ53pbYuqC/+ybo/tmYcS4TIW2CNZnSEle07U
         2uXicz036DWH1XTL2VDr1swnOV3N/VxE2F3c1mhXwKgsrFzY/Y0GQSW9BRybwD/CLIqY
         SWn72dounvMXeagyQ/zjeDgyIobZKxzD+I94E4TMWtOeNYHi0bSZhd1ZxZMRdZ4UUcb3
         E7o/MW9TTKtm4vmQbqhxOJmMHAPvJGT1ycYUwZIEjBnEa5GR7QCsBxQVvr2dUO5Vufpf
         2DCZ94TpK8IPrS2ZOf9bfWkA+4nypFNGSQFA4AvZexkJl70dN9UKfvbqKCepi9mITiRS
         i89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720486672; x=1721091472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RndljY+ojuqqLEThPj9Ebbm8sK/uGI5QU2zT6/ks0M=;
        b=t8d9QVzz5SB+PBAKTsYsVE7FxmIjwHCbBOUlyFjYwWbeyBT9wKidMqxBaRmXK31jDB
         vNen9Xdu0NF619GgSq5v5H07Qp8VIJfOTJksIoNubAmGLsD8lMtaL/nIhUQ+jo8F/SQn
         A32PszGGW6NxFmFuZ3+j3TNqtWHydELs5MK0piksHdtvZhTX+wIMHCof1iLSDb59KrmY
         jrCWifkd/uUrap11h3Cv8Jijpp7HGaDAEaj94sQagyFxzP1tyvWd7CP62XcaoWHZpFIa
         Zo9hnjKwbm7RflD4IeUcUpKzbIBu/qj8LcvkNcHy/SmOoQtjrWQEdf4gT0RD5vEYF3ag
         9kuA==
X-Forwarded-Encrypted: i=1; AJvYcCWjldppzx2wOi9M09oDcHhmVkk3h2JKsWpb+sUxWRCZEcNN3TcBGgX6ba28XHeiHj3wXDxJUZcIqG9M2ziUqiMQDI4bG9x7W3HXyaoS7eaFyLR0eGtKd57Et5Uy69bRmJs0Kt51OEq3
X-Gm-Message-State: AOJu0Yx5KTdrPjepO0DJ/dLnDRgFyniExPAFxjbWNC+dtEMi7cEwHECD
	RdwKWwCWMN0ryW3SNqHyAh2hY+OWk2VANXYS26JNIQUVJgbn3pPRlvfWNHdSomtzEAG5FQHtncd
	2iABeTQrDSiXo84OhKdlfwjY51Hk=
X-Google-Smtp-Source: AGHT+IFUElNwsuD2/fvQADjVk44tQ79KBYv0RH7VC5FPIfSpUsuA1MqG5hRQv1kgsIWJFnrV2CNyogWNYmSn6rPh5T0=
X-Received: by 2002:a25:8243:0:b0:e03:6020:4708 with SMTP id
 3f1490d57ef6-e041af3f4d3mr1537658276.0.1720486672584; Mon, 08 Jul 2024
 17:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-7-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-7-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 8 Jul 2024 17:57:39 -0700
Message-ID: <CAKEwX=NJjDL3aW3hXioxh=yASSsHbDBWubV9cE2RiH+tSXpscw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while
 pagein/out IO
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> To prevent the zswap global shrinker from writing back pages
> simultaneously with IO performed for memory reclaim and faults, delay
> the writeback when zswap_store() rejects pages or zswap_load() cannot
> find entry in pool.
>
> When the zswap shrinker is running and zswap rejects an incoming page,
> simulatenous zswap writeback and the rejected page lead to IO contention
> on swap device. In this case, the writeback of the rejected page must be
> higher priority as it is necessary for actual memory reclaim progress.
> The zswap global shrinker can run in the background and should not
> interfere with memory reclaim.

Hmm what about this scenario: when we disable zswap writeback on a
cgroup, if zswap_store() fails, we are delaying the global shrinker
for no gain essentially. There is no subsequent IO. I don't think we
are currently handling this, right?

>
> The same logic applies to zswap_load(). When zswap cannot find requested
> page from pool and read IO is performed, shrinker should be interrupted.
>

Yet another (less concerning IMHO) scenario is when a cgroup disables
zswap by setting zswap.max =3D 0 (for instance, if the sysadmin knows
that this cgroup's data are really cold, and/or that the workload is
latency-tolerant, and do not want it to take up valuable memory
resources of other cgroups). Every time this cgroup reclaims memory,
it would disable the global shrinker (including the new proactive
behavior) for other cgroup, correct? And, when they do need to swap
in, it would further delay the global shrinker. Would this break of
isolation be a problem?

There are other concerns I raised in the cover letter's response as
well - please take a look :)

