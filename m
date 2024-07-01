Return-Path: <linux-kernel+bounces-236646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDA91E54F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390DE1F239D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5216D9AB;
	Mon,  1 Jul 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXgmAbXK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB515F3E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851246; cv=none; b=Fu+aFbEN06T1BdqUM7ON1nEaL/GQ6/MevoeP+tnmj5e9Et9zclR5jonPKiac4C07frehr0rlL480+3O3QmDT4F/uwlqH3y/WmoIDhUhglhphDZvSh8X9lH37gdjSFZJIseck8IK/xv2nOkSWI7RQzE8Ekwjji8kKw0ztSBqPe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851246; c=relaxed/simple;
	bh=F/0fyD3tuLE75kbEOFk9w0FuDMPGWs+Q66+UszKetXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COSP9wJRKy0WBdJfZki21Z1wMlzRAVRgFa3jllvAH7z4Ef+8exVUjYNXZbGkuG3vw97LZVHvl88gcePh1HPnOfu7QS+5jQmrTbwFi8bTRUOgccBDChLO1uWWp+rE9/F54/QJdMEzkdRKk79LBi4PaEOZYBme5HvCfQOC+K1slQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXgmAbXK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9aeb96b93so21681115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851244; x=1720456044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7UBY+UV1dqUs886cQefaoyGAbVXuttEZvsE7IUx80NA=;
        b=QXgmAbXKDcriOnt0SWZQTWoQO8yFZ7p28URMAr7VB0GLz3pnAtUspOsQzEfHkIeY3l
         1M8WNUxz/Bb7W5m6SVrl+Jkn5Q7Zevjayk3zWEn95ddB5WuDb900I5f8rkW6nMfXdOw6
         mUWacWMjwopEXl7SY7u+DvEULF1bBwvtlfYF7YrBfUjA5CYsv+PMmzIaAUm6uLOLeypm
         Ao8qJuvI4moX90t20kx9Frw9iOinegs5zvTc/uBxrIPy+8mhvZgj6KtI1QDQ2vuXr6aB
         iDom2ueesjvgoUQ51AmXii7i5IVYeyPpRtsXTtPqtrhUCIO1yjX/zIsCSu+SKasrQNQJ
         iehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851244; x=1720456044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UBY+UV1dqUs886cQefaoyGAbVXuttEZvsE7IUx80NA=;
        b=e/wjCIBjCxqFQeB8VZ2O/PmtBq6zXP4mXh8gxkdrORl3fCsBvr+uwhtLcC6FhLU04t
         NgTJNsqvCkN/uNe6WWiqybiE4DkqP0aw0GBIqPGkdB+IP5rP8hKn6xcwQUtdJTOWSSJj
         o3CDl1UMqymuQ5vJF9aTcNAoKiW0ILPGk7DJ62WT/8cPgnrCel/YsKQLnc+3ni92lAG7
         MDtrIiNxfJWqrFra7Pw/6HCVkgx6ddS6v1XjBa2iLYVAzUmWWpM+ND/fvkvCkKVl5C3s
         i1ffGfCpnzcq36KOqH0i3tN90adhRhorznDmz4sUrtxO9RFK/dgOaXqXx6/gBaqwZ3Zg
         Kbag==
X-Forwarded-Encrypted: i=1; AJvYcCWtHYtthuZOPwwd54AcZAteC0TC8O+5UiFc//KWxsniaS7RgdUJREST1fx4zMATLApCM+A3W8TiaRzC/I6Qw45EkYHim2dhD6ZWjixP
X-Gm-Message-State: AOJu0YwOtg6912sZ0kNK3E9A1vEAoen4cbrapr43rABcu1KAnNvFKmx2
	80802N/obx452IPgdP66N/clV1johFUCYXMy9lETFucK0ygwbTbHSpAoPUtFSA==
X-Google-Smtp-Source: AGHT+IFQozfWAuNmYJp3g/hIlVwVj9JRmtZA00eZM1uMI3eaJG4lXuB+faND7zWMLiQpbH3R8hTCUg==
X-Received: by 2002:a17:902:eb83:b0:1f8:46c9:c96f with SMTP id d9443c01a7336-1fadbd02087mr46513535ad.61.1719851242883;
        Mon, 01 Jul 2024 09:27:22 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c57sm66855885ad.53.2024.07.01.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:27:21 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:57:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Slark Xiao <slark_xiao@163.com>, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] bus: mhi: host: Add name for mhi_controller
Message-ID: <20240701162715.GD133366@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
 <20240701021216.17734-2-slark_xiao@163.com>
 <36b8cdab-28d5-451f-8ca3-7c9c8b02b5b2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36b8cdab-28d5-451f-8ca3-7c9c8b02b5b2@quicinc.com>

On Mon, Jul 01, 2024 at 09:13:50AM -0600, Jeffrey Hugo wrote:
> On 6/30/2024 8:12 PM, Slark Xiao wrote:
> > For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> > This would lead to device can't ping outside successfully.
> > Also MBIM side would report "bad packet session (112)".In order to
> > fix this issue, we decide to use the device name of MHI controller
> > to do a match in client driver side. Then client driver could set
> > a corresponding mux_id value for this MHI product.
> > 
> > Signed-off-by: Slark Xiao <slark_xiao@163.com>
> > +++ b/include/linux/mhi.h
> > @@ -289,6 +289,7 @@ struct mhi_controller_config {
> >   };
> >   /**
> > + * @name: device name of the MHI controller
> 
> This needs to be below the next line
> 

If this is the only comment of the whole series, I will fix it up while
applying. Otherwise, fix it while sending next revision.

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> >    * struct mhi_controller - Master MHI controller structure
> >    * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
> >    *            controller (required)
> > @@ -367,6 +368,7 @@ struct mhi_controller_config {
> >    * they can be populated depending on the usecase.
> >    */
> >   struct mhi_controller {
> > +	const char *name;
> >   	struct device *cntrl_dev;
> >   	struct mhi_device *mhi_dev;
> >   	struct dentry *debugfs_dentry;
> 

-- 
மணிவண்ணன் சதாசிவம்

