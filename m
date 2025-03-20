Return-Path: <linux-kernel+bounces-570310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE9A6AEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE03B7DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AE227EBD;
	Thu, 20 Mar 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNXnC/Mj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9791E5B7E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499672; cv=none; b=o6hzByGi8cGmdmKdLWu8z57Co66COe4qyt6qehhffXwZ6z7n13+Kq1baPMyIRsQ95dIhrubgZ3lDm0Smgd0aewYYyDDU+w3jheEjbrE95+Z97+4M3cXCEOpcf10E0g+FfxtptAUuHeDGmT4/iKLQKYyITuK2JFuuGXuOlfoDFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499672; c=relaxed/simple;
	bh=wvQxy7EYplUISZ0w1bmP0u/Y9bJXMJJWRo6e/ddO4pc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FVeITYTUxwReSW02uYSKENfg42lmEN+Ip3MzQ8P4C9tc0fp1hft2v/IDMI56CX6MMTK0oEwIwaUDWoOkkgJ9FKoIzZbzg3jqua5dGHgGCJcxWlb1SY+I8832+iw2DbeJDlmWNeapvPygMvic4IV5ZEPlIgZEKLrqQdBUTiowNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNXnC/Mj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742499669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuxXqw6GD7Luri3ii6782mBHPFKtCRI2jJ0fXlHMP6E=;
	b=GNXnC/MjCRjbhDH9UqEAYHO9xk30KNBRNpdxEcJI0UEwGDXsJFQQieVhHA6uzSsRawjylw
	Vfr+pH7eVRLsYaP7kCn7EH8lEaAoPAmgS+/ERXR9KwD4I88K6rP02qchdIqlxoyjRDmdVA
	ctDZO9yFqPJGt44eG/OmZ7oCwQDxM9Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-d5RK13jOMQ-k6h-jy3_diw-1; Thu, 20 Mar 2025 15:41:08 -0400
X-MC-Unique: d5RK13jOMQ-k6h-jy3_diw-1
X-Mimecast-MFC-AGG-ID: d5RK13jOMQ-k6h-jy3_diw_1742499667
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f64eb467so10307856d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499667; x=1743104467;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuxXqw6GD7Luri3ii6782mBHPFKtCRI2jJ0fXlHMP6E=;
        b=N64lttQw3i22AEZuhz97/ge0BtIot9SevfSFsC0gM35v2FbpRuAEQbmc3HQObgZJic
         PD+Ybr6Ys0g3PB5DybsJubYVrZMzMs+8ym5ZWzuvAghgH1kik0MWh8WjQxIHwnH1Tmg/
         Paayo40OytT8UVLwO08DB87Iac60MSSNnVWVudbpCaiGIf5wqPYygs9pazFEkWnZSRK7
         SUgqLg0n4NcJEMvdP0c1l+XLCDPJ+9vAO7q4S2k0XWbb9p96R2Wns0UhycERtGP6Jcff
         w10P2Yl1U4bZ1UwglQyawTfmkFH8h3TvVzd4I1b0A7nCDNFEBxi3CQtbIMdDd/T9I4Nj
         /HTw==
X-Forwarded-Encrypted: i=1; AJvYcCXlGEXgsBS8yy1DtgVJXGL5fO5lsGbjv18aVSryD1WMSFG6XY6n3xei3XZiwaaFzdaQPaGdvfUrtp2P8sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/oS2Ibk+uATvl2o1oU13KtjHU1N3z7s8KYU8q0T92JoKNu9K
	ENSJte9CpSQTsR4A4LPV5WYr4FDrUrnCC/BY6PNWe3DTPDahSLnjiDws8N2Ln/Es6nlgsOvrGTL
	vHJSSA7cmuY4yvAdqFWF7qB1TLu2BR65yBRyyX1x5/JHizBe4CQiWORR0PBoBFRy5klXaVw==
X-Gm-Gg: ASbGnctVM+VUlp02pBhT6cd1/RGJx6NyjusQ8Yf/p9fFV8a+mfe3dP0GObeYTF7WMeL
	SZfHdN0lA5N+XO3rgxjccAcnmySNJie2Uben0zVzE2cMaLrZlR1l7KGTPa3iwh6qYhwWktvqant
	f62lHHKEmoodJPNr5dZKHCK9maJxlVsumLiCHMgdipjd8B5LR4o5+8Mo4KgtdzB67+hZtPQ99IR
	ELcADDh1Ku2NZxlAvF81GyfPMoVWjAH71TXFEs3vkwkYUbtd5f7y6uM11YGVCU91n0lwvfykOru
X-Received: by 2002:ad4:5ded:0:b0:6e8:fcc6:35b6 with SMTP id 6a1803df08f44-6eb3f275e0amr8278156d6.2.1742499667153;
        Thu, 20 Mar 2025 12:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxgR5kEC/tNHdZ06VV6oGL8c8ichrEbJIpBzq1A+tGZpLER6gVnAF2uploqeF0gS5LehZNxw==
X-Received: by 2002:ad4:5ded:0:b0:6e8:fcc6:35b6 with SMTP id 6a1803df08f44-6eb3f275e0amr8277746d6.2.1742499666574;
        Thu, 20 Mar 2025 12:41:06 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ecf9sm1976856d6.14.2025.03.20.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:41:06 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:40:55 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 3/6] rtla/osnoise: Set OSNOISE_WORKLOAD to true
In-Reply-To: <20250320092500.101385-4-tglozar@redhat.com>
Message-ID: <d55ba3cd-2de5-7520-a0b2-e5bcb6bad235@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-4-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> If running rtla osnoise with NO_OSNOISE_WORKLOAD, it reports no samples:
> 
> $ echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
> $ rtla osnoise hist -d 10s
> Index
> over: 0
> count: 0
> min: 0
> avg: 0
> max: 0
> 
> This situation can also happen when running rtla-osnoise after an
> improperly exited rtla-timerlat run.
> 
> Set OSNOISE_WORKLOAD in rtla-osnoise, too, similarly to what we
> already did for timerlat in commit 217f0b1e990e ("rtla/timerlat_top: Set
> OSNOISE_WORKLOAD for kernel threads") and commit d8d866171a41
> ("rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads").
> 
> Note that there is no user workload mode for rtla-osnoise yet, so
> OSNOISE_WORKLOAD is always set to true.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index 1735a36466c4..a71618d876e9 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -1187,6 +1187,12 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  		auto_house_keeping(&params->monitored_cpus);
>  	}
>  
> +	retval = osnoise_set_workload(tool->context, true);
> +	if (retval < -1) {
> +		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
> +		goto out_err;
> +	}
> +
>  	return 0;
>  
>  out_err:
> -- 
> 2.48.1
> 
> 
> 
Reviewed-by: John Kacur <jkacur@redhat.com>


