Return-Path: <linux-kernel+bounces-206793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D5900DD6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC46283B70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DC154BFC;
	Fri,  7 Jun 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b/Gbsc5z"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530412B93
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797707; cv=none; b=iKbujcvd9zACMduiCoIbFTvn/hLW1BGl1Cow8RJaF2VDUr6rN0ax60DQcmjBkg9bejxTATIcBR+VGA1j4dAKy08yPAQWIVyZXGoJFz2SPMcnXDvdQbnpE7ZVCPFt8p9jtoEvDsUHURv7zv1e/TqWWxa31oWG1xPQm5g/aN81c14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797707; c=relaxed/simple;
	bh=HgG8kVkEglgLX7MJcyxmuum1YvnKnUkJuJ2Cm/ZTSnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnOYlBPvk8TSKTMF0yo6ayeqEsKtx55agWdpro4iNy6IKbzlaMq/1X5CYUO17fsTDSspB9Gx7SS/4B0KUV978eyHa79sH4IdVxtEjiNKk4ISPmcg8fMvAB3RHH2mEp3ssFmP6lwMa9PKcaHrY7ATzoDmvbFbg3ttM9xzDrihLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b/Gbsc5z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-702492172e3so2269546b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717797706; x=1718402506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75kpnasqev5JD+W3tO0sE6ARWTXSJTS2/9u8O9IAZK8=;
        b=b/Gbsc5zfMFzMBfTCMbCRQY26niSCIOj2Y3wz0DUZBJvIG2tAH0N9tvqOS33qrrjrT
         jJFuEpXw8/Ljm4mUOeDaZIBgiwhrS3ga1cr9CPLBsPPfKzwJrN3z+ZMen7BiizOVbtMc
         mkxB+ufcRHM590aPFvySMvPS7CMgh2fuoOhUfZhZg/V6O/F/PObRzCe/pw9Gzd4+FO6m
         GA7JYwHUG4FZHyS41DOdzLkR0Ow+BQigQmdn+CcUKLQNgaMWavyifcLRAys2ZJooFx5q
         Obv1dygt+/Zenv+GerMHP2rS2CP6HtBSpQsVAiXySb9AVu+UcX9Qh1KWJK4oBkWLHzxF
         I8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717797706; x=1718402506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75kpnasqev5JD+W3tO0sE6ARWTXSJTS2/9u8O9IAZK8=;
        b=TOi9jUhY3vXhaPKxlQf4BpOoOjjslRM9TQxLvUUnrunGJLS/O3Jcq54ntSHvfzDwSb
         yQT1D/RLAC3HbVfZM4lf63J9ghcnO0hxTF/e5Vu14iNLU8Dc/L1lY6rB+M8o0o9i3Olz
         czG9vfeEozS8bq0ABBVzTpZthPpjqRa1fOc/w44jqt53Oa7i+IcjH+O2sKje3/MUjrlt
         1gdbMNy2zyKNp9rnUH13ttRTm96WFAmizpEy3qO+E1MGvVfBmwokN10++cH21J+3FgTw
         7AXIpsAKdCCGPBGfC0r8YEpf5ZfSTInGYGI7F5bHjrMDs9lcY3J683uUCdTTNCIY7kNr
         CWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8bajKsHcK2h/mjE8ttr717Z5+c/YfWZChBwKN7IVuNbZWkAAPeqFXLwx1Bb6/oiNigksJWSngcJOFLIi5vcVLJSM2vuIClAMiyzNm
X-Gm-Message-State: AOJu0YxgHh/RGzmI+Xk64y841BpF+4E7OGUHzxB9V87tkAZvP340KBno
	ahccSvbRtPobueeh1ckQM6mBNaBu6I6s2XAtbBI43ngfdrUdMbmc/BOtEZXRKp7mehoIqD1bxwC
	l
X-Google-Smtp-Source: AGHT+IFChtu4tG/SxDzBPzFrzoSYJnwGMc+HGLFVJlSWYwIe/rm/MSoAbdLGq//B/YyTZI5ubiDiXA==
X-Received: by 2002:a05:6a00:4649:b0:702:6f45:effc with SMTP id d2e1a72fcca58-7040c690d1emr4038399b3a.20.1717797705590;
        Fri, 07 Jun 2024 15:01:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041fef8548sm394640b3a.113.2024.06.07.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:01:45 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:01:43 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: Per-thread envcfg CSR support
Message-ID: <ZmODR+EMn5zW2Iu1@debug.ba.rivosinc.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605205658.184399-1-samuel.holland@sifive.com>

Hi Samuel,

Thanks for working on these.
Patches looks good to me. I've given some suggestion for patch organization
and squashing. You can take it or leave it.

Other than that.

Reviewed-By: Deepak Gupta <debug@rivosinc.com>

On Wed, Jun 05, 2024 at 01:56:44PM -0700, Samuel Holland wrote:
>This series (or equivalent) is a prerequisite for both user-mode pointer
>masking and CFI support, as those are per-thread features are controlled
>by fields in the envcfg CSR. These patches are based on v1 of the
>pointer masking series[1], with significant input from both Deepak and
>Andrew. By sending this as a separate series, hopefully we can converge
>on a single implementation of this functionality.
>
>[1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/
>
>
>Samuel Holland (3):
>  riscv: Enable cbo.zero only when all harts support Zicboz
>  riscv: Add support for per-thread envcfg CSR values
>  riscv: Call riscv_user_isa_enable() only on the boot hart
>
> arch/riscv/include/asm/cpufeature.h |  2 +-
> arch/riscv/include/asm/processor.h  |  1 +
> arch/riscv/include/asm/switch_to.h  |  8 ++++++++
> arch/riscv/kernel/cpufeature.c      | 13 +++++++++----
> arch/riscv/kernel/smpboot.c         |  2 --
> arch/riscv/kernel/suspend.c         |  4 ++--
> 6 files changed, 21 insertions(+), 9 deletions(-)
>
>-- 
>2.44.1
>

