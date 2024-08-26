Return-Path: <linux-kernel+bounces-302084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D895F99F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DAE1F21046
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1211990A7;
	Mon, 26 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lrc+uev0"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1980034
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700277; cv=none; b=lr/OpkVlg68x5egoe0ujM6xgTwzkxHQpzTXgnVZT3qQGGPr8fnspTtShq5A5q5Vy5XW4sUU7WasVGM5dCmt9r/uv+W/cj+D/IcEXZv8qx7TcddAUJFeF6iOsAKnx8kYaymfZ+wFvf1V0N6KS0ckNfBqwSIj3qbYBq4F6uKrSx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700277; c=relaxed/simple;
	bh=iLVCxBE7eTfwj8ncMZ1E4YQjRMItTW30tjdhn2aqe4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsZKdRVfLtjc9qDsh6MXYY5NzZmbtoTdk3M3H10row8r3fjDqdtqqAVC+qVNlCabXpvSa3JYvQz5KXxG9T3yMYW/K7moAM1A3kGyPxBBX4DJqYzaW6DZFsw0r3OoJ6ta3Gm9uXbjp7bQraY3YL9uPyLV0lUh4d/pHSFp7OenCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lrc+uev0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b6b9867f81so39316207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724700275; x=1725305075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pdl8rAPODNH1DYUiul4n7cS3RmcHlTUnkI9dMlMOkk8=;
        b=lrc+uev0H6o9HFwuznDWtj44djUGQlDLVncqoDWvy9nWZfoFabdRoQZBqz3QfwmSdt
         MIq6pOTpjaqfvvTEM5/+KrWzXoap9KGUkEYYz4BLTMac+m/UG242yRwmPD0x+ZoaZN3U
         pNY3oeeLu/Er69Jt0Nks0CgGD9x69z86Iai8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700275; x=1725305075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdl8rAPODNH1DYUiul4n7cS3RmcHlTUnkI9dMlMOkk8=;
        b=aFc6jqVVWO5F/Qr1o4s6SQWzOidgLfpZykdJgufz15D7BX2c4ms5nE56n+ZoHWrInn
         XEbfw/Jc1JqFKc3ps0mncsNoGmaLRZ4an053Pl4jh0mtty5Eyn/E4Zqrv7wteFKlGVFW
         z90OEB6q+3sslLE7lgO5/PfNShyHTgD7q3QxIwpIrFUOBSt+J/kCYANFMdQ+l28j/nJx
         APNAYFhuPTR7fEQaY+vEDOAkmnpFP2Z1v5xhdZ0PNdjzFG1gprQjDQN6IgVL/EXlaphv
         vmswEYiuQeWh1InWkCqB4kLurVUt15iJJ2kXdOJYDIh+GVsxptB2a6/MRe2UU1uBsp/P
         dYWA==
X-Forwarded-Encrypted: i=1; AJvYcCUu7c2senukQ6MnyoDt/3bZbIJwav+7qwqXF8OTaMMns5vckzhkYWGgTEMXE3HK9/tRrVfnuAp3BGDpaD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3u5TAM1AlfO3GULzJvjNxNbs7WnjNBAOp6Z3jxNMnnRZcVx2
	LKh4eNWqfPHJNUgSiIOCv+y/GtA6yPUoWEFF4jV3sZGk8nEoaHZWPOizKwvuMkede/va6GeKHsF
	7dQB1LFU/LWUejqaiHQASA21muop2TjBRNck3lw==
X-Google-Smtp-Source: AGHT+IHNK95lz7RoP/iiwKLhCzvfsqOhNa34m6ooBrxcZ4bZDzpwzVUsRqAmYcqldo8byzdXXEPDx3ROFcEFWTWWuL8=
X-Received: by 2002:a05:690c:fcb:b0:65f:d27d:3f6a with SMTP id
 00721157ae682-6c6249dd335mr126663547b3.7.1724700275110; Mon, 26 Aug 2024
 12:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824092553.730338-1-yangyun50@huawei.com> <20240824092553.730338-2-yangyun50@huawei.com>
In-Reply-To: <20240824092553.730338-2-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 21:24:22 +0200
Message-ID: <CAJfpegsFvE-oSaYqNWBAdiXnBYWGAp+Lc8cjL3BWs9bd+O_c2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: move fuse_forget_link allocation inside fuse_queue_forget()
To: yangyun <yangyun50@huawei.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 11:26, yangyun <yangyun50@huawei.com> wrote:
>
> The `struct fuse_forget_link` is allocated outside `fuse_queue_forget()`
> before this patch. This requires the allocation in advance. In some
> cases, this struct is not needed but allocated, which contributes to
> memory usage and performance degradation. Besides, this messes up the
> code to some extent. So move the `fuse_forget_link` allocation inside
> fuse_queue_forget with __GFP_NOFAIL.
>
> `fuse_force_forget()` is used by `readdirplus` before this patch for
> the reason that we do not know how many 'fuse_forget_link' structures
> will be allocated in advance when error happens. After this patch, this
> function is not needed any more and can be removed. By this way, all
> FUSE_FORGET requests are sent by using `fuse_queue_forget()` function as
> e.g. virtiofs handles them differently from regular requests.

The patch is nice and clean.  However, I'm a bit worried about the
inode eviction path, which can be triggered from memory reclaim.
Allocating a small structure shouldn't be an issue, yet I feel that
the old way of preallocating it on inode creation should be better.

What do you think?

Thanks,
Miklos

