Return-Path: <linux-kernel+bounces-171287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA28BE23B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF51B1C238A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DB15D5BD;
	Tue,  7 May 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fcmKxLe1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D315B0F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085287; cv=none; b=APBXA00lFIC2fELTf6+vGX9gE1+jNxwbKs/9rHIXa+rpzL7jseaX9WScoaax/dpWvxIYZdlHdewRcnME3HvQQ+D543hKP67SHDL7G4PisuXCyj9c+7TtZQ2dhz1EGrtjgNGRLm0SPXcDlzqDpGndxvvjIc6MXtGp0QiOKJa5jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085287; c=relaxed/simple;
	bh=4qhhVrDLgvjiR3qGhTOs9uM3suWa+tgK/JAtQej9lNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWaxVze+H0jvdRF+OS40K2jWFSqLkL0r03sj/kLJJFAdLabUN7NSAwT9UNi1cIcEt0hrBLguutEwB8xfhOYSpBof61ypAQVHXtEd5BuXad7Bu0KTMxEJ6kpYauccPrMw9AE8OVT6BiX2AcGzg+hdjKfZUcTg7IDHstqwUQlVW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fcmKxLe1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f17ac14daso3320547e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715085284; x=1715690084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb7T1C3RqLm2Zber0tc50ZaqTjghpLq4bIRrAurD6qU=;
        b=fcmKxLe1yEnewMPMZr2Jz5huoki3cxRFB1ASj9i3UrylKgFQeMPskQlJR+HsMozAdA
         BEOxvKgvw/XakEiklmC0WLDdBqVGBRIU/cO3JBIhqpKYBumsSSOJNHCtFpOfoZHpcwlq
         lOBoMxCmgOX8I1brp+fnl7dx8lAwuR8TnNfnTAsUcl9VpOXHMTkVR5/rR1LdaFH6clT2
         HX1RDLlopDkXQkKUSjKYIP7Bngj0S/k0ZXdIiq1sFJr+8kGvE0FLIGln2vPgfjUh2ZSx
         /LRVzyrScZ5gZWX0rkHIhePHs0VSFZp4ZbEVIcWbXelnyTIU3wXB+G445ULtFydRT02S
         o0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085284; x=1715690084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb7T1C3RqLm2Zber0tc50ZaqTjghpLq4bIRrAurD6qU=;
        b=NsNmHmEr4klDBZMQaROUb7+Z2Rwo8qvgFNKBTOIQh5JixTy8fy2l2nuvQTqUqocaox
         ssN9Jj7kxHnL2yWnXI+E4HtIUdWEBDQ7pHDCxZ5+r4CmJh0s5hz1y2r7We6jeWaKNFne
         2yg7mHD0Tdc+tbLCNxXp39eaKEjpf+ytBHvCTqY3qCP4M7ShV3T+eugPRIxhJyJyNWZR
         5YfJQpHNgFFu8u1YMPVDe2QPs0btQdYkhexa7IEsw7Xf5HE0zPJtUw8t8EeSkx9BBQHT
         YxYFZpLlvmm+JJF6bPUxKb78BQTClj9HRD223b+6DRmVMA+GJ8zCcajehYeX6raUkrSs
         6JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvUe5H/SZIi3UaYxKoyXX3/rVm2HjIhtBJLf0/ZTZcs1U2ZkwCNftStYiqrcXisH7h4g5PSkFwk7eAth/trGSYpMXilD2PxuHwVL31
X-Gm-Message-State: AOJu0Yyc0RbI+fQkoOE0IeC7IWxTGKr3H2kWr9zJocOYgPoryfuEgMs9
	Uu5q4MxC6ttJ1wrgV+fDaMlE7yxeJ9oxYt8yxAzxZYRQzHVUl8iFKoikZqx9/TY=
X-Google-Smtp-Source: AGHT+IFuuNXxRqEhhogyMFo8s4Muv03vq4OxYhgbMjSC8e3E/QpWVHqtClYBhR+3fXlxPsxYgDYrZg==
X-Received: by 2002:a19:2d51:0:b0:51a:e21c:109c with SMTP id t17-20020a192d51000000b0051ae21c109cmr7768074lft.14.1715085283574;
        Tue, 07 May 2024 05:34:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b0041bf512f85bsm23047532wmq.14.2024.05.07.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:34:43 -0700 (PDT)
Date: Tue, 7 May 2024 14:34:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhangwarden@gmail.com
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] livepatch: Rename KLP_* to KLP_TRANSITION_*
Message-ID: <Zjof4QzDQ2unnjVn@pathway.suse.cz>
References: <20240507050111.38195-1-zhangwarden@gmail.com>
 <20240507050111.38195-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507050111.38195-2-zhangwarden@gmail.com>

On Tue 2024-05-07 13:01:11, zhangwarden@gmail.com wrote:
> From: Wardenjohn <zhangwarden@gmail.com>
> 
> The original macros of KLP_* is about the state of the transition.
> Rename macros of KLP_* to KLP_TRANSITION_* to fix the confusing
> description of klp transition state.
> 
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

