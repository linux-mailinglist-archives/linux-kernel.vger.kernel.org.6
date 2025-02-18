Return-Path: <linux-kernel+bounces-520471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C2A3AA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B267A6A64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E711DED4F;
	Tue, 18 Feb 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZErjMnHi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D31CEAD6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911496; cv=none; b=G0rwrw+b3OsUPZJaLOcLzCEDcgjGgtrm5KzfAX+OL+0gD2JGuAlCMBAC5USxx1+tGuIoFUKY2bed3MvBomrLeRJ91nPr0Zfcw8BuzAwjv7pE13EPMFMh71UdSxk8JPypFBm1x8rYUqGqzcw5Y0UVaE/+4ZPWUmXdSSYOjdr8qHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911496; c=relaxed/simple;
	bh=/xK1OpD3jYnII80Bbmv3ASuomy+lTutxUhIKv3KZ8vg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fG0Ubez9KDaGP4OejNjWbciIqqEddQrAlF4Y7AZ3WwQqTGkjIXm4EKN9DOMKknID05bANGBxagI35Mi9QCzjzTCls2Lj+s+Xs6Z1H4LI0+MXglIsHuwkLQ6oBqPuIEBdhrH00hktA6aNiEQxsL1SzAbCQS14SVcRDaNbVcyw+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZErjMnHi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739911492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U6IaL4Uh4Ysg2qyqv6Wdh6gK8ZyE5jqK4/4mRmvBeY=;
	b=ZErjMnHiAnTvN9qwj3lL0GbYjs3MWUEA9/yHF3mEff7emyt4/VHTbLhtpEkTFYZd5bxazG
	2ObWAqzXjDJ2F5+LMsXSfNtDESUgFXO4v/K+RzOtya1Xsy6IBCK3wIT0+ETzgq0+4IOyDI
	glgMOuGazJ2ijV6t1tuaStiS8CP5Wt0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-rf86IdNBPCqwe4XTaDrd-A-1; Tue, 18 Feb 2025 15:44:50 -0500
X-MC-Unique: rf86IdNBPCqwe4XTaDrd-A-1
X-Mimecast-MFC-AGG-ID: rf86IdNBPCqwe4XTaDrd-A_1739911490
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47198c965e1so106161001cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739911490; x=1740516290;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U6IaL4Uh4Ysg2qyqv6Wdh6gK8ZyE5jqK4/4mRmvBeY=;
        b=iVskduINkkMjflLysaLw4Qiaw2e43rPfFHsnzoY2md0QUV0hcSX99fIGxqwfiN8m7N
         PRCU6TdkjwWMKScLDVIJeO4ssSorLHLD8Ck269deAimpeuRRuK3PfpvP2hli2kgZe5P6
         mstpvbdY8aWIPgmXcwVLVC+IZdy+5t2peU7lwh2l45yttXV1/sXmNRYsCMoFA4aqNQCL
         KG2kD05JyX2cVvTP5k2slGvMEHZtr/Sp6BJgulMITyRfnq1d6EMC9PCBnoboqKNK1ObB
         /wTS52KnYzYvntOLJUx1xl0ydIXLdem4u0rjx3/JNpQafWhGb0JoZ6OZt6cQ9rmxBlgd
         HIxg==
X-Forwarded-Encrypted: i=1; AJvYcCWi7JQKDide5WIw4N2TBzqs+aHDS6NzjyrSYN/B/WPMZizkp7Sj6+EqfPexQQsBrlmeuMEW+CYIu07xMIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHaG/NRnDPoUPajfvUcLfg9cDjyKVPIKQvaBqoL6NWL1rhKRr
	54wRBNQxg1UlanyHU6DaEfrciswYo0ND8uKFum0paUPDQThsxzUurdnSbgpWeWWKOq5uvI5hKNS
	Zt3fwFdxPUjceeoInbDNYcQy7owKt9F4K8FVD4Ykc0ArMLP7WDsXJKF5o0HcYmA==
X-Gm-Gg: ASbGncv7cK94NhQDW0gcli63pN1XFHHPWd5VjlNcoNXtYghB4W26RX3Rp3UJGQHcwsc
	fNsxaoB1cXBXM32cbOBH81eZiseTqAL2Jq7gLKAEEyQ8ZJgwDJc/hRhBEk2sdwsQw2rbadHCLVU
	puFYm6ZD2TAxEMaGRBIJgiuyi3xLFiHDKIRfM8LOB0NnfSfdxXlqwI/A+BNW4cZneOJgU6Hy7ZH
	HM5E2I+OpR+cvIeEFlvOo08yxXbMJ3fpXHFoykcj/gxKq/bbnAWooZPp3v/a7kaXoRZneHPQOsi
	iqFcuvpPc+iOzaKAJ79j+K+f45QCDZjj04NI/o2tuXcLGnuq
X-Received: by 2002:ac8:5e4e:0:b0:471:bd14:a77c with SMTP id d75a77b69052e-472082a97c3mr14807101cf.44.1739911489844;
        Tue, 18 Feb 2025 12:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDJ43mCnX/GxrYQz/yZz57l69Gil45oCG1T44SH7mvxCs6L1e9ve5SqgQTdz+WY3G273FDRg==
X-Received: by 2002:ac8:5e4e:0:b0:471:bd14:a77c with SMTP id d75a77b69052e-472082a97c3mr14806821cf.44.1739911489528;
        Tue, 18 Feb 2025 12:44:49 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fa44e494sm17504291cf.48.2025.02.18.12.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 12:44:49 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c7fce1b1-b0f7-42b8-9a1f-fd07e6200924@redhat.com>
Date: Tue, 18 Feb 2025 15:44:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: make shell scripts POSIX-compliant
To: Aditya Dutt <duttaditya18@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20250216120225.324468-1-duttaditya18@gmail.com>
Content-Language: en-US
In-Reply-To: <20250216120225.324468-1-duttaditya18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 7:02 AM, Aditya Dutt wrote:
> Changes include:
> - Replaced [[ ... ]] with [ ... ]
> - Replaced == with =
> - Replaced printf -v with cur=$(printf ...).
> - Replaced echo -e with printf "%b\n" ...
>
> The above mentioned are Bash/GNU extensions and are not part of POSIX.
> Using shells like dash or non-GNU coreutils may produce errors.
> They have been replaced with POSIX-compatible alternatives.
>
> Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
> ---
>
> I have made sure to only change the files that specifically have the
> /bin/sh shebang.
> I have referred to https://mywiki.wooledge.org/Bashism for information
> on what is and what isn't POSIX-compliant.
>
>   tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh   | 10 +++++-----
>   tools/testing/selftests/kexec/kexec_common_lib.sh     |  2 +-
>   tools/testing/selftests/kexec/test_kexec_file_load.sh |  2 +-
>   tools/testing/selftests/net/veth.sh                   | 10 +++++-----
>   tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh   |  2 +-
>   tools/testing/selftests/zram/zram_lib.sh              |  2 +-
>   6 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
> index 3f45512fb512..00416248670f 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
> @@ -11,24 +11,24 @@ skip_test() {
>   	exit 4 # ksft_skip
>   }
>   
> -[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
> +[ $(id -u) -eq 0 ] || skip_test "Test must be run as root!"
>   
>   # Find cpuset v1 mount point
>   CPUSET=$(mount -t cgroup | grep cpuset | head -1 | awk -e '{print $3}')
> -[[ -n "$CPUSET" ]] || skip_test "cpuset v1 mount point not found!"
> +[ -n "$CPUSET" ] || skip_test "cpuset v1 mount point not found!"
>   
>   #
>   # Create a test cpuset, put a CPU and a task there and offline that CPU
>   #
>   TDIR=test$$
> -[[ -d $CPUSET/$TDIR ]] || mkdir $CPUSET/$TDIR
> +[ -d $CPUSET/$TDIR ] || mkdir $CPUSET/$TDIR
>   echo 1 > $CPUSET/$TDIR/cpuset.cpus
>   echo 0 > $CPUSET/$TDIR/cpuset.mems
>   sleep 10&
>   TASK=$!
>   echo $TASK > $CPUSET/$TDIR/tasks
>   NEWCS=$(cat /proc/$TASK/cpuset)
> -[[ $NEWCS != "/$TDIR" ]] && {
> +[ $NEWCS != "/$TDIR" ] && {
>   	echo "Unexpected cpuset $NEWCS, test FAILED!"
>   	exit 1
>   }
> @@ -38,7 +38,7 @@ sleep 0.5
>   echo 1 > /sys/devices/system/cpu/cpu1/online
>   NEWCS=$(cat /proc/$TASK/cpuset)
>   rmdir $CPUSET/$TDIR
> -[[ $NEWCS != "/" ]] && {
> +[ $NEWCS != "/" ] && {
>   	echo "cpuset $NEWCS, test FAILED!"
>   	exit 1
>   }

test_cpuset_v1_hp.sh had been changed to use /bin/bash in v6.14 by 
commit fd079124112c ("selftests/cgroup: use bash in test_cpuset_v1_hp.sh").

Cheers,
Longman


