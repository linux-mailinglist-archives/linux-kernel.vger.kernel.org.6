Return-Path: <linux-kernel+bounces-267329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400294103F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8430B22019
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A5198A15;
	Tue, 30 Jul 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvMM5qE+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949D18EFE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337926; cv=none; b=WkeBg8xEvKWCX04XIdblgqlWAm+DI/dVAmn6f20fdpJGNgp9cc94uGV0uoMkB5cUOJ7+yeNBlknAwONpCgDU4uHDI98G017PmyoT3UYYGSnBl94V22a8ENWxqHF+NwJ4HdeYv339S4RKGWjKPu/Agogzukd5/ks/XlZ9CYkIzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337926; c=relaxed/simple;
	bh=OiKNuyUUycHp+DcRuys+22df2w8deZY63KZCSZoiHbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+lKSZqwA4UGIOdtJtcRKvTQ4RAvfzj79Rmyfr3XTxIMWCdMxC3dgGpqDddnNcXXt94XGRjnXsIHN2XoYXCk5fbrsoZbvPuF9tvjiAGdBWiYmFFKjMPDgHh7Vs0y254MYvJz+3x6rkkLU1Lu0X8CuSGQ6W8QkDOznyKLOP8lk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvMM5qE+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c1e58eso5751767e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722337923; x=1722942723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIJ0xWQHIT+ZhGzKTfqkUzIlhOjoSzit5i+9fa21rOw=;
        b=RvMM5qE+M3Ex1jhtXT/fwRU9WoUIkOuhfui9OCUOlKqQLohfjMhbvEJpAalqJnz/ke
         vOrtRxvvAD6RAGK+xDButojkkRFA6pSGVCdTQiUlTsshoYhxmrndK9KEqQpASgUlnjO4
         CACoocRrIDsTWZfiCwGm6+g92QmYagwFVMXPOlcnoDUywnBxZeUbZDbMW5Oaa0IPImmZ
         sJxQXwio4pr1FWlyw4sTp5gx3+9YbLt5LP7gKSs533V/kOTD3lI6NE8xjg8am1cR5LAW
         FUelNmdOvqY0sQ5EKexq+fZxadSSzHgxE7xwuhQM9dL43j/RGwNq1auFMP9VOdBo9MyC
         4S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337923; x=1722942723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIJ0xWQHIT+ZhGzKTfqkUzIlhOjoSzit5i+9fa21rOw=;
        b=A1m+LMl6eX62qvrAlF8i+mFje+PFcfLvyNX2Y2J2weE5E1gGV0E5ei3obY34y8NKDJ
         H1fDQPKHAH3wOBkhBBW6wlqsTQsxjXUru3TX3Bg444NUwDkeOWVC47xEKSELWUhU7+ME
         xIBFYTquhbzZHFtrcJmPPocHDSCseWhQWaBqLzc2mK87JY6xW+fLaLOQh6RhXKINhhzn
         OLDHfQejO3kfm1nnwro54x7/lJx6+xq0WGPiG/7SOJwkqadipvZc+RUJV71vV3tQ9wYT
         dPpSH3043NO5XS0Q1sS5sRp+9VoRMNQHU7aaoelah0FAqVhOcJ1TVTkQGKI5s/HBDEZn
         ds9w==
X-Forwarded-Encrypted: i=1; AJvYcCXGAnOR9hTzSiNXBR2emcDGRpjLxFXiCP/cPP2CIQqk8SykB12M+eJDWOancMt+5vDmGQpmaDJ60GfxH3p9lkq6RTDUiL1nWP56Nnky
X-Gm-Message-State: AOJu0YxOBGfiajQ2TSTSQhBXNBzBGPwIkIq7+PLjBziMl7KgYslNQUgf
	D39BLbKIYWSheNvIbjaUjKyuFZR/bXLDp/OVob6513SRQZOn8zYyiOw3KAH1
X-Google-Smtp-Source: AGHT+IHUxD77mDH/d9mMpgxALtiJAh34ewMy3CKZweCMv3mJqycIuSfBladaljtDRbcVoiaKT23Z+w==
X-Received: by 2002:a05:6512:2ef:b0:52e:9808:3f48 with SMTP id 2adb3069b0e04-5309b27d45amr7968939e87.21.1722337922942;
        Tue, 30 Jul 2024 04:12:02 -0700 (PDT)
Received: from [192.168.0.21] (ip-095-223-231-216.um35.pools.vodafone-ip.de. [95.223.231.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414e2sm628783766b.127.2024.07.30.04.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:12:02 -0700 (PDT)
Message-ID: <15f5e406-f81c-4e78-ba1c-26430d4254a5@gmail.com>
Date: Tue, 30 Jul 2024 13:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ntfs3: Folders mounted with 555 permissions?
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <edcd6eb8-8682-6552-a5f6-584ac103d0e9@gmail.com>
 <05b8cdbf-6ca7-40b8-9292-f332e1ad3a84@gmail.com>
 <1d5d764b-65a4-42a2-8cc7-37d558aab381@leemhuis.info>
Content-Language: en-US
From: Julian Sikorski <belegdol@gmail.com>
In-Reply-To: <1d5d764b-65a4-42a2-8cc7-37d558aab381@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

well I would not call it a regression either because it never worked 
properly(*) in the first place. noacsrules option just allowed the 
problem to be worked around.
(*) Properly meaning that, however unlikely, this could be an intended 
behaviour. Having said that, ntfs-3g does not require any special mount 
options or chmod calls to be able to write to Windows' Documents folder.

Best regards,
Julian

Am 29.07.24 um 10:44 schrieb Linux regression tracking (Thorsten Leemhuis):
> Top-posting: adding Konstantin to the list of recipients, he might have
> missed this on the list.
> 
> Side note: this seems to be a regression, but given that it seems only
> few people care and apparently is caused by the removal of a feature not
> working properly beforehand, I don't think this is something covered by
> the no regressions" rule.
> 
> Ciao, Thorsten
> 
> On 27.07.24 22:34, Julian Sikorski wrote:
>> Am 11.07.23 um 10:04 schrieb Julian Sikorski:
>>>
>>> with linux-6.4, now that noacsrules option is gone, an old issue has
>>> become problematic. When I mount my windows drive, some of the folders
>>> in Users are mounted with 555 permissions, including the ones I would
>>> like to edit:
>>>
>>> $ ls -l /mnt/windows/ | grep Users
>>> lrwxrwxrwx. 1 julas julas          8  1. Dez 2018  Documents and
>>> Settings -> ./Users
>>> lrwxrwxrwx. 1 julas julas          8  9. Okt 2022  Dokumente und
>>> Einstellungen -> ./Users
>>> dr-xr-xr-x. 1 julas julas       4096  9. Okt 2022  Users
>>>
>>> $ ls -l /mnt/windows/Users/beleg/ | grep Documents
>>> dr-xr-xr-x. 1 julas julas    8192  7. Jul 15:28 Documents
>>> lrwxrwxrwx. 1 julas julas      24  9. Okt 2022  Eigene Dateien ->
>>> ./../../Users/beleg/Documents
>>> lrwxrwxrwx. 1 julas julas      24  1. Nov 2021  Moje dokumenty ->
>>> ./../../Users/beleg/Documents
>>>
>>> Is this intended behaviour? It appears to be quite an old issue [1].
>>> If so, is there any other fix than running a recursive chmod?
>>>
>>> Best regards,
>>> Julian
>>>
>>> [1]
>>> https://www.reddit.com/r/archlinux/comments/r325t3/permissions_problems_with_the_new_ntfs3_driver/
>>
>> One year later the issue is still there with kernel 6.9.11:
>>
>> $ ls -lh /mnt/windows/Users/beleg/
>> insgesamt 18M
>> dr-xr-xr-x. 1 julas julas    0 19. Jul 2020  '3D Objects'
>> -rwxr-xr-x. 1 julas julas  77K 20. Nov 2022   AMDRM_Install.log
>> -rwxr-xr-x. 1 julas julas 2,7M 20. Nov 2022   AMD_RyzenMaster.log
>> drwxr-xr-x. 1 julas julas    0  2. Dez 2018   ansel
>> lrwxrwxrwx. 1 julas julas   30  9. Okt 2022   Anwendungsdaten ->
>> ./../../Users/beleg/AppData/Roaming
>> drwxr-xr-x. 1 julas julas    0  9. Okt 2022   AppData
>> -rwxr-xr-x. 1 julas julas 1,4K 18. Feb 15:30  aqtinstall.log
>> dr-xr-xr-x. 1 julas julas    0  9. Okt 2022   Contacts
>> lrwxrwxrwx. 1 julas julas   58  9. Okt 2022   Cookies ->
>> ./../../Users/beleg/AppData/Local/Microsoft/Windows/INetCookies
>> lrwxrwxrwx. 1 julas julas   30  1. Nov 2021  'Dane aplikacji' ->
>> ./../../Users/beleg/AppData/Roaming
>> dr-xr-xr-x. 1 julas julas 4,0K 15. Mai 20:41  Desktop
>> dr-xr-xr-x. 1 julas julas 8,0K  5. Jul 22:43  Documents
>>
>> Here are the mount options:
>> /dev/nvme0n1p4 on /mnt/windows type ntfs3
>> (rw,relatime,uid=1000,gid=1000,iocharset=utf8)
>>
>> It is the main issue preventing me from switching away from ntfs-3g. Can
>> I somehow investigate this further to help fixing this?
>>
>> Best regards,
>> Julian
>>

