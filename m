Return-Path: <linux-kernel+bounces-328583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AC978628
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E81C22D83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1442D052;
	Fri, 13 Sep 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T0pWkR+K"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3147A73
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246126; cv=none; b=Jz2P6kk1fV1SUTp4cCqXBg3kHamYYBAJUKlGLCZH+hjLeP5BbJSJK3rFJ4v/XPavx3yWv7leDPlyfDF+PK08sT8cLkMaXKJ5cRxBweZO4KQRiuF4cjdKa0fJRjo9n/lQJAY6aoOBOczISzjCiJ5QsVUupWM5Hb+Rae3SpTKJkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246126; c=relaxed/simple;
	bh=+zTJgyJqVywynjJkOZsN8T6rAAR9NXuTLXz50LOECkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv4riP9c/6I6sdTs6QnwMrGIm5RM4DSzZxuCvl9b2WK6ZGPeF+6wBPWnQaxufHPWND7InsuksM2tAXq3a5S8YPluLuq9R+GRl/JTor6NGz0sk0dd/54pLZlWRonLOfFLMveILuALYcyrk/6jttNcVw7yg+hQCil5JyUQorEEkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T0pWkR+K; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-829f7911eecso115414039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726246123; x=1726850923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReW0m/5Yz+FZyKQtEYV/Kkq1KJtzSn0264yh0o5bURQ=;
        b=T0pWkR+Kzvnd996RLEm2g5NqDbJPJKqQcwkCxXwanIA/2lIXEj1VQe/Cjw1UxrA11G
         hvNtWDWi/tFpTtwrVpi9IpDB/ullwGvyyS5Fw6Pwe1JQxUC3INar2o4m0pgEBAMiOpAv
         UcHrb9LJ2JOM1RGlXze9CujAKeFEF44J0f5LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246123; x=1726850923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReW0m/5Yz+FZyKQtEYV/Kkq1KJtzSn0264yh0o5bURQ=;
        b=A2Ciy+D/fa6aZMUJiYF4zqnMTeeafuFIR9sc4cFHr/VzLkLE+XAZFeHT14YZbiQxjE
         iGGNlJCP0kXmtju3lnutNtdbasTTgyCMhqDYWi3xFKyUCC+HjVcY4/kcfRddwQ84D7lT
         AKGQfaQ7NM/ndmhabuqQmyOitr+XZtBbD6qPXkgJV6p+tUL7CE3JB21k5C5wIFwo2tyO
         dYklSW0O9GqXWiI86hYw25QNw02cboQxdiHQpQrc/WHeYG5TEAA+e0JlTZiXVz25LQ7W
         JzJt9y6mkER1IFk3oCtlhdwVIHoAGyIrRGjSleNQTBxl1EurKgHthT/M0gQhAaM3L5QF
         Im9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW786JEh8Ivh1Qzg0AfRHFpDDavD6YvP5+KmoZEl3R8foKU7NdcX0rpYevTRIyq6/ER+Kk3IaP5djcQ028=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza457KXC4RlxoDEnbNO+xAQ4OJ75suYN6KCZrqi6x/Km2nIIFY
	AeWd+koGtJo2FEvd0k1NLdJFkFpULkA78Gn9blyQp2TRl5RjrZ+xLtpQP2hdHk0=
X-Google-Smtp-Source: AGHT+IG0iy0TYcrdtAOxYoAi8QT+bUWCRbCq1fB9g7J/Slnos62IyzhRK2xzaUZk4I0W397+VIw0QA==
X-Received: by 2002:a05:6e02:1b07:b0:3a0:4df8:1054 with SMTP id e9e14a558f8ab-3a08494ab1cmr72801895ab.25.1726246123109;
        Fri, 13 Sep 2024 09:48:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590160dbsm38719405ab.80.2024.09.13.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:48:42 -0700 (PDT)
Message-ID: <e35af04e-a8ee-42e2-a2e0-c369a118044b@linuxfoundation.org>
Date: Fri, 13 Sep 2024 10:48:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, "John B . Wyatt IV"
 <sageofredondo@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912230102.157534-1-minhuadotchen@gmail.com>
 <ZuRqkbJixRQEScYA@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuRqkbJixRQEScYA@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 10:38, John B. Wyatt IV wrote:
> On Fri, Sep 13, 2024 at 07:01:00AM +0800, Min-Hua Chen wrote:
> 
>> To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.
> 
> Would you please rename this to .swg instead?
> 
> '''
> 5.1.1 Input format
> 
> As input, SWIG expects a file containing ISO C/C++ declarations and special
> SWIG directives. More often than not, this is a special SWIG interface file
> which is usually denoted with a special .i or .swg suffix.
> '''
> 
> https://www.swig.org/Doc4.2/SWIG.html
> 
> I tested it and .swg is not removed by 'make clean' or 'make mrproper'.

That is expected.

.i extension is used for a C pre-processor out, hence the need to
mrprpoer and clean remove it. Because of that reason, using .i
will not work for swig interface files.

We build files to debug problems and to check the pre-processor
output. So changing mrproper and cleans to not remove .i would
leave the tree dirty.

This is the reason why I wanted to understand the problem to come up
with a solutions than renaming the file with .if extension.

Please add this information to the changelog so it is clear that
.i extenion will not work for swig files that get added to kernel repos.

> 
> My apologies for the extra work Min-Hua. I can send a quick patch
> instead if you wish.
> 

+1 - Yes please send me the patch with renaming it with .swg extension.

thanks,
-- Shuah

