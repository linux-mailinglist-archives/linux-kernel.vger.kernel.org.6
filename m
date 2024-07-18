Return-Path: <linux-kernel+bounces-256009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB19347B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308861C214AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013B44376;
	Thu, 18 Jul 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g082bNpN"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCC537F5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282121; cv=none; b=u4/GvzgqOz0WQrznkLReEaLTbksagXgwxowkvnvPPSH4eBaH/4v/8vAa4ZFHtNPnxvW+soHS5nFEujhYC0r17a33IE9QnxJ9aSEdtELfCVL2UqxiPd8JKGqa4bOy2vsy7Eni9w97QdEfvch0sa/oHD/+QQo3NneygykyVenLLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282121; c=relaxed/simple;
	bh=rSfkrFDz4KiKGXWsrXStq34iGxTJPiKpgBeS1OUqDh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9yvJZPx3umCQoCauSyymZrsXK5SAfGKPcA0wfuc0WP6mcDtPOFPqdSdg9E0Gh95b8nr4/sIbju4HLhObEbHPgknlJVa62reszxxY/yrienVK8cyx4/6O4GYtgkWh/Bb9UJMn4wcaOIdzEKKVt90JcgyXZn5RUoN1oLeJxPQdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g082bNpN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447df43324fso121131cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282119; x=1721886919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JNNTA2y2v2UAF3P22vk8HbPzpbKsgqxe7R/vkh0UlQ=;
        b=g082bNpNIFBvME9lkWvyc/ZTLXFFaPgrHjEB5oF85jf4OsLyQsT2dcqy3XxrmBuSL8
         9SEbde9D/0AvrFTr+awq6+AwIKhF2D4Hdcrn2u9O/jCLEwiqpr2H26Ok4EQ8qujMtvyR
         iqMFTJuc+xxtbe2CSxLi9TyyWlETv06LDbW1mNG6710B+IyQuFYnqOpbBf7Gp5qxcW3d
         ZswJDLpWGyNU3fPcQytEIovQAIiZIBf+2Ts5ikFJHLViBWRe9596ghgwgd1iPdokxh/x
         DxLG5iBq1s3W/c8oiyMxSfpWKaKHbNumhk0RMhiQoFn1n5yfChqINGONO5+C5h0zK6sd
         2JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282119; x=1721886919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JNNTA2y2v2UAF3P22vk8HbPzpbKsgqxe7R/vkh0UlQ=;
        b=SuKXz2+vslG+9tgmeyoOXcePOo1iCW7C+hGJ/z+CcTXTgKpYM5smTNbRaCOnUStJRq
         r7BUrvHiiYBplSHw/ZNx/gJgh7WJSGBQgBWNHXSU0lA3WDwKCP2Bok1VpiTkEFEl8Saz
         hRNM7yHhnyxjrig9blqoUBsO56IzdPX7ixiRGJcaetuTsXSdPt5VRzB75Lv6GO4T/crb
         V1JHq073EaeEElaSv0zRftsnrTGiYKJmMhkuWUqvZOEbCnf9eSG0PAbUdhvUtZrQTiO9
         L6v4F4awdJQuXEHb5HvnQ13L9nR0545WYSbxA/F+PeNEVLM99s3NkuXfCrEWpn1n0lqT
         ZFZA==
X-Forwarded-Encrypted: i=1; AJvYcCUPAR+lsvhdxgh56FPi/pJZet1/nn9kmtF139LSYOaEsA0mR04LIoacgoJd9fCuWXt25RtGmhFnyJyp4rsFyv9UHM0GaKkqpOcGoy5C
X-Gm-Message-State: AOJu0YyikW76uTc0I2IXMnfClmDFFq/k5gbz/MSAXTG0PPgxBhIFM3yU
	4GxL9NUSBq7S2zgzTsNBUV+x/aLZY6ZnSU2qboRm46PiLHeR+R3LNxVW5TibcwIvenZGbJeIRtJ
	tR+qzf37C49ULAkghr8zv4dAtRut5hjxPbd7Z
X-Google-Smtp-Source: AGHT+IG649NqMWZT+4BLfuIoUbzf0lvwb4NNtCdPjj8u8gv1/q6HTZZgpJ8R8vjsNUEJP8MN3vp1oxKX3rY/DXV/c6g=
X-Received: by 2002:a05:622a:a70c:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-44f92572a39mr1212331cf.29.1721282118976; Wed, 17 Jul 2024
 22:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717203521.514348-1-bpoirier@nvidia.com>
In-Reply-To: <20240717203521.514348-1-bpoirier@nvidia.com>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 13:55:06 +0800
Message-ID: <CABVgOSn-e1rnMG5Syor2CMS0+DOeL-L2SpWRVB7vmMr4sxh4iw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add detailed explanation for 'N' taint flag
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thorsten Blum <thorsten.blum@toblux.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 04:36, Benjamin Poirier <bpoirier@nvidia.com> wrote:
>
> Every taint flag has an entry in the "More detailed explanation" section
> except for the 'N' flag. That omission was probably just an oversight so
> add an entry for that flag.
>
> Fixes: 2852ca7fba9f ("panic: Taint kernel if tests are run")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/admin-guide/tainted-kernels.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index f92551539e8a..700aa72eecb1 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -182,3 +182,5 @@ More detailed explanation for tainting
>       produce extremely unusual kernel structure layouts (even performance
>       pathological ones), which is important to know when debugging. Set at
>       build time.
> +
> + 18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
> --
> 2.45.2
>

