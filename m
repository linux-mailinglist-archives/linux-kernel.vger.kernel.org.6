Return-Path: <linux-kernel+bounces-568069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC5A68DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D985E188A9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C42561B1;
	Wed, 19 Mar 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aao1II5T"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA192561D7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390708; cv=none; b=pjoPgaeB/Y8LDI5p2NUJV0RtJZKnvSApkuoK8R6PSLnZp9A+dUOMWtWjzKBqC6K/dGrDefYr1L5aug/7bCiu+h9MiqIcgQqcwwSHFRfLFDFe8SM4XEiPABSFMQTeqz+qHYLExBiwHWfGLp8AoMoIV19lFv96VovySFvJXj3u/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390708; c=relaxed/simple;
	bh=PcRSCP5NGmcuqzH6IBt2yC6NKq7l4D2BaqxCdGW/XRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FX5UjdHTg2nPwc3lvIPttZQKyw7SP0N/qFkcmJkqxqLU9UweUZEXteFc08kHg7wDHuwWGY5KUqVwgjBnOdc4flHZ1cwDC4bcsrnMPg3dfzhx04AYx1TPLNUWBVX8w3xReyZvBoVFcWPGBPI3dPp5LUJ6BIEbSQi6O5DX1yNz8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aao1II5T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2264c423e37so19481415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742390706; x=1742995506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgXHMNPeJMWY8rY2atSwsICleqZAiEqzOD7JeyDy3bg=;
        b=Aao1II5TEal9kJ04qG1TaeFDQ5L8PLfDC4J8L0IEnlL/9KTgo+d8wwo6/8lSxmoe0Z
         avhke/5IdRoA5Fz/4XqFnaCJibaOZBemBDvJy5sDGmpZEhLQ26MHfLZBl5+cyVKKpAUc
         mhPuFoXZ1vsXlO46Cjv5nKsHfKBz4fJMCQI8wy14e35ULKOW86rgpBhYk0/15vcXah8l
         h3ca+TYGfF6UdAeNfBma9MnUToEECNMz//DH9ZbW28XgEn/LoacgKrSZzbbibrzeTnzm
         6hc5X6s8Gn99iKCsE224l5+x0FXHjZ9kQtl1jkd+I8hQRUV5YFLW75OVrYZtqjbm3EBF
         Ms3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390706; x=1742995506;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FgXHMNPeJMWY8rY2atSwsICleqZAiEqzOD7JeyDy3bg=;
        b=eXNodt9ANmrgrhICBhAeV6PaZxnVli0ALlAYGMG43dvH9dxPxs44sdBisA81cWr9OI
         XtZEtFqXQRJRmiuAyawsmqa2n7GHTcxQuRUQbz4aivNq4Mq0kttXuCvYYsu5V8k/A4gF
         EPWoSFg4+NoS3pg+gjUljUCQzSmME5KzTPUq7PaCeCI/h47yTNKfOA7T92yY7KyeKoEM
         S55SMu6EZ+tUlP6jj9/a1IKr9zSklJsjXtRmkooQopIuPiEwX3P72s7+S2TvjEgP3CWC
         CgZLIAMATXEWxUR4Qf9lEWJW2ztrLVL5S/5Hk/fsHltP6YwfW1Us/I32WvmP+DhS1PRW
         GnpA==
X-Forwarded-Encrypted: i=1; AJvYcCUw8KYhQqFiszDxnQrZbn/w1Iks4I+bMe1lVhI59Vrxyh+bMBGDBSZJm8QKfyLgPqt5ZJ21OYVX0ln1sP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzS+aTmMwLGi4bsmNrMPqW6v3hNXYf8LtpDJ9sin0PCKEieCEI
	itOEsVXKJ/oZiPKROydFCeHyGUMMuVvOjNh9qGnv/GNY5OcwAgF2zu1nzEmpJmrM8/7bpYrNgVl
	gtQ==
X-Google-Smtp-Source: AGHT+IFCXgfCbfXat3h95vML35RpjO3geEM8Vn2+zEqDnpHcNewRUBan2lmC/MgrE2pETJ9smUeIaUbHaG0=
X-Received: from plcn1.prod.google.com ([2002:a17:902:d2c1:b0:223:52c5:17f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d509:b0:21f:1202:f2f5
 with SMTP id d9443c01a7336-2264981d9b1mr35108395ad.8.1742390706595; Wed, 19
 Mar 2025 06:25:06 -0700 (PDT)
Date: Wed, 19 Mar 2025 06:25:05 -0700
In-Reply-To: <CAGtprH-HmtdyNZnRn3UjA-pBYaBBJgUS7UQSd07PDW94kdwufA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319002334.423463-1-seanjc@google.com> <CAGtprH-HmtdyNZnRn3UjA-pBYaBBJgUS7UQSd07PDW94kdwufA@mail.gmail.com>
Message-ID: <Z9rFsWl96Lc99ZWd@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2025.03.19 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025, Vishal Annapurve wrote:
> On Tue, Mar 18, 2025 at 5:24=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > PUCK is canceled this week due to lack of topics/interest, DST differen=
ces, and
> > far too many meetings on my calendar.
>=20
> We would like to discuss base TDX KVM support readiness for the 6.15
> kernel merge window in the next available session.

The plan is to hold off on merging TDX until 6.16, but to get it into kvm/n=
ext
shortly after the 6.15 merge window closes.  We want to give it a full cycl=
e in
linux-next so that we're not scrambling to squeeze in the inevitable fixups=
 and
tweaks for such a large series.

