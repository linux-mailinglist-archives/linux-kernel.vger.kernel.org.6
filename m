Return-Path: <linux-kernel+bounces-297054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CDF95B25E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A5A1F247A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B17179206;
	Thu, 22 Aug 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HITlbrzo"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A77E0E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320357; cv=none; b=WYlRyrsfP9gOhh1to63wgJDrMGnFJMEkS2cmppPFSHZtT6BZMVyf5Y2zbPsnF9TG7sCfKaFtkMOMElOBxIKEJ+wfnAIqE9QbMR9x5a6bMWZAa8JmQ5CVhW9RJ0Z2+5uNPFf+qNNqSaGwdD2or280YDqDo3GIrttbjwPw2dOsm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320357; c=relaxed/simple;
	bh=YQDoeRsr6q+u3voHfHxdWEDewqv24NSCdzIjQnnVtEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOHD+OKO3mC4UP9BTc2ysdibi8rz6RgNobryOgA5944VJavSbEC5/uBZEG5aH0lVqiLg1aidDBLzhCSA/c9p1CL0VoU5j2cf1OzBQTJdg5NgH4JZ7U7wUiPx9M/iaYLs3HvlsAO9S2ytOtwqWEmxKHGTf4M2yxjvcjmyvLazH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HITlbrzo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53349ee42a9so781952e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724320354; x=1724925154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ioDL8+VV11S+Jkj2FT4N18seewzyeREKSup0+frDKw=;
        b=HITlbrzoSM79DTmFlA+UZ5+lKMsZu7F3jDajilDVrekGJIzNLl2iKdyZS0eVXQ4w1K
         puXac/jLh3GllCR3+dWwsnnhxTdXvK4gvD+/0LERm9LWmCDRrLx3oCk5y2OLnzU/bbgB
         dZlkXTKoF/E0SjauCNL8xyJdp3FQmscCFIN1JOM0EHIRtRf1HhiggujY9IWykqAlBmYl
         bEPO+yOYv6EhpImV9FVfC6g4/SYn2YpX11774iC0qtSrfSbp5FzfeKELD0MXDi9E2Mog
         rRZ/YkUnKGHn33NlY44mylMaRB5C/6W8YOAuvMfgH+74dCEjV/jItfyvOZQ9QX6CzQxp
         azPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320354; x=1724925154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ioDL8+VV11S+Jkj2FT4N18seewzyeREKSup0+frDKw=;
        b=h2ee1+snjWd1ZkVGmwA39ELADfGhgd3GZ/HM6qPrIZgL6zidu61UavgDhIR9RknxYR
         wIrl5mnCzP2RiK4Y5H8Ii3apJzvWAL5ItzAYYwWpXmongCvvkBGfN8aNSLfwUsOxP3Uq
         I7yN9nuKSOnWPm7D88forkG9GmE/5DsBLHSjxqtf/mgmaqobK3v9iG0OmnU8KkiKGFuu
         1cnXzaVtUejmZlBqyB1R0AOzAgeiy/j7XeACHMnHMH8UeyGoTxjOFUbyOMqk0qk1R59M
         O8q0DG9d1F14mW8lB5DJcIvNovQakDNLBrYhTk6xMXhV2j4GwioxgUDEA+UIQfA5p8ak
         HD4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzwo6yRxEpSAy4i8f/ajsEvlYPiMvhWmc4S/cgcmtcNgyi4YVRnRACtOsKAdNwPXVK0sId92TW+GgMz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzRSsgFN0w5aUQYnou4ul0PCz2dL6tjGw9nLOOWsNc9FqkJa1
	N6DScrHM7kwGxTHS7Ftw5vXUPBATj6ANJBs+QmV7enPDY4ODPbdkga/MId5H7tuMs0Sw2ngDgPT
	R
X-Google-Smtp-Source: AGHT+IE6AR0cXAnZyVzfNmM6b2iJejrQlthgszJ9kbrDjazQQ+yfrh4+RvUHZrPu2x1o2MjsO6mC/w==
X-Received: by 2002:a05:6512:114d:b0:52e:9ab9:da14 with SMTP id 2adb3069b0e04-53348575002mr3203521e87.31.1724320353542;
        Thu, 22 Aug 2024 02:52:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ead33sm700430a12.47.2024.08.22.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:52:32 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:52:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: gregkh@linuxfoundation.org, soumya.negi97@gmail.com,
	piroyangg@gmail.com, andi.shyti@linux.intel.com,
	alexondunkan@gmail.com, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] driver:staging:vme:Remove NULL check of list_entry()
Message-ID: <3e6423eb-0845-4ab2-8d92-86da2c814569@stanley.mountain>
References: <20240822025736.1208339-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822025736.1208339-1-liyuesong@vivo.com>

I think Greg may have already merged your commit, which I'm okay with
because so far as I can see it's fine.  But there should normally be
some additional analysis for this type of patch.

On Thu, Aug 22, 2024 at 10:57:36AM +0800, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.
> 

This is true.  But the other possibility here is that it could be that
list_entry_or_null() was intended.

In other words, sure, this patch doesn't introduce new crashing bugs, but it
might going against the work that static checker developers do to find risky
code.

The first thing I would do would be to see which commit introduced this.
git log -p --follow drivers/staging/vme_user/vme.c
This issue was introduced in 2009.  Probably if the code has been this way for
15 years and no one has complained then it's fine to remove the NULL check.

To be honest, that's probably all the analysis you need.  :P  I did a little bit
more analysis using Smatch.  These are the places where Smatch says that
->entry is set.  You'd have to build the cross function database using
~/smatch/smatch_scripts/build_kernel_data.sh and then run
`smatch/smatch_data/db/smdb.py where vme_resource entry`.

drivers/staging/vme_user/vme_user.c | vme_user_probe                 | (struct vme_resource)->entry | min-max
drivers/staging/vme_user/vme_user.c | vme_user_remove                | (struct vme_resource)->entry | min-max
drivers/staging/vme_user/vme.c | vme_slave_request              | (struct vme_resource)->entry | 0-u64max
drivers/staging/vme_user/vme.c | vme_slave_free                 | (struct vme_resource)->entry | min-max
drivers/staging/vme_user/vme.c | vme_master_request             | (struct vme_resource)->entry | 0-u64max
drivers/staging/vme_user/vme.c | vme_master_free                | (struct vme_resource)->entry | min-max
drivers/staging/vme_user/vme.c | vme_dma_request                | (struct vme_resource)->entry | 0-u64max
drivers/staging/vme_user/vme.c | vme_dma_free                   | (struct vme_resource)->entry | min-max
drivers/staging/vme_user/vme.c | vme_lm_request                 | (struct vme_resource)->entry | 0-u64max
drivers/staging/vme_user/vme.c | vme_lm_free                    | (struct vme_resource)->entry | min-max

When you look at the code, ->entry gets pointed to an entry in the list in the
request function and never modified again.

Which is slightly weird.  In other words, struct vme_resource)->entry is not
used as a list at all so far as I can see.  It's unclear to me what's going on
with vme, but I suspect we're going to remove it.  See 35ba63b8f6d0 ("vme: move
back to staging").  Otherwise the temptation would be to ask that we set a
pointer directly to slave_image and master_image instead of saving a pointer to
entry.

regards,
dan carpenter



