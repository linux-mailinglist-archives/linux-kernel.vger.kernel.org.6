Return-Path: <linux-kernel+bounces-242398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02BD92878A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047D21C22473
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF594149C52;
	Fri,  5 Jul 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swy+LiKK"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8B144D3A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177930; cv=none; b=KeOOQXt7FI9qfpW0B/+2+jGLPvyIboQvabzzm99GkfoIXCAfLAaXLYxkjKXR8hKQtEGlwwDUHkVbRzGR3aN3VaMjK8NazyTGCgIoZnKop3SxAji2hPmKX0iNN0604hrAHP9SokkKDg7vn3IVUXDGvhloLKtrsHlL/Ap/6XpO8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177930; c=relaxed/simple;
	bh=JbUDiOuVUAg+M/MZxnGjL1kk/CHUo27nL310DisMGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBt6aL8cV7CJHfSLI0Kf8zC6RAF0qYj7C66y+lAN5DylO+obl+VuADSqXOvuFSpA9URhdocyEG2rivG9pmKKknO8TXF0jmSUwO81AEHmIMPVHxR+PxYfu3Ba97SPpiV7S+dnvQ0pezvKm/i0WW8EAzfJ6SNzpKDJkESgDgcOqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swy+LiKK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-710437d0affso918753a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720177928; x=1720782728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kedp5pEchF6jn5ZJLNyxEV3NfW0tGv6Nmb7MddPZUNo=;
        b=Swy+LiKKNzEeGLHVK6GWFVoPkBZE+tA5js9Mh3mbsIfmQiz0BrZUX4GcA5dwo1+RyM
         Re+SiO4TLA6vSx6YdiDEOJwAxLtZhOuySYhd1W6ofz9L92EDMT4z+DSLd0uDw0KhwXGE
         whIDffaTvA5kgHb7Izof6SB/kO/EHrbKl6jvfk+fjcEWQhFKKVph64IRCjMklDSf8tsX
         YVX9v61EtYYzKaPhu7idB3MrCde/OvOXAB9T5+ff6ARG7UoMrwQA2kyEP8rAxVoGz0vI
         KKX1gL8bKWmFIozg7qQymSndGvR478up4fcLWvZrdo0VQ2AEOwuWn0ozgCBPGwkgtEe2
         +4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177928; x=1720782728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kedp5pEchF6jn5ZJLNyxEV3NfW0tGv6Nmb7MddPZUNo=;
        b=jJUfkiy8129EF6oJgC8sp5LBXekPAk+RUw+jBmTT8H7Y1lhbvSCTY0VmiX30I4vNPU
         peH/2cHxuMZTVi1d1Hx/eH5fApxL/bzRZh67vbJaQxuzJ8J/jYn0bqO4eYq3uPSN0AGx
         5hDizWnXSgm0fCuNKRCcvWI1MVFqCiBCQXUwsByJCMgviM6ZEQe4TnjUxpXPaNPEcpLo
         xaVi9QXHcB4ytXSmr0GfokOcTpX4qnHYdvoDYReNiEP3mcGpe0A7rql24r43JkJEwVBF
         05t9HxLzXDwioXCpZTEB2Nrde4Zh24PQdomxlkGCsI8t3LncEKtdEWNxWXv3SfrRcPX2
         hZyg==
X-Forwarded-Encrypted: i=1; AJvYcCW7n+m/Mo/FVWisvKFfEp2jMYjKShao2ZiFaBg06ihClJQskiF26556D/A97n9Z8aNnByOl9/NFczRNQpHU2c/8JiQprT9Y0biWk2mw
X-Gm-Message-State: AOJu0YyCOhdnboAeYqe4FKMVxuwwbPdn4HyqC+GDPoaDN7KEQlFCmigc
	01ejwHJ3L9w2dwnKz2sHWhpjoLIjJIZx0zYecuRQ8FY+6elCjMRO
X-Google-Smtp-Source: AGHT+IH8Rr51cNn4PUmIUuEywbXk4qRu7nqR1De6CpR9xz7j9diozlUfO0bdN6i6ZKNQSjXIAKALKg==
X-Received: by 2002:a05:6a21:6d98:b0:1be:cc74:5818 with SMTP id adf61e73a8af0-1c0cc73adcamr4221809637.12.1720177928014;
        Fri, 05 Jul 2024 04:12:08 -0700 (PDT)
Received: from five231003 ([2405:201:c006:312d:e14f:e5d:8437:cf1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a989405sm3132132a91.27.2024.07.05.04.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:12:07 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:41:20 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] soc: ti: pm33xx: do device_node auto cleanup
Message-ID: <ZofU2ABYrB9Q0ZyR@five231003>
References: <20240703065710.13786-1-five231003@gmail.com>
 <20240703065710.13786-4-five231003@gmail.com>
 <20240705115413.0000307d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705115413.0000307d@Huawei.com>

Hi Jonathan,

On Fri, Jul 05, 2024 at 11:54:13AM +0100, Jonathan Cameron wrote:
> On Wed,  3 Jul 2024 12:25:28 +0530
> Kousik Sanagavarapu <five231003@gmail.com> wrote:
> 
> > Use scope based cleanup instead of manual of_node_put() calls, hence
> > simplifying the handling of error paths.
> > 
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> I think you can make use of dev_err_probe() in here to
> further simplify things (a bit anyway!)

The changes proposed on all the patches make sense.  I'll send out v3
soon.

I hadn't caught the dev_err_probe() change in this patch ;) while
preparing this series.  I'll make the changes.

Thanks for the review

