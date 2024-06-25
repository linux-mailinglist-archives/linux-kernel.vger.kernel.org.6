Return-Path: <linux-kernel+bounces-229649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B5917252
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D701C22A77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E017C9F1;
	Tue, 25 Jun 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ+60aRS"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522114A0AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346353; cv=none; b=ByXaQJgIj3iPZAoBT29pEuqxz36/GpH+60aWrhwtnnSulZeHTegeMHvduJEJEcPzK4LkP8qwCVipBla1cBdddVnsGvurVFFK1tio3ykRXrV1XkBQ3ksbBfwJFnzlSRLGg5kuGT1UmTj97JHe+uy2Knhy6e/+vWEJOky/WDdVCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346353; c=relaxed/simple;
	bh=zq+1GyEy3QN7Hvly1B7/f9e4Nuk3KlypxkX84M+gbh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LTfUWBMJ3bjCvDTjSQ+u9eETlTVfTWf3JJDgdkNi2f1UkSdvORweUgLHwth4bJqiUvYE2NV9VJzMz6N5rVLCcjAB6QGx+ncInCcjV5X9+8v0/CYVZpQy7G40kWPRZcklLc3dJ/mXx4eAxT+HlvH6e6zoJPSWSywkr58RA7xiy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJ+60aRS; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c1adbcaad3so2640815eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719346351; x=1719951151; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ALH0o4wCkPNRcsw7b9kjeSziGi/YAjVTN8e30pO6c=;
        b=FJ+60aRSe+zJH4HFRD8oddrV3vl7yuzMYxYc6iMyiaD3vF3iltcM/BfnphxrDY+h+e
         xsbCb/n4gqsp4tEv3SzIqa9X3bJhSzRTW05lCiZvAv1ALDEyBcdwBp2ikloEuK0k2udA
         RZk8doF5ub7EFWObB63w5H/9No/9gyUOcPoDhS8DtCysl8RDmN/tE9nRmx2S1frbfuNW
         H5bdYcFMAML3kq4ZJ6Q1SS/hpzTjjU1fpSQbSwjrqb+ib4EgFPLJq3kl13Ic9s6wjvpm
         +gNvmMOXcnwEPGqYkJSORLAEDgrTOsJ1JVwytnUSc1SrxlMKQ43esNOTqqyvaImEa01G
         noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346351; x=1719951151;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ALH0o4wCkPNRcsw7b9kjeSziGi/YAjVTN8e30pO6c=;
        b=gbZiropTeRwPdbY32XUnjdsjKu+oLBOR/ZpnynaaxipWM5pJ/yWVyv8kFifJWqlK2N
         jd7zR5daFbNrnWVJNhky8BIeTimpLEiZhdICD43tRZJKaWxgb7LYF2+9GnaO+goJxJ7N
         jPCfri1QewetceX09GwXy+Uidq2zTO3kT7iz9183NFQBCJ0MkGGc8+6Sn+H1vVC/CxIf
         dI+ELnFIpFjTElX4J/A4ZHhG2+3GdIlUKWRe3aCvFQoAA5ITN2NjwxiKf7TKnQp57WNH
         0ndJGeoqdavKYNGgRSB/58VQPs33t51Mp+ZrFdwMiN7TCHhVmbCWwv5rg4QfNsFO6j7Q
         k5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXoiGTuwWlf3VbKcGiAGrB0rAb8n5OmECCfCR50qpIhmrnqZv9eLcxmiJ3VKwUE3KrzvVoufySY4oUnwo92y8jUS2jygo4olcNdYhev
X-Gm-Message-State: AOJu0Yzq2jnNaAHj5TExvSLAJpsjMmK2rmB7rWZy/dloSIQlDft4Oi1m
	4+wnnkAjObe7vdb8IqS2wTZnK4DKHHoyKhpa3jOglK/fcdo/YJAyOyNmvjUNdA==
X-Google-Smtp-Source: AGHT+IFWvGUa5p/ox2mzwxVRrOw0xLck1CoWcMZTXwVYkVJW4z6AQtgo9Luvs6iReQ3fQmDzPAdXrw==
X-Received: by 2002:a4a:2d01:0:b0:5c1:e955:95bc with SMTP id 006d021491bc7-5c20ec105e2mr2204436eaf.2.1719346350715;
        Tue, 25 Jun 2024 13:12:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d58ff7e1sm1873751eaf.39.2024.06.25.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 13:12:30 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:12:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Barry Song <21cnbao@gmail.com>, baolin.wang@linux.alibaba.com, 
    chrisl@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    mhocko@suse.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
    ying.huang@intel.com, yosryahmed@google.com, yuanshuai@oppo.com, 
    yuzhao@google.com
Subject: Re: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful
 __folio_set_swapbacked()
In-Reply-To: <9e8d71f4-69dc-4bf4-a40d-e1b89586f5c9@redhat.com>
Message-ID: <ada1b9f4-82de-f25c-f8ed-45e589644bd5@google.com>
References: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com> <0a41d5fc-d1a1-4b1b-873e-a701b20bbcb3@redhat.com> <f7c74073-f19a-0f59-3801-a20d319bc0ea@google.com> <9e8d71f4-69dc-4bf4-a40d-e1b89586f5c9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Jun 2024, David Hildenbrand wrote:
> On 25.06.24 21:37, Hugh Dickins wrote:
> > On Tue, 25 Jun 2024, David Hildenbrand wrote:
> >>
> >> I'll point out that it's sufficient for a PFN walker to do a tryget +
> >> trylock
> >> to cause trouble.
> > 
> > That surprises me.  I thought a racer's tryget was irrelevant (touching
> > a different field) and its trylock not a problem, since "we" hold the
> > folio lock throughout.  If my mental model is too naive there, please
> > explain in more detail: we all need to understand this better.
> 
> Sorry, I was imprecise.
> 
> tryget+trylock should indeed not be a problem, tryget+lock would be, because
> IIRC folio_wait_bit_common()->folio_set_waiters() would be messing with folio
> flags.

Interesting observation, thanks.  I had imagined that a folio locker was
safe, but think you're right that (before the fix) this could have erased
its PG_waiters.  Typically, I guess something else would come along sooner
or later to lock the folio, and that succeed in waking up the earlier one:
so probably not an issue that would be detected in testing, but not good.

Hugh

