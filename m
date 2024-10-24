Return-Path: <linux-kernel+bounces-379106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05119AD9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336FA1F227AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928B14F12F;
	Thu, 24 Oct 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ98TJJe"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969CD4D8AD;
	Thu, 24 Oct 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737659; cv=none; b=nXcsetYQMajSv8wdVqKZhrV94WwQ2EOrfpOn5uNBirwQEnsArNVYtNUZLsuXQ2kmtkD1nNNyl8KZMC/xctm4rYK1oyEyIDFx9g7e3SDUr8JuD970hLrgI8grDRtFsg47fneiPgNEVXgjzxl20rBiVxclb9JyIsBnb+gLDQ2BCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737659; c=relaxed/simple;
	bh=bys3ISKeLd08WWgCorxKWPccYot/hU5DGRV8BYhyRU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfpqcUmrz2CXnlQ4HfGY8idOZbdDVmRUNXf4rjbzGBiesBRjLA/nXEpPpaHOvoiUylISRewfqXj1VbH5W9xowj39uujwyuR0unn4j2/veoSdwW1xtw8BuPftu53NBKt41WOIvpjGLO2cW6TmvPAOdiz6qvmiw6tnbZhImfiak5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ98TJJe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2972abc807so497320276.3;
        Wed, 23 Oct 2024 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729737655; x=1730342455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIxP96exfOoa5CX6fTPMX7bSuvLMk6J+pOAMwb8dHKk=;
        b=UQ98TJJedSaWk/BIcgcy6neGLu8Tvsqj3YjBSMQW7tVOksTnPujcKcKKeeCN/EhtFK
         RFfnX19YNk+gTIgP2wa72IhOCkYYqHqiBvtOpZchiXverSuA8UmTgv90K61Beh24lgTm
         ijuHk7/CRCM7zwOsnqVLgazA+nu8yTSzEAJn7S4Tessj7QlUPuICAGZgJsT7EraItz9O
         RwUaHkxKGUZ+NWCJErZMq4+GiU5SUI1wjrvlrFgOEeGfmVQ5Xojxd5SzAUuQ7+Qf87tD
         DU11c0Us1Vd8OEEBSEB3Vl8vUdJwRKe+86M1hJpIFbgbgr9rlsKJhkxbURuzPlUvEfU5
         7icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729737655; x=1730342455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIxP96exfOoa5CX6fTPMX7bSuvLMk6J+pOAMwb8dHKk=;
        b=xHp9WikM/u7RzfJHp3I1u5p9CfAfr/a6jUq7y/EWu41DFTbiN4xu3KT+TEr/hEb42D
         TNRIQOosYdJfGkCIGgE9YITmo6iUz+geK7m/RjKQ3BIA2fprfoM1kUyMb3ydmnCuyBPb
         XUc4BfAH/Menv1RaLWEOMuEVT6CCOhiZeZ34aWrzrJOaFqGVfdLYTItLjJb6rcTcNpHw
         /XLGUw9HRBRUBYUDeCFeKK+Zj9uNNSmRK5YrCF1GTKn/B+5EYlPvJiTQiieFa3r7X4dU
         kno5vezP+TRZk5E4gr6vNqDVyyqkBdSagCYwF/9j+COF6P2pvivY4XMsPPNZF4u7Vxhs
         3W+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkOQQxA6atYh6w6Iqfyz+zc4LoFrb6kj3joRbpQEPuIYKv8OjVslM81sTUaRtnqar/BIAfJwlXgsoWeW/M@vger.kernel.org, AJvYcCWE7epFp01HVJ65FTtz389eaPTCu1wyhYMjgG+xbCcFRyADyKBY+sj+c2GRCgP0KmduJAY7gLB/34kLJbLwvY0=@vger.kernel.org, AJvYcCXkFcJMInH6MdNILu8GEjbJ0vpUlcDi49IO/EagQmd5fJSHg0bxhm8NbXCvAfdBzYgilXyfVXbvzFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNx1rSE2IFdMyabBYPDtXATWSohjyMVmaMybhTo9Rctjpk/KQ
	64NchTvRiiR3UoNK11duf6tQe/8FVurhSHeN++5xTxPGw5ApI9iZ
X-Google-Smtp-Source: AGHT+IGH8NHWvZDdQphM1F4EUF4yjz11pGp4Slih3bjoBRhE+aogWpjkHaoDgzzI9J0pimZIRIZn4Q==
X-Received: by 2002:a05:690c:dc3:b0:6e2:aceb:fb34 with SMTP id 00721157ae682-6e85814ad59mr5773367b3.1.1729737655457;
        Wed, 23 Oct 2024 19:40:55 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ceecbbsm18146457b3.110.2024.10.23.19.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 19:40:54 -0700 (PDT)
Message-ID: <e0c34a1b-6801-4ae3-b04f-56dbce5c76d8@gmail.com>
Date: Thu, 24 Oct 2024 10:40:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of
 process/programming-language.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241023062750.849951-1-dzm91@hust.edu.cn>
 <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
 <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/24/24 10:30, Dongliang Mu wrote:
> 
> On 2024/10/24 10:21, Alex Shi wrote:
>>
>> On 10/23/24 14:27, Dongliang Mu wrote:
>>> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
>>> programming language section")
>>>
>>> scripts/checktransupdate.py reports:
>>>
>>> Documentation/translations/zh_CN/process/programming-language.rst
>>> commit 0b02076f9953 ("docs: programming-language: add Rust programming
>>> language section")
>>> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
>>> Intel compiler")
>>> 2 commits needs resolving in total
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>> v2->v3: fix warnings in the make htmldocs
>>> v1->v2: revise the script name
>>>   .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>>>   1 file changed, 30 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
>>> index fabdc338dbfb..95aa4829d78f 100644
>>> --- a/Documentation/translations/zh_CN/process/programming-language.rst
>>> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
>>> @@ -3,25 +3,22 @@
>>>   :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
>>>   :Translator: Alex Shi <alex.shi@linux.alibaba.com>
>>>   -.. _cn_programming_language:
>>> -
>>>   程序设计语言
>>>   ============
>>>   -内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
>>> -在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
>>> -
>>> -这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
>>> +内核是用 C 编程语言编写的 [zh_cn_c-language]_。更准确地说，内核通常使用 ``gcc`` [zh_cn_gcc]_ 编译，
>>> +并且使用 ``-std=gnu11`` [zh_cn_gcc-c-dialect-options]_：这是 ISO C11 的 GNU 方言。
>>> +``clang`` [zh_cn_clang]_ 也得到了支持，详见文档：
>>> +:ref:`使用 Clang/LLVM 构建 Linux <kbuild_llvm>`。
>>>   -对于一些体系结构，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 编译内核
>>> -的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
>>> +这种方言包含对 C 语言的许多扩展 [zh_cn_gnu-extensions]_，当然，它们许多都在内核中使用。
>>>     属性
>>>   ----
>>>   -在整个内核中使用的一个常见扩展是属性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
>>> +在整个内核中使用的一个常见扩展是属性（attributes） [zh_cn_gcc-attribute-syntax]_。
>>>   属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
>>> -重大的语法更改（例如添加新关键字） :ref:`n2049 <cn_n2049>`
>>> +重大的语法更改（例如添加新关键字） [zh_cn_n2049]_。
>>>     在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
>>>   即使其速度较慢或执行的编译时检查/诊断次数不够）
>>> @@ -30,42 +27,27 @@
>>>   ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
>>>   请参阅 ``include/linux/compiler_attributes.h``
>>>   -.. _cn_c-language:
>>> -
>>> -c-language
>>> -   http://www.open-std.org/jtc1/sc22/wg14/www/standards
>>> -
>>> -.. _cn_gcc:
>>> -
>>> -gcc
>>> -   https://gcc.gnu.org
>>> -
>>> -.. _cn_clang:
>>> -
>>> -clang
>>> -   https://clang.llvm.org
>>> -
>>> -.. _cn_icc:
>>> -
>>> -icc
>>> -   https://software.intel.com/en-us/c-compilers
>>> -
>>> -.. _cn_gcc-c-dialect-options:
>>> -
>>> -c-dialect-options
>>> -   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
>>> -
>>> -.. _cn_gnu-extensions:
>>> -
>>> -gnu-extensions
>>> -   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
>>> -
>>> -.. _cn_gcc-attribute-syntax:
>>> -
>>> -gcc-attribute-syntax
>>> -   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
>>> -
>>> -.. _cn_n2049:
>>> +Rust
>>> +----
>>>   -n2049
>>> -   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
>>> +内核对 Rust 编程语言 [zh_cn_rust-language]_ 的支持是实验性的，并且可以通过配置选项
>>> +``CONFIG_RUST`` 来启用。Rust 代码使用 ``rustc`` [zh_cn_rustc]_ 编译器在
>>> +``--edition=2021`` [zh_cn_rust-editions]_ 选项下进行编译。版本（Editions）是一种
>>> +在语言中引入非后向兼容的小型变更的方式。
>>> +
>>> +除此之外，内核中还使用了一些不稳定的特性 [zh_cn_rust-unstable-features]_。这些不稳定
>>> +的特性将来可能会发生变化，因此，一个重要的目标是达到仅使用稳定特性的程度。
>>> +
>>> +具体请参阅 Documentation/rust/index.rst
>>> +
>>> +.. [zh_cn_c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
>>> +.. [zh_cn_gcc] https://gcc.gnu.org
>>> +.. [zh_cn_clang] https://clang.llvm.org
>>> +.. [zh_cn_gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
>>> +.. [zh_cn_gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
>>> +.. [zh_cn_gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
>>> +.. [zh_cn_n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
>>> +.. [zh_cn_rust-language] https://www.rust-lang.org
>>> +.. [zh_cn_rustc] https://doc.rust-lang.org/rustc/
>>> +.. [zh_cn_rust-editions] https://doc.rust-lang.org/edition-guide/editions/
>>> +.. [zh_cn_rust-unstable-features] https://github.com/Rust-for-Linux/linux/issues/2
>> Hi Dongliang,
>>
>> Good job! Most of translation are good.
>> Just the above doc seems still English version, give them a zh_cn name may cause misunderstand?
> 
> Oh, I see. However, you cannot use gcc or rustc since it already exists in the English documents. We need another name to make sphinx happy. Therefore, why do not we directly use the final version of name? :)
> 
Uh, is it possible to use English version 'gcc' links in this doc? Otherwise,it make sense too. 

Thanks

> Correct me if I make any misunderstanding.
> 
> Dongliang Mu
> 
>>   Thanks
> 

