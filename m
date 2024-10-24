Return-Path: <linux-kernel+bounces-379095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D999AD9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F50B283791
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A614AD19;
	Thu, 24 Oct 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo3O6XgF"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAB4D8CB;
	Thu, 24 Oct 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736525; cv=none; b=UB7UbLJBvKQX9VD2HoGQkZ0HhB3T8Tbync0AZxtBfhiylEC0FK3iyH+Bviod9XTnvE0evDKTCfDJ99OHp7s6EFzRnYuHmNEjEuX6ze/0XfPsaheh2gEJY/dD4luipEZt+S4jsWrfutMqzjfPoa15dUvFBqeHDNEnZtIFuHGRSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736525; c=relaxed/simple;
	bh=m3Ot8oYn8Og7JeN1WvTnV4Zbz1ZuV/05Kmvb05VqKsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKBZHBYvPU9BPmopVbM2xsndbo7SDsuZIfd/kwKREUOKyDNvTXD88UZCX2T0bj/Lc5c5zVHloF+TycyF7Zq+/w5INt15gJgwW1Fq49XcciKDj9GIe70a/hFX+YiwVohbep0/IOAUVlqKIJkvVL6a7uF0jkwSWoHqdsnHdjVcJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo3O6XgF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso460424276.3;
        Wed, 23 Oct 2024 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729736522; x=1730341322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0GrkmMosGLeeGUqJPb2uCqk18kplfVZimJ2iFrxCRw=;
        b=Xo3O6XgFCXNNTtBXyVeUSonoH9Be1x/WY9aXhhuTSCuzTPjg2aFJgHrarLG2039ObU
         JuQUWRuy48l8EQXwA/sKT7QCwMD+GdAuI97wskSp7NmhCxPuBzLx9WlGywMEItaqQehU
         AdQ3+3Ftyw7xjJdAldkiIFTUKkN6hAiAw3TJLtXkUuPY3nYb6N9Meo180UYIiDI+ZMDT
         nmsBOHCpeS10/8L/cc7mJtCUzbm5G8w5pbocQhvXiVB8eOdh9gHEdsaGhyWjlTzNSRFl
         YroVXAveKPNMXqjgWI+UHqV9c1lR1/UhF/qKMPHHmpcaNT9RQkBnGzPbOArsf7vzD5XP
         tM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729736522; x=1730341322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0GrkmMosGLeeGUqJPb2uCqk18kplfVZimJ2iFrxCRw=;
        b=EAkXgnPSBxdXNRuqUM5S03PcGBvXrOi6lM+XwZUVVfvGhJwPZi3GUrpEtD7vv1m7XU
         5t+Z4GtVW5KiZMwYt2nGioIemIzN2P4bH7yv3GkmtQ3A/8oiygvHBX63b53z6tdjfRv8
         GUCC8XbHd6aRiliiY2NjlRO3ShC7qarihF1kmnOPyIV4AXsIjenPI00AVAH6MgoJ8lFi
         o2AQ5LLfiHyFOYLFndYpZ8kiGQYHtT3C43pEHS5W1f8j8pT28cRxs/fnK6V4ilHjXePn
         QDE7rGMmPoiBMmHKidZF2a/biaBePZMhOP6T9SX9Rgd4dYAsm9QKyBtT1DMmyY9w71vZ
         Q62g==
X-Forwarded-Encrypted: i=1; AJvYcCVcxTKtpvaJa6LiW12Py5wCDSIIHyULi+JSkzUx4k7QNVdBDMdow5RQsd7OS76HPJRNjUJbN94TSiMrMIONvgE=@vger.kernel.org, AJvYcCWev+msONZ2KdU9sI6iZORELexjxh67GeOB2LLYlcMHyiq7j+OJE7NvVusfRaifMosx3lMmthV8pVpBPA0l@vger.kernel.org, AJvYcCX2fO4ytlNX7Mevz1fcI2ovNfZ4tmtpNK/faOvc3NuWJrKv1PgZZF11OpirFscMOQlp+nE3EQy9zts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10ZLjh+nFGubeTFO95fES2ey5WT/mcN0cwj3EP1Pt1Y/YI17G
	J2PouFwkGurMcziNP0GbQ8qY5uA1VtLBjkgUDZlyptlo7nWrB8Q8
X-Google-Smtp-Source: AGHT+IEUu7KXxZFkflqposC4YCLigCJ+qVgqi9aBnoX0dNZcQbmujiyi2eoO6po+vUlEAx1yw3ClKQ==
X-Received: by 2002:a05:6902:1a41:b0:e2b:ddbb:1337 with SMTP id 3f1490d57ef6-e2e3a6e4de9mr5367390276.53.1729736522062;
        Wed, 23 Oct 2024 19:22:02 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc974c47sm1794099276.4.2024.10.23.19.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 19:22:01 -0700 (PDT)
Message-ID: <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
Date: Thu, 24 Oct 2024 10:21:47 +0800
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
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20241023062750.849951-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/23/24 14:27, Dongliang Mu wrote:
> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
> programming language section")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/process/programming-language.rst
> commit 0b02076f9953 ("docs: programming-language: add Rust programming
> language section")
> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
> Intel compiler")
> 2 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: fix warnings in the make htmldocs
> v1->v2: revise the script name
>  .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>  1 file changed, 30 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
> index fabdc338dbfb..95aa4829d78f 100644
> --- a/Documentation/translations/zh_CN/process/programming-language.rst
> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
> @@ -3,25 +3,22 @@
>  :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
>  :Translator: Alex Shi <alex.shi@linux.alibaba.com>
>  
> -.. _cn_programming_language:
> -
>  程序设计语言
>  ============
>  
> -内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
> -在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
> -
> -这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
> +内核是用 C 编程语言编写的 [zh_cn_c-language]_。更准确地说，内核通常使用 ``gcc`` [zh_cn_gcc]_ 编译，
> +并且使用 ``-std=gnu11`` [zh_cn_gcc-c-dialect-options]_：这是 ISO C11 的 GNU 方言。
> +``clang`` [zh_cn_clang]_ 也得到了支持，详见文档：
> +:ref:`使用 Clang/LLVM 构建 Linux <kbuild_llvm>`。
>  
> -对于一些体系结构，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 编译内核
> -的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
> +这种方言包含对 C 语言的许多扩展 [zh_cn_gnu-extensions]_，当然，它们许多都在内核中使用。
>  
>  属性
>  ----
>  
> -在整个内核中使用的一个常见扩展是属性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
> +在整个内核中使用的一个常见扩展是属性（attributes） [zh_cn_gcc-attribute-syntax]_。
>  属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
> -重大的语法更改（例如添加新关键字） :ref:`n2049 <cn_n2049>`
> +重大的语法更改（例如添加新关键字） [zh_cn_n2049]_。
>  
>  在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
>  即使其速度较慢或执行的编译时检查/诊断次数不够）
> @@ -30,42 +27,27 @@
>  ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
>  请参阅 ``include/linux/compiler_attributes.h``
>  
> -.. _cn_c-language:
> -
> -c-language
> -   http://www.open-std.org/jtc1/sc22/wg14/www/standards
> -
> -.. _cn_gcc:
> -
> -gcc
> -   https://gcc.gnu.org
> -
> -.. _cn_clang:
> -
> -clang
> -   https://clang.llvm.org
> -
> -.. _cn_icc:
> -
> -icc
> -   https://software.intel.com/en-us/c-compilers
> -
> -.. _cn_gcc-c-dialect-options:
> -
> -c-dialect-options
> -   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
> -
> -.. _cn_gnu-extensions:
> -
> -gnu-extensions
> -   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
> -
> -.. _cn_gcc-attribute-syntax:
> -
> -gcc-attribute-syntax
> -   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
> -
> -.. _cn_n2049:
> +Rust
> +----
>  
> -n2049
> -   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
> +内核对 Rust 编程语言 [zh_cn_rust-language]_ 的支持是实验性的，并且可以通过配置选项
> +``CONFIG_RUST`` 来启用。Rust 代码使用 ``rustc`` [zh_cn_rustc]_ 编译器在
> +``--edition=2021`` [zh_cn_rust-editions]_ 选项下进行编译。版本（Editions）是一种
> +在语言中引入非后向兼容的小型变更的方式。
> +
> +除此之外，内核中还使用了一些不稳定的特性 [zh_cn_rust-unstable-features]_。这些不稳定
> +的特性将来可能会发生变化，因此，一个重要的目标是达到仅使用稳定特性的程度。
> +
> +具体请参阅 Documentation/rust/index.rst
> +
> +.. [zh_cn_c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
> +.. [zh_cn_gcc] https://gcc.gnu.org
> +.. [zh_cn_clang] https://clang.llvm.org
> +.. [zh_cn_gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
> +.. [zh_cn_gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
> +.. [zh_cn_gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
> +.. [zh_cn_n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
> +.. [zh_cn_rust-language] https://www.rust-lang.org
> +.. [zh_cn_rustc] https://doc.rust-lang.org/rustc/
> +.. [zh_cn_rust-editions] https://doc.rust-lang.org/edition-guide/editions/
> +.. [zh_cn_rust-unstable-features] https://github.com/Rust-for-Linux/linux/issues/2

Hi Dongliang,

Good job! Most of translation are good.
Just the above doc seems still English version, give them a zh_cn name may cause misunderstand?
 
Thanks

