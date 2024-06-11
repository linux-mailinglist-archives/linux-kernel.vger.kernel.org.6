Return-Path: <linux-kernel+bounces-210154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828490400A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6530B217D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798A282FD;
	Tue, 11 Jun 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK+Nl6gt"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D7381B9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119912; cv=none; b=O2MKxqAucqqSn8A91p7lOHxVptd6aiV463WANMig/zLCVTyv0vVMnKiuIiUifFXwr1//o2T0D89l7L2KXMiA0bChbu3hmdKSRzMXztNcI9GpKqH7FGX2RORZzVGIyyR5PUIp/QO1Ij1UnrpYI3SuAEtAd2mvQ/1fQhqP+37mAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119912; c=relaxed/simple;
	bh=nb/41p5cqxyjZu+y4cWwFNmsrVjqoLEmHFNnJV6EqpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixv6WUy/1dqXGXjnaxXU4yOE67hqaKFQEEj2Nsc5Q1jbVzTdhuorlN+hOtjZrDzM9KdnjA2+EUpmr9q/e+4Ry6i6GMukTn5SFkdz9V7bVUajqQkVcQY+ptl62nL+fzJVKZb7qyNX+dVkgxq1WUYlD199fflt8/tBL2gUae2FUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK+Nl6gt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7957ab2ad40so8459585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718119909; x=1718724709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgiG88rmAe4hGOcOH9NukgYDWLNdDqncNF+Hnp9N4/k=;
        b=ZK+Nl6gtdw0YVGHn2MHxy4xGsmdCTn0xyogrFSyIso/kBVC3PGftNCr1o/uQa4ij5C
         s9FO1G/wpH1Ew7AnabDkGrPlaiGhRphEaERqrRb/GOBmD0WvgFhPr79d4fqFruSvKLpI
         X1188hhDVVU7m79TG7C4/QQ7V8ntC84v6kpBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119909; x=1718724709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgiG88rmAe4hGOcOH9NukgYDWLNdDqncNF+Hnp9N4/k=;
        b=szfa69RsLL2tiN1Dp0HXVStY8DaUpYWCxtx4yz67HNc4bkRiWjJltAsKziBdJSMoCU
         ptexEAmTxpZwNCBcwRbuZpOkrd8uSzan5fDXiQUBxG8WOVkPVxLcL/CNvSwc3tbURFPt
         uy2rKET7/mxmvYJ+ZW9Z6dkveFQ+uI0pLIkGbn19c14a0sizMAJDrGsKuD5MMpWdiXHD
         xuymvfEvKh9bZX4E4qpSn+HZLL62ZoJuSo35KSP7Krk+kB0GdyobwrgcFVhGRYzgTjZL
         YLAFHYsY6q2PL/5tUEKgcuMNmHATIf8Dfdd5owyFm1m836vyoAc8RKSBRyb7kEa1HYCa
         irbg==
X-Forwarded-Encrypted: i=1; AJvYcCWnj2kHwbyAhkNoaeqT4L16rnu4LHwTFI663qYgfGfprcxMkM/hrcH9/cTcEHm6ofAjknZuAVrjRvwqQPkOIAdgg1SuA9nH/04zwu4O
X-Gm-Message-State: AOJu0YzZBoZuhsO3g2TSS3saCaF5tWRre7PZ27y0QehjKUId4cGD0oTV
	1NBAusgPbasbnUGQF0F2mj5G48cHB5iIilbLM+yfpm46bZ/epOMotMIoIetU2VM=
X-Google-Smtp-Source: AGHT+IEHDJL7YARi47dyxRN47x6RuENvb+peq4F6yfjVEpkHUHFAOpVDJJYWA+kTFDm+N6LjRwYthw==
X-Received: by 2002:a05:620a:4886:b0:795:6b7b:6923 with SMTP id af79cd13be357-7956b7b6b78mr697052285a.3.1718119909316;
        Tue, 11 Jun 2024 08:31:49 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79558163eeasm299849785a.124.2024.06.11.08.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:31:49 -0700 (PDT)
Message-ID: <e9d3060b-dacb-42a5-83bb-224678182a53@linuxfoundation.org>
Date: Tue, 11 Jun 2024 09:31:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: add return value checks
To: Abhinav Jain <jain.abhinav177@gmail.com>, shuah@kernel.org,
 brauner@kernel.org, mszeredi@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: javier.carrasco.cruz@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610200909.55819-1-jain.abhinav177@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610200909.55819-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 14:09, Abhinav Jain wrote:
> Add ksft_exit_fail_msg() return value checks for fchdir() & chroot()
> to address the selftests statmount test compile warnings
> 
> statmount_test.c:127:2: warning: ignoring return value of ‘fchdir’,
> declared with attribute warn_unused_result [-Wunused-result]
>    127 |  fchdir(orig_root);
>        |  ^~~~~~~~~~~~~~~~~
> statmount_test.c:128:2: warning: ignoring return value of ‘chroot’,
> declared with attribute warn_unused_result [-Wunused-result]
>    128 |  chroot(".");
>        |  ^~~~~~~~~~~
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>   .../filesystems/statmount/statmount_test.c          | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index e6d7c4f1c85b..b5e1247233b6 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -125,8 +125,17 @@ static uint32_t old_root_id, old_parent_id;
>   
>   static void cleanup_namespace(void)
>   {
> -	fchdir(orig_root);
> -	chroot(".");
> +	int ret;
> +
> +	ret = fchdir(orig_root);
> +	if (ret == -1)
> +		ksft_exit_fail_msg("changing current directory: %s\n",
> +				strerror(errno));
> +
> +	ret = chroot(".");
> +	if (ret == -1)
> +		ksft_exit_fail_msg("chroot: %s\n", strerror(errno));
> +
>   	umount2(root_mntpoint, MNT_DETACH);
>   	rmdir(root_mntpoint);
>   }


There is another prior patch that fixes the problem
https://patchwork.kernel.org/project/linux-kselftest/patch/20240417184913.74734-1-amer.shanawany@gmail.com/

thanks,
-- Shuah




