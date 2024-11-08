Return-Path: <linux-kernel+bounces-401339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005749C1902
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E7F282081
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BEC1E0DDB;
	Fri,  8 Nov 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=visucar-com.20230601.gappssmtp.com header.i=@visucar-com.20230601.gappssmtp.com header.b="D0/+tu3+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C651D1519
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057677; cv=none; b=qCfFXlJmjYu8/yTxJy8/LcSyfAOQN4siAUCMopD//tkN2oveBKD+hCMVZ9H9C9KHDtlArPxcoSKvvpfAzztt3Y4QY2YARx45jP6FPjxxPN9wuKFF2TcemAYTMSBV6zSho1voogATULXXCOva3aTOBO4wL4vW4GYjcqIfdBKINYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057677; c=relaxed/simple;
	bh=IG9s7zwiMEVGa3NC3/fFrBRps5FmTPIdUdw1SvVTBy4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YIkBeZbN8ZvVYbnyul0X9Jp/9BJ5/wX1rXx3EqaQpUvMjMT9VouCwwrs9jCWyXHELQ5phIHN/mAtTtEMlqGWvinDCO9ENPOLxZn5HAP6nC71FllB0tmWQbLHbHZHft1eiEmDZg2J691lvwkrS7NXqbqQ683QYZn0tZ2dPiVN+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=visucar.com; spf=pass smtp.mailfrom=visucar.com; dkim=pass (2048-bit key) header.d=visucar-com.20230601.gappssmtp.com header.i=@visucar-com.20230601.gappssmtp.com header.b=D0/+tu3+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=visucar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=visucar.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so278111766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=visucar-com.20230601.gappssmtp.com; s=20230601; t=1731057672; x=1731662472; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy0sKvm+7yx0IMydMthJnN0nAQmCesl7y6QaqCahaLo=;
        b=D0/+tu3+yVglbYqJoCTHJ9w3XUaTwl98KRB0NsJRoFH8Io1YHQ4wPXlNTzPdlktYP/
         Sb9P97xpeiL4Rr/9nREo4OJS0mCZdpKyd8u8aZPe8rxtltnO6EEOZcRk0w8jccOHpmG9
         wqbETJVzdBaQq1Cm1dLA+/nh+NWy/aTd/sK3PvrcRMV4jGqnpb/SMjq2adVxjbMzvHDl
         JuceLEjAoqKOoz6wweWkFCGWX+85DJj70GPQum0E0Pl+IjnG9spB9vls39302YvrtzmS
         /LfEkt/GbuSH8O/BWJgNmBGvmdaquBVnXY9M3tBg24wTdQtiSkIUT41ZxDjMEDKFbZqe
         GQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057672; x=1731662472;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cy0sKvm+7yx0IMydMthJnN0nAQmCesl7y6QaqCahaLo=;
        b=t2uqILSAfBRtNIzAS3vyJXxzSgwprpgvogg6vAeSCEtEOgpwhMRiSCDsggTzbvnDA0
         WhpYS23TYbRsHoBmcFUsKoBD9mZGshHbho0SvvEjwof9p392ZBUJQvfQZpYOldmRoPzR
         WOGdM9Teq1xaKWInocqBgiV6CjdJw7Uh2ezz4sduP4NUlxElik1XHwlHXK9Hh4iDH84+
         jZDTp4kMI3OsEEVWRBdDcrdBp/p9h7xb201rbSSQxaB28Dh5e5DaF+btAkhjVXnwl0Te
         H1rUhO4jHlrJR1kvmdwb1S+fyLZmWxzThb00jWPvohjCmWzf6XhVZQZ7nm3HkhZP+Sns
         YbJA==
X-Gm-Message-State: AOJu0YzSKf22zLGvacDjbzEvfUlaf7qK5mj+mVk1KujGzqqSrSBdVRC5
	mNaeAefETOLJc5O0GXfCJQB2gP9FkLKCvvqgY6Z+nf82/S8pXST+nhTYB09eZPv7qZAS7Y+W504
	0
X-Google-Smtp-Source: AGHT+IH+MxBYvOOFOFr+HtYq7ZL2Ts7ExzeaEahtmRH5GpV0kKv841bX/Zx9DlThXaudfxe6JX4WvQ==
X-Received: by 2002:a17:907:961f:b0:a9a:420c:d1a6 with SMTP id a640c23a62f3a-a9eeffee0a2mr176613866b.48.1731057671955;
        Fri, 08 Nov 2024 01:21:11 -0800 (PST)
Received: from [192.168.1.68] ([88.230.160.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fb98sm203861666b.176.2024.11.08.01.21.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:21:11 -0800 (PST)
Message-ID: <5e36543d-b46b-41c5-b657-4275185b4f1e@visucar.com>
Date: Fri, 8 Nov 2024 12:21:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Bugrahan_=C4=B0mal?= <bugrahan.imal@visucar.com>
Subject: Question About Linux Magic System Request Key
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

     My name is Bugrahan, I hope you are doing well. I found this email 
in https://www.kernel.org/doc/html/v4.18/admin-guide/sysrq.html, and yes 
I have more question :).

     My case is about raspberry pi which run raspberry pi os based on 
debian. In my use case power may suddenly cuts off so I cannot schedule 
a shutdown perfectly so that leads sdcard corruption. But fortunately  I 
can have a clue that cuts off will be in next 5 minutes. So I was 
thinking remounting filesystem as read only for that 5 minutes. If power 
cuts off memory will be safe, else after that time I remount this rw 
again. I search and found I cannot remount / partition while working on 
it with "mount" command. After a search I found out magic sysrq-triggers 
that seems solve my problem. I run "echo u > sysrq-trigger" to make 
filesystem ro, and "mount -o remount, rw /" to return it rw. I want to 
be sure about this process has no side effect. I couldnt find any 
documentation especially related with "u" so I asked you.

Thank you for reading my problem, I would be glad if you guide me about 
this situation.

Sincerely

Bugrahan Imal


