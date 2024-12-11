Return-Path: <linux-kernel+bounces-442174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B439ED8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5E828399A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4E1EC4EE;
	Wed, 11 Dec 2024 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOmm5j3H"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B144384
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953425; cv=none; b=qJR+ODSowY22CB28fOF1sFy4E+4LIpcTeCPxwrLphDad2eay5DE8TKmd1Zj5wzNC7XnDy7BrLY17I9Fo6SjHgILzsXcZmTMGGWYqAQqckKSaZ8owTK6cIXAFKISaDJrzpNwhgOHK+Qh1zn8Xyl00OzheXy0NSzqNGqoaUG4juTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953425; c=relaxed/simple;
	bh=B6dLX0PCMF6LNXVlJ1hYteBUz0wRZO8TkeZkHqtFabo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3BrCWwpkT2Ka/WPFMy2PYF0RRsWVoBDSTkTUMQg0WJjldWCZ5LYcRIN8WaGrDptsBb7hNUF9EZpK7DsVs3w3/6mNplbq6m35EWml5anrJ9YMUXlGsSYsH89gvZheoZaywQpmKwnG0227mb57anF/uUqJWQBCP4U+ZzeNMe9E4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOmm5j3H; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so5033975a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733953422; x=1734558222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jANBAEDCtSv3pwk6q4Vw8RKGkd4R1NtNTLdDCiJ5iYA=;
        b=jOmm5j3HpjyyoF8peDMKiFFxW+u5WFtVW8nRMtfVccqd3OZ0Njt9cVpI4eSzGpbMSj
         ohf3ifT+RBIw4lQVS/cRw63RcrxVFjmM2szWLB229dLAcbhMobiVJYYMX080D1zv/YZK
         +hYEBeiT3GrcRro1uyDhMpyDaHIgrVmaXo90+bjR8Q9EkuX00xHHxDVRRd/SC8anEfcB
         pvbTsQoLxPPVqBWe+K/KG8yeaigMLxYiuC/hGSyf1SDbZ7pmZcaPyO7JZqZNkKj2Vt1V
         WVMh/CR9Vsg8ANw1QTyzyerFsrWLdYSUjVPKaBOCAfk73BfpZ6JUzHA9+bdh2dt4FZAs
         7HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733953422; x=1734558222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jANBAEDCtSv3pwk6q4Vw8RKGkd4R1NtNTLdDCiJ5iYA=;
        b=ud4jjLZb7206rEYQS6y3O6FvwhfGce5FNl7c9GzVJNcWrTHN99bHZ3/85npijKwLuw
         SRJWjKiqdVl7dRNL6h0c9JsRggiM1ldrOTWR5b6K0HpU05V/MipEq/2PQh98gDwXozy/
         pLR83twUNbCmXIs1lcM0b26rQ7yMfIA7dcYKJUrELiZh6xquEvAV12tkZ19WsFw9tYg1
         XWGXGVV28KzRxAiF/maFj4wmFmy32XK70PiC2QwPAaS11uoSpjvaoR2UwZDmUOSxr+Nu
         DScAF/ziYmXlONWabyth7O1TzlBr4NFLFWOAO35UKJ/7M6xQOqRD/Z8p9ntHNyBwh7q4
         Jhkg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJ9BLYIuZmKoNz8BDj2vkwVpIdZF/FgFGYJPBtYYZOwADNyPkanfz/DBA0Vs35Yp40/RAmFL/4xVdFyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtSR4iT1SsO3/LIR9lRT3/RzdWUUt6mw6Fl7tE1ZbQjQXuYmp
	xQbyTAkoBPKcCHS31/PiFxmJ+qhRc+TAQTwCmXOE6sFPx8Hugrjj
X-Gm-Gg: ASbGncv7JAzjD/v83pzf9Q75a99UK7elJ3UqGQVTMgLVE0LELvtqrYIAdIA6b6zJewD
	aBcMMVNyC/3K5jY1XMZrp5hBFSiMNbZ9E1rDie2PmbSuTp5qOl0NTm0rPaLxhgSFYHese+7kwYb
	k8ShqX5Mz6MbAAcuQNi1xmUhy0wboEFHtE8OxIGgi3/qWtNVHBcqRwsKQ2/yN0lGeuvquRVSr5O
	HpL/5m/zeh2VT75ysq+LeomQUrxS6Y/243QY7AyEvP4GnA++Euzze9oFef/bfuZwrG/XPeOaDhP
	IU69bg==
X-Google-Smtp-Source: AGHT+IHBaSDKbo7EyeuaVv+rCE+2o82gIsnu/jmJ9j1vGzncTgHiyB1QwqkT1BK6tAWSzDDQjpG1mw==
X-Received: by 2002:a05:6402:4583:b0:5d0:8f1c:d9d7 with SMTP id 4fb4d7f45d1cf-5d4330358cbmr11222914a12.4.1733953422181;
        Wed, 11 Dec 2024 13:43:42 -0800 (PST)
Received: from [192.168.178.20] (dh207-42-21.xnet.hr. [88.207.42.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a394d380sm304768966b.77.2024.12.11.13.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:43:40 -0800 (PST)
Message-ID: <f09bbd18-98bf-4424-9a7e-c5477c52a771@gmail.com>
Date: Wed, 11 Dec 2024 22:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/9p/usbg: fix handling of the failed kzalloc()
 memory allocation
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
References: <20241109211840.721226-2-mtodorovac69@gmail.com>
 <ZzhXCi_0m3X2AHpJ@codewreck.org>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <ZzhXCi_0m3X2AHpJ@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/16/24 09:25, Dominique Martinet wrote:
> Mirsad Todorovac wrote on Sat, Nov 09, 2024 at 10:18:41PM +0100:
>> On the linux-next, next-20241108 vanilla kernel, the coccinelle tool gave the
>> following error report:
>>
>> ./net/9p/trans_usbg.c:912:5-11: ERROR: allocation function on line 911 returns
>> NULL not ERR_PTR on failure
>>
>> kzalloc() failure is fixed to handle the NULL return case on the memory exhaustion.
> 
> Thank you, I've taken this in 9p-next and will submit it to Linus next
> cycle

Hi, Dominique,

Sorry for the late reply, but yes, it is perfectly OK for the patch to go with the
next cycle.

I confirm I can see the commit in the torvalds tree, so this is a minor patch (+2/-2 lines),
but a proof of concept that it can be done.

Best regards,
Mirsad Todorovac


