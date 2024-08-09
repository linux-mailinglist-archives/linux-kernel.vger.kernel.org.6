Return-Path: <linux-kernel+bounces-281093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1400194D2FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8261F21F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC9197A9F;
	Fri,  9 Aug 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dumN3CSD"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB98197A82
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216279; cv=none; b=P0InTAjVlR4jtGtKrmM0XC7WEeHvyE0//0Dx+QraD48jlTGsE/HVNCqVIATDBLAyrP+4VVklwD+VbUoANNNzQvNYMNXZmX3bWVDMS1qiAfYSGnRBCnpyBsgRa/WyariIpdd7Q2hbnc2CpxfDMlmt1splIPntlwlsdcvM1Kc3lRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216279; c=relaxed/simple;
	bh=7qv5/5ztgjnBd8ABlrZklhWeB1+KbwrFTx+b/38oBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqdCmFqp1n2bbdOgGbJl/UmoSD2OC5vIQfP6MRO/8MC7USm7TuB9bOP+8BuUSUSk7qg2hjbOxe02dTmiqqMCGL09E+4b+t5gvEZdse7yMNb1sWj5PwH0xCD1hvWO8UxLkHFRR+dIXWirdZlTGq7omlaN5hJQU3f/tTzoxuHdIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dumN3CSD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so2843577a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723216276; x=1723821076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCnFjP8yeSTbgg04jO70aNmUrU3V0BlhkT72Qsh0eiU=;
        b=dumN3CSDg61IqILdGhI6uKDjeqWFaLYRztBAdAEylQiCpRw1EcT6viaBp6jKfpdM02
         NgHICBOHKDfikhPodtVd1qTDR7LCTUqBF3ah/YsBqRxLKXW7aUQbPxcs709ZYexdu0ae
         kzmxm6qNecQMCZZHq9J6vbJFSvxF1IwYPEKQ+i8QXVc8U9sxqh0ueyfnTFhRbn2byohl
         5xhIYLB7xsjdsgIn6I6DmvDHVLT5f6YG62m8imQYyZnXu8piG3tvRZWbod6cLdN8B9+y
         ba4SkJkxztKZZlqEdtd7UOiXuN5z0e38XK8XD7+TjpGKQjOKgW5pA+zDp8mibVTwQif7
         oftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216276; x=1723821076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCnFjP8yeSTbgg04jO70aNmUrU3V0BlhkT72Qsh0eiU=;
        b=RGJOGrVkQ3YTieNSvBtH6CYGBorin2bXl6FKz6RiK4vYmCBwDtxMUQfojm2JL+7522
         g4/LbW9xOEQKVC15vRyxsFBFmeNlUTMj3l8kdKorDCimEupQHnCSQwxn0Dh/O/hfS1dN
         Vh2wkn6yvs58sIe4ibUiFiYZf8jyPmrj4fLr89/fJ8aRA5xaKGse0UZmPLl2DFqDRrbu
         epKjVMzHBiqKRii0ZhjKs6x8GOF03oQKRsBbcgi9IaFgR3hdWQtesBVfFnuyYIlYOooN
         WsyTPzZzq6PsoRwGHE/Sw88IeKS+l+d+B2EaMXhD4aDMSZEaIRa8XazaN8Up6X+j01jS
         lM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+vJGn8BWc/UuV1JpLvdTw4KXsVmMyaOvOzt0rWwDcQ5lJ+D2nfCfItslcyJ2H+tsIlJYvzsX1ZxWc91RFMzc7VFKwCKTw7mgqWmRD
X-Gm-Message-State: AOJu0YyNjknNqAwrt71BhxU2/3H6sVjS1rO0zHpiBLYrso4vv5WyqzBc
	gd1F7z90RTI4vR1c6V2C6VC1kRNFgcAxS1TFG61Lf5u6DER5ox/riaxocDR3Fa0=
X-Google-Smtp-Source: AGHT+IHM6/NyJG0fypeFEFHE1MSoC6qNiWwYqrml/FzF4jdvuVfqudW3tenaS4EdJbwoBirlwLdtnA==
X-Received: by 2002:a05:6402:348b:b0:5a2:4d19:4c08 with SMTP id 4fb4d7f45d1cf-5bd0a58a137mr1382401a12.11.1723216275896;
        Fri, 09 Aug 2024 08:11:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1dbe4sm1590031a12.27.2024.08.09.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:11:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:11:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>, David Howells <dhowells@redhat.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smb/client: avoid possible NULL dereference in
 cifs_free_subrequest()
Message-ID: <a08c6b03-6d23-4711-a891-14b0250b90be@stanley.mountain>
References: <20240808122331.342473-1-suhui@nfschina.com>
 <893f2ebb-2979-4e34-bdab-a7cbb0c7e7b8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893f2ebb-2979-4e34-bdab-a7cbb0c7e7b8@stanley.mountain>

On Fri, Aug 09, 2024 at 06:00:26PM +0300, Dan Carpenter wrote:
> On Thu, Aug 08, 2024 at 08:23:32PM +0800, Su Hui wrote:
> > Clang static checker (scan-build) warning:
> > 	cifsglob.h:line 890, column 3
> > 	Access to field 'ops' results in a dereference of a null pointer.
> > 
> > Commit 519be989717c ("cifs: Add a tracepoint to track credits involved in
> > R/W requests") adds a check for 'rdata->server', and let clang throw this
> > warning about NULL dereference.
> > 
> > When 'rdata->credits.value != 0 && rdata->server == NULL' happens,
> > add_credits_and_wake_if() will call rdata->server->ops->add_credits().
> > This will cause NULL dereference problem. Add a check for 'rdata->server'
> > to avoid NULL dereference.
> > 
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Needs a Fixes tag.
> 
> Also when you add a Fixes tag, then get_maintainer will add the David Howells
> automatically.  I've added him manually.
> 

Actually, David should have been CC'd but the fixes tag wouldn't have pointed
to his patch.

This is an inconsistent NULL checking warning.  It's not clear to me if the NULL
checks should be removed or more added.  If David were trying to fix a NULL
pointer dereference and accidentally left one unchecked dereference out then the
Fixes tag would point to his patch.  Since David was doing something unrelated
then we don't point to his patch.  Instead it would point to the first patch to
introduce the dereference.

regards,
dan carpenter


