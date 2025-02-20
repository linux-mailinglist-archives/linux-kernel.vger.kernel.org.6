Return-Path: <linux-kernel+bounces-524867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15532A3E832
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B00A7A4E64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9326561C;
	Thu, 20 Feb 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkj/tpqS"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57651264FBC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093446; cv=none; b=tRhMqQbVs8WM3R2oSFOXGrYqhugOeY0NKGP1ie2B3K3vCUKwL31029PaTtIXBVS57Um5EAQA6IaVL+AiXVCSNY7OfGBwpaelZcRpqRa3gSSqrxc/Wworwyc/UdQH9vpi3+Mgo8HeGHGsDvEOIGPERGKqWFxisBf5g4sks+Nt4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093446; c=relaxed/simple;
	bh=1cIjuvp4munwp36O0Su27G+k3yaY66vxM/AalS2J9ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2bf7scXE/4FC7A5viTg1l3S12OQi2IjSkD08WNtbuNRupMLsOhM43No/M8SHIAPpSR3L/lyU6ST7N9jmHFsYZsb1LMR3yjIl/PY1FiI5JDJ9G0ydXV5ZOrVlQc2LYGbykJuerIL/zXQia6fEXd5SSvKh8mBgwBffIjPRxlqMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkj/tpqS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461a3a03bdso1195e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740093442; x=1740698242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=rkj/tpqSLFpjBs0dxR8qkkahDlYqKH/YXlwJaxKghOqYy8beHOre+cqReO0jFT5+HK
         C7MYN3247mdFm4Mg+XOMABhcWgBCsqwBWvsr18Uh4RXFNY7Mr4hEn1rt0x+EP156OhRj
         zv+/PqqiLu4XJWlkgOzk3jOhnZog23aBMD7vvytTr8XTa9Cqe5jchjql+YhOpQFx/x8/
         oJ7QKXIE2NT4tzSIk19kZ3SDzPhI9nidDVZa5Ie2v8aoL+qaMFbdg9OqxIOfhCIqrRcS
         luGMRxCeEiMtVISXNNpjWFImMCSQUirFI4dxJUXI0HSSu4vGgnKkGyRBRbIOz9x02E3V
         v3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093442; x=1740698242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=RNqSGXXfWyY8zq1zegzHXHumzGDs9RN0jg4CRDIvIpIxvI1g8NTNYagsJ370p3KDXD
         vAXhrWdFepI9PE4h1+IgjOYvOedSYMN738F45V+T5O3pqbs29tv8R4/jUxXS4b1wqgMx
         wlb5RTjmTaVNeBPeuiM1X7+71yUmKrMvVMaeJAti3AukRXcvcVrIEjU3sIFSLE5Wa5te
         ZJo8GjjKaP3tjI/D41fnXLY1bwdQRJK085+FagVhdpqHRmdw3Ciy67SWwkcijzJzZXTt
         RPJtNQdqgDRDD33R60QKL9UA51inM5km+U9mDc5C+iGD8trRqIDsSSl3VuZpwmv6ijoD
         j60w==
X-Forwarded-Encrypted: i=1; AJvYcCXiT8jGH1jox7GYeDKZfP0zbVidY9KhdpT12h0/r3QEhrrB8bB1Vw9T42AnOhRxWP6fceF6jjeRtLPmLnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AfbfiTwc6ydm/tftAh+QLQUPy5TvDKvP0SIyqnKEkORePJnh
	qQSo3dL0gPDWNOF1Erv2/4BZvH1W38T6LLq50VAZeBnHkMVfzqeH3NrM+Dp79VQiPkvrFx1QJ/7
	ITqvjGArj198bPTal5ASU32UWkUAkxp3na7XM
X-Gm-Gg: ASbGncsaS0bxvwD6toJ2g+sd2bgPvtwaBXZamsD3Z54Ry9Xo8IALcqop9HBrHFaZL7M
	joY467z8KAlXqx/a83BbksvxufSAiRdo+UHnvQSKj+NnmyKZiC1qjkz5naUrUxLR1OJlt4Wgw0J
	lpZ5gjKcTnvqCAbwj1PHnbmLihgdE7
X-Google-Smtp-Source: AGHT+IEWQiBc288yYrLCTppIrbxa3qN0HBmgiL7WK6l/eN2zlTxhCP/B74cPGse/0Iz95hyG2RtMrjG+GdCe2cYgGKw=
X-Received: by 2002:a05:6512:124f:b0:545:2301:b1c6 with SMTP id
 2adb3069b0e04-54839f9c24dmr36007e87.7.1740093442260; Thu, 20 Feb 2025
 15:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com> <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
In-Reply-To: <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:17:10 -0800
X-Gm-Features: AWEUYZlcMEtt0DdUpswWfn-2RnJ9b7h7OlP4aU2QsZo74T1M7MMOMNFwfs29_Zg
Message-ID: <CAGtprH-utPk=u938odDYAWAFLSZj+OhVH_k_RCHc87k3eqm0jQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> > like platforms, move HLT and SAFE_HLT paravirt calls under
> > CONFIG_PARAVIRT.
>
> I guess it's just one patch, but doesn't this expose CONFIG_PARAVIRT=3Dy
> users to what _was_ specific to CONFIG_PARAVIRT_XXL=3Dy? According to the
> changelog, TDX users shouldn't have to use use PARAVIRT_XXL, so
> PARAVIRT=3Dy and PARAVIRT_XXL=3Dn must be an *IMPORTANT* configuration fo=
r
> TDX users.
>
> Before this patch, those users would have no way to hit the
> unsafe-for-TDX pv_native_safe_halt(). After this patch, they will hit it.

Before this patch, those users had access to arch_safe_halt() ->
native_safe_halt() path. With this patch, such users can execute
arch_safe_halt -> pv_native_safe_halt() -> native_safe_halt(), so this
patch doesn't cause any additional regression.

>
> So, there are two possibilities:
>
>  1. This patch breaks bisection for an important TDX configuration
>  2. This patch's conjecture that PARAVIRT_XXL=3Dn is important for TDX
>     is wrong and it is not necessary in the first place.
>
> What am I missing?

