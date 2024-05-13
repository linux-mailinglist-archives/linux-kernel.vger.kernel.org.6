Return-Path: <linux-kernel+bounces-177987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018E8C472B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822A4B21923
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C53BBF1;
	Mon, 13 May 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DzsvkT03"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDA39FFE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626217; cv=none; b=UUHxXTKoAy9CsBWBlwXZfLU0LWGqMdFuqO6wCp/idKklrMK094yqyktAoOROgnBY9ABWAwfu01Bfp5mRev9WJSJ10s4u9wDDr8UHtgh9I/FdrU53xtufXvu59jkW+JijmpjSZCt5q069kXcQjc0RwoC1bXIMGdYqZ/jaAjDfQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626217; c=relaxed/simple;
	bh=v5EzLiLSnhQ3zgksVvx7OMRhw1dkzGWQORWXTJSMoNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpXkUT1kQk0DO59Bo7rARDWuOuNu9ROTmmJErwPGmibIBMS3zd/2oAWzTIYAdj3VP5e8mOmv3+Nc6yEVoA3nK+QpGvHCu+KFLKu/q7/x3+59wQN9KxAxxIpyKKHlrbTGDZOXn0H2pfQnUb6UOTd8jIjqDhoc3pFP4kwsNFWMmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DzsvkT03; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso3645900a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715626215; x=1716231015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyHOyXID1cnVSASJehop59SLFvhFG+Vcg1nWbWZdfCw=;
        b=DzsvkT03OiEp/V3XbadhyKa+S6sulrk8Of2RNM0fgNHIGlLJObf9cpFAIAhrN26AOS
         /EKrFvOUJQFjHyFsK6N/WUjGmcCukJDx4wUWyL3Mqzb2HlUTkPY72LTheX7Oo0gfe4hH
         L1wvEGUwz7dSGYwiDfp3oxnb+L5BQxcFxWO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626215; x=1716231015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyHOyXID1cnVSASJehop59SLFvhFG+Vcg1nWbWZdfCw=;
        b=QpU+t1SLO9eBVjYVBe/2kcWcAM3JfXoQvlBJp6vzHLv0Sem94XJYp1wBab2xkI+HYM
         JxbmwhZ5hcl2IJ359234dq9+wjTm8dInRW0YX0c2YNBk0BjM8U+hvo+5MkvCz113VUhb
         S3Zp5mr0Mz+0qRal+fGeBUnQbMhbi5OMiKyZNDZBnIYhKjCxv3gYGMzK/EC278puJIiJ
         bozve8Dj8tAfzAH3JIJjcDdS5M4iHo3AWVn51gAajFiSHnYl36FIscZwseehhfwRCBPV
         yfdyIB6/9jTKi4EeiogkGomX7Ozd7NtGiw7Htm0Wz7ixqPtrVNF/ZqOWXD7ji3VqL+HU
         zs0A==
X-Forwarded-Encrypted: i=1; AJvYcCWq6XLmzXoAKopITcvYVeJHl0sx8Ac+YcCV+vEctA/7uiCkNl4uHUbIYtfcDo1ZNGZQysB6z7seDct6yfKnOjW2OiRUWGuQHqUEsrgO
X-Gm-Message-State: AOJu0YxRmhPwDZiabYQMwyA3pRVx3atdz7p5knZr0dv5eN6hXfHwzovB
	nMVFuw1EAtZ3NWFzhhcHGPCsBQJ4mvI3XCweSLaplQHZSmI1YgthTHv5gpAe+g==
X-Google-Smtp-Source: AGHT+IEvCeu/BfzHRyH21BwLxXx21VEdXwjVwlQ+NO/c0WZoHXqRLSzkrDbKKYXs4TMS16J43VPsPg==
X-Received: by 2002:a17:90b:374f:b0:2a7:7cae:8ec9 with SMTP id 98e67ed59e1d1-2b6cc342971mr7887529a91.7.1715626215287;
        Mon, 13 May 2024 11:50:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca51e0sm10114509a91.35.2024.05.13.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:50:15 -0700 (PDT)
Date: Mon, 13 May 2024 11:50:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the kbuild tree
Message-ID: <202405131148.A2D10C2320@keescook>
References: <20240513151316.6bd6fc87@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513151316.6bd6fc87@canb.auug.org.au>

On Mon, May 13, 2024 at 03:13:16PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kspp tree got a conflict in:
> 
>   drivers/misc/lkdtm/Makefile
> 
> between commit:
> 
>   9cf51a6d1de0 ("Makefile: remove redundant tool coverage variables")

Ah! Interesting. I have replied to that tread now:
https://lore.kernel.org/lkml/202405131136.73E766AA8@keescook/

> 
> from the kbuild tree and commit:
> 
>   fb28a8862dc4 ("lkdtm: Disable CFI checking for perms functions")
> 
> from the kspp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

Thanks, this looks correct to me.

-- 
Kees Cook

