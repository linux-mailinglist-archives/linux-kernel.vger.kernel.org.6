Return-Path: <linux-kernel+bounces-180166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F68C6AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D86F1C20BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E682574F;
	Wed, 15 May 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZIr1KB93"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8614084D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791769; cv=none; b=GiqD2sKmeZhNGrX0gcMGrm/H/fxryIZXpoUAN8pf8RoYpHh2OKcOS6sWzdKsUiPokT+9LWgZouAcyBqw2RivVhBOCTrWGDBN6n16KlKNKJvHzKFBdNGmkRMDbVLbaEHJ+fFTmp2q65V5wsDngIH3U2M2yH47nlH5j4rafXyfHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791769; c=relaxed/simple;
	bh=rwSS1TgJQWw0adIVRDDzmes057TY1+a9Xl1CeLSbnlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiCoi/d8dl3Mtq4XKqCkfaalv0ZjSnEkQyxj7I1GKxEATgEuvFUUZLSOLciivyHa8tt9pF9TTFAabxaHI2GUTevPy2lKfF8AH73Tjd+HymTsAB+Gnklx1mno9MapJNdvHzp01W6gkCWBdGJK/6jRnU/srZqXha1MgBMmbNFtb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZIr1KB93; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f666caf9abso2167416b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715791767; x=1716396567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoV7cV0JwbbBn7RhWLNEmVN8lGKUwH4R+jX2T3SF4lM=;
        b=ZIr1KB93OMF8RmtuyTYOKw0VzX2kmPgy7taFkxS/BF1eE73+QjIv6QzadTfEWWpXjC
         sRTQ64hzFvJXYOWNhDBJb4PNt6nKQKkOd6McZKeXhtXCCnylj+NMtCrDbd2zaLAgAuzD
         vPJqnpi8yq1C32tIwSf4Fb4oKPH3Spr8Yl2AzB4uYQU+ssGDgaGtc4POlxDmRA+5LWIW
         Vo1kk3DOQuqzgdnehsvT3b0GG/wkjsCxfsp6y6srD8OT9yAcNYRwMO+/K4NMr/Rma8lB
         R5POTS/KWP2QEpTsFcX2Ci9HuSvP3RucSCFMocOgtagrj/pH4nYuxx59bErltivMUNex
         +XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791767; x=1716396567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoV7cV0JwbbBn7RhWLNEmVN8lGKUwH4R+jX2T3SF4lM=;
        b=CU1h0zRpfq6ODYQ2/d4R++CY4uhUdOfCI2r+jAp39meciT8zYqXNSJTFi5LQWUVT3w
         Neft+Ye1Lv6K0EqvlpDNAqnLRJtEMNaqi+fFhR6xOGsa9KCK/tedh4XOYMBvEPSltp+z
         QKHyNlKJ+wgcDaHJQvX9fD1NbVvuFN5DdyLEa2LrS/D+hBg2nncgncGAORWmnryeKUFS
         lsCfz27VeBKQoJXo1EMW4huE1mX8OcVPUyVJGGngJSSZBpIUwfdnd5oFiPUnjvFgMAKZ
         rMfQbIFZCFwZzIV702Aw6eEeS/l5On/f850rPjfH+jxYTsjeoQx/dwzsSZ/2ZPy9z1OA
         TXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2AoKJ7DCfVQsT24G+SlfX1Fbp+Cnd1iNL1DJTBkIaMVN4N0AjexsaCcSYpLmjfDROLmse9s1C+hwUAYgHJE5sBtsLi40+QANmZSCA
X-Gm-Message-State: AOJu0YyatM8pIP17asvwLnENlv87Q6L+CFAKN0rI8NJZ5aiAe2/25VAs
	RLlQPzrMYdRlUlGZOp6FbOKWFKCRTGrpuRv9W8LqK2VYmawb5Dhnajslq992xZg=
X-Google-Smtp-Source: AGHT+IGe3OBD6jM1gbubyykp+cGQaPSezSszLGkivme8anrlqDizpz6IK5FP+bm6bslTX2/dsmigLg==
X-Received: by 2002:a05:6a00:1144:b0:6ec:d972:c3d8 with SMTP id d2e1a72fcca58-6f4e02c6598mr16188054b3a.10.1715791766742;
        Wed, 15 May 2024 09:49:26 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d88sm11315503b3a.122.2024.05.15.09.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:49:26 -0700 (PDT)
Date: Wed, 15 May 2024 09:49:24 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <ZkTnlEnoFFrQdXi2@ghost>
References: <20240515-comic-sketch-3b40e6676f55@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-comic-sketch-3b40e6676f55@spud>

On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> helpers") added includes for the new vendor_extensions.h header in
> the T-Head and SiFive errata handling code but didn't do so for Andes,
> resulting in allmodconfig build issues when commit 589e2fc85850
> ("riscv: Convert xandespmu to use the vendor extension framework")
> added a user of a macro defined there.
> 
> Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2: Fixup commit references in the commit message
> 
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Charlie Jenkins <charlie@rivosinc.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/errata/andes/errata.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> index a5d96a7a4682..fc1a34faa5f3 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -17,6 +17,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
>  
>  #define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
>  #define ANDES_AX45MP_MIMPID		0x500UL
> -- 
> 2.43.0
> 

I was going to fix this in my next version but was waiting for the
reviews on the thead stuff. I wasn't anticipating these patches to be
able to jump the queue :)

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


