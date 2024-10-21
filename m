Return-Path: <linux-kernel+bounces-375083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8E9A90A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB471B2253B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C41D3578;
	Mon, 21 Oct 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alWgyXFB"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435B192D66
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541355; cv=none; b=KF7VbYP8m6D03CywiUfTtb/grJoRgE+Zni9plB4DvoxMCJrWhI7ZmC0g8ZpLIrGIYRYQZH7xVUfy1G8pzwqFdqu4ntqxRk4T3EjYudXidb+wFWW00Ny66T7twed3OajTGG5Cc0kjDacUteyBuHKcohs9u3HLk5N/SFWW+ptwY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541355; c=relaxed/simple;
	bh=I6t9p1EaDfvb/Eliq/u4F2cQjKpPa4rONmqDu33+ZwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka2JkPvrQlV/MOeSoRSajXxQb7W4wYYX3lJUmFCNenM6/vrJr9qhi4JgrNvEcKH3C4dGjvYdi7rBlkqvvUkMFlycSuUVwGzje39tGmwtWXWtLe/NpboePILM5gAC3f3UZ1mcotogrl3j78HBEbjckcJFmoV7S+tnVAL7mmW4kbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alWgyXFB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d399891d6so1225000e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729541353; x=1730146153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7UfXJmHqQAN/EECC23EYEuOCLTpAVln9L8WakW7sCk=;
        b=alWgyXFBA+H0T/A3mNimKB8uiUJKi7VMNRYQ25fgCJl5sQivtMxQroqoA9BZsAdFuB
         J+q4uYFwFSUfcgvMM6viDc3yHNd5oBntRHArhdvXxmZlo+wvUtjccmrJc35hAlS4Br8g
         i4DLfW2W5NdV0pNwrams6S9Z+6FAsudakGnggyx0i375aXIOpKygik3XRZh91FInpwfV
         SE1waY/KyKTWyuJLHtkWr+Wdm6+ftqmpJwmzxBaLFi4OyvqyFPcsFXRATbS7cZsqHOaZ
         JLhBR3didFUqdrl1Qzxyw/QWhztE3Q71NIjgTLLUSLoBb/g4JFQanH+nQFIk29HIyZ4P
         rm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541353; x=1730146153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7UfXJmHqQAN/EECC23EYEuOCLTpAVln9L8WakW7sCk=;
        b=c1QVuy8uBimzKnUNrkSraoBG//NE1HEFUfhFxOD3/SrvK1CHPfuQgJauyaKCfhfws3
         qJsGnyiHNdrztNsjB6a4ny4YAxOGADt3ocVJPrkeZ1Ns+4JfPEhZ5Bsfb95fTOz9jhps
         VMJm8/aKfMFvYbbm9Q+7D2eYWp90anvDahSOl6TJwS1o8ndJbJzjCi3BkAGdrJxwSh9Q
         VX/yJ3qfkJd7Z/lXz84yk1heI3tjCpY+ucebQoDQnQgX1pW05Ckii/zUDWBHrki4I3YZ
         RgKyOEoIRpkSCz4FXSeFRzYQgu69+23k0oxo7Fb29YFLkb+pigOaxbuq6c24JSf75U8T
         K1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNd9dj3vc3362weKHDvmDAmEiGqD7VnW3jjmJKYjnmI3SJ2hT926EXL77yriBHpnJMWWCpRMdU3z7Qhv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCh7FKu4RpTs2z49jeW3Dn3rXu16XHgbms4uDP0Bq5lD5idJpZ
	Y7on2h8MOC8L4CP0rptdNRKz/q5kFvYFmkWVrGx4lUm2TKeOurLvpFqtV0+tgJ2oCg70VcdeacR
	fH57dMAlrHv3QJ9737DD/0SntqpJDhoQITqF0Gw==
X-Google-Smtp-Source: AGHT+IHOy4P9Q03evxUVUvw+iLlP+PcSvEmnXr9naHrpQxbtIPqDsLLua0p6Q8JDW2ufPcobKza/hdFknJsTy785kG4=
X-Received: by 2002:a05:6122:179a:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-50dda180bdemr8605836e0c.1.1729541352168; Mon, 21 Oct 2024
 13:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102249.791942892@linuxfoundation.org>
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 01:38:59 +0530
Message-ID: <CA+G9fYtXZfLYbFFpj25GqFRbX5mVQvLSoafM1pT7Xff6HRMeaA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/91] 6.1.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 16:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.114 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.114-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm allmodconfig build failed due to following warnings / errors with
toolchain clang-19.
For all other 32-bit arch builds it is noticed as a warning.

* arm, build
  - clang-19-allmodconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build warning / error:
-----------
fs/udf/namei.c:747:12: error: stack frame size (1560) exceeds limit
(1280) in 'udf_rename' [-Werror,-Wframe-larger-than]
  747 | static int udf_rename(struct user_namespace *mnt_userns,
struct inode *old_dir,
      |            ^
1 error generated.

Links,
---
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.113-92-g6a7f9259c323/testrun/25501845/suite/build/test/clang-19-allmodconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/

metadata:
---
git_describe: v6.1.113-92-g6a7f9259c323
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git_sha: 6a7f9259c323c90fd1384904b8d547666568a716
config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/config
download_url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/
toolchain: clang-19
arch: arm
config: allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

