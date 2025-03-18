Return-Path: <linux-kernel+bounces-566607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6DA67A65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7CB1892C54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9F2116FD;
	Tue, 18 Mar 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WxDOqFmX"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A25211706
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317750; cv=none; b=k8FeMB1+fnMJcpbXC8lRAM7WGinSEkrRciVpMaevA/bs+GPrWOcZDvphYXhIdxn1TyXASAL7FaV9bloBnlDJqRXW6lTQaDeUe8K+RbvQvRFWLi4y5AYhEm+psxnHE8EOkaGLIxj9aIKpCu4lp3xz5It5Ig4Kza9fB+TnxmNivTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317750; c=relaxed/simple;
	bh=CAxoJk2xCi5CTk1lZ3Alo6w3Yn1tmpQzUqJJijSViS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIlCNadBipOv6DXuQMPjicygqLNMXz30mMXMl4GcTe6mhCzfy+hT+ADDPFG+lCdoRGRITgB40OQ8c9IEvv7VbupyA/GZMjnEMbYFgjIBHIyz6azD8rRQC+APxuMMXWvTdDaTCGvoRZgDJ1ffZiLzVuUVY64hZKyVwhkIeiWG4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WxDOqFmX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so9382800a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742317746; x=1742922546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAxoJk2xCi5CTk1lZ3Alo6w3Yn1tmpQzUqJJijSViS4=;
        b=WxDOqFmXfgCMh0vccPpJRju2JEz2wTPuwuZYj6XvHAZZ6dTapmdXFfknJeROKctZ5n
         uzTXW8vzskZWPTnXYfsEGXk0x++ESF1zzEcP/n8ohkZB728aGJoa2TJBwK0bQoDHoF5Y
         01U1Tt8t5ogJZ7LqSrfoqfaXUKgCIl+QnfizQfmzHqvTXSI6DBLDQD/AU92b3Vyglggl
         6LsT8F694pJcdsOqivkcxjrXqFmjimPuLF0z10psGyB0tFFPnOhVUeO68jdgXi7K/S0d
         2YVpKvr/op+RhC4o0jumQfN6suYn+y8SmikePMJgF9YcY0n78GpSUxGBmIN3N4wpD7OF
         7hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317746; x=1742922546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAxoJk2xCi5CTk1lZ3Alo6w3Yn1tmpQzUqJJijSViS4=;
        b=lCmMX9tLMNMbLD1epw1wDPAV+rxL+k5oaopp8J1oIgxH1dBNo70fRQhjcClRdzkNI+
         d2ZcC3JvNLvF/WHKas+JAZ+hYBPkVbgFOVgFiVrLJM2oRkhNvjdRzHb+byVcsNl8jV9F
         lwCvx/Heoy2uTLuEV4EvSvadMREP3ycqyzMD67oc3BMyxKmAH6lURwJhMeHskCiGkf7I
         bvW624AmoKjDeQmSRxvWJ3yr4MsgMLL9Ql//UyvqjZxWpKw7MlwrD2Wagh2epdatzb4w
         38IiojiIylEZQfUY3HD+HJx0qGDemkwerYPg1ZPd1GzyBGtYanjAcQuMvf3zpJbh7vtq
         x5dg==
X-Forwarded-Encrypted: i=1; AJvYcCWw6BsMLCjNvDkIpI3db/D0tmaqiFZ7X3qSvMSCzWagFC5L7fNEYsw1PsYp7gSkwG2qV2HrFO7uwzGdvB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEl8xXGlZqbGwz0ZDe4Ztwdd++Bat1cif6w8pyei68Su7X/qqW
	BIxhpkzLhxlA63YSv4/tPEOO+A4jyBgdWb/bGw3ft3zPmhX3nP48WTfqYvgRzpcw+5SEtk1Vi4W
	txPVbx+aXQ77hDk9KMLJ+X3uYyb8b8YmvFNJKxg==
X-Gm-Gg: ASbGnctcOm+E5oUe573btqppojMTzwJLWqMxpz5ekRpAMcdti6yMPe3fW9DxPgnVrWQ
	PHPltLOSoOqf2PPbGNNm1KHFaiZbg7fshjlwn+FrnOIFZE4nVBY0LGVOa5jYSEpmd6gmqvJXj6N
	bGv4tcIHMNu8svzHAXFUDrF2jd
X-Google-Smtp-Source: AGHT+IEEE4RO4zxyBDmckkd6f9or8rKj9TXQLrHcqQviLBK7W0Oe2j/6oojFAHxmk/xtfTMTEVD0WGofjXbmcw2RyW0=
X-Received: by 2002:a17:907:3f9f:b0:ab7:6606:a8b9 with SMTP id
 a640c23a62f3a-ac3303f75c6mr1674914066b.42.1742317746360; Tue, 18 Mar 2025
 10:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095440.436685-1-neelx@suse.com> <20250318160017.GF32661@twin.jikos.cz>
 <20250318160455.GG32661@suse.cz>
In-Reply-To: <20250318160455.GG32661@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Mar 2025 18:08:55 +0100
X-Gm-Features: AQ5f1JqqSv82jC7_LCZF3NyEczZ0RsY_HF3x69S70Z3MmkNC9LCcRx-Ofq9Jm2I
Message-ID: <CAPjX3FfCw3E68XA+XT7rfW+fdUnfaTDMT2sH3_EjNep7hYYD5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 17:04, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Mar 18, 2025 at 05:00:17PM +0100, David Sterba wrote:
> > On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> > > This flag is set after inserting the eb to the buffer tree and cleared on
> > > it's removal. But it does not bring any added value. Just kill it for good.
> >
> > I na similar way the flag EXTENT_BUFFER_READ_ERR is unused (was removed
> > in eb/io rework in 046b562b20a5cf ("btrfs: use a separate end_io handler
> > for read_extent_buffer").
>
> And EXTENT_BUFFER_READAHEAD, removed by f26c9238602856 ("btrfs: remove
> reada infrastructure").

I see. I can have a look into further cleanup later. I was not
checking any other flags yet as that's unrelated to my issue.

The full story is I'm chasing an eb refcount issue on downstream v6.4
running on aarch64 with 64k pages. First I suspected it's due to this
flag racing (only setting the flag after inserting a newly allocated
eb into the tree but without holding the eb->refs_lock) but after a
bit of hammering I managed to reproduce the soft lockup even with this
patch applied.

That will need to be solved downstream. Still this looks like a worthy cleanup.

