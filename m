Return-Path: <linux-kernel+bounces-278192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D694AD22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612E51F2986C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83613A250;
	Wed,  7 Aug 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lhy9+T+I"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97F12C54D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045337; cv=none; b=CAXDuuzKHZKgPG2r5I3l48XcVX+JWXrHj547V0TC9pd5OLXpAX4k1rq4xaYpZ1OlkVlQKs2YWlIqZ96wxhzhq3cQofamMPVcsihimvxvwTlJe2wqM2SckTyYN0O4fdkFkfiozlFhm12N1xRDDoWC42m+FKbqOF7iVD0rZ1RntQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045337; c=relaxed/simple;
	bh=p7PVqR202pLZcsTbDjLFYNgJzn0bloqG+abqcVgvaJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIqAyFiYJGD+dmCE8ipwFSkog6O2UEMVgnpEt0VvxO+YqJ79czkHHxtzf09WvcY4uVu4gxSlh5oprpmi4nIu3vrEHQiqNeJdab0NKKw27itIWiXRvx9tZYXbzVpdKaBdwsIVwKLL+UC4a3QynECGySWKXKGUMTVWuKzIdN10/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lhy9+T+I; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39aecad3ea7so1372355ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723045334; x=1723650134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuwHjHFvIH5yzRbowDpjPZeGCKe893MON8qjCHt6NA8=;
        b=Lhy9+T+I9SlgQZCWx24/UGQHRvTeLwvMIeRMfwswfx5SfSSA3ytbsYDKCEyGTdLHOv
         WorBAKpn+AFeEMMni3W6jXM+vSCA9v1f5gUrWZ/me/iGSDGAwRJw/BWSleH/ZOhVlCMd
         YFWmO8cMjBgCh/ZZv51O7qVoSyNoSdohO0CUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045334; x=1723650134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuwHjHFvIH5yzRbowDpjPZeGCKe893MON8qjCHt6NA8=;
        b=I/CmCiqCqtAZ9jJFL4SU0bNpIDzIeFaE8pzTVA/23HOGIuDiXWW47qj4zowdhsL31J
         0Wvm4Dk3ODLxztMPQ6LZIJSBZpnmGbCGDIHmE5lpxSyrrxQtEn4K8zrXmI2JSfMybNyY
         gE7QXJu7gDww0bnJZMc0WuTom+OPHVyuanVJLCUc8hUY/8r0C0Fr82qY/Nna2+Ty0FCr
         WS95qnyXnGb8ZN5o/eJQNXl9eifLiK5Ml/arsLTWxpVvtKinDV6Y3HdFjNZ+u0dKBqVu
         n5bmsyYlah47Susa2d8MzOnOJJouRSa1lGKZ1fWhH4JKbSmXZDRzZPWlWkCG+dZzTHeA
         qYvw==
X-Forwarded-Encrypted: i=1; AJvYcCX/iHU9CZS7pO2FlbUKbAOyqTOU/PSRprP2pV57PxgetJSJPnoMKoT3rb5iiLm/lx9fVc9/Nb4RU0NJQBizswgQ6qmC1h/K0aXEbCNr
X-Gm-Message-State: AOJu0YwZ5naxMq6Wrz5eFQ8grZP0ocWX62IZF27Sil6r0t8gILzeBEab
	6Zm1hq5TMwDv13I0qXyMBRbp4KgWiywos8uyeaTnMPwhvEi8qZHjvKGKNseSBL4=
X-Google-Smtp-Source: AGHT+IENm7ilj2AMmEwQJYpawRWrkgTZs3Cq1oL1+5AjSJCsF6nenoG7T6ZS8wtXFNT1iOwrbP88qQ==
X-Received: by 2002:a05:6e02:1b0f:b0:38e:cdf9:8878 with SMTP id e9e14a558f8ab-39b1fc6194bmr121613445ab.5.1723045333621;
        Wed, 07 Aug 2024 08:42:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab4f73sm45805565ab.39.2024.08.07.08.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:42:13 -0700 (PDT)
Message-ID: <2dfa76a7-eeae-4b05-bfcd-684ae7ade963@linuxfoundation.org>
Date: Wed, 7 Aug 2024 09:42:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix a spelling error in a doc of bcachefs
To: Xiaxi Shen <shenxiaxi26@gmail.com>, kent.overstreet@linux.dev,
 corbet@lwn.net
Cc: javier.carrasco.cruz@gmail.com,
 "open list:BCACHEFS" <linux-bcachefs@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807071005.16329-1-shenxiaxi26@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807071005.16329-1-shenxiaxi26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 01:10, Xiaxi Shen wrote:

Missing commit message --

> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
> ---
>   Documentation/filesystems/bcachefs/CodingStyle.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/bcachefs/CodingStyle.rst b/Documentation/filesystems/bcachefs/CodingStyle.rst
> index 0c45829a4899..01de555e21d8 100644
> --- a/Documentation/filesystems/bcachefs/CodingStyle.rst
> +++ b/Documentation/filesystems/bcachefs/CodingStyle.rst
> @@ -175,7 +175,7 @@ errors in our thinking by running our code and seeing what happens. If your
>   time is being wasted because your tools are bad or too slow - don't accept it,
>   fix it.
>   
> -Put effort into your documentation, commmit messages, and code comments - but
> +Put effort into your documentation, commit messages, and code comments - but
>   don't go overboard. A good commit message is wonderful - but if the information
>   was important enough to go in a commit message, ask yourself if it would be
>   even better as a code comment.

thanks,
-- Shuah

