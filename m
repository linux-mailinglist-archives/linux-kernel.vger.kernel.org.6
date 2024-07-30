Return-Path: <linux-kernel+bounces-267139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A9940D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C20B24C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F17194AD4;
	Tue, 30 Jul 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9HKFAey"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD4194ACA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331129; cv=none; b=PyMUuKQEyLErQhh7K9v4x0D5OfdQAZzSXgKJpNtMTKk5dVQKkKQhpm/6xJlSx+KoedMr4lh4Oj2EZrIqi2Ar9aiTHsjz4Lbi/JJ+/umpmafkgL5i0RIBlGDj664aREGiLVHizwN4DYHgGw824zJN2GNPizk8TGHRwXi/bHVuKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331129; c=relaxed/simple;
	bh=iWvOG0BLGI8jgof9d72BuBIQuV8Y83H+sNJPopZ1fNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZAlveguVHq9eyRdgDM28lhJ+cGo6P5EyUqiRTuqL/1V7iEKk1FPe01P+uPyRoMVWjDqEXzaZvRIyJgafinlQ6+R0uk8dKEOLisAjdenp8DHj6Hjq3h8UC1F8xbcwmA4LNsXbux702TNZtIDv3OJpaV1wwwZH2CjiFqksJfKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9HKFAey; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so6909879a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722331125; x=1722935925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jctJvtv+1IaigDF/1bjmDqE3F2Ur/iKYxs0PGsWgibI=;
        b=d9HKFAey7VuH/f5xYdkxamq2lRH/ekNOkd6Nu73A1Kbg0m98Aoyq1IxfF4PtkT62rp
         bNCEjddNHXkzJLfGm8OJ9LaWQnjKkBbXHIQ/ikHQRMnZePd5EI6pMkNvMsqkMtiMrZys
         QS9EFFtnuTmBtQPVmQtCuCjXBsnz9WffTrE9Zb6wohvy60+kRyWAubX0PDm0ElUl9AB8
         I3H/y2HJjWO9gi14l/1zotAUeWpJ5GnU0d0bHRBK2Xs0fvWkNhDs64qMD7Ek1DREWerm
         7wLSh5RY8Vv/kKsktrIR4qG2n0bW2gSEHMuiijhC8clc4E0BAu6QCpa4WUz2Cdzn3Kea
         s60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331125; x=1722935925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jctJvtv+1IaigDF/1bjmDqE3F2Ur/iKYxs0PGsWgibI=;
        b=HOhFxuX8oV8FwYlhEHhMS9bNr7OTLRlnS2y78/TmnEnsCDoJKv6litUY0IcdPdFx7k
         1QbcSlI7fzA30cc5fxy0usGjn/WTa9is6Cv1S0F/tyevpww8Vjukv275SdiXZVR1bIVX
         8zz3CFbrj6ZsGHgWRb79StiU2nFvUVigFKpGUUqPKXkGP94XC47VfL1QYN9XgZyq1Xrx
         Tb/6jZ/pK9h9+TOYs0l9QkJXJNPbTeHqfbbt8810BijkPD7YGQmYJqNHUt5/2G4hLBZb
         qb+3nqYkl1rfJljfXt6luA2HJFAn/vbUfCxEcEiQR+KIjk50Y5cWp19w6qQyJWSIU5Fd
         3sng==
X-Forwarded-Encrypted: i=1; AJvYcCVO65GtW4Q2Y4d/cOyXwps46QybYUH7TSjsbXVD3TabtroXRh31Yb1vcunHpQes0a3eyfZMZqaKhTqEeTPEPIyk0XohxBWls7mlFB1k
X-Gm-Message-State: AOJu0YzloN1stN/bocveQ7TiX0XnidTPXCTn7ZBvIHLo35cwWe/eDpnr
	NGUyER2vfdEHfBpclAuYm26x6hmdAnahCEJJGug2XftjgEOsL4//
X-Google-Smtp-Source: AGHT+IFZf1pqfFnaNvhVBcURD1HU8uxwWAd/zV+FPQ+Eo1Fl1XkihsI1ZDPmE3muZ7BSaujFltAOng==
X-Received: by 2002:a50:cd05:0:b0:5a2:efe4:262d with SMTP id 4fb4d7f45d1cf-5b020bbddbemr5384188a12.21.1722331124360;
        Tue, 30 Jul 2024 02:18:44 -0700 (PDT)
Received: from andrea ([151.76.3.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af959990c9sm5495745a12.47.2024.07.30.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:18:43 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:18:40 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] tools: Add barrier implementations for riscv
Message-ID: <Zqiv8EEKYr5lnlHl@andrea>
References: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>

On Mon, Jul 29, 2024 at 01:50:34PM -0700, Charlie Jenkins wrote:
> Add support for riscv specific barrier implementations to the tools
> tree, so that fence instructions can be emitted for synchronization.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Charlie Jenkins (2):
>       tools: Add riscv barrier implementation
>       tools: Optimize ring buffer for riscv

LGTM.  For the series,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

