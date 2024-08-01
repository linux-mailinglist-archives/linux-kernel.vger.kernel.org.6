Return-Path: <linux-kernel+bounces-270574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0C94418F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B17D1C221D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4F13D283;
	Thu,  1 Aug 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow/kHUA2"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791E38DD4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481918; cv=none; b=EaelwADX1d0G7C1eDXcgM5xP6nCNxrPEshmAQYgxxoviIBeYV+L/lAtvRAKozU2q8IEW1nntEIrIsbgDeW3rBV2MdwyPBQVJbRUcN2zuhyVDanWWUxcbdQxgEyWfyA62GYRazvLX8zs3hnTQPuBKxrOV8c6FoXq9dsSKoZlM1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481918; c=relaxed/simple;
	bh=0NOpXemn//gNDaTpcMNDKtpUuPaUe1LmrYb7pf2TR3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpBmuNCq5U8uqeHo0xE9SOSHfaUKzaHHDOBlLoDGEmtb/gWAH/IcL6xrWqAdSSA7hvR8utLZ1Gd/uCp7/dAXpFx5R0NBS1y44ZjXd0dq6qHMhsFAbEP2xabTNhGpEe/c0Qc2yNgkOfaYRPow3XuQjTAJdTV7S6gwhNYnB0qF8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow/kHUA2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso4321805a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722481916; x=1723086716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NOpXemn//gNDaTpcMNDKtpUuPaUe1LmrYb7pf2TR3g=;
        b=Ow/kHUA2vgUmADyTdCSZFeYVF/hvJU84eENQiuH3lrLc1kFjf1sdPld3zBVUCjFNAH
         VaQXU/nx9+lEyFycShGoR6ln8Oh/5VS4wxaAnXNMQo4vkiIe+LDEVMYyFyr6+AyUJAjk
         3l8cO+V2y8NL4K/oveh3zB8Kkhlp8ecLbtsRplY6TQSzH6S4dO4k46GmQyOyWEWdM//v
         1ft5vEptf1b033REd97SsDQkEAzSs1ISFtNjvrHj/whc/5GI3w1SjousUxsp1/WMAV4J
         XQyFDxSgYU20IlTA3Z3V47stUzWYIz0elZshwQsGHnzoFOxS6Leb6AINJzYLt4g66//d
         gqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722481916; x=1723086716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NOpXemn//gNDaTpcMNDKtpUuPaUe1LmrYb7pf2TR3g=;
        b=LhDREMndEEeMbJOntkjP2IKcO0uCrjQDRaGtn4mnQ321fSMBi0keQ+jilTYFrHHUak
         aYvc1ERjx5ym96FaxKvz+IPyOuYCk8t74nDsqjn2ARG2rl0M1nQVG5pI4JQxDdz9NS4S
         vtJ+YQG9vOlprkS17xqKtaKiBCTkaIr2PakRmTI7Ev+9fu06OdnTDeOqdgDfd4csBsmh
         Vy1NQf0QbEkpfop3vyBcWSY3s7X5f3CqX9knHGWi0PkWuhMNHYLZcL0hHr/NfDWCGLIG
         5e6U770qTHtq4KxunZNl3lxwPimJ39DGc0XoIKh0WQdlz1mHtTudn/sECHvMtq/bJK+C
         eXCw==
X-Gm-Message-State: AOJu0YwElxIRWFAz6PSX4/nncxcDPFedpcuFn/vTdaxsGBSsjZbSHGeP
	Q0J0bz1hZAZS3dgpELARSDHHGafPcNMaW+Q+FKIRbIklgBE8Um1NMK02+MbuXahUBY6jT5fe6ud
	/lYp2dglNxzx9RzwJMG9sq5vdBxg=
X-Google-Smtp-Source: AGHT+IGO2D9m2f/qoCgY6rz/iJP3Vx4lGGSbed33AJj59KAj5m1GcCWWXAT3metSRFkOImkGfP/GRe+h6/H4EfWiPfQ=
X-Received: by 2002:a17:90b:693:b0:2c9:9b2e:61b4 with SMTP id
 98e67ed59e1d1-2cfe78be0b0mr1644946a91.22.1722481915912; Wed, 31 Jul 2024
 20:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725010437.694727-1-jiangshanlai@gmail.com> <87wml4s9zz.fsf@linux.ibm.com>
In-Reply-To: <87wml4s9zz.fsf@linux.ibm.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 1 Aug 2024 11:11:44 +0800
Message-ID: <CAJhGHyD7Ligkp4Ww0STbj=p=igOmORQP86XyB-CmQ0wGqK351Q@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove incorrect "WARN_ON_ONCE(!list_empty(&worker->entry));"
 from dying worker
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Marc Hartmayer <mhartmay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Mon, Jul 29, 2024 at 7:39=E2=80=AFPM Marc Hartmayer <mhartmay@linux.ibm.=
com> wrote:

>
> [=E2=80=A6snip]
>
> The crash I reported is fixed by this patch. But I can't say whether the
> removal of the warning is OK.
>

Could you have a look at it please?

Thanks
Lai

