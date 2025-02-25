Return-Path: <linux-kernel+bounces-530491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A88A4341E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A42A3A7040
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099218BC2F;
	Tue, 25 Feb 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ie/g0kM8"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7839156677
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457696; cv=none; b=PsDjzsFFEEYyeQMFwZUWXfDl7g8XC5Fwpi4Rjp+tp2g0ZIyH5IlC79iNG45PfyWyxwT+FUI5Oqw8TEbqC90+RqGRHPZ5Y3CaDXiDLjc8JeayxMWZpNkRvCzSuk5gTtoAm6C1XCteyNWmjkBaOd8GiiKxhlQ2qO4fBlSDaQPqqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457696; c=relaxed/simple;
	bh=G0eBJjapMyZYC3G4DQLFNrkQO0QOLVkTdNR6ndJ9FqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwywAbqXRt3QZ8g7KKG7BYdy4VQMx0RD3ChKW8rfS86+MKYcdednYkP5RmZ303Ibt8/mz49v81faTLRxmfFM3sJbbYGovUvYSpFJyeGbWVKmlJnYNgx+KHsUrLuMhKsnURqdoyjeUtnaVHI29AIF8pEhCA4GUYW/pAjHBof0kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ie/g0kM8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcf3a69c3cso5037173a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740457694; x=1741062494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+X5JfPK4BibaEtL7BQIEz80W1y4GdOj6RNmewuZiBw=;
        b=ie/g0kM8ZTsYhidm0ToA7JFgu1BM/TmZbu+sQihCungf9KItcOUePoJp0SODLPXg8Y
         6JZxxnSl+DJ93j/oURp8wjnG3s0hK+ewVA7YFIQQGOYg7IMu1L1UZ/1FEjw8TMHEpoIC
         V5OBUMjoN6g/kKepOh217tULYop3QSPTZaGEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740457694; x=1741062494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+X5JfPK4BibaEtL7BQIEz80W1y4GdOj6RNmewuZiBw=;
        b=ETbV2KjVJTDfpSBewl0JCSmod7Ah0sSzDhlKZCKkNNR5oQStoCEJdGHlTLzcOpZnV+
         fXxLr4bsh7CkZrsk7LlBWJ2Wq710mfef7v4rr5g7NLzcn+6rNHBYLpksAXAcD3zYIQht
         TLCfjoQ++kvHES1kmCV3ACv1Yj8DfOEy1wGpeDoDQmc+QfQq7/UywpYE8CFayEaXKKXe
         CxtDTFExWWYGNLIoXvXp2Z78z7Ou9d4jIm54yPV157Gh45VzyAa64Woa+fcnI3+/Gi4i
         t+PJb7aVAKmVzdRKvFFjui9KEhSTXEDFvPs9qFp7TsXiNQX5aoWQ8HqpaTC7i4edmhDp
         mPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE/GAjMZ8B36pSd3NsuQCGFPgl8E+nl7Gei+5MAwiXZPF5prRqVLEZAEd0b/0VIZethAH1EHQzoEiD2O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84lo0olj+hj/LO6uO4rppSaAGnRXi76SlwAk2s+lz7HWC23xN
	t3YJO7Wj2ZOm24FjTtQL0tcnMcH5EAKl302Wqu850Wg+ea6tld2EG8nASzvo0w==
X-Gm-Gg: ASbGnctMyTBSR/nHDG5VtuHgsB3j5i/De5d4ctz2hBZws1XFdMFj2GrbLj8w9F7R3ih
	RdVEhpJi3/305bO6z4Lp6zwPBBRloASgc025ygrkcEXlSEO2wzK6yUOw2J+2C8m5ylQPD026gFo
	FI5Q4pRPtvZhpmbNih6VQV6X/eiPDAHpBNZlNY2r7xMEHpC9j2Eu7FZMdGUWLGC5eBIsEC792Be
	3QYYCrtk+erN0AepB8FJRpXOI/wrd7ZFIzrGg7C2tQNIMpyExyuWv+E1Q6eLBgK9Gw7aGqOWk5Y
	uTfMJM0LraOxT1ADsFVDTcvwLXFtUQ==
X-Google-Smtp-Source: AGHT+IGN7n10gk0Mg9q+s54cyuTq6rWt1GXB+ExUPwCxugZhPSDMmIlsxSuZcdMmndNCmU7034jDBQ==
X-Received: by 2002:a17:90b:1c08:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-2fce7b04f6amr25577848a91.30.1740457693979;
        Mon, 24 Feb 2025 20:28:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e27d:842a:e0d1:29c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3992fcsm506183a91.3.2025.02.24.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 20:28:13 -0800 (PST)
Date: Tue, 25 Feb 2025 13:28:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <nfkblmczqmfizey3fmd5566xthbrbg3dpsdu7ldsoddnwlqnmv@ef7lqqpa66bg>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-12-senozhatsky@chromium.org>
 <20250224085943.gChnQpEB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224085943.gChnQpEB@linutronix.de>

On (25/02/24 09:59), Sebastian Andrzej Siewior wrote:
> > +/*
> > + * The zspage lock can be held from atomic contexts, but it needs to remain
> > + * preemptible when held for reading because it remains held outside of those
> > + * atomic contexts, otherwise we unnecessarily lose preemptibility.
> > + *
> > + * To achieve this, the following rules are enforced on readers and writers:
> > + *
> > + * - Writers are blocked by both writers and readers, while readers are only
> > + *   blocked by writers (i.e. normal rwlock semantics).
> > + *
> > + * - Writers are always atomic (to allow readers to spin waiting for them).
> > + *
> > + * - Writers always use trylock (as the lock may be held be sleeping readers).
> > + *
> > + * - Readers may spin on the lock (as they can only wait for atomic writers).
> > + *
> > + * - Readers may sleep while holding the lock (as writes only use trylock).
> > + */
> > +static void zspage_read_lock(struct zspage *zspage)
> > +{
> > +	struct zspage_lock *zsl = &zspage->zsl;
> > +
> > +	rwsem_acquire_read(zsl_dep_map(zsl), 0, 0, _RET_IP_);
> > +
> > +	spin_lock(&zsl->lock);
> > +	zsl->cnt++;
> > +	spin_unlock(&zsl->lock);
> 
> How is this working given that a read_lock always increments the
> counter? If it is write_locked then a read_lock makes it UNLOCKED.

If zspage is write-locked then zsl->lock is also locked, because
write-lock returns with zsl->lock acquired and releases it in
write-unlock.

