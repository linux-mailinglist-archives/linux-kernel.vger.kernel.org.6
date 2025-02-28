Return-Path: <linux-kernel+bounces-539120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88357A4A127
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EBC18998EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491926E140;
	Fri, 28 Feb 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRZ8HUEy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894C1A2554
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766098; cv=none; b=BG3L4pQ4nNPO3d1XzFvNgspPsC1JcASwxvJDZCfzJ6K8SIBLM04DCmSVBvW+GEF+zTLW7sZjnkGeOSJuyVCmPLhrbeZMafAuQh+daGNp4No2MEe0vXntxol7UHUbqFDQ9Cum4QMVtHjUTE2l9odEX3D/r/tgi2mW3xfJm7Dr/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766098; c=relaxed/simple;
	bh=mkKMZyvEmjILI0VQPl+Q47RBH4JPzmUV/Kn8yF96AJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1BN1v5LLXPpQ7+WEFhuTq/ZnPVY3LzLgjTcLph18VcDjCzFKM4WAInG273DkyPE1R1BVNw28tQBZPVRwlw37LQtR/cJNxWeAgu+nzCWPQy5f+qmiwg3W22FwCHWjDiSz0Wn/gElLw/O6BDCVCUB0GizDM+ETSD6lWWUlNSDsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRZ8HUEy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22128b7d587so49589455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740766094; x=1741370894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FGlj93oVSUEpNebXrgo6mP2cBNMi/S6YmOpjIgHVhA=;
        b=IRZ8HUEyf3Gtg58OEX3aACVCzEtcpED+cNt0qIo5tXLiDp/qJbuIZ2Sz3zOLX1Aj6M
         L8omAsu9mBIpVVQj6BUBub5v56dQU74tWPiW0jVBINLLOBGXL5NxmP5q4kWz8JhbL3gk
         earrCd/WaWQVyxO3x+IG5Oo7d46jD4HAGqlV8Can++CLPxt2Mk+QhWds9jMXYfg2nSTd
         59Vk9vrSNcWNxzFvbCOoKMhK3QKw08UJY465TtrQ4mn7ogu9Sr/W54VbS7zMAY5WNaXi
         xhTniuGhiwdj6t52EEtbSNaCo5vk8AwYil7vF3JucpFJUpejjO0zAmUGUrQc+QxY0s7f
         ba9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740766094; x=1741370894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FGlj93oVSUEpNebXrgo6mP2cBNMi/S6YmOpjIgHVhA=;
        b=CX1YvCZfDyAnFxnNywgkIrOzeJI2PojkEOPnVuR6YV90+w4VZrR8MU2i9FTEpL94yz
         yL3hU/xdxoIJyd1rfcncKnbJW5/by1/bh0KDoKatpKtyYzP8aCUAL+k/Fh+Rd/Xk/NsE
         p0Kup6XeFYvqobuNroDiNHimtV9Z6LW6KqZRVolEpZfX1aOxSa/+8/97f1Xw4HFfSblP
         OqGN8PNfodDaEOJg1/amzu+fDTKxrmbFlAvXSt4/hO9tZm/lgrw0X1oemqobdrWz/swO
         /mR02ZwxvU5bw0+Xw4/8uCNbZG3b5CBgQaxeaSZaKgx9Exn8fMb5XNT0qcc0/P8LEpEO
         /rrg==
X-Forwarded-Encrypted: i=1; AJvYcCXHp8IZUlmRolLqRXtiGehlt1uY+bQP/iDDuV6e389LdDdRAqx4leHquGwiE1peqf2UNStdkTr2VUA+HlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZx7PTbUwj5Tejztnb/Y2Xdvdm2YrW7x/9tNJlevMSueHe5t4
	w7DKixgCITZxO5D0JQDtHHeXj/hi7Th3Kka4gR115l2x0DrHGiLNXsdU34RA
X-Gm-Gg: ASbGncuf0ZbvoiOVO9KnJf9MnpKHRfWYELFUMTxBjE1kHDddOF6c71c0nmAJCKT+OFG
	2L6yumBJkuDoZm/hJTT1/XR44mKqSSvAn5JH5FStUXRg+TTluy/XZCj8ARWE4HjNiq+yChNdNla
	9A1FwbKHVXx1u0OBF6gdWg30Wr4xlyAs10AxnPl6D+83rJ+cOSYy6Xk8hnCxEdP+7J6fI/qzRww
	YOTdKVkN/L7Jnqv6EjsbvKekPIZbpUg65L7LIQkaZTXfaKdr3e0lSCoBfxkCQpKhp0AcqXGuWj4
	AbY9ZO6FLyzwnfVVh83Iivm4AVRY23Rt5kSpJe21prEYF9jiMA==
X-Google-Smtp-Source: AGHT+IGwgbctKvSf3lcIuN61DVELtr/K9ktb/iP3RdLzeF9PdO6RarJyLvkc2P4qmypooEahW4Ur7Q==
X-Received: by 2002:a17:902:da91:b0:223:5c33:56a2 with SMTP id d9443c01a7336-223690e1aafmr74058445ad.28.1740766093703;
        Fri, 28 Feb 2025 10:08:13 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d94csm36339635ad.201.2025.02.28.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:08:13 -0800 (PST)
Date: Fri, 28 Feb 2025 13:08:10 -0500
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: david.laight.linux@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	skhan@linuxfoundation.org, mka@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 RESEND] uapi: Revert "bitops: avoid integer overflow
 in GENMASK(_ULL)"
Message-ID: <Z8H7ima1qAsHNhuu@thinkpad>
References: <20250226065623.1567363-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226065623.1567363-1-richard120310@gmail.com>

On Wed, Feb 26, 2025 at 02:56:23PM +0800, I Hsin Cheng wrote:
> This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
>  GENMASK(_ULL)")'.
> 
> The code generation can be shrink by over 1KB by reverting this commit.
> Originally the commit claimed that clang would emit warnings using the
> implementation at that time.
> 
> The patch was applied and tested against numerous compilers, including
> gcc-13, gcc-12, gcc-11 cross-compiler, clang-17, clang-18 and clang-19.
> Various warning levels were set (-W=0, -W=1, -W=2) and CONFIG_WERROR
> disabled to complete the compilation. The results show that no compilation
> errors or warnings were generated due to the patch.
> 
> The results of code size reduction are summarized in the following table.
> The code size changes for clang are all zero across different versions,
> so they're not listed in the table.
> 
> For NR_CPUS=64 on x86_64.
> ----------------------------------------------
> |	        |   gcc-13 |   gcc-12 |   gcc-11 |
> ----------------------------------------------
> |       old | 22438085 | 22453915 | 22302033 |
> ----------------------------------------------
> |       new | 22436816 | 22452913 | 22300826 |
> ----------------------------------------------
> | new - old |    -1269 |    -1002 |    -1207 |
> ----------------------------------------------
> 
> For NR_CPUS=1024 on x86_64.
> ----------------------------------------------
> |	        |   gcc-13 |   gcc-12 |   gcc-11 |
> ----------------------------------------------
> |       old | 22493682 | 22509812 | 22357661 |
> ----------------------------------------------
> |       new | 22493230 | 22509487 | 22357250 |
> ----------------------------------------------
> | new - old |     -452 |     -325 |     -411 |
> ----------------------------------------------
> 
> For arm64 architecture, gcc cross-compiler was used and QEMU was
> utilized to execute a VM for a CPU-heavy workload to ensure no
> side effects and that functionalities remained correct. The test
> even demonstrated a positive result in terms of code size reduction:
> * Before: 31660668
> * After: 31658724
> * Difference (After - Before): -1944
> 
> An analysis of multiple functions compiled with gcc-13 on x86_64 was
> performed. In summary, the patch elimates one negation in almost
> every use case. However, negative effects may occur in some cases,
> such as the generation of additional "mov" instruction or increased
> register usage. The use of "~_UL(0) << (l)" may even result in the
> allocations of "%r*" registers instead of "%e*" registers (which are
> 32-bit registers) because the compiler cannot assume that the higher
> bits are zero.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

Applied in bitmap-for-next. Thanks for the work!

