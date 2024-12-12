Return-Path: <linux-kernel+bounces-442992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022869EE51D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF22166D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794A20E02D;
	Thu, 12 Dec 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALBAcTv6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAC1F0E57
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003205; cv=none; b=gdrLP8kJjoMy6b2OsQfyvJx6nJB0Z4O5jxcFI+tU4xa9NKi+hC1o1ih0hGffl0Tih1TN/zE37H+kY4Rw/vAR1sjv1sfxHiNcVraNq5icTUemB0kEGcmKQBh2sTQfOnc9bZRTDXWQiVmu1gnFkV0iqsz5kER8HHzOOLvisKDW+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003205; c=relaxed/simple;
	bh=G6qeZL6zC4j3j8VIBGH88kPG1jhUAIZKaaTLasnNDY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCpT03VQYBU/n/uaYCtPMeR2Q5WdazKeWxbLmXkyPkku+q0Ab7NHu28h+MCd/44oLVfee+VO4GH6cVlYajuc7/GeiJjwt3ayiin7CuzwjfeZbEUwlzh8AQINBF+lpJlbGoZtfeKVyCBianYaQ2S/ISEwZinlV/7jONberhMWE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALBAcTv6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f796586so5495905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734003202; x=1734608002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5a+MQf0Hip9QArkqxNik21FxUn3e2NhEp21qq8cqaU=;
        b=ALBAcTv6aK3TxVRX9rz6e9R1b7GKP0hD6hxxohvkW24XI6A0UZKTC2cJsLBGRwB0k/
         qjj/0C5BIN2+f68whLY1VNXgYFt/aR67Xb+19YRHiTVN6Q8YsizDz1xTusFd0GxnCjvM
         TY/1H0EgXXCcOC9VmA07sihTCtIbZknekMyQZ2vYGWjAy1VwsnJ9DHlT5Dfjf69Do/4d
         XQNldDlQ1d1ockvFU4p1K9zu0ZFuZloy8nbeNeqZGilrHGrBqn47PJtSXBn18QFK4wG0
         o4WOyV2TC3rKsywBfTqOfNbkrld6I7tnjVX1kcfZVc+c3LX1d3XxAiR3NczlGv8YXbPt
         iFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003202; x=1734608002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5a+MQf0Hip9QArkqxNik21FxUn3e2NhEp21qq8cqaU=;
        b=ooPynACItuoMR2YgBJ4aF7kdBeIoko4ZwRvZBJZUX0lELFtgI54y6CG14hRdNIm/Kn
         5u7dEzjDkbfCKjx1ue0eZSVYcVLTEm6Vx9aQ4pEA6uQKjwnC48JGJRHhOCs6Nxak+r/c
         s4AkdN91c1W3mnWNtociUn201tlBIHrzL/PEu+iaJroqygKIE+jU4h4k1xRxMGW8N9AI
         uOKwq7Hp9yEIBkn3XMqrBF1tDTbl+ty6iQuHyavbd1Bv168zYsDQpqaZH2DbKifLua7h
         5l0gHQ4tU0+dxug9k3jbyWGwDz1cjsXb7R+4a/p7Svq/mXDc6VkXgszhmUlit5/WsMb9
         idcg==
X-Forwarded-Encrypted: i=1; AJvYcCU/f71/hxmhtN/yaMq3db+R8e2p03xvU41VTdV8Mo3T7pXDhskd234C2md1tdQjT2CuZAdGJPb4r92UlhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FaQsoo5+Ah90XLNbIflmcZk8qpfoCD8Tv2e2fRNix5chh8zG
	h7UidMlGLpPP3oS3EmUiwo2tFagp8GXCzylgyzDMt2duvSfh2LYul/mqx0uvIw==
X-Gm-Gg: ASbGnctUe1jqRvzJWa/Lgy7KsmlVtY+0lnkADVrmXt+Izd48vgq2+yKI3LNQt/C3Qy4
	aZpzB3CzRqtGyrLVII9sTcpj53qoDunUbTMA7FxLr0Q2aObTGN20K9d4fbEs2BvRPLHB9sxf0ud
	vhfdLZPi32HDqeEvzmP0eZhGz4gHHIfupOkuGe3HAbwaAMv3MSl+1PAd2w0GU7EH/p3bhzcbdib
	tT8rzx7dRVJ+GcsPWvIMYPVcLhVJlpTmM2z2M0rQ4wINeudHD3e9RLY6RNpy28InpbAuCziuTVD
	+537ZVx8EiWldfE=
X-Google-Smtp-Source: AGHT+IFftUzg2KTR00FQjwA57ZaLYqw/4a8Hb6V4ISjZn49Uf12Ozmj8QlHhzs/NZ8VdbA1gsYccMg==
X-Received: by 2002:a5d:64e5:0:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-3864cec7614mr5970842f8f.46.1734003201711;
        Thu, 12 Dec 2024 03:33:21 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699487854sm470265966b.13.2024.12.12.03.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:33:21 -0800 (PST)
Date: Thu, 12 Dec 2024 11:33:17 +0000
From: Quentin Perret <qperret@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 4/6] arm64/kvm: Avoid invalid physical addresses to
 signal owner updates
Message-ID: <Z1rJ_dMJJzGOmjNs@google.com>
References: <20241212081841.2168124-8-ardb+git@google.com>
 <20241212081841.2168124-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212081841.2168124-12-ardb+git@google.com>

On Thursday 12 Dec 2024 at 09:18:46 (+0100), Ard Biesheuvel wrote:
> @@ -908,6 +892,9 @@ static bool stage2_leaf_mapping_allowed(const struct kvm_pgtable_visit_ctx *ctx,
>  	if (data->force_pte && ctx->level < KVM_PGTABLE_LAST_LEVEL)
>  		return false;
>  
> +	if (data->annotation && ctx->level == KVM_PGTABLE_LAST_LEVEL)
> +		return true;
> +

I don't think it's a problem, but what's the rationale for checking
ctx->level here? The data->force_pte logic should already do this for us
and be somewhat orthogonal to data->annotation, no?

Either way, the patch looks good to me

  Reviewed-by: Quentin Perret <qperret@google.com>

Cheers,
Quentin

>  	return kvm_block_mapping_supported(ctx, phys);
>  }

