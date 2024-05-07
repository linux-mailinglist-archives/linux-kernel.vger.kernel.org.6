Return-Path: <linux-kernel+bounces-171436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0D8BE446
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF48E1F2212E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C86161305;
	Tue,  7 May 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEBFPluU"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671D15E1E6;
	Tue,  7 May 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088586; cv=none; b=U5kT7GVfxgpiWCaFbPjH/GtZHmy1IuzJIImT9wyWo6xShFOIkqbmwOCeEWaxQ7Df2YElfBGsgT1qEFSY641otu+kxCEKOawpDXyxQcD6UhyB8nYcR+WueYTPakCE5u3Sk0c3eJu+kiQLbMxdeB8Cpb8CYTO91Oatd9q5Plexvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088586; c=relaxed/simple;
	bh=XIDDqhsY7R4tB/pzk7W1mDLu8wlvA1ti+3tET5M5PbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljUehbLj37c5ZHimgzHLlHccuDjcoIOesFKSX7joEFLRFBa8eNNYCCoepa2K/vPlty+iy70FG/N8//oUbsKUcjMtJ2EtC+VrK2pe/NN4GgslPQqdWVxp2oS6414+1k2NSa9jTP/nFZJhUkz3a8q4ZuMGiTj8o9/dsnW3QDqdZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEBFPluU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec486198b6so25501675ad.1;
        Tue, 07 May 2024 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715088584; x=1715693384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n569n9SL+LXTTL9px6BcI0Vvwn8aUwdrawtWOOlG8Sw=;
        b=jEBFPluUgGAeR/Pj9XEcbam5jUHmefM37mUuyiQ0nDPxOHlxZ5N9D1oj/AT++KFJYP
         jXJEcqw4gEeLvlAODiMj5IC4TN9mq/yQOkK3ciAIQHFS1VsfjSRr3RkRDvjt8ZGfHcOf
         MlqhJXQwOmj3uVtbT3CXcFhjD/jixh6fRYtZ/Vw0lj+n2IBel38eg8+ELrHi77eTOg+X
         JeI/VtoWhxTyZw7EzVTpOwbckWEE7OE3lkITbkqzVJmcgsN/htsHLbpOV9qiHo560hd+
         VMG7SHZ3XsJeCP+fo3nebpvABm9eImsPvexKj/2ofI6nvQU7DICeCdT0L1Xn4pyC/0Ii
         wStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088584; x=1715693384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n569n9SL+LXTTL9px6BcI0Vvwn8aUwdrawtWOOlG8Sw=;
        b=hfq9fSzW7wspFR7hBF+gB6wLBvZiLylyjwjkuOClOKwqfZb9JyjAxBsIu5TELoqs5p
         KkYHZgxXOoOmJotIlXtcloz47fW0Ssgw6vYZa9/XR2IVYHeB2dGe3hcs2IE3FniotcnV
         VoswZYtu2ZbgT70RF5Ogno7UmWTE1+Rbd4FvpoSrZNztBpyYbZnJzQ25Bk/hFv9EEAC6
         T+6YVU4mDr7MzbDOaoSi56ZYFzp7z1NAx1T6hpFHADY+TuLooxrRj7xJE/LHbd/jvv8L
         l+RS77HKcjdPabhvL9TSkKyovwAXVHxZMC5Gw9Ta+hicu0O3s1CbypVM1wDOmyS777Jr
         Eokw==
X-Forwarded-Encrypted: i=1; AJvYcCWimWDMGzxr+hPJKalM9D6bOvwrILlkytSxZO1AOqLlpi4kVeT3LegnSR1y5tcO6835y/AEH05NaBGjEuzSVcIsooxaglT9yaEEAPY0
X-Gm-Message-State: AOJu0YyBno9kQrDx7p6+Ggk/ySEdhCXO8aJVnAhhXrXZtHAQKykx+089
	QMhA1ZQ3Jc76M/8YO3y3Fjxu7KirMVXa+g9843AdoxURCVKWqATITOC8Hg==
X-Google-Smtp-Source: AGHT+IHyh74tDDcjx/C8ZGKboiDtZYiV/c1oBGr/ChzgNcDgf+0AZAkDc7pCAWg3HQHjWuYGL9npdg==
X-Received: by 2002:a17:902:c947:b0:1e4:a667:550e with SMTP id i7-20020a170902c94700b001e4a667550emr14988417pla.20.1715088583746;
        Tue, 07 May 2024 06:29:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001e49bce99d9sm10026261plb.95.2024.05.07.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:29:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 7 May 2024 06:29:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lars Petter Mostad <larspm@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hwmon: (emc1403) Various improvements
Message-ID: <5c3972c2-66f8-4a4d-984c-72c8f23d36d0@roeck-us.net>
References: <20240503154324.517246-1-linux@roeck-us.net>
 <20240506144412.139300-1-lars.petter.mostad@appear.net>
 <f0a2ce94-5610-4f0b-91ae-2d16d1b80dff@roeck-us.net>
 <CAC-Dm24im6hB71ijDS2rtO2W5ZEdQ=LnwGGzR0Oxir2=PA0u3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC-Dm24im6hB71ijDS2rtO2W5ZEdQ=LnwGGzR0Oxir2=PA0u3Q@mail.gmail.com>

Hi Lars,

On Tue, May 07, 2024 at 01:27:44PM +0200, Lars Petter Mostad wrote:
> > It would be great if you can reply to the patches with a
> > Tested-by: tag.
> 
> Tested-by: Lars Petter Mostad <lars.petter.mostad@appear.net>
> 
> Of course, I had to do some light modifications to the patches to be able
> to test on emc1438. I will post these modifications as an RFC patch once
> the above patches are available on the hwmon-next (right?) branch.
> 
Yes. Patches are there now.

> Note that checkpatch.pl --strict fails a couple of checks.
> 
Odd; not for me. I see a couple of CHECK messages when running it on the
driver.

CHECK: struct mutex definition without comment
CHECK: Alignment should match open parenthesis

However I don't see any messages when running it on the patches.
Please send me the log.

> > Also, could you send me a register dump of emc1438 ?
> > I'd like to use a real register dump for the unit test code if possible.
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 2b 2d 00 80 06 55 00 55 00 80 06 55 00 55 00 00
> 10: 00 00 00 00 00 55 00 00 00 55 55 00 00 00 00 00
> 20: 55 0a 70 2d 00 0d 0d 00 00 80 00 00 55 00 00 00
> 30: 55 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 2b 60 00 00 2e c0 00 00 00 00 00 00 00 00 00
> 50: 55 00 00 00 55 00 00 00 55 00 00 00 55 00 00 00
> 60: 0e 00 00 00 55 55 55 55 00 00 00 00 00 00 00 00
> 70: 00 0f 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 6b 60 00 00 23 00 3f 13 ad 03 20 02
> b0: 20 00 00 00 20 00 20 00 00 00 00 00 12 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 59 5d 00
> 
Great, thanks!

Guenter

