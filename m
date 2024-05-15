Return-Path: <linux-kernel+bounces-180442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99468C6EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4F1F20C16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D115B97C;
	Wed, 15 May 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="kQTsj3Ej"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254315B55E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811930; cv=none; b=nEoIHutlDxnw2cFCjuXYzw1FFNgS+k3gEiMayu/GVUNGN7v/0QMzuCDR6/67yrbzBgQgeGVzLnTSyb3S5vKIC7g1NC/c3SHrDjlZWG/CtIb1KCaUK7xM73eFH+QKxf9BV4fu4hfe+wECs/G927XBAa86fpF+I6sCc2VqrkADMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811930; c=relaxed/simple;
	bh=BI857sayZDwQNSg5pPJ106rwXLFaEfhCLfpMtQ/x5oA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZX8v/tNSBASlTPIorL0stwa74lCSOUvQ9LF/cvEJV9tUJxIVMWVWPWg16Mo++An00L8azcFLjqOEvco+/r9DkButYSV8CSkXVsD/7FoJt1sd3NQcKtfhPRIOtEtQt+bMSkAtRlM7B6Inyifbpa067IMSXrHqoabvbqa//Jfe45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=kQTsj3Ej; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42011507a57so34227655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1715811927; x=1716416727; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI857sayZDwQNSg5pPJ106rwXLFaEfhCLfpMtQ/x5oA=;
        b=kQTsj3EjTCl3kq435XZFvBqK524GVyd+rmqRw7H6+Zwga0Mf41bgh74EJv8ZbeFRyB
         donfkAeMOuB/gSTDOOoX1Bdc38n7apmKQqgoBIdn55pwPwVQhfZE2QxT/jIYpl2eMkHm
         zryG2nNWoX9IwjFaFmdEJLsg+AsndqKALdNEFxPYMxDVfwIpTglBJuvKStfeCRLuYWJs
         ov5Jz+FQdpwMg62DyutUDgPaawOfxQlOKzM7nI4yW6PFA4nEYo35XoMwjnENDRZ4hpTM
         py7yZo2rcNQFuR9kpLRiAiy5hxeCJyUub6X4VkZq/lGeSUarcJopRjmJEA3+RDQhozGJ
         LbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811927; x=1716416727;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI857sayZDwQNSg5pPJ106rwXLFaEfhCLfpMtQ/x5oA=;
        b=JH3TnQNwPtrThPQmpOmoPtnvJi9GR3FVtYRhGiVO8wE2xGbvg8x5RqCitOd5IotI7u
         cJTDBENaygpny5mUde4+HdtoE7vBroQzyLLJA6lXAFBP8SsGp4EV0P+tnCz/Js3bRoNN
         n70uwUt61t7eKWj1SBcPzQmIr5hYO+9gC328ZHFUIBP9RqpP0V9i77X6l4wZNJv8UUHy
         J5BC2K4eDQCdevZN3zFgjTDsnp+wFOGkiXo7I+ZcXnHGv3Mh5m9Gb/VsVZxIIi8nIknc
         a6gzzZU5jlsy8U95YBLXb5I9udKLt4DurumSOcyL4uvfIodHp8sezXzUJJeIp5JMccJc
         upUw==
X-Forwarded-Encrypted: i=1; AJvYcCUzRxRotU4azdEnH6lQaCua3d4GceUNvY24yAZiWESZ9WOeSZ44bSiDqHthPyI9RUMaQXagStWT7hL1s/qPmfWVyVV+fWf5jAjq6Td4
X-Gm-Message-State: AOJu0YxRLoQY+96DI3vCHMU3TrXo9exMpWCGeXFt1qdnkJgGsiQmgC6k
	iFG+xs/mT+85Svd/z5hxWJr9QJYRnbGvHs6+YhhDhNDLe46Fe+85QCEc4mNVFO0=
X-Google-Smtp-Source: AGHT+IENgjSLQxs5gKBtSC3SHE6IkKb3zYvJJgsyZKLJ07yLL95UOkkK/ds1ZAYyov1qy7vJDUKK1A==
X-Received: by 2002:a05:600c:1d1c:b0:420:98d:e101 with SMTP id 5b1f17b1804b1-420098de3c7mr107812905e9.15.1715811927173;
        Wed, 15 May 2024 15:25:27 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42009eda143sm184412385e9.14.2024.05.15.15.25.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2024 15:25:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 0/2] riscv: Allow vlenb to be probed from DT
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240515-add_vlenb_to_dt-v1-0-4ebd7cba0aa1@rivosinc.com>
Date: Wed, 15 May 2024 23:25:16 +0100
Cc: Conor Dooley <conor@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9EDD470-B8EC-4644-82A0-7444729EF885@jrtc27.com>
References: <20240515-add_vlenb_to_dt-v1-0-4ebd7cba0aa1@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 15 May 2024, at 22:50, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> The kernel currently requires all harts to have the same value in the
> vlenb csr that is present when a hart supports vector. In order to =
read
> this csr, the kernel needs to boot the hart. Adding vlenb to the DT =
will
> allow the kernel to detect the inconsistency early and not waste time
> trying to boot harts that it doesn't support.

That doesn=E2=80=99t seem sufficient justification to me. If it can be =
read
from the hardware, why should we have to put it in the FDT? The whole
point of the FDT is to communicate the hardware configuration that
isn=E2=80=99t otherwise discoverable.

As for T-HEAD stuff, if they need it they can have a custom property.
Though naively I=E2=80=99d assume there=E2=80=99s a way to avoid it =
still...

Jess


