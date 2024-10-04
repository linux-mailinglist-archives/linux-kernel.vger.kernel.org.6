Return-Path: <linux-kernel+bounces-350213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEF990197
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D92820E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED91156F55;
	Fri,  4 Oct 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DrSOV8v9"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACA146D65
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039009; cv=none; b=B0poCxGBdO1nd3DTh5H/u6bRX2kj0M96UNoIyvC2zrKuW9xERtY1+jkb+8IT2uK639vidBl8sxBPNHF+E/wIS1MInZNoonnrWj0aUm6Lh9R/MVDeIJU+bGWQCH+HnrvQjLstuMvOUbBJzUKjlJg7zHQAlzMVg78Cf7ffnuUFgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039009; c=relaxed/simple;
	bh=xEusqPbHWqC2kSvOa0CNTBI7KMX/dFPG15n+u2klxls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXFLKpErKFsxe0D6JPahi3dfZd9SJuOVMD5hChkvDcGqAcQygBdlZ6hhWILMSCtlKO+iYfsBWd7arygOXhkCfjA7Q4TwANoXCTDdg1ThEllhzEyH5iWfNw9lB0SIYjdRGtUaR+h+J6iyyETxX8F6ZdmEY7J+k5JrMiadxydknzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DrSOV8v9; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e03981dad2so1775159b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728039006; x=1728643806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywSS2L490J8CU6HcXGs1TjYnaQVhnORicV0t1QQIhzc=;
        b=DrSOV8v97XvumGn5kHUJgA8MaOlUWIbaw+Ktv/H+U/ss/oiZi7xQSZJzZL/pKUY3Gb
         T4pXWd01O0MIBFcYWPrNsy24NgnVfTDIE9QJBNEM5vuNoOTrqQcn8zJ81BHvPm4rTlyk
         zY4oH/3z/7vBBhxH62keek9azUrTNHs3p04S70N77PxZE2tu4X2nsmz8nDTcoO1ZLr1h
         J3loSpqm9f0YGg2t0scvVonMBIjYeWYQmolFlq2LoIg1pelpHzGNEf2Qx97QYdZlZGMF
         N2OId7Kw51nEPhDimsshT7+8ZMV3krHQSRy1Rxl013ILvaizcWXFoK6cu5Nz58se6Atq
         Yp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039006; x=1728643806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywSS2L490J8CU6HcXGs1TjYnaQVhnORicV0t1QQIhzc=;
        b=DnnQ0FCKe1QgujK8BE9coGPIUhzScUOn2XA3Iq2EMTqC57oyLm3K3gslRoxJiZfTkK
         nJT967G9c+7SSFJRhC6dTXKkYGzxAAswJfgCpXVis2J8UZW4ziOPRVwDjIa9Ia80BUFv
         fpiIdDpAJKvWDS7Z+Upo93MnxK3pVtnZh5TE0WwruGd28vgPPWzJ0OnJYR5MzrDNof7s
         NRWlld+lJY5Gds7XZYvUEjWakcCq8Zt/u482s3MoKlvYFEWhgMi01HzC9kLxa21UPyQS
         AK04F/73VbZvf/15AsjOMlWjCbeL7VXyJD7kOpdfYpoggS4wdkhiXD3eSzx8buMOSIf9
         R/9w==
X-Gm-Message-State: AOJu0YxPtAHh6v7hTKttL1iTNM3ClWp2C47WMaPPZb1NP34+y8etpb2z
	tuguPjO7+QEG040TGv3YHnAejOceCDjxOwD+fxMK3CeNIZzfAXTp4s30+3uaIty6awrAbZpQAFJ
	NNAgS379QrhBFgTZSip/om02vedlnKDU7CJnfkfBH7P2qXwkK6vo=
X-Google-Smtp-Source: AGHT+IFdS1NgCgffh0R0p2aEd2ZRC4hGoiJ1ekyWkNR4iWURqjLghfq2K21CKe2rjB4nMhlYIqLz4cS31CYnPsoOl4o=
X-Received: by 2002:aca:1118:0:b0:3e3:b291:833e with SMTP id
 5614622812f47-3e3ba1adb0dmr2801841b6e.9.1728039006554; Fri, 04 Oct 2024
 03:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808081439.24661-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240808081439.24661-1-yongxuan.wang@sifive.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 4 Oct 2024 18:49:55 +0800
Message-ID: <CAMWQL2gBOma5c_A4JPnTK6uDfbyqcbcf_4qZ4Pt_S3mvBY3s0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Thu, Aug 8, 2024 at 4:14=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in_clrip register or to clripnum.
>
> Update the aplic_write_pending() to match the spec.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/kvm/aia_aplic.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
> index da6ff1bade0d..97c6dbcabf47 100644
> --- a/arch/riscv/kvm/aia_aplic.c
> +++ b/arch/riscv/kvm/aia_aplic.c
> @@ -142,8 +142,6 @@ static void aplic_write_pending(struct aplic *aplic, =
u32 irq, bool pending)
>
>         if (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH ||
>             sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW) {
> -               if (!pending)
> -                       goto skip_write_pending;
>                 if ((irqd->state & APLIC_IRQ_STATE_INPUT) &&
>                     sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)
>                         goto skip_write_pending;
> --
> 2.17.1
>

