Return-Path: <linux-kernel+bounces-181042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F230B8C769A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4EF2814B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215DA145B12;
	Thu, 16 May 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fc3TQ8VP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F24145B38
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863113; cv=none; b=em4Py3FLLL2N45ba9zpT731ZY/XIkzIHw56Cur1JPslzNg0r2Y/ud1ffWrNFWech+IIXVg6e3LjasU60VY4eSxwydg/5wiA8Rbvg1Ott8Oo/4Za4U34O4e4LrBDKNqLtbnH/Qf/rPR3+28bZPngt2yW2mAdtRqNfBCNReE8Zlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863113; c=relaxed/simple;
	bh=UqqZT38xF3OOo/y5r7atHEZa4jxv8addNOCglC63/Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMQKFe1rZeVuzOL7GA8df9F+Owfw9gj0DqxLsWHg6dc/qgqFa1LeiRwojJufm1Bkd5FayuzvkiIGClluGA5tAvRtNOOeQp73UX/4BYnVhPw1LF1c5KdnxEsfAfiem1A5zPVTAOgMTnOQWJs2cHR6NB8O0q0BjJKKGQXT+4IC2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fc3TQ8VP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-523b017a5c6so1135699e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715863110; x=1716467910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iWXDNZutTCQXyK7swK+WhdATWJeoIgfasLnh7IMyXI=;
        b=fc3TQ8VPbgzkemLAbUvRHCX47FO1ssgRsUtP9XYaB1z+tn/5XeKh2xVm5fQIn+Do4n
         iFvRR4oIwDoPlVdJxY7XKzEtbCPkUNz0m7xhGbuBjq0+T7SFIO0PDyaEdD1+R/7nmg9j
         ZL8e0eg7YUzu9ltuL7XwdB4bohzyBrS5CdYBo9AzAcEWkTN+Jf4E+n/QQlnnnPuaKMQi
         UGZy75sOPN8Un1qUJ4AcrwjfYz8AAh4yZ8SKdu39dQt85jQotzhR4PUh03g5YxK6T4YG
         2hK8Wt6NerLoMuQr3DXTF4iSj1jtEwM3EJ8uK9PAIsjoobfhZr/yxlE4th98T7eHRnFW
         4hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863110; x=1716467910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iWXDNZutTCQXyK7swK+WhdATWJeoIgfasLnh7IMyXI=;
        b=DVUEWpc/NE0ZamuyftsGF+ajRbrPOUfSOuMmvaTak08XiHG/mKAEvTiV1qmbWwCCqi
         nVxf9cKYNkreX26gVH392SngI2ixcBWNjP6UJf9g4+bEmKVP3+SG5LgHx2iAeaRJfJKT
         YgQkAmvq0ZvRcHOeiCj5qQdAcPtYIP/1Ao1+5aUx509yKVkz9QzM5xOUxvACr5ny6cHb
         NpIey9Knc26c9EZJNpShAOCJu3Uc8pFSv1BaV/QNlMiN/M0s30jfEspD9Ba5leVF+dX7
         ZnHcIL0ikz5JvvmmCNoKd4G2x3B/7NKVA1z3tBmCnP2YouCbBo99KuzCarKTYBRU/Q25
         4L4w==
X-Forwarded-Encrypted: i=1; AJvYcCX9DjVsVClSJZO4ZuI6W6411XfaZpsBc2HvMsmrpV5tudSpZqpfp+gKTAYtMXFraqHPH2f0qt0kqfSkNked5isSUMK1zbVksfOqZF/D
X-Gm-Message-State: AOJu0YzXhPOU2ojPk7/4q5u/SU2dDDHsistgl4dLOFl9KscKBkQgWpwv
	bG3GzgFigVNON0uHwSXqwQ7VGUdjQxfvdKiLDnnTKKiCmGra2zBPnimud6gpX8M=
X-Google-Smtp-Source: AGHT+IFvaxKFOv8LilzEoxtWuNaiQB4YOLRJwVRKx1QLhx9shrtK6ID4rKRb2vM0K66NfrbiVweSbA==
X-Received: by 2002:a05:6512:238a:b0:51a:c7d0:9e84 with SMTP id 2adb3069b0e04-5220fc7c57bmr21204513e87.12.1715863109765;
        Thu, 16 May 2024 05:38:29 -0700 (PDT)
Received: from localhost (cst2-173-78.cust.vodafone.cz. [31.30.173.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d10sm974132366b.198.2024.05.16.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:38:29 -0700 (PDT)
Date: Thu, 16 May 2024 14:38:28 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pulehui@huawei.com, haicheng.li@intel.com, conor@kernel.org, 
	ben.dooks@codethink.co.uk
Subject: Re: [PATCH v3] riscv, bpf: Optimize zextw insn with Zba extension
Message-ID: <20240516-0ec6ff4ad0e23302003be51a@orel>
References: <20240516090430.493122-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516090430.493122-1-xiao.w.wang@intel.com>

On Thu, May 16, 2024 at 05:04:30PM GMT, Xiao Wang wrote:
> The Zba extension provides add.uw insn which can be used to implement
> zext.w with rs2 set as ZERO.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
> v3:
> * Remove the Kconfig dependencies on TOOLCHAIN_HAS_ZBA and
>   RISCV_ALTERNATIVE. (Andrew)
> v2:
> * Add Zba description in the Kconfig. (Lehui)
> * Reword the Kconfig help message to make it clearer. (Conor)
> ---
>  arch/riscv/Kconfig       | 12 ++++++++++++
>  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

