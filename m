Return-Path: <linux-kernel+bounces-215391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CC90920C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D72CB25449
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549C19D093;
	Fri, 14 Jun 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTxt1u6g"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CA146D62
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387720; cv=none; b=A363e5NY3MKiqD/zUzhzXMeTqHUK5AbOZFtSK076utNlN5z0pkAe/FxlstJ0dohcKJEIa7tiXMLyiW7uAsllTyWFcvk97UHw6mHZXslmIrd0AEdYYTZ9xim2/bY0deb+77eL7uR7k+ojgfx3X9W6JtJEapCCKRzB9idNnYuYjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387720; c=relaxed/simple;
	bh=cyGvAMRY33STt2mRnVANNOEIpFnlCLoDzUWHjIVGamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPqBVhPKw+xs8kku3a9Qk++M6xGfkca8515iDCE+lKG5ahzTRzghTGZf16A6tTcbIv6SO+AZb8AHqc9mV2Lbj2/ZOKMqOlvYrK+CX0luh6eBS82PqbnDfO3jFObeezk8oayziLwUhALfPl+4bykzyJbOyPXfGljiTBxNw/H9J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTxt1u6g; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso1554515ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718387718; x=1718992518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+j+RUk2de6FJv19zd/L4eL/1J06jSsoa48YLJfFggs=;
        b=cTxt1u6gZ4WyMVmiVWvr7T/NYKFOkSr4cUYuSRG5vvzmZB0TvW+H1YwDscuj7YJpQz
         QeWhcAkF5wFBy43l58GKSwb0CeGfwHyUU8Cl6nK2Q/twUp7Fy934wfaTE58D6HOenDFw
         KG2V8lBrE7JRd6oZW89/WBApgB0j26wkc/F1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718387718; x=1718992518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+j+RUk2de6FJv19zd/L4eL/1J06jSsoa48YLJfFggs=;
        b=n9QZ/KqjEdXStsISsCYmMe7GUKHRt6H/3aJ/c5NmjR6M2tzTPZtI8fC0bGintqtVyf
         qLMqJjUxoL2T3I07XI0DJ/u4hZEMknIJmYYbmjjTki+CjDDw/oR2r3+iX3zCxmVSzmTG
         e2ilVRQKY07AAy2gxCrDGAVfgxbo7ndmwpdtrnRn3Fk6vYBVF9HhX+KEbikiUOnlntls
         oKNN5oLx7NHfF2Sigxeh4KJqyUYakiFgEAijLCqI3QIa8/f2tr4yVl0jRFidVQMjeh6f
         mOk9eTIDNDKvrIvstzTp2IAX3HiaDEXYlL3x8bj51aOSsLEhNmVIR+TNytg2TCPkMptW
         dkvw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDoUPSaMZIX2BiIhe3suV1vOSxD8WIUeGgpTXP2PQrpEVHZ6ZNO5rH44wAo2+PeDU16HQlEOwKLzxd8Uhv81Ivq4mVmruJyYZ1pTs
X-Gm-Message-State: AOJu0YzSaZJyOAaj5QyvZyViGnuNjV7VU7AfKesRD+8vf9qgWopGO8vC
	/n9Njs9dD2VP9eKk7SZaJIpn9U7/ry6FlceZXsbQGQfbuBxSea4W4W/GoKPOV9I=
X-Google-Smtp-Source: AGHT+IEmvxfFUfe/ZUtHqAzDfK643dw5rnQIVFLRKEgRcf7yxKgbrv9dr4wvix7BLTSXo2TwmdEQ7Q==
X-Received: by 2002:a05:6e02:1242:b0:374:88c6:385b with SMTP id e9e14a558f8ab-375e0e69ac0mr30391555ab.2.1718387717986;
        Fri, 14 Jun 2024 10:55:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86c8fdasm7293465ab.52.2024.06.14.10.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 10:55:17 -0700 (PDT)
Message-ID: <111c2adf-7db6-4b02-bca2-8a7890078165@linuxfoundation.org>
Date: Fri, 14 Jun 2024 11:55:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve cpupower utility build process description
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 11:52, Roman Storozhenko wrote:
> Describe more precisely build and install 'make' processes for the default
> and the user defined directories. Show how to run the utility from the
> custom installation directory.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Enhance cpupower build process description with the information on
> building and installing the utility to the user defined directories
> as well as with the information on the way of running the utility from
> the custom defined installation directory.

You can move the above into the change log.

> This description is based on my experiments with building the utility
> and each newly described step has been tested.
> ---
>   tools/power/cpupower/README | 133 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 123 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
> index 1c68f47663b2..ec0d5551ae96 100644
> --- a/tools/power/cpupower/README
> +++ b/tools/power/cpupower/README
> @@ -22,16 +22,129 @@ interfaces [depending on configuration, see below].
>   compilation and installation
>   ----------------------------
>   
> -make
> -su
> -make install
> -
> -should suffice on most systems. It builds libcpupower to put in
> -/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
> -cpufreq-bench to put in /usr/sbin. If you want to set up the paths
> -differently and/or want to configure the package to your specific
> -needs, you need to open "Makefile" with an editor of your choice and
> -edit the block marked CONFIGURATION.
> +There are 2 output directories - one for the build output and another for
> +the installation of the build results, that is the utility, library, man pages,

Make sure the lines aren't longer than 75 characters.

> +etc...
> +
> +default directory
> +-----------------
> +
> +In the case of default directory, build and install process requires no
> +additional parameters:
> +
> +build
> +-----
> +
> +The output directory for the 'make' command is the current directory and its
> +subdirs in the kernel tree:
> +tools/power/cpupower
> +
> +$ make
> +
> +install
> +-------
> +
> +'make install' command puts targets to default system dirs:
> +libcpupower to /usr/lib
> +cpupower, cpufreq-bench_plot.sh to /usr/bin
> +cpufreq-bench to /usr/sbin
> +man pages to /usr/man
> +
> +$ sudo make install
> +
> +To put it in other words it makes build results available system-wide, enabling
> +any user to simply start using it without any additional steps

Mention where these are installed.

> +
> +custom directory
> +----------------
> +
> +There are 2 make's command-line variables 'O' and 'DESTDIR' that setup
> +appropriate dirs:
> +'O' - build directory
> +'DESTDIR' - installation directory. This variable could also be setup in
> +the 'CONFIGURATION' block of the "Makefile"
> +
> +build
> +-----
> +
> +$ make O=<your_custom_build_catalog>
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build
> +
> +install
> +-------
> +
> +$ make O=<your_custom_build_catalog> DESTDIR=<your_custom_install_catalog>
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build DESTDIR=/home/hedin/prj/cpupower install
> +
> +Notice that both variables 'O' and 'DESTDIR' have been provided. The reason is
> +that the build results are saved in the custom output dir defined by 'O'
> +variable. So, this dir is the source for the installation step. If only 'DESTDIR'
> +were provided then the 'install' target would assume that the build directory is
> +the current one, build everything there and install from the current dir.
> +
> +
> +clean and uninstall (default directory)
> +---------------------------------------
> +
> +'clean' target is intended for cleanup the build catalog from build results
> +'uninstall' target is intended for removing installed files from the installation
> +catalog
> +
> +default directory
> +-----------------
> +
> +This case is a straightforward one:
> +$ make clean
> +$ make uninstall
> +
> +custom directory
> +----------------
> +
> +Use 'O' command line variable to remove previously built files from the build
> +dir:
> +
> +$ make O=<your_custom_build_catalog> clean
> +
> +Example:
> +$ make O=/home/hedin/prj/cpupower/build clean
> +
> +Use 'DESTDIR' command line variable to uninstall previously installed files from
> +the given dir:
> +
> +$ make DESTDIR=<your_custom_install_catalog>
> +
> +Example:
> +make DESTDIR=/home/hedin/prj/cpupower uninstall
> +
> +
> +running the tool
> +----------------
> +
> +default directory
> +-----------------
> +
> +$ sudo cpupower
> +
> +custom directory
> +----------------
> +
> +When it comes to run the utility from the custom build catalog things become a
> +little bit complicated as 'just run' approach doesn't work.
> +Assuming that the current dir is '<your_custom_install_catalog>/usr', issuing
> +the following command:
> +
> +$ sudo ./bin/cpupower
> +will produce the following error output:
> +./bin/cpupower: error while loading shared libraries: libcpupower.so.1: cannot
> +open shared object file: No such file or directory
> +
> +The issue is that binary cannot find the 'libcpupower' library. So, we shall
> +point to the lib dir:
> +sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower

Nice. This is a good tip worth adding to the document.

>   
>   
>   THANKS

What is this line?

> 
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240613-fix-cpupower-doc-9f9365d15c16
> 
> Best regards,

I think your patch and email got munged. Please use git-send email
to send the patch.

thanks,
-- Shuah


