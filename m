Return-Path: <linux-kernel+bounces-174694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E68C1305
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B3D1C210E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D968DDD4;
	Thu,  9 May 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsqKPLPI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970CDDA9
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272384; cv=none; b=m4/TGbl/ZVlN+YVkfk3uoz4BY+l9j27se1b+EM3S9wKAHRF4Jm0BQ5TtjXp4JjuP9np2yOxvjD1elR8fiO2Z8rZ+F+i6yYp4lhk86fG/4t4JCyjmU5G7ER4InlZoyva14R7MjvNSSIvL0gJDhlVkKBcvkqF9x0eokdmxAnvEZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272384; c=relaxed/simple;
	bh=nqAYF5wVmuQsqlDaMYBXVqjzNMIgAKg+oEBJYr1yuxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICqDuyVY1UQYrtv49wd8WRb1LGBIlx1pl9eJEyEgwiuw0amUHP9UNQLsmITFNze688mwIOUy08V54V+eVouxSTyxI9stAoc2eMxipacP2eZHGQJ5Kobpk+1RDRC+2DSYyAo5cpRgyVjzV8xduSVbuDYnJuajQ4rZtSRiaX7nQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsqKPLPI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec92e355bfso9236425ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715272382; x=1715877182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd1yEer3c+rasLGQTSYbENadeYi0nH2D19RAy3R+AKg=;
        b=jsqKPLPIlIMLZLD2hLEbA2rj0N0UaAY+tmJUSPpP7xrKy4WqYvSxPkzhQlB/lgqEfR
         lGe1KBMxxlNzfmX7bElIBM1+3c/xuipKsZhwd5xAOmeNr13B+oMQTbj/0h4/GCEg2B6l
         L/C9iGnH5amWe1eT1QcA/KubqLu0yb++LgNMJVlXWxFdHYhQ85G7qPnILFbOVTQ3dU6B
         wcNx4fQr0AMC2l2egTBBGOiK88M7R1eSGHevYaRtzJa5HN9byLjmKnldLzODA8R64Mb3
         OhdvOMW5sG2KaeTEBwkL+9+MOOe3QHoasKOgASeCjogNoBedVAFENyuMsooS/cPoLngx
         RAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272382; x=1715877182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1yEer3c+rasLGQTSYbENadeYi0nH2D19RAy3R+AKg=;
        b=BT7+Zat0i5SbdjKCLLnGcz7psyuZ8ZrmL7GzmPc3skxkTiPEHerMQRQEl3vU/P5o0k
         z+yhmnHnYhMIU4RqclYxFdVJ1eCDxvEtZmRhAm3pENWiwQQQam3T3Ow+Uh1deQKuzpYq
         PKzIfHFpOjXZLciXxV4qMPJsfBnRmTVms0nrRug9/AsITpjYiM+tH2g1DTpQqG5+JnSH
         N+eUG3vC5EEbEgQpv0meFBeMGmiJBicXef8wzjwYpb7VDvdu1q8KMs4YhV1xDf61v0Bi
         IBCIzIDFcNCSWmazaWKyglZH/kBaFogJBWAeiFXrUqt6KMQ/MiRPUX4M4dAAfDzh/vGD
         4slA==
X-Forwarded-Encrypted: i=1; AJvYcCXexuUPKbQ7NhATBHAJ9XRhhcAXBQr9iotmiacmotIszMmiu9o5CIeB1+65YOhp8jjZYnU0BKTnXsBhL+0rjz77e+bcg1X77AGnm7+A
X-Gm-Message-State: AOJu0YwrlKCAeXnLj0xu66ADfOShARUqiK435MVijZAsPMvm38WlVzyc
	igBO4nfnQaHDZaO6wZcCfemfqEQyBFJBIIVOFAzMzKLCTLf1RL9X
X-Google-Smtp-Source: AGHT+IHL3RnjKR49FfcF6YhqnajThZS2hJcHHc9gMKjC4TCL2BBM1AMzJxm5tb2gVWlCj9i4tmaINw==
X-Received: by 2002:a17:903:289:b0:1e6:114c:2e54 with SMTP id d9443c01a7336-1ef44050ea8mr1441855ad.69.1715272382189;
        Thu, 09 May 2024 09:33:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm16521815ad.134.2024.05.09.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:33:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 9 May 2024 09:32:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc: jdelvare@suse.com, ninad@linux.ibm.com, eajames@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (ucd90320) Increase delay from 250 to 500us
Message-ID: <6ea76e83-f623-4bf8-9594-dc882cda6c81@roeck-us.net>
References: <20240507194603.1305750-1-lakshmiy@us.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507194603.1305750-1-lakshmiy@us.ibm.com>

On Tue, May 07, 2024 at 02:46:03PM -0500, Lakshmi Yadlapati wrote:
> Following the failure observed with a delay of 250us, experiments were
> conducted with various delays. It was found that a delay of 350us
> effectively mitigated the issue.
> 
> To provide a more optimal solution while still allowing a margin for
> stability, the delay is being adjusted to 500us.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

Why did you not send this patch to the hardware monitoring mailing list ?
Such an omission all but guarantees that it gets lost, so you should not
be surprised if that happens with your patches if you do that on a regular
basis.

I am going to apply your patch (fortunately I still had it in my inbox),
but please keep that in mind for the future if you want your patches
applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ucd9000.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index 8d9d422450e5..d817c719b90b 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -80,11 +80,11 @@ struct ucd9000_debugfs_entry {
>   * It has been observed that the UCD90320 randomly fails register access when
>   * doing another access right on the back of a register write. To mitigate this
>   * make sure that there is a minimum delay between a write access and the
> - * following access. The 250us is based on experimental data. At a delay of
> - * 200us the issue seems to go away. Add a bit of extra margin to allow for
> + * following access. The 500 is based on experimental data. At a delay of
> + * 350us the issue seems to go away. Add a bit of extra margin to allow for
>   * system to system differences.
>   */
> -#define UCD90320_WAIT_DELAY_US 250
> +#define UCD90320_WAIT_DELAY_US 500
>  
>  static inline void ucd90320_wait(const struct ucd9000_data *data)
>  {
> -- 
> 2.40.1
> 

