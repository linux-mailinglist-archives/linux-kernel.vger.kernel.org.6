Return-Path: <linux-kernel+bounces-395703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8799BC1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFFF1C2125D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D06FC3;
	Tue,  5 Nov 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="V9DycDZc"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B1817
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765497; cv=none; b=dZuWiYtty/DFYNYNY+KmOhfgKubBYYj6THeJsk6j/anen0wK5KySnoKvR6bxfsqnj83DGZY6yJ2rp/CqqUs+RilSiHo0KP0hkKJJgXCjhXimWS/IbSVCgWXt8FEiz8LA+3u/9+22nLaVH8eXuAubxOlZ+DgCW8ZTeNGxzhy2WqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765497; c=relaxed/simple;
	bh=gWgRcXOWyPuYyTeu+HI4eru08VqwWwTDaEH/C3Ai8TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPZ9df+pGOiD9zaHQw1K8JcKzgVCHRmBPKoIyoAMjRCcmkiZcW3AGHIuxwxZRtzoA1dVNwQi4WvsxcVt+dITZTqzIVEkaDcQ0rKhTQpBDY8DM9ISVZ9TSXw2ctczllfgw3wWlwonev26XuZKUYs9ojyCcNAJHnlra6kbvxeRL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=V9DycDZc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso3732747b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 16:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730765494; x=1731370294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzBGIIzGVWypDF2F/j8kxcVTvvbYnIIP9aDVrmVHUqo=;
        b=V9DycDZcrQMIiQgw99c8ifLm4wYIdgDN2GLr0l3lnmzTBH6iUmfpRqswwvXCjy90Xq
         Tn1dxlJ/63MYXkzJblf9BC8YJ7S3o7i2WhtYvhcWGYn29i0jdSUCM9x0cDRnAN8DQVZg
         ZyP1sxi/7nLU/PhHNKBhGe2Sn9Yvdh43kxais=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730765494; x=1731370294;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzBGIIzGVWypDF2F/j8kxcVTvvbYnIIP9aDVrmVHUqo=;
        b=XmgpuTDCNxHa4X5j4KSm7k7ZDPi5ng7L9OkpPS3yvruX1U1CG7dnrdN7y6ZYEZbiOW
         ORHJ67BF57TD6NlhY5nfE7aRncEY55WGDmqQoa78AQq5etGKcMvoAbixpNKUD0gpoXxh
         xezP1HPcyfTFpfblpL70ntJPnZJ6SZngJRiXTbrVJfVD7yRj2VGsmWfKkW44dPElkNT2
         MXjlvbLNCNaU7yQnonlEHARzjMdnqeZHaXgLJQe6h9EQs8/0cDAeyAJSYWjI/fVZIoA0
         oSMdGJ9ew4Xx/PFZWqqDaIqdJ8JrCeHMh9AXF5jsrKVydboMGVMcpoMwnhcZ5ym75qb8
         COCA==
X-Forwarded-Encrypted: i=1; AJvYcCXOOsUWMBg7np4i7NwgEg1aLg5jeNSIOxx2lH0X2GQk5oyKd2q7jDJxIdl9V6oQrtpivgnYdaf8LkXRk+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnlqQD0Wo8kMjxzY1bKC23E58P7juKBo5mp95kITE30FcPx8q
	JsF8XnfW054SFT2N0lzze4eGfdspM19CwuSpUtEPzkCkaIU36B8XwdCQE0pEHg4=
X-Google-Smtp-Source: AGHT+IE6+0r70GgR/JYYtrp8S6WEpFk6AKBf4ysxpcdZyo74q6Lq8+iIND0dfroDCYdzA0K/G5OkBQ==
X-Received: by 2002:a05:6a20:d498:b0:1d9:1823:83bf with SMTP id adf61e73a8af0-1db91d516d0mr24240567637.8.1730765494528;
        Mon, 04 Nov 2024 16:11:34 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1eac2fsm8150260b3a.72.2024.11.04.16.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:11:34 -0800 (PST)
Date: Mon, 4 Nov 2024 16:11:31 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
Message-ID: <ZyliszeFtcZqfsnm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-11-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-11-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:28AM -0800, Stanislav Fomichev wrote:
> This will be used as a 'probe' mode in the selftest to check whether
> the device supports the devmem or not. Use hard-coded queue layout
> (two last queues) and prevent user from passing custom -q and/or -t.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> index 044198ce02a7..270a77206f65 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -76,7 +76,7 @@ static char *client_ip;
>  static char *port;
>  static size_t do_validation;
>  static int start_queue = -1;
> -static int num_queues = 1;
> +static int num_queues = -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -731,19 +731,31 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (!server_ip)
> -		error(1, 0, "Missing -s argument\n");
> -
> -	if (!port)
> -		error(1, 0, "Missing -p argument\n");
> -
>  	if (!ifname)
>  		error(1, 0, "Missing -f argument\n");
>  
>  	ifindex = if_nametoindex(ifname);
>  
> -	if (start_queue < 0) {
> -		start_queue = rxq_num(ifindex) - 1;
> +	if (!server_ip && !client_ip) {
> +		if (start_queue < 0 && num_queues < 0) {
> +			num_queues = rxq_num(ifindex);
> +			if (num_queues < 0)
> +				error(1, 0, "couldn't detect number of queues\n");
> +			/* make sure can bind to multiple queues */
> +			start_queue = num_queues / 2;
> +			num_queues /= 2;

Sorry for the beginner question :) -- is it possible that rxq_num
ever returns 1 and thus start_queue = 0, num_queues = 0

> +		}
> +
> +		if (start_queue < 0 || num_queues < 0)
> +			error(1, 0, "Both -t and -q are required\n");

And then isn't caught here because this only checks < 0 (instead of
num_queues <= 0) ?

