Return-Path: <linux-kernel+bounces-218516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3390C12F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6501F22C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B517547;
	Tue, 18 Jun 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QMMmeo80"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36E4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673302; cv=none; b=fmbqm7nRk72xFcEwy0wEDgKHIdH6ajhp3HP1ylkB0D6IruYCXjYLNBJ/isrA3/fH+iyxISHxtUiSrh7BpP15UXguetWNMfxl85CcPbOiBb/zhO0vwDNL5ks27/xaquddTXO5ojzo+2tzwTI3IHqdo53c8KsGloRThJCp4KFA4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673302; c=relaxed/simple;
	bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmdwX8nm6Z23vwgMB+C/JWlNLKMBTtBU7E0Q6Xdc93sDm+DnZTtEAR1xHJO6WsiAGA+HI2RO68a4O64uIinZ4RLgQdynxkwsk85cu2AXK27MLMajAaWABN8K8pfzovxn50RDIQ8KOzu7ctqTq7q063thtzKzcJaIAbYlJMa9JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QMMmeo80; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7eb01106015so220282339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718673300; x=1719278100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
        b=QMMmeo80f3UKHrX2RKMTqPYXQ+14JkxFwzHF+RSVHLIzcnMvA5Aw0GlpdmLA7K4jGP
         ApexsoOZEMN5qLOYbO/U/XJOZyKRPbkUgLtuXmuIlbi9tBtxSEHnbSb0Cv4KrZFKioyN
         5UjZ3h7qlvtCeE8UZz7nONlgJaSAV6C4VdWOVSNTjwU2WguPI8t2W0pBpNnySsW3vGrt
         91Gmo626dk3UHesLUrNymN0zXrQaSxEOo5AaAKatGyk8OFewbd0phbgvM63f7v+JbdKR
         m3n33VaDl8KQ71wrGKShrw8JYKv69fmP7cpA7OA7oKR24CdGitn8QjEoF/JJ1HIkAd8j
         O0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673300; x=1719278100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7Mw9balXkdXrpGP42GBrIywjp+7pg5Y/72fbcj8y6A=;
        b=FATq39YGAZ3Yj6UnZksbL1/YcToURxUtBEWkik3lh14AXvlC/dWCZJMw22KH0ykltR
         k8kTLTquJWKkkxYphMUgqo8X8kqFriU757h0p7wQvenucR9aHl2QWPOCooPc5+lXQjt9
         DwlIDLTog1CkkDoBLAnSbLXj6vHbXu7yjulDh2R6v77A2SBTDH4U3R5ngTO5YWYLk9U2
         upEeugT4zxzzLRh0QvUjjTquCNmpCxwLDscA4dHl0l4mTrM7xL7S7LYxvFicfin0ciTa
         QKynoMWOkH6wJTbT+MTUvXFf1hSGOpwfRlxRIf8tjPo2PgBfYv5EArUVzyoz+s/vD5ST
         gD+w==
X-Forwarded-Encrypted: i=1; AJvYcCU+2MXNPP1kvxs+CI04OtKFz0TDRU8WlDOXb0vrOmwUyRVwRbRmMV9wqMF9Ofhgi8PGEzgMCvgxP2jzQhqfF/f/FyEHMlOThouIQASK
X-Gm-Message-State: AOJu0YwqFunu8kkM0ECho9RjcCVYnqHIc/oLaSpjfxFVcVVXMxfVpnMU
	U5qnjXO8n+Yo03KJtMRXw9YztJXGjEweIT9UcZkDxB0n2dglk54yqT6R+UmNARH/MqEd+1PpnRM
	pZRH2byubx8/m3m8QKMirE0qFP2IU6jmLiWsTqQ==
X-Google-Smtp-Source: AGHT+IHVk2V/zxfCC+TEYjE1GLUfJe8wd2/UBNvu0XGLc1b3cPwbgU0WKTC0+y5CcD6xobj4+R6Bbm6kIWf56tesqFQ=
X-Received: by 2002:a05:6602:2dc8:b0:7eb:7df7:461c with SMTP id
 ca18e2360f4ac-7ebeb644d32mr1162260739f.21.1718673300529; Mon, 17 Jun 2024
 18:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-2-zong.li@sifive.com>
 <20240617145521.GE791043@ziepe.ca>
In-Reply-To: <20240617145521.GE791043@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 18 Jun 2024 09:14:49 +0800
Message-ID: <CANXhq0oq=JjwjneJ+S2YtuaaPWdHYHuKrtcm+_Agn4CfjbyfDw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] iommu/riscv: add RISC-V IOMMU PMU support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:55=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:47PM +0800, Zong Li wrote:
> > This patch implements the RISC-V IOMMU hardware performance monitor, it
> > includes the counting ans sampling mode.
> >
> > Specification doesn't define the event ID for counting the number of
> > clock cycles, there is no associated iohpmevt0. But we need an event fo=
r
> > counting cycle in perf, reserve the maximum number of event ID for it n=
ow.
>
> Why is this part of the nesting series?

As you mentioned, it should be a separate patch set, let me submit it
individually in the next version. Thanks

>
> Jason

