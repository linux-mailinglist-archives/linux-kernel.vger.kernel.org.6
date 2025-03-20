Return-Path: <linux-kernel+bounces-570355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF5A6AF41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3A44675B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBC229B0C;
	Thu, 20 Mar 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQmCA8Gh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE221EFF9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502981; cv=none; b=SwZoB+/HriEEKO2DQ4lOOyec+u/oRdzK9Qef82m5hovN79+BVbSV3XPLoMhEZK0Ju0I7OHkSeseu9143F0+7wGbsl/Q6z232VIwRUHL9CC1+cwMOzcK3WztWRZFG8RBLBRGiaQSYeP9N+zRnXTCjfX1nL7rh6MDhCDX3dBfuQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502981; c=relaxed/simple;
	bh=HNI3+8j2uUg+iUrX5QfJ8q4x1m2XlYX6YegdFOe8SbQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lEvNKfsQJkvcPqezkAAkYy+8hZVCCzwSHBZqrUz/F5TMG8CU1ywTGE9ZMbFch1JwNNsSnH/lLoRiJgQvj03+rIXPViRbL4xK1ra6r773EiMO2mdnPO+udvYCaxMHL6ikuiWKNF3wrHq3vjiwMBgV9K2vfpdsaLULySQ0ZjkKtqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQmCA8Gh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742502978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wt6bgZEsyM6VG0/rKn/P//sJOGO57/PIOicF9noce8g=;
	b=jQmCA8GhfGw/6z6DCM5KOZjwqZq2QKp/+D0y/T/GJqvPxl2W9eNBUOF5xvPnr6Rd6A3QOI
	A6f49oU/ncgLBGDt61PEUxOOi490s7hGQUepIQUxy7a2aT1D+vK5OdtgedbmaBmhuXRg+r
	nTeMBLzw9sTX/+GtQw+UhouTW1GKRjY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-6s09irAHPwGvQ0OtIXd-Pg-1; Thu, 20 Mar 2025 16:36:17 -0400
X-MC-Unique: 6s09irAHPwGvQ0OtIXd-Pg-1
X-Mimecast-MFC-AGG-ID: 6s09irAHPwGvQ0OtIXd-Pg_1742502977
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476b2179079so22735871cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502977; x=1743107777;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wt6bgZEsyM6VG0/rKn/P//sJOGO57/PIOicF9noce8g=;
        b=ZgFu0y4affT7nIQkx6idapq8im3+2i3cfbFoAjD/Z99ROyNNIeiJ1ER3kvjIOXDw4H
         206FLHkorlXC/aPbDTLoKKQ8zKQFahvAqLX3gS00Re3ZDmUtrT2n89w5wtEgT1XI5kUi
         OYStUs5Jeb5i/myWdDsFrMzIsHvIC7IlqnfeXWZqtoWG3Bsw5lvVlLaZJhphnv5fnA00
         YAEc+1YqknDaLmRtraZkIuD4qmiZCy6yQtDhHTdHpW6V3ZMeldE+b24dz5ioVLh0whrs
         ZX6GYHA7aEHalMAfwJUVyiSjx4lnqBQ3ugC5ZUXxdANbOx3k4FE89v7gCfCMGFYBRFLn
         PZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDURzei1LRykJ8xctAAmjYcpipWw3+XfHIz34v8m/CnAcuDFwYAm6RLaJGXYoEGBw7OjJkxoTl5cSohLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXyc6Ls6JcYdXhdiXeNo4bNqkGl12bwZFO89Xt1URNq1kxnbS
	aUU8/HD0c8Oa7cRTGCDduDwFOHk4eO4CZuWGd0neDtrBfZVpGXa30FiOXV8jiQG2Byd7ypCkoMJ
	3DXC4W3/14g0XkuOobWEU0idFIeITGJL0AE88znmDux9J+4Xg4MMahuXv23mWXQ==
X-Gm-Gg: ASbGncuinSBzSjh5NmguupKKK1lJdUVOfX02SlXTRbSCMiuRZYiVd5sZpO0/ztML6it
	v64yvb2el9GwIbXxIWnBDXb23k3E2SixjTLbwVyXtbKrhIhI0MgIadfYzBP8I5ZhSrHQ/7Z3pBQ
	JEmv3GQboEGnXbGg0YAjADXDLVXafXWsSAyCBsGS0wQ2SUAinv7NXycJ+84o6VxNLuO7dInfzjk
	bn+pKPDJ4Gko8FqtEfOFzofkxqtfgXRNyZnSVwppNmr6GO0icknKsFGc7fpdT/19pSOnlKuOieT
X-Received: by 2002:a05:622a:1f89:b0:476:7bd1:68dd with SMTP id d75a77b69052e-4771de7deadmr13620591cf.50.1742502977167;
        Thu, 20 Mar 2025 13:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc6nQvnoQrcX1ByqFsZNWw+StGQCeklVgridhqC3mGlG9suOczgaIZuDOEPlY7AITfEcVPCg==
X-Received: by 2002:a05:622a:1f89:b0:476:7bd1:68dd with SMTP id d75a77b69052e-4771de7deadmr13620071cf.50.1742502976694;
        Thu, 20 Mar 2025 13:36:16 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d6361b6sm2726701cf.74.2025.03.20.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:36:16 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:36:05 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 5/6] rtla/tests: Reset osnoise options before check
In-Reply-To: <20250320092500.101385-6-tglozar@redhat.com>
Message-ID: <ea016692-37b4-7d18-ffcc-3c7a145bf59e@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-6-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> Remove any dangling tracing instances from previous improperly exited
> runs of rtla, and reset osnoise options to default before running a test
> case.
> 
> This ensures that the test results are deterministic. Specific test
> cases checked that rtla behaves correctly even when the tracer state is
> not clean will be added later.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/engine.sh | 40 ++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
> index 64d0446dc28e..5db8aa4bc031 100644
> --- a/tools/tracing/rtla/tests/engine.sh
> +++ b/tools/tracing/rtla/tests/engine.sh
> @@ -8,12 +8,44 @@ test_begin() {
>  	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
>  }
>  
> +reset_osnoise() {
> +	# Reset osnoise options to default and remove any dangling instances created
> +	# by improperly exited rtla runs.
> +	pushd /sys/kernel/tracing || return 1
> +
> +	# Remove dangling instances created by previous rtla run
> +	echo 0 > tracing_thresh
> +	cd instances
> +	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist
> +	do
> +		[ ! -d "$i" ] && continue
> +		rmdir "$i"
> +	done
> +
> +	# Reset options to default
> +	# Note: those are copied from the default values of osnoise_data
> +	# in kernel/trace/trace_osnoise.c
> +	cd ../osnoise
> +	echo all > cpus
> +	echo DEFAULTS > options
> +	echo 1000000 > period_us
> +	echo 0 > print_stack
> +	echo 1000000 > runtime_us
> +	echo 0 > stop_tracing_total_us
> +	echo 0 > stop_tracing_us
> +	echo 1000 > timerlat_period_us
> +
> +	popd
> +}
> +
>  check() {
>  	# Simple check: run rtla with given arguments and test exit code.
>  	# If TEST_COUNT is set, run the test. Otherwise, just count.
>  	ctr=$(($ctr + 1))
>  	if [ -n "$TEST_COUNT" ]
>  	then
> +		# Reset osnoise options before running test.
> +		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
>  		# Run rtla; in case of failure, include its output as comment
>  		# in the test results.
>  		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
> @@ -37,6 +69,14 @@ unset_timeout() {
>  	unset TIMEOUT
>  }
>  
> +set_no_reset_osnoise() {
> +	NO_RESET_OSNOISE=1
> +}
> +
> +unset_no_reset_osnoise() {
> +	unset NO_RESET_OSNOISE
> +}
> +
>  test_end() {
>  	# If running without TEST_COUNT, tests are not actually run, just
>  	# counted. In that case, re-run the test with the correct count.
> -- 
> 2.48.1
> 
> 
> 
Reviewed by: John Kacur <jkacur@redhat.com>


