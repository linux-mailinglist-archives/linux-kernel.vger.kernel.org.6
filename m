Return-Path: <linux-kernel+bounces-235928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182391DB5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67EDB2462F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7B84D13;
	Mon,  1 Jul 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="teoesQ6V"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8083A18
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825972; cv=none; b=uJzmganQ2KiIO4DcbCV+pWCEVSjFS8YUtv4vB09JK4SewTdDkLTD1dfcG0GDQ7fvf/JFY7Q92xXUvJGU1IBjLl3B56I/Scw+9bWGPvQI6Dv619QDTcgKFaTqAuUxjetcGLm/FjEF7c9tFTwdFP+rkzLFQP7xQT45y8pR0zfkax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825972; c=relaxed/simple;
	bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZuqp39SrH2iejpJH9PWrNoZ/70EyC53kg5okEfTakJCL9U1aInXkNctyDCb/ejetvYnJ6T8tjGrbx1eurI6LD+fx5ngBd3w6Fdl5wvsSXZ2IouLe3iQzywSUthh57X7Zr3fn9Jn8NOriUCoO0k2KDi2SgmxwiW04/YWFVt+IXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=teoesQ6V; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so1347849a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719825970; x=1720430770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
        b=teoesQ6VWdqt74vN8ZCCR7Bk9Xd8oAkYuNWjO3q38A1fmopWrRFodvcaNpklHRR8zU
         js6gd2NAeGcubxF/fm52yar911RzIUYzae7bdi4PvAuDlkjDXbWYb2SAvty1cb3XgE8s
         KzQRZde5IDjdfZvTlIyuPqisGz9bnM4rLW+UF57I+K7uB5DcUnD3bjBWcDTyIUg6/PjQ
         rNuh77QXBLxsdM9CoZbdKYgP3WSS9/i6gHOZ8UEUYLKNNIUoBqVnfrMm1pJrsCx31J0+
         CWswp5eT+te2f+DqXWULIgkxEodWMhpb41E3G3/1XpGVwAfNdRHdaJvE0IVYsTdU650H
         nKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825970; x=1720430770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
        b=TUEMD+60VgVgj3OjJ2/+zwNwIkuiN2xZ0z5yyJ58SFzessKA5J021YMMFsSlkezOzC
         4oukKJpi7jWtk/JG4Yj82cNKcBmtpWTDDDYH7MAlAlv2ArpHBiNNejA5my7jSaLinowE
         +EHAAUtvBRtG2NH1+0NEZD65Z0fM749W0edOQzEpNUL+mLbhhtORiMGRWK9UOYfq24c8
         0OfItdLj57AqImnM+0aXennIrnjvNMUu5EmDk3CjwfKpDXp2+h1ov6oPZ7tjznA28hoK
         ECvumqjl3hLZ8vlMDLs/wgp2gtyfZP+8LKG2PbA06mhG+V5ddmyICUCpOPYQM0stmsdY
         clUg==
X-Forwarded-Encrypted: i=1; AJvYcCUXIxwXkjp11UqVGJpF/VOGiiP5tCkhNntexlnUM3NK0fpHYbU7JKenUeu10RHNE9V+wuIEV+FjZMmGjtCl9rpiFNQG1Um5cVWJ3Wm2
X-Gm-Message-State: AOJu0YxgeeRC2YuRa5khyAfgfYSolaxSgREZGAhPlu+ctAV2536wbO1g
	Mre9BuCbgP8e/skv9qvwgLxkTLDreT7VbsshQBjc0WMhjJL4tFunPMmDmYkzqrMxFOHWOgZczGR
	/di7NJBuZAE7Nafl+wpDMiHzkLN6s4buZESaYzQ==
X-Google-Smtp-Source: AGHT+IFDGkhs/Uqx9rZKsJJeig7rjQkCf5zVJ9PGVd7JKGl0xn5A1rWbgKarqOMg3F9Uak5en6PJWXoJTcb9RkZko7I=
X-Received: by 2002:a05:6a21:3288:b0:1bd:23c7:ebfb with SMTP id
 adf61e73a8af0-1bef6277352mr4231085637.62.1719825970649; Mon, 01 Jul 2024
 02:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
 <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com> <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
In-Reply-To: <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 1 Jul 2024 11:25:59 +0200
Message-ID: <CAH2o1u7u3G0NDj_SjPPasNo9pJ2xDpBAE13=aqSG1EhVQyup6Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 11:14=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Oh, I think I understand what you mean now after checking the
> implementation of riscv_iommu_queue_vec(). I apologize for not
> understanding the meaning of the code before, please ignore my
> disturbance.
>
> Best Regards,
>
> Xu Lu

No worries, thanks for checking that path. LMK if there are any other
problems with the driver.

Best,
- Tomasz

