Return-Path: <linux-kernel+bounces-385170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8629B3369
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C811C208CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D191DDA20;
	Mon, 28 Oct 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcPaPm7c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AD1DDA2F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125471; cv=none; b=NMqs89ihfRa5idS7k0tc4Gdn3kJRPPyJjndgg5sGmfE2UPMU/tyUXk/1q+A+cHUaE5ozQW3jkTa5PRK81m/pwK91LAL3vKniosE/mCA0vF+UMjDprKWY5p/UD7/zH3L06vubTgpbzpMFGomVqqxbRy8RQnq629+bUqn8F2B+EGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125471; c=relaxed/simple;
	bh=mYKwHnuXZ03D9OcAu5yJhAzhDBeaKG62cCw7L0E2Ovs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqdJx3M4WN1KGbjpWQ0h0esjMWmQSpVzD8ziF9GKypCYF1ghUseN2drYfiucg8nNb0M2RkusG5NtDH9ereyBjE3A4P92oTEsUuoYNAOOjsV7x9I3ggDkgD/EYA1KPgjXPJXXzhpuJ98IbthvM8osLsIg3Tr8tNMpdE17KcEsRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcPaPm7c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730125468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kytK5LpkQkEuAs5Ql1SB1GVSseoYUuQhZoyWj3gqhw=;
	b=AcPaPm7cepglXKVNNGay+b7H69qsoLB6jcCeXUbSxC27MIrNLlbBa0C7xDQc3Jzfvypzc4
	uRX8+q1n4PEIAaj5ZSBWxIq9lrWDg/DZWteNIukJsjiaXuFZe/LYY7aFjTU3tq//N5iu9g
	J/hJlNVLkHnfxbRlZJu3UOdo7NbON/A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-xxNotLRHNoqFvTsfrtx57g-1; Mon, 28 Oct 2024 10:24:26 -0400
X-MC-Unique: xxNotLRHNoqFvTsfrtx57g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-461011bd338so82574541cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125465; x=1730730265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kytK5LpkQkEuAs5Ql1SB1GVSseoYUuQhZoyWj3gqhw=;
        b=RCuyIZCZG7rP2vm6QNu2n1S1+hUeET+ujwFSAirFXoEgnwu7pfSTbZLij2DWMyixqt
         pDHwJGItsT/a9O2q8jw+B1e0REduITY8ZifhqRFOt6JJtH4kScBxu8YoTXKA4HoxAkuY
         8Gby0lhDcUhZ7HHrCrrpw8+6qicRKAgJaVKj+D1tiulyKlzM1cAYqE6pt2cFcZWcrxWc
         rBDBdOu2kexPUwefRKD5OIQpTk/0lOcWMvzi9i99nEwIsPs3Wz06lHtKq8GIrrDrinuf
         s4gqWBGjw/s488Z6YATRsjWRlUFNxGEzHIRvtMAymLpYPyGOpiZsoy0Nw52KZnah7hIH
         +2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUd63fYakcB3xph69SOHo3i8BBBquICo/MPtV5UgfuyHGj3ziBAblDtOwdfLHOV4R4Ad+U/w5toh4ajTU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLf2PFshwdpmD4HtBCjKPSD2Z+x6dRLYSP33HHbp7i+QE74kam
	n78Mo+QKNHmrUBHw+v3LQF/qFXYV7dizjwNpYumyX+65pNnBljmRjdfxqMjPbrlPNw0TV85FbQo
	0HEAjBVAryWBOZ+GBCE6Oz8soeOKT1Th64SXai/jhRu/ttYMT/rpxQ1niFuKVkA==
X-Received: by 2002:a05:622a:5b87:b0:461:3faf:6504 with SMTP id d75a77b69052e-4613faf66e3mr113244501cf.57.1730125465607;
        Mon, 28 Oct 2024 07:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9S71jomFJTF5FwvrgWGDLYy0nlBNLtjyLZXz0OPOtdolOwMUfjO96/yAXySc9eqlsImXhA==
X-Received: by 2002:a05:622a:5b87:b0:461:3faf:6504 with SMTP id d75a77b69052e-4613faf66e3mr113244281cf.57.1730125465298;
        Mon, 28 Oct 2024 07:24:25 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132132c1bsm34715201cf.21.2024.10.28.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:24:24 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:24:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Yang Shi <shy828301@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: delete the unused put_pages_list()
Message-ID: <Zx-eliLcBh9HBUj8@x1n>
References: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>

On Sun, Oct 27, 2024 at 01:14:42PM -0700, Hugh Dickins wrote:
> The last user of put_pages_list() converted away from it in 6.10 commit
> 06c375053cef ("iommu/vt-d: add wrapper functions for page allocations"):
> delete put_pages_list().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


