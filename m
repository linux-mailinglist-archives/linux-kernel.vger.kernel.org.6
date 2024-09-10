Return-Path: <linux-kernel+bounces-322314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA2972742
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CBFB232A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804C142911;
	Tue, 10 Sep 2024 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuNa+cUm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12521DFF0;
	Tue, 10 Sep 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935693; cv=none; b=VvQHgwrbi8l4B97ogB1NOg3W+7W0TrpqYZl87IGwIa0Tnwcs2X0GpOz6utBDwUg/Xgh9pLN87Cu9UoFjkTJ38a1GqwXtcpZwdBOqEEvdORiHFqwpXimd82Ekjg6P/IXL0dFpXrA7ejR/Q90V6MnKqWbdil0I9CvJq9ygjVEWEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935693; c=relaxed/simple;
	bh=veXA8/aEIcvbJ4tdLTLkNwd/cTiLdA9uvb6N55XyEZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5DlfjFb5rNvRMhkCzRGoZq5KXX5rF0udGMbcLn3dkoi3M7ZgqlY9Vk59tvhAhm3yRAuiYW8cTTTV0qeGEGrBQvH74yDnYfzU2FrAxDpiHi3GXBVF3C8JcrG73OOa6n/14XUp5AqwOURWO5cUBoObQwUHCSM2rN0KgXNWcJQtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuNa+cUm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso3917662a12.3;
        Mon, 09 Sep 2024 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935691; x=1726540491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbGFjI1Jm4RL1Dvc7yvqZW7MuzgcmJKxyv77P01RY7g=;
        b=SuNa+cUmFJya6/lLECF/h90LbT4M/rbGeN866WE7BnRtEpo/rM3li/oTQ5/AoEWwGC
         vdshSnmUsvv7y2608lEqQjfYVZ4z/jNAEryWzrC4R79AFrvVRyOdHeJpikPCjnix5Fdx
         rMxvlrc/phV0usiO2/yiGGOd7iLS4ztEP6cuOLhoHoSDJqxBet7Liu/Pueza+NY5ChBb
         36KfGh9vA8kgwFMA8HScn9SYM+MyJyYtXQaqCCR/TiCsjP6MXCihvkJBB8iEhq/WiJkg
         dlYf1d1tyX5vc7xl6tUNRRrM7iSLFySmvWecslGkdX8GTe2vKZrr9kUZ4sgRfan3JaG5
         JHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935691; x=1726540491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbGFjI1Jm4RL1Dvc7yvqZW7MuzgcmJKxyv77P01RY7g=;
        b=lJAPn3eNg8xzrl+kcw+eIuh6hYQTHsA4rQtsleR+Ri+9MDM9A4qxSHLk0IGD8xyePb
         qthksmsWVjvsGioA7HtaBKxIfvcgxCnl97i1oZIvZUg01Q3qeS9lki/XXl6P1xhTf9nt
         zsk8Gbo+p4B5HzJ9cg45BhjsVgeHj/Gqndz5ETJ17E1crj43ch1S9T524MOhGlyE2GDi
         4hD40f46qTSZt7zCfwEvWcjA58yc1n8+qKAJKOtzqHNFbRdUen1+L52wRhseASb80enG
         TOnv2Bt8B9vf5NwAIiH8mi/jHYtXw8x4XHPnp7suwOoEZ/BEeBePmCx8jwGOZL/s5/4u
         Fb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHAdhcyywIpY6Km4Gx0imxA3KfpI/SGr0QU3ohhz3QF8N8h77pyZKL4FbFkrjxTcOSQbZ2uDpJerU=@vger.kernel.org, AJvYcCXUZsgLTA19vGoGNaw/1A1TkTykPoRXJDW9Wu6LwhZpczcd8ZY0YC8mdDzzqc/L+brJsrNP3Jb/TmPdlFhB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhm3dYo0o5a3OYkLD2Fzk6WooyxOoiWekgl8F6p4NosJUeEqM7
	mlQIqvUGxWnAQvukIBZzzrBSGtJuWdADK4+aol2dR6Z5wQtkTLjTrf6t+9aS
X-Google-Smtp-Source: AGHT+IEfbDIfIWEWl9+hGeO41iqQlYwbmdVvslDHL+mdRN/85/Dbu+yZ/qjViZE/76xB3gtzWv1L+g==
X-Received: by 2002:a17:902:eccf:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-206f05faedcmr193772175ad.56.1725935690772;
        Mon, 09 Sep 2024 19:34:50 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3121fsm39794215ad.257.2024.09.09.19.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:34:50 -0700 (PDT)
Message-ID: <f98a792c-3ee0-478f-8696-f0d153ade931@gmail.com>
Date: Tue, 10 Sep 2024 10:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.cm, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240907070244.206808-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240907070244.206808-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


LGTM,

Reviewed-by: Alex Shi <alexs@kernel.org>

On 9/7/24 3:02 PM, Dongliang Mu wrote:
> Finish the translation of kbuild/gcc-plugins.rst and move gcc-plugins
> from TODO to the main body.
> 
> Update to commit 3832d1fd84b6 ("docs/core-api: expand Fedora instructions
> for GCC plugins")
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: fix sign incorrect pointed by Alex
> v1->v2: fix comments from yanteng
>  .../translations/zh_CN/kbuild/gcc-plugins.rst | 126 ++++++++++++++++++
>  .../translations/zh_CN/kbuild/index.rst       |   2 +-
>  2 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
> 
> diff --git a/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
> new file mode 100644
> index 000000000000..67a8abbf5887
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
> @@ -0,0 +1,126 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/kbuild/gcc-plugins.rst
> +:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
> +
> +================
> +GCC 插件基础设施
> +================
> +
> +
> +介绍
> +====
> +
> +GCC 插件是为编译器提供额外功能的可加载模块 [1]_。它们对于运行时插装和静态分析非常有用。
> +我们可以在编译过程中通过回调 [2]_，GIMPLE [3]_，IPA [4]_ 和 RTL Passes [5]_
> +（译者注：Pass 是编译器所采用的一种结构化技术，用于完成编译对象的分析、优化或转换等功能）
> +来分析、修改和添加更多的代码。
> +
> +内核的 GCC 插件基础设施支持构建树外模块、交叉编译和在单独的目录中构建。插件源文件必须由
> +C++ 编译器编译。
> +
> +目前 GCC 插件基础设施只支持一些架构。搜索 "select HAVE_GCC_PLUGINS" 来查找支持
> +GCC 插件的架构。
> +
> +这个基础设施是从 grsecurity [6]_  和 PaX [7]_ 移植过来的。
> +
> +--
> +
> +.. [1] https://gcc.gnu.org/onlinedocs/gccint/Plugins.html
> +.. [2] https://gcc.gnu.org/onlinedocs/gccint/Plugin-API.html#Plugin-API
> +.. [3] https://gcc.gnu.org/onlinedocs/gccint/GIMPLE.html
> +.. [4] https://gcc.gnu.org/onlinedocs/gccint/IPA.html
> +.. [5] https://gcc.gnu.org/onlinedocs/gccint/RTL.html
> +.. [6] https://grsecurity.net/
> +.. [7] https://pax.grsecurity.net/
> +
> +
> +目的
> +====
> +
> +GCC 插件的设计目的是提供一个用于试验 GCC 或 Clang 上游没有的潜在编译器功能的场所。
> +一旦它们的实用性得到验证，这些功能将被添加到 GCC（和 Clang）的上游。随后，在所有
> +支持的 GCC 版本都支持这些功能后，它们会被从内核中移除。
> +
> +具体来说，新插件应该只实现上游编译器（GCC 和 Clang）不支持的功能。
> +
> +当 Clang 中存在 GCC 中不存在的某项功能时，应努力将该功能做到 GCC 上游（而不仅仅
> +是作为内核专用的 GCC 插件），以使整个生态都能从中受益。
> +
> +类似的，如果 GCC 插件提供的功能在 Clang 中 **不** 存在，但该功能被证明是有用的，也应
> +努力将该功能上传到 GCC（和 Clang）。
> +
> +在上游 GCC 提供了某项功能后，该插件将无法在相应的 GCC 版本（以及更高版本）下编译。
> +一旦所有内核支持的 GCC 版本都提供了该功能，该插件将从内核中移除。
> +
> +
> +文件
> +====
> +
> +**$(src)/scripts/gcc-plugins**
> +
> +	这是 GCC 插件的目录。
> +
> +**$(src)/scripts/gcc-plugins/gcc-common.h**
> +
> +	这是 GCC 插件的兼容性头文件。
> +	应始终包含它，而不是单独的 GCC 头文件。
> +
> +**$(src)/scripts/gcc-plugins/gcc-generate-gimple-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-ipa-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-simple_ipa-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-rtl-pass.h**
> +
> +	这些头文件可以自动生成 GIMPLE、SIMPLE_IPA、IPA 和 RTL passes 的注册结构。
> +	与手动创建结构相比，它们更受欢迎。
> +
> +
> +用法
> +====
> +
> +你必须为你的 GCC 版本安装 GCC 插件头文件，以 Ubuntu 上的 gcc-10 为例::
> +
> +	apt-get install gcc-10-plugin-dev
> +
> +或者在 Fedora 上::
> +
> +	dnf install gcc-plugin-devel libmpc-devel
> +
> +或者在 Fedora 上使用包含插件的交叉编译器时::
> +
> +	dnf install libmpc-devel
> +
> +在内核配置中启用 GCC 插件基础设施与一些你想使用的插件::
> +
> +	CONFIG_GCC_PLUGINS=y
> +	CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> +	...
> +
> +运行 gcc（本地或交叉编译器），确保能够检测到插件头文件::
> +
> +	gcc -print-file-name=plugin
> +	CROSS_COMPILE=arm-linux-gnu- ${CROSS_COMPILE}gcc -print-file-name=plugin
> +
> +"plugin" 这个词意味着它们没有被检测到::
> +
> +	plugin
> +
> +完整的路径则表示插件已经被检测到::
> +
> +       /usr/lib/gcc/x86_64-redhat-linux/12/plugin
> +
> +编译包括插件在内的最小工具集::
> +
> +	make scripts
> +
> +或者直接在内核中运行 make，使用循环复杂性 GCC 插件编译整个内核。
> +
> +
> +4. 如何添加新的 GCC 插件
> +========================
> +
> +GCC 插件位于 scripts/gcc-plugins/。你需要将插件源文件放在 scripts/gcc-plugins/ 目录下。
> +子目录创建并不支持，你必须添加在 scripts/gcc-plugins/Makefile、scripts/Makefile.gcc-plugins
> +和相关的 Kconfig 文件中。
> diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
> index d906a4e88d0f..b51655d981f6 100644
> --- a/Documentation/translations/zh_CN/kbuild/index.rst
> +++ b/Documentation/translations/zh_CN/kbuild/index.rst
> @@ -13,6 +13,7 @@
>      :maxdepth: 1
>  
>      headers_install
> +    gcc-plugins
>  
>  TODO:
>  
> @@ -24,7 +25,6 @@ TODO:
>  - modules
>  - issues
>  - reproducible-builds
> -- gcc-plugins
>  - llvm
>  
>  .. only::  subproject and html

