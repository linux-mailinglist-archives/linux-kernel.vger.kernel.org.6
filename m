Return-Path: <linux-kernel+bounces-348602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A0498E990
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DCD286DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CC5914C;
	Thu,  3 Oct 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZbh+ngU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F645005
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935011; cv=none; b=jLcNm8p+MQpvumsOtmkDYrV2xxS5xt+rATz2yv+tF2nH5qwgVqk1DDGgg9+4x9c7uUCG5TDzxJDMzx9OhYGes7owyek3lWnOAwSUMoUi/vj+UkC7cKU/U24TNu3/CKl5HKEW8gX5ruDPMF0Tj0Lx9M6SiekcxkNtWn2sihUluQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935011; c=relaxed/simple;
	bh=kxecG4Pt5lO9TpOnoTQ4+y1DPaoeTbNUayy8b8A7uQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrPAiqLkw5/d3Xv7yMp1IlZPidPcRU9CFPxTXWyWwarLdgFcYSVw8gID+qW5QqMQcf7cE4YOMHr4lVDSMVJ3kmWLXC8BqtZzpwCy0Mxgg9N+THOiPmZfAoibwXgiUhWM1McaC0Pi+pLXhwQMDQyB7Uy25qONbfr1lPMy5vLAqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZbh+ngU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so4897145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727935008; x=1728539808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5sZr8kVTGEtzRoAeFfcsUkXeKf0SJMvytdAssiPvdw=;
        b=uZbh+ngUKuLk/+yUJN8H79Q/96LvqvLldHvTD1Rh1OqXHmBghzXgv3fSBI7TaZv4bh
         +//2VuHOfspMDReCBeBHVhffLhnNc6bZwxNjA2L1na0OSSj/nfb9HLZChNVMF+X0jvOa
         TcJcMf+Kmz60YnZT1earmRBh7mJPB7EaacFIvSSjS9bch/4mlkvXnv9WULrTbTmbYv1R
         CHXNbtcbJ/GK5ReXCzyz1lmSpQKDt87tSeq/o5Rm4s3VTLdoCrD6bN79SkvgJfn1cSTE
         WK7XhqaBtuH8ZRrFw6dmEOf4iqgP8VdvTcQn5Z7pAVYw69jRfBP+WJ/qsKreBuJxw47c
         s/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935008; x=1728539808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5sZr8kVTGEtzRoAeFfcsUkXeKf0SJMvytdAssiPvdw=;
        b=agm+yCh4khcuWfbi9CxYUKYiCtme8y6xxusrSSP3HTR0p6MRQzwzfQ+HpOkFa1axHc
         Sfyb60EOy9rhGGZ6wxc5HXA2bwDYBhBGOyBGOoMMGcJB8duPuzgiu5qyCpxR80uDB7kq
         FrlmaYDGG3vlcNFIjkHcJ96/Rvjyq1YZv+FlAfN7YUTk3CP+erobIO7/Z6kv9m4U1r4L
         r07wDxO9FUzAZ473qRYe0F1ubifjteUmJUS1bEtOLDTFryzLtCYXbUsX6eutS6y46F4f
         aWzF7FKNw4eOI+jL4ER+OwmRT9lDruXCI/Lt4ZU4WVog3mUstBizMmUUVlwTlOfj9h7y
         TI5w==
X-Forwarded-Encrypted: i=1; AJvYcCWtQmSDoaf+Tb1yAO4LxepajL3J/947RD6AQSXD8YQMO8TVeJrZzxjMTMm0HQxC8ixSWwOX64IQw2yHa4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y4G6CgxrYrA32uv8AaIiHn4w0gZh3VKPeBD5fv8OPp+Lj6nd
	22MtHNaWStdAaQBh8rkqhIcRgb0RKwwgiCUvpe5Mfn8E0Tnl3qHV8diA0q9E/W8=
X-Google-Smtp-Source: AGHT+IEAQ7vgs1gj+ETBdYfXrCS6c1Fp2NHSUwSlmfV2FP/70trlY9ue+6G9YkrG20AA5sv1yjYHMg==
X-Received: by 2002:a05:600c:358f:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-42f777b99b0mr41468065e9.10.1727935007902;
        Wed, 02 Oct 2024 22:56:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02eaccsm35231745e9.42.2024.10.02.22.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:56:47 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:56:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
	Jani Nikula <jani.nikula@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
Message-ID: <34233c4c-1f61-4bc6-aeca-9f5faba8509e@stanley.mountain>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
 <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>

First of all, the change is wrong.  We can't dereference "prop" after calling
of_node_put().  You have to be a bit extra careful reviewing Markus's patches
because a lot of the rest of us have blocked these messages so you're on your
own in that way.

On Wed, Oct 02, 2024 at 10:43:46PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/10/2024 à 22:02, Markus Elfring a écrit :
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 2 Oct 2024 21:50:27 +0200
> > 
> > An of_node_put(bk_node) call was immediately used after a pointer check
> > for an of_get_property() call in this function implementation.
> > Thus call such a function only once instead directly before the check.
> 
> It seems pointless to perform a put immediately after a get. Shouldn't
> of_find_property() be used instead ? And then of_property_read_string()
> would probably be better.
> 
> Maybe you can even use of_property_match_string().

The of_get_property() function doesn't do a get as in get/put, it just finds
the property and returns it.  It doesn't bump the reference count.  It's a
confusing name in that way.  The The of_node_put() pairs with
of_find_node_by_name().

regards,
dan carpenter


