Return-Path: <linux-kernel+bounces-275015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FF947F92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059241F23583
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC015B57B;
	Mon,  5 Aug 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cInXa4Jv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322450269
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876505; cv=none; b=OwegI9uvAWFLRfnAudrwf457fkbPy951GYhn5LHFuQ/Lmtt/0piOavbyBxQVSLwL4S8V9BzCQ/wr6qblbwDfnfodjTfmz5sEs4wDuleSsDcwokGdMvP2bCmLb1ny7xMI/f2XVRIEHNE+hKje/SJOsQlf0oGyFWSmjH9V5HWI23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876505; c=relaxed/simple;
	bh=6xvQHK9uFnVoZqn3M7MT99hO3bnPBPugpNXbC16QlUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9HxluQ451m6RcYaK77DVtJSO42viQjs2S/U82JEEZmq/nufdeLZD2gqJY/kvsRZefuOWH0ehvTy2AlA1tS5Oki8K8pWqBisPqHJMCnMK79s2Di1k3fqJnp1XmnMHLSkwkrWY/7yzmH+csyYzB0xyVbP5TR+gvmzlLo6Oiwwxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cInXa4Jv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 720B63FB61
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722876496;
	bh=lsWqZM+mvDkH2telu0ng16sF/VojAFP1XTmTZTkJd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=cInXa4JvgRB3CpJTKMmhrf0fVaegZYOuDFtdG9SjWDOu/d//DY8DDrK0RDXwv/FQK
	 6ljDj5oqvShKdM3U+9BFWJCnYUJVuO4fT8fLMLE4+ZXcwfKvECtq9vMlbrrn5TDB+k
	 VMQThBasZvI+Eptv2EvjsvnQD0dBZABA/RW34XNCh07a2WduawfUrdeawzMmDmxTuH
	 Z/4ZP3o7umqXR00IcmdoXUJxXOSZ5RITVCGx4Sf2jTwD74DEj/DAeX6UOkCgxp2j/8
	 gAGozCWXAKM83xAN/qs+dLESGIIMFQDdmFYIKURhbNxY+1u11cZPwLJYTc6rAKZwBC
	 twEX9aPH4dtEA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280f233115so72447325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876495; x=1723481295;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsWqZM+mvDkH2telu0ng16sF/VojAFP1XTmTZTkJd9s=;
        b=luE20WHHqUXl/btV9kJpQlp9ly3PTAD5TZy4JHvhfOzHK+QusrGbNBgQOy6+E0gi9q
         yOudIqfFFWzqM8FotL/czF7lu/BW2FDIiXgUBFxlrU4hZnI9Wa1qV3J06eAD0KIx2Uqu
         twaPCt0WCy1ObVgR8RtlyOgpiQzyZ5qvOov02+Q3pxpzGaDXn+LOTgfWg9WHq/qyLsv6
         cNE/gRS8FC0Zi7wrKWX4GCs1bfyCOKge91tyC8El/bS24q+TggWbWP95FQSGB+yh1OgD
         xgKrvJZPxPv8Ual/ivQTmfPkprZs4x/2K6QAKNLz8dGVfuxbylhF34EJvRoPrj6DHlFB
         u2aA==
X-Forwarded-Encrypted: i=1; AJvYcCWmEGtN3rSK2/t56VUUqPl2NxNhDxT3RAeCx1c+E9Iy190MbQIiOiI8NNec8BVyzpo3z7Xr2bkCbpWNptE7aamIKUjIZDDt85eBubSQ
X-Gm-Message-State: AOJu0YxEYpV+br5ecI1BcyQl3uVTbBDCkedotEKIP2CgnPbLMJEwTIeZ
	v7xB22bKXYKgfIf+0iUR3plCFCLgnXQy0kw7JDDi1A7LfbXk7oRgyqT8Gs8PmQ7g9AmSE2+aSzL
	610VMd4EODl0N05u5MZZIhKRbSPQk7r0XhkcETkfgHPZX/DKWcY9evdFxAusChs4y4nBkxRnyJn
	ogzEHHCPr02mpL
X-Received: by 2002:a05:600c:350c:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-428e6f866acmr82716965e9.6.1722876495584;
        Mon, 05 Aug 2024 09:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwyurpoHXzU+GDhWQxTG4p/OqzUTXn/t/qqurAm0N83gLZWJlWU39m2I0uRdbnbzdfNnxq8g==
X-Received: by 2002:a05:600c:350c:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-428e6f866acmr82716705e9.6.1722876495079;
        Mon, 05 Aug 2024 09:48:15 -0700 (PDT)
Received: from localhost ([82.222.122.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ada7esm208487675e9.15.2024.08.05.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:48:14 -0700 (PDT)
Date: Mon, 5 Aug 2024 19:48:13 +0300
From: Cengiz Can <cengiz.can@canonical.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, security@ubuntu.com
Subject: Re: CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling
Message-ID: <otjby7on74mc3sx56xynqdnce2d2jmql57jvrgp6wvbo2knqbc@tm3udmcrp7gn>
References: <2024041034-CVE-2021-47188-092a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024041034-CVE-2021-47188-092a@gregkh>
User-Agent: NeoMutt/20231103

Hello,

I'm trying to figure out the security impact here:

> That warning is triggered by the following statement:
> 
> 	WARN_ON(lrbp->cmd);

This is just a fix to silence a warning. How is this worthy of a CVE? What was
the criteria here?

If there are security implications of not nullifying `lrbp->cmd`, shouldn't they
be noted in the CVE description?

If this just a fix to the warning, this CVE should be rejected.

Cengiz Can

