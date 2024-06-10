Return-Path: <linux-kernel+bounces-208674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDD9027FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FBF1C21EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9C1482F6;
	Mon, 10 Jun 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="HdZy45Vn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051C14B95F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041787; cv=none; b=gIAusL1bjTeJS1gxcY4q35t2DniSTOduUqXugARVs1EsI0YDLDaptYD5LBNwTLlYc7KNTIgSldonNKxFzzijlFx2m/DY3iBUmlPlp8odkuIchJ4pNdNok9tkfVhqzTlsS38MpMs+owD1+lCgzGvEUp2BDzKiB6WhZpolNp5Dcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041787; c=relaxed/simple;
	bh=kaN+OH8u0mjuLsUgDZzqsqHcd5qKUZnSBirUfTBy/rs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k55CG5SqmKYCrmNjuvn0ZWgI8mdN8XYw41x6CsGO1aC/OKFRSM2FBgOozvI1Jx4niXvNaqoIl4bhDyraqzeTbFTwijNvqnd7LlniEQURPzRid8ahkJYRuaJRAGiATGYFWmlyp7rIDtsbzza3OhEMqKcobNH6TfJEJHJteF0Xsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=HdZy45Vn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42121d27861so41308175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1718041783; x=1718646583; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zyb+ujtIGgfui3VzqiGKyVsxQvcv7H95kxqnj+CmxU=;
        b=HdZy45VnEKiQ+w8OWBY/zHujgtcZXRFEAEziOdL+tkGektfnFC2af1F3ya7tmHVtNB
         OcJP5t4BzifNIohd4fJWUPM8KGy7At1uQ5MRY+rd19ONb1heKniuRh8X8cZHKSQgmefp
         Xk1d2RstDNSGJdiYOx8nU/j5jD6JPRQBvvU+K1ZdqMSVegOiS3TziZdQ6kkjFATVEsvo
         Tyf93Y19Nz+XuH1LyBQwt5uF2AwnJMxIihwaPD5Lqh8VzCaSHl05eIxlxDTxU5TF3EAe
         ynAnS40CZ68yCZJPr1uhgFIFMOGsgCaIoW0Ear4295v2x+TEOM3ALQFd9j0Xv3QVNcyH
         20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041783; x=1718646583;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zyb+ujtIGgfui3VzqiGKyVsxQvcv7H95kxqnj+CmxU=;
        b=SojbmUXDh25hpeaAXNY1JFxlawawkXk6sIVGncuglFIgNig1WnJK3AsOjnBsswDpvB
         QWSwxKG1sg4cWtvM2yuRkw3MqmHUiZB1valXxUusF2qyzwLgPStVcoQjJvrBQ7OkRXg2
         HNoRqZoX2ELvYblkU8J1piEG9SJILaIB4WOdXLskgU9Tc2eEYtg1RVWNfMkSG+38aMVl
         d9makUN0pfYCyoBP/LIvnD/xcGPdMOcHbz8OFAeT7qcWtsf7JKpbrDKWPQevgYoa42Px
         rHKWmEmR1Ksq/tVkSpOPuDPshpLAcqH1WiExz22vF2x5DnsC4TDv5QeFFCWl8PN85fEb
         M8UA==
X-Forwarded-Encrypted: i=1; AJvYcCU2AkB2jIN09xlCJLp9nUcH49QTpzkVSc+YdynpZdIQHZcZGm+aaehT1vt+dXWfpxUL23clCx5hSHy0FFylrr6F+YfGQwT5UAqW/65b
X-Gm-Message-State: AOJu0YxSAU7rCdVrYozRFzXWTthraG3QF1RpzcArVaQGI614BCliolDb
	e4qETnTNO8B1AdL4GJLOQjk088InFnSWI6UtpRGMTwlhNPyciJRBODzCaaSnRIE=
X-Google-Smtp-Source: AGHT+IGOL4J84jhPB6MOYY7C/yQXa66itQV4TEzYbITX4tGHe/3k2ra5FCnezqsLOntd6VEWEWr5PA==
X-Received: by 2002:a05:600c:1ca3:b0:421:6b79:8900 with SMTP id 5b1f17b1804b1-4216b798c9cmr55824915e9.41.1718041782597;
        Mon, 10 Jun 2024 10:49:42 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm149074925e9.5.2024.06.10.10.49.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2024 10:49:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240609-xtheadvector-v1-3-3fe591d7f109@rivosinc.com>
Date: Mon, 10 Jun 2024 18:49:30 +0100
Cc: Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Evan Green <evan@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD6771F5-5739-469A-9C0B-952AAC62AB68@jrtc27.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-3-3fe591d7f109@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 10 Jun 2024, at 05:45, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> The D1/D1s SoCs support xtheadvector so it can be included in the
> devicetree. Also include vlenb for the cpu.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi =
b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..50c9f4ec8a7f 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> riscv,isa =3D "rv64imafdc";
> riscv,isa-base =3D "rv64i";
> riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", =
"zicsr",
> -       "zifencei", "zihpm";
> +       "zifencei", "zihpm", "xtheadvector";
> + riscv,vlenb =3D <128>;

thread,vlenb

Jess

> #cooling-cells =3D <2>;
>=20
> cpu0_intc: interrupt-controller {
>=20
> --=20
> 2.44.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


