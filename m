Return-Path: <linux-kernel+bounces-308099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026A965734
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579C01C22E63
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB01531C9;
	Fri, 30 Aug 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="muRvcvCe"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9B14B061
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997431; cv=none; b=m2aYXh7qOjssgFtZvJhZ7YgnElfucPe62O6hFyI5nHwbIXYijx3kXC2bgOY79o0ZPXAYn9Z4nmSh5YVBto5/RV9Nx/Zq9ejtgWQdLeMNyM9dovpES+RTk9uW5yjXmQBLXO0eNiRB5ZC+ygkZIwzmUV8DcDJEkKwa41695r0tGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997431; c=relaxed/simple;
	bh=EVTXf/DONCxrQFC0k4tFvKek06ZwX1QujVc0QdJjtiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJtOym284Xersstb9R1kK0SEqFsEUuexpYnR85LbSDWZWDLLWcSuTafNRGZ0Nj/el5STT2ONe2jqvU+oezHohkeo94a51ZC3N+TFoqsQLnGSMNOaNA/SAOFjZVOqg2IB951PpQ5WcQacX2Ath1j0rVeomJYjccQ/tROZRxdjkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=muRvcvCe; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df096e70f1so827227b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724997429; x=1725602229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bS4Vcno3eV2Qn/byTVlsNhExHrNUmtKjgh9WYM/zcU=;
        b=muRvcvCeY6dBvd3163VWvs96UcjV67HJDEGM8OHgVj1I5pDRiRCQjxUhc4eWv1EVwx
         n8cZmSaIcGsp1eE/Mta/vr1e9C8FWgBxt6vfSQVVCujOO5eVjSAUTK+eTmsV6peFPHAV
         6BFp9hQg2/7H6kxhkpkSiDtdTClpcDACL7NgI/BInmmWdKvHa7zW7tYBTkM/KCM3WCCR
         a5pk602HA6cWOhyXBKenM1xuOdgJBiExbZeHwVXA/Q3delfJevQv3vSV3Lb2TdqkUrJR
         CTqXbOPYhOrV5ZR0WLhb34zDcwYlE/GT6TDS5vraXMr2CqwsfxmU81U7MDwN/E7kZSmV
         RAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724997429; x=1725602229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bS4Vcno3eV2Qn/byTVlsNhExHrNUmtKjgh9WYM/zcU=;
        b=WlF+GlGZQNtEUwa+H0mDDFOsFImZBJqq7FhjqQ6EiwtKPNM28qNR6XPwp2bBb99HF5
         3FuB/eiDdZ0eTo07MIBr1EkrMKJnk9KKRLRFSgEkhkdGZ63lsWK9E6Ir48XO76qQdKeC
         iZTTBqlUHImyk6ODCUNpLikblLOtPOevaD+CjOhhzLRHPzzYD7ft+yaAjYfVrd8/VemE
         L3QajNPCh1XHK+lWH/Fd2tJzWu4ee1ETzvI/+nLAU4YWbmjeyMBG6N0SGYSAg6Y4JRtx
         wIslELoeNZ+eYGBoUXQiH8Cy6HphQor//rPQMDDdmdYlfg87tDKhQfShN1m/9r6lXQk6
         mWrA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Oy++ZALG4G15upxdm3uNS9HB+A3EWn1ubyAsiYuw+AB4/IVBVqw+39+6F4XZ65xNOW4a+yD6q7LelJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrERA/Jv9vJvF4DPOMm8eZN/3PUsrg00oamZ0vZE+fUchgfiQB
	zCbzvKl0ZLIPM500AgGbYFRk1o1s7saincQhgtqA3UFlRUl2BBALRsx9bhCvNAfPJvN9dVlKBay
	DN0ZjNo75LvV5RD2DJebXhvtbIXiVRsoqnu33Dw==
X-Google-Smtp-Source: AGHT+IF+bvBOzP8WPuHP2wswdhxLCrRjaJRkPZE2kRmeOLYycfULGuDXQiQa0ow1QrMYQIBLSiVTZE6myPNKH1Jcjkc=
X-Received: by 2002:a05:6808:11cb:b0:3d6:5791:a378 with SMTP id
 5614622812f47-3df05e22510mr5366568b6e.17.1724997428847; Thu, 29 Aug 2024
 22:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
 <87o75ba1hx.ffs@tglx>
In-Reply-To: <87o75ba1hx.ffs@tglx>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 30 Aug 2024 13:56:58 +0800
Message-ID: <CAKddAkBM6BW9BXYumiG8JzbTFRD1pgp=b0fcb=KBW6ysjPf8Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
To: Thomas Gleixner <tglx@linutronix.de>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Thu, Aug 29, 2024 at 9:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Aug 29 2024 at 11:39, Nick Hu wrote:
>
> clocksource/drivers/timer-riscv: is the proper prefix
>
> Thanks,
>
>         tglx
>
Thanks, I'll update it in the next version

Regards,
Nick

