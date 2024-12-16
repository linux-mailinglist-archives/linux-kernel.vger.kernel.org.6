Return-Path: <linux-kernel+bounces-448321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF59F3E80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79837188E4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD91DA10C;
	Mon, 16 Dec 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLhAfij6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8D1D45F2;
	Mon, 16 Dec 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734393334; cv=none; b=mqz8Q0dgXamusCpj+hxYjteMI1EhKmO0M/RyEH5KYhiZjRNS6aeLTn/jXlZrMvKxeewUqH5AJtGf1WRPCQRPEoLWnDqAwzwaSlpG13SXzIjC13xXPAfBlAdgSRSgfRT3tDNuwlu3RGQ8vzpUIdBhkQafJtnMwP/kphynQylEB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734393334; c=relaxed/simple;
	bh=qcHiewX+vr3/Az4ll4cLmuIeb2/zHSNvQ//ODJgqH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmS/hY7nFl3I0tET346J8k1+iKLpW7xLEe/rJLjZcX0RPhW2NWLax9BZIh7TLGuFqsoly3xGBbMnJ6xMzg9K5VD3zW0D8NqrwnLN4HbBMvW4hFbFuzxVHLKzHBQ+Z4YyE+GORMrXN3Slf3dOC3+ZISsU5KVvpYU8uRj52fsE5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLhAfij6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso41397125ad.0;
        Mon, 16 Dec 2024 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734393331; x=1734998131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wTsNWNRPHTgTo4+QxL64lGOH0MS+Fi8hjHOqgs2z8Y=;
        b=FLhAfij6uq8+GB689ow4SgFEf14KccKSeJvzg8K/dLKu+ZYcRUeMqInloGh89nd4NL
         ua9WiEGwKvPet8ova9vNTX6lDsJJILjmZ5YUBiun8gFzIwbrKRsfGf6y9LznhUmuRCWf
         5q6havdAyNwqkOye09E0OAj4k66g9sjnLzn82kV1Ogm98d+eG9AuWqF74r4Eg9toW9FZ
         F/tvCqq+3/mF/f0FF5U6Psfs0jNpM1vCmI7g66PUApAgt/NrGpSNPio9J9eORWSYzSOB
         2zUVk+roIcOE8u2Tbu8vYXgFZoj9zIEr9qDI8sNqNgPASPQD0gnkVDpL3Tr/uFaiWdyr
         Gk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734393331; x=1734998131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wTsNWNRPHTgTo4+QxL64lGOH0MS+Fi8hjHOqgs2z8Y=;
        b=Je2cU74a2wP0k34/AWDbekree72eqiGcn43Zu3rZcQwJXagKEvbP+7KuoJJujO95DG
         h+P6QJ/HymuEwO3iTqZFpKL7lIU/ad8NgVOYNpJY5kD27rUMWBtld84BewSEI1rbH+Uj
         DJO8GmacFPf1d7sVr8rKnVDwRUL+H69i0tWeQFJ2dLBZxzDaS/ysuRRnxo8JpaeaLjOz
         0yThatH2KzfLw7bMaRLY5vUo6EH160P3h3LYYqLJfbuutkE/MVpkRM6Pw7DfQh8z5NV6
         g+V5tXfMyNqjdlpu9jdpes8+MS0JefUrE5XLhmdpa6nD8W+4QcIDeqLTNZSFqAPLywVV
         IgNA==
X-Forwarded-Encrypted: i=1; AJvYcCV1dighKFSZzYZPnxCWG1luDP/5nWPMhjx6MkOxxpay+bAl2y2cbwt75oLEloCHhpb5koVpAKXCEUXEdA==@vger.kernel.org, AJvYcCXzUv26n/Jl3GN6OEaIbT4pcrWa6EaXI0jTM4TOIiRI9Zugbozj1yMsxMP5FKo8+PEoOug4QpMD5IgwudNh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhj1m13WRuT/3Rch0EjgWRgDv/8EY/t2apuukE74wLyaXKEaPy
	Cv7LwYvrv/mNlhgaYJER/ns6VTTRssn8HWJQ+I2aIkkFAptbnoFH
X-Gm-Gg: ASbGncvsNVSEq92L65WAP9+iNvD49OMQEuN+6S6LwmYCv6BQiQ2QHTfw+bj9MBLBeT5
	P9tOuiUJtvySrW/ohvbUPAFhbegmhwPHHlWcOiFiHhQPxUDjzQxPt4DQ6N/iri0z9qcGKConJVc
	kilSFj3FAZSaRmrFSEZwVmOj6KaIO2PrnKWk/2oe6SV24qdT+U9D4VoKovFIRzMxwoOU1sUUeSx
	Z2r5kkfj+KTVDqfSn/j7kktbM+cUkuw1YwiZoZp+GRSVw7zViO5UB97bG9sXMfB2AYOSQ==
X-Google-Smtp-Source: AGHT+IE0SpGpDxkCpz81oeAK2UC6rPnNZPTM4DwIHcEMUmU4YwsHkmM7Sq1SYKdjoDDRFEIU2DHKcA==
X-Received: by 2002:a17:902:f68c:b0:216:48f4:4f1a with SMTP id d9443c01a7336-218929c3556mr180996245ad.16.1734393331014;
        Mon, 16 Dec 2024 15:55:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5499dsm46766075ad.126.2024.12.16.15.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:55:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Dec 2024 15:55:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Murad Masimov <m.masimov@maxima.ru>
Cc: Eric Tremblay <etremblay@distech-controls.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/3] hwmon: (tmp513) Fix Current Register value
 interpretation
Message-ID: <b2168d93-12c1-443b-bb5c-bfe6df71fd8f@roeck-us.net>
References: <20241216173648.526-1-m.masimov@maxima.ru>
 <20241216173648.526-3-m.masimov@maxima.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216173648.526-3-m.masimov@maxima.ru>

On Mon, Dec 16, 2024 at 08:36:47PM +0300, Murad Masimov wrote:
> The value returned by the driver after processing the contents of the Current
> Register does not correspond to the TMP512/TMP513 specifications. A raw
> register value is converted to a signed integer value by a sign extension in
> accordance with the algorithm provided in the specification, but due to the
> off-by-one error in the sign bit index, the result is incorrect. Moreover,
> negative values will be reported as large positive due to missing sign
> extension from u32 to long.
> 
> According to the TMP512 and TMP513 datasheets, the Current Register (07h) is a
> 16-bit two's complement integer value. E.g., if regval = 1000 0011 0000 0000,
> then the value must be (-32000 * lsb), but the driver will return (33536 * lsb).
> 
> Fix off-by-one bug, and also cast data->curr_lsb_ua (which is of type u32) to
> long to prevent incorrect cast for negative values.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>

Applied, after fixing checkpatch complaints.

Guenter

