Return-Path: <linux-kernel+bounces-448319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE279F3E79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EB718858E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1E1D9A51;
	Mon, 16 Dec 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Pe/Edh"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144842A9B;
	Mon, 16 Dec 2024 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734393232; cv=none; b=a3ouCw3aZj0gHzQdt3b2CgUbnbVZAosXAx6noO3xSug3ns2/6W9QccvZHrtpjzJIGSUVuOLZWiWetENwdHwWXdZqgQhuMVkNyuEIJBx0xjrGf2ktoAZPX0rgW5H1oHDDeG+zgvWdw87fDDHXMQU9fsTiWUgEelicSgItNs8J9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734393232; c=relaxed/simple;
	bh=0q+3VBopVRsuWei478P2PzsJh3jZpBMy2zKrno2FNpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9+uzWFCs4MtyxLWCNnCfSOn2o3mUTVV07CwKTq0ABf3nMWV+lJQ415+f+MQVczddmdI3hu5FFP8yBML8k/GPXPaqw2OoKBGeGHE/jcEZkXNyyhH3TmO0rbztR972f+o+9fV+EvHylyQP7Wam/7yUnYMzZmc63rR9C7cTgXqpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4Pe/Edh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so4040532b3a.3;
        Mon, 16 Dec 2024 15:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734393230; x=1734998030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AYsCzgj/5ODkiEST6+6L5KNVoz2P7jT/ZqfLUwWWO0=;
        b=C4Pe/EdhqDwJ99zi6oJe5LzBRiwcTmmD7dEmB5peypO4pcD66rQIka+n50Y60t7xmg
         JEyK7GUByCxsVmUCOP57NAmBsIj6veIhHV8K0YWNs0Epp+BJTS9LGwObk7LQTRVa4qPM
         yo8upAKBHFMC6I7HWEWf2XC+UoyG693DA76Q62csgB+aExj6dPBk3OjQw0sI7a4ifWp+
         af2SJ8qBNq9pstnPtWDEXxzd4B8sJelNXut5KR5jRpb5mAQXdy1PbJVs4n/4Zuzw2JGn
         axuGj4w4Ew3VkrSAgW7sIfRK1xmK3YcFfoZu7RjWp1Bnow6hPQ2qObeuBKkY9xZs3R/1
         0MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734393230; x=1734998030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AYsCzgj/5ODkiEST6+6L5KNVoz2P7jT/ZqfLUwWWO0=;
        b=qlS5riZKQdIoQXQpuqaHUefW5UBHdhZJHuoN090I5+MylDgUZA9Gc8eMhO4jhLtYFY
         wR8X9K5ZJcjYO4VK+uXskqbxGHhu8Cx3DNK9TowNPnMFWRQ49IqeL4SIjflRYGC0//H8
         dipylr7sDp89lJZLyInYCnqWcH/aYGuZKC54NSr3nx0ik76ZzxwTJkrNNlbkEs3TpYho
         ILFIB4cHbr/GeukzVHnFUJRQkIqN83HzKqyiVCibeJGzzy38ZEff0J4cGVfW9zsNh9OG
         rOf/jbBRp6jkJKPrjdqth/6MMzQYm0YkFSNn1WslhzomGx+VnRCB96UQu2sMhgQoqTwm
         JATA==
X-Forwarded-Encrypted: i=1; AJvYcCVMykE1vjOJPNb437Fa9uMOnzEnzjwj5+xa0lYFv1C/hU3l1jUQCMsODewSa1QakLDhQfiedb+hT8frlEpq@vger.kernel.org, AJvYcCWhX9f8RrlZhF5AYaCRzzaiSnmZu8dOBicS7mEbHKLGFjyWHrQzvPmkdC5QZMiN0XcGfvNsTEU4ubZLuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6/QlogZQazgklup1VrBnz7cDz5aRV2d1l+ctaxaScor9iVHW
	pW41+3XR0oPu29DKMm38Pt/Gwr8tVyyB5LfMF0WRz/pL4NEM2kL8
X-Gm-Gg: ASbGncvO3FYWcpXvrfw7j+xMe372jm92UGZuESkyIrCNTaQeE4mWoLLE5gAQYHopCYn
	EBxGYp1pFscozelRbg/ZPceXEI5bX+w83crjKIlqMF7vUS4YcHezMDh1kFd/CwfrNhvOw2sSjNl
	37XqulX2L4KxA76BDEoBWaUNlDt2RKtunugwtpJ5JC8XBY/EYhdrGxZjZxx5q89k7mp8igRy/mF
	gy3MSStV8yplpjmRJO3mR3LLBURM2UTsvDA2A3rDJdpp82H34+6nUn5GB9Dk9oDqECpoA==
X-Google-Smtp-Source: AGHT+IFlq67BlFxxYbTnNq3eqbfnNG8TL9UMXNRaExmf/FIKrMOnklGUHDXCbo3jvFTms/P5ipHnfw==
X-Received: by 2002:a05:6a00:4285:b0:725:f18a:da42 with SMTP id d2e1a72fcca58-7290c0e1af9mr22662779b3a.2.1734393230068;
        Mon, 16 Dec 2024 15:53:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b77335sm5304805b3a.118.2024.12.16.15.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:53:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Dec 2024 15:53:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Murad Masimov <m.masimov@maxima.ru>
Cc: Eric Tremblay <etremblay@distech-controls.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/3] hwmon: (tmp513) Fix interpretation of values of
 Shunt Voltage and Limit Registers
Message-ID: <64188480-09e3-4064-92e1-c1fa0a368cd2@roeck-us.net>
References: <20241216173648.526-1-m.masimov@maxima.ru>
 <20241216173648.526-2-m.masimov@maxima.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216173648.526-2-m.masimov@maxima.ru>

On Mon, Dec 16, 2024 at 08:36:46PM +0300, Murad Masimov wrote:
> The values returned by the driver after processing the contents of the
> Shunt Voltage Register and the Shunt Limit Registers do not correspond to the
> TMP512/TMP513 specifications. A raw register value is converted to a signed
> integer value by a sign extension in accordance with the algorithm provided in
> the specification, but due to the off-by-one error in the sign bit index, the
> result is incorrect. Moreover, the PGA shift calculated with the
> tmp51x_get_pga_shift function is relevant only to the Shunt Voltage Register,
> but is also applied to the Shunt Limit Registers.
> 
> According to the TMP512 and TMP513 datasheets, the Shunt Voltage Register (04h)
> is 13 to 16 bit two's complement integer value, depending on the PGA setting.
> The Shunt Positive (0Ch) and Negative (0Dh) Limit Registers are 16-bit two's
> complement integer values. Below are some examples:
> 
> * Shunt Voltage Register
> If PGA = 8, and regval = 1000 0011 0000 0000, then the decimal value must
> be -32000, but the value calculated by the driver will be 33536.
> 
> * Shunt Limit Register
> If regval = 1000 0011 0000 0000, then the decimal value must be -32000, but
> the value calculated by the driver will be 768, if PGA = 1.
> 
> Fix sign bit index, and also correct misleading comment describing the
> tmp51x_get_pga_shift function.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>

Applied, after fixing checkpatch complaints.

Guenter

