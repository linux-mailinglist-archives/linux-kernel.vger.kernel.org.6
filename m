Return-Path: <linux-kernel+bounces-382443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258B9B0DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7AFB26105
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF61120D4E3;
	Fri, 25 Oct 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="o4+O51VN"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4AD18B462
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882339; cv=none; b=Ftp1yXsHl1rsweiyudaNQIA/usXfIDX0/xqXbcgd8Qnx8FDU1DjldSdHxMl+dS1i60zJxkoJDdIzUVmmcmscAgc5pmpMhyaup+ghNp0/1D7KiS2w1IlXBwXGIEtu8slPMNP4iGnqrRttB0R8dKo+Ww/TC9oQr3Qyv3jQC+9525U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882339; c=relaxed/simple;
	bh=mQ/7yszNfD44DNxwgZjb05j7JClG4c0ofBvaVc8X/Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF0OC0k+DMW8HhlpNT2X3EtedMW00mL3ocGa2A1ltERFjGJlQLAZKI3qzjjABwlCWxN6IyKpFsY6Ln4kRH3lBaxno3gLj/+MpwBCnIOln4suO+/2t8LRdo6xXU+7Bidc5ax6op+SqTSbLaJIhqH4sOtprVZ91N4j0GNWdtol1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=o4+O51VN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso3110967a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1729882335; x=1730487135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1lYbNqcKOA68YTts8lRuLKf+vXgT6yKl8RvaoPZy8Q=;
        b=o4+O51VN9YqVuATcsFGKjPRliJfX3Vl4bQLUcYKcB9al+9j+1to75sffG6r/9nY/au
         zm6z5GncMhWX6vaJirTUrx/fUT/8s4hm8WPVrX14BQrm22eW8V5kvNV8VTrqWBY1u8aa
         Kq2b8dvKE4YI+CbPWrm8kZ1r4copIB725tl/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882335; x=1730487135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1lYbNqcKOA68YTts8lRuLKf+vXgT6yKl8RvaoPZy8Q=;
        b=CZYvhtQR4zw7mhlgc1eUlPtfyt18G9ZLXeusyrzP4xb86p8rXjTzxMWQi2qjxMZzwi
         ng8jLxm0LY5AweUI520v47nybukXrxMreJ/Pq7Zw5xTLwntUrXrISJXq4vDXROp1BTSE
         NtF6s3MurkM3YSlKglDkze7Eky6t1aJqz4gmZyBQTB6OH/ZX0q39kGxTeQvqLTydwoLh
         XQh6a35eWXv3BIgxGEHYco5V7leOyDQTcdALJXHhopUamBwZxVx52TCn3QwVT6xsCCvD
         NGxf9vM+glkzZR9AHmsp80fG77I8IfwF8vEfYT8LZm6W9wYjGs0Srol2oaN/guUSAXyQ
         Zqfw==
X-Gm-Message-State: AOJu0YzD9Q9jo6ALBCJchvv8T+HNaElrYlE/0O5pMiIEwSnb19UmRu+c
	6zq0DC1dW7KDhIis2hvGpqCdlW46aBWz+12VUyTrwpu73a0N5HDKYGrTBvBE2Ks=
X-Google-Smtp-Source: AGHT+IEZdYJFB6gb+Q9Sm2ZEt60M/ddr1PPSufgX+08hfD2+B8IAJ5xbMoSPT3C3S1sHIhE3UjUakg==
X-Received: by 2002:a05:6402:3495:b0:5c9:7dd9:3eda with SMTP id 4fb4d7f45d1cf-5cbbf886467mr258815a12.5.1729882335026;
        Fri, 25 Oct 2024 11:52:15 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c3da7sm882499a12.55.2024.10.25.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:52:14 -0700 (PDT)
Message-ID: <99d67545-8dfb-4987-b723-47ca5b0512a7@citrix.com>
Date: Fri, 25 Oct 2024 19:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
 <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>
 <20241024184744.l3575coe4sx26hgl@treble.attlocal.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241024184744.l3575coe4sx26hgl@treble.attlocal.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2024 7:47 pm, Josh Poimboeuf wrote:
> On Thu, Oct 24, 2024 at 10:35:33AM -0700, Linus Torvalds wrote:
>>>  i.e. when bit 47/56 is
>>> set and 63 is cleared, would it not go untouched by mask_user_address()
>>> and thus be speculatively interpreted by AMD as a kernel address?
>> AMD doesn't _have_ LAM. When they do, they had better not
>> speculatively mis-interpret addresses.
> Ok.  I was thinking AMD had its own version of LAM, though all I can
> find is UAI which is actually quite different since it ignores bit 63
> altogether (and isn't supported in Linux anyway).

Yes, UAI is AMD's offering to parallel LAM.

Perhaps the funniest aspect of UAI is that it intentionally doesn't
apply (i.e. no ignoring) for stack-relative accesses.

Now consider what happens when frame pointers are turned off and the
compiler is free to use %rbp for other things...

And then realise that you can fix this mess in 32bit with an explicit
%ds segment override, but you can't in 64bit.

In 64bit mode, most segments prefixes are ignored and %ds does not
override the default-%ss-ness of %rbp/%rsp-relative accesses.

~Andrew

