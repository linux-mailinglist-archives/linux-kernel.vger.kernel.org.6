Return-Path: <linux-kernel+bounces-344150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7398A56F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D4E1F25C28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7E18F2FD;
	Mon, 30 Sep 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V+2xNaGg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79F2AE8E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703532; cv=none; b=PC769/jzz2ziE/ZeuV+xm9n3xZJ3ByyCKgU40mlgn3sO7PxANAyT8sCxzaNcCsreqsOvB7UVUazt6LDDBZmwjyNDRHc7ppB3eDvZD2QN2TT2hVhS3dDlKd756DbZLT/Jjez0/2yOODsfRh24W9wu+5VF59knnrGdJ9L7d4mXkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703532; c=relaxed/simple;
	bh=TZ7/jgwcXpRcsdAwMW9ewmGuXzJP8KTXecY527RD8Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIG3eMCYb+O7nT7OrSuxVVjNCgReQF8/Cn13YtXwjdlHRfrQsFJ0EBUYBd7DTl3hml37q3PnZGVwtfzm5fn3QDaBUkO9GqmNBLHLkOPJIRlSEy4KwCNO9/kTO7U5N4dK2ilE6Y3Xh7cGq0qgzIkm9J7DHgbyTGHmO/f978KMJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V+2xNaGg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4979b843so641263666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727703529; x=1728308329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MPniYXfYKgln6nb/HfyU4HnTcRjrBrRpvvr6Y9lixw=;
        b=V+2xNaGgmc7t/h/wexhHBDapiVM4unU1UVLSZE8Y+kuKpZxqHs5oDy2HsVvB8guESw
         HBLHbBoWW3QeZ9IKuhNn48PDT4kLceOHJBhAhqrOkhUJnlIXKpngEvijxVgxm+9Rdoo6
         mTXrBF0x1Ib4UftCIKcmuGSMbbjaB3x+WUguXDl7Ibi/v/4skBXMyV3Mkx0O3GaDa7MR
         4JbXYcI2E92IOuc1Ve92AFW+Gu6PXtG7KHCdcn9dYM00s/uf3kkxqxFgR1oSMA3UprHj
         jomKFGOTxE5VRCcBS5x1bEO7gp2tFPqldoXr+sJZ4RTUD9BWTJXiP2cmXRprAkg20acv
         BpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703529; x=1728308329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MPniYXfYKgln6nb/HfyU4HnTcRjrBrRpvvr6Y9lixw=;
        b=XRb+mv2iBM9/8UuU3zZUhzQ5mGwesT62vBoQ7I0Q2oJ4xMdeT9RBInyGhRWF0yIoU2
         9Dpj5RfjIbBL62YkHp+0O0s+bOpGEydn6tkpgMiMCSaXMPaTerov463cB7qgg9Eco6BQ
         kYn2Q75kg4JJ6KXdjfoc5O+4Op9GL1ugapuGqRwyIWfnUtHJjFjA0OI4fQZLRSgJBvWy
         DcCbgG8kjsyUDlqHDrmNq0QnXb9nACUpUnYxzTqjBUHf217ET3RwuIC3rdo5v55DrUZX
         qPBR8hCUm45nANxf9JgEt+h8qm6/BhArB0lmRUxidhbrVy7FBh+q6k9Mm+XGTTgoOm/2
         rX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5WYaYNZ8nNA5uZjM/4eKSZhH6u+VEZCd8n72K3rkV1zZABj0AM9h+b15LLbEHJYqSp69q5wvCX6g9MPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMn28yZU/xM9R2euzKXGCfmqKmQgRFR4frVUxCYPH4ov5ovUt
	ufuTj34zsDYg2JpwjmKHDRSFxFI40CTJcddO3uLGgz36B6kHb1KnVQtEpM+Lv5WdIzGK7jncTY9
	V
X-Google-Smtp-Source: AGHT+IEkiG8JoBQ2q71WF4hYUTEomiQ1lmEgIlsCWFA6CXH1JGsqBPW61T/bXlNinIrB1ExJnC2LkQ==
X-Received: by 2002:a17:907:9445:b0:a86:9d39:a2a with SMTP id a640c23a62f3a-a93c48f61c0mr1488055166b.8.1727703528590;
        Mon, 30 Sep 2024 06:38:48 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299af9esm531203866b.216.2024.09.30.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:38:48 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:38:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] printk: Improve memory usage logging during boot
Message-ID: <Zvqp5jNa7XCRfSu9@pathway.suse.cz>
References: <20240926011203.1472798-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926011203.1472798-1-isaacmanjarres@google.com>

On Wed 2024-09-25 18:12:01, Isaac J. Manjarres wrote:
> When the initial printk ring buffer size is updated, setup_log_buf()
> allocates a new ring buffer, as well as a set of meta-data structures
> for the new ring buffer. The function also emits the new size of the
> ring buffer, but not the size of the meta-data structures.
> 
> This makes it difficult to assess how changing the log buffer size
> impacts memory usage during boot.
> 
> For instance, increasing the ring buffer size from 512 KB to 1 MB
> through the command line yields an increase of 2304 KB in reserved
> memory at boot, while the only obvious change is the 512 KB
> difference in the ring buffer sizes:

Good point.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1156,6 +1156,17 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
>  
>  static char setup_text_buf[PRINTKRB_RECORD_MAX] __initdata;
>  
> +static void print_log_buf_usage_stats(void)
> +{
> +	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
> +	size_t descs_size = descs_count * sizeof(struct prb_desc);
> +	size_t infos_size = descs_count * sizeof(struct printk_info);
> +
> +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> +	pr_info("prb_descs size: %zu bytes\n", descs_size);
> +	pr_info("printk_infos size: %zu bytes\n", infos_size);
> +}

I would make the information more user friendly. Also a single line
might be enough. Something like:

static void print_log_buf_usage_stats(void)
{
	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
	size_t meta_data_size;

	meta_data_size = descs_count *
		(sizeof(struct prb_desc) + sizeof(struct printk_info));

	pr_info("log buffer data + meta data: %u + %zu = %zu bytes\n",
		log_buf_len, meta_data_size, log_buf_len + meta_data_size);
}

> +
>  void __init setup_log_buf(int early)
>  {
>  	struct printk_info *new_infos;
> @@ -1186,19 +1197,19 @@ void __init setup_log_buf(int early)
>  		log_buf_add_cpu();
>  
>  	if (!new_log_buf_len)
> -		return;
> +		goto out;

The same information is printed twice when the default buffer is used.
We should do something like:

	if (!new_log_buf_len) {
		if (early)
			goto out;
		return;
	}

>  	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
>  	if (new_descs_count == 0) {
>  		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
> -		return;
> +		goto out;
>  	}
>  

Best Regards,
Petr

