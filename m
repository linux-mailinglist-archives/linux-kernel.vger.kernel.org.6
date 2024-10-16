Return-Path: <linux-kernel+bounces-367415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6649A01FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1341C212D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5A1AF0BA;
	Wed, 16 Oct 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g74hGVDI"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E819939D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061942; cv=none; b=oqIkFLmA8NOpzn2fwwtRWE42wyAArz5PzSZ1Dm09C1nzUOtE1sgTWEZNgQDssZKveEc3vGeNKMNooaeGnSLNZFRWK7dUhj5SnGh1uifafRi4GrVrpro8BpiMvozbW3xxxM7I4pw/VfoQh4Gh9rpRRnQNXyOTcZKGQeWO9FNWDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061942; c=relaxed/simple;
	bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDamaR89F0NWuNivOk7ug5Db2yMQHOpJdZdlamxC+HGlfbP5nsn2BC8N4oxx7UB6zskm3BvgE/EJ0rbUCq/WOFZtdZzaN/eopCZOvJl9Ps5Rco/TDj2Y3Qs9pVvuasMFMb9nCmxTbt0mKdHYVlVIUgF/Av3htp1lyuefoAMdtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g74hGVDI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8353b41369fso398498139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061940; x=1729666740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
        b=g74hGVDIdKXSRMoExMy2L7duAIytErxpodWT02qBjL8oPHDpvMDmRcasyJO7G7QcJa
         p0URmffTuHoz6VQMi64tHtPi8QGiwM/Qm4hHvd8TUmsYysmlwCdhvOMDGZsoEygMqnUm
         Rsd9+uQFFRSYtntyd0O/j8t+3KXLR6Yz/KtVBavFtU2uipV7EwuJAlaQiVEej/lwJ/r4
         8Hz7qLUMOvmN6ePwR1AW0j2I44VUO2EApFzjTVX3L8pumqmYSwdTHM8lN86qCWo76aBq
         Kx6/y+x7hufaGaSx6uaaLCNKjyRBEDumuJqe3Y4Ny3wjyvveq0H4tvtcHyrccdIQ+8FB
         BKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061940; x=1729666740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgqhkQIww3EnUduiJMY68fYIYly68qVF8vVZyUZJznY=;
        b=E4029f5XXisUNk9hSu9OU8Cpy7YZbco4KuN3x0K1t3m/mnCwFxrjknGbUhRWzZnB6T
         NoSBWBoim66yHeav4uTbPIuQJftOlj/q/qT/TnqrEetLWXIPWjhYHG1CabSVDlTUJ/0O
         WGiRubacW4FmfooBAYZ66LVILFQUAlVacndst+YrTs+jyVxv36XU76UjfH2WE22hOUo6
         iVW+X6dB10QgWEKd78+A+nECgLxqgJ44a75+RvBrLh9kxqHXljZQsec6DIOXddTn1woz
         hreQMAlnryax2+aRX2zwUanRrLGB2aGMlPDxJa+3trw2mpdZ22eR5QzlF+6VKjHpHHsT
         FJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQtDSHP8WTlbo4JrUqIixs2s7k8lTbbqMkREBa99EIHMV/wJt1Y7ouXbrGgtK5VDJdBjMpLumPlKKELy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8lSmrDvFBkg+axwETGv52wxXDqaOaDrOZ9gzietqYD/gsQti
	SMGM8gPl/rnh+yDBvOSqU4EaPoQVKk10Pl0gukExs4iqg5Cwwl4Cb2C/mKLBQTGdyxLMk4Y8p/b
	+DSard53kTMIfgET+88oDAyL/iLOwkBqkH5PQEw==
X-Google-Smtp-Source: AGHT+IErhSKXVFLT/FTSTbt5YKWJYoMqeAPP9Z85ar2ZS+Bbj8qfmYFetiQos0G6hD7PlYuMWAq/MbtzSisSbfzWG1w=
X-Received: by 2002:a05:6e02:1385:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a3bcdc6befmr119191555ab.12.1729061940262; Tue, 15 Oct 2024
 23:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <Zw4s3BHQZ6x4d79-@8bytes.org>
 <20241015085945.GC19110@willie-the-truck>
In-Reply-To: <20241015085945.GC19110@willie-the-truck>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 15 Oct 2024 23:58:48 -0700
Message-ID: <CAH2o1u5UMQHvaNNUgKQk1e97c03ntuJALUTaW7gYaCuyfY471g@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Linux RISC-V IOMMU Support
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:59=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Oct 15, 2024 at 10:50:36AM +0200, Joerg Roedel wrote:
> > On Thu, Oct 10, 2024 at 12:48:03PM -0700, Tomasz Jeznach wrote:
> > > This patch series introduces support for RISC-V IOMMU architected
> > > hardware into the Linux kernel.
> >
> > Thanks Tomasz. I plan to merge this driver into the IOMMU tree if no
> > further objections are raised in this thread by Friday.

Thanks Joerg. I'll try to address any remaining issues asap.

>
> Sorry, bad timing on my part -- I just left a couple of questions/comment=
s
> after Drew poked me at LPC to look at this.
>
> Hopefully we'll get those resolved asap.
>

Will, thank you for your valuable feedback.
Hopefully v10 addressed those comments.

Best Regards,
- Tomasz

> Will

