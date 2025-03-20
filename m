Return-Path: <linux-kernel+bounces-570423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473CA6B02E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B463AB55D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B144221733;
	Thu, 20 Mar 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anp50Zrs"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75797E555
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507558; cv=none; b=ajfQ9pjoL6Eg8ZP2H3TQogdAkXuV0PUKrTYcbUsnH8R/wxxgD3asPV+wPw/oL6scWnDTcUe/q90g6+UnPgiO07sS+oru8VZtxFtQVD8Om/0kLM69250p0O1joOQBq1DNibYYenwMohxgfvEZgmwJpdK01rowpcCWQlwvY5U11FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507558; c=relaxed/simple;
	bh=BVvcyxYEziOGx5h9tmnx1mM84FwCZyGNM2IgO9jPDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5wrT7UO0QYzdvGeUS4HQlIzufs5ToBl5byqF1GAsqt/37zFkJw7LncZ+mnHKuUmuC7O3exropNq0sM+9oOEnp635ONzR/7EfjOkax49yrj6cRAi5TSo+4wxaZ6XJScuNtAicF2mxxvEYSIXZBvG6NEiPGwvf3YmxU/gJuW19kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anp50Zrs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso26310675ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742507557; x=1743112357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oma0AVJC6lreuhNibEpEtJe+P+lT+eQf/vjxRrYfHqI=;
        b=Anp50ZrsUTFbwjAWjEzDK+B0y2dOULt7UasID2+3QHS0N2ptFNbsK1e3+cHM/grqh3
         fyTBZvcRjDVxNF/8J3Fe4zxk3MdbXWeUOvp+T3ZB1P9N/AFtNycBw6oEly3DC06LOcxN
         h063eRHFCu6TQZ8SRRIKMlI1wrYTednQua54DeXC2y+skHz/LBf6I79VUNvnjoocRWDP
         FyBnmOttDJtICme+9t3MOwyZAJDMDbQTcmBFJHRYQDaK9B5HuHYBuQQdARCqa5Y7n7fa
         NLa0iAYCWXvueuyprLJual8xYBZe6L6OO9LRQ1uHlnQHddItxgH26ixNBcXHPF80zYtF
         zsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742507557; x=1743112357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oma0AVJC6lreuhNibEpEtJe+P+lT+eQf/vjxRrYfHqI=;
        b=Fn4aPWFm4pquXONtdBwNCF9xklqC4qtsc+nFwuub/z98h4xUbD0raZQUojoov325FY
         rnah5BWRKvba4PELRroFSOomRfG94mESFodGLP+mxLN5JKU3GCkALcxPWpdAHYIWdms+
         cS/5+gCCVc8O5a+5uMea5gj3b7lnPrA1mR+oTpo0+Y9TyTIdR36NQ1C/T8Fxcwz+yzM2
         DGWmnYvaXkT8OHbYSvzLem1g+xaa2YfdY4s4yKXy8qpbG5AzqmhCSb+7cFRPyJTVKrut
         OhRKVBldFmpKxWyaKNF82PzDdAIKin2QnAzJ/vJaCXkath2tQpqVRNqKTYlTL7dzyuF9
         u7FA==
X-Gm-Message-State: AOJu0Ywnp6kXetWWo8bsH66fWF/GdPSgkHg76i7krXH72OWrm/jZER+S
	92CPnGuV8rP3R/ZC1MDPNZo+4MGTyeyVqIjh2PSg8n7igPx+a9JR
X-Gm-Gg: ASbGncvq9YqFUiXOjHMzrqZZJhswZ3gHUx/nc2NJ+isjKoHDqSp14sH0zXXtDrCT00Y
	pdCK8rszFKxw2+7yKqbgFqQ2WB3RN5X5HiZ0Blb59lYyx9ufjcKCsk1IaSLYv9nojWwcm5w5lGN
	TzvFi+jZizYI0rtgM88PRxmMq6TQGsz2ZT6vQ3tyxJ8c8oBU28lnhyZ3N4QP+w5baQxN9rUSAeE
	xfXnf7wNOnLoSi3SWgNyObF9ArGC5siN/V/VgYmNhSRnmiYYwFOST4mX7hP8X/C7whTh9FUy/OW
	DzAKGCnSUVGGwHrq3NoOKSNjEXOd4kYcHVjaDKWRBvve
X-Google-Smtp-Source: AGHT+IG6epocPw88IsPbFMl2croZ/2EIOobb/AmUBe5xDBSpt6oOXk+SSwLq0WUXX1lCJ0jsItTdyQ==
X-Received: by 2002:a05:6a00:1953:b0:736:5486:781d with SMTP id d2e1a72fcca58-73905a27720mr1481570b3a.19.1742507556590;
        Thu, 20 Mar 2025 14:52:36 -0700 (PDT)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618dd29sm322274b3a.167.2025.03.20.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:52:35 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:52:33 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Joel Savitz <jsavitz@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, trivial@kernel.org
Subject: Re: [PATCH] cpumask: align text in comment
Message-ID: <Z9yOIRO0lm83TifM@thinkpad>
References: <20250319161218.24430-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319161218.24430-1-jsavitz@redhat.com>

On Wed, Mar 19, 2025 at 12:12:18PM -0400, Joel Savitz wrote:
> Since commit 4e1a7df45480 ("cpumask: Add enabled cpumask
> for present CPUs that can be brought online") introduced
> cpu_enabled_mask, the comment line describing the mask
> has been slightly out of alignment with the adjacent
> lines.
> 
> Fix this by removing a single space character.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Applied,

Thanks,
Yury

> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 36a890d0dd57..c281990c000f 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -81,7 +81,7 @@ static __always_inline void set_nr_cpu_ids(unsigned int nr)
>   *
>   *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>   *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
> - *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
> + *     cpu_enabled_mask - has bit 'cpu' set iff cpu can be brought online
>   *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>   *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
>   *
> -- 
> 2.45.2

