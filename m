Return-Path: <linux-kernel+bounces-291475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CB956316
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F21C215E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBA914A4E9;
	Mon, 19 Aug 2024 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="Lh597F69"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990834594D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044667; cv=none; b=QRl7OdgXGAI8WZSF+Y8TkpND9Y5ZSHzCWykk977rzpWrbswx5ajofiEd/d+VPZvJeYuWwfX9osAGgdo7K1zzsz3ZdBJ5Ab3YDb69eL0ABaInNX6Egjfv9Y1JUVRWb9GKTeaNY+eoFnw8OXzMYiC75eGXxPUkPEpBsw5lIrJVRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044667; c=relaxed/simple;
	bh=C1nYJFSadkBqsA2XjIbFq/oop7+NYZUTKMV4DY0FdEA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NNt/vC5Cn7Tl8iDQIfhX4T1jXFLOBpEE2mMst2uug62ywK2koqo9fpxYcBnk4EDogyyNDpkZSJr3ZT6mdPu1L4yAx1rzsGBsYXlEXUA+ZsMlxpLwOYfNlxYOjgFVEtfwCyAIOuSZ9cp7S4gLf3RU99bO5JnYXBZayxVwjBh42Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=Lh597F69; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3719753d365so1781730f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1724044664; x=1724649464; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyh8E2w6qS2dDnFyvllL4xJUAKlas+oNhNFEyWDUr/o=;
        b=Lh597F69PZek5HsdOznQPwSshxBVBSVj6AOZGucjLSRGa3HHoDRoDhbvLCbAK9A1Ip
         qvFQ6l9/jZAWHzG2qafPTRBsExL9T0su0sJAFWMrn2WE29Wczg7pBzbb1ccy2+s2OR3h
         PAzstZQQDA0TUms7bqOtMBk96LGQvLeGlbiDD7GddbDDLzxkTTs6b9z6aRJbdcJaJYNy
         yOC85idKNPa4bOVTza0fO+4Gu/umzr7XBVU5+2wjwLGjAgQELLL8G4jwhrsrT9TbTEBJ
         MnqzbVqF3tNV3JSi55ctahfyLBNHmYqJ3VUtUpJeZHFVQcfRQQHCttucbsgVaJvjBeQk
         0vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044664; x=1724649464;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyh8E2w6qS2dDnFyvllL4xJUAKlas+oNhNFEyWDUr/o=;
        b=pZ+doTuUEar5nu3CPlqaOkeuH7zklYU924Z34TDLCT9Lq0B1ldWjtuVZqoa8siZ4fR
         NHfg4OsIjMFwbua4zeDceeCXU37WwmlxGqhUt6BZTVw7dGCchEXZvP3/jFa7S9qPLEft
         3CX0kQ6P6FwWTQX5aUfrxoM455wwcM2mswyL/UWbTqDn1BE1d/xjfu/7hzrUZDrGPfh1
         SIsNRJRRUIJRpMJcwl72WNewjLIDrXyap/Bz5pESw+D1Z48oYkw/Aq1RhXNPRzpoOZ67
         pb9DpoByx7pS7xdlFRPfiqkCnsWVHX6MNYv+fR8d+IAwTQZM/Y9DW6u7mpfR4yprpHjV
         VXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYX4Cbi33ZnfVvFeHS7vIBI/N8MswnrAFQw7MTDMRdty5sPbS/2nJI596JxOKFZzGRJOGrJ1w7gWxz1XAFnhQ1zDg5RcL2ADSEnC/a
X-Gm-Message-State: AOJu0YwuSLQvhQgR3hKZGmZgbQK8njCS44tnqqieQWovh0WeOXGrmAMU
	TAC0yIR28SVkI3Lb3LdEusjvxn8/00e37zzKONEeavf38/slk6UWe+Eui1vV+S4=
X-Google-Smtp-Source: AGHT+IEgas2OLJrF7XB2mIgjoehICb7EFSEjFXMukvtNnOS2pTLyI7kJ/AO49Glxml7R7Hs3m0cKzg==
X-Received: by 2002:adf:e6c9:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-37194317364mr5779116f8f.1.1724044663633;
        Sun, 18 Aug 2024 22:17:43 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm9428388f8f.17.2024.08.18.22.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:17:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Some feedbacks on RISC-V IOMMU driver
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
Date: Mon, 19 Aug 2024 06:17:32 +0100
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
Message-Id: <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Hi Tomasz,
>=20
> Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
> lot for what we are doing. Below is our feedback on the existing
> implementation[1].
>=20
> 1) Some IOMMU HW may only support 32-bit granularity access on its
> control registers (even when the register is 8 byte length). Maybe it
> is better to provide a 32-bit access method for 8 byte length
> registers like what opensbi does on ACLINT MTIME register.

That OpenSBI has to access MTIME piecewise is a workaround for a vendor
not implementing what the spec clearly intended, even if it wasn=E2=80=99t=

explicitly stated (but is now, in response to that). Repeating that
situation would be a pitiful mistake.

The current IOMMU spec draft very clearly states:

  "Registers that are 64-bit wide may be accessed using either a 32-bit
   or a 64-bit access.=E2=80=9D

Jess

> 2) In the IOMMU fault queue handling procedure, I wonder whether it is
> better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
> bit. Otherwise the ipsr.fip can not be cleared and a redundant
> interrupt will be signaled.
>=20
> Best regards!
> Xu Lu
>=20
> [1] =
https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


