Return-Path: <linux-kernel+bounces-216630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C090A265
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C22B1C21FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574831DFDE;
	Mon, 17 Jun 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OklhgJ/B"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5810F4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590589; cv=none; b=MRV/nIrjCVgKQoTBTgdWwGgs0MUpWarDsZBAqGZWlotflx8emJ6n+P1rceXBTlTXERHo3CsZs8XoIeQA7XFF6IPLlB4/ivQamk7b9n3S5lCdg3sZizV5OXAiT1GHKzoviR/AFoLbqEXhJGBVHoHVMBw55Zp1KEogUJkur7tfbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590589; c=relaxed/simple;
	bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxBTahNuF0lLVWusZqCqgI8e0ZRZto7WHu2pJycDnk0jWblXL4BwnssgM1w/NlP1+Uj17quccuz8igUjRuJPCwh3oWqzDVuRfqMA8bxUlICT60zRizjllFwHhjXI5YXCEsmpazO4zJ8CjzNgiCX6GZJCvN9Z7rmqdHlP2TH7zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OklhgJ/B; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eee5740aceso19756939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590587; x=1719195387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
        b=OklhgJ/BjEfwZpjOvxAXeMK3H0WhjEsgfe4sizgjLgX4gq+12rhccBjIzcpKdsiGeJ
         M/+nv6MxkmhicmRZzDCMCgwZd4GB8KHXe0RMENb0XJ23fTxnys6h2qxdUhkgv5bvcsjD
         7SBojF2orXz2jc0Ti6gZqUwGwq4T4thJJGJMAKhuJC/A7jbw+7z4GZPTftr8BWVps8g5
         o80L46gKZDEbDRFEKrnj9+csB0Amkq4r60GjufU56XdvsEmZhr54EZsQz28f0qyOXnyg
         3xMC9oui6E7BpXMvKvWczb1SfU3slhPWPbNm5J4LAqga/oHYYY5DlQyImRlDEmEsxOvw
         zKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590587; x=1719195387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
        b=pDBhQHis5DVVDlmltBnurjIRpaIIPjHt8hAuxPb2y+2/0tonpeWWhkoRa2ZznsDbkX
         Tm3RMyWkriGN0RUWs7BUIMbhUpjo+SM3fSbzag9wt+HKBZWiTPBTpIip9eCUMF50PrVY
         vnOJ0Jtgcrn8N/qAxrN1s/GuBQxUuBXiifhVjxZ3wThoWdELyX+2DXVYJsKBRvrZtOL+
         lFUbuTgkRdQryKArbnR07EYhnJmorKrJIQ0H21YKipodGYRqVtVwTYGN1Sd2la+/nxEU
         JOZ6KVnxTlc7vDsqpOzs7jysXZB6OqVshbqHoZQDPvZY8lhMv3Gn3E5vS8OmQoGzAher
         QvHg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTodJQ3/LIeJ958eJiaF9iLd5zI85U9aiLUvOIVyoSOk3k5beoyMnoftDy2EjQtm33Wr1RJAh0yHUYjjhu7/DHPVvW8ZY+nu2SUPy
X-Gm-Message-State: AOJu0YyDPIlNKxtIyd35+6NY5BSPv8weuJnJS5fjz02m0vv9pEdbkwQ/
	0PD2vLJlgn+jxWHsIz+bFZsqXrLygd4PEQWYDJRat1dTjlM0UtR+Ouh6ERUAlf9GYhO6UQuVHL0
	Rtpp/1tgVfTIPdUWj/GdkpATqQNTlr3pz9BwXbA==
X-Google-Smtp-Source: AGHT+IGjqStvPzq4eQHVMVjSkHpNaFIElfvbz63p0MeN0p8pMu3otddGU/WtwKbFVYh2nVlV+RVSIco/aX28xZYpEKg=
X-Received: by 2002:a05:6602:3f95:b0:7eb:9697:95c9 with SMTP id
 ca18e2360f4ac-7ebeaef3ee1mr937068239f.0.1718590587407; Sun, 16 Jun 2024
 19:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-9-zong.li@sifive.com>
 <fb252e35-46e1-48ba-b236-a3296922ffdb@linux.intel.com>
In-Reply-To: <fb252e35-46e1-48ba-b236-a3296922ffdb@linux.intel.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 10:16:16 +0800
Message-ID: <CANXhq0pukeeAEde2i2UDOAU3fhwxf4zx6dzbugU=XGrT7kj+3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:24=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 6/14/24 10:21 PM, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
>
> $ grep "This patch" Documentation/process/submitting-patches.rst
>
> Same to other commit messages.
>

Thank you for your tips. I will modify them in the next version.

> Best regards,
> baolu

