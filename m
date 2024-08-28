Return-Path: <linux-kernel+bounces-304906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED56962683
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2095FB2254B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC7172BA8;
	Wed, 28 Aug 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg+bqbSe"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B016C687
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846712; cv=none; b=HMM/ekQI/BV/9LH0JKaSNXG2IRy9XoN+rbgnhxRPfnelqR3RJR+IauSDizZWSnrOpCjCwQ+LM2RX0mOXuTIAxiUdva0wXfyP1gZqnRk7PfhysfjS9mPSVxpCiSpSYuz6iKl8hGYhKIfWOgUiilNJaaaECZopUuVUxQ4fzCLbKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846712; c=relaxed/simple;
	bh=KMZpbwn6MBd/xExcsxm7yVvpkWwCqtCMQbz9UQHJMqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdTOElNbcW8yZv0m0FVmOjg6ZMEMJ9Ni3gF75s1aQ6ieJaqhl6QhSiK3SrFHSQ3xXnqcUAmkUQ6a0VOgT0snJw97bRLYJxF36bw+MK/0LPfOpu/qsW7+Zh+4svTY6t5ywmHmN7x/R1zU4/OkNl7GAXSj/9jQ3UvSHB+d0Q+r0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg+bqbSe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83597ce5beso97277966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846709; x=1725451509; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AS55+5mE5vsLIos9zH8bUKG/bOHrYqvqd/7qfIRC3A=;
        b=Yg+bqbSeJqdME3U6AXo24J2fYFLpeAjvZL+d3fYU+/8Kk/I18kIEd53iQ7nySiMZvq
         qnMwTYbYF5iyqhZiyZ7Gv7t5W8+1uxHAWicrNrQWz7JwSspcso7XdiwPfA2m1xO9PCni
         hHMwtejfJdPCPXZHeLbDECIiXmd0twF0fjMaRqxLsEx8LhU+QX2bZ6iepXSbJ9p7g4W8
         K0e3FYEf42+Y2ixmRofRtKHmQYMVbxBtWhsGPRem1eilowX1HIMtcgXs8Dlq6NqoRrDW
         q4fz1ok3EiGIgfEkz6cAW/51buyfrNeorsyPgWpVQXwauDNBpThQmYP52KS31gXIDc8x
         vq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846709; x=1725451509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AS55+5mE5vsLIos9zH8bUKG/bOHrYqvqd/7qfIRC3A=;
        b=mjN3AgIGDfk4cnC+6955x1dpVDOV64MHQyjtIFL0ZhekajHosl8HFOgil4rY6w/eKu
         2V/JFwlVpJi8RpZADZgJ5wvkMFK3KhHeydxwfJ0CiWffyz8LglfvV+9i86zraN0zWRWP
         JAmupJqWBE0AIuFlkUCA8LLvMf0xYB5Gid3wMpje0jMThnqwIGOMCwTbcaiBgZ1ADmg0
         0LdEdC0cAFoMVjGxZwHEP62oRRbtogytJtgym89KpIjl9aV9rPBLUjHBPI+fICuz7qW8
         pTFVWyMbyHjS1vrAyoHeGHEr3MpJxe8ukfGf/AS/9H88Z6kTJV4uYtXqMAVk8RFVXUEo
         Rh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZnEAEk/ttnmlOvab/Dt+fFGQonw3Qa6GoGE1nX5bn7GI6DvmYm/QUbwtNkQ7+gwyaO7QNV+DR/cj2DLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvdH06FTFjTl3TSG+FaHHybHjYkj8v5HLn3xoqv1P8gZ6ATAJ
	fU7Zw4n3EGL/Fi7UyplGgbUdj9xRPy2ZbVQ78zaGUw3R6PIoCno5
X-Google-Smtp-Source: AGHT+IEh3s6hp2UfALIkLUHiCIc3xx9YWxULhlPT0ih5P/Jd5cwphB4OweDfJn1WheQE51Qd49tAAA==
X-Received: by 2002:a17:907:7da0:b0:a86:a6ee:7d92 with SMTP id a640c23a62f3a-a870a9ba661mr229410466b.18.1724846708932;
        Wed, 28 Aug 2024 05:05:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d488sm238661366b.104.2024.08.28.05.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2024 05:05:08 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:05:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: arange64 node is not a leaf node
Message-ID: <20240828120507.jc77ysofhlzw37lq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240826012422.29935-1-richard.weiyang@gmail.com>
 <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 27, 2024 at 06:34:26PM -0700, Andrew Morton wrote:
>On Mon, 26 Aug 2024 01:24:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> mt_dump_arange64() only applies to an entry whose type is
>> maple_arange_64, in which mte_is_leaf() must return false.
>> 
>> Since mte_is_leaf() here is always false, we can remove this condition
>> check.
>> 
>
>These are pretty simple so I'll say lack-of-a-nack-is-an-ack ;)
>
>Please do cc linux-mm on maple-tree changes.

Sure, will cc linux-mm next time.

-- 
Wei Yang
Help you, Help me

