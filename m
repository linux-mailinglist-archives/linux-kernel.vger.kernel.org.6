Return-Path: <linux-kernel+bounces-434224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45269E637E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6C286A42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2F13D8B5;
	Fri,  6 Dec 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnSRi1o0"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3ABE46;
	Fri,  6 Dec 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449431; cv=none; b=BCzck9z9E67CfDUApTHN8VUYOR1ekHH+0t75rZsE1jJeN8DPVALHRIdq46IMUziqYLBgRBvSDNxVomCCTjCJhmy8nJvoAP1oTmhjPqmI3EavTYMjefQ/N284geKiSfhvK557rj3+nsAk2Pnc1D0+zsEV9E3BWQ6hUu/agz1H9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449431; c=relaxed/simple;
	bh=3a28XM+kiu7wZQ5XmQFhCWh94Mx9FFtZDBQpPRXPgaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgjMTRHRGMkxGyce7ohIbS51yZ4nvX21ilhvlTzo36HQCalivJ+fzHcnKUufc2rJ7vwPka6WdqNaY/SFImLhFhg+1ZrGX/Qbg2rKAkINWobJ5pTxn/r7BnAqLfEoJiEOLTvPvxg1pKt8VfkJIaaPGSHfwjJ6Ki5nEFtxEMb4NWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnSRi1o0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725a84ff55dso914938b3a.3;
        Thu, 05 Dec 2024 17:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733449429; x=1734054229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvMuO2LzOEcK6bZJDOQK5xJYTAbXjx0HM3xx7EXHDhI=;
        b=ZnSRi1o0dloO7cfVzdz3Ls4l4EYKMLKBv2tq4I9vBc4vbrd60ATYKq1eU/YR9p/se9
         AsPZNR21MYxib3aUgD0GoQ3x6WADSz3oR/KylbcOLq3AnSFI686CVxVzvmUoKFnZ52En
         QpAmZYrePy9+JRpQqEumOWzjHNR6nuZAhjG7stvRVH5B7g3nnOTkFBm1VyC31QC5bZlg
         RVgQ0R+5NKyUQ4B6ZpMIs6LNiBav6S2ThYWyPiTPQopZ5qjoxAKsjlvPuk58i319GcIE
         HQtLrvGrKUvQmppyWus9w3DvF2wL4NwWysXecGvwUZTfVHzDiHD7HTA26aCKFShEjfwK
         GutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449429; x=1734054229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvMuO2LzOEcK6bZJDOQK5xJYTAbXjx0HM3xx7EXHDhI=;
        b=uJEyIIgYvDTCmAEfoIImy5CIEGpaUblcirvSzCPunF9aegnI73VDA2ktXuy7mKQe9R
         su8WAk5t8adlCJ+5MP3UylPND7MHRcxBK2+vLdzcuIQTmMYsE0rQPuVSgRJqwS44/TE9
         B2t3I54RgmRHrUfIrz4F1iYoVbjzf0MkdD+fS4n0S/E8Sqx6HKsTN6amuzahB3Rrv2kw
         nPFWjhqej6XJ5pkS5SiylNda1EeY+HAnFeOK2r1xDDmIq4/5EYINK3EB9zUIeWNkz+FR
         TzHbGSzHJ5QKIW8ZyAz+0bigMrZ76x0hhCbpgrNsyeoe02GBRZmoDAptNpz9KSHlxfHV
         sQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmQxcAatQFf7tyDohKiaYnEvkKbcQh71wtS2J114S2AlLAQHfFl1CBCfk4W0W9WALEDD64MFnzuTB2@vger.kernel.org, AJvYcCXtuYgXBu6NcS3v/CjW3LHMflMIHPF9LlLLOIJgVhg7WiE0KL83lip/YKo9X/M64sM/SVTw9qYPBLeKZhtr@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwKUTVZt2+RfnMw6aT2+bk7SVI5bCbl1CBXTDsBw18GZzwMu8
	cVPBlqAgUDZQYahWVG00NiPBI1rOMzDkyh9hhAhv+iWAYnTs693Y
X-Gm-Gg: ASbGncspjxxhF44bMvAj8fs4EgBZP1qQpw7D6SSVUzCTm34Btn8zW5t6j1EhDakTjeA
	01V3acfueyYPXOm4ucUjFshVBBCSsF40tYke5N+O/7e6dACtG1V3OZSX+t+vuNPO7T4vPuL45eZ
	zpk3djfoibE4jUgL9GlOMRGok8hEgSVtKYNDJqP/DBPKSaHWdknm2p0zR8kf1apVHoh10G6bL7t
	TP7+FzvBftvR36NZbHWzyMlfdOCuZ3VAilCT9zzOI2Bom/JJHmmvuZhBe0yFFPWzfblEeG/SVy5
	SP6E8hSKis0zs5RBeKAWoz73
X-Google-Smtp-Source: AGHT+IFYW2PobbERX0J/R0MGurhl+mv/yjucHbwp3t0d/Vn3DANq7WcMduBahQARhzIKRTXGHQSXBQ==
X-Received: by 2002:a17:903:188:b0:215:5935:7eef with SMTP id d9443c01a7336-21614d68778mr17893035ad.22.1733449429330;
        Thu, 05 Dec 2024 17:43:49 -0800 (PST)
Received: from [172.19.1.53] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f30fsm18793305ad.74.2024.12.05.17.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 17:43:49 -0800 (PST)
Message-ID: <d41c9484-6192-462d-92e8-c200192d37f8@gmail.com>
Date: Fri, 6 Dec 2024 09:43:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] Add support for nuvoton ma35 nand controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204025129.150525-1-hpchen0nvt@gmail.com>
 <878qsuwhm1.fsf@bootlin.com>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <878qsuwhm1.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.


On 2024/12/5 下午 06:26, Miquel Raynal wrote:
> Hi,
>
> On 04/12/2024 at 02:51:27 GMT, Hui-Ping Chen <hpchen0nvt@gmail.com> wrote:
>
>> This patch series adds the mtd nand driver for the nuvoton ma35 ARMv8 SoC.
>> It includes DT binding documentation and the ma35 mtd nand driver.
>>
>> v10:
>>    - Update ma35d1 mtd nand driver
>>      - Add unsupported write page handling.
> I was about to apply it but...
>
>      [31m●[0m checkpatch.pl: 117: WARNING: please write a help paragraph that fully describes the config symbol
>      [31m●[0m checkpatch.pl: 141: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      [31m●[0m checkpatch.pl: 348: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 352: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 352: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 429: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 465: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 465: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 466: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 466: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 467: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 467: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 468: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 468: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 479: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 479: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 481: CHECK: spaces preferred around that '*' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 481: CHECK: spaces preferred around that '+' (ctx:VxV)
>      [31m●[0m checkpatch.pl: 514: CHECK: Unbalanced braces around else statement
>      [31m●[0m checkpatch.pl: 611: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 650: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 665: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 675: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 689: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 699: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 715: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 756: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 805: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 935: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 950: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 953: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 975: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 1001: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 1018: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 1131: CHECK: Alignment should match open parenthesis
>      [31m●[0m checkpatch.pl: 1159: WARNING: DT compatible string "nuvoton,ma35d1-nand" appears un-documented -- check ./Documentation/devicetree/bindings/
>
> Please fix these warnings and checks.
>
> You might want to use --strict by default.

I will fix it.


>
> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen


