Return-Path: <linux-kernel+bounces-209414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06E90344C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385CA2821F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AA172BC6;
	Tue, 11 Jun 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1jF8B3c"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1016F8E7;
	Tue, 11 Jun 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092172; cv=none; b=Un4NXpFPwNASY+c5Zcznw8qlxFEsGIJzbiX6Qi2lBd7AZqT+T7WFB5/tDLGwL4IPjHGkNdosp3AkIBOaqmZkNOFENr6DSgiwmLyKjQpfQ0fzsQIUIp7A/Y/LVxnctrUjAYj1m4/Z+y4wZDWzuxte4MR6EzH0GmkwYbp7kJqMLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092172; c=relaxed/simple;
	bh=KBfl3zJtDkXD1sqOkHiQWf1Fkr2ByU/VIx60ZYmAVa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy3s82E5GZlTDIbxVEolL6BEcVr1e/8/RYH/o092FgDxKzVPgvLivonZB4ViFnIN2tmt5g6baAvg3FtwMLlLMukSUrrVHY/QGwUrOzw+gLKzyO/9lx4HA2i7H3oIoBRRSuFKcd6Zg3ODKp7zwo1+sneUkKLmuJOpajtCLeCCeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1jF8B3c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2f6b47621so1570578a91.1;
        Tue, 11 Jun 2024 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718092169; x=1718696969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBWaF9WNzCHoigyeVegbB49DHyK0V5NSO+g/3YRuGe8=;
        b=D1jF8B3cjtNnyKAbHLQNklls/s9mN8LvArhGNGu0M+L2TGsmnoAVTz50qa3tur3XhV
         RHWTZw2UuFhEIUixVqcdiei8OZRyXPdOzSvtcO0o6QGzRD8wi22KFGQ5krb4LjaGytrs
         5+yCz3JBzG+L4zVvAVRP6AVnH8OoQQHdwDfnQM7gsPKcGTfg1XOBIyB/4R4iDMi6qSER
         hFLhDCkn9ke8VbMld+22lQ3lesATGzH8AtvZdDykf8TCyeJRCf4ve7LlzZbkQSl6WiXe
         ypHal6jBui1KPo6gJYYa4A8tHB/44zOeOWc0glQegX93rbAl5RlDLswTIhh8O59ZMHUv
         1DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092169; x=1718696969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBWaF9WNzCHoigyeVegbB49DHyK0V5NSO+g/3YRuGe8=;
        b=QVA/qxKp+Cc7tpp8eAFpMUjNx5p7+HZZ2WM+awiR/mzrXMjzvv4dO9FJI1UTkSxsBM
         i1txGxqlDgaKuJbQZAw141LFoEM+CE+xaKb5rfAqhYcFX6F/ZcY05K94YCGsHNkzw+qx
         a5aavfnLr9CjGTP15S3R4Brj8v7tr+qE/nBwZjqNLsmKULqixKV6lxnmbVdCmi5Vw7th
         3T4t1BnQomDC53X/xeQZR04DK5NwWWw/PffZM4Anxel0MW3OVBRLbWrsmBi1Y6+uXh1h
         tOouFag82W1LMlRaYsEQTtqyOxmYaNsSSPLMenOGAxErK6ooIPW9TGqAwuCZS3+vHaSL
         abYA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFxOkO4ouSbne2QJCVH23yExD+G4TX2I+aDH+OmIztQiVBwqpZks5rk08aLQ3S9Di7CHpRr7YJaCHJcd03p5TPNsAtlxW354emrk6kT2NNTxKfmpNFPXleexxneBvTgX+367NuSAp
X-Gm-Message-State: AOJu0YyDkQu/22AqUNJBZtxN8V5jWARG0PFgBeHukIW4SuhEHpLNZ/gJ
	M24zh2IiIA6uzo9Qn/SR1hdYeDaNqAyWQ9XjjVrybyQBabk2Zn/Y
X-Google-Smtp-Source: AGHT+IGZQ0KDspbCMP2Qvt3JePMwH7pEdnwmmkqAzCKI50glQUSuigDMGCBm7HtPpk2Ov6faQ1GTiw==
X-Received: by 2002:a17:90a:df98:b0:2c3:3002:98b2 with SMTP id 98e67ed59e1d1-2c330029addmr1863984a91.11.1718092168955;
        Tue, 11 Jun 2024 00:49:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2ebc0ba09sm5435328a91.46.2024.06.11.00.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:49:28 -0700 (PDT)
Message-ID: <125592d3-e2ed-4ae3-9afe-60211b224b18@gmail.com>
Date: Tue, 11 Jun 2024 15:49:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: add process/researcher-guidelines Chinese
 translation
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611042515.61387-1-dzm91@hust.edu.cn>
 <c4952369-ffb2-45e1-8fe9-f7c920998833@gmail.com>
 <CAD-N9QXCoiZ3KG=HNPeTs7XiVO=C3wnBzrt1v2XWW-ijk2Zimw@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QXCoiZ3KG=HNPeTs7XiVO=C3wnBzrt1v2XWW-ijk2Zimw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/24 2:49 PM, Dongliang Mu wrote:
> On Tue, Jun 11, 2024 at 2:13 PM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 6/11/24 12:25 PM, Dongliang Mu wrote:
>>> Finish the translation of researcher-guidelines and add it to the
>>> index file.
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>>  .../translations/zh_CN/process/index.rst      |   2 +-
>>>  .../zh_CN/process/researcher-guidelines.rst   | 129 ++++++++++++++++++
>>>  2 files changed, 130 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/translations/zh_CN/process/researcher-guidelines.rst
>>>
>>> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
>>> index 5c6c8ccdd50d..5a5cd7c01c62 100644
>>> --- a/Documentation/translations/zh_CN/process/index.rst
>>> +++ b/Documentation/translations/zh_CN/process/index.rst
>>> @@ -64,6 +64,7 @@ TODOLIST:
>>>     management-style
>>>     stable-kernel-rules
>>>     submit-checklist
>>> +   researcher-guidelines
>>>
>>>  TODOLIST:
>>>
>>> @@ -71,7 +72,6 @@ TODOLIST:
>>>  * kernel-docs
>>>  * deprecated
>>>  * maintainers
>>> -* researcher-guidelines
>>>  * contribution-maturity-model
>>>
>>>
>>> diff --git a/Documentation/translations/zh_CN/process/researcher-guidelines.rst b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
>>> new file mode 100644
>>> index 000000000000..462b5aeef184
>>> --- /dev/null
>>> +++ b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
>>> @@ -0,0 +1,129 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +.. include:: ../disclaimer-zh_CN.rst
>>> +
>>> +.. _cn_submittingpatches:
>>> +
>>> +:Original: Documentation/process/researcher-guidelines.rst
>>> +
>>> +:译者:
>>> + - 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
>>> +
>>> +研究人员指南
>>> ++++++++++++++++++++++
>>> +
>>> +Linux 内核社区欢迎对 Linux 内核及其开发过程中涉及的活动与任何其他副产品
>>> +进行透明的研究。Linux 从这种研究中受益匪浅，其多方面均由某种形式的研究所推动。
>>> +
>>> +社区非常感谢研究人员在公开研究结果之前能分享初步发现，特别是涉及安全的研究。
>>> +早期参与有助于提高研究质量并使 Linux 受益。无论如何，推荐研究人员与社区分享
>>> +已发表研究的开放访问副本。
>>> +
>>> +本文旨在澄清研究开展过程中 Linux 内核社区认可与不认可的一些做法。至少，这类
>>> +研究及相关活动应遵循标准的研究伦理规则。有关研究伦理、技术伦理以及开发者社区
>>> +研究的更多背景信息，请查阅：
>>> +
>>> +* `研究伦理史 <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
>>> +* `IEEE 伦理 <https://www.ieee.org/about/ethics/index.html>`_
>>> +* `开发者和研究人员对开源项目实验伦理的看法 <https://arxiv.org/pdf/2112.13217.pdf>`_
>>> +
>>> +Linux 内核社区期望与项目互动的每个人都是真诚地为了使 Linux 变得更好。
>>> +对 Linux 内核社区产生的任何公开可用的成果（包括但不限于源代码）的研究
>>> +是受欢迎的，但对开发者的研究必须明确选择加入。
>>
>> “但对开发者的研究必须明确选择加入” 这里“加入”具体是指谁加入什么？
> 
> 我个人理解，这个地方是想表达，对开发者的研究必须清晰且明确地说明，不能隐瞒。
> 这个 opt-in 不是很好翻译。
> 
> 这个位置调整为“对开发者的研究如若要开展，则必须要明确说明，不得隐瞒”？

这里应该是获得开发者同意的意思吧？
所以替换成： “对开发者的研究如若要开展，则必须要明确说明，获得（开发者）同意。”

> 
>>
>> Thanks
>> Alex
>>> +
>>> +完全基于公开可用资源（包括公共邮件列表的帖子和公开代码库的提交）的被动研究
>>> +显然是允许的。不过，和任何研究一样，仍需遵循标准伦理。
>>> +
>>> +然而，针对开发者行为的主动研究必须在获得相关开发者的明确同意和完全披露的情况下进行。
>>> +未经同意，不得与开发者互动或对其进行实验；这也是标准的研究伦理。
>>> +
>>> +调查
>>> +=======
>>> +
>>> +研究通常采用调查问卷的形式发送给维护者或贡献者。然而，内核社区通常从这些调查问卷中获益
>>> +甚少。内核开发过程之所以有效，是因为每个开发者都从中受益，即使与目标不同的人一起工作。
>>> +而回应调查则是对繁忙开发者的单向需求，对他们自己或整个内核社区没有相应的好处。因此，
>>> +这种研究方法不被鼓励。
>>> +
>>> +内核社区成员已经收到过多的电子邮件，可能会将调查请求视为对他们时间的又一要求。发送
>>> +此类请求会剥夺社区宝贵的贡献者时间，且不太可能产生有统计意义的回应。
>>> +
>>> +作为替代，研究人员应考虑参加开发者活动，举办研讨会来介绍研究项目及其对参与者的益处，
>>> +并直接与社区互动。该方式获得的信息将比电子邮件调查问卷丰富得多，且社区也能从中学习
>>> +到您的见解。
>>> +
>>> +补丁
>>> +=======
>>> +
>>> +澄清：向开发者发送补丁**是**与他们互动，但他们已经同意接收**善意贡献**。故意发送有缺陷/
>>> +有漏洞的补丁或在讨论中提供误导信息是不被同意的。这种交流会对开发者造成损害
>>> +（例如，消耗时间、精力和士气），并通过破坏整个开发者社区对贡献者（及其所在组织）
>>> +的信任而损害项目，削弱为贡献者提供建设性反馈的努力，并使最终用户面临软件缺陷的风险。
>>> +
>>> +研究人员参与 Linux 本身的开发与其他人一样受到欢迎和鼓励。研究 Linux 代码是常见
>>> +做法，尤其是在开发或运行可产生可操作结果的分析工具时。
>>> +
>>> +在与开发者社区互动时，发送补丁历来是产生影响的最佳方式。Linux 已经有很多已知的
>>> +漏洞 -- 更有帮助的是经过审核的修复。在贡献之前，请仔细阅读相关文档：
>>> +
>>> +* Documentation/process/development-process.rst
>>> +* Documentation/process/submitting-patches.rst
>>> +* Documentation/admin-guide/reporting-issues.rst
>>> +* Documentation/process/security-bugs.rst
>>> +
>>> +然后发送补丁（包括所有如下详细信息的提交日志）并跟进其他开发者的任何反馈。
>>> +
>>> +当发送因研究而产生的补丁时，提交日志应至少包含以下详细信息，以便开发者有适当的上下文
>>> +来理解贡献。回答：
>>> +
>>> +* 找到了什么具体问题？
>>> +* 在运行系统上如何触发这个问题？
>>> +* 遇到这个问题对系统会有什么影响？
>>> +* 如何发现这个问题？具体包括任何测试、静态或动态分析程序及其他用于执行工作的工具或方法的详细信息。
>>> +* 在哪个版本的 Linux 上发现了这个问题？强烈推荐使用最新的发布版本或最近的 linux-next 分支（参见 Documentation/process/howto.rst）。
>>> +* 进行了哪些更改来修复这个问题，为什么认为这些更改是正确的？
>>> +* 如何进行构建测试和运行时测试？
>>> +* 此更改修复了哪个先前的提交？这应该在 "Fixes:" 标签中，如文档所述。
>>> +* 还有谁审查了这个补丁？这应该在适当的 "Reviewed-by:" 标签中注明；见下文。
>>> +
>>> +例如::
>>> +
>>> +  From: Author <author@email>
>>> +  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
>>> +
>>> +  The error path in foo_bar driver does not correctly free the allocated
>>> +  struct foo_bar_info. This can happen if the attached foo_bar device
>>> +  rejects the initialization packets sent during foo_bar_probe(). This
>>> +  would result in a 64 byte slab memory leak once per device attach,
>>> +  wasting memory resources over time.
>>> +
>>> +  This flaw was found using an experimental static analysis tool we are
>>> +  developing, LeakMagic[1], which reported the following warning when
>>> +  analyzing the v5.15 kernel release:
>>> +
>>> +   path/to/foo_bar.c:187: missing kfree() call?
>>> +
>>> +  Add the missing kfree() to the error path. No other references to
>>> +  this memory exist outside the probe function, so this is the only
>>> +  place it can be freed.
>>> +
>>> +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
>>> +  11.2 show no new warnings, and LeakMagic no longer warns about this
>>> +  code path. As we don't have a FooBar device to test with, no runtime
>>> +  testing was able to be performed.
>>> +
>>> +  [1] https://url/to/leakmagic/details
>>> +
>>> +  Reported-by: Researcher <researcher@email>
>>> +  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
>>> +  Signed-off-by: Author <author@email>
>>> +  Reviewed-by: Reviewer <reviewer@email>
>>> +
>>> +如果您是第一次参与贡献，建议在补丁在发布到公共列表前请其他人私下进行审核。（如果明确
>>> +告诉您补丁需要更仔细的内部审查，则这是必需的。）这些人预计会在最终的补丁中包含他们的
>>> +"Reviewed-by" 标签。找到熟悉 Linux 贡献的其他开发者，特别是您自己组织内的开发者，
>>> +并在将补丁发送到公共邮件列表前请他们帮助审核，往往会显著提高补丁的质量，从而减少
>>> +其他开发者的负担。
>>> +
>>> +如果你找不到人内部审核补丁且需要帮助找到这样的人，或者如果您对本文档和开发者社区的期望
>>> +有任何其他问题，请联系技术咨询委员会私有邮件列表：<tech-board@groups.linuxfoundation.org>。
>>> \ No newline at end of file
>>

