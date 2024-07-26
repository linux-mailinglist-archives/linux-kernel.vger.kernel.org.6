Return-Path: <linux-kernel+bounces-263556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D493D7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F062842AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3717D35A;
	Fri, 26 Jul 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xLgkPVaQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A17D351
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015095; cv=none; b=tpCuAjOSxPthUFvNX7j6FuM3XrKw4Hjw0u46T2cYCk33y2aSyIw2EK+3mOgO6DiH/D3u2Z0Gui2HcvstRyChR5SMtUz+/X8ltHGXdTZhvdIQctluwrIaMu1B6+8UejZXKgyJhdJN4nfWGIIsQ1AQa+UU98mAwimxhYXKRsje5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015095; c=relaxed/simple;
	bh=TJFfdDn4hCn+JfxAD3q9QsIiCucI1Gx1K/+KVTB4ve0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUWJEZ3iSfhnAQK10cC/ZB2WPcRZ5kxtdD/K4WAhJCAzQ5l/AyM2YQGg7MB+MoaLEWcXpb1A76+gX28dcKSSxj3BXH3mWg0wYw3yFJGN5DTJzaC451122KQ+u3XuHAg8mCCJwKKu5xKlFJMns63sI3ksmwg9ba0ipbjYv2mlLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xLgkPVaQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427ffae0b91so24134525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722015092; x=1722619892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJFfdDn4hCn+JfxAD3q9QsIiCucI1Gx1K/+KVTB4ve0=;
        b=xLgkPVaQ4C8L0QS+GWG3v8MWW4F3rksKRcWhW59hiLB/pHuUSWVDT0rjQiSIB4w2YM
         ZdMyt+BUm99p86Kmp1RjzAWT8VuOf6vab/QXyV99UFx+KyPzxX3dNiZxU3ns0TprO9hq
         9qcDIrsjMj5Meww+9cOqPS4QMa7gw6IpIx6OeCmimJucIGpktjnRxHKpS+6KNaRfAo+H
         qc2wiETiRWQQ5Gv6aZTRUHLGwHFlRi7sI5/+EiVxSFEYR7pNNH9CJ02lkNHPeWvjZZFb
         ee1a16eeqb6qaXMtShIv8WU1kFlBYH5dPWRXkaimf4I36rRsNcWCkrbiZUv6aUFpBJj4
         hvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015092; x=1722619892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJFfdDn4hCn+JfxAD3q9QsIiCucI1Gx1K/+KVTB4ve0=;
        b=Sp61abRfw9G4SveF/DFMPoduY8VRrg6T+iqtIlnGOsuVPyJzU69alXxSM6C4sZ89ri
         g9rM/E2YG2HKeOvNbaCFEB9KJGLlSoN/xySB1Gz3WqNShG5UFZBvsd9tdpZXbRHBFszU
         RpqRrlkvWpVWFwBoDbY1DGZpNES5qtoqBcgGrrGJxlmVK9mufnVrJAAq4nUscVaRAnot
         BGcKuO19Y4lLMCZPcU5HsRe/CRERqxhdncWu9cmSVpKTUw2/lTB5b3C+101HkKEvewqD
         b8RXnL3ybFjcvyEWO+hFNF8laXJyg6CJuG4PNyL5C61R2KWnLZTXgZpBMjfcMI3NNqi2
         LVOA==
X-Forwarded-Encrypted: i=1; AJvYcCVsF58FiIchFZx3qDFhovkBMoG6k7sHBYnZWw8vweavZg3VpcMcroM5+kL1CCtvrfGRwo8VkGQ/bCmiszo9Eq7uQQwIrNcCVON2TIZ5
X-Gm-Message-State: AOJu0YzRYTIcUBLfDX80KSk3LUkrovlVN+v/Y/IhAyiUQw0FwgD5JB4L
	qfFwMZhgCG7/hhu3njnr2hDW5qdkQSLa7z4/wsruWtYJSZQRNHLXr2LPN2GB18uf3aGsrs8STys
	tzlea4XIwjg8ccR3cqqvWiUGyg/czOG96y4/eNg==
X-Google-Smtp-Source: AGHT+IEcbBIq0QVjjaGO3yyeblxO7j7e77wp+O5wnIUnEO6JQdPn2RcZcLA9pSLULVqKcWiJroK44X/hEvsIxOop/OE=
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr327709f8f.43.1722015091942; Fri, 26 Jul 2024
 10:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726163719.1667923-1-jesse@rivosinc.com> <20240726163719.1667923-9-jesse@rivosinc.com>
In-Reply-To: <20240726163719.1667923-9-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 26 Jul 2024 10:30:55 -0700
Message-ID: <CALs-HsuL_eFncoEe=ns2=Lsdr1y+a-QhzSsZ+Yw_LQ_X7fs2EA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] RISC-V: hwprobe: Document unaligned vector perf key
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:37=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Document key for reporting the speed of unaligned vector accesses.
> The descriptions are the same as the scalar equivalent values.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

