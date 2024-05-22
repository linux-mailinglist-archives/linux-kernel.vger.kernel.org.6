Return-Path: <linux-kernel+bounces-186161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B88CC07D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B3F1C224BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D0130ADA;
	Wed, 22 May 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f20xYOjL"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CF12E1F1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378275; cv=none; b=i1VmwsAwonw4mdm/lpl8tbuu3GMGmMSJoGDNraWuT9ECdSvQULMw3Wg3QzTCGY9Owly7XTamzGq3Z6gPqkxqoQ/P1S6ldAlil+pTao39CrTlfvS3aGAY4/xzhzHYByzLTcZV9f9fzbbLoU0WbP1Q/8UqL0+x/P8mHTGdMa7JS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378275; c=relaxed/simple;
	bh=LpnRNcJij0yq/HxvAH4NrOsBgPjXV73gGgD3lrbBeFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNTxIbg2gjiNmaifnIzwXaxdHU8ciZpCFS7HQHGiO3ryUSQLVvk7nS0DnXnaIEJFU9vIyquPBYyPfX9rogdgtfdAYcrICuoPeNeCKkHdV40cfaeD5V2peWO1A5C+byQkaO71uCUlK8RGLxsRsPVywc+227yBrsJ8CuyoG6hpqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f20xYOjL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e428242a38so91700551fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716378271; x=1716983071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voS8iBC/CPfmqha7lxiV2JBUbAAWG1gJ26sqax7yLe8=;
        b=f20xYOjLwWwoZQ2vjy2vQpiKvFK5HJ1E1GmFEWFgELk+HuWiujYJRV02yqVXMGAqCq
         cJO0UISh2o/j9udiybFmRT/Nzqjm74Of1aBZzcwy3rDa3/QY8nvpj+yXC96YGZgZ5aXd
         /UGGaT/gZXvoSuW/Slh3JSRe2iJU69BvedXeDTT6Sw0DId1qlYkTRNNYW/e2RDhT95cg
         gbNCWtyDbaIckDtW5wgtRV3iIospmYd81O5Q4QYwm7X3UDK8AhlIfMDKh/Vp0LbhbO4p
         Yg9S7CVYSB5ckXRDc0nXKwhfuMaBpTUZ0wXECGbIKII9f0XMRuPb1uQFpPkH/T7LEvSQ
         r//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378271; x=1716983071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voS8iBC/CPfmqha7lxiV2JBUbAAWG1gJ26sqax7yLe8=;
        b=Hwgwdg6fxpcrrS4wwkFVrREW3Mt02a4OaejPMS20JbmnFYeuuYA/dF1Aq6o/5YXRv2
         BtJwAlHvuI5SFIL9mX8f8uuq+9gNd+v7t8Sv4t/vsQKxix4Nin6swUhkIqQn821DnqU0
         bZuKEvljM5S4eSotdT06fSrQtrxgxYGIUAYC4JunXK3/r7nXIW2LxMLsmihyc3cHG3BV
         YUE1RKUWjS/2KLINndRim07H0ZpwtGP2D8DLLC6sLBb/MoczHjJZInA2WII6iOJ7SeKR
         7qS2ctY190HvNbB73jmx5nAzBiEhA7bBqRbqXFmSxS/PtG+9VCCpPGLt8K/M3GjUjVnt
         vpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGNudpj2FNRnkAdhiRkNTPIS81ljvfwkJIDmEX/T/q1IBOelRPpHD0VXuHjkavM7yyTiCHtE6+c28dPJIRJ6U0xj0es3zxDCfLbDyL
X-Gm-Message-State: AOJu0YyAAph5Pf/+Yojo1SEC/WVilWeHhR1rCHZR61f/P8ApQ2ChEsGJ
	NIxCIF3YwKGY5e9OKR8Vo1jkiCA47pI0uh/09EQ1uydPNTG/F3YBkzYC5SzvjYc=
X-Google-Smtp-Source: AGHT+IE6UsVgyNWxEj1Qq4n1+brostMB59DhOJ0AltqQqX31WU0Ago4GOZq97qgQ7AygtP3IFrRPug==
X-Received: by 2002:a2e:9210:0:b0:2e1:c448:d61e with SMTP id 38308e7fff4ca-2e949466c14mr13483761fa.15.1716378271019;
        Wed, 22 May 2024 04:44:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892450sm1778426066b.63.2024.05.22.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:44:30 -0700 (PDT)
Date: Wed, 22 May 2024 13:44:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lukas Hruska <lhruska@suse.cz>
Cc: mbenes@suse.cz, jpoimboe@kernel.org, joe.lawrence@redhat.com,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH v2 6/6] selftests: livepatch: Test livepatching function
 using an external symbol
Message-ID: <Zk3anchjqeCkZmU5@pathway.suse.cz>
References: <20240516133009.20224-1-lhruska@suse.cz>
 <20240516133009.20224-7-lhruska@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133009.20224-7-lhruska@suse.cz>

On Thu 2024-05-16 15:30:09, Lukas Hruska wrote:
> The test proves that klp-convert works as intended and it is possible to
> livepatch a function that use an external symbol.
> 
> Signed-off-by: Lukas Hruska <lhruska@suse.cz>

> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -7,6 +7,7 @@
>  MAX_RETRIES=600
>  RETRY_INTERVAL=".1"	# seconds
>  KLP_SYSFS_DIR="/sys/kernel/livepatch"
> +MODULE_SYSFS_DIR="/sys/module"
>  
>  # Kselftest framework requirement - SKIP code is 4
>  ksft_skip=4
> @@ -299,7 +300,7 @@ function check_result {
>  	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
>  		 grep -e 'livepatch:' -e 'test_klp' | \
>  		 grep -v '\(tainting\|taints\) kernel' | \
> -		 sed 's/^\[[ 0-9.]*\] //')
> +		 sed 's/^\[[ 0-9.]*\] //' | sed 's/^test_klp_log: //')

The prefix "test_klp_log:" is not used anywhere. It seems that this
change is not needed in the final version.

>  
>  	if [[ "$expect" == "$result" ]] ; then
>  		echo "ok"

Otherwise, it looks and works nice. With the hunk removed:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

