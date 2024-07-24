Return-Path: <linux-kernel+bounces-261454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC6B93B793
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822DBB218B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C721662E7;
	Wed, 24 Jul 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzhFW1Nu"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EC4A39
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849446; cv=none; b=BpjzmfteBR3L/eOY4Q6Kb5Rh4FnZ8sBEXti19h3oGeN8IM2GyD56ArJJnefbrE7KSKf8Ar/Xk0TjyBTfF+Xs96NDonWhSDRLDETp1eTP9yFvMXY7+uFEJr65tLh5bfgBsFSL6rfFBwDMrBz/2GBoXVjX2240b2PUGEtWcaEYZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849446; c=relaxed/simple;
	bh=CwcrVl/60DWCLtqD/z90jzM81X9qJdKWNTrpQsA9+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhxsVgp8MUh9zkZqGuMw45WHAVYOt+hz75BpKA/5JlWVlV0dkLLfeLK3A1YUtPi5U33Tgg5f8SUi9OMjvtFM18wLVh7QiC8JIQ7Sg0tVNZhUvUDsFK/917IJxxlD/mZ8tEfSipyaGRIXqXF7Eh7sbDETtxHji4x3mSvMeaGgA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzhFW1Nu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a130ae7126so138796a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721849444; x=1722454244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4MvnsTGWo0THFyPD9MrsKyrQPqeYvDANUUTqm+As1o=;
        b=LzhFW1NuJ2YXOyL94ZXkrjJtyp7xDm8GrM1HjE9jUNhQPojYfgCjtoV1Uk1iUz9LHp
         TSKO/02X57AhCbwYAutZLwDI+yLAqjTaMTJbCtSl7l6FBenm8rraAT/CKRW1zHL1oQZi
         GKnzMpGfe36K86z2Y4ilArCkOCMYSFI1HAh9reDHmw21Yh7ZLQGGr9P9KG8+HZMEZ1DM
         bS+hU+RshRkmwkxXpxytG4ToRhIT4lg+/dounZhOyySBSLyp4TMIZl4lo68bwOg3G85b
         9/aiq+o5DA4oKXqohd7n0oidV3H4aHcpwB8oZR/ywQRAQimzciLpm5hfiaJyRO8Vg/oa
         4qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721849444; x=1722454244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4MvnsTGWo0THFyPD9MrsKyrQPqeYvDANUUTqm+As1o=;
        b=CRRQ9IrvxABQl6A0JWlT2DD00PyKFf2t9ZJTiufbjOb2ojg9HidyNGB3piBXexqtYk
         aOEZVLXbr3UQNu0/ZIgOLK7fbVTN2Eu9k5MOaS4/OqK/p+Cf8mWb0nvCupHow1Jq5OME
         5POGZ/Ez86jtHHeEASIm1F0n4gjx9x0oWMG6+jb/BPbQ+ljiW1dEban51qNMG0Lh4xRY
         Hyw46mrB60JUtNIAnaWR/v/QnI7Ntnk8JcrqPVY1v/Oh3r5XMCkXKKwE7kE2lyc2V8uP
         t6ssWtgXtquofO2fdriwavS0si3jwqdRbFDhsWYdcb/WIf/iGll6xzZ4Bum9DVE8aoy5
         rU5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3xtxIGY0iAgSHHv5ud7rdVk7IaVv0NkeVTZPhRNsmiF3gglK1UoqIjcB9xbTnP1v+dqNG8irJUHjOjVMq7fQRrq26903RUcYfygL3
X-Gm-Message-State: AOJu0YwlokwrpfEfkLqv2BlJetCblLEtNJ/71pk3kVB9WZ6EbmuP6BVs
	SQczc94uLDkvu/LtoYu8Ayk0FigmSKxnS0T4yaeo5QTYrUUmmG93
X-Google-Smtp-Source: AGHT+IGeMQuCgTIh3sLr3bbX2Tu5TYy4tqK2HRcEnZ6n/KheSClihGZCYHx0kW/iSQRWZ+Lsku7jpA==
X-Received: by 2002:a05:6a20:840d:b0:1c4:2469:f893 with SMTP id adf61e73a8af0-1c472c6d61dmr1229216637.46.1721849443832;
        Wed, 24 Jul 2024 12:30:43 -0700 (PDT)
Received: from localhost ([2804:2484:804c:b67b:f1b3:b8d7:cfb4:98a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1971a5bcsm6395578b3a.0.2024.07.24.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:30:43 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:30:39 -0300
From: "Ricardo B. Marliere" <rbmarliere@gmail.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, harry.wentland@amd.com, 
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	marcelomspessoto@gmail.com, aurabindo.pillai@amd.com, adnelson@amd.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/amd/display: Fix documentation warning for mpc.h
Message-ID: <qyoun6sfdpdxxzwystaimsiw3o33jwvoqxm3kpawczju2b3dl5@ytjpgyabbzet>
References: <20240724175423.18075-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724175423.18075-1-abhishektamboli9@gmail.com>

On 24 Jul 24 23:24, Abhishek Tamboli wrote:
> Fix documentation compile warning by adding description
> for program_3dlut_size function.
> 
> Remove the following warning:
> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1043: warning: Function parameter or struct member 'program_3dlut_size' not described in 'mpc_funcs'
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> index 40a9b3471208..615c69d966e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> @@ -1039,7 +1039,21 @@ struct mpc_funcs {
>  	*/
>  	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
>  			bool lut_bank_a, int mpcc_id);
> -	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
> +	/**
> +	 * @program_3dlut_size:
> +	 *
> +	 * Program 3D LUT size.
> +	 *
> +	 * Parameters:
> +	 * - [in/out] mpc - MPC context.
> +	 * - [in] is_17x17x17 - Boolean Flag.
> +	 * - [in] mpcc_id - MPCC physical instance.
> +	 *
> +	 * Return:
> +	 *
> +	 * void
> +	 */

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>


> +	 void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
>  };
>  
>  #endif
> -- 
> 2.34.1
> 

