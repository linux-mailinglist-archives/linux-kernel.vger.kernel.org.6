Return-Path: <linux-kernel+bounces-510261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A0A31A68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F6D3A5662
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED24C81;
	Wed, 12 Feb 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MLHbF/9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23579EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319794; cv=none; b=TSdRuAtVJ4+nqzBaxlcm+NSh23N29JziRvp/HCAU7L4Obd9gjLajTsBH+G02/yV2c5fCP44OcSEBmuEatzMYZfk3wCxCFUEuaG05PL7Jug0BzZY4xVrwLFRVUTvJ6p3QqhThJvVo6AMnJfx9bGuJ1HOuQf8pmRb745P0P3kSzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319794; c=relaxed/simple;
	bh=qNR6Tk+GObHhwah3Z3S1fvOkyR0+TVEpjXojg1MVygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSLaaaXIwOvWsje3BoxKUriXWIZDGSsR4REFOxuy5FAJZHoMp932tMapOvA5a/iW4Flyt/PxVsLYJ7SSwjbfEA1Yn+84KIRmdn9GH9S2342+b1vzDimfKjh3hHYE23p8kRHp56SnzeYsbGGkRHVsypH4+Jk/XDooyiC13eb74Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MLHbF/9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5440f27da4fso3369e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739319790; x=1739924590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mACifcoi2DxXepU+x0EutTWQzaMm/Sos4wROfYi3LJM=;
        b=4MLHbF/9MvyJlVpqwihOMAbZEWmHui6Y/YoJWyrTe3ADLmu+r/1qeP2PffGFmCCjkH
         lVzN9XgIIEY9qNvk5CC9opqfil8PdjAmo95Tyfy8Gz2cuvHLCxPHBgl8pfhH2zWCrA6A
         cPsZm97NxRE46U/R5gJ4Wm6lZNt7tniwC1XrnF69awagyBbcDGrxpOrXgDqAXGRaHfM2
         jq19A4MP2qwShRWVymA8MJ3+EbIlSH0OnCeFbUawsxhJueWPrTJGbtqZ+kf/nQmYl0Np
         tg3pc7m8G4SGPYZT3o+oEwtjyqyhjex00xKOo2Pm7ofOl+xrszNaJzG5M3B6PSxepz2/
         KFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319790; x=1739924590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mACifcoi2DxXepU+x0EutTWQzaMm/Sos4wROfYi3LJM=;
        b=BFhmispdDr47tw89NFbnKzGAvPVclZFpORsZxhwqCVzYNhTRX5HhZo9YNnbmPRSxuh
         6IwXjz2bUzUdFC3DWtNC4lK9DdqNS5Lt1V6TwMeP/GQ57SDD7n4lnaYtP3r47omtlEg5
         c68UrJ0Hss8Zudi5ZEQPQYSvyLtNqSG/0Z9Q5oZNhs2hAYomgOx2wA2eC1U1RDoOzRHe
         lgmOK/pU9rYmGYggIRfEnLzyqen/ZECkKncfZHLHoB/8eFWmgBW0blVWS607ioX5tndx
         Isq2gwi/JRDm+88cmX7EjV8BxHYeL0qrlOtU4v1ZlGCy8gtePF6PGDi6P0ycoOYE8Rnq
         aAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVCm8kcTCho2V54R9HgZzGOBt22ob6Aj9vd1YnvkSB/qmwQIh92Tsnpx5z+saHyZQXokEieTQFW7gbziM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVAYXmIpReIu8Fzad9uXxx9zJUkBZ6SPB6dQtxvcJ7JjydyLi
	EVsa/MD5/AwR6t1tFUMYjVMxFc8BPDs/rHe71SboW7TEtO4bJ98GvMynW5JmLX26zqvVY1CaTZ1
	baFpRYfS2hSuhCNqYQat0iKCO22UVh/fXlNZr
X-Gm-Gg: ASbGncss4h3eBUQRBt9gXVTKQ4K5b7IHer6uW76SYCCr18akUuXK5cJmYd4xesmNGUc
	S2zJ1MLDpUFqth2241Aft5/6QOiHhicvbfqPQFcGhWXJCacJ00V+6IwTHUsjBWmWFTTdAwDs69f
	zDDhrn9kZ9PgfCjjAoa2kydxrq0QInOQ==
X-Google-Smtp-Source: AGHT+IFPKhZm0/EPYURfMy8o2OglVh9zff4nbrdv9CblcFNVpZjWo90EpnyStQulFiUbZl+EMuN5argcpQNCmKAOnj4=
X-Received: by 2002:a05:6512:3d90:b0:545:34e:16c0 with SMTP id
 2adb3069b0e04-54518de9606mr49823e87.5.1739319790362; Tue, 11 Feb 2025
 16:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206222714.1079059-1-vannapurve@google.com>
 <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury> <c07fa2b7-d453-4a9d-b1fc-e3e96514a8d3@intel.com>
In-Reply-To: <c07fa2b7-d453-4a9d-b1fc-e3e96514a8d3@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 11 Feb 2025 16:22:59 -0800
X-Gm-Features: AWEUYZlkk-jh9FqHHuYl2log-YQTJzWr98PHa1jkE8VtQRSzVdPYb1_-7Dq2dlc
Message-ID: <CAGtprH_4Z15UdPDDCYg=pnroS41fX7c7VzK_ziPMsk=UgQYfgw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:46=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/11/25 00:32, Kirill A. Shutemov wrote:
> >> If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
> >> executed from TDX VMs via paths like:
> >>         acpi_safe_halt() =3D>
> >>         raw_safe_halt()  =3D>
> >>         arch_safe_halt() =3D>
> >>      native_safe_halt()
> >> There is a long term plan to fix these paths by carving out
> >> irq.safe_halt() outside paravirt framework.
> > I don't think it is acceptable to keep !PARAVIRT_XXL (read no-Xen) conf=
ig
> > broken.
>
> Oh, I thought it took PARAVIRT_XXL=3Dy to even trigger this issue. Was I
> just confused?

Original issue with unsafe "sti;hlt" execution for TDX VMs doesn't
need PARAVIRT_XXL to be enabled in theory. Any caller just needs to
reach native*halt() to trigger the issue.

