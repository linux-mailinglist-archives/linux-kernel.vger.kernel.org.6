Return-Path: <linux-kernel+bounces-531714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB27A443F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72417164694
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988226B082;
	Tue, 25 Feb 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="EV90n1jV"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8A268689
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496189; cv=none; b=NPlDbyRsqB4jd4bC8XYb6kAw+slEB52GTShuZUF57RL71EkwpG2BpMF3svCHrPOsjy+gFJMrOZxbXepq+S+WfmzydFPkIILPox0lLqsSk+3HJj6RmrNYHNW7FIHSQH+57sK26Pgff/B23T0ZsRx4LgtUwGgb8y6C2GHft3aR9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496189; c=relaxed/simple;
	bh=74YQeqAA3d+5r5+SX4agSypDZS1pWWwPocYcfG67nMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG6bO66J9b2K2HMSRFKP2oPw6lC7gcMftLLcSsuWVoXMka+fwBli8ucP/mj5Z0JC5jYy8l7uKK81EpKd7bJaTpq3n0Whodq972psjjNQ/aOs1voY8+rFbGBERwU0KJ3a+PSAZ98C56BiP8NE7gytWbccymTNNcGPYaDrJIJEQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=EV90n1jV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47210ab1283so80525781cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740496185; x=1741100985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cm1qWMsbUpl/AqfYL5EEQc+biUSgO7YWDttV453eOTs=;
        b=EV90n1jVEs6c6ipvzs9g9ZUo1VvbzmYz38PB/kEGGhK2lPp9dk3JPalikJcEVSvA2t
         5J+jHq+ogYp5oHnmdlxSEfcpA3ku+D8NuRiI440MxEFiju5dVTP+ZVupOU3XVlYzs3VX
         UUUf70PdmRj6moRrIAGz7gikM6HOmm5b5UjL55xuSJ7v/E4maBQcp4MPa42ztJS9jzio
         HPLYPgIbnThwahcfiEM7MTC61OQ56aieX2kyLJFHFIvM8vAqyqWmeIQzSiAASyseqtvZ
         q3RBZh93qH7EZeSffdDG/1Ygpm3AUUmKZd92U0GqAun619/kFqDpQb06sqmnUDI+XGT8
         OAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496185; x=1741100985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm1qWMsbUpl/AqfYL5EEQc+biUSgO7YWDttV453eOTs=;
        b=qOhQUk0JuDV/HLeITkEdtezzbN6WkQ1mj0Py7fZ9TfSLN79P8fB0Ni5N6+D6D/hUPJ
         4pYgSuar4ElK9lud/8+MDJ3dp0NPetOV4tyErSBUZkQ+wUYRyKag1X0l3hjWmYR1UYyr
         Nom0jbseXISOK5RUtTE6h10gBOmT3lxWcN+Obk2HCBgGBuwAz4vHuoPi9ONSbmXLk//v
         7nGFhY9cVt/rV4sQ+EU1YWbVOuLSn3oaAtafKRuZYfsLsF+iGYmPKOty53qa5OZYz8qC
         FX34ilVnu42MGq5lItT+78JntNtCkZHp0+1kaH6dLUztWo3CFpA5YeTzyT3ZxbWvif1Z
         YhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz2i+NyjYFcQaYQDPB61y4u3UEYGY7+/LJGUXDBXWw4r/dFLDjAn77v7fgkddxfBxjmvw0GOv9HcnBLxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMAee8dCMcJ7bLAwltnZiZ4F4XfsW7jsMVbNgUkbDXhQTJvJl
	xi93LJum8cEU+zLXDNsqagV97EUeJ8H6yrrdvAgoyFEDurd7xwY+Vgtgs/R2Psk=
X-Gm-Gg: ASbGncuffW2MnjQGFe5nEP5/hKb4ZmI0Vt7K74RuRVC4+2AUYuR2DPG+iKiPdUA+q2g
	WdWECecjr2wP0cqOdpIPdELkmUjlXS6jY5DqgXqhpH2LlzOSnwdhwOCokzm30L8CkrCBGQ238uv
	vuON+I74m081AUg2KMKDWruZ4BM6/d9kl/5/aP25/BLUqqHbgTjMzDOUs6fm/E1yZfc+D9R6SKu
	BsITe7P/W/nx2j8NIHnKXj43qxR5R2vm09lXXngMXqnhByhsaSAviLCTWOr5P9PbnPFeO0ZSl5g
	xG42qZlqCJMMnKSLVngkj+At
X-Google-Smtp-Source: AGHT+IEVrNuqTHxCPGD+pVoL7RDfl7fG/ts70CXWgb5aQjnlCTNe5Q1iAvDePknZhUQDgpEkSgVynw==
X-Received: by 2002:ac8:7f15:0:b0:472:1289:f88c with SMTP id d75a77b69052e-47377228998mr59707991cf.28.1740496182130;
        Tue, 25 Feb 2025 07:09:42 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4737806a4a7sm10754641cf.52.2025.02.25.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:09:41 -0800 (PST)
Date: Tue, 25 Feb 2025 10:09:40 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: page_alloc: remove remnants of unlocked
 migratetype updates
Message-ID: <20250225150940.GB1499716@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-3-hannes@cmpxchg.org>
 <Z73JB40tGaWyVIJK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73JB40tGaWyVIJK@google.com>

On Tue, Feb 25, 2025 at 01:43:35PM +0000, Brendan Jackman wrote:
> On Mon, Feb 24, 2025 at 07:08:25PM -0500, Johannes Weiner wrote:
> > The freelist hygiene patches made migratetype accesses fully protected
> > under the zone->lock. Remove remnants of handling the race conditions
> > that existed before from the MIGRATE_HIGHATOMIC code.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Aside from my WARN bikeshedding, which isn't really about this patch
> anyway:
> 
> Reviewed-by: Brendan Jackman <jackmanb@google.com>

Thanks

> > -			if (is_migrate_highatomic(mt)) {
> > -				unsigned long size;
> > -				/*
> > -				 * It should never happen but changes to
> > -				 * locking could inadvertently allow a per-cpu
> > -				 * drain to add pages to MIGRATE_HIGHATOMIC
> > -				 * while unreserving so be safe and watch for
> > -				 * underflows.
> > -				 */
> > -				size = max(pageblock_nr_pages, 1UL << order);
> > -				size = min(size, zone->nr_reserved_highatomic);
> > -				zone->nr_reserved_highatomic -= size;
> > -			}
> > +			size = max(pageblock_nr_pages, 1UL << order);
> > +			size = min(size, zone->nr_reserved_highatomic);
> > +			zone->nr_reserved_highatomic -= size;
> 
> Now that the locking is a bit cleaner, would it make sense to add a
> [VM_]WARN_ON[_ONCE] for underflow?

Yeah I think that would be a nice additional cleanup. Do you want to
send a patch? Otherwise, I can.

