Return-Path: <linux-kernel+bounces-331239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312897AA46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B1028853B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C41B813;
	Tue, 17 Sep 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su5pRlkJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBC134B6;
	Tue, 17 Sep 2024 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726537614; cv=none; b=GShQSw2eNdMnt01WfqyJHzleEorYPsR7rp4Q82TN1ZZ0v20yRhhQFKJhYyyDQMRQQvjo+phQZSRpz9ahjt8nHfLkHpq5x7l23s5JIeUfWI5W1VCR2hY5t7ex09c7N1yjGn9UvePh+pW3dbAGWkLyeenrYENtirZ3cPHUI0mXDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726537614; c=relaxed/simple;
	bh=/brxbPc3FMEZyUFKdaEo/F3MJogHN+JwKDCdPbpHpiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPthcIIX+WE4SNKwkRxcUBCeKgwVR07JXOpegKrLf/ZmJpfQAyZtqlEtQhUXx7WJ3XYYPZ0cDRlQvQMu7PsxNBZE+hjsdhP8sT0ugxzxBNhF7wm55HpA19pWs7celHQxrkb+Gz4aDF406kufbzZHIu6r5xcnzDRTbIIBKqTo8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su5pRlkJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso3589052a91.2;
        Mon, 16 Sep 2024 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726537612; x=1727142412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+D4cPBmRT6xaemcGTmAgItbpnUbMzRSePyZlZJqK1E=;
        b=Su5pRlkJVS8oMuIM6KKmP3wqbzHdoCRKZsfJBBFQJqjgPOsCUNx+kbcTz+Vsb9LRVj
         5ZsNC/bRfPB1HjJdrCpEIXzbyMfoGlt+gFn8xOGXS7z+ImJIzt6diHkZ0Kv2dNIlGLNC
         Zm82fS4KXWd9iHHEIqMDJnZ9Q80BA8uSP5X2exUO6k+hjpkyIlZuVtNf088yKcheWh++
         7Ws9zBsMorPwgHvcW+FqMXdlwYcUgM2+v09+L+Cv/yU92Zkt56VBPABfFQmL7+002VZu
         LEPW8Vd0vrIRQJbgDmVVN8WQbFEG8gJfW1LsKfRYIEuqxc40/pYVoCgBFdCQqPvp7EWY
         4aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726537612; x=1727142412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+D4cPBmRT6xaemcGTmAgItbpnUbMzRSePyZlZJqK1E=;
        b=RycS0ukvbMpWF18kQgnlcUejNfICwEFMqu/0vnNdbOAJMHwkEhVrkvZ0qWyxmjEE87
         f1JZt2ATiknepgaSVbeyoVrlcpq3Vp5rWnguPPYnDeN5efMlpSGuz4/87NIUyUi168Yw
         EYOU+6EeoozmzoQwUsM93StNYkLzTRKdvFc2aLeOuOGA5ASe4QRo9npBojqqP24Uo2ls
         9c+OFdly3JZ+r1dYT28JzHC+TsPBcjPHwv431nyMLyszRoS8cFP9TthO5E12wmGGFlH7
         J1lJDBUhWga2q1lZCIbTOUhsf1kG5kCdJDaxQrExMYNF2uNI5RR8pf1FTQIW+w/nwwO0
         l91A==
X-Forwarded-Encrypted: i=1; AJvYcCUt328uZODeZ/NMXngX+FD8Q3fR4IlmwLB3flCFNH5cvKY+C9tpkMDlwGdN18fwQCLC6060jwmhliP9@vger.kernel.org, AJvYcCW2v0M2IMxC5zZjfXPlXDrF6XliUj3eClL6fIWlTfn0sVvagyhaCusDo3lITKVWzzJW7jlflFIc016+@vger.kernel.org, AJvYcCXMXYkefIdxZWzRdrkuPryWHHj3Wq5JsVVnMLNvnVjOxs+UfVCKk/c62AtT7grkLizDHObnyuIzXqFXc1AR@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFqKJCIdAeYVS43555ta0sowqNJANMWBW19d8r86xc5o8rWr+
	IyQiyR2Y4CJMRFPbX1OFaixXdc5IW6VhYK9cCmytjgwy8KieYOKY
X-Google-Smtp-Source: AGHT+IEdGRthF0fnla/GYicoDcKM7UbNyJjWQz8xasioZPu4c/6Qc7VBLGYpi0jEQP/OFDLMoLvwkw==
X-Received: by 2002:a17:90b:2883:b0:2dd:4f93:93d4 with SMTP id 98e67ed59e1d1-2dd4f93944emr672335a91.17.1726537611784;
        Mon, 16 Sep 2024 18:46:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ccd91dsm8113123a91.33.2024.09.16.18.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:46:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 950254A1A1F4; Tue, 17 Sep 2024 08:46:46 +0700 (WIB)
Date: Tue, 17 Sep 2024 08:46:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linu Cherian <lcherian@marvell.com>, suzuki.poulose@arm.com,
	mike.leach@linaro.org, james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, devicetree@vger.kernel.org, sgoutham@marvell.com,
	gcherian@marvell.com
Subject: Re: [PATCH v10 8/8] Documentation: coresight: Panic support
Message-ID: <ZujfhpLezHtbXhjs@archie.me>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-9-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NdeeukOhj8gwtfO8"
Content-Disposition: inline
In-Reply-To: <20240916103437.226816-9-lcherian@marvell.com>


--NdeeukOhj8gwtfO8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 04:04:37PM +0530, Linu Cherian wrote:
> +3. On a kernel panic, all coresight blocks are disabled, necessary
> +   metadata is synced by kernel panic handler.
"... and necessary metadata ..."
> +
> +   System would eventually reboot or boot a crashdump kernel.
> +
> +4. For  platforms that supports crashdump kernel, raw trace data can be
> +   dumped using the coresight sysfs interface from the crashdump kernel
> +   itself. Persistent RAM is not a requirement in this case.
> +
> +5. For platforms that supports persistent RAM, trace data can be dumped
> +   using the coresight sysfs interface in the subsequent Linux boot.
> +   Crashdump kernel is not a requirement in this case. Persistent RAM
> +   ensures that trace data is intact across reboot.
> +
> +Coresight trace during Watchdog reset
> +-------------------------------------
> +The main difference between addressing the watchdog reset and kernel pan=
ic
> +case are below,
"... are:"
> +Sample commands for testing a Kernel panic case with ETR sink
> +-------------------------------------------------------------
> +
> +1. Boot Linux kernel with "crash_kexec_post_notifiers" added to the kern=
el
> +   bootargs. This is mandatory if the user would like to read the traced=
ata
> +   from the crashdump kernel.
> +
> +2. Enable the preloaded ETM configuration
> +
> +    #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enab=
le
> +
> +3. Configure CTI using sysfs interface::
> +
> +    #./cti_setup.sh
> +
> +    #cat cti_setup.sh
> +
> +
> +    cd /sys/bus/coresight/devices/
> +
> +    ap_cti_config () {
> +      #ETM trig out[0] trigger to Channel 0
> +      echo 0 4 > channels/trigin_attach
> +    }
> +
> +    etf_cti_config () {
> +      #ETF Flush in trigger from Channel 0
> +      echo 0 1 > channels/trigout_attach
> +      echo 1 > channels/trig_filter_enable
> +    }
> +
> +    etr_cti_config () {
> +      #ETR Flush in from Channel 0
> +      echo 0 1 > channels/trigout_attach
> +      echo 1 > channels/trig_filter_enable
> +    }
> +
> +    ctidevs=3D`find . -name "cti*"`
> +
> +    for i in $ctidevs
> +    do
> +            cd $i
> +
> +            connection=3D`find . -name "ete*"`
> +            if [ ! -z "$connection" ]
> +            then
> +                    echo "AP CTI config for $i"
> +                    ap_cti_config
> +            fi
> +
> +            connection=3D`find . -name "tmc_etf*"`
> +            if [ ! -z "$connection" ]
> +            then
> +                    echo "ETF CTI config for $i"
> +                    etf_cti_config
> +            fi
> +
> +            connection=3D`find . -name "tmc_etr*"`
> +            if [ ! -z "$connection" ]
> +            then
> +                    echo "ETR CTI config for $i"
> +                    etr_cti_config
> +            fi
> +
> +            cd ..
> +    done
> +
> +Note: CTI connections are SOC specific and hence the above script is
> +added just for reference.
> +
> +4. Choose reserved buffer mode for ETR buffer
> +    #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferr=
ed
> +
> +5. Enable stop on flush trigger configuration
> +    #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush
> +
> +6. Start Coresight tracing on cores 1 and 2 using sysfs interface
> +
> +7. Run some application on core 1
> +    #taskset -c 1 dd if=3D/dev/urandom of=3D/dev/null &
> +
> +8. Invoke kernel panic on core 2
> +    #echo 1 > /proc/sys/kernel/panic
> +    #taskset -c 2 echo c > /proc/sysrq-trigger
> +
> +9. From rebooted kernel or crashdump kernel, read crashdata
> +
> +    #dd if=3D/dev/crash_tmc_etr0 of=3D/trace/cstrace.bin
> +
> +10. Run opencsd decoder tools/scripts to generate the instruction trace.

Format all command lines as literal code blocks to be consistent:

---- >8 ----
diff --git a/Documentation/trace/coresight/panic.rst b/Documentation/trace/=
coresight/panic.rst
index 3b53d91cace8fd..864f6c05b3f7af 100644
--- a/Documentation/trace/coresight/panic.rst
+++ b/Documentation/trace/coresight/panic.rst
@@ -113,7 +113,7 @@ Sample commands for testing a Kernel panic case with ET=
R sink
    bootargs. This is mandatory if the user would like to read the tracedata
    from the crashdump kernel.
=20
-2. Enable the preloaded ETM configuration
+2. Enable the preloaded ETM configuration::
=20
     #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enable
=20
@@ -176,22 +176,26 @@ Sample commands for testing a Kernel panic case with =
ETR sink
 Note: CTI connections are SOC specific and hence the above script is
 added just for reference.
=20
-4. Choose reserved buffer mode for ETR buffer
+4. Choose reserved buffer mode for ETR buffer::
+
     #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferred
=20
-5. Enable stop on flush trigger configuration
+5. Enable stop on flush trigger configuration::
+
     #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush
=20
 6. Start Coresight tracing on cores 1 and 2 using sysfs interface
=20
-7. Run some application on core 1
+7. Run some application on core 1::
+
     #taskset -c 1 dd if=3D/dev/urandom of=3D/dev/null &
=20
-8. Invoke kernel panic on core 2
+8. Invoke kernel panic on core 2::
+
     #echo 1 > /proc/sys/kernel/panic
     #taskset -c 2 echo c > /proc/sysrq-trigger
=20
-9. From rebooted kernel or crashdump kernel, read crashdata
+9. From rebooted kernel or crashdump kernel, read crashdata::
=20
     #dd if=3D/dev/crash_tmc_etr0 of=3D/trace/cstrace.bin
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--NdeeukOhj8gwtfO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZujfgQAKCRD2uYlJVVFO
o2zvAQDx+PVsRJKQr7fD6gbDCeVA0X1MY9/zbQoMUWgQIFBkLQD/cQtUnKML1Ccq
xuiDgDEMvkAKQS8ti1jx1KpyslAhDwY=
=mgTK
-----END PGP SIGNATURE-----

--NdeeukOhj8gwtfO8--

