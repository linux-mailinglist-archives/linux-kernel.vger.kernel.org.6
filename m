Return-Path: <linux-kernel+bounces-410444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03F9CDBBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C72B28374B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D318FDAA;
	Fri, 15 Nov 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs2VRPji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9C189F39
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663518; cv=none; b=BppM4/GHN3/Fr4ii0aPr1jGuiUmyMDXekN3lG2YBLGzdTA9KQvMJ4RvhRJz87GVVfTbXcjCWPsoq0lDMSp8C7p0Uu4v9g2lX8XtqfQq2nJPwjyqSZ3poRixKJ04/JCYysdtPcV3eOBHMjfTv66VT6wA23Vr1sf4zQF3g03p5oGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663518; c=relaxed/simple;
	bh=YYysRYtvQy0q1YE+IIP4G0gf6yUYEBbUKM9dwLw5Bz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZaf7rDe1lmCO/cvGkQC1s437wqykt3U7U3q21WwHHBKdrTWOyMnw6vf8QPStlGKRjEDstx3ljHiX0QbK2bo+irWEmZCyVRh/mccRdwPYTV8FFLXC9dK50dlMoil1vGn4TbR5fswjAQ3MUaNMYyMFfmAp3eF9o/vplzZEO+9juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs2VRPji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8C2C4CED7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731663518;
	bh=YYysRYtvQy0q1YE+IIP4G0gf6yUYEBbUKM9dwLw5Bz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fs2VRPjinGAMEdi5Rh7G+TlO2iLPvRlxq1o9syXN2uRGCv28u6KobRl/uZiyWX4q3
	 OSmOG97V6FZfnKIG95m1CxHsYJMI0QfHwrNmmW7R3QRWjtZk0M2r6iDf2Wsy9JnDiY
	 KS6lHeoB54+qe1F6IIgiBOc5f4dLniXQ1u2bJFSjCwz4T/8LUOP0nqpGXsbLPAhy+r
	 k0BsQuxU8cHWkhZ8ytOqGJenJkrCDQI8k/OeClzKxq6uWwAz9TQ6y4aNf24+j7hIU2
	 pae9Sr5/8458dQMv9RYCaH8RQ2c8E1IjVp8F4JLePDeCKjR22N8FU+7KoE9G1POG+S
	 uq4QSazF7dARQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da4fd084dso1586597e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:38:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGzltkEwDa4AO56DzQTkAO3+Hd1Jm6ZThEDKC8cHsQo9SJz5nwziZMpRmv1Q27qVKQKJHZmwzYC48Tcc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGUFtuh9uCmJW2nK6zRic1GYo1NO4y/YmYMx326cRcXITXH2D
	gtKfO9o/YU1MxCTOYQSn/unjDlMZAtCoZkwyVMLatNYc0cSQtWq4ZBJDcUAkMnPW2hZfYQau3i+
	A2A2PLS+2ufk0ENwkgYk08ZdgAME=
X-Google-Smtp-Source: AGHT+IH73d+9THQbzwUoYsoeCx3epRujR0P8MgqQvHPDtQGZ9qZm/e6/fnvhYd36ViCB2QWThdX1O5NPm1HMbThelho=
X-Received: by 2002:ac2:5449:0:b0:53d:abc4:820f with SMTP id
 2adb3069b0e04-53dabc48279mr403956e87.6.1731663516323; Fri, 15 Nov 2024
 01:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115093456.7310-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241115093456.7310-1-zhujun2@cmss.chinamobile.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 10:38:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGgLp3vWd8jqN=NaB=YkqQgdFvoP_u-Kkt20NPjodLQ6g@mail.gmail.com>
Message-ID: <CAMj1kXGgLp3vWd8jqN=NaB=YkqQgdFvoP_u-Kkt20NPjodLQ6g@mail.gmail.com>
Subject: Re: [PATCH] arm64: asm: Fix the cacography in pgtable.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: catalin.marinas@arm.com, will@kernel.org, peterx@redhat.com, 
	joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 10:35, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
>
> The word 'trasferring' is wrong, so fix it.
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Please stop using the word 'cacography' - just use 'typo' or 'spelling'


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c329ea061dc9..4a5acf522c82 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1338,7 +1338,7 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
>  }
>
>  /*
> - * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
> + * __ptep_set_wrprotect - mark read-only while transferring potential hardware
>   * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
>   */
>  static inline void __ptep_set_wrprotect(struct mm_struct *mm,
> --
> 2.17.1
>
>
>

