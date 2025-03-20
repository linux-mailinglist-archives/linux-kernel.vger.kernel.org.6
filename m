Return-Path: <linux-kernel+bounces-570358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30578A6AF51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C4483216
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37811E0DD9;
	Thu, 20 Mar 2025 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITipPvyU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC20212FB3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503381; cv=none; b=MOJl6uIpSRjeunYitVqLONy1tJNxwL0Q0DpB8TSbSSbjfh4clsHN9/ft8+XPVtzjqj3S/Kbbo5YSRMx7NvlQHQ7Inmo3jmU0A+asXODAbZVCw1gUQAFnWr7MuIxw9Rw7F0OPJwT85Vli7hTMjat4S76MrrjFzKHJVhB8T/MHzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503381; c=relaxed/simple;
	bh=Xdh/MJnCIprNyk5gQo7vfrxF4hS9VbcpNTXzPMRPSTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LfcJKlD/6bF8OGl6Zz2RkJWg0cGvn3KY1aMlzTfRJVfTUrEi8of9JA9x+84qLcY/pn6l4ZN9970imDdDktvtoiXruUEKknDQOd7jgaf06nN779DwCmB9Poz0ub4r8+SyAQ63SXTSFmeuziDzZ3QNIgf7t+nLVzmsdm1SobCT+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITipPvyU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742503378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk0vo4ySgcjWcYyqJYaGojYKQ2mTUpyWgtMJYQlkL3c=;
	b=ITipPvyU0es/gAYc/5fZy+eBasaPdbvaubi0L9k/nZwC749dmnQPGHAJVQYLzGcJnHG2rx
	JF5/KZnMgnnGHfiQvLJwhq1VdHcCwBm4wW0VydfB5kpnU/hfCvsKpl8PvykCje1SQp0gqv
	yJ4xU8aEgc8hBGeW3i+vq1gk83dPcDM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-N6y2mbzsPwuDPwO-biQMdw-1; Thu, 20 Mar 2025 16:42:57 -0400
X-MC-Unique: N6y2mbzsPwuDPwO-biQMdw-1
X-Mimecast-MFC-AGG-ID: N6y2mbzsPwuDPwO-biQMdw_1742503377
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47682f9e7b9so19806391cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503377; x=1743108177;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk0vo4ySgcjWcYyqJYaGojYKQ2mTUpyWgtMJYQlkL3c=;
        b=lv50dTqwwf25OYJyuijVHwh6UgWOmcvpolNV6rhOZoEygdLUiTjo/DrJ7YydFtacAF
         2+XLFvQj7ifkJo23JP8zcDoelI3i8gmVbZB89GZkYl/B/ZgmIIRByfnDWFmftOK+CjyZ
         RBMzlOjh/9jPtIBROJjDXS8duRFlZpuW1Qvmu0/qDUYodDDeuhMMWaiTsaq9mj7DWsOT
         05/mG+kU0WjpVx32jn/sqn7FQb2W3ukFOeLOnaCy6uqKcmxRdcX1HG1hPXvkRLAQuEJy
         jamQ8ZyLPW82/xoS6xq6kjRSKyu3ZBQ5B2E+F3XvBHycxs8lKNkOS7TNhUBMT4tFUkeD
         CIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuXTGF7y3lc7t8zglwJRuS/wwrKHTi6mVlBrxkuOW2RRYmLQT/wzCjZAJMq4yvPi0oifwfoby1NjTpfwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+u68KY600x6Uqjo+5DUjbJO5pIljKQ/Miw2MElX5C9QX9hoC
	odEWR1n1h+9B7xxyUtbX2dhyBG5Xn5D1OB4uNqOvtW3sP75mnawKu0/zUy+VGCTEtoZ1E+knerF
	b+4hqsUFv0SiqbdTlrhWc2jH3YQ+6OVg3YTrV9rFuSDzXEnkiCjE507SWI3COEg==
X-Gm-Gg: ASbGncsJUSGXzA9Ey0CgAVelk4T3S3RtDPufy/XvKwco9bzZepmKWC4TM2FKkRmcBCm
	VUyRgSBnbk+Gdy1Y5XBv/74XO3RfPtt6EI2AZkPvuVdA967URIslOHuNtzYvcahg/YMpmikRgul
	0zKCm1JJqYBOt+L/SkeRzX13aBMB84PEoUok+m6yQrxyRzS3fsz34j31xMQ7lgOjgkt+jMuMYku
	XtTrUWbKohPx7oSnK4il2tT4xkDKeNv2c1boyCsp2k8SLNEOGTjExn9DWmznEZ0zL6U0WBa//BH
X-Received: by 2002:ac8:5ac3:0:b0:477:1f29:e80f with SMTP id d75a77b69052e-4771f29e85fmr1879711cf.4.1742503376810;
        Thu, 20 Mar 2025 13:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMG1UpKj1xwg60B9Ao0w2zuv2Lvk2uR3IbSS3I1F5A4BrQHvbrmH05TUt/jndE9B9USAOUbA==
X-Received: by 2002:ac8:5ac3:0:b0:477:1f29:e80f with SMTP id d75a77b69052e-4771f29e85fmr1879321cf.4.1742503376308;
        Thu, 20 Mar 2025 13:42:56 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f7d4sm2876801cf.37.2025.03.20.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:42:55 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:42:44 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 6/6] rtla/tests: Test setting default options
In-Reply-To: <20250320092500.101385-7-tglozar@redhat.com>
Message-ID: <72c05486-1b49-242e-478d-e83c367e16fa@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-7-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> Add function to test engine to test with pre-set osnoise options, and
> use it to test whether osnoise period (as an example) is set correctly.
> 
> The test works by pre-setting a high period of 10 minutes and stop on
> threshold. Thus, it is easy to check whether rtla is properly resetting
> the period to default: if it is, the test will complete on time, since
> the first sample will overflow the threshold. If not, it will time out.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/engine.sh | 26 ++++++++++++++++++++++++++
>  tools/tracing/rtla/tests/osnoise.t |  6 ++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
> index 5db8aa4bc031..b1697b3e3f52 100644
> --- a/tools/tracing/rtla/tests/engine.sh
> +++ b/tools/tracing/rtla/tests/engine.sh
> @@ -61,6 +61,32 @@ check() {
>  	fi
>  }
>  
> +check_with_osnoise_options() {
> +	# Do the same as "check", but with pre-set osnoise options.
> +	# Note: rtla should reset the osnoise options, this is used to test
> +	# if it indeed does so.
> +	# Save original arguments
> +	arg1=$1
> +	arg2=$2
> +
> +	# Apply osnoise options (if not dry run)
> +	if [ -n "$TEST_COUNT" ]
> +	then
> +		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
> +		shift
> +		while shift
> +		do
> +			[ "$1" == "" ] && continue
> +			option=$(echo $1 | cut -d '=' -f 1)
> +			value=$(echo $1 | cut -d '=' -f 2)
> +			echo "option: $option, value: $value"
> +			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
> +		done
> +	fi
> +
> +	NO_RESET_OSNOISE=1 check "$arg1" "$arg2"
> +}
> +
>  set_timeout() {
>  	TIMEOUT="timeout -v -k 15s $1"
>  }
> diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
> index 86596e547893..e5995c03c790 100644
> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -16,4 +16,10 @@ check "verify the  --trace param" \
>  check "verify the --entries/-E param" \
>  	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
>  
> +# Test setting default period by putting an absurdly high period
> +# and stopping on threshold.
> +# If default period is not set, this will time out.
> +check_with_osnoise_options "apply default period" \
> +	"osnoise hist -s 1" period_us=600000000
> +
>  test_end
> -- 
> 2.48.1
> 
> 
> 
looks correct
change "stop" to "stopping" in description
Reviewed-by: John Kacur <jkacur@redhat.com>


