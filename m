Return-Path: <linux-kernel+bounces-523722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F11A3DA66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593D217F299
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20931F5430;
	Thu, 20 Feb 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidfrank-ch.20230601.gappssmtp.com header.i=@davidfrank-ch.20230601.gappssmtp.com header.b="JeaOCe31"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2881F150F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055737; cv=none; b=owG02N/Y87sl9qOb11StXrLzGajBlBPv44bAk+nGiRMQdqbzqjOZpafeWMzeVC9pixYP80EibhIQggQT77U1Fj9kNibWTtxWey43oxGEb0WtJu+vhca3GxTuc+Mwhe4pwhseutTAMSpzfS+o54XJkYOyDuoOzoyOkwYZrBMDefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055737; c=relaxed/simple;
	bh=6n61EcdJ0K6iGjFZLmdgYD9Vo0NijsSP6ktV5oHZs2c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Tsu+j0QXlQpST1BBTHWR1kq0KXxvRfxn+5Gjb3K7scln1J0tDNQOhsgqCV22qu96luoykzbbCrvnKSsrrTBEC9LGLyZUP0hNNcIjw+LEaDMGiVEyBGBz47X3dQ7xxmcWx3AteyGOp0/v4uLDWP0plzSmYu8ncLj9kSPHXd65B58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidfrank.ch; spf=none smtp.mailfrom=davidfrank.ch; dkim=pass (2048-bit key) header.d=davidfrank-ch.20230601.gappssmtp.com header.i=@davidfrank-ch.20230601.gappssmtp.com header.b=JeaOCe31; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidfrank.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidfrank.ch
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fb2a6360efso6210807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidfrank-ch.20230601.gappssmtp.com; s=20230601; t=1740055734; x=1740660534; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKxSyhj0r8L4FxdqwgDIGIROdko5JdS3mVV6x3uzZL0=;
        b=JeaOCe31F15mB4/l8kdbp2JB+aEHZO001o7JZmk1VvuKyh45LJlilN82VHuUJgCBin
         yxCMZVog4keVCZItgWuJ7apBrdTJnE+j7DBBhSaDy6vZ7iIQyeKUHwNS3Bb0/dNBpJwn
         2cwKPeLuRtiKnHH9kxlyJTHUe/TzCQ1GRtD87tt5HfYsavUAADzCG/w8072j9IiSRDqa
         4pkTziNKbW8lEdI2YZUwJkaaBZbK1v4ZDugbFJaEuEZCeXYpQBsrCeVsdIeTL1l7Wz2p
         EYYzTI5HC7Tms80WwjWmqPW9QbBRsutvzac27N3qOcnoIdVcTv5VzkPf8x5vybiTs0Nu
         9obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740055734; x=1740660534;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKxSyhj0r8L4FxdqwgDIGIROdko5JdS3mVV6x3uzZL0=;
        b=P4xyOILGDO4re7vFxVdJV50Mx40ejW03mP5WXyaJWMcgu2Vf0zAlzGo2X5rWCuT6bR
         eDtUWPnAbyQmjXz8CIvw02w5fd96eWyceFXAil3eOrGTfEfnwzN1LXp5JXJZUAi5Radd
         WNQ4PHxbQc31HeOjhbDtTEugcBwuCXwjHBWs1VUcV8Jpl6QxQU2VwcUb0/71GdZzGIsn
         Ja19e8h2OJEo0LDSQp786zpeq93cxxkSSJk7CHpbbTeHjVFzSlPhrC4F9GNG9TL30kZP
         UPquabfqfny0Yd0/dvXjj75suckgolRIrVL3PhzusAWmen7L5YDH1FYIGb5HTz9PpBOH
         21Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWLuNqZNYHdx4iD8tI0+M+MORex3cqzRVPcLb2WnyMV3w134/IYpo/5mVdU+atTNkgOnKllcNeB74niHag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4bMyiYuQmFB0b9SahTSPdpQ67LIOrjoCMPq6wKCjelMSblrh
	36Kvx5GuE9A8HLqhwoNls0qCGLjWz0LQhHQjRtEkJ1XXO3hfUVYL51cJkpvhDGEx+uJ1JpmNAxI
	EYlGHJaz5yt8QJMXauPjVU+AKJZVUN1SIkovu4yi5LP5Ec1fXc+ASng==
X-Gm-Gg: ASbGnctBRZlebQzOVUBmjoBjBu66f6oPSdYhCrRe+xx0Ffc78XCD4TzeakWQAn/UlaU
	NirY3L/K3D7rs1adkEGRaddHLYroej7tzFA81MsuSO3vUgJTsjlBUCbTLNfPnAlnw9FDdVqQvGQ
	==
X-Google-Smtp-Source: AGHT+IF6sUhg1H60bkwB0j9K+QiZP9UeP8lDnzI6ksqOJ8re/sVGcfRrNu3l/MFgaYNwGJuLYWq4mrxuyRD/VEOq35M=
X-Received: by 2002:a05:690c:6809:b0:6f9:a3c6:b2dc with SMTP id
 00721157ae682-6fbbb5f412fmr19353557b3.2.1740055734700; Thu, 20 Feb 2025
 04:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Frank <david@davidfrank.ch>
Date: Thu, 20 Feb 2025 13:48:18 +0100
X-Gm-Features: AWEUYZmQ8373J4A9x9Xcisreel_DSOg7hz5xJHPEonORDnqod_vzotma0fdIevA
Message-ID: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>
Subject: Efficient mapping of sparse file holes to zero-pages
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'd like to efficiently mmap a large sparse file (ext4), 95% of which
is holes. I was unsatisfied with the performance and after profiling,
I found that most of the time is spent in filemap_add_folio and
filemap_alloc_folio - much more than in my algorithm:

 - 97.87% filemap_fault
    - 97.57% do_sync_mmap_readahead
       - page_cache_ra_order
          - 97.28% page_cache_ra_unbounded
             - 40.80% filemap_add_folio
                + 21.93% __filemap_add_folio
                + 8.88% folio_add_lru
                + 7.56% workingset_refault
             + 28.73% filemap_alloc_folio
             + 22.34% read_pages
             + 3.29% xa_load

As a workaround, I started using lseek and SEEK_HOLE+SEEK_DATA and
changed the algorithm to use a static array filled with zeros instead
of reading from the holes. This works ~30x faster, however, it
introduces substantial complexity in the implementation. I was
wondering if mapping holes to zero pages with COW in the kernel is
being considered.

I found [a related thread][1] from early 2022 which mentions mapping
to zero pages for shared memory objects. There seemed to be some
concerns about the complexity, I wonder if it's different for (even
just private/readonly) mmap.

[1]: https://lore.kernel.org/lkml/4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com/T/

Thanks,
David

