Return-Path: <linux-kernel+bounces-333049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE497C2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45867282E45
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621951EB27;
	Thu, 19 Sep 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PbiQn4tz"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA0171C2;
	Thu, 19 Sep 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726711834; cv=none; b=hVoX9t3WzIrG8rdZrzJLJW0vbAYX++zxjDutHjOFk6dtGdjXZ06qqUMqLQwM/YoWVBmfLqu9B9KFDvKw75IWfcNvDJVAzBr/fjy7/t+rGwXbXqgOHYhaW+3MmWem91rdpfOKYIwbY+DiFC17XPybELeD93Jxeu3NTbwC2fsUs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726711834; c=relaxed/simple;
	bh=GjnnAalKrUo6ZZkksy4vObwETa5MAT4PuvkokRInd08=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKIRcGmBdrgbmlY7TH8dm5gDbqF83+WDd32kNrMo2Vahd3qWAGWJRuRjVZffuluUOY77Uy1UJmXYK21g+yRpY99a47kK8Dv3ce4+L9DrHmOTLwbHEKRRR31yBecLCyUriFIuwtRzZlohzoFZOTJAexh+ygI1520EIu2R7GsJYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PbiQn4tz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IITFHX009778;
	Wed, 18 Sep 2024 19:09:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=PI3aNYe/hvx6qtW3e7Y/iLut/
	YXbUFclLNSaL99unsg=; b=PbiQn4tzaS4k6PUz0hduiEIzD5RdhKn/wFBT44nh6
	wc0p+mkPtO/+3ra+mBr7AGPqz6X3HoazB55PbHs73JPzV30FLo6TFtLDxQHRHkO5
	KZhoBGPtZb2tLncXo7RWTqcMQ2XF3j3HD1wzOGq6Zj6zUzwO5Ggx+j0UD/eP3/+d
	pcIKm/SspKDKaBg0Af1CUqB8knerKYYGv3nMmsXT7COHwwDwLkFv52tuas1BgrjP
	CrP3t43in6CVNsoTXFPPadet5GTAa0af2G9mV+1URo8wErPgnxFUo5sC+ONzQNsu
	UumlAPBeFSguJ5ugXXOSfsm4V8xMtQqZtCYpYC4yT2XMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgf713-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 19:09:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Sep 2024 19:09:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Sep 2024 19:09:55 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id E20263F704E;
	Wed, 18 Sep 2024 19:09:50 -0700 (PDT)
Date: Thu, 19 Sep 2024 07:39:49 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v10 8/8] Documentation: coresight: Panic support
Message-ID: <20240919020949.GA735454@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-9-lcherian@marvell.com>
 <ZujfhpLezHtbXhjs@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZujfhpLezHtbXhjs@archie.me>
X-Proofpoint-GUID: N4OEpQ-VPIZHL56J6G_IRQpnxsQeiWxq
X-Proofpoint-ORIG-GUID: N4OEpQ-VPIZHL56J6G_IRQpnxsQeiWxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On 2024-09-17 at 07:16:46, Bagas Sanjaya (bagasdotme@gmail.com) wrote:
> On Mon, Sep 16, 2024 at 04:04:37PM +0530, Linu Cherian wrote:
> > +3. On a kernel panic, all coresight blocks are disabled, necessary
> > +   metadata is synced by kernel panic handler.
> "... and necessary metadata ..."
> > +
> > +   System would eventually reboot or boot a crashdump kernel.
> > +
> > +4. For  platforms that supports crashdump kernel, raw trace data can be
> > +   dumped using the coresight sysfs interface from the crashdump kernel
> > +   itself. Persistent RAM is not a requirement in this case.
> > +
> > +5. For platforms that supports persistent RAM, trace data can be dumped
> > +   using the coresight sysfs interface in the subsequent Linux boot.
> > +   Crashdump kernel is not a requirement in this case. Persistent RAM
> > +   ensures that trace data is intact across reboot.
> > +
> > +Coresight trace during Watchdog reset
> > +-------------------------------------
> > +The main difference between addressing the watchdog reset and kernel panic
> > +case are below,
> "... are:"
> > +Sample commands for testing a Kernel panic case with ETR sink
> > +-------------------------------------------------------------
> > +
> > +1. Boot Linux kernel with "crash_kexec_post_notifiers" added to the kernel
> > +   bootargs. This is mandatory if the user would like to read the tracedata
> > +   from the crashdump kernel.
> > +
> > +2. Enable the preloaded ETM configuration
> > +
> > +    #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enable
> > +
> > +3. Configure CTI using sysfs interface::
> > +
> > +    #./cti_setup.sh
> > +
> > +    #cat cti_setup.sh
> > +
> > +
> > +    cd /sys/bus/coresight/devices/
> > +
> > +    ap_cti_config () {
> > +      #ETM trig out[0] trigger to Channel 0
> > +      echo 0 4 > channels/trigin_attach
> > +    }
> > +
> > +    etf_cti_config () {
> > +      #ETF Flush in trigger from Channel 0
> > +      echo 0 1 > channels/trigout_attach
> > +      echo 1 > channels/trig_filter_enable
> > +    }
> > +
> > +    etr_cti_config () {
> > +      #ETR Flush in from Channel 0
> > +      echo 0 1 > channels/trigout_attach
> > +      echo 1 > channels/trig_filter_enable
> > +    }
> > +
> > +    ctidevs=`find . -name "cti*"`
> > +
> > +    for i in $ctidevs
> > +    do
> > +            cd $i
> > +
> > +            connection=`find . -name "ete*"`
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "AP CTI config for $i"
> > +                    ap_cti_config
> > +            fi
> > +
> > +            connection=`find . -name "tmc_etf*"`
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "ETF CTI config for $i"
> > +                    etf_cti_config
> > +            fi
> > +
> > +            connection=`find . -name "tmc_etr*"`
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "ETR CTI config for $i"
> > +                    etr_cti_config
> > +            fi
> > +
> > +            cd ..
> > +    done
> > +
> > +Note: CTI connections are SOC specific and hence the above script is
> > +added just for reference.
> > +
> > +4. Choose reserved buffer mode for ETR buffer
> > +    #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferred
> > +
> > +5. Enable stop on flush trigger configuration
> > +    #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush
> > +
> > +6. Start Coresight tracing on cores 1 and 2 using sysfs interface
> > +
> > +7. Run some application on core 1
> > +    #taskset -c 1 dd if=/dev/urandom of=/dev/null &
> > +
> > +8. Invoke kernel panic on core 2
> > +    #echo 1 > /proc/sys/kernel/panic
> > +    #taskset -c 2 echo c > /proc/sysrq-trigger
> > +
> > +9. From rebooted kernel or crashdump kernel, read crashdata
> > +
> > +    #dd if=/dev/crash_tmc_etr0 of=/trace/cstrace.bin
> > +
> > +10. Run opencsd decoder tools/scripts to generate the instruction trace.
> 
> Format all command lines as literal code blocks to be consistent:
> 
> ---- >8 ----
> diff --git a/Documentation/trace/coresight/panic.rst b/Documentation/trace/coresight/panic.rst
> index 3b53d91cace8fd..864f6c05b3f7af 100644
> --- a/Documentation/trace/coresight/panic.rst
> +++ b/Documentation/trace/coresight/panic.rst
> @@ -113,7 +113,7 @@ Sample commands for testing a Kernel panic case with ETR sink
>     bootargs. This is mandatory if the user would like to read the tracedata
>     from the crashdump kernel.
>  
> -2. Enable the preloaded ETM configuration
> +2. Enable the preloaded ETM configuration::
>  
>      #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enable
>  
> @@ -176,22 +176,26 @@ Sample commands for testing a Kernel panic case with ETR sink
>  Note: CTI connections are SOC specific and hence the above script is
>  added just for reference.
>  
> -4. Choose reserved buffer mode for ETR buffer
> +4. Choose reserved buffer mode for ETR buffer::
> +
>      #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferred
>  
> -5. Enable stop on flush trigger configuration
> +5. Enable stop on flush trigger configuration::
> +
>      #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush
>  
>  6. Start Coresight tracing on cores 1 and 2 using sysfs interface
>  
> -7. Run some application on core 1
> +7. Run some application on core 1::
> +
>      #taskset -c 1 dd if=/dev/urandom of=/dev/null &
>  
> -8. Invoke kernel panic on core 2
> +8. Invoke kernel panic on core 2::
> +
>      #echo 1 > /proc/sys/kernel/panic
>      #taskset -c 2 echo c > /proc/sysrq-trigger
>  
> -9. From rebooted kernel or crashdump kernel, read crashdata
> +9. From rebooted kernel or crashdump kernel, read crashdata::
>  
>      #dd if=/dev/crash_tmc_etr0 of=/trace/cstrace.bin


Ack.

>  
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Linu Cherian.



