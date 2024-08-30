Return-Path: <linux-kernel+bounces-308500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD5965DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC431F279BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F017B519;
	Fri, 30 Aug 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G5dyOtCK"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BF1531CD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012105; cv=none; b=jwg9SybVSjrsP5g6UA6ZGbmSBdbrFC9HUS+Ld0eYxyFd+we3J15jK6ZOU0gpSXg/MkhgduHQKj4c9g+3DvQkq3R61FbxKA6SMFnw05c8h5GPGF9cLK2rvw/mXNcdiSj2rgQ66oOHqRRwwJWugELj4NaG5xsfbq0rHVrrHcrGkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012105; c=relaxed/simple;
	bh=LZubAQ4YaXASrR9+vpPgJI8s3K379aWVwNe79OIAA8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEcKTu8Jt6YJNuo0vwl+YjGeFfZ6um1QRUJI5AOVqHx6SFB6j4JqMO9YG27ycV+vs9krLEOv9RkPSnjw3x3BVKQFCekkd6gYSxur7l78RtQs8sN47otgYqZDnDPF8Fo1oO+x44Hlhh4KgIOtZkVdC/lW6TQFzMVITzw8rjHIZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G5dyOtCK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2700d796019so872222fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725012103; x=1725616903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGh6tOVfT3AGgZmYj7CotHEnsUZ6hNFR9Fk9bpSkfUo=;
        b=G5dyOtCK3Yh3CRrIEdavEApOC6h0q4XZRyToOQzNYLylFTFQnFmb1OwZhyfr17SleN
         8N4lJiOUd5KcXhO0oa+Yw/2fQRiUO+Td6M1qLGHKBYJ/fRfNcZfsr5yRtKKdtoJZ9I17
         9WCvG4t12AKAoYYkJrXyV5/cWdnNTwnXmxCbIhtVXXaozOy3PtKijhHnHh2cin+VQu+/
         uiBwoDPS2Zi+9lQ/f8GLqI/pB7U2m2iVG/PRJJSnOofKTa8sbQdkm7+uFEITmxtIotuF
         w+HxGHm303S5HjWIml9jxRKiwO57J7zzrpdrXXZXciZSxvvYCGFtDYimdSY7Y3r85n16
         JcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012103; x=1725616903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGh6tOVfT3AGgZmYj7CotHEnsUZ6hNFR9Fk9bpSkfUo=;
        b=J4N4Nnbyl73dXaFAYgFgKStQEdGZpFT8sv3ilTcswU15je8gSRpL9AHMM2XIpbpGL/
         E9a7s163XArDWfk0q0MCATTuVodGoofQw7dsIQeoSBBZ5qjESzi3o+v/tuCql946UcLE
         Px217b6c9ygaKDWLl1zC3b3BkRXxPUbbagTCrA4r/D80OMWB6ylzqN4tWzd6nJYzcTkM
         wEANkPwSlHhdmZAzyxtFt2ZTY1rRHDohsMMPQnHbr2YloUJpyVkXrNdxQIf41twwyZg3
         UIIJdvncoKXJqgNBsQFVNk3eaSiUc2R1deZ6c1ocJApXdVzE0pD3sYDjghHoQJ3WwTPS
         f5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhe3Z1VVRONHSai+JQJNkslYBxG3rmg12OMCrswtYt7IObNGyZh9Ww6TDLWJkMmoIP7bPrGIGCxPlI9fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE571NWOxIPYTYzmTfWnWk4d+dARP3YE4wShZ0W9+19xnw0bhy
	21yCo/jJOqiCK5iMBkbNDkFWEmplZp7nkLtTXk478ZXHB89pCLe9eQE+8qy3iE0pW12S0jdAAkX
	1ZAPpRPNanPl/F8QApPhmu36yDhv1ZLv0G/bMlw==
X-Google-Smtp-Source: AGHT+IGgJq/nQWVrLteUCrCDYkCkCI+cLIsJ8x+FujDVpbUmLezFx0No7xlEbHjnEnq9yqlFxxMSaWSfJiKh7JuD0qo=
X-Received: by 2002:a05:6870:9121:b0:261:2357:5a29 with SMTP id
 586e51a60fabf-277902f60bamr6302103fac.46.1725012102541; Fri, 30 Aug 2024
 03:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824004920.35877-1-cuiyunhui@bytedance.com> <e06a3bd9-6378-2d4b-b06d-cc2d58776eca@gentwo.org>
In-Reply-To: <e06a3bd9-6378-2d4b-b06d-cc2d58776eca@gentwo.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 30 Aug 2024 18:01:31 +0800
Message-ID: <CAEEQ3w=PsM5T+yMrEGdWZ2nm7m7SX3vzscLtWpOPVu1zpfm3YQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC] riscv: use gp to save percpu offset
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org, 
	samitolvanen@google.com, guoren@kernel.org, debug@rivosinc.com, 
	charlie@rivosinc.com, cleger@rivosinc.com, puranjay@kernel.org, 
	antonb@tenstorrent.com, namcaov@gmail.com, andy.chiu@sifive.com, 
	ajones@ventanamicro.com, samuel.holland@sifive.com, haxel@fzi.de, 
	yang.zhang@hexintek.com, conor.dooley@microchip.com, evan@rivosinc.com, 
	yang.lee@linux.alibaba.com, tglx@linutronix.de, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,


On Sat, Aug 24, 2024 at 9:57=E2=80=AFAM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Sat, 24 Aug 2024, Yunhui Cui wrote:
>
> > Compared to directly fetching the per-CPU offset from memory (or cache)=
,
> > using the global pointer (gp) to store the per-CPU offset can save one
> > memory access.
>
> Yes! That is a step in the right direction.
>
> Is there something like gp relative addressing so that we can do loads
> and stores relative to gp as well?
>
> Are there atomics that can do read modify write relative to GP? That woul=
d
> get  you to comparable per cpu efficiency to x86. x86 can do relative
> addressing and RMV in one instruction which allows one to drop the preemp=
t
> enable/disable since one instruction cannot be interrupted.

Your suggestion is excellent. If conditions permit, we can indeed move
closer to the x86 architecture.

Thanks,
Yunhui

