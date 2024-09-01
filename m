Return-Path: <linux-kernel+bounces-310114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66896752F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DB01C211E1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049C42040;
	Sun,  1 Sep 2024 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2yuhGLL"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D13A28D;
	Sun,  1 Sep 2024 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170599; cv=none; b=ojJkWH46+6d9pWVgU7zDb2VxwDZcVyxlzQpvUoNvfz2pbOam3JU96KpeiEaJcmYKGEsKHHx1hBLPPTS9m2OFTgOgqmSWJvKjtyvr3b9+rHztTT3bTAV9nmd6IJMxknqe0YbJZXvqyQaCIHyiwjeT3/LbsvdDjdMNVtuGa0sD+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170599; c=relaxed/simple;
	bh=gTaVx+TwHD+FJbillFONR4wr3k7gQ6JEyFsWWKxKwTA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mJI+xm4m356bK9OzV4bP/vtrtypsvQYhKLoKdTiiYAjWchiF02RNGWKqCrPY0GFOboIPnkKV17zz1HJR1BU//aubb21SY8zROi3zZEr5T01bd3gJhfHArN+gMD4Uq8CaXSQdz3IoyJCYfru11mzRaEz1wFNZm2WrpxJu5oKETHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2yuhGLL; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39f51371baeso3011055ab.3;
        Sat, 31 Aug 2024 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170597; x=1725775397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ASaKifyh7CAWP7KfJ/Pkn2CRTiEMZbywc4FPBtZowk=;
        b=K2yuhGLLDvNXd+wXc7Y9t2sRQ9GHc/lahQ4XnV482RtDIlR6z6blulohbUzd9s6NSy
         ginUCoOJftgRabsyWn5AIRa5fhi/aKGPP0fCeXc2yB84+DGFKnrkaOxfUWqaEj4CwX6R
         Xaoo40F4IRrX7sD62PxnHg91ItO1659hSUFOZzXMmm8cFGk6AqzLx80hm/9XATq+3Gn5
         HZNE05SoPUYZjvswnFoYsvj7uSHiBxHpZI153qxX8LxnjSZdxBmEy6cwBHSBi0JjqfhU
         DA0UAdCvgXIh3l8ov1N79Cb/Ld9Jeme8N4Vh4DfOnq3ehQSYxBgPsxGXkGc/m6KIPXG4
         LG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170597; x=1725775397;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ASaKifyh7CAWP7KfJ/Pkn2CRTiEMZbywc4FPBtZowk=;
        b=FMveowpsXyCjUt5J1+wJ0HAVcKml5MFnbtlnIImZ+vQ373RRceun7vZbKddJC8dEqn
         JiqIxGqUFl7HUulP2sp/UQsw1M3z72cC9Bd25fl6+VYmWlqVJ19obc1l58mgei0ghnHm
         AhQ2SHWMp1/nxU56KGW/qfkJBuWM2mm4IzsfSvnYdMS20C7+fLH/wl3izluKIz1eJU+B
         tUr9+ubaywfxh+cXa8t9skVnqnyKivXEZLo7wdKaui6YiBbIBaiVBe0PJzp5IX+YS4RP
         nG9lxi9KYaedJHFUwr84Stx0fQvuGTS8162Vo+kzbT26yPNl5/ZJyzGwNlJMBhgijlBF
         UPNA==
X-Forwarded-Encrypted: i=1; AJvYcCUx/D4AesS4reZWHgRusSH0MZdgvJ3bUgdw8Dly4fMZePvlAh0K/UVvjxbPkHZ0INbOrPyQRp4/cfcykreI@vger.kernel.org, AJvYcCVaBgQNahxnndBk/se9ZGDKIGd9WNGntLKC+qVScj6LnmUjLTM/Fj66B6Jp3mCBsSC11qxXFApwSYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MBX8KSPWuvED62BViXAa54sQRxeK7Xjh3cxPG5NUty9A0W7R
	aYL5oNNI5MgxrX/v3/Z7TM+frnG+qbkGv5g4BHjMQ9sL0yOXaHi8
X-Google-Smtp-Source: AGHT+IGw6QkiS7ytm3WVmlkoKhqjolc0dX880UP6OkyZZlWBmYHKwT4V+Nr35s91ww2YI7/yzG1CwQ==
X-Received: by 2002:a05:6e02:1cad:b0:398:16d1:6127 with SMTP id e9e14a558f8ab-39f37867c14mr129488355ab.21.1725170596927;
        Sat, 31 Aug 2024 23:03:16 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d92a5sm4631784a12.90.2024.08.31.23.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 23:03:16 -0700 (PDT)
Message-ID: <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
Date: Sun, 1 Sep 2024 15:03:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dzm91@hust.edu.cn, seakeel@gmail.com
Cc: corbet@lwn.net, hust-os-kernel-patches@googlegroups.com,
 justinstitt@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com,
 nathan@kernel.org, ndesaulniers@google.com, siyanteng@loongson.cn,
 alexs@kernel.org
References: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I'm not Alex, but let me chime in.

On Sat, 31 Aug 2024 17:34:11 +0800, Dongliang Mu wrote:
> On 2024/8/31 12:11, Alex Shi wrote:
>>
>> On 8/31/24 11:48 AM, Dongliang Mu wrote:
>>> +目的
>>> +=======
>>> +
>> there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'
> 
> What do you mean by "sign incorrect"? I check the html rendering in the 
> vscode. It seems fine to me.

You are right.  There is nothing wrong as far as the reST specification
is concerned.

Quote from https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#sections
(emphasis by me):

    An underline/overline is a single repeated punctuation character that
    begins in column 1 and forms a line extending *at least* as far as the
    right edge of the title text.

HTH, Akira

> 
> Dongliang Mu


