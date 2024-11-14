Return-Path: <linux-kernel+bounces-410060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A899C9603
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AE91F2141A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A21B21B5;
	Thu, 14 Nov 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cie8v75h"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631E1AA785
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626233; cv=none; b=giH6D27K6bPh9QBieUYV1XWbPgrHQNszGjavNMrtm5kQFG8iqefb5JREdqUvwbhXJYd1fYZYG2E+9mONprBWP5kGUejKMjQ5eigOvVUQF9S0WaR0fXYuWqFK/QhYJFp5Nb46fRKTfYhC+FlFGz3kPh5n6dK/3FzLwuamfGNIZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626233; c=relaxed/simple;
	bh=CI1r12nNHRwypDsUYC8xY9fzjewA2c/mrZsbdnAEyB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjoBTo+OKji9y0R+WvVjJmXLSKNlj2nRvl0bHXKbfqwe+ZQTg5Idgg04X7KWF3TYbTEAxbGyCGga4PapPKJ/3IoaDVcwZci76Sc34GYSH/5QIQ0+PudIUhSA2I1uDE99Iq9/3WFLnge6auFVQfNuOoKk2Q96WvC5Rc/Od0Kolbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cie8v75h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so1717521276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731626231; x=1732231031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwAzg/sQCaKfbfUxYjkIW4dK4mXFdPygldw0DR81bXI=;
        b=cie8v75h4JigBi3C9ayjkHTv1bcGaPALHy4DUS9KhfM+MJgpMavda4mB3jLzUDkXv7
         qRdyOWKgMc24sTK1gH/GWzmL3SSUHe/TEQlUhb42EUe///VOIW3hXvylnaMkwn8BB8tl
         37W0ePhSDYbJHX8NBCgX9BVK7XYxY2czsMMwe7TIjbHMMJKqOvLf+1kfD3uY0w1fvZDG
         0Mss+KFHOKqueFy9yoP/p/TGwjoxC5VXQf7yDYNcGXRfsRMc1KXOqfcOFKFojeAm/byJ
         phzV+1IrrGVIhVZylYua8kEF7pc11Qjl7ub/3DNRE1D/h4dseATKp0JAdbgKest74s5z
         7v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626231; x=1732231031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwAzg/sQCaKfbfUxYjkIW4dK4mXFdPygldw0DR81bXI=;
        b=HyWvD8+uoJWagvv/qvzcK3uvNJ+4lBDaJZu925genhm5OhBQfLFrOLJy3O9ccza7wm
         GUTAsN1aF9mVhlNcGWrZ8PC/TZTcG4i1GgzTRKuDWL9DUOS4CBl5eZgFf4idzRYEznK7
         gXUVvFHtsZHGlvHD1lWzPK7sExKjYv88v4yFC5N9IljuwfZvhgshSbq9vUMAV4tz/hLc
         UTrRwtMKojkKA4J3JuIeS7+P7tmh3soeTyBLr3Er/o5NjKqwkH21/CRZxzJlerbX21I5
         9t86lcEV8yVhRUlWZ5miDaYRPLKAqJiC+AvExc2ex2SmRvsMI9rXlp7S13Dlqu3qOcLs
         NBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWojtMFYiFv2Eh2nA9DkRKBvxl3RiFAucOgRNsbpq822ivw6kZ/olDHix2xjzaeEysM0rhY9FOxX3h8e48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFbyG+yRDnLP9wG7HmoZQYDKKj9vrlqTKKjhBao/LNj6qlDga
	pYIAPT3uv19gQZF5SVORWKNJrQUjKcemQOdWtCgwZAXGHq+8LjeT5gC89QGztwGLOK7P6Q7I3Um
	8IA==
X-Google-Smtp-Source: AGHT+IGFlgWX0KKA/ZGZ5IsWUoPGyuuB/g3OCmrsFVhtApZPgZzMWdFLLtgmd2LXV8EXavHvLHIIovN59Bs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:9e0a:0:b0:e38:e8d:2c02 with SMTP id
 3f1490d57ef6-e38263a8b74mr588276.5.1731626230833; Thu, 14 Nov 2024 15:17:10
 -0800 (PST)
Date: Thu, 14 Nov 2024 15:17:09 -0800
In-Reply-To: <20241114223738.290924-3-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114223738.290924-3-gianf.trad@gmail.com>
Message-ID: <ZzaE9dYmSqg3U33y@google.com>
Subject: Re: [PATCH] Documentation: kvm: fix tipo in api.rst
From: Sean Christopherson <seanjc@google.com>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: corbet@lwn.net, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

I must know.  Is the "tipo" in the shortlog intentional? :-)

On Thu, Nov 14, 2024, Gianfranco Trad wrote:
> Fix minor typo in api.rst where the word physical was misspelled
> as physcial.
> 
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
>  Documentation/virt/kvm/api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index edc070c6e19b..4ed8f222478a 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5574,7 +5574,7 @@ KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA
>    in guest physical address space. This attribute should be used in
>    preference to KVM_XEN_ATTR_TYPE_SHARED_INFO as it avoids
>    unnecessary invalidation of an internal cache when the page is
> -  re-mapped in guest physcial address space.
> +  re-mapped in guest physical address space.
>  
>    Setting the hva to zero will disable the shared_info page.
>  
> -- 
> 2.43.0
> 

