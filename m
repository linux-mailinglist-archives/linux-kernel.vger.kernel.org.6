Return-Path: <linux-kernel+bounces-361441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5D99A847
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FD9282533
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E725198E85;
	Fri, 11 Oct 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJnQPN02"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A961198A30;
	Fri, 11 Oct 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661769; cv=none; b=kOqQtwiQ1ByT4wW/Zo976mW+c0+SsZ1XFhfkGRa1eEWmXK9tL5p8VmZ7Cwxsa6oFW90tsRe4rDtkRa0oEZG1NFukCZx4V35160FUfffrw7jDOaFrAZnexJlQH5eKPysY2SYVLR5MOeklfif4KqpJ/T18ZCrUl/yQ/XFqaQQX2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661769; c=relaxed/simple;
	bh=f2hcgsydgRYVoApnvHt1Ek6C1pfxeKgde/tWJDkAMv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TZKunO+lbv5uLDAyxn2/r3ZA37v38wHUEPSgJpc0+lnS2FD02trfbvbwAJMEmzSbpp6R7cNatxOiuMqyN2BCCEl6y4fdC8JYhif4PK6XUjyXYyt+4rc/xEv5THI0RDv3CIgty4ZuX8JKq5ca6ZWv9GCfAkz16P4mtiW1V+U4Kgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJnQPN02; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea535890e0so131918a12.2;
        Fri, 11 Oct 2024 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728661768; x=1729266568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1St2Im4uOTbsDXAIoCqhnZbuttTkVPtBeaDvpamXxQ=;
        b=BJnQPN02lReiSqOduHQcPYfjtP671blYjZeoVWqLA9Sfl/DxUua8NvYzD9AzJKfoeM
         1RwObS3bbVZtFmtVqNc0wXDlPcYJquLaW7zJScR8oe5QqosGBa53zuKuq2VlVg2ryOGd
         lPpsHBBK6PoB0fmGX2J15c2qs5Sxdjtbo87b0e0rTpGYm7V4QTL+WV96vLMLPy27JsQx
         GOGgy4HY3P+ykASGgFxUGy8sbjMSYe4c8SyVY7P5PeOB69JOgDgEbEZsM0zweT7kcbVO
         eRUfD3mK1JVj6a2ru05kY0I4z/ygI4wCbUROgLNeiR7cmSGmrce7kM9oMPMnswiHKB4H
         jy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661768; x=1729266568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1St2Im4uOTbsDXAIoCqhnZbuttTkVPtBeaDvpamXxQ=;
        b=ty28Zyr21PK34HaVihAoEHKegLWnIrhbkZM3hXvmw6rYYhuLaaH7eX4Mbxkdg7vycf
         JNPDJXIiYtvbLFBINF2f1fiU62Xw+5iaB+eEJPc6/CjjvFhGMTtO/C/N5GKEBwC3eW2c
         OOci+YI5aQccxBsLwkBIH46wa89MNSmsD8tQUF7+RvP2l2VYl67Fcas7YsKzMBykyXAQ
         QapnEVPqxdhQfkgoBEZl33RevSCMJiH92nuCTT9wgKLD/8I6np/bkUounzmsAtd+w5EI
         GKFDeBTmo7UhdxqGISyCQL1CCCi3YDEchmy5xwWBn3TSnKXO5akUMbDhzVOXpyDuzJcR
         abTg==
X-Forwarded-Encrypted: i=1; AJvYcCXCAICdikFIo6Sa26lF7+IDXe60QVHe/2alAZwPZ0GVcbzRW9Jau9LQ0pjPuQbb4/oo2tjoBBf4IqfPBkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgpWWVQkYycEXf6qeOMcuFllbi9Gj/YZIusvB/7CN2jAxvW/6
	GGBqJUaFPpL1IztrxmWtR4sySeK2VRh8YggNQ9AB4fzhYECylUIm
X-Google-Smtp-Source: AGHT+IE6uVyZZ5iMM+uYfdamWAPqsmsaVtX7zoqAR7E0nuUfTQI0i0pXJJjiy7S0nZW6q8UhSpYleg==
X-Received: by 2002:a17:90a:8c03:b0:2e0:9d55:3784 with SMTP id 98e67ed59e1d1-2e2f0808125mr1823037a91.0.1728661767527;
        Fri, 11 Oct 2024 08:49:27 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa92e1sm3367382a91.35.2024.10.11.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:49:27 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com
Subject: Re: [PATCH v4] Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
Date: Fri, 11 Oct 2024 23:49:13 +0800
Message-Id: <20241011154913.2808-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Yanteng

>在 2024/10/11 09:47, Yanteng Si 写道:
>>
>> Hi Pengyu,
>>
>> 在 2024/10/8 23:38, Pengyu Zhang 写道:
>>> This patch provides a Simplified Chinese translation of the
>>> "page_tables.rst" document, aimed at improving accessibility
>>> for Chinese-speaking developers and users.
>>>
>>> The translation prioritizes technical accuracy and readability,
>>> ensuring that the content remains clear and informative for
>>> its intended audience.
>> Let's add a commit tag so that the scripts/checktransupdate.py can
>> recognize it. just like:
>>
>> Subject:[PATCH v3] docs/zh_CN: add the translation of kbuild/gcc-plugins.rst <https://lore.kernel.org/linux-doc/20240907070244.206808-1-dzm91@hust.edu.cn/#r>
>> Date: Sat,  7 Sep 2024 15:02:08 +0800
>>
>> Finish the translation of kbuild/gcc-plugins.rst and move gcc-plugins
>> from TODO to the main body.
>>
>> Update to commit 3832d1fd84b6 ("docs/core-api: expand Fedora instructions
>> for GCC plugins")
>>
>>
>> Thanks，
>> Yanteng
>>
>Sorry, my email client sent an HTML email and I have fixed it. Now resend
>to the mailing list.
>
>
>Thanks,
>Yanteng

We discovered a pfn calculation error during the translation of the 
page_tables.rst. I have submitted another patch to fix it, and it had been
reviewed by three maintainers, but it has not yet been merged into the mainline. 
https://lore.kernel.org/all/20241009144135.12453-1-zpenya1314@gmail.com/

So I have a question: should the commit tag be based on the fix patch
I submitted, or the tag of the original page_tables.rst?

Thanks,
Pengyu


