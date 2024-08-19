Return-Path: <linux-kernel+bounces-292700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CB95732D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B18DB25468
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085A18952F;
	Mon, 19 Aug 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="ZcHUIe8z"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48515ADA4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092036; cv=none; b=iDHokPSVa6+fO864S9kRPUk5wodOQ8HsH/qixiZa7M4e760Fi+PA3nKEYpb0yjiy+DlnKpC++yBXXJpGlwbAC3jWK+/laKQK5QFuDXCuAFrux1wfqV3JSA6KbIC92ktaL5mpLRO54Kz4Q1sDXhLdsvDba7mA6kOMsGamTFtsJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092036; c=relaxed/simple;
	bh=/tUMaP2vWhujMAMBYU8n0tCigYkSaq/Ngcst40mzvvw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SJ/czWoVqTTUYQ6SlM40WXVJtcQCaTtNeMaMAW5+xNXO8GwyJ+luwTbq3ae9Y7ovIMllVvJO57+V7pApkDX+XiLk99Km/H1UVHn3GKpQJaubUbe3Csv9EKRbro1h5S3tRDCVAcbbZVLP1biYb5pJFCjZjGjyLtB1B8d3pbbb/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=ZcHUIe8z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371b098e699so1819940f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1724092033; x=1724696833; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKLGgkdxGjwvH7vrkOjUsYvXYfsjWp5LV2FLkOtp4XA=;
        b=ZcHUIe8zH1tvIXmkx4+/o8zstx4YWKqqu7Tr67ias9nYHjADOVmh1oxTT5aB97MDSj
         WDfAFVO7sNiKUiQyuQjLuZclH8dMGG8fMqiizdd9btvXo3G5Nft5hNipwqJ/dpO+0obS
         XOB2T8/n/g8hOZiT2+LiECe/2MMPVb0gdRW8EcPogENc4OqebqWefpApR8TgLh7c+ZOc
         mST5/YuJKbO1lt/oUEDi1hZfiqokyCAyIMbxNpNkS+5v2SregTR+4pv6nu9bZeuVctvr
         oRA6/f+LiuJkiwneDJwcDHU896WCB0ebEAHuE5ejgRfRy7BUwq353f6++dnFy7GbpuGp
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092033; x=1724696833;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKLGgkdxGjwvH7vrkOjUsYvXYfsjWp5LV2FLkOtp4XA=;
        b=lkofmCbKcEYiK0R+Pts62Ro41Rak2FJJh4EvEnsJlEfUqJdNomIB8KY5Nd3FQx3psP
         tQKZTniMwEGifwaD+x0z6T8e6ZEB6wYmd6hD/06lklOQq67GCn4pwuS6r4RtiXlKtben
         NTUnhS47Ad2IcFaYWXhH6NeguJydlTNulP1Ikmxdh/zz+6rOOZPAG1GwDh64xpiM3jYj
         FV3BuyNANLA7/nYMYUj6mvEWWrjWflOA4NF6HQE+Jh15l0M6Eb7dDYUzGYo8m0xKbxY7
         j6lVz2ugCFuDnm7HQW1gLy3Vx9R6sM48BA9tTVt8ysAdE6zK+d7hvSUD/6JZ5n1MsS98
         L8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWg2/qEvBHGhbcw7E7YujHoDzExahp8nb7nBmicE5bQkyWQt5B5o7PAmEXgInAehEpP/xMM2kRWMs35qki7koYkOStYAIe+1pToOqz9
X-Gm-Message-State: AOJu0YxDxZfuZYxfwMUcqPrSqRxHy/CYlFwDwqDud67LV441cEGexEdr
	jRD2gGf8fCsPDIbym7gQgJcZhDf+2ypIikUY8vb5nrgR6JhHzlHWnzSmX7VyW48=
X-Google-Smtp-Source: AGHT+IEZO0hM/Eo4qjWitYGYD8gtI1mX/YSCbBZ3xcT3qyrw3QTuw78EQsEo1zsD6MJr9+sfqGczMg==
X-Received: by 2002:adf:a317:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-3719431575fmr8913958f8f.2.1724092032510;
        Mon, 19 Aug 2024 11:27:12 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm11152375f8f.91.2024.08.19.11.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:27:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [External] Some feedbacks on RISC-V IOMMU driver
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
Date: Mon, 19 Aug 2024 19:27:01 +0100
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com,
 Will Deacon <will@kernel.org>,
 joro@8bytes.org,
 LKML <linux-kernel@vger.kernel.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 wangqian.rd@bytedance.com,
 linux-riscv <linux-riscv@lists.infradead.org>,
 robin.murphy@arm.com,
 Hangjing Li <lihangjing@bytedance.com>,
 baolu.lu@linux.intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A75E5C30-F062-43A3-A9AF-BB205632C7EC@jrtc27.com>
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
 <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
 <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 19 Aug 2024, at 08:49, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Hi Jessica,
>=20
> On Mon, Aug 19, 2024 at 1:17=E2=80=AFPM Jessica Clarke =
<jrtc27@jrtc27.com> wrote:
>>=20
>> On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
>>>=20
>>> Hi Tomasz,
>>>=20
>>> Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
>>> lot for what we are doing. Below is our feedback on the existing
>>> implementation[1].
>>>=20
>>> 1) Some IOMMU HW may only support 32-bit granularity access on its
>>> control registers (even when the register is 8 byte length). Maybe =
it
>>> is better to provide a 32-bit access method for 8 byte length
>>> registers like what opensbi does on ACLINT MTIME register.
>>=20
>> That OpenSBI has to access MTIME piecewise is a workaround for a =
vendor
>> not implementing what the spec clearly intended, even if it wasn=E2=80=99=
t
>> explicitly stated (but is now, in response to that). Repeating that
>> situation would be a pitiful mistake.
>>=20
>> The current IOMMU spec draft very clearly states:
>>=20
>>  "Registers that are 64-bit wide may be accessed using either a =
32-bit
>>   or a 64-bit access.=E2=80=9D
>>=20
>=20
> The spec's description about this is pretty confusing.
> "The 8 byte IOMMU registers are defined in such a way that software
> can perform two individual 4 byte accesses, or hardware can perform
> two independent 4 byte transactions resulting from an 8 byte access."
> It seems that there is no requirement to implement 8-byte access.
> It's OK then if we think this is not a problem.

I agree that part is poorly worded. The part I quoted (from Software
guidelines) is clear on the matter though. My interpretation of the
part you quoted is that the spec has been written such that software
can choose to break 8-byte accesses into two 4-byte ones and things
will work, but if it doesn=E2=80=99t (which is a valid driver =
implementation),
hardware can also do so should it not want to support an 8-byte
interface (e.g. you have a 4-byte I/O bus).

Jess

>> Jess
>>=20
>>> 2) In the IOMMU fault queue handling procedure, I wonder whether it =
is
>>> better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
>>> bit. Otherwise the ipsr.fip can not be cleared and a redundant
>>> interrupt will be signaled.
>=20
> By the way, it seems the irq handler must clear ipsr.fip first to
> avoid missing out some faults no matter whether a redundant irq will
> be generated.
>=20
> If ipsr.fiq pending via fqof/fqmf is implemented as edge triggering,
> then ipsr.fiq can be cleared at first. In this case we can not clear
> ipsr.fip again after clearing fqof/fqmf bit, as it indicates a new
> fault to be handled.
>=20
> If ipsr.fiq pending via fqof/fqmf is implemented as level triggering,
> then ipsr.fiq can not be cleared at first and a redundant irq will be
> generated after this handler's return. But it is OK as no fault will
> be missed. Otherwise it is hard to detect whether the ipsr.fiq is an
> old one or a new one.
>=20
> Please correct me if I have any misunderstanding. Looking forward to
> the subsequent code.
>=20
> Best regards!
>=20
>>>=20
>>> Best regards!
>>> Xu Lu
>>>=20
>>> [1] =
https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv



