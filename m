Return-Path: <linux-kernel+bounces-374128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B939A6489
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85302281016
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4E1E1C19;
	Mon, 21 Oct 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AM0IwWyk"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60851F4FD1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507342; cv=none; b=ty04nPxxIktE2xF+f+rITvRE46W8z6cBdFsaI43yE84nXIFCQvoZ7IxB6qSKave7HD5QiZ05plXUREAZWH4XCWsjkQAEC/bx9lxFJK1i27HBnR3bKhwsMr0m8TQHFtsN5YhY7mDM6E7tyhzAlH+UJ9Z3ZFsgxXYAYYzSKqtclFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507342; c=relaxed/simple;
	bh=lGlERMYtz5SnLQLwOGVAIXCz87xRgIubq9/dH5MFKxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFO3eulItkFg/HmEX53nT32gMW1cPiyJOll6h8b3+QMjHNwsENKsOw44EKsGftIQKBFaLzH8E3ujcg6WkHG2TdYlG4xn5FSRs8T62uI6OtD8FnFKHVUzdWaG0iRQwuFkcL63StwIdfc+AvE42xFxBFD9t1OBoa80TAcABdpj3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AM0IwWyk; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a46eeb84a0so956787137.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729507338; x=1730112138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CROML7dAJaONpnsbzUaZW2t8Il+NSf2ScEsMHxaPnXE=;
        b=AM0IwWyk5Bi7vP/FjK+dBxt8SOPiE89M5zrMMuwzTnxgjNLiW3qfx20BvKPOGIFJM4
         fmcxeB7W2xkyXLyHUyrPmxdf/6RBQTly2vyYuBuh2M290XkxlDG5/bbtjbeeI+pgRBPr
         /i2/qXDeDq7+2FKZlnyLB8lraasiOwXoxsoy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507338; x=1730112138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CROML7dAJaONpnsbzUaZW2t8Il+NSf2ScEsMHxaPnXE=;
        b=duWz0qNL5kw7ctyjQ0wxIfEkwNERZQL397KY+Ory4Ng+7t3u3rXRVcUwHpZ49tH9/n
         bqlS2DIvlKB722BD8Subhvlyw6FYc6FKmCwf49gpFAwWc76eq6OUXfl1z6iIJZ5nDZ4J
         KTQs55J02rMqd+yY8jhcx3EQZRZZTGmFF4TMKWGlE7xwAc5dE2YWEkgiGIGa3YmniPQk
         ip/wVBwjtAcvjmjV08DYjb+NR21vRmuR3oBKMEh+C02AF/rXDrbvhJv8pA0OZt5EyR6A
         dPi4OyyIYu3qM1WYlSieM1Me/ue4+JHkG+mW6OJyi2beUL8+NeS+cbyPa7gJBgvt3IS2
         8ofQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYr4B62pgugjWNY5htIHSuBoEb0lxGLcjYELgwzvLY0xgcqnzF3w/t12QpmRAHmmtjkda0Poq6r7uir7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CS+qIBr4xoY3/aoVNSkWd1NNpmLJTrqabRl+9BMdUvFqzZE1
	4lV4aAjUecHGvYRpsPe7pA2mwE3bLKMT6vrOw4Cos7SB/Fit3PTXf0pv8+Wpnp1QkbU4O3Z1RuR
	2TGdq6BdscFLUExp/g0fEFGhnsMfIMpifL0XdLw==
X-Google-Smtp-Source: AGHT+IF1Ku/Or8mDvMjmkzrfK8UuA03VpibHFZYdfjhYwkRLLhL+F0cs6ozQJUKX5mt29gqDjdXeNaCFn3JIdUBJ4NM=
X-Received: by 2002:a05:6102:3a0d:b0:4a4:950a:cb1f with SMTP id
 ada2fe7eead31-4a5d6bb2175mr8957269137.22.1729507338663; Mon, 21 Oct 2024
 03:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
 <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
 <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com> <CAJnrk1aQwfvb51wQ5rUSf9N8j1hArTFeSkHqC_3T-mU6_BCD=A@mail.gmail.com>
In-Reply-To: <CAJnrk1aQwfvb51wQ5rUSf9N8j1hArTFeSkHqC_3T-mU6_BCD=A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Oct 2024 12:42:07 +0200
Message-ID: <CAJfpegsKbt=r+aY57cuSwyBe090aJQ6gh2eZ=o_Bo1PxrHyXwQ@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 20:13, Joanne Koong <joannelkoong@gmail.com> wrote:

> I guess we don't run into this warning in the original code because if
> there are no dirty pages, write_cache_pages() calls into
> folio_prepare_writeback() which skips the folio if it's not dirty.

Added the revert to fuse.git#for-next.  Hopefully the syzbot reports
will go away.

Thanks,
Miklos

