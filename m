Return-Path: <linux-kernel+bounces-267985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60E941F07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC411C22CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54731189522;
	Tue, 30 Jul 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWdHq7mg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110415ADB3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361992; cv=none; b=PMVXmHWwjjsqU5r1lrGSOn39K4J84bMcgeyQSwn/NFlM1OpUVuYuknuiegD+i7CYVmhkadq4pbL7kTP9GZHFqZqtMXliVGB1UKtoIPf12q0VlN8uSLZJaOJhWUb19JYEMg9kZ2yGROoCQ8SuVDgBwpsYdHEtQ92cA9PZLgH2QLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361992; c=relaxed/simple;
	bh=Czf4YJE66OhV0uOYrMejAyjW4cbm5QqG+G5FrfW9+uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ida6p3FIzt6fMkXhwqGGQSJ3UxnXe8iDDcarJ/iDuv/T/dJB/PUXC5ya9VWIKnAKWMXsoKAJPlouCh3UkOs1eyx9C/u6y3wSe8zU/wqxNeY4cTstGzE24IJGOE2PFgSB6fKdoUea4Jsh6lx/o7Fl7a3c82jUGBBnvqCPp9/9FcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWdHq7mg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ab8f14929so49021266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722361989; x=1722966789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9vTm07aXTEkdNLGLjYuG1rQDZxP0zze4VZrn18Nt44=;
        b=WWdHq7mgQgMpri4+/TE6TOmRH4YqWVoI1a2N1Tv8GVmIetJ4s2L4Y8BbKbUZjgtnvS
         kKNF+V0DrYKGer3lWTtzAqf2hWHu66IgN3o1skcd7xsIXiAUrU+rsulqdWBBKrIL/S47
         1GO7nEsAQ0DSF35HhWzv+trTuPmMYG7SONAP7pgvsr3hUjFxHXFh77G9A4JkwpTnI+5T
         gZM6urGAyg3chWRWeus9pZeNrH2ayxvp645Qw6DrIF8axEBLbqmWTemqoRtCVG2WbwdM
         56m4eJMSJiKpXmnlRdWDxCNGSlo43rC3S5aJfY8zjS2ueLOJ/LotxlGzdaXsnW7U9UtV
         xSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722361989; x=1722966789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9vTm07aXTEkdNLGLjYuG1rQDZxP0zze4VZrn18Nt44=;
        b=Zc8zuRlqHlooV+yqymjxBjIWs0+k2jsNe6eZvVd5r82TJ3+xUl8fcbVM3ITpwAc2/j
         T31Mib/ay2aqSV1j/5YLpPgwjRQW+HSdvYEeu48jfSRH5se8tDF7E0gJ3A8cWKr92C2O
         eTgdzEOd1OK5CzI3DRTr0F6Q3TZzrRDHx0tf6aW/izzYh9zY9K4ws/uouT04XgWmlMcO
         syOitU6XJkaPVDXLmQHSsORLx/nom+elBymq3GclJEHQ00bcFioQNBUoOzkoQT9X2pCF
         cc4QwxqO4SLW8AVn+3kje3rI04ODhL0fWkFVvk3LAe3zypVGQv7SqNfT32oT/8YGI+3s
         Wdag==
X-Forwarded-Encrypted: i=1; AJvYcCW6qiJ9p178rQmCKkiI54xsSbF7zOIeI/9RWJQ8FKDqBUzR/Nut6+lFdSc+z6LNAuO1ezxtJltnnT87QBk2bhdJ8SxI5JGWPUd0KdUZ
X-Gm-Message-State: AOJu0Ywmf5h8pRL1JYH1bQliO1dHD2K4+vWf2fBKg+v05oItKpxfh/3m
	SiABXJlsAHtx5hWNloa6cMCHGEoachF9S5RpMHhmZ4MsX5o/AqYu
X-Google-Smtp-Source: AGHT+IGVTdXF6fa1R+7kdsDsyQK/aholuI/gOeBeg87pDLlYcbG9twe9QYTuW6T0bmdKDj+fMlaqOA==
X-Received: by 2002:a17:907:7296:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a7ac5b944bbmr879290666b.8.1722361988666;
        Tue, 30 Jul 2024 10:53:08 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8552:f0f5:c00a:214:55c4? (p200300c78f2a8552f0f5c00a021455c4.dip0.t-ipconnect.de. [2003:c7:8f2a:8552:f0f5:c00a:214:55c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233c0sm668263266b.44.2024.07.30.10.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 10:53:08 -0700 (PDT)
Message-ID: <410c5072-ab3c-4651-a7f3-10f7f3337814@gmail.com>
Date: Tue, 30 Jul 2024 19:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: remove trailing whitespace
To: Felix Yan <felixonmars@archlinux.org>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
References: <20240730063746.176245-1-felixonmars@archlinux.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730063746.176245-1-felixonmars@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 08:37, Felix Yan wrote:
> Fix the following checkpatch.pl error:
> 
> ERROR: trailing whitespace
> 
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> ---
>   drivers/staging/rtl8712/rtl871x_cmd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
> index 2613b3c2acfc..268844af57f0 100644
> --- a/drivers/staging/rtl8712/rtl871x_cmd.h
> +++ b/drivers/staging/rtl8712/rtl871x_cmd.h
> @@ -736,7 +736,7 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj
>   void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
>   void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
>   void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
> -void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
> +void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
>   				u32 tryPktInterval, u32 firstStageTO);
>   
>   struct _cmd_callback {


Hi Felix,

Please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

Please do not add extra empty lines in the description when not 
required. Consider that we have a lot of commits and it is most wanted 
that the description is short.

It is not required to add the name of the tool who found this, but it 
can be named. Much more important is a good description why this change 
makes sense...
For example:
... to shorten code.
... to improve readability.
...

I cannot apply your patch:
Applying: staging: rtl8712: remove trailing whitespace
error: patch failed: drivers/staging/rtl8712/rtl871x_cmd.h:736
error: drivers/staging/rtl8712/rtl871x_cmd.h: patch does not apply
Patch failed at 0001 staging: rtl8712: remove trailing whitespace

Are you using the right git repo?

git remote show origin
* remote origin
   Fetch URL: 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
...
git branch -a
my branch: staging-testing

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

In case of questions feel free to contact me directly.

Thanks for your support.

Bye Philipp

