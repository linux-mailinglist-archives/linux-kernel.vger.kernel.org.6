Return-Path: <linux-kernel+bounces-423863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D99DAD99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF6165ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D88200B95;
	Wed, 27 Nov 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KA5QcZl8"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045D83A17
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735118; cv=none; b=fCs1doyaqDRSgujYMNo+tIUwX6BPWN4N93/AENfwQlluMkFCDmLmZts6a2bsSWAV+HmKS5X2ZVAH5VhMBh7q+LSNZvsaqC/LGN+HF242TPYtbZeMlNnGPwAuM0cLJRkrI46sw3Yx12sb5m8gHtfOJEILHEiSwNsYMUDRgEEK6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735118; c=relaxed/simple;
	bh=H8kTvabrePo63QyDbEsAGRelBz7E4ZozgtD6YyY+PaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/TumoKz/RSOu3y6r3Enb6ftTcVp5KBeIecVPbJI+et9yGK1QHlKizpLeKpc1+mrkqd8vemmcXnSSkB4qrHsmBsKskLI3wGAIagt5oSIBsAjNRDSxcC4jbOLDd6OtyBfllPB5YxEaSsVjApu6cnQYWTRoAj7CeUz7CvvwCrLBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KA5QcZl8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so102846a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732735116; x=1733339916; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vB7+zX/eMQEZVkQdJuvLGtE/WTXbmTPbcZWyGfuE/hw=;
        b=KA5QcZl84HC1g0pce6mwasvAvP4IOjHgWEa49Ksly1Lvy3GWmNmusH03JucS6BylT+
         Ckc9kv4as7FETCcV5WOSg/94C5q6ju+p6sZc/eqRbkALc9sfYKBsbCtmdeKo5gCK2ilK
         yGqeiccU7X/XnhrF0+drEJRpEFguCceZKco2dcpP7iyVUSOyqKa6Ekb8PhBpU+9F/Kzy
         0aaqXT0rEEvV1NJG+GQiG5HJxFy25/n07kMKcaF4CcNCSzlP/PGC3Q9YJmrckVHNdrNW
         E9HUjG2OUndDnUZ1byEMJBkiePM3gJ05VIzEokRNrT+FrB3W+kVZHpl67g8c5wwT5Ree
         06yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732735116; x=1733339916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB7+zX/eMQEZVkQdJuvLGtE/WTXbmTPbcZWyGfuE/hw=;
        b=nUlPGnaNWj1u7SKuc/t7QfJLlljIMlX2LNbiYte5TIJNY2LCj9TdgC/SzWfMt+2XIN
         qxxsleGAA8zhR5cX+PnyMhCxsrWN8ssPdH9KgKcHoPW23CLIMxo4TdkuwOL1c4vxKubo
         4vcetSc73KxK5zZN9+g96uq0aSq0O900JM+V1gtIqdq91pnjWZEMWBkgcDHyzp4pXE97
         oTORfzkrgiEYCE3VzjqkWBaWDwQ4utSlQX+sQVuHoS0biQ0jNdzYkrJWWlEmUEGPrDdQ
         922TPhKXTWEcFUdx2TGgZ7KM9DX8MSrZG+JuUAH01XEp+TnAb2rHkrLRUp/ukhcKULoR
         SBXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmfQty9mA1HfPFg+oSaHqDKZfy+c07WgeVpYfQjozqO+RAe6qeJrHMWdpCU6jRVUV7F4BN10UoP/065Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oCQVsDMWkjlpmDJs3CBjlnXyC/CmxPlRLptDhoq0gGdKJMoq
	qayi5C7UBdPOstJDYqZ90CjAgHG77NY7wec56YSRZQR8p59TRkufCHAC82O0CaMSuvzCj8RJqbi
	X
X-Gm-Gg: ASbGncsWvEWdox+AULx5NgTry8apu6Y6oVjXejsfQfGlrDVVOSdl39nNtRiUMCcd14y
	P29janjGrzZsIetlGdjrc9qdks/HjUdSZ6aTkX45eh399nRMUZSqlUjBzYDuv+U2wIhiL22L7Kn
	dgqYsmloRQ1fRCVDAImm0qbpTJxZwjVMh2hHDbJ57an0rre5jATgMhMWla6IxojvkXMQftjlJQa
	Vf5wHUaQmQK8EwqazFvMgG8KSR2xgEtIpJrRihUFhA=
X-Google-Smtp-Source: AGHT+IGwVibQFz/HfTnBYJFj3BlQooBTbScjEPx6pkFCrKgYZmTcrR9P+ao05cm4glAwREsdCh+uFQ==
X-Received: by 2002:a17:90b:4d0d:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-2ee08e9bd21mr5224356a91.1.1732735115685;
        Wed, 27 Nov 2024 11:18:35 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:1259:e59d:e348:e0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa33374sm1960698a91.4.2024.11.27.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 11:18:35 -0800 (PST)
Date: Wed, 27 Nov 2024 11:18:32 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Kai Zhang <zhangkai@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: module: use a plain variable for list_head
 instead of a pointer
Message-ID: <Z0dwiIUThatX1H_X@ghost>
References: <20241127142519.3038691-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127142519.3038691-1-cleger@rivosinc.com>

On Wed, Nov 27, 2024 at 03:25:17PM +0100, Clément Léger wrote:
> rel_head's list_head member, rel_entry, doesn't need to be allocated,
> its storage can just be part of the allocated rel_head. Remove the
> pointer which allows to get rid of the allocation as well as an existing
> memory leak found by Kai Zang using kmemleak.
> 
> Reported-by: Kai Zhang <zhangkai@iscas.ac.cn>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks for looking into this!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> V2:
>  - Add Kai Reported-by
>  - Reword the commit description (Andrew)
> 
> ---
>  arch/riscv/kernel/module.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 1cd461f3d872..47d0ebeec93c 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -23,7 +23,7 @@ struct used_bucket {
>  
>  struct relocation_head {
>  	struct hlist_node node;
> -	struct list_head *rel_entry;
> +	struct list_head rel_entry;
>  	void *location;
>  };
>  
> @@ -634,7 +634,7 @@ process_accumulated_relocations(struct module *me,
>  			location = rel_head_iter->location;
>  			list_for_each_entry_safe(rel_entry_iter,
>  						 rel_entry_iter_tmp,
> -						 rel_head_iter->rel_entry,
> +						 &rel_head_iter->rel_entry,
>  						 head) {
>  				curr_type = rel_entry_iter->type;
>  				reloc_handlers[curr_type].reloc_handler(
> @@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  			return -ENOMEM;
>  		}
>  
> -		rel_head->rel_entry =
> -			kmalloc(sizeof(struct list_head), GFP_KERNEL);
> -
> -		if (!rel_head->rel_entry) {
> -			kfree(entry);
> -			kfree(rel_head);
> -			return -ENOMEM;
> -		}
> -
> -		INIT_LIST_HEAD(rel_head->rel_entry);
> +		INIT_LIST_HEAD(&rel_head->rel_entry);
>  		rel_head->location = location;
>  		INIT_HLIST_NODE(&rel_head->node);
>  		if (!current_head->first) {
> @@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  
>  			if (!bucket) {
>  				kfree(entry);
> -				kfree(rel_head->rel_entry);
>  				kfree(rel_head);
>  				return -ENOMEM;
>  			}
> @@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>  	}
>  
>  	/* Add relocation to head of discovered rel_head */
> -	list_add_tail(&entry->head, rel_head->rel_entry);
> +	list_add_tail(&entry->head, &rel_head->rel_entry);
>  
>  	return 0;
>  }
> -- 
> 2.45.2
> 

