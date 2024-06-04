Return-Path: <linux-kernel+bounces-200382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF508FAF2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F135AB212CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963631448FF;
	Tue,  4 Jun 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGO90VT5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EE13B58A;
	Tue,  4 Jun 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494387; cv=none; b=t3o0N120IPSAhZN3JN/Gb6nhIaAJlJ7vD2RXxoIpVaWbV3bxe5wj03ySt8nr+qFrlDzfH90Efm24vBfPAjQ/oNtNBPA+sQ4oQcLGPHI4dxuXLAsJRmRd1ZPIKYujunluW3ETo8Nbr94xB8CsKno2/IKMmOZnCW4nijYSFDMr1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494387; c=relaxed/simple;
	bh=VelLrgCyVufY769kxGVathE8QdW2VKCazGNXXN/11xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRC5143GTso/MPgKw86Qsds9VO4t8tC7snO6DAjBmN4CuASrelK2ZsVxh9df9rd5QJurXVrivXApXC7BV0laH19HC8Sp0gNrS5CnXWPgM0oDDWLlCsHae+2mktAz613n6eFCH0QXldcp6A1MHv8qd2/k3CcAwMO6NbhSBdcFJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGO90VT5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1a272c96cso901726a91.1;
        Tue, 04 Jun 2024 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717494386; x=1718099186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Iy/95Cu2HrlzBSr5TKl0e7xBU0QDGnX2eGXYKgDdg=;
        b=BGO90VT5XzsIbp8+8+tw4ewQFvh99pGB6iprMCFt5Xb6ilkxOUVhr6BHwS/v6FkW4m
         EGftatoMMK2ST0LnPsCKgaNb8kFeMJeagw3QuafIUnjTdWhehYlx5T9DstK4wy0eaZzS
         J80JBXqslTf4qlqqgCYKzJyhM11I8NnpCVsLfhYVtd5SkRaWIUeesycSq7/zkeDmH8I1
         9pcmaNyL6Btqxn4dkMaHGHh/B3c32+W8NZEWB9WHThTLFJ5Bz7FJmXfmivFegSodbNwM
         jMjx58kckb2xsEYuaXzF4g+bh3+ASmghyMGsVYiQMx3N3osQmxd/N5F9wkUi7CXR97qV
         Y1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717494386; x=1718099186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Iy/95Cu2HrlzBSr5TKl0e7xBU0QDGnX2eGXYKgDdg=;
        b=WaDxMCR+FvWrT9+J5F/17on/H3XLMStN1n/rb0/wvJpvVWVWNUf0f8/fHGTo/skCBP
         1gSjU79jD5OfJndkHZz0wUpGnipCsOFCCsLPRJvBxuLzv5FaG6zaPvdSOnUNb2esXKtX
         nLM3pKEPZTP8FtwuyTTnvJW9YxZDqu/nTTFyMjLhEiFiy2RmFT+R8eZhsYwuc+AQjtXq
         Pc0KC/RDR/DHCh2sjoe1L+u3wfnbsr2v0t7JhRRGe3PHI+JCS4jr40qKLY01WoU0cI6Z
         UpaFwyM4io3uO/k1lZWee4sJLfqXvWB/D3xhXclOJxnYm0cmxsOo6X7GrMGF3mk9pJdb
         eB/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/Bl4+vBGeSqLuP0Bgbty6u9pz072X2YMse4tuIR0RXg+HsSIc4lJ/qEAt7riPTJXpHr66CItxjNz+19JBVUFp0LRb7vQsJqZbk6gTvhJU9TxlhVIunoBzur2PtgtTIZZxhPZfKmYaBMfs6zZqRJoOBdq+xwbCudA/TNPjoqGFjX5qmw==
X-Gm-Message-State: AOJu0YwWBmprp6HteeQQz4nJaGT+IARjsUOToX+WeWU290I/hfP31EzO
	MoNPdfT2jnUn/WfCFZQBiUlRcM3Ia3HwhTIFU/WRiEOyfSWZ8tFpzDUp68M6CT8RbnnVMC/qldM
	pzrB1NgCN0ccKvu52YjtdCWr7eUc=
X-Google-Smtp-Source: AGHT+IGQu/cJn1x0sA5BtqSnIZFVL97WUuQok1tV3pUcfO+SZxiGMkxxQbIzQbdbfMNIlTn164Rr8DvSHK2haHzzUy4=
X-Received: by 2002:a17:90a:12c9:b0:2bf:9370:5a55 with SMTP id
 98e67ed59e1d1-2c1dc5be130mr10619514a91.2.1717494385767; Tue, 04 Jun 2024
 02:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud> <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud> <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240514-congenial-smother-1e4b0fc6a5df@spud> <NTZPR01MB0956CF1AA9EA5A20A174FD8A9FEC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240515-reorder-even-8b9eebd91b45@spud>
In-Reply-To: <20240515-reorder-even-8b9eebd91b45@spud>
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
Date: Tue, 4 Jun 2024 12:45:48 +0300
Message-ID: <CAEn-LTrKn079kbs2Wx5AuTs5+_sB4zaJsTf=MKn_nZZL04E5gA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
To: Conor Dooley <conor@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 7:31=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, May 15, 2024 at 02:23:47AM +0000, Xingyu Wu wrote:
> > On 15/05/2024 02:08, Conor Dooley wrote:
>
> > > There's a push in U-Boot to move devicestrees to use "OF_UPSTREAM", w=
hich
> > > means importing devicetrees directly from Linux and using them in U-B=
oot. I
> > > don't really want to merge a patch that would present U-Boot with a p=
roblem if
> > > the VisionFive 2 moved to that model there.
>
> > Would it be better  if I  change the rates of PLL0 and CPU core in the =
driver not dts,
> > and avoid the dts of Linux and U-Boot being different?
>
> I'd definitely prefer if we don't include stuff in the kernel tree that
> would cause problems for U-Boot if imported there, yeah.
>

What is the current state of this patchset?

I noticed this patchset on the U-Boot side from Hal Feng:
[PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings with Linux

It seems to indicate that there is WIP for OF_UPSTREAM support.

Cheers,
david

