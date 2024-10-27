Return-Path: <linux-kernel+bounces-383713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA69B1F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD741F21317
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6780161328;
	Sun, 27 Oct 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1trphlU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341417C61
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730050612; cv=none; b=ixkYg66yBzXC/X6DRsEi6WmaxhRBozU6veV4w1UY/jRwMpIUb0SY1zfXgBkHCZJ1YODkuBZppQ3WeLcc2mBsTgQs3TJ4uBk3HvgvBB9NwPcV5mSd3+S6sF2L8I6PHv190nKmvz3UkePpOsxLZ3ZW9+btCC98XN+6WfLS6ca9iuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730050612; c=relaxed/simple;
	bh=nk3BoHr6WXxdBYL/OI3ipfxfR97iTF5ysl/ZtbrO7fY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QPCiO0/Tf38t3Eyr8wAvhM7QiC7eJYvafzfO2fkVeNzRn0quzziJN1WvJdwfAjc//kalIQPiz6X2YCOOGGBaelF8dFy72IyWJ8zBX+yfnWPyYiQmQfvkXgxd8Yx9Sf8EZ0gD4CsjXKGR9ClhenHhtEt0B391wHZsnscic1iRPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1trphlU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so4050823a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730050609; x=1730655409; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk3BoHr6WXxdBYL/OI3ipfxfR97iTF5ysl/ZtbrO7fY=;
        b=T1trphlU1v+CgKKSKuFkxtRXccnozfFYoPTdtWlVOdTDeFGYZtVmT9Y2huEYnSrv4M
         WmXB1jVvoFUEFtLB+DKtlMmlSNId6DXWKeZvwmQjOK0cEvZWNprabmE9AsRwfUSpbeTy
         s+o0MAbw8sudp3Ja/C/UdMn6LwEbpooJD06aHzHpIR7Rpj8Szg9/qP/z2/wR0aJo3kp6
         BENR2o8bR/6AVr3s90/EuN0Er2aXVN/aj29Bri5Ed3irphEDgmy6gFooWpe9olQWhiwq
         fZOtB2TpN8zFWRVV+4SOOVt5Ph/HrXVHCTw3T2ry4c05GIkJrt9rpIZ80MLE8u0ZeUZ5
         +PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730050609; x=1730655409;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nk3BoHr6WXxdBYL/OI3ipfxfR97iTF5ysl/ZtbrO7fY=;
        b=pU/SWvQGgJ1Bvw8C7ZUASO7Lv/5JeZVsWKyElltm/dD2bAnNx4uDQutOXMm/07W4oc
         V3TW5hviNeeJ8fdRpuDvd16izDkZnxmUY0ptuOXPtEpuQQuAbntjiZyp3vfNQLdYmrvp
         cRuCOQ1J/xxaKR2Of9W435MWOHkr4qB619X03i+qyuj4r1PBzyroqjg/mOCxBRGUhaIc
         TEUZOj0ibjtaaqAtV/uEtgxjaW4o0CVKBeVBZMY6jCP8sc2aR+UBEK1RWsM7rDIJ96Xa
         PtsrQyhKrPebJJ0dYxFhxY2Z9WvsPlomSHJ3oFuqeXkNuEdUifD2Ao13oYp44aLM12Af
         +IFA==
X-Gm-Message-State: AOJu0YzBB/gbpzSXCuXXykhD029te/ag5a//KJmxWk8umA1/an9xc5SL
	V3WMkLOUDZWwfYj4+cg0Uc9rv98MRIgwN8fLLUak1lXV5k5LUyS4u/o9KQ==
X-Google-Smtp-Source: AGHT+IHyhQy6s5Y3DetU7drvV/Jt6k2a/JVer8nkxIngCqwQXB60t9pxijU4d6PDGT+1+4hgJoJM7w==
X-Received: by 2002:a17:907:96ac:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9de63327c3mr537037866b.62.1730050608560;
        Sun, 27 Oct 2024 10:36:48 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-251.xnet.hr. [88.207.40.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a0887a2sm295713766b.215.2024.10.27.10.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 10:36:47 -0700 (PDT)
Message-ID: <896a538c-1509-4e88-818e-80c2fc0b83da@gmail.com>
Date: Sun, 27 Oct 2024 18:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: ReiserFS and Mr. Hans Reiser
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

Not knowing from which spirit, I am moved to speak with you openly about the ReiserFS.

I have read the "dancing trees" article on the web by the incriminated programmer. Now,
what I can say is that it is a work of genius. If it could have improved ext4 speed by
factor of 8x to 15x, then it is certainly not to be disregarded.

A mind is a terrible thing to waste.

From the sources I will keep confidential, "to protect the guilty", killing the file
system could be equivalent of killing Mr. Hans Reiser.

Now, I would instead recommend that he is given the means and the tools to continue his
work and development, as his rehab activity, as we are meant to be a correction facility,
not a destruction (Abaddon) facility.

The letter of last Fall year ago shows that Mr. Reiser had kept his talent, which gives
me the impression that his crime was not willful or was even staged and programmed,
as the communist secret services admit have often done.

We know that God doens't give His talent to murderers, unless He has purpose preordained
in His Providence.

Please reconsider this request, which by no means demeans the value the life of Nina
Reiser neé Sharanova.

This is a dark spot on the Linux kernel community which I am participating for slightly
longer than two years, so I am a rookie, but remember that the chain is as strong as its
weakest link, and that Mr. Reiser is still a part of our community, more than I, I suppose,
so if I owe him one, it will be paid in full.

If not in this world, then in the next.

in Xhris Jesus
Amen

Mirsad Todorovac

