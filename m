Return-Path: <linux-kernel+bounces-538007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F55A49375
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BD3AA29B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EB248863;
	Fri, 28 Feb 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfQFEOxO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B361EEA5F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731270; cv=none; b=kc77Wj1RCK4u0TvXwAFcV0hLs3W6OED2pi1vw+7papHUsIvbPmGW0ez8gHjuCwNI0s09DqX0RK957fpH8D3d5M+kfSjJuUSd9SZ3eIYw/DU8wXDYaiTT8RENHGf2MN1FdzNk5Dequmkm7HjhfO/k7yzoke9vuJRzCFFpnFFpkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731270; c=relaxed/simple;
	bh=1EJkEJ5clKWWBKa67/kejH6W7shjdDPibbwwvGn5zB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hblbvNe6iO9DzSxARMfqLfGvwa61uLXMcc9vkVXB6xTWy/ROwK2sLOzoZUX2tavXbqMTWCwcAWxFiuRVbYwNjqLajT/FJN6teOyOextfSYbP8nNF0w/iA/IUv+fg5YL2AwidvaQ4b3uOFlTOVMPZbNqeXMG3Im4cCS9ATzWsPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfQFEOxO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22334203781so44068105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731269; x=1741336069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/YCY4QhV0U17HVcIuIR7hymAR0CmjWSHDk8xrbOfkY=;
        b=sfQFEOxOiNrVI3ZfsONwXk1AAuT4gSFnaKlb/wFnUrrXY/OWxmA52fwQJPEUpYqSrI
         m7RGcLgDk4jGqDP/aHz5nNMHzGTDrCS7yDWuJPKGfS4qMFJUbdGCYHbns3S9TyPmLIvG
         2ga1KqRHNouihCEtPhnTjWelERq9QlIhzeSxWACjSmsjrkisIg6blZUrVKY1CaUyuklT
         bQ7ZNTeCNcsUcdU7xbyIakBnvCZJfiGMveEtn+/OPvME6R5JEuXKhPNLHcO/GDgJfU2p
         pHUo2fsyH9TS3Zd1NKOHhhfmrXaSOsAdmxwTX7AOeLKwKwppp2TTOqFo//Y9IntdREvx
         wCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731269; x=1741336069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/YCY4QhV0U17HVcIuIR7hymAR0CmjWSHDk8xrbOfkY=;
        b=iWzDisHBmSg2Qbs7CsJmC4S0v2VV/pmZo8NJ+g2PuhAtlY8KSeJ6pjkDEzwR8CTKRy
         4cRmXo302a6XZnN5z6+bNaBsNYR4i1cwS6omDWXjLxKBr78DXAJhHgwVu5+M2i1YCdOF
         4RcqYxnWhCbJayamakz+ux6D2Sp4k0oPT5PaDcnzdrRYZ7a5oU4c3Yuuje+ijnedfbHS
         9aGCCWFy/i9LKeOow3kcNKh036MXSCouxy5Eq6Mp99xCQrkun4pxRDc/5rtSJLzTGnTm
         9pSLM2y3FQ6qF618JS9hxieSyrizMI/C3DznI6eOY5+jzVRgOE4cNyZnh9NKdxaWPdAN
         0G5A==
X-Forwarded-Encrypted: i=1; AJvYcCUNHBDOrpcxwVJSX+Ju24AU3Snbp3nZSWXVAmsn7I7K9b8wYEMMlN+1CC0CWZo2y0OGczeaitZzhnk5qFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAI4F4zX0h/P3uC+gvPrnhyE6l4OxXzD9RClSJk9W6em6pbVm
	TbcHFj7HmZS+oUrkMy3KKU3K+S/yxp9UdDfltRoc8a+VwSwxWWdZAYKQAUeWLrA=
X-Gm-Gg: ASbGncvMadAKgVtNto/FpBPlhfgJO2Z2nfGb14Hjdxp6LODDrFG9fYwdA1lM0BNW35Z
	x+qwg6lQHViyrjXksDBQjCBVkUJr2qplHT9FqXwsSRObvo+hwC01wLzs5EKrelpIg6OW4cKfKcj
	5T/C0nLNNDLUZVlmmpejC5qwsWEABHjfp/8UlySzNhpb3ssRAH6tuAvUnHVl1HdyrhpCHEwYip0
	F5m0+Ji0Jh+NXDwHpgr7Hq88DzjW7LnaCeD2p8CZ7eVmOeSNmY7k5E8mxG3XPips+SGIObreFKk
	MNb2/nm3bHf0m/MDToJFKl2Vms0=
X-Google-Smtp-Source: AGHT+IHGr47Db6l2St+90Kkhqacb9ZEZ96TNwAIVftc00apKFnyCA1On0wbzyLHpd8HB2mYA3zvL7w==
X-Received: by 2002:a05:6a00:22c5:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7349d2f51cbmr10238365b3a.9.1740731268633;
        Fri, 28 Feb 2025 00:27:48 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005fd15sm3149453b3a.168.2025.02.28.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:27:48 -0800 (PST)
Date: Fri, 28 Feb 2025 13:57:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
Message-ID: <20250228082745.rc2u5jiqnq7h737l@vireshk-i7>
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
 <Z4osWNCUfufciZNG@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4osWNCUfufciZNG@bogus>

On 17-01-25, 10:09, Sudeep Holla wrote:
> On Fri, Jan 17, 2025 at 03:35:52PM +0530, Viresh Kumar wrote:
> > Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
> > lead to following warning:
> > 
> > WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124
> >
> 
> Looks good, will add to my queue after next -rc1.

Ping.

-- 
viresh

