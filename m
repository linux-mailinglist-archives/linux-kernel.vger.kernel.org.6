Return-Path: <linux-kernel+bounces-250273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104ED92F5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB21283669
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6966113E02C;
	Fri, 12 Jul 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCZEM+v0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67513DDBA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767965; cv=none; b=d+WKGzycYF34qaie6IRNfjGW6uzxvK5z/AVV3VR+hWkI3DUcCao4bUVjBlYZPm9F8jRd4RyPJKeRl6tSBI6S2uRzX2nEMRD/LshQJQtNBAcuP297A1no41t/ul6vKO7z6ot/3uZfC0vGZncUR24WzkrwBYYUz6kxaETgvU5i8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767965; c=relaxed/simple;
	bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq+gfWLFMUOfNLZiERDxKkenbS2YXo1gv9NWIhleV9746bRtbJDWzVyjOzcnRnIFl2AnVtt/m9es585i/Ac5S3oNN1eRt9bgu5I1vPO3Irv/0VUwz2XopSEbWt5/73kyNdpShc/ZTSxF02uTHbadSqED9zRnzalOeDe6qgH5+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCZEM+v0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70aec66c936so1465685b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720767964; x=1721372764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
        b=kCZEM+v0A1vtSsVSgBZXQtN59yQ14ppx8so7lkuEnd/DBWe/Doou5X7FDYid+F+0G9
         LSi91HRe+BNTO/S17t7WuTS+Ylj2UMF99BDPAeiFfBw2OjCdLUUUIJteqJjhGj8oi43D
         skRs7EI3w/K983Os7eqncmq50JQ/EdA3n5ueWOmGEHjUKXTGXkXyzRb9DDCUnmP8hKX9
         KN/0gaSFuzVF6IXZBMFv9PNHc/Vp6G0CZaZKIiOo4yQWJpFCYjCiOcmfB4up7Z8KmEqi
         VMBD33S35n7fAmr/Okvgg0ut81TO6Q26pH/JOJ27QDQkqtRKhCzbwPQevbozV91ypul+
         qi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767964; x=1721372764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn060LLjQ/iIKiEBOyhqceipwLz6Rtb/XZdaXblpksE=;
        b=feg7mMU8EmDocU81/P//UO2p5PklokCM9A6vbsEtEHTWF+BUHARfKW72T/ijpsDMbJ
         dIvnJAF8cpD9bJ78mJ8Py3Rh09TJYu7mNkoVxPpNEVmt99kx9J03DIqZrUdT24taoqDl
         zC6A6otBcTkWnRdpfCYtcuQc+sD0w2WivpooKearskoWBncgoAewPIRP6ajrn1q7Ic3r
         FFSAwLXmaoXVnJwY9eq9hOjvviHZcnMCfzLLKyIxDTyxiKde2M0KdxL3cymbaBomxN9L
         UU8n4OU+CfpwDPoX7Wx+MhEgJxDClPv0HwvHeUsg0cmXFj9YN/1nrrEdy97atfSD8ktt
         eVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjGpIrL/30UAtb1fs9R9ooj4gLjj+SIDiUPV+VonbXKiYjlj17gPIcvmvo6On7O5tztBWc6C42PcHAYNvsdnFtcPfUfxSf7ZmMQ7U4
X-Gm-Message-State: AOJu0YxXOIpXSlLkb4oYO35cIcMtf8IOfvgSSp8t1LV4uXnMdoqqIne/
	iFo/eMTBOZGUFj/AMfFfhWgkF/bmcFvLxRl5YlXhKgwswPitgkOZ/u22FIl7rSnjRdzc8dAc8Qn
	ZMT4ITVDamud1QSYKnR+CsBGnY+vDwAZuHOLE
X-Google-Smtp-Source: AGHT+IHF+IQNF+84R2HuQm4DaRBIt08wyUhggtbfIGujMYkHCproHjLzYh38/DIH/rrwybPiylXk6nxfOaVGpxQqxvA=
X-Received: by 2002:a05:6a21:3393:b0:1c2:8d22:c6a6 with SMTP id
 adf61e73a8af0-1c2982158c3mr12336608637.8.1720767963426; Fri, 12 Jul 2024
 00:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709234913.2749386-1-pandoh@google.com> <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
In-Reply-To: <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 12 Jul 2024 00:05:52 -0700
Message-ID: <CAMC_AXXy+2Fc8RcGGFh0abL0BRLHwnR-9BmypFNCJpVuPoHmJg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:45=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
> Do you mind telling me on which platform did you test this fix? My
> understanding is that modern VT-d hardware supports hardware pass
> through mode, hence this piece of code won't be executed anymore.

We tested it in a VM using an emulated vIOMMU setup. Hope that helps.

Thanks,
Jon

