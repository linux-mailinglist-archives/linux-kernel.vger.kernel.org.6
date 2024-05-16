Return-Path: <linux-kernel+bounces-181563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450D8C7DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12ADB2834F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B1158217;
	Thu, 16 May 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f7I5TVmz"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576441581EB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891331; cv=none; b=bLOxxnMt8pH1QYFgbXMtUpmmpfcZ0s4J9HA6Q/qyiOM97ajQEdXIi0yrFdhtMUIgtaZO5OA+aIGmiGb/SsRUVJkVVGSLM365QNwj1FM7PT0/KUIqyJisjNOq52Q0IAznZJpCJXt0wesyI5XUOuzwfDn1WcTPxhTwGaT3yrgcWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891331; c=relaxed/simple;
	bh=kC5VynHMsC9YRLX685duYC0SDWhDLE4h76tMsTIxJ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIP09SgxeO39C0y1smIRHzzCKgMW9J0YMxUf7SHxDU7BoOBv+3kRqy9/0cV9HdXVyXcs7lM59Zi3oTlDBeCP5eUOjrysFD7BrLTn62c5SBH2NRPHHVqfvKod1nCn134tWr3MWD3Zs4uBXLowWD7H5im93qBkxJ3vdkiDG7gN/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f7I5TVmz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso562079a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715891329; x=1716496129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4kKN9JX8nIOafaZ0J8qaWRBKY02LqUa/O7jwO2X8Tk=;
        b=f7I5TVmz2dloZY3tjfcb5pTQNrPv0mLDrOCxzWIsorznjnTAKpjQIk2IS1USv5ZOZn
         h6qMS3dnyGPXkfUm1kBhXc6bMUxqcsLHmZdxBi9uvrn9j/N9YOgOgJgi4w/PuAsk9b0P
         N+M/GOHyvHeBcMonuA7mFVcbdF1avWueWc+YH4IB0t5NLsCgMfHxqgDuExKmFr4AAb1k
         /3734/J7SJPaw2Lqh6tJEkGsr/kQSlBIrGkK+dz/FLwqyhTYVkuBUGcmGllwhJXeHwiY
         zSGH54rdSKfee9jJiz5ZGDxT6uEmbTQwF4+9sPh9DU5dWSKE9GHevui8DxO7l0zlHQTS
         aiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715891329; x=1716496129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4kKN9JX8nIOafaZ0J8qaWRBKY02LqUa/O7jwO2X8Tk=;
        b=om38HtU2tANBW86EqStlRKs0ANFUQMfT6+0SL2b1wuiv5q149b3ChDj9arGcC1EwsA
         /UUB+O/9j+sdM7IH87O31MI6Tsv+tvc6lpObtvC5yYF5+Mfac3vSWOSKtXpwa88rjPeu
         6tVn6LIt+xleY4EaStkQZyFKpQ1KV8WJb6Qahl0Lq5bHRDFG8XuiTGPR4/lLHkAf/OvO
         xFqWFq5V+83q5Jq/92PQSaVtPsnLxS1fy2MhTOuoWRhAG88EZiCMQzI1oZ2IgMVWAN63
         RmfQ5h/bC0MQxL9YhfX1nJ6SNwRk/bODyB9tvbMIf8N5o9Kx2GESNCXn6WWNIgYkBSY7
         9Yrw==
X-Forwarded-Encrypted: i=1; AJvYcCV9t2AvK+TnsCgkF6BlayDz5DDoaMhFHpcH4pgTjvyRaUS0VoMQ2F+LiM9yLtPJ4NQ2zAm58RaHXXNr55GWaDJm/Ne385H8ktMPWwBm
X-Gm-Message-State: AOJu0YxFmn6viiTI0tyCq5zUVjBpJX7+zRrfgtNHyNvpHpCN4C36UoWx
	gWA1qL9dO+dk1702J7JP6ja3zutL0TmoZZM84TWpgpMYgLetKGvys1TcAPx8R0M=
X-Google-Smtp-Source: AGHT+IHTvY9bDUnWjwEIw7wiu0tFvYg1zAisbkSsd1SW/ziLhl1A+ZDZh7r1nudePVmEtMwYFsaJKg==
X-Received: by 2002:a17:90a:db54:b0:2b6:3034:4ae9 with SMTP id 98e67ed59e1d1-2b6ccd6bceemr16825092a91.35.1715891329488;
        Thu, 16 May 2024 13:28:49 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782dcesm15524206a91.53.2024.05.16.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:28:48 -0700 (PDT)
Date: Thu, 16 May 2024 13:28:45 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Andy Chiu <andy.chiu@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
Message-ID: <ZkZV3yxbxab4W6I4@ghost>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
 <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>
 <20240516-grandkid-monday-86c698ca4aed@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516-grandkid-monday-86c698ca4aed@spud>

On Thu, May 16, 2024 at 05:24:25PM +0100, Conor Dooley wrote:
> On Thu, May 16, 2024 at 10:00:12PM +0800, Andy Chiu wrote:
> > On Sat, May 4, 2024 at 2:21 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> 
> > > +               if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneous_vlenb() < 0) {
> > > +                       pr_warn("Unsupported heterogeneous vlen detected, vector extension disabled.\
> > > +                       elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> > > +               }
> > 
> > We only touch COMPAT_HWCAP_ISA_V and the failed case only turns off the
> > rectified V. So here we have nothing to do with the Xtheadvector.
> 
> There's nothing t-head related in the tree at this point, so doing
> anything with it would cause build issues.
> 
> > However, I am still confused because I think Xtheadvector would also
> > need to call into this check, so as to setup vlenb.
> 
> 
> > Apart from that, it seems like some vendor stating Xtheadvector is
> > actually vector-0.7.
> 
> The T-Head implementation is 0.7.x, but I am not really sure what you
> mean by this comment.

Andy, the idea of this patch was to be able to support this binding on
more than just xtheadvector.

You are correct though Andy, this is a problem that a later patch in
this series doesn't disable xtheadvector when vlenb is not homogeneous.
I am going to wait to send out any more versions until after this merge
window but I will fix this in the next version. Thank you! 

> 
> > Please correct me if I speak anything wrong. One
> > thing I noticed is that Xtheadvector wouldn't trap on reading
> > th.vlenb but vector-0.7 would. If that is the case, should we require
> > Xtheadvector to specify `riscv,vlenb` on the device tree?
> 
> In the world of Linux, "vector-0.7" isn't a thing. There's only 1.0, and
> after this patchset, "xtheadvector". My understanding, from discussion
> on earlier versions of this series the trap is actually accessing
> th.vlenb register, despite the documentation stating that it is
> unprivileged:
> https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadvector.adoc
> I assume Charlie tried it but was trapping, as v1 had a comment:
> +		 * Although xtheadvector states that th.vlenb exists and
> +		 * overlaps with the vector 1.0 extension overlaps, an illegal
> +		 * instruction is raised if read. These systems all currently
> +		 * have a fixed vector length of 128, so hardcode that value.

On my board with a c906 attempting to read th.vlenb (which is supposed
to have the same encoding as vlenb) raises an illegal instruction
exception from S-mode even though the documentation states that it
shouldn't. Because the documentation states that vlenb is available, I
haven't made it required for xtheadvector, I am not sure the proper
solution for that.

- Charlie

> 
> Cheers,
> Conor.



