Return-Path: <linux-kernel+bounces-350411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E161E9904C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A9D28349F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F047212EED;
	Fri,  4 Oct 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="epWtngwa"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB3210193
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049666; cv=none; b=FodQHVhRDjll3fDmvzG6DiBoW9Csz6zraGj4wT+gaTsk/cMdX091H7+afEyspaORZ4HorSXnQIAbufNwbs9wOxMpqfc0ozB6NmEXWw0dOGKFlcSSTGygRRaOBgogacI/DSv5e7emOY/1B41AnwECBP6fVxhNpv3IUc0Le1JXnaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049666; c=relaxed/simple;
	bh=mKpxbrcHZCsztud5IA1FHHgpbaOPgKrNuSnu9crzLwM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5h65ZfSZrCFJ/z8QnJWHBp2IU4CVi3c4gSxpyfMdB3rHP2wwJt5BLDV4V82dGJfGiYueucDoK4hgqvlL7eugwld7iFxX3N9OBfBOHD+6jvsAroIqcGSpo6qUQJLeM5OUf71sH3gs1KGn0O/ZDIUJF5/gtpxzvMg1YlOZw9M6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=epWtngwa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e077a4b8c0so1557888a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1728049663; x=1728654463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4NZSSOmxpJgVIXotODKT8B64hShlAJiNZdC5IU4kIQ=;
        b=epWtngwaYS3m7e7qdSWGJ6VqVSW/y2V+6OQaQGmb1rE80zDSdzp0hJNhU6XsTprgwM
         HzHx7KdnDZld63rQWN9cvJWSsK/1sd7f89yBIF1aRIK7kDHq4gSK0f12X/VBOyfzMZv6
         oEBT0/F2rJL+0rKFhX1/2+Al/PoCGJ4bcZKQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049663; x=1728654463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4NZSSOmxpJgVIXotODKT8B64hShlAJiNZdC5IU4kIQ=;
        b=vs3ximfjhbvJF1yg/G7uW2uT1tFQbn6QvYK1ysLnAhLaze4z5nAeGg8c2CBMtA48bK
         FQYUm1mNOxEWIeF2gRlfLufvRh20lCm6UJOavk04VlGZLB8GaJjOg2VK3Fcbw/0bvQE+
         e/TSWykAOMEoy3+YN30PumZg+dSl8gH7//O8W2fihU878l6TzXkkvMCdfVQOCZ/10fk7
         Hnomm6MZI+ODPMrEbUgO4pCoXINkHvTXfHTqNhwdXhHdImkBO7yqIPnqDdrIks3Z83l1
         nuZmZP5k8DsBu0AjmioJxARRvCQxKfVmg//J99FWAGnhGLxw9l+tKPfiUWLJ4Vlk/xEc
         6jNg==
X-Forwarded-Encrypted: i=1; AJvYcCW5xTblySF/cUpd/ZOvo+BOAkcH15kwD6j+u53WM2BDztYt/xFBFNJpHVxtOEB0miAN7Uz4gekQW+UZ4Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElEpwBHMZa0qBNU0oi64XCWoAPnX1tUVbvH4H36KQH6KdZhZ5
	bHUgDEl4f81jcXntn0F5rqxlM/jhI1NUYrVZ26pRehzdT9C5ueBtOAej3taanFY=
X-Google-Smtp-Source: AGHT+IEeTrdPnfpDQVPKQQ/gxSDhFGcv7qtEq3cmWRZs8r+EwWAAhjIc0+E+WS/byji6CzuShsADmQ==
X-Received: by 2002:a17:90b:109:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e1e5d63376mr4226145a91.11.1728049662954;
        Fri, 04 Oct 2024 06:47:42 -0700 (PDT)
Received: from fedora ([103.3.204.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83c9f60sm1618424a91.6.2024.10.04.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:47:42 -0700 (PDT)
Date: Fri, 4 Oct 2024 19:17:37 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <yaaz2ctwd2mbirrpeuibmnugdapkalukunjvs2im76mj2q7bk5@bap7dtow4ce7>
References: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>

On 04.10.2024 19:15, Manas via B4 Relay wrote:
>From: Manas <manas18244@iiitd.ac.in>
>
>syzbot has pointed to a possible null pointer dereference in
>pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
>dereferenced without any checks.
>
>This fix assigns mapping only if vm_file is not NULL.
I also edited the commit message (and cover letter) slightly to tell about the
newer fix, instead of the v1 fix of returning.

I hope this is okay.

-- 
Manas

