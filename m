Return-Path: <linux-kernel+bounces-265112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE093ECBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5682F1F22079
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875E80034;
	Mon, 29 Jul 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g55P4XXe"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E91E49E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228754; cv=none; b=NxQFcEgUyDlc+Ar7Fp83DJEURWGe2CqpSfwMJUnfVvqMzTTCX1sVDWT1hRzl1vyNYGcMo+lYoyv3/XTbU4gM6/vfffTQszOfi3B0TV+6sMTawLEzrRT46i/N5h56oRwWMIJ4oEwesWnprMemhV34wg8ib2hWo7Tpa7JgDQxJe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228754; c=relaxed/simple;
	bh=Aq1hQz9TZ0nP9HoE35i/5Jwn8RMdmLmyTjl5z8WJCcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGuz9EMUZkayE7tSgJK7GjGdBmeVXeoLhBlDsHBi2y73B2p6jH69LMRAj8LMW2EVZNgZNTh9PlPTZBP6O55gk92twNRcN/7EupIbByN+tpZF/DUf6ankHq8fDympPW7nVAHRdyqIBx3XSVzXzYXW1bIqQEy6ceHXHmwaatvrZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g55P4XXe; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928989e272so472672137.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722228752; x=1722833552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofiyx5F0hQVYQXdxJr8h0U/CqHEl0NlaMiB507KxBTo=;
        b=g55P4XXesiKqjJgZLlRcDxu2rtVGg+pSMH0mXGhrXtpAlLInmoBWTxQVBZtyU3xNsf
         IzQxYjtrhMi6Ejx4VMkyTWLm1wfygnxrXK+rU9TQ0bwekVdZzYXQbcpOrk6m41/tRBrh
         FvkPSCHMx7yRtq6lbA1zfXm/LQAiSdED5KX57Q4TfsEvUm+f4Gb3dKjZ6xXd0p3fuEVe
         ioj18Pq6a4nue5as9hfaYA86mLE1j0M4MdkNv1Ye4ipqg3anwNaOg/CRBzRWCMLxTMlu
         nV9m699g698SC6aqqmwRu4US9CP64VSIeifeGkCMcwQ1gVB316hMwjwpiTAPyiNQ/Y9q
         5E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228752; x=1722833552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofiyx5F0hQVYQXdxJr8h0U/CqHEl0NlaMiB507KxBTo=;
        b=MVfgk1DMi9LpgcD8iExIrPeXoqBt4pnZyZ8bkTvKGMzhpO4m/6kdjFNHX0EpPefQ7Q
         rprafwZntKyMW+6SqVCL1cr1N/idCeriaUn6ckPksb+nID4uJy0b29GTxbd8CpY2Po5e
         /i+lk8Cud4TeLm38sRcGuR5xU1rfPF8r/tUPk80E92dcJjVALfHQCUFhEpwb+4kAzDVS
         eLLNePnEme+8OVGdzPzzce0yAgz4XoKwQ+/rJRzeKhjoNqWdqP5JDkYiQlZaHwCHbQVz
         MNTCn+32eDwGue4GAs18P4dzLf7klpsgmWHB2cN70JuKiIqZuVinGXxsid1A+P6oNDiT
         +ikg==
X-Forwarded-Encrypted: i=1; AJvYcCW4hl9Sid+z6gi3N2PCc7PI6OUSt4WuxzasucS8Yaqp2I20xPRRfVUwo21rBaGBVNkrxIovx/PQShw/idthndJiEzM2JcAe1EBrAiFl
X-Gm-Message-State: AOJu0Yx2fu4RcYn2YKfLYrnQnh8OlYVdCZcW8K8tv0rMtGlGZ/T6EsEh
	NW3vKBwQqPvF0Zt0SAEoEom0nqD0ERTKj6XeWQc8j973zpFUqcRfFEoq8o9wCntour/+McnNhYY
	bKOwks1Jgui0NYVBaWQBpR/2B/bc=
X-Google-Smtp-Source: AGHT+IHQsxFo1QG7juCbJBdv3znU8kGo5WoeRRqZ+fNAtYje2XFef5zWQusAXpIMuMtzU3QjpRQJvth37+2A76m5caQ=
X-Received: by 2002:a05:6102:32c5:b0:493:bf46:7f00 with SMTP id
 ada2fe7eead31-493fa61bdf0mr6994008137.5.1722228751920; Sun, 28 Jul 2024
 21:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkbho1a6pwZq82aHBa8BpXijqVopde3k-RnageOtdO32pw@mail.gmail.com>
 <20240729020222.36389-1-21cnbao@gmail.com> <ZqcP6ucX6yHA0l9i@casper.infradead.org>
In-Reply-To: <ZqcP6ucX6yHA0l9i@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 16:52:21 +1200
Message-ID: <CAGsJ_4xXMhEV8cDXzSpi0yJ64S7B9F+=hHsnQwz5-k-HsG=qtQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: Introduce mem_cgroup_swapin_uncharge_swap_nr()
 helper for large folios swap-in
To: Matthew Wilcox <willy@infradead.org>
Cc: yosryahmed@google.com, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:43=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Jul 29, 2024 at 02:02:22PM +1200, Barry Song wrote:
> > -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> > +
> > +void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, unsigned in=
t nr_pages);
> [...]
> > +static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> > +{
> > +     mem_cgroup_swapin_uncharge_swap_nr(entry, 1);
> > +}
>
> There are only two callers of mem_cgroup_swapin_uncharge_swap!  Just
> add an argument to mem_cgroup_swapin_uncharge_swap() and change the two
> callers.  It would be _less_ code than this extra wrapper, and certainly
> less confusing.

sounds good to me. I can totally drop this wrapper -
mem_cgroup_swapin_uncharge_swap()
in v6.

Thanks
Barry

