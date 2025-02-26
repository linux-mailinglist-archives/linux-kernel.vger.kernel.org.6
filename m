Return-Path: <linux-kernel+bounces-534956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F123DA46D36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9346316B505
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9225A65F;
	Wed, 26 Feb 2025 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQyepYDK"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692F2586CD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604496; cv=none; b=VB2ILYUgsei93Dwm5qt5iTqDRh5IDEeF9HoiqawwpQpemiObu5Xkt7Fx7pnVK2YdSjiJDYsMLRWvn+IAVbMShFDBeZZZ1wEIGvdNi6Fy0hubxvzZJ5MUgYxxZj8JItUgQ/IQ00TtCSmmJ6pquXgZXpRcLHI/dl+btefG3LarJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604496; c=relaxed/simple;
	bh=E1c29q1k3+hPHBUs86giej64N6HgJOnbesOhyZVRWkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY+7GNWbgfh0+KyUcbUH/Kdv9IaKDrVQPQeHWkFd59sdc0/WKVZEhRMJQpJktWs/UcVZbmxtf9ysHtRSa+a1NMOv/1/8GzdySJeRCPujoHo0OpK4rPNL5tUcho3WYo6BDxGGPIQQ4LRj9gIvEksj8DMIPrI3YDAVGVz2ulKI+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQyepYDK; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso25003039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740604494; x=1741209294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfF1Iqu17zlnxPN/qbmmV6kCrFr+eSAtr+JvZ1nEl4Y=;
        b=cQyepYDKsHin7kdPrt8zsJS3VF3p4J3phpKVPto6Ccc6yOB2z76ERWCynGxQGmwWGW
         sFk4upSOOteWO6NktxiRCnlxKJlZYoNM0qXCDs/dImEpfTTl8pNIp6nA9GowaaBVLZDB
         +9lQ9DVXHKuc9+Qf+P1HJWIfQj5z5iS3wpax8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604494; x=1741209294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfF1Iqu17zlnxPN/qbmmV6kCrFr+eSAtr+JvZ1nEl4Y=;
        b=Mr57O9We3e5dcJ12vMpLypfKB4SsoinGgU4vf3LEyhx5/RNtInhA8f8aEz+YOUuHnD
         H83NPlS5PBMEhJXWULPTBb0P5uE7IiLyBZkPTJ2L8CJ1epV0T4av/E+f9qchE77o7yBJ
         SZZFVrCMapHkCbWKERZFsn1GHxHPoV4zOExsomlNh6RnNzVoumz6F+ohNFW1GusUKCpL
         LpoJn2MM3Vid0YrhvqAZqm/HAMxN/ea3pmCX005Ck91MszQUhqqUAr6tK0nXvl91gHWt
         FjjviLtivq7Zel4WCDR57HKBGR8ah4gemUGR9wL77NVrius6fySk+2t0FsOkj7JDs1NB
         m6bw==
X-Forwarded-Encrypted: i=1; AJvYcCVitM1veD1MkoirTFpLIzP6wW8KMOrSnPqOac52NBgT8bAbVOaX2tmqGXkDCbmpGWh0XEBCoGgDlFLo67M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUtoJu82+byB3g0gxJZBc+KLZP0hzuhLnRWbUS+JL47JqqhXO
	7ORNRDopBnjwrO0ACorDFB2lMrW+ZFYAMEhnr0DKO6t/2O6B8czF2nSFdDpjn4E=
X-Gm-Gg: ASbGncuz3FtB26m1uypU+oRju+FG5Bd90DVRafyznBLIx2CjPhcZNKNS1zbmdQYHeJ6
	urRmMTlFIeab2pouqN5P7W9tm4ZkdzMHSajBT1KNlliC3A4Fi22glsa3BpPOU5qOp1E22A91gV3
	e8v+Lj9iG8EJs185nofuAbxugZBw7MCh5Nk/x1Eg+g9MY0kUW46KO3mqcdLy27Ncte8tkzp4Ro9
	tOJ/yw1gsxf+VlOPpD4cjEmwF1i62HpyHhtIie6mAWONQt4E+wfv5AauZ06D7uHQhNTA8DgjdIz
	7nxWgr5mA5gSaL2ViNpkQwD1iEIHMag+eOKe
X-Google-Smtp-Source: AGHT+IG+jg50kIWbCGxmzZInd7J5jXcpjOWX98KOihuv5522c7CQ+evo5WxnYAC8GIaepTI0uvYjmg==
X-Received: by 2002:a92:c246:0:b0:3d3:d229:f166 with SMTP id e9e14a558f8ab-3d3d229f29emr46992055ab.17.1740604493774;
        Wed, 26 Feb 2025 13:14:53 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d36166099esm9453395ab.31.2025.02.26.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:14:53 -0800 (PST)
Message-ID: <8b903a33-30bb-4229-92e0-f97c3ae0a906@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:14:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: fix GNU hash table entry size for
 s390x
To: Vasily Gorbik <gor@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Fangrui Song <i@maskray.me>, Xi Ruoyao <xry111@xry111.site>,
 Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
 <your-ad-here.call-01739836346-ext-7522@work.hours>
 <your-ad-here.call-01740598679-ext-1013@work.hours>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <your-ad-here.call-01740598679-ext-1013@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/25 12:37, Vasily Gorbik wrote:
> On Tue, Feb 18, 2025 at 12:52:31AM +0100, Vasily Gorbik wrote:
>> On Mon, Feb 17, 2025 at 02:04:18PM +0100, Thomas Weißschuh wrote:
>>> Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
>>> changed the type of the ELF hash table entries to 64bit on s390x.
>>> However the *GNU* hash tables entries are always 32bit.
>>> The "bucket" pointer is shared between both hash algorithms.
>> --
>>> On s390x the GNU algorithm assigns and dereferences this pointer to a
>>> 64bit value as a pointer to a 32bit value, leading to compiler warnings and
>>> runtime crashes.
>>
>> I would rephrase it as follows:
>>
>> On s390, this caused the GNU hash algorithm to access its 32-bit entries as if they
>> were 64-bit, triggering compiler warnings (assignment between "Elf64_Xword *" and
>> "Elf64_Word *") and runtime crashes.
>>
>> And take it via s390 tree.
>>
>> Shuah, if you don't mind, may I get your Acked-by?
> 
> Hello Shuah,
> 
> friendly ping. Could you please respond with "Acked-by" if you don’t
> mind me taking this patch via the s390 tree? Or let me know if you plan
> to take it via your tree.
> 
> Thank you!

Yes. Please take this through s390 tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

