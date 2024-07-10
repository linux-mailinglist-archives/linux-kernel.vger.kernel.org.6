Return-Path: <linux-kernel+bounces-247301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3992CDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3D1F26DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2017D344;
	Wed, 10 Jul 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7NGWvao"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231C17D341
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601975; cv=none; b=ZnIWHfeJVy3CyMXoQpJ2zuXBi7g4LaG5iJVmp0itzjUQH3WdQNvIZT5XiFCkCA37m7U5MxqQzBiZZSKRZ0EFlMDRV26VrOsHo0Iqx105nhNVhzKlV6pRWHEK1y73Hp5vgRRvmrUXaxa2rOI4G+0QhJ2Evet/fEebWrx0H8+VXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601975; c=relaxed/simple;
	bh=wsu5tc6BdVJCdLiq4ZS+eTjcl5TUiujEyzCku6yizhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6+Bvswp/UImZ+mX3jd7QTnl6D+AJ+/yFTB/IiUSlK/TrNPAB/1YWz2vnyygcE1wcuRQql17al9ktL620osMbJOunoPfvt6jrpdDKCIHjG/2RgdRQ2Kng5xJCmF4acBS+qgYwedG7zOmylQ6YS+hXVuCZ+u59x/0mzqSPwDPwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7NGWvao; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso7348977a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720601972; x=1721206772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AFgkrTsAbch65s0iFzsbxEhv7dvuaqj7iB6yNyk3Ig=;
        b=O7NGWvaoSRt6TItsvoOr/M7i8VSDxrAvlJwn/ozcMRJe74Pg4uQo/23yTsS93d6fwO
         R25YYoEhNGbx9b0rPAp1HGP/YWVEWowsCvOe9F8g/7CCdUHLwFP0WwAD4q2XjCzH9Hbl
         pAaVhdS+SriwLFBhRfIVMcSQPp1byeW8Y5po98sL1sUIWbbgaETPmUmekc0+5dFkrGtB
         P0EsxSYnxcoJOsJfrLZ7Xt2Zfku3bW1h+RgxnRvBXmGkE5A2s4sYpaWuxmwWD9WKQgea
         VHV3SoUwqaU3AOycqi3PBalnZvhVuzCD2Qf2z67Pcy1R1uc+BMVDx99bunj1qAmQ8i3B
         1cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601972; x=1721206772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AFgkrTsAbch65s0iFzsbxEhv7dvuaqj7iB6yNyk3Ig=;
        b=nrG5v7dNCBAWMaL7pk24Wl96MIgouAttEowY8HTZ6hHUEQjsvagjdi4Tx3nnK2oQ/R
         KCg+KiBlYeob/DWx7FOqKpO22Osgb8EsOHH8unmXTV6Z1JUbGgPKC3qWp450uFUY6GyQ
         uXsuVW6qcpvGDakXtQnQGzU8qtLjX9DjqTZbsuIGk5l0M5fr5EmTpNOmPug4SqfI3BtQ
         S6J8VU0QOWG5JM6AnQKzF0M1Bz8Yu2QJ+6fWEKR0l+yrjbjrHERrB3SEd9ukm4aQ0XcQ
         tZPePX537ksMzRpSHoqktX2VeE+lhJEATeb+ovoVxers0QqMkZRdUovCZog69Xc/8L2q
         +opg==
X-Forwarded-Encrypted: i=1; AJvYcCWvZTpK1oL1OdB5h+Ondxhem/Z0am0+sAX3aegZJCdEbNDpEwAFwBOR0fN4hQdzaTUcOJFLSYYm+ciJKWSTNnvWMqasId8JG4AEsV2i
X-Gm-Message-State: AOJu0YwfNaGYTVHB9zRYqC7qG0SLlfzWbtXL5p+jOsyRDV5SVKu8moA1
	rpqDdxT7176qMgvDAPZS813YZD/uXER7yfscDo951EY4kuo6fAs=
X-Google-Smtp-Source: AGHT+IHCzjHr6Syhg0aC064+TZHFvRek9NsnVb6QHpIQDonygpLufrewp4hvcMMBSM1RPvW2GL3vAw==
X-Received: by 2002:a17:907:720c:b0:a77:c5a5:f662 with SMTP id a640c23a62f3a-a780b68a9camr406398866b.12.1720601971601;
        Wed, 10 Jul 2024 01:59:31 -0700 (PDT)
Received: from localhost ([151.47.106.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a797ddb28ccsm27298466b.147.2024.07.10.01.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:59:31 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:59:29 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com
Subject: Re: [PATCH 3/6] sched_ext: Make @rf optional for
 dispatch_to_local_dsq()
Message-ID: <Zo5Ncd8DxGSVztoH@gpd>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-4-tj@kernel.org>

On Tue, Jul 09, 2024 at 11:21:09AM -1000, Tejun Heo wrote:
...
> @@ -2052,17 +2052,20 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
>  static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
>  				       struct rq *src_rq, struct rq *dst_rq)
>  {
> -	rq_unpin_lock(rq, rf);
> +	if (rf)
> +		rq_unpin_lock(rq, rf);
>  
>  	if (src_rq == dst_rq) {
>  		raw_spin_rq_unlock(rq);
>  		raw_spin_rq_lock(dst_rq);
>  	} else if (rq == src_rq) {
>  		double_lock_balance(rq, dst_rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);
>  	} else if (rq == dst_rq) {
>  		double_lock_balance(rq, src_rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);
>  	} else {
>  		raw_spin_rq_unlock(rq);
>  		double_rq_lock(src_rq, dst_rq);

Not a blocker, but would it make sense to provide some wrappers for
rq_unpin_lock() / rq_repin_lock() to simply return if rf == NULL?

Maybe it can help to make the code a bit more readable.

-Andrea

