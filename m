Return-Path: <linux-kernel+bounces-232981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C287391B0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB28282ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7619F469;
	Thu, 27 Jun 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UVIIzkIV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCE14D6EB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520882; cv=none; b=hBvH8VGFWlsn0fLTiBBKgSfSFrwotROEXWsP+x9ILverUwoT1I3EPss5NAB87opIii5A5KflMH0qjofh9BOVY9MIMw0hQT7stkmXJCLdfGdTCBtSUvLbKLO49hOoKGveNT9Q5p91iQtVtlB6KugnMPSWos0221HTeZ/IC7vdN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520882; c=relaxed/simple;
	bh=6c4jsOigt9Ruk43a9HCcueSY0YeUSMFClS0eq+S9m88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkiH9X4AZKuNwGMEx0SFZlxTjrv465UjhUoXU0nORTZrn8/WSJJy4xRkMEJbBC2rIjgta5Ch8GJkfxjkqnRmx8UYr4czmftsw78mx0u1c11FySXlw8Z2TUCFfR3R4kei4eWJ7IxQOg3ZdZDd0CYQUwCqsN2nK9NEFpkp4YaVruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UVIIzkIV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-444fa159caeso24030491cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719520878; x=1720125678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=UVIIzkIVmMkkgsoPEYsRsVrnq2LF3tRCwYZPDLOgbeT2EFVpOUyoKtbtxPNus4B/S+
         ELhTQYL9QCOKg67OC3oBDlJu8LmIUj8uqc4ORem2/NW62bwulasAlUlkCtO/Z7S2+oIE
         3YR3nOIEDgNDyhJWnWlHrDOOYn8Sn21nocnNW0M47DvtvYdF+ragBHNYgabnfXra8KyR
         vhviPyOjub8zuLxUClEqS5MdvTgFM4mSNXo+dkg3Z3pYydCFWQoiavf7lEVJpP00lwG3
         ZU3Kr2MGg2Vi5rEpN8L3YPfbIcIuqZf7zJqLDdWoro9N8Nfmo6vxN0UcUB0tsDw0koCg
         pF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520878; x=1720125678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=ngLB5LDhocd30w2dMGZKOZ+iqA9u4/3Ac72Fk9ST9+d1PJFB0i79lrfcmTwV1JdCd+
         1k6wWNmOY2myt/5sabKBh4T2oQqv/p5xtkgB428NpwxYJ+qPJqJuea7Ooog1jcDBz9k4
         bJQAVyhZVfZkdIFQ9rdPIzosdnIOWuO7EC7qe53lZmU47ylkWHrRWyyaZK4WK3sJC7Zr
         yoF+wfnirjxvZXmt16gMGYT3ER3mv4cz9Y7Mzk2LgcoKfTgDyc7Ksr4miE5tGied0wrU
         BAO1JCHER4NPaDJWRWIBpyqkks+X5SdyiGQt9rWOWBI/aD6jTx3eAGevA7NO3tGtAeX+
         BzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPAvVP7ZQxRW3w16veUDSP260svtgm47YiHTrM3Ey0APNasxDZSy/IAKFqIceXVp6YF4fLbQi5Jutnh33zj0YJF7uNQw3b8eDtYQPF
X-Gm-Message-State: AOJu0Yz7sjt3xfUhCjGgQVREqTkWyMkZxbwpX8cMOJNo78i4DsAf6hXo
	8g83k0+nd08f3r9uOazHniLqqonCi6jpaOE+Yf7itQ2xa2g/nK7Z50JMIQRPe8I=
X-Google-Smtp-Source: AGHT+IGFIa4hRaQA4Mu+AfyzyAeM600yB3mVaPeVNWkc2nyBTtruDGKIVTjDcc3JK0L5TEEZ2mr0/g==
X-Received: by 2002:ac8:5a4b:0:b0:446:426b:70f9 with SMTP id d75a77b69052e-446426b7a4bmr31951631cf.24.1719520878558;
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651498827sm1607971cf.62.2024.06.27.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:41:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
	ying.huang@intel.com, viro@zeniv.linux.org.uk, kasong@tencent.com,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachestat: do not flush stats in recency check
Message-ID: <20240627204116.GD469122@cmpxchg.org>
References: <000000000000f71227061bdf97e0@google.com>
 <20240627201737.3506959-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627201737.3506959-1-nphamcs@gmail.com>

On Thu, Jun 27, 2024 at 01:17:37PM -0700, Nhat Pham wrote:
> syzbot detects that cachestat() is flushing stats, which can sleep, in
> its RCU read section (see [1]). This is done in the
> workingset_test_recent() step (which checks if the folio's eviction is
> recent).
> 
> Move the stat flushing step to before the RCU read section of cachestat,
> and skip stat flushing during the recency check.
> 
> [1]: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> 
> Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> Debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Fixes: b00684722262 ("mm: workingset: move the stats flush into workingset_test_recent()")
> Cc: stable@vger.kernel.org # v6.8+

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

