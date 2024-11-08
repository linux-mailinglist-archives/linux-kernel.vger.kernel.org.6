Return-Path: <linux-kernel+bounces-401125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25469C1630
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FE51F22168
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A61CF7B1;
	Fri,  8 Nov 2024 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imDMGRyR"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048F1CF5C8;
	Fri,  8 Nov 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045120; cv=none; b=QiMQnF15C0qKIfHJt5GihvdwYpzIjAWZFY/ctTDtFUbNRSGxc5LUKqNHs/YcRI8wl27Ph5db6ITqYbRaHAA0E1KWiPqOnEFMnVKGHGTAJPbITbPovFJcz9s/i4l5srDbBMmhLWW3CIqSJEyIknChzxC78vnPrqLJZpbIzIZRWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045120; c=relaxed/simple;
	bh=FldH5ezVCKzA4ilhWwESkXoEsqQSxz+NQnJCrsnSmDo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AQ+O2oTe9fn+Y7cKCAwahkd/hS5+lsubLpdJdnziHdYIc03Xouw8Q35Lvk+CL+nnL3xnfj4agdAyAhnMJ0TT3KFySJC9p1glhP7VcYXMCfEegOAdlVh4OwDtY/z06W5j4QEKDgL0nrqjnKhbHPlDV8P+uwUBw6gqGryOifEv/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imDMGRyR; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-288661760d3so935197fac.3;
        Thu, 07 Nov 2024 21:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731045117; x=1731649917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqQKVoQIIB/alco7tDnCa7tsUMIzxx7+4InKayAOpSw=;
        b=imDMGRyRqwhaM7xaIuhA8vIf7aO3Uv7G2chzV4oPGqJDRvUFoqCtCJ4ah0oixEBcH/
         5cYdkjDuy0+JFcLzduPfqMdcI6lD2wCTOZyD1DeYBakFOssH6BelvRrC9iiCzLZ5cYAh
         wD5dqHRscZKWGQSLai4isgYpSstR2ftfxJpP2T/xx2TGtfFukBMbtjSWk1HR+F+mt06u
         hPTeJ2Tcu296eiik7O0QXLZ5yVvE3KV2mIsA+lET6rVZ3ru6Brhozn8+vDMdUIsKn8IO
         eFi+hty103KE8F05g4DZK/tVHer7dj3zgOceo1Qlsju2ny210jrzs9zDpM+DNRvNEaPw
         U4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731045117; x=1731649917;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqQKVoQIIB/alco7tDnCa7tsUMIzxx7+4InKayAOpSw=;
        b=IfFDqdttZ6P3pxfVUn4mdwSQ2/+NvkEu7uc50Qbh4j5KkclorBUCnKUeH9fCgwV0Ya
         R6MiiY7T2JTSDoglW5dAduPwN5Lo1lhpCCoOvmmKHvuhS+mNT6ERAS8rYdfc9DqTiq4A
         xBX9PPQmErPxRcJph+mY5VwVDOviYYoRZHO6Fc0hzygWFwYR2TkAoargKugLxujRGYCb
         iOnpmWxVpkX4HwJHhByGw4FPS0n2YFWNTmpuWgmAO0ZmFns6t+S/kI9vC8BAj/HcisHW
         3lVQDpPz00l7gQVPzcHDLfbxzEi64bamSndG/yr02DdYRFcNfhK4GU/ibHODJxq7SX38
         cPRA==
X-Forwarded-Encrypted: i=1; AJvYcCV6MhxjwRCVTCVaCk7oq6D7QZHyHczF0rrSlQClZjypGsl98F2qjqsoxM9B1xG2rahaUFAyGEQ6ZgHCo56H@vger.kernel.org, AJvYcCWHCoCTHeQMgF2gNimVKZSvTxgzQe9KG5SMitXo4TwbmyUmpEy3IMNzK81bDd8y4wRhcL37pjZMG4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyxr58X9BEBPKXqYi/sf+eblEeqyqV8wx70rKs2EUDfFgpkkiS
	xQ4htwgBfVSaMG74CxYGM9MtTjwY7n3Z6X95Wqdil+LUwET0J1ki
X-Google-Smtp-Source: AGHT+IFkZaTZJxaNXXPpZuSOVEsTRJR2nEjo5hkiRAfTbYsTwu37oqi4krQ0l4Ej1anGCJLRJlEz4A==
X-Received: by 2002:a05:6870:5e53:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-295600c5b27mr1930081fac.11.1731045117421;
        Thu, 07 Nov 2024 21:51:57 -0800 (PST)
Received: from 1337 (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ec7sm2752918b3a.55.2024.11.07.21.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:51:56 -0800 (PST)
References: <20241107063042.106228-1-xandfury@gmail.com>
 <464b1628-957a-485b-87d9-47636491de22@infradead.org>
User-agent: mu4e 1.6.10; emacs 28.1
From: Abhinav Saxena <xandfury@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, Zhihao Cheng
 <chengzhihao1@huawei.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] Documentation/mm: Fix spelling in hwpoison.rst
Date: Thu, 07 Nov 2024 22:50:46 -0700
In-reply-to: <464b1628-957a-485b-87d9-47636491de22@infradead.org>
Message-ID: <87ed3me0j3.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Randy Dunlap <rdunlap@infradead.org> writes:

> On 11/6/24 10:30 PM, Abhinav Saxena wrote:
>> Fix spelling of "focusses" to "focuses" to follow standard English usage.
>>=20
>
> We accept British spellings.
>
> internet says:
> "Both spellings are acceptable in American and British English."

Ah. I should've checked contributing.rst[1] first. checkpatch.pl flagged it
for me. I did not look more into it.

Thanks for the detailed reply!

[1] - Documentation/doc-guide/contributing.rst

>
> "Focused" is the past tense of the verb "focus" and can also be used as a=
n adjective to mean clear. For example, "She had a focused approach in trai=
ning".=20
> The plural of the noun "focus" can be either "foci" or "focuses".=20
>
>     FOCUS definition and meaning | Collins English Dictionary
>     ), plural, 3rd person singular present tense focuses , focusing , pas=
t tense, past participle focused language note: The spellings...
>     Collins Dictionary
>
> Focussed vs Focused | Spelling, Explanation & Examples - QuillBot
> Sep 10, 2024 =E2=80=94 Published on September 10, 2024 by Trevor Marshall=
, MSc. Revised on October 29, 2024. Both focussed and focused are ac...
> QuillBot
> Spelling Tips: Focused or Focussed? | Australia's Best Writing Tips
> May 7, 2020 =E2=80=94 Summary: Focused or Focussed? 'Focused' and 'focuss=
ed' are two spellings of the same word: Focused (one 's') is the sta...
> getproofed.com.au
>
>     Show all
>
> "
>> Checkpatch.pl reported this issue.
>>=20
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>> ---
>>  Documentation/mm/hwpoison.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.r=
st
>> index 483b72aa7c11..dd02fae484dc 100644
>> --- a/Documentation/mm/hwpoison.rst
>> +++ b/Documentation/mm/hwpoison.rst
>> @@ -17,7 +17,7 @@ To quote the overview comment::
>>  	hardware as being corrupted usually due to a 2bit ECC memory or cache
>>  	failure.
>>=20=20
>> -	This focusses on pages detected as corrupted in the background.
>> +	This focuses on pages detected as corrupted in the background.
>>  	When the current CPU tries to consume corruption the currently
>>  	running process can just be killed directly instead. This implies
>>  	that if the error cannot be handled for some reason it's safe to


--=20
--=20
Abhinav Saxena

