Return-Path: <linux-kernel+bounces-359167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38F998843
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A426B26561
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF21CC16D;
	Thu, 10 Oct 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrYedPSs"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744721C9DF3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568162; cv=none; b=V+ZyBs8LRhtTjFhMCNtMo0FCB0XZbOkHye06zN/1uGv+/EsjEV2m6asvCJPIDNOfijlC2bkBGwbkSp6QFpCKNjrtwS6RWvamjOz8ZvP8oaUfCqBPDfFAfKME4uBrE1MdhD4GZpeyBAwnbsNz939zezRbqQZtt/KZkeqogRatKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568162; c=relaxed/simple;
	bh=MkfzJPryuENSyvLa2fWlHXY7JSZm/ynNAd9cER+oGiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joqzPllWniu2POpt6pVWWm5hn2jlpxJTbGnnBcKzmpnfueY8BVe8Cf0vH9LPXyS0ND/oaL1hixFDg/AcZe8MXGBAU873Gy8X0Z8lEwheovq5AAn3xYbAfQgnthadY5aFqu+0BAkJNT7x3+vW167twV9LrYqZ/FHBBfBUDAAGUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrYedPSs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43058268d91so8654875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728568159; x=1729172959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVs/IOPgNM31y6y82QiYclQ6PlIE3YW8FKJDe7DuIfc=;
        b=NrYedPSszYcTF/lX9Ggg8P97HFVRoHeOLwcbclPABVKexpO5NP/g78xUfIdekNLoaN
         BQbAkhqoxbZBPSYWvAABThcgss3WQ2f8ODSJCFE/m4Yrf3hRp6d4/Cj0+JzbjHbZ7lFB
         8Rs+OuIYQxAFFFmrPxldGBmMZ4mkrqwk8wnvpl9hB+rcOb/cwG2Shn9iBZrxx74en3vY
         bfCkzMakg0N7Ox+6jOs9++mTloZCqLAv9jO45dgT19KBDuOqGoesFEyFrvsDgar1njwh
         KTXGgtzlWr2ctKHNk3rJzJgelq/4zHxh6cGDxZTpdH4wOE87G4aigl2oPFSByWHyYtqJ
         ZmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568159; x=1729172959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVs/IOPgNM31y6y82QiYclQ6PlIE3YW8FKJDe7DuIfc=;
        b=YLssP8uLLC3+Wbb7KQv5b7/3NsElDGzflmfpMWQcnVA/mndeELSm2bfwJAVvrva2hx
         s7pkqKTkYMif+KilzQTuydjo1KAZ3UbHWJ4cDT9qBGq7YT/IHBlK4zollCYBwxqxEI8B
         iYTTm0TDBD0flyn4GIC3uyBxD/E76WLFApHV0aJy0KU4m+kVH1TqtYMg5UOFyWqI+xqP
         4B/unMCi591q6ZY734ExE1lIDxj5fY3IdDjtGC3zKoUuoze8naK0HM+DbM0kJfPof5a2
         d2qO68qrSp8TsiurXR6pOkH22lQIvpHak9JvCbg2FlY9VOBP1zgBUfMdE07caNxKzccq
         ezjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfh2VrPBlDcCmQXZZAWzKNcAoXGlS1An+G6oDpVLYcbbTLeMwhFm5fRmgydiLWp0zOH9jqUlhB20ydrug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LqZubmVDTx+CczU8axYNjie5auLja0sRuhkXcPsAjfhaMVj7
	abDp0+RqecvKcbrAQvL7S0tSOfjwR4hielQLjjUwHuafpoHwN1WKxadOhJc1kd0=
X-Google-Smtp-Source: AGHT+IHjkW70IvZpZidBcOOO1FW1z74uz5tbvpksvMoBr6DAW85JUj00bLvuq5bdwty4viiClMPJXQ==
X-Received: by 2002:a05:600c:4ec9:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-430ccf2879cmr53610325e9.11.1728568158920;
        Thu, 10 Oct 2024 06:49:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm49649975e9.11.2024.10.10.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:49:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:49:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] octeontx2-af: Fix potential integer overflow on
 shift of a int
Message-ID: <15043c16-019e-40c3-874d-fb6d1392a9d7@stanley.mountain>
References: <20241010131122.751744-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010131122.751744-1-colin.i.king@gmail.com>

On Thu, Oct 10, 2024 at 02:11:22PM +0100, Colin Ian King wrote:
> The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
> arithmetic and then assigned to a 64 bit unsigned integer. In the case
> where the shift is 32 or more this can lead to an overflow. Avoid this
> by shifting using the BIT_ULL macro instead.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 82832a24fbd8..28f917a37acf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -2411,7 +2411,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
>  				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
>  		if (!(cfg & BIT_ULL(12)))
>  			continue;
> -		bmap |= (1 << i);
> +		bmap |= BIT_ULL(i);

There is a similar issue in the next loop.  Could you fix that as well?

regards,
dan carpenter



