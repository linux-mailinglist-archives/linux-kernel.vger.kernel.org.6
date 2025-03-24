Return-Path: <linux-kernel+bounces-574004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6852A6DF76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A541894CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5D1263C7B;
	Mon, 24 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwJ6RZP/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362A2638B2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833244; cv=none; b=FxVtlVmt+TTRC+y+XNh2TZqITUbZLjehzTNxB6EcfqkFcFYRcXNs974AaeONulyw0bUGGx5sfXToaLUh34IsrH2lI8UnlzX25uRTUcwaMYEfPUbADJW10jABJbAxko3axIYSMs+Bsb5+RpfCBayjBB40qL/EXm8RJGdbzPUeXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833244; c=relaxed/simple;
	bh=QEMyyGsi6pKVdO1NZX06aqp/5WGNOG/kiMBDZvItNyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5Pj61mmeSWU4zVSdyZBiaEe+reaquFaIJiZq+QYOOdgKucufKWz1T/40QmeWksDpqzaBqw/T6NhyyDBxjzsIEqVJwTK752+bC8JYEGyZz+0RaX7InKqj9UWcXPdie+CtH8alZQJjuFZhvXp1Jl85gnsNpFHaNCuvgO85NqA/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZwJ6RZP/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2aeada833so858488266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742833241; x=1743438041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvYPLpIx/vsSMNptY5I/a8vTPmXkTJh7cHFovrjH+zs=;
        b=ZwJ6RZP//we7OiBrbt0k6+LxpikEZvO5AMbM6H633EwfirkyajUD2n1q9uhMsD8n7u
         jRlrjfh9ycqQM0iLHoHK77Wv22egrF2JcjyHXPczozorDR4k5ZxoEZPq3zK7iIWUDT++
         lVr+xn2GJIHc8Wf2S/Nb/vKHTgJGN7RwnVM5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833241; x=1743438041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvYPLpIx/vsSMNptY5I/a8vTPmXkTJh7cHFovrjH+zs=;
        b=m7hYVSu7phBfrtetVm5ruoNCN/etFuv4WavDZv4jBguuxRbBixSPp3g04M0xEEvQ0n
         UmVcODGHWrGMBnRysGoMzBF9v8vKjPenrV5ox+lPThfRKi5i+oQbPghhI/k2Q7pdKz8S
         rK1twwFb0oBAUbKYRt39Zh5I17xVSFllwbWZvxyw4YMZdaAsT10jXfB5x7OrI6yhi3kY
         sF5QlbWzLxYHjbdnqcYxqCyM4Wj3TBhKQ0QS+t75Un4il/j16u+cE47yF2fITUfvoxKy
         LpmOyoMbbA14X1Z07A7j+s7OjCqCgHsZf17VuMYlEnxo1oXfAHyZaZeFRfdptnX03A37
         NapA==
X-Forwarded-Encrypted: i=1; AJvYcCU6AC9kFzChxtPn78BayzgC2DloXP82wkOzhNAuVP528m/L76C5zhx6YBuHMf0Qi9QxnPXlnLOiNW1pJhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PDy5tidnNcsMA0qRrT4OR8z48BBjRgu3oU/Mh1xkBg43VBPV
	PwxKqQEi2IB2GeitRD5wN/HpXqehu6QXQZ6qXGpAKBQcjMg3Nk8iJPqmWFn20ntSK83dZ4bP27T
	EJQI=
X-Gm-Gg: ASbGncsGwX438pVogbFmuszTVwe+5jOv73Qe5R0wCx+ETd3PvEEAlpKZyXGvLSvkwvA
	ErvT3TR2Qo1pFYQ0SSzOCdXqXdnPOiUC26RgR6r5SdMIkk/E0lDcb6GitwJlaD0Bd6KYBj6De7t
	LZlZKiJapJXTsNsyv82XmuXfvn5nwgWR+fX8/3R6Vby8EtDMb6cBQdCKVvFtw2eMU1locBHFiSQ
	Z9j9wJYh/B+uoETVUHY8KvBxI8yqdwr1KzM1V9AYDjgfyvTcOBPa4AkkSHZu3jCGUaRip8rtPCq
	0CZVD+QBM4bwR4GOhH3kMhGF2Yg8O4d2Xgjug3OF2MimfhMf+IT3axhNkSqCztbAAwBCH2tMgwS
	4Ts0V/R6I08KVwbD/29k=
X-Google-Smtp-Source: AGHT+IHJCL3M31Oy4HOUwOK6GI7CCSrUzO+JTxgS96k0g/B7FFZ61CHNZQlNo7G0vBUU81QHuyxgWg==
X-Received: by 2002:a17:907:9708:b0:abf:24f8:cc1e with SMTP id a640c23a62f3a-ac3cdb2ab88mr1506872666b.2.1742833240887;
        Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d39cbsm699989166b.38.2025.03.24.09.20.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac297cbe017so1010526466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTWxndcIL7vZuAXIb7euqfA3X+0TrEaeW+zE58vD+CEEnytpUofCuF2sgorV/VyevIhUWa0oxgrfWHUf8=@vger.kernel.org
X-Received: by 2002:a17:907:c23:b0:ac1:edc5:d73b with SMTP id
 a640c23a62f3a-ac3cdb96185mr1669224866b.8.1742833239650; Mon, 24 Mar 2025
 09:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-vfs-misc-77bd9633b854@brauner>
In-Reply-To: <20250321-vfs-misc-77bd9633b854@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Mar 2025 09:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
X-Gm-Features: AQ5f1JowOKwVmnN0rwQkJkZQnbuG77xhgomiTzUPj4v6fu6nQxCSbS6hjKowXAw
Message-ID: <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
Subject: Re: [GIT PULL] vfs misc
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 03:13, Christian Brauner <brauner@kernel.org> wrote:
>
> Merge conflicts with mainline
> =============================
>
> This contains a minor merge conflict for include/linux/fs.h.

Hmm. My resolution here was to just take the plain VFS_WARN_ON_INODE()
side, which basically drops commit 37d11cfc6360 ("vfs: sanity check
the length passed to inode_set_cached_link()") entirely, because that
one had a "TODO" that implies it's now replaced by the new
VFS_WARN_ON_INODE() interface.

This is just a note to make sure that if anybody was expecting
something else, you can now speak up and say "can you please do X".

Or, better yet, send a patch.

                Linus

