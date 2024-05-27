Return-Path: <linux-kernel+bounces-190992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA48D0541
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493F51F21174
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9461FCD;
	Mon, 27 May 2024 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFrRUiES"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C561FC0;
	Mon, 27 May 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821037; cv=none; b=EdzGczlsohjVPgiOX70rn8Gv1JQAqHCenzGASbXiyZyzze4uSnvQXdte4Fz9gb0tM30tKgeSF3uyLRVHeJdX6edGdgm5tkix/K7N0YBzczPeqDufaUQilX6SOgehwDOP5v5hkaOQtQDQAAdOCHavP2be+8nMRj68AMdBkjt69dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821037; c=relaxed/simple;
	bh=yZ54pHZc8pZ1llQjTF214XGFVmGuCbN++WoTXje+y18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZksmdWSXS0ebi2UsvlIpsUiOdrFzgqJJAkpvIHiRZiNxJ6JEXog8Ajhv13CDuyLHA+8B0w9rfAgWqJZWd3FJbOEh/fc1ok/84u0T6DwYJe+81Y2Qv69TYA4cp3bGhb6bU7LepAlG4qINzup+JIGzAqvKWKwLJPmu82Mbk6Bho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFrRUiES; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b45d6abso26651935ad.0;
        Mon, 27 May 2024 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716821035; x=1717425835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEv9TOl2VcsNK97lEGFpOwkx9V8aOFfBaXbVSYVjqbk=;
        b=AFrRUiES+BLBq7fGesvxpV+3Q+vgoqYbMRIhLPSdzru3X9Au92uP4BO12u3WixselN
         pfqPVpKaENtKvdkF2exM+yMXH5w5OXilNzicuYNc1PO+0u1TbV8LpYWfsUelchsNAXzn
         FGwDQv6cGPfAJsnXI+L9mZWkdvliPqkDuxuKIB1Kq1QlvKHKznk/wRJjAwJ6ijkB075l
         6eEI4hxksH9Lmutwh5+/sM6arzFUVDBikCl508K/uCfqDYDPsQmu3lKi7YCcfpkY0Z7T
         CXacCb43oBpgfClYhjfslcgGLKqgNk3D9f3alDVmROBaQTHqDj4vIfM+fFyxyn9CGogu
         TXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821035; x=1717425835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEv9TOl2VcsNK97lEGFpOwkx9V8aOFfBaXbVSYVjqbk=;
        b=fB5LayQ1Y294GfAjhJiyTZEr6ztm8UszeLT/sj+t8nQ9X/nXboLO1F46i7o71CZbCZ
         zV9CRGSm12Rv9QAhSqE98gl6vDG6jlUKvM8TUVfkU6/o3/k/EezU1YZx+L2giudlFVPp
         /hw/o/8V+CY/W3rjq9pHGDM2c9Ms/jahX/j0HZcNBLRSqU45559iHAYXex7MubncWeRB
         1EI1dhPagdBOLUBxC6g0yAe3rnJ+7OENRRXeDo7GjR2jqX0lXqOap2O7RvkqrLnXCFdF
         Ya9gQs7kDmqbSU7Avc/objEmb+jFNxOorMfpJrPXczZ+SfrI4ZH44MRyQe2qRb6VJy+J
         ZLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK5WH4xpeTCImY6p9LqahPdG2FXEamJULAFyk/TMxzai8iLTHpda3aVrmzOg431JL10s1hqjC5mIfvXx7LOv1pBVOiV1nUQ7kc//0FyIrNOYcV3ShWFHG6bRY6pP6jVpdUd7XRrmVvuVJ1MyC9JHVihJTG7MOL0BNBxqf4U4sBnf+C
X-Gm-Message-State: AOJu0YzBIL396jpnU9wH3CjxPZv2CxnBQIQH+WyreNWFOvSHTNIon0RA
	KK5EgS29CqGIcwrMNzVLmCogY100bVp8Yog2yaVwEoQ6hkw0C4vo
X-Google-Smtp-Source: AGHT+IGnAR9vdm6Qy/DLqPuX3AD8gKj8qNo/aOyJuE1HPXJCL3Up+L+CWGvNzE959PkXuAs62RPlEQ==
X-Received: by 2002:a17:902:f68b:b0:1f4:8372:db24 with SMTP id d9443c01a7336-1f48372df16mr43806395ad.38.1716821034998;
        Mon, 27 May 2024 07:43:54 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481d5a77bsm30101805ad.298.2024.05.27.07.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 07:43:54 -0700 (PDT)
Message-ID: <8880b0ec-9315-428e-b9c4-e578690d3c08@gmail.com>
Date: Mon, 27 May 2024 23:43:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: cve Korean translation
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Jinwoo Park <pmnxis@gmail.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527103003.29318-1-yskelg@gmail.com>
 <87ikyzpgqz.fsf@meer.lwn.net>
 <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
 <87o78rnz3a.fsf@meer.lwn.net>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <87o78rnz3a.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/24 10:50 오후, Jonathan Corbet wrote:
> Yunseong Kim <yskelg@gmail.com> writes:
> 
>>> 1) Why do I have three versions of it in my mailbox, sent over a period
>>>    of 13 minutes?  What changed between the versions?
>>
>> Sorry, I forgot the name of the reviewer when I first sent the
>> documentation content related patch version 2.
> 
> Which is fine, but...
> 
>>>    Normally, you want to wait for reviews to come in on one version
>>>    before posting the next, and you should put a comment after the "---"
>>>    line saying what changed.
>>>
>>> 2) When did this review from Jinwoo Park happen?  I was not copied on
>>>    that.
> 
> You did not answer this question.  Reviews should generally be done in
> public, but that does not seem to have happened here?

Oops, sorry about that, Jonathan.

Jinwoo Park sent me the review below, and I've updated some of ambiguous
words in patch version 2.

https://lore.kernel.org/linux-doc/57f0d90c-4cc6-4418-ab79-6ae026d8ae09@gmail.com/T/#t

>> Thanks for translating new Documentation/process/cve document to Korean
>> Language. Most of the Korean sentences are looks good to me. But only
>> one sentence seemed unnatural.
>
> Thank you for the review Jinwoo.
>
>>> 잘못된 CVE 항목들
>>> =================
>>>
>>> -해당 배포판에서 변경된 사항으로 인해 또는 해당 배포판이 더 이상
>>> kernel.org
>>> +특정 배포판에서 변경된 사항으로 인해 또는 해당 배포판이 더 이상
>>> kernel.org
>>> 지원 릴리스가 아닌 커널 버전을 지원하기 때문에 Linux 배포판에서만
지원되는
>>> Linux 커널에서 보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를
할당할
>>> 수 없으며 해당 Linux 배포판 자체에서 요청해야 합니다.
>>
>> When the first modifier "해당" is first used in a Korean sentence, like
>> "the", there needs to be an explanation of what it is targeting.
>
>
> You're right, that phrase was awkward in the direct translation. Thanks
> for catching that.
>
>> However, in the process of literal translation, it seems that "the"
>> became "해당" due to the difference in word order between Korean and
>> English, And since the translated sentence did not describe which "Linux
>> distributor" is being described, it would be very difficult if
>> "특정(specific)" were used instead. It seems natural.
>
> I will send version 2 patch. Thank you!
>
> Warm Regards,
>
> Yunseong Kim

And I added Jinwoo as a reviewer to the documentation on patch version 3.

On 5/27/24 10:21 오후, Yunseong Kim wrote:
> I added Jinwoo's name here on version 3.
>
>> +:감수: 박진우 <pmnxis@gmail.com>
> Warm Regards,

Thank you for guiding me Jonathan.

I'll keep the process in mind and use them to help the next person who
translates to Korean.

> Thanks,
> 
> jon


Warn Regards,

Yunseong Kim

