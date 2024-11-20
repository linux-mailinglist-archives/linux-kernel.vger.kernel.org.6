Return-Path: <linux-kernel+bounces-415653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5459D3962
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097761F210D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7501A2C0B;
	Wed, 20 Nov 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cR9MY3Gc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E41A2567
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101655; cv=none; b=JzaXm5Os+oKuHyXj2pMOCvHeaVmtfsFBjqpaYT88zxxUegXYaEV1//+H6mjgJeLofGjHqjmY/e10gEKJloGnAwl4h2jWfG8bGNy5DnDSbox3JjHXLxODD0TM3YvAPmddnwzvWRzXMP0sNoQOcEBhg+3HtwTdKS2tHNKkJ18kRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101655; c=relaxed/simple;
	bh=l7G39Ni/WM+NIaPXJqS6inv2T6BnJhhqnj0CHz9jRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGiYl1C4IJXCQ91K8UStNCPlsBgCgbn2JkWhPwN1hkzUKfgCH32rOY1zn4/YjPJwX4z5Erju00gRRPW93uGLDePKY9opqp+Vwz2qzCjAMFGI7q5f0DoqeSMegZXWb3twaHHHIRycIIa+e0rd6WnZ14KrRKdqpssriwXQOWqw2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cR9MY3Gc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so37552845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101653; x=1732706453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DH68XPkDBDr2SFdw3UbWf74PCLjCq+oTGZBI03sAE6E=;
        b=cR9MY3GcrzYw/Tbw/EPSb9VlX4nT9b8k7QKpMGBbxIkhd/doCWNuPlqjk9aYcesJsN
         lOENSJc0W6DQeWIdm+i4gibZ8/TibDCwL+NK0gIZssMr8If9CTbfg3guF5klKhTNzhle
         b6Fk4X+rAJOO+om41E+m8Jde+x9K+2QcS4QFvc2XqRGyqzc5vS5BfyGS0wJyAgkhiBxa
         vmmJPdLJq9TX6CXw9sCq13NZpAuvMXETKF2502EOrXN0WUB5NekQJR6DU2n9VYA8cSKj
         b4U3kGiaTJ3Jl4g9Qn1mjENbj6MMXsHLbwweodOF7my7SaIqHTdZmL9YAY4fQV8MIlda
         Ne4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101653; x=1732706453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH68XPkDBDr2SFdw3UbWf74PCLjCq+oTGZBI03sAE6E=;
        b=HC95J3n5wo9CMSFqnrdJipRWlSjNdYdvNWBBNen/yWBX/Ysy4yRlZt7Qpwq7y5F626
         JaFyeuwjRDpRC60/O57huIBOePus77dN1jxQHjb7gCyjZF57OBu/SblI1o6Cyp+Q/AT0
         3xP+qQyzF5lLKkARuHShQ+Un/gePAjnx36WioO1ValnLdreP0/wIEVP2tKi/O/ZXxjP2
         BmXzflPvl7xvrLmW6kGh6iHEMYFadm+NUKxrwizUczIbLxt7oPwOg1PC4X7vHjTl8PMi
         hzegksL1X2MdGqTnNdaTpxuLHnBiRueLNoGHg9r1vVMcJZzbyLAqV6fNiyJilvcnvRPh
         GlQA==
X-Forwarded-Encrypted: i=1; AJvYcCX0TVct2tZVCltmquiXO+oHbYJNKIq6E4o7s4XoJq0n7mgPu9PpABZcUfmMDjUqm1P8QQOERoj1wVzwb78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWK8KrRhVQISGrPAluJWkbpXlt08iRBc6VtWVB98CtLjXORC2y
	3g4T3FCerzqR50sIXIsu8hDNzDOqt0xOALgOMyFngaSX18TP9GD/7cruTbwGwgw=
X-Google-Smtp-Source: AGHT+IFoW0aGrY44f798dMADxQS0s2HP8FnMFtMgd/GYwO11/AYw3oJvuDLaWXWp9ideXtqi2/lvsQ==
X-Received: by 2002:a05:600c:5250:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-433489970efmr19437515e9.6.1732101652707;
        Wed, 20 Nov 2024 03:20:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea20sm1778948f8f.93.2024.11.20.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:52 -0800 (PST)
Date: Wed, 20 Nov 2024 14:20:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Perego <pperego@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: Re: [PATCH 1/1] Remove hard-coded strings by using the helper
 functions str_true_false()
Message-ID: <4c8f5e95-6d33-49bc-8af3-e6dec2dc7c62@stanley.mountain>
References: <20241120093020.6409-1-pperego@suse.de>
 <20241120093020.6409-2-pperego@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120093020.6409-2-pperego@suse.de>

On Wed, Nov 20, 2024 at 10:30:20AM +0100, Paolo Perego wrote:
> Signed-off-by: Paolo Perego <pperego@suse.de>

You need to have a subsystem prefix in the subject.  The subject is probably too
long as well.  You need to have a commit message.

Otherwise, fine.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


