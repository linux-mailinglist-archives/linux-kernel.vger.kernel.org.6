Return-Path: <linux-kernel+bounces-264979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380A93EACB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03C828195D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7841C89;
	Mon, 29 Jul 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDU/0t9F"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5946BF;
	Mon, 29 Jul 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218122; cv=none; b=SfxQcUG1CRdWZ9pq549cu1Hufk/g6LR/x3Mgp3D3P5Fs+IFfnpzIINoGqKM7rdCGrj3j7NBs6irIgqP6ZJx4wQ1G/wMePqj/yDp+3tEO78ET9HlI2nl59A+xpgB27LLac+dCXtULMHP34ES4Y73orSy819qATrQLLDexDidKRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218122; c=relaxed/simple;
	bh=2fdNFW+i95ZpWXflx23NynA3I1ALYuVGu/P5r5PPxkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2yQE/wT9ZsWDEV6PGbFzShEBDLHN1i1ArRxTKHWP/SfId+a5OcF/ikdMOFOGy+tyniqDOyiih/U5hOE7SeqsyGEG09q+QWrSTDL3dKGkOJ0hbafQhKBTJJEvBHnrDUt2ltv6Mf/cqBgERg/eQUGN3zpa9G7NgELFlFYTGJUtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDU/0t9F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso13566735ad.1;
        Sun, 28 Jul 2024 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722218120; x=1722822920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5iu9SH/VwPrifdtlVA6MPi16aem4OhWSbSk9J9nOGc=;
        b=dDU/0t9FaBsR39KV1k12NzkgywyxtE7HLGd6Rd4E1+8C/0PvKFoXEFFIWYNv1vtxqk
         doDzArlasnkycrgUe8asPjXPAH68Xko+VMmotAiASJDksHpgrN3A7LJHqkHVeiaNrQFm
         gV73OtPcYAnF3KSCIj0QwIRxGSnUU+W63aSGR4xGvHwHYSOMRbonqdOhXFW+DLnCsefY
         moJaRXpakg4nFeiYNKkTBY9hJWenHUF39N43v3gzGBDnTBUb17nZcLJMtWxrudfy51Y7
         kv391/Srur0iPvI8sHBr864iUox6sFfn9ll0gTofiMJFdmKTWPwcvHMqwFqalgXvqOnC
         WzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218120; x=1722822920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5iu9SH/VwPrifdtlVA6MPi16aem4OhWSbSk9J9nOGc=;
        b=uy4djuZZ9nTKf69FUhfKKceLZNSeds92AZa6hKc0zdE/X803Yy+H7PAwyrwajD9+el
         bPHIvgBTxAktajKOHFChwcKzSFWCOQGBxhQYH4ZrCrzIwPOlwUTVPSoATqhjSMyPjaeu
         PEOCihZuD17urwfguYcsu3uYWhSocxFVWY0qj0PesA1y5ThlGELmoiLaYR4bXrqP/fXN
         ZJoT6XjGMtUOFimGw8WktZnjn0EEu9i4nb7L1mg+AgMZlyN7Jm8r4P2xEfbv7pvn1dze
         KLFjp5QTsLyu1rN8PaeiMR/ckz3aNEKkmf0gQ/rEOB5XVROLUuwpe2hEIyxJ5XVvNVw8
         epDA==
X-Forwarded-Encrypted: i=1; AJvYcCWcl6StwEl882yuD490JmDh8NrdnAfcN6H9xSwYsfZ0tgrU4WuKtkFDpN3XtdTHmULbGFA4itQPtkqom7yBFx0xn2daKb2iQlimqJpo
X-Gm-Message-State: AOJu0YzORIqZM3mnMWDU5KTo6SsyzEArxpS319q7gJDGa7oFDl3GLojR
	02kF3ezkExqsnwwZ+NqAIGDvyQY42dzZIsr6Ibgtl2fHz8ZM0aLP
X-Google-Smtp-Source: AGHT+IE7nc1tTdJQ/ICWGLt+X1PfaOqfleZ4H2/D9xjVnwGo2OX+NB1J+MbC5i4/Aewmu7zSG25wRA==
X-Received: by 2002:a17:902:c153:b0:1fb:719a:28e2 with SMTP id d9443c01a7336-1ff0482f2c0mr42924695ad.21.1722218119744;
        Sun, 28 Jul 2024 18:55:19 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1cc38sm70692625ad.200.2024.07.28.18.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 18:55:19 -0700 (PDT)
Message-ID: <636e8ae6-e34c-4c20-91fa-8547ec95ea7f@gmail.com>
Date: Mon, 29 Jul 2024 09:55:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of security-bugs
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Hu Haowen <2023002089@link.tyut.edu.cn>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611020514.48770-1-dzm91@hust.edu.cn>
 <e80ef726-fc2a-4bbf-b61f-d1419179eda6@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <e80ef726-fc2a-4bbf-b61f-d1419179eda6@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LGTM
Reviewed-by: Alex Shi <alexs@kernel.org>


On 7/26/24 9:21 PM, Dongliang Mu wrote:
> ping?
> 
> On 2024/6/11 10:04, Dongliang Mu wrote:
>> Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
>> CVE process")
>>
>> commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
>> relaxed their rules")
>> commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
>> handling")
>> commit 4fee0915e649 ("Documentation: security-bugs.rst: update
>> preferences when dealing with the linux-distros group")
>> commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/
>> to process/")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v2->v3: revise the references in zh_TW
>> v1->v2: remove admin-guide/security-bugs, and revise all its references
>>   .../translations/zh_CN/admin-guide/index.rst  |  1 -
>>   .../zh_CN/admin-guide/reporting-issues.rst    |  4 +-
>>   .../translations/zh_CN/process/index.rst      |  3 +-
>>   .../security-bugs.rst                         | 42 ++++++++++++-------
>>   .../zh_CN/process/submitting-patches.rst      |  2 +-
>>   .../zh_TW/admin-guide/reporting-issues.rst    |  4 +-
>>   .../zh_TW/process/submitting-patches.rst      |  2 +-
>>   7 files changed, 34 insertions(+), 24 deletions(-)
>>   rename Documentation/translations/zh_CN/{admin-guide => process}/security-bugs.rst (57%)
>>
>> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
>> index ac2960da33e6..773c53956000 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
>> @@ -37,7 +37,6 @@ Todolist:
>>        reporting-issues
>>      reporting-regressions
>> -   security-bugs
>>      bug-hunting
>>      bug-bisect
>>      tainted-kernels
>> diff --git a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
>> index 59e51e3539b4..9ff4ba94391d 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/reporting-issues.rst
>> @@ -300,7 +300,7 @@ Documentation/admin-guide/reporting-regressions.rst 对此进行了更详细的
>>   添加到回归跟踪列表中，以确保它不会被忽略。
>>     什么是安全问题留给您自己判断。在继续之前，请考虑阅读
>> -Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
>> +Documentation/translations/zh_CN/process/security-bugs.rst ，
>>   因为它提供了如何最恰当地处理安全问题的额外细节。
>>     当发生了完全无法接受的糟糕事情时，此问题就是一个“非常严重的问题”。例如，
>> @@ -983,7 +983,7 @@ Documentation/admin-guide/reporting-regressions.rst ；它还提供了大量其
>>   报告，请将报告的文本转发到这些地址；但请在报告的顶部加上注释，表明您提交了
>>   报告，并附上工单链接。
>>   -更多信息请参见 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
>> +更多信息请参见 Documentation/translations/zh_CN/process/security-bugs.rst 。
>>       发布报告后的责任
>> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
>> index 5c6c8ccdd50d..011dc2cf583a 100644
>> --- a/Documentation/translations/zh_CN/process/index.rst
>> +++ b/Documentation/translations/zh_CN/process/index.rst
>> @@ -49,10 +49,11 @@ TODOLIST:
>>        embargoed-hardware-issues
>>      cve
>> +   security-bugs
>>     TODOLIST:
>>   -* security-bugs
>> +* handling-regressions
>>     其它大多数开发人员感兴趣的社区指南：
>>   diff --git a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst b/Documentation/translations/zh_CN/process/security-bugs.rst
>> similarity index 57%
>> rename from Documentation/translations/zh_CN/admin-guide/security-bugs.rst
>> rename to Documentation/translations/zh_CN/process/security-bugs.rst
>> index d6b8f8a4e7f6..a8f5fcbfadc9 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
>> +++ b/Documentation/translations/zh_CN/process/security-bugs.rst
>> @@ -1,3 +1,5 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>>   .. include:: ../disclaimer-zh_CN.rst
>>     :Original: :doc:`../../../process/security-bugs`
>> @@ -5,6 +7,7 @@
>>   :译者:
>>      吴想成 Wu XiangCheng <bobwxc@email.cn>
>> + 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
>>     安全缺陷
>>   =========
>> @@ -17,13 +20,13 @@ Linux内核开发人员非常重视安全性。因此我们想知道何时发现
>>     可以通过电子邮件<security@kernel.org>联系Linux内核安全团队。这是一个安全人员
>>   的私有列表，他们将帮助验证错误报告并开发和发布修复程序。如果您已经有了一个
>> -修复，请将其包含在您的报告中，这样可以大大加快进程。安全团队可能会从区域维护
>> +修复，请将其包含在您的报告中，这样可以大大加快处理进程。安全团队可能会从区域维护
>>   人员那里获得额外的帮助，以理解和修复安全漏洞。
>>     与任何缺陷一样，提供的信息越多，诊断和修复就越容易。如果您不清楚哪些信息有用，
>>   请查看“Documentation/translations/zh_CN/admin-guide/reporting-issues.rst”中
>> -概述的步骤。任何利用漏洞的攻击代码都非常有用，未经报告者同意不会对外发布，除
>> -非已经公开。
>> +概述的步骤。任何利用漏洞的攻击代码都非常有用，未经报告者同意不会对外发布，
>> +除非已经公开。
>>     请尽可能发送无附件的纯文本电子邮件。如果所有的细节都藏在附件里，那么就很难对
>>   一个复杂的问题进行上下文引用的讨论。把它想象成一个
>> @@ -49,24 +52,31 @@ Linux内核开发人员非常重视安全性。因此我们想知道何时发现
>>   换句话说，我们唯一感兴趣的是修复缺陷。提交给安全列表的所有其他资料以及对报告
>>   的任何后续讨论，即使在解除限制之后，也将永久保密。
>>   -协调
>> -------
>> +与其他团队协调
>> +--------------
>> +
>> +虽然内核安全团队仅关注修复漏洞，但还有其他组织关注修复发行版上的安全问题以及协调
>> +操作系统厂商的漏洞披露。协调通常由 "linux-distros" 邮件列表处理，而披露则由
>> +公共 "oss-security" 邮件列表进行。两者紧密关联且被展示在 linux-distros 维基：
>> +<https://oss-security.openwall.org/wiki/mailing-lists/distros>
>> +
>> +请注意，这三个列表的各自政策和规则是不同的，因为它们追求不同的目标。内核安全团队
>> +与其他团队之间的协调很困难，因为对于内核安全团队，保密期（即最大允许天数）是从补丁
>> +可用时开始，而 "linux-distros" 则从首次发布到列表时开始计算，无论是否存在补丁。
>>   -对敏感缺陷（例如那些可能导致权限提升的缺陷）的修复可能需要与私有邮件列表
>> -<linux-distros@vs.openwall.org>进行协调，以便分发供应商做好准备，在公开披露
>> -上游补丁时发布一个已修复的内核。发行版将需要一些时间来测试建议的补丁，通常
>> -会要求至少几天的限制，而供应商更新发布更倾向于周二至周四。若合适，安全团队
>> -可以协助这种协调，或者报告者可以从一开始就包括linux发行版。在这种情况下，请
>> -记住在电子邮件主题行前面加上“[vs]”，如linux发行版wiki中所述：
>> -<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>。
>> +因此，内核安全团队强烈建议，作为一位潜在安全问题的报告者，在受影响代码的维护者
>> +接受补丁之前，且在您阅读上述发行版维基页面并完全理解联系 "linux-distros"
>> +邮件列表会对您和内核社区施加的要求之前，不要联系 "linux-distros" 邮件列表。
>> +这也意味着通常情况下不要同时抄送两个邮件列表，除非在协调时有已接受但尚未合并的补丁。
>> +换句话说，在补丁被接受之前，不要抄送 "linux-distros"；在修复程序被合并之后，
>> +不要抄送内核安全团队。
>>     CVE分配
>>   --------
>>   -安全团队通常不分配CVE，我们也不需要它们来进行报告或修复，因为这会使过程不必
>> -要的复杂化，并可能耽误缺陷处理。如果报告者希望在公开披露之前分配一个CVE编号，
>> -他们需要联系上述的私有linux-distros列表。当在提供补丁之前已有这样的CVE编号时，
>> -如报告者愿意，最好在提交消息中提及它。
>> +安全团队不分配 CVE，同时我们也不需要 CVE 来报告或修复漏洞，因为这会使过程不必要
>> +的复杂化，并可能延误漏洞处理。如果报告者希望为确认的问题分配一个 CVE 编号，
>> +可以联系 :doc:`内核 CVE 分配团队 <../process/cve>` 获取。
>>     保密协议
>>   ---------
>> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
>> index 7864107e60a8..7ca16bda3709 100644
>> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
>> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
>> @@ -208,7 +208,7 @@ torvalds@linux-foundation.org 。他收到的邮件很多，所以一般来说
>>   如果您有修复可利用安全漏洞的补丁，请将该补丁发送到 security@kernel.org 。对于
>>   严重的bug，可以考虑短期禁令以允许分销商（有时间）向用户发布补丁；在这种情况下，
>>   显然不应将补丁发送到任何公共列表。
>> -参见 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
>> +参见 Documentation/translations/zh_CN/process/security-bugs.rst 。
>>     修复已发布内核中严重错误的补丁程序应该抄送给稳定版维护人员，方法是把以下列行
>>   放进补丁的签准区（注意，不是电子邮件收件人）::
>> diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
>> index bc132b25f2ae..1d4e4c7a6750 100644
>> --- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
>> +++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
>> @@ -301,7 +301,7 @@ Documentation/admin-guide/reporting-regressions.rst 對此進行了更詳細的
>>   添加到迴歸跟蹤列表中，以確保它不會被忽略。
>>     什麼是安全問題留給您自己判斷。在繼續之前，請考慮閱讀
>> -Documentation/translations/zh_CN/admin-guide/security-bugs.rst ，
>> +Documentation/translations/zh_CN/process/security-bugs.rst ，
>>   因爲它提供瞭如何最恰當地處理安全問題的額外細節。
>>     當發生了完全無法接受的糟糕事情時，此問題就是一個“非常嚴重的問題”。例如，
>> @@ -984,7 +984,7 @@ Documentation/admin-guide/reporting-regressions.rst ；它還提供了大量其
>>   報告，請將報告的文本轉發到這些地址；但請在報告的頂部加上註釋，表明您提交了
>>   報告，並附上工單鏈接。
>>   -更多信息請參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
>> +更多信息請參見 Documentation/translations/zh_CN/process/security-bugs.rst 。
>>       發佈報告後的責任
>> diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
>> index f12f2f193f85..64de92c07906 100644
>> --- a/Documentation/translations/zh_TW/process/submitting-patches.rst
>> +++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
>> @@ -209,7 +209,7 @@ torvalds@linux-foundation.org 。他收到的郵件很多，所以一般來說
>>   如果您有修復可利用安全漏洞的補丁，請將該補丁發送到 security@kernel.org 。對於
>>   嚴重的bug，可以考慮短期禁令以允許分銷商（有時間）向用戶發佈補丁；在這種情況下，
>>   顯然不應將補丁發送到任何公共列表。
>> -參見 Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
>> +參見 Documentation/translations/zh_CN/process/security-bugs.rst 。
>>     修復已發佈內核中嚴重錯誤的補丁程序應該抄送給穩定版維護人員，方法是把以下列行
>>   放進補丁的籤準區（注意，不是電子郵件收件人）::
> 

