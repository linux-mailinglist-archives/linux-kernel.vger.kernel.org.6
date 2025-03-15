Return-Path: <linux-kernel+bounces-562369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C67A624CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265F442198F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42DC18DB07;
	Sat, 15 Mar 2025 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beEPWjiZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB7176AC5;
	Sat, 15 Mar 2025 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006470; cv=none; b=aQT/S4RIVDZdrAQcex/EVb2YMIst7RmZ6fCv9VB+4IwmWgBOoGBoO4LE30SxymzakzN1NFoDmC0GzXMxtencXutyTT8NqUv8T8wpSx5tjLLJxN3BgGjinDaim0ppinY5akoph6YIksoJXSH+TVQBvEVPYSZf0u3QWduI0H0Zhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006470; c=relaxed/simple;
	bh=B2CEDEhFdSbK5+6Qq7Xbe3jgxhR1ZYSO6nxrloEY2NU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qhGUjV5dubtXcpO1H6pf7CIWd3/e8XOoOIa/pRscDImYbjRQSvPm8zkWxsvnEft2CSMWD4PujvDcXO+7ynxUqvhT4vdIeUO5AFFg2k3d7GAUTq/A6q2jwwsvJBrZJ6cRNkw0lLq+9HW1DUhID9i4nmJnC1pYNfD51yWN6/pprGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beEPWjiZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22401f4d35aso52834385ad.2;
        Fri, 14 Mar 2025 19:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742006468; x=1742611268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15gdaJdchlrAww0ZPYIU2PXFNpF4h7zH7gWYODgucLk=;
        b=beEPWjiZyrZm03q1pxZVD2JcqxcrxrI2BIqVe4XpadEOPmrRMnwOOW5fMG2YAA2sJs
         xeKVPMQh3PaAM+Yyr6noCuQa+8+0lDDzSHRErwSJPZWSKUcT06qyKS88MACVCkjmFlKQ
         oNVhn9yrncj9HFJV7ju9QYIYa0JeNoTtFmhIbMi+F/mliPgs6x7Uunna7+3I8iPigB33
         bPvyE4IfRVmMss/zoIIMjNNDW5US8mVjIXj5yTG7cXRtt8WcS6jBoPLVajG43ln0FrAj
         KIVvvoDZzBPzvH1T1+lspjDsr/t/Uzu0Jn1cTFUVzzhSlaAyhKbUuf18+b+h8+nDdssT
         kE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006468; x=1742611268;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15gdaJdchlrAww0ZPYIU2PXFNpF4h7zH7gWYODgucLk=;
        b=aJgEqjNCB3Lb8/cXhC8EIVreQx7i/XOtf3MWWMARYfCbO/6zzDiiO+KhTHdFWcbAxb
         Wa2oURCzxHlrj0BylaFYJUKo69O5H57kaR4Dgt4oq1SEl0xR0fmkAaqfN24ovpW/9x8J
         +LfAgqAMSsVDPD4OwrkPmfMe5qmDgDOagAgkI73bqzR2cQLzYJH50pzhmnWeaHD6CiwB
         OIs/2cHg+RHIYIELBDK+r75xaZbTpNQstJeXBCk9kNGldqc3A53iJGJ6HAj6ku7714Np
         7jtAepSqK8g9X3rZWXk7H0gMVL56DCZEr6nIaZ450RIer/5UvvN9hpIJSTXhSaMLB5lA
         ZbtA==
X-Forwarded-Encrypted: i=1; AJvYcCVIl4EqAPCksVeoXbLCIiZhjE9b7337QKqhs/lHZFZU6C2hL8WGwZ7GfXuO2u5UMJWmGzGOeZk0Bsk=@vger.kernel.org, AJvYcCXUBsOI5cJ0IOfe4jKqo34pfghJB6KnnjPp16vgx/iBfgh/aqN2lAifCQtDhnQvQ2L43zTE3898bYVl+0cu@vger.kernel.org, AJvYcCXqHOPnvbchMXbCRJiXa1QP5qNFa7DYH0dFhLr4dso7VZyArR5fBJfsHIReMyWo46rcAvhX7mNaFYhX@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvyPtf8QkRn+tkJNpONZOdiwJx7lCzJqXgg8Gbc7WncEjOzPu
	vj/OKzHx+CTAE/y7pK19n1xFCQ3GUVRrJls+/iHlk5o6kIMOkSPv
X-Gm-Gg: ASbGncv0JnaUqpSz3kt0TE9kpABvWYGgNyYTVW0lQg7RY37yjnXc00VpLBqbwSiBA4i
	5zARNJC9piTlNhbNxMRyxvfHrH7zbVnv8s/XGGxlWW/YnCU5AJL+enigC2IYmCgh/nemGWuwlED
	b6pR4EHk3qIEXvx8rDIUDg1QDys5qo7x2SS4pQ58sz6cmANLd+r0ngzW5pWpx86UUPZ7+3o8KuI
	IurL0YogjtsETgB4FgZGrBV4CAQk6KubCvEyEFdcxqAKDS1GTcNUyNt36B0G18O3C3LoiscMapz
	7vjhD+yDExzC2E0jDH5ljj1bw1FzuuxgRrT6TU5CYZah/urP8q0BH7geqCpwlc6iiD4zCr3PXwf
	9qoHKns8ZcIr7XH8=
X-Google-Smtp-Source: AGHT+IFaFRZP4GF2msqauqXMGAobEitpbtIOLAfjlGUx0Lcd1m68pCYkXYMSC7iLEn+TyVaHIjArSA==
X-Received: by 2002:a17:903:2b0f:b0:223:49cb:5eaa with SMTP id d9443c01a7336-225e0aeeaadmr76664625ad.35.1742006467666;
        Fri, 14 Mar 2025 19:41:07 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba740bsm35410785ad.122.2025.03.14.19.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 19:41:07 -0700 (PDT)
Message-ID: <c6a697af-281a-4a91-8885-a4478dfe2cef@gmail.com>
Date: Sat, 15 Mar 2025 11:41:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ignacio@iencinas.com
Cc: corbet@lwn.net, dvyukov@google.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, workflows@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <1d66a62e-faee-4604-9136-f90eddcfa7c0@iencinas.com>
Subject: Re: [PATCH] Documentation: kcsan: fix "Plain Accesses and Data Races"
 URL in kcsan.rst
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <1d66a62e-faee-4604-9136-f90eddcfa7c0@iencinas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Ignacio Encinas Rubio wrote:
> On 12/3/25 23:36, Jonathan Corbet wrote:
>> It would be best, of course, to get the memory-model documentation
>> properly into our built docs...someday...
> 
> I hadn't thought about this. If this sentiment is shared by the LKMM
> people I would be happy to work on this. Has this ever been
> proposed/discussed before?
>

This might be something Jon would like to keep secret, but ...

See the message and the thread it belongs at:

    https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org/

It happened in 2019 responding to Mauro's attempt to conversion of
LKMM docs.

I haven't see any change in sentiment among LKMM maintainers since.

Your way forward would be to keep those .txt files *pure plain text"
and to convert them on-the-fly into reST.  Of course only if such an
effort sounds worthwhile to you.

Another approach might be to include those docs literally.
Similar approach has applied to

    Documentation/
	atomic_t.txt
	atomic_bitops.txt
        memory-barriers.txt

Regards,
Akira


