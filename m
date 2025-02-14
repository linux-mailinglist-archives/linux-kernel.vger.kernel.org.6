Return-Path: <linux-kernel+bounces-515595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01730A3668D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A8416A8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4771C84D3;
	Fri, 14 Feb 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atWkLEFO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C321C84AF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562920; cv=none; b=TeLLG86k4/PUK+0El0K4obDjdilo47XCIeQ8Vi7qv0f6WFK4F1JzS4FXI8WPk8xlN6IZJhu6zHdQ0tu2x89cKhoHfnBDXYEecDU8TDNYI8e02e7vIad17tCNBuBOXwe38M8qHwCwPlVuBycR2HEJNaao/xPv1D+KEs0ItH1aysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562920; c=relaxed/simple;
	bh=yMZ2/JPlJNhfijRUmJA7R1MnwXY6ka17JZFq0S/gLV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Siud7XPHldpjJplBfiPDBVMqjoRc1Hf+Cp851sdQa+9eMm6vB6xZ19+Gb2NXpishkBK1WBW/VdFn5Xm8u+4SsqHsRXPSWBbOiGuJowpNZ4EwYnndSl+ww4x/iUVd8q/f+WPaI2hoIXrUKmyv6ZTZ6c55bo0pd813BElgW/bJm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atWkLEFO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30920855d5bso10277471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739562917; x=1740167717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMZ2/JPlJNhfijRUmJA7R1MnwXY6ka17JZFq0S/gLV4=;
        b=atWkLEFOn/lEhJWNraCHKrv4sm4eGGkn826R+IL2HGYZjoPR6hpvXw+TZP6ZD8aIgx
         EHCQEk8Ey0zXZE7qpGw3ViL0KeoBP5wMu3WiO5vOay3r77PPUVv4kIAcfpxB72GI3Jx4
         H1crNSw4gJiHR/CFYFUMVLXDfhDKy8ji+A1QoE19qdVjMz2WZZyD5KOc0widUF+/iCX+
         fpLodGSUtFibFl7EeDkYoglWjXjJMiTQHN1juVmOdrCYc+Mup/itIeBT3TGGA4ksHc8c
         Z1j/zNQnSPrPwl+9pdeVkaWuPXcnJanTCSpBVCa/NQV9jOWmBr82JeEAwnHf0Ot9FRDs
         3iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562917; x=1740167717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMZ2/JPlJNhfijRUmJA7R1MnwXY6ka17JZFq0S/gLV4=;
        b=S0oFyQ3CoCXtt5qix4xcqQpJ0pOPP/f2l1wdPzrJPwJ/RKxckOc20pkuPM3pPv/sw5
         xBGrvhbm4CW9PFh1Yc5RvnegvbYSxUagCnUca2Q6XSdeWpXUPXyTikLgHJlS93/Q9EQa
         7xjfcADY5FuYwZNYPVXzauaxR63ZRCi52uCZpwNDsrBIdRcUdJirK42Gh5P2K6utXT/C
         Pplp1Lp3ho8YFxZDwfcnf73EOmEQAHyDwDqrcUmULMvwZd3z/3M3qBIC5VR0kS2zgsbB
         t/ggUuOhhgBXTxTiasTLkw9z4IQYa9mdmyAaKdX5UxVRfcmQaXobyhjnxK9dAyouGNJM
         esaA==
X-Forwarded-Encrypted: i=1; AJvYcCUeq9KE9Xuza6Qjy1w6cgfhOUYgLA/mmJhG/fu+3UhsSuvrZ91Z0AIvyP/atrwfMtdPLIAflxo5vP81Nno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfWDXfRCemg6qgomLI4sPmQIdZ0Q36AOCMPGaxVMD/MlJs1Ns
	sXe4QI48QVHWTIh/TgxjAWLcZ8mM4zuwfta0TtMlSuramzkrVFFKiXLalsRK7xpEl1+bltwzNi9
	eOiATBsGeg06Nigp8/QVnwxKAazY=
X-Gm-Gg: ASbGnct3uQKSSWsruDgUyxMljd8M+fFZEB9J4BLbUjXPk7jpdeCj+TPKdPO1Yc9RBh6
	WyAWgm1YjvMuCeyh/Z2F9NsNZ7J880sOtMhic7t3OOF0GwZQFe2AY9o9k3IfBnurCHV0E+zG1
X-Google-Smtp-Source: AGHT+IF9G5bgV9D1yOsWCWwuw4d1/Gl5fDFWq+7odiFv+8Ue3CHnTgi05GcstQFuYH9sUv9ys/X0oeL32RpkkpPR+a0=
X-Received: by 2002:a2e:8657:0:b0:308:eabd:297b with SMTP id
 38308e7fff4ca-309288b1b6bmr1582711fa.4.1739562916294; Fri, 14 Feb 2025
 11:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213191457.12377-1-ubizjak@gmail.com> <04adffd9-2900-4cdb-a557-1c486a87b522@intel.com>
 <CAFULd4YUSCBSJQ1F0Rn45bwTonQJb2_=c2sZZEGV7RfgHBAOJA@mail.gmail.com> <cf264b5f-be03-af53-3de3-a97051f9577e@gentwo.org>
In-Reply-To: <cf264b5f-be03-af53-3de3-a97051f9577e@gentwo.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 14 Feb 2025 20:55:09 +0100
X-Gm-Features: AWEUYZndtUFuHUobZ9uYTlaAdtqql4J2p04GR3tREOBJhVdZI8n7MmcYI8IZAjo
Message-ID: <CAFULd4YMNsSzNS8wBZBC8iy2uNnoV8kDWpp70r4Wx+-wJ1j1Rg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:22=E2=80=AFPM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Thu, 13 Feb 2025, Uros Bizjak wrote:
>
> > OTOH, all recent x86_64 processors support CMPXCHG128 insn, so the
> > call alternative will be rarely used.
>
> Do we still support processors without cmpxchg128? If not then lets just
> drop the calls from the kernel.

I'm not aware of any discussion about that decision.

Thanks,
Uros.

