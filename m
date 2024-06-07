Return-Path: <linux-kernel+bounces-205936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DB900264
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB41289294
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7518FDAF;
	Fri,  7 Jun 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP8Om1/L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D918733D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760362; cv=none; b=T4K4SknujfFYVcccXK6BBqYS4rLfgfE4mpUywfRtRTTqIJxuu4mXvW6dbEN3synnUy3HT7pknXNg0aPWLsvTVaS+SGaIZk+rwKTavVTtsc27pcPA+fgiERSyQEl9cvIGGTNPsrjJAJERLJtvczjmaAZ4qOuA0V+7osP9MG8X4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760362; c=relaxed/simple;
	bh=e84aLCdKh1EShx6as1qrt8Lq6oYac6YaHWvxgNpoL/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGY48D3iayvPWDaI5oGhwTzjwS10mkV/iEA7PJUI671hykm7BjwJpkhmV/yskm3TfLILkTCfeWwJqTaAA5v2m07aS/E8HmO8el7Kz1HZSdDu+kiXIqE6REbDcVcVqhsAAM4IGdju0WqE2Io5hjrp+Z2/Clj6vtFmii031eo+RlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP8Om1/L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717760359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e84aLCdKh1EShx6as1qrt8Lq6oYac6YaHWvxgNpoL/g=;
	b=bP8Om1/Lkckr9o+y2fbfHsp7vtKdr8mMrcnqqRiHK5Tn4bwvNvFDjvFLq82vGDm+BeIWCO
	nFg+6W43BeksUMAel3VIVnOwHXRqCiobQR/KG02pSEZbHcALRrLwFKZ+JgGAD+si2GuCl1
	sbVioZXu6K9lPg861BXXCPV0dDeghr4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-4k1uxTh2OXmP3VfruF_t7g-1; Fri, 07 Jun 2024 07:39:17 -0400
X-MC-Unique: 4k1uxTh2OXmP3VfruF_t7g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b84359026so1681533e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760355; x=1718365155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e84aLCdKh1EShx6as1qrt8Lq6oYac6YaHWvxgNpoL/g=;
        b=Ih2BRn+bq/7erMjT7xQjyUHu2cj3vhsbafoTTH3J8pAnEt12FImGqjIzhNgvPwUzYg
         9smrqnCOJoJmkX83zWmwDFm/DaNGZx6MyxJWff1yrXQJPuOuC9qc39yFFPKIKFNhG7cA
         rgCW5cJfkXt5l4zVgC2rUfsfKvL/QMRdDQ1eOMlHsiDpSWAwBaiZeDDdTqXj/tSDEIgx
         ysplTR4j0qC0n2YfxuUl9Lh6XPX3DRHj2Pa5Pdef4dj7XJuirgHY+Z90H1E+dFdWtAyp
         2uZ57NQBbPFgQceXWOngNR8zPkfRPek+M3wvsBzfvUSUcH00Ujiz2UMHGx3ExtOf1ym0
         HlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt0rLwHNZJuEO5lVm/UNJJmbCdCxvayEufxLo31aY/6SYxK72bKJRGt+/eaEpBLPGsqqXIRVYsRtRhxGNnaOT2z8Md/8Ozs07MAE40
X-Gm-Message-State: AOJu0YysRh04A/cZxs1pRe9nFTXU2kGpdJEZVMlYIJX1bHUBbBdb2OsU
	7K7qaEn+RtBRI43TlcWe0eZ2l27TkOsStUquOxf3/29EKXiJq6pzh0ybbJAdEod3K3g/TwTic1h
	5dKZ+8UZq2kut9m5MKJRod4prcOf/zidj4ToOhxJ+PlBgJLuqdlsYOfcH36jElk8ZYyvOZJqWJw
	L6G3mBXDEZSEQsvxBFQeitO/25j1LwVibOQ5lOGvSi4t4md3s=
X-Received: by 2002:ac2:4835:0:b0:52a:8c03:35b8 with SMTP id 2adb3069b0e04-52bb9f81ab0mr1569124e87.32.1717760355425;
        Fri, 07 Jun 2024 04:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFttzSyjZ/xewoUaB7sRNrp9fxS6XKxR473AautxW/ZZSFxk2qTKh4+hDSwszrYSLV33Ybaxo8GBzeMDgJAS34=
X-Received: by 2002:ac2:4835:0:b0:52a:8c03:35b8 with SMTP id
 2adb3069b0e04-52bb9f81ab0mr1569115e87.32.1717760355033; Fri, 07 Jun 2024
 04:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 13:39:03 +0200
Message-ID: <CABgObfZigjQHxdHHhU3n1oP=wq-G2rS=AYaSzmPdP39qCUmrGg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] TDX MMU prep series part 1
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> Hi,
>
> This is v2 of the TDX MMU prep series, split out of the giant 130 patch
> TDX base enabling series [0]. It is focusing on the changes to the x86 MM=
U
> to support TDX=E2=80=99s separation of private/shared EPT into separate r=
oots. A
> future breakout series will include the changes to actually interact with
> the TDX module to actually map private memory. The purpose of sending out
> a smaller series is to focus review, and hopefully rapidly iterate. We
> would like the series to go into kvm-coco-queue when it is ready.
>
> I think the maturity of these patches has significantly improved during
> the recent reviews. I expecting it still needs a little more work, but
> think that the basic structure is in decent shape at this point. Please
> consider it from the perspective of what is missing for inclusion in
> kvm-coco-queue.

Yes, now we're talking indeed. Mostly it's cosmetic tweaks or requests
to fix/improve a few comments, but overall it's very pleasing and
algorithmically clear code to read. Kudos to everyone involved.

I don't expect any big issues with v3.

Paolo


Paolo


