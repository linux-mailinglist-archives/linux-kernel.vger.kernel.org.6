Return-Path: <linux-kernel+bounces-353391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A965992D30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F4286D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB261D3644;
	Mon,  7 Oct 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxRIvQzf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C801D356F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307509; cv=none; b=SWOH0BuxglcnSiw6OUHM6cRr14sfiUFRHuAE+1uWMwak/TSiBpJgqMZG5Kr/a45r5vre3MKr+sOTg0KG+XGyPM/4n/pQbZklIYd3VwCM0Uuk65wAfQp0Fx+e5Qw9haFAcniHHrjfFEz6f+7x8K92lYCAPr2B1lz2NuzzwKAisqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307509; c=relaxed/simple;
	bh=MJHXFEEryb9PS6FSgv6RX77Wi4ZIfLZ/Nlz5tH2i/gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ+rQvjmmcWnoiqeCBS/PycOVXJwbiFhiAFK6n6QZrmYo+osVCVPmPWeJQKnYRVY9Lf17yuN0EZo6JDzDK7gfB0XTLryH0G1wrHL1mAux2IAQ6HJPDpafrSyCj6IjGu0Z02A0EQzlWVWu8cDLoTcbJBcwm1TMYz74OFp00LYlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxRIvQzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7to6M2v9YExVH8dgi44dQHmA/lbYoY7UdTto26LHN/Y=;
	b=UxRIvQzfZPUJWTQzdNdp9+NVoIyfdgDgbgPuOV18keX4k/sLG1VcSFZuU7vCc0m2qqPded
	YJgIL+aQi+Djegilr6uJ8N4iGW0Jf2WuzF0qk4UQA5g6xk/NMQS0PyUtaGVyftEp4o7lhm
	GvsFZxV9CG3tl+rXLmdsS/O6xH0TDdg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-trzY_FWFNfW7QsHAGhxs0w-1; Mon, 07 Oct 2024 09:25:04 -0400
X-MC-Unique: trzY_FWFNfW7QsHAGhxs0w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9a7eed5b2so886275585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307504; x=1728912304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7to6M2v9YExVH8dgi44dQHmA/lbYoY7UdTto26LHN/Y=;
        b=ZkymM+ePUfRCIlk3gBD2GUnNxfNtd9y+OKn/L46I9fTjC51N9ES59usNB5zvFJCzcS
         g8m8eRb5b25z8AeA6KTyP7TUZIPSzKP0cmCv9BQlv9+MOlYHd4J82egzZQpUq2hBKMix
         c7IACCCTzk7ld5VuOO5tLhA3by0d3eGnr4LKWmj4sag8lAtaQuHcaspS1E8D1y0J7R8i
         Md+gX8MV3xuiMM9VqrYbEbwde7Ymaw0kwmr+whvdMb1/s8d71bGBfGP5Y3AgOyUFR9ky
         hHxdiV++YQEjNwFtuojqCwlequ4WiJibW1iWs8mgWHE3gaqF1tEtnJP0pldafVyiz0wy
         uO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTISh70/XmF55UsuwPGxVpgF7ebXWPvpjJlMhNcQdwTAO5XvkIOnz7S1c5es5GtAELgSYREIZI/jL1iDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AmfNvnONpjCzvdrZGQ3Sh3SC3xvur3TYEVQwXdD2csWs9+U9
	R93s+atyUmN1GB/X+hqoDZkoWI8kWiXsg77cmjmzoJUEJZ/wq9K5E8mgGEmrL1w/Ssn1OMqEfFr
	lxJ0spkrFx4Ljhv3vDWJ6sgyteznC3H7eihJFpIwe1b5blSEFhQtmyj3yNrFB+g==
X-Received: by 2002:a05:620a:17a3:b0:7a9:b3db:bf32 with SMTP id af79cd13be357-7ae6fbaf5b8mr2022680485a.33.1728307504326;
        Mon, 07 Oct 2024 06:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ducyhmpTjSWJfEoqkJOyEPWQFKMshZVUqEAw2VCWtyvS7W8ZtImZ5cjaMzHZ9T4dK5+nGg==
X-Received: by 2002:a05:620a:17a3:b0:7a9:b3db:bf32 with SMTP id af79cd13be357-7ae6fbaf5b8mr2022677085a.33.1728307504005;
        Mon, 07 Oct 2024 06:25:04 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75637909sm255127285a.68.2024.10.07.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:25:02 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:25:00 -0400
From: Peter Xu <peterx@redhat.com>
To: manas18244@iiitd.ac.in
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <ZwPhLFIk4gvhn10d@x1n>
References: <20241004-fix-null-deref-v4-1-d0a8ec01ac85@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004-fix-null-deref-v4-1-d0a8ec01ac85@iiitd.ac.in>

On Fri, Oct 04, 2024 at 11:12:16PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> syzbot has pointed to a possible null pointer dereference in
> pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
> dereferenced without any checks.
> 
> This fix assigns mapping only if vm_file is not NULL.
> 
> Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> ---
> This bug[1] triggers a general protection fault in follow_pfnmap_start
> function. An assertion pfnmap_lockdep_assert inside this function
> dereferences vm_file member of vm_area_struct. And panic gets triggered
> when vm_file is NULL.
> 
> This patch assigns mapping only if vm_file is not NULL.
> 
> [1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


