Return-Path: <linux-kernel+bounces-310546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34733967E1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F668B223B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7353FB30;
	Mon,  2 Sep 2024 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLzN0hG/"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E8282EE;
	Mon,  2 Sep 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247272; cv=none; b=VPQTjmcv3zd2Du1Mr19XLTmKXWimjnDHANv1MtHifmUWwQQLoVyWhL9fkNObUOkPAXW5meZbke19mBGGnFKhhESrUSaroBEb8KwMJZXgfP3qdXixUpuHxE4xYtAVe65qA4sMpkA1cuZouGid3boAW38xBWPtgm9l6PrteeS4lbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247272; c=relaxed/simple;
	bh=y9axUGR8EfqxZAHiydHEX6vOQWDyEvg4o2WuDvwdcn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPCdfe1fNtxOEea+YJJrc/8DCefJvFnGG8YrifvoYy4/e4jearJHJj37jOyoOq/xUUBAJp1HOlPpm0KJg4fYEA3oYhseJh7PO/WeM7ZLcraE9LsitLwnHbeA4uZLJ+X0/0PTWKUoHB8Toq2YSr6yI93FebNZpZIgwXC/iNW0djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLzN0hG/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8afc9ff3so3212191a12.0;
        Sun, 01 Sep 2024 20:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725247270; x=1725852070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io0s+dCAmw2DOjaXylSZmDvypE1DTOx04bqDl4bOCME=;
        b=PLzN0hG/4irk0DilPzSt8howdyfjiQWkRKYPDnMpB2bONWrHWkNYT07dTrH7K6ONia
         yRHyf9U+8Zaa88qGwwtYBZOR7Er9ZNqDaAw7Rhr0AmRru/J/kKuM4sDvEtCXsa62BiGa
         p50FF1XUUxPGxKbNU8hZ09yAfcc2rwN9LyKOL6qbFS/tE573R/RV/SrR9SGSJVrPrjfy
         56E65j+mTkF3BYgiStcDogehoustJaJuX3s+l8JCjLfaZMBCYZiwQkq2mziTsPnhv7tG
         /75Wvsf/2OHojmKR8rPTaKzMuDowQWSX82zH+/g0WbYYvH+Ie0SGgA7ZiEMEOO4LA8I+
         Wa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725247270; x=1725852070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io0s+dCAmw2DOjaXylSZmDvypE1DTOx04bqDl4bOCME=;
        b=dMhE5gakU3juYwymeEOMKrfH8mcVH4w9HQTIKH5baXvMUHZI5bvWsNUGm8hpvO2OXu
         ULInSPh/pUv8bPLxHtb4V1UTU/d0Jj86sZAqlmJCxu6C3Uuy9hE57IZqIMQKwsFgFRL8
         MBfsvGgjMNcPzV9aqYVG9YrArhPYkXNMAXgqdU0Uscolp9teNzp9xD87TfsbXcA0IY/n
         rulBYexUveP+zBs90C647rhcVl+67r2FAJiqWQh8NevIuwrI3aaa1wSaAtwSu66d7mZe
         Cr0bGy8YaQRvxy5IgTlodatPG8luooE41J/KDcLn0zKsYjJtNzHf24SAL7spkT3BsaUZ
         BH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVkEFnY9CDNWqye4Y0Pd485TcDaRJRVwH+58xdv8XJTGzaWa1Bps2H1cHT02qfsMOFrmOghlY9FuLk=@vger.kernel.org, AJvYcCX+/7QZFG+6bxgrhT/T26ARYcmoNAgxXaxfI0l/L/Xi8nr50zI9aE3hZKMf5R27KKGlJIRX047AgQClBe4w@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXnyCH0T3xep6Dz7Wciwb7fn+psMpY9mHYO+MTjAMETryMsBO
	V4yzL3S75quSpcz/dVwn5P7j1X/jBlkwodeWuMXBZVJpBRuFStVRMFfy0g==
X-Google-Smtp-Source: AGHT+IGl3cgFt0BFw7/Mok21dhJTcmR4ZEFf8lmZSNP541apI10NG7rJBtzmFKS+934r9Yn3AxsQSg==
X-Received: by 2002:a17:90b:191:b0:2d8:90c4:8a9 with SMTP id 98e67ed59e1d1-2d890c40930mr9938904a91.18.1725247270003;
        Sun, 01 Sep 2024 20:21:10 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84461411asm10441678a91.24.2024.09.01.20.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 20:21:09 -0700 (PDT)
Message-ID: <129f741e-ab25-4954-8d30-39746dea2d3e@gmail.com>
Date: Mon, 2 Sep 2024 12:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: YanTeng Si <si.yanteng@linux.dev>, dzm91@hust.edu.cn, seakeel@gmail.com
Cc: corbet@lwn.net, hust-os-kernel-patches@googlegroups.com,
 justinstitt@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com,
 nathan@kernel.org, ndesaulniers@google.com, siyanteng@loongson.cn,
 alexs@kernel.org
References: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
 <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
 <65f5467a-5c31-4d35-b0a4-e163429e98c9@linux.dev>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <65f5467a-5c31-4d35-b0a4-e163429e98c9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2 Sep 2024 09:32:08 +0800, YanTeng Si wrote:
...
> 在 2024/9/1 14:03, Akira Yokosawa 写道:
>> Hi,
>>
>> I'm not Alex, but let me chime in.
>>
>> On Sat, 31 Aug 2024 17:34:11 +0800, Dongliang Mu wrote:
>>> On 2024/8/31 12:11, Alex Shi wrote:
>>>> On 8/31/24 11:48 AM, Dongliang Mu wrote:
>>>>> +目的
>>>>> +=======
>>>>> +
>>>> there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'
>>> What do you mean by "sign incorrect"? I check the html rendering in the
>>> vscode. It seems fine to me.
>> You are right.  There is nothing wrong as far as the reST specification
>> is concerned.
>>
>> Quote from https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#sections
>> (emphasis by me):
>>
>>      An underline/overline is a single repeated punctuation character that
>>      begins in column 1 and forms a line extending *at least* as far as the
>>      right edge of the title text.
> Yes, I guess we should also think about the reading experience
> of readers who use vim to read kernel documentation.
> 
> Because Chinese characters are already very neat, sentences
> and paragraphs should also be neat, otherwise the reading
> experience will be poor.
> 
> Let's take a look at some examples: (copy to vim)
> 
> 整齐
> ====
> 整齐
> ====
> 整齐
> ====
> Great!
> 
> 
> And
> 
> 
> 不整齐
> ============
> 不整齐
> =========
> 不整齐
> ================
> I think this is a bit difficult to read. What do you think?
> 

So you are talking about your personal preference, not about what is
technically correct or wrong.
And you are exaggerating by collecting them in one place.

If they appeared springily as title adornments, they would not bother
me at all.

At times, especially with a very short title, I'd like to have a way
longer adornment line to make it stand out such as:

  整齐
  ------------

Of course I don't have a say on personal preferences and I think
maybe I was stupid making a *technical* comment here in the first
place. :-/

        Akira.

> 
> 
> Thanks,
> Yanteng
>> HTH, Akira
>>
>>> Dongliang Mu
>>
> 


