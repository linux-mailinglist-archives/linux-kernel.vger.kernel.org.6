Return-Path: <linux-kernel+bounces-565722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE7EA66E12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6A916C9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7C1EF374;
	Tue, 18 Mar 2025 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KJWjg8Vh"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736D7346F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286216; cv=none; b=YIoy0fVw2itsnUmf5VvQJnPDUa7hSURQ/m1RoccaBhVqgBrJF1BpMZEfPWjyCgOiR66U1pPqy11hIwb3phmIvitEzXa8VvG9BRF1KPK6CUA9vzWPXOnDRLZO4UVhwacirpFlwpc+gZdYUqtA2k8HJ/0SFPcXgAqqMMkn/fmx/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286216; c=relaxed/simple;
	bh=65aJItAncUqatml7wHLt+LFovXrHvhZaAuunh9n5Fb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDUyDLEqMhdbdB/kYvZKk4YFpGtxhowv2YeQI3qVZKQLrS9SxE9sOdT8pBCQbBtaM827wqa3A6V0psenloOtJ6QRfgtrTmQyGBCYJZJDIqlce9dx3dIUSa46n4TwHJntX9OWwFImjQSx2+Bymh7kqMrffm7ZzqWR26M6qQP02U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KJWjg8Vh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso13972545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742286212; x=1742891012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ksPPSN/t3ENipy0fSK71/AaUjxYWBEmqhNa80UkzEw=;
        b=KJWjg8VhJWMhgAQsBJV1TTuA9AJzPs7w4p6NZT5oZNm3prgSqHPVn7wcX3vxBXC6S+
         Xmf2CYZIUEDddrEn+JBg1/Pc5NVahOxZVBLdXbHV/oaE6Czi8auHksO5XvCmSIvaV2Yt
         ANbtnI2tCbNrS6n4i9QJuFRyJ1M+7kBWo3iV7H0/tqjBn396CKxbrt435p79+ZkULkSs
         mmq4LfupxF8El5CesEAkWiSdzq3nU2Wn8xjaieKn9ZoDJdIpaX+gwTh4gdkg1UVg23YN
         osQsZhEpQ89Rcfb/E+7DqcPxhSriczyGG38DdjsYhAGN8GWNmyYixvV6JoN1BhnZ0kEw
         9Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742286212; x=1742891012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ksPPSN/t3ENipy0fSK71/AaUjxYWBEmqhNa80UkzEw=;
        b=dlU+pijueQ3mS4zVBSP4p8F7ewVw+bhtcpS6yroTv6w9UdUsfHJ/G/xzT0C/z3/gbM
         zoW54QQ+OlUYdd2bVACXN1Wm+r9B24a/a4cBbyz3et2etaqxLQ5voOfPs+/fpalCGpm3
         F7xsLustWK+XtnbGA4BqW+U8Im57kLBg+gDnx1vQQI9lRMJAx9DLTVUIcMa8cY5r/X/r
         t6XZeKi+EZtVWpyz9aAdw1UYr1nb51bmfeQXwtoKOhLf5DS9zoUWbOUTQ505jeAptxzc
         J08ofO8/ZBNY+hlb6xMsQSf8QAwHuFAOGxm68m/YHuskd36ccJfcbNg02LHecJqL0e4v
         t4sw==
X-Gm-Message-State: AOJu0YyBzqiW7SAuQDPyFabm/okKkLOHHqOy/aOnJs9qiTddwaurhFuf
	KiPmFsZkUk/INYopHLDYfKyPp9yLNKauyFx9o56aE3qdMX3sCrWK/KHqhIgR4YI=
X-Gm-Gg: ASbGnctCC6mQk0qauFhnBR7jLkfUmCfm2N2TkTaU0NWLXpPMA1Q1NZx5nVn+Gx753+z
	8OWxqMBDAVxHNFFV8dgwg8ArJPRgXzi5jys/RC97xsH3jRXmld2am3MJsUjtaO9VeoisMKhl2i7
	OLQllBrZ5f8LspHDww0Crnqj2szlkOalfGOIEnMYayRtvBdigWbPEQuH3dtetlGl2iRNFP6P9rn
	5AwdTb7zx11U2vNBHCHjx/lRbw/hFVhGkRua/+eju2s33mD9GukU9GxfIyZn6R1+WIwlZjMQk5D
	eFqzMRkXDuS6tBtAzlpaDsbDqLEhM4L9fUYJGXSh81md18X9JxIsSSMX/w==
X-Google-Smtp-Source: AGHT+IG9nVEC/rbpi29dQAAbskIxW5Ckh4S813VmV2TTyHn1/qASg31PSbSDt242CEBwQxUG+srOXQ==
X-Received: by 2002:a05:600c:1907:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-43d3b9d27aemr6560615e9.22.1742286212383;
        Tue, 18 Mar 2025 01:23:32 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3996d998545sm1220961f8f.34.2025.03.18.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:23:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:23:30 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] fork: Use __vmalloc_node() for stack allocation
Message-ID: <Z9ktgl8kVHGQ4FLH@tiehlicka>
References: <20250317163614.166502-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317163614.166502-1-urezki@gmail.com>

On Mon 17-03-25 17:36:14, Uladzislau Rezki wrote:
> Replace __vmalloc_node_range() by the __vmalloc_node() function.
> The last variant requires less parameters and it uses exactly the
> same arguments which are partly now hidden inside __vmalloc_node()
> function.
> 
> This change does not change any functionality. It makes the code
> a bit simpler.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/fork.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2fa2a3582925..72d9e7c7639e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -311,11 +311,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  	 * so memcg accounting is performed manually on assigning/releasing
>  	 * stacks to tasks. Drop __GFP_ACCOUNT.
>  	 */
> -	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> -				     VMALLOC_START, VMALLOC_END,
> +	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
>  				     THREADINFO_GFP & ~__GFP_ACCOUNT,
> -				     PAGE_KERNEL,
> -				     0, node, __builtin_return_address(0));
> +				     node, __builtin_return_address(0));
>  	if (!stack)
>  		return -ENOMEM;
>  
> -- 
> 2.39.5
> 

-- 
Michal Hocko
SUSE Labs

