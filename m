Return-Path: <linux-kernel+bounces-221554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8D90F569
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA6B1F217A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475B155C94;
	Wed, 19 Jun 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6onS8WM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986041746;
	Wed, 19 Jun 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819143; cv=none; b=FgXcKY0l4igeENABWoGYYSEu+ttdINMk/aDtRYvt4FyxrJHja4pvd+9EZFNgCewBu+SMeGTXakqWw9eliBICjRDG1UQ2G4++erywvnqZ0b2A2L60tY9Nr61+k8UOfxaeTtM+tK06L/qUS/vPfzwddOTApcBSQvskJk12qbMkuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819143; c=relaxed/simple;
	bh=RbfV+KUQeiFLojvb9jpKaSo3OOfIErnBLUWYgJNACG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsyrm1O3SjgwqA0Ay0MVWTf9Dpuvku1LZn+LRJ2lLP+UyHc9+GmkJ8xB298d3Cv7veMMdP+L0lorl/yDPYfTlIdKOjLxcOHwPA/Z31gQ9pWgxoMc+RN9vuIaZWB7qRKBRrXIrXNE+hScbF/y9Lv4EKXKZoeuTdwoCVJeTQBSWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6onS8WM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706264e1692so86271b3a.1;
        Wed, 19 Jun 2024 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718819141; x=1719423941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kvhj1mvThf9WTErjbenIIrNdBrlJUowCoHlpC3rJMmM=;
        b=d6onS8WMSHCg5d+7Sl+/DXMY1SZMcYPCba0xTy9THN/qugecMyamiTKtLvpT2ty7vd
         C2VPaOjqRTRBAI0N8I7yoKGlT46Msq/kdRj6nCY/99gknxuoqGznt2/t9/Po6oSvc21U
         +qYvrtcMTE9xRaoIpgSLauQqWz2CVF0GKXQ8iRuPyvTl86XTV0cj4Bu/0FSxvV4vlmQQ
         K2ZreTR4bW1tLFTZeHOPo2D4VPX1QFoTskKUbojO+kHXWW8P9RK+FpA0T7euROn75qfs
         xXMyhSZuQwoCsbZt2AbLGXY+pjfuKMvuJGNCg3PAWDSux7dy1e/p31Xi5ZZmuLGuivaT
         SwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819141; x=1719423941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvhj1mvThf9WTErjbenIIrNdBrlJUowCoHlpC3rJMmM=;
        b=I/fVFmaERYVLMFSQfC45jnD4PIYWhrSm+H7D+qXeOi858ErN3JUijOd04M/6R6YSUr
         l0o9QA47S3to1HiVUQwm9XzYR9yZV0oeh/b9KFDMscgXh9WZmV/ghwzKqMv1V8AlcN9C
         +94HqlqAPavX8hOkwGc6bew9zhXzMbbDyC8VqQfhGOPx4pW5Y63TmZFqK2SmXptpev0X
         DeazvPvJEgVwSERF2IioEr7nVlGrXE6AeC//ZVa2VGCHlrLV3tviBktABs8BfLOfk64t
         ncPkAF+Q7FRK/X/BNlnKT3EuOkbFSPOKmmKA+bivbW2dukp87vI0wCafY/IHS8Cdlswu
         SuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8PlDZsDMfnV39HwKIw0zr9S50dPdAp2d/zdQxCCd/AFbwTmPjAFHZmDtMaQaiHbSRCQo+3yVla7jRWBDf9Bgevg+K36IkTpoZjaZCRqmCRdmrIxbMD4l0aehgPFmBa7UgxYcnbHizRVyKR1eOodjXFmitZOCpftN4soW0xmZGbOZg
X-Gm-Message-State: AOJu0YzRjyHurwwtgtoylzDMcE7FxZ+iaZsKRbmH22g+wPks8eVj7Ow8
	HePEsKgDUUvq+D1FKlhgT6Zz3XtUg4mC3DM52vaSIXO8XHKVgpGh
X-Google-Smtp-Source: AGHT+IGH9xki418S2ph1Ml1h0Yjs4wj2oPyJmIGWhXuGeHSj61TlnV5b2HR+mshFN8FxCeBeo9JxQw==
X-Received: by 2002:a05:6a20:968e:b0:1b6:bb61:3784 with SMTP id adf61e73a8af0-1bcbb60d5b2mr3475008637.55.1718819141446;
        Wed, 19 Jun 2024 10:45:41 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c793sm10923725b3a.51.2024.06.19.10.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 10:45:41 -0700 (PDT)
Message-ID: <274c4648-e549-4b7e-a563-57d97e75dcc1@gmail.com>
Date: Thu, 20 Jun 2024 02:45:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Documentation: cve Korean translation
To: SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Jinwoo Park <pmnxis@gmail.com>, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240617231148.64366-1-sj@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240617231148.64366-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi John, Hi SeongJae,

On 6/18/24 8:11 오전, SeongJae Park wrote:
> Hi John,
> 
> On Mon, 17 Jun 2024 16:27:25 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
> 
>> yskelg@gmail.com writes:
>>
>>> From: Yunseong Kim <yskelg@gmail.com>
>>>
>>> This is a Documentation/process/cve korean version.
>>>
>>> The following changes have been updated based on SeongJae Park’s feedback
>>> from the last v4 patch.
>>>
>>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>>> ---
>>>  Documentation/translations/ko_KR/index.rst    |   1 +
>>>  .../translations/ko_KR/process/cve.rst        | 107 ++++++++++++++++++
>>>  2 files changed, 108 insertions(+)
>>>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
>>
>> SeongJae, are you happy with this version?
> 
> I have a trivial concern about this patch.  I'm not very confident about it,
> though.  I therefore personally shared the concern with Yunseong.  Yunseong
> thankfully agreed at some of my points, and he told me that he will post a new
> version of this patch.

Yeah, there are some parts that sound a bit awkward in Korean.
I think it needs a bit more work. I asked some friends to review it
offline. I think it would be better if I revise it a bit more before
sending it.

> Please correct me if anything is wrong or missed, Yunseong.
> 
> So, I hope this patch to eventually be merged, but I have no strong opinion to
> provide either 'Reviewed-by:' or 'Nacked-by:'.

I'm trying to translate a little more naturally by looking at your
translation, All the documents you translated have been super helpful!
Thank you SungJae!

> [...]
> 
> 
> Thanks,
> SJ

Warm Regards,
Yunseong Kim

