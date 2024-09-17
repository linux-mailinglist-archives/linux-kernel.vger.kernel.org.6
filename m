Return-Path: <linux-kernel+bounces-331234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D420F97AA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1371C25ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89212B73;
	Tue, 17 Sep 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C3yQvM06"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842EA920
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726536581; cv=none; b=WoxKDWEcw6jtfFHnYpcoIbnL6HME9qfMj7MdYraPiYY71mO4jc2ezli9tg+Dz/0JTR9mLcEaPa6qGfXF6HM+cycP/AJeTJTgQfrf91bfbciL2Equ54K8V2XlZkdo/F8rMKUjo7Cb1mI3M+5xfXp3hp0YqCO3jTuaWeBRrxNrFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726536581; c=relaxed/simple;
	bh=g5Bra2qGdCGsEjC2FVx3BidNFBxk3XnjkbO7L8FfHcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx1kmFbZA0LS91LJXsRYUJh6m9ochA/II6OpXn9DuHo8XKS+9I7gHLhiDy6N4w3Ktjv1YuUc/VyoVAgw5nu7a/KRZcnhN8WiQTd9Kb1Woy/4n2OFYcwx9KuqFthroIJ0nLDoM7gc+MUWEFY6qQnznY8Kh7mPir/BUje5ZGtK0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C3yQvM06; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206b9455460so38802845ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726536579; x=1727141379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyryESalsOBTEC7e0+1MuyZ5bn07qCvw2uSmSNiGi+8=;
        b=C3yQvM06mO4Xh5FVcCdS51kyYjQPibI1H0B2kh2b+ACO6mBUjEbL4QuNDhyzhUtoMw
         2Llf0gXYm29e+DPPQKk/BaPJZlkcaps9nrMdj1+jzhpEV3wBcOZElsM2L7/xpTPJOy/i
         OjZKEcH+gNmw14oAIqZ4O4HHxXhPidCNYnJ8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726536579; x=1727141379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyryESalsOBTEC7e0+1MuyZ5bn07qCvw2uSmSNiGi+8=;
        b=cDT1G+LqW1g3AA4jOxXHpZsyUcobc1pgNmURySN0iwuVFgXorW/YsZykpnOjO0kQK3
         rIlNFY2kRPXbKEzuk+E/IYPsTH0jwmqjZuMNnCWOk24+fq1L2zUW2tAogIN5ZVUGJsvH
         ectUrbDyGuNlAsRh9p4jF36nYc4EDdKZWYb6y3KbEaehEk42mxc67mJrNIUMS1Y/mFc7
         KVZa3oL6/KsZH/e00UYMYQHkgzn6Bw47k9+RP/JfY1VkbSCpLfwCgv71GwqFYbqGgWRd
         MEwbFmZMCRP+99nypgvh7/d9oxWLyFoVWkm97c8o9WsBxe738Gr1+NTrPsSNvZDN7b4k
         LnIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZS9lhSyzmXWN/UISC2l4HwsqoO91HeyvTPuDDdMm8Fv+Yy+mMf9A9xs8s1bfv/kgAIqHiiEmZX+7QDgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4XT2Iaz/MMe6Sk6UJ/6euW/DDJzJZHvb59QRYMDVAYq0Yl8w
	m+OmW+ptq4UBFKPqj4hjFBpvf112ajWtHJ7Gf+obfUkqaVCo6JhX4I0kB7v/0SnaTqGbRm8m59T
	NbA==
X-Google-Smtp-Source: AGHT+IEx778E+TGOsLFbbFxBv0PXuKxhur4NRHwyUB6xd3ThFU59z9YcB+KXOekm9TN6wQtQQkLYnA==
X-Received: by 2002:a17:902:cec8:b0:205:841d:1221 with SMTP id d9443c01a7336-2076e5f7f44mr294804065ad.24.1726536578911;
        Mon, 16 Sep 2024 18:29:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731a30sm41953415ad.268.2024.09.16.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:29:38 -0700 (PDT)
Date: Tue, 17 Sep 2024 10:29:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: free secondary algorithms names
Message-ID: <20240917012935.GE2413563@google.com>
References: <20240911025600.3681789-1-senozhatsky@chromium.org>
 <20240916074423.36ec570115c556ff0ab78425@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916074423.36ec570115c556ff0ab78425@linux-foundation.org>

On (24/09/16 07:44), Andrew Morton wrote:
> On Wed, 11 Sep 2024 11:54:56 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2115,6 +2115,13 @@ static void zram_destroy_comps(struct zram *zram)
> >  		zram->num_active_comps--;
> >  	}
> >  
> > +	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > +		if (!zram->comp_algs[prio])
> > +			continue;
> 
> We'll probably get emails telling us that this test-for-null is unneeded...

Agreed, I also thought about this, let me do v2 quickly.

