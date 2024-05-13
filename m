Return-Path: <linux-kernel+bounces-177886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9B8C45D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9917E282D82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623A208A4;
	Mon, 13 May 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQDG2H6E"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188B1CFB9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620642; cv=none; b=W0keIppSwVHXwlnp7zzmAPls4mKcwMgfAPrpkJwrIcSRWiKYhXjkd+0QGb5IFm+AgTh5U2GMU5s87gLIym9G+qbtnhhiqLxwaxRwBtv+HwFj8nCo7jj3fq8qQ4bNxDMtij90eXtS3ghMVhGC/GMlV6OiXC7GApdwm1WFfSd6He8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620642; c=relaxed/simple;
	bh=xQY5i2QiuMX6Yd+fUV1fPNOF+4MpIZNtds3mU2fDFYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC744dNsSjMCUfuNlPVdZgtKmSJ1tjNWdNH/zEFoKy6H5V/mnGZrG2ftYdZxNRs6ECIUyEvjRxveMm0PZyl9KfdA8hDE2DFrJOixvMmQB8w/l6/mWLpt63hEn+gAmmQQ3Ze75RPRu/goX18tfcj8IPR8ChRfDJzUptXyRCEEAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQDG2H6E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so4149127b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715620640; x=1716225440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFbtklN6bv/SjrNyXTAYrkJHqYJqOPRagVWR/OgeVt4=;
        b=RQDG2H6EP/N7pND6PmB/tusFAEpGqZ9gBCfpNA9pqufG8AZ/Igp8r6b4/idFJJXsYW
         1lrfuuFvROR6yGdcMiQK2xn9WPbn7NqURMSGC65uGJEsRbwBHfWjd7Hpygu3t4FWth87
         oDmSTsQEozyanq6mCrmr29YkC3yXsMIun1Tpj3mQFXYkNl50Y1XvdNqixLzMxP/GJQo8
         n1qHMn43eJG0RRzPN6XLfRxyxJKHJ8ZtFcRncNbVExKNFUGqpr3DCA20Bzfi+QVbXBuq
         z9BrQ5ivq0Vvp0w1P2ZHCpw4lE2jD9hkVrtQZOAQFmIW3kmfhU4uFjzX5NmBYySWDton
         bZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620640; x=1716225440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFbtklN6bv/SjrNyXTAYrkJHqYJqOPRagVWR/OgeVt4=;
        b=AUOJYJ1fUtdjDBSvrY+JoN9FfyQyuxRvzYMpNy8JfNbaBZIUnmuXmbN0qQjEGdXG9z
         m5D63h00AAXkVFqnYb5LFGWNHPNwkmuoT9EO5RYYrJ6PplULTKHbVda+fNucf6I/Aq3F
         gmLu/G0Klvbr8kTYhHGEKQRNOkJWW/XEo8iy/PhUbkqss2A4t7f1dFSrmpNQqkuN9r04
         B5XA2rSyO9hD6lC5Ia1OdTSWFj1mHbsstiSHQ8x+z35mhRBADWgHDhqtjmCTtxIjHubU
         jcJeJPJVL7AcGJItY1rYDFQ1zxsbiCQwPVFhQlPPw3ziScb7JJLugO1UbeTYhQusbnX1
         Ou/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtxr5P+WCIGHofOOIGFKBUSNYva+7ob0RBD7XJ70rSbxKUJukoHL0+FJJttsZgiaMbybJbOsMpd442OauY90jNTYJ1HIMD95fPRPoo
X-Gm-Message-State: AOJu0YzEWFRHfm/4CpfNA5yaBea0hWolNWAKNcgZOm0qbKbA6pEUayQ+
	LHLAIBp0BHAwq4IW8o2TjPrWyQciBXMxGi4I9/BoJcZXELUzB6VI
X-Google-Smtp-Source: AGHT+IFsbReIv9pnHsCWfpxdQj1RPZoYYjUBmcEqU6qvPmUoCt1Y2kVaLDhkf8vYLiORfaajL9tSlg==
X-Received: by 2002:a17:90a:4307:b0:2b5:4ee8:e5e8 with SMTP id 98e67ed59e1d1-2b6cc758bb5mr8365530a91.16.1715620640187;
        Mon, 13 May 2024 10:17:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b695f8d058sm7231660a91.2.2024.05.13.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:17:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 May 2024 07:17:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao22@gmail.com>,
	neelx@redhat.com
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Message-ID: <ZkJLHtiGb6XM4iMO@slm.duckdns.org>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>

Hello

On Sat, May 11, 2024 at 03:15:11PM +0100, Aaron Tomlin wrote:
> > @@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
> >  		return ret;
> >  	}
> >  
> > +	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);

Can you please address the testbot reported warning?

> >  	wq->rescuer = rescuer;
> >  	if (wq->flags & WQ_UNBOUND)
> >  		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
> > @@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
> >  						  worker->desc);
> >  			}
> >  			raw_spin_unlock_irq(&pool->lock);
> > +		} else if (worker->desc[0] != '\0') {
> > +			scnprintf(buf + off, size - off, "-%s", worker->desc);
> >  		}
> >  	}
> >  
> > -- 
> 
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

The patch looks fine to me otherwise.

Thanks.

-- 
tejun

