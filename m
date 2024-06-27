Return-Path: <linux-kernel+bounces-232758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1E91AE02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487572829F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328219B3D5;
	Thu, 27 Jun 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YuEUPWU2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9219B3CF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509028; cv=none; b=i5XkD4fskd6cR/Eve7omgii/dPUejRGdj1GOIxnv8zYMUTZ8pTLOzVNZp+6x9On43Kophpu8myVGywgok2YTOagkoGLR9j+eutdHaAtSeaUP+lYm2K8nyNbXWenbgSOwCZ+tn/khM3D0p/oR8WooysbWaO8sBd05/tJ1vQZDuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509028; c=relaxed/simple;
	bh=wjRMbyLk5mL2jDe+gW37GdehOSvrgw4JJrEwiDSKAec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFIw9qiigSIn6iH7Eeao1FceoIpmZ+RmZAyNrAMwAnQCkMy23cC0Bj8F9RN7Z7AihfLFRT2a04LQVkYZeeYPdU7HkXcUBvChkXMQOy3RwZ/9JAR1aIJD4P6Zmd/nsthcXn2339cVjCjS4yfH2kmMW8v7sjI2mb8cowDWsILnA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YuEUPWU2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo2064003a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719509025; x=1720113825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QbM8hs4VmoA19X1MK0QBCSUQmi8mmEld0YypFNZYMHU=;
        b=YuEUPWU2Oki0Cc7YwVW+wMYy53y4+gglXcToEl6hsvVQSg0FA04y7yIE0I8ofPHUqc
         hyFWwS0LPmMr8GY61/grcCIvstGeXTYpe8fDX0PQJGvBvSQa9ha1Av8RAEuZHP6fi207
         mV34LgtHPXoSKNfvjx8DsNTye73L5oWu7M9LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509025; x=1720113825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbM8hs4VmoA19X1MK0QBCSUQmi8mmEld0YypFNZYMHU=;
        b=nfwCeq+d2H+0fyTuiky1N8vwKyDS9i3IeJ+JSastEIvPPrEjDT68rRLRdh6MROcc3c
         dTq4dDQ4+jNUuPnf4eVulcXNXzFqD++970g8gu5hLQxLJ9D+/HykOHQZCNKkHj/7Tzm4
         lZspWyg/nBWtZat/k7zMtCc0Pf9Uz+caUCXgaw0D0j0Eqa+30kZhoT/DlDZdysSJ5oCx
         MFrlyaAPCOUEr2KLzzjk7wtTZBTIrOZq965gkA4YZjqSlDAhpSkoGtFTjoPWuAW5RDJD
         77kEHNvbqYwUG/BhxEL3mxH97tAmnrLpVTAfuTfZAzOM5MSJmy9FqPYRzaBOmFL+Rvqh
         qp5A==
X-Forwarded-Encrypted: i=1; AJvYcCVdoM5/HEhJwS/2w7IRyAYkTpUsxMONlFCdRp2iN7KaYfFvyXngmXT4RQ+kzXQLa8A05g9mP5Viq1SVVSz/SG1DAA+zsNBHKNLyxBdF
X-Gm-Message-State: AOJu0Yw6yd1JorAPQmCvvRsMhsZbtfTdFv1VbabbbgVLTB/XMzDkNuLY
	Go38d3UlIUgJT0v/Qe1OsofAcQniHXiQrxMrd6XKpWYONqiQFZkUuPQLR/oJ0cmpISKNYNE1XVG
	cb46cIA==
X-Google-Smtp-Source: AGHT+IHEvkDhO+03TcGIAW34nL5Rwa0ez7tNQTQfHnvBxBDA9xUBIxXYtjF4URvZIulP8XJeNDXp6Q==
X-Received: by 2002:a05:6402:3587:b0:57d:8f6a:802b with SMTP id 4fb4d7f45d1cf-57d8f6a80b7mr8684317a12.8.1719509025332;
        Thu, 27 Jun 2024 10:23:45 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d27817dfsm1123550a12.71.2024.06.27.10.23.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:23:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a728f74c23dso271273566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoKlt3NmpCIIdtQVRdhoDxocymARUhWPHBLLOnkhjvUrp9vGATMVLlhkqwaCek+IGHJbV/6Rcs/D4vXAb75K02GmdPspyQM0fFncZL
X-Received: by 2002:a17:906:7955:b0:a72:98a0:7159 with SMTP id
 a640c23a62f3a-a7298a072damr233670466b.68.1719509024080; Thu, 27 Jun 2024
 10:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
 <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com>
 <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com> <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
In-Reply-To: <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Jun 2024 10:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiz739MaJQdHdK85WbBChKjt7PDavW15saX-NkWYEo0Lg@mail.gmail.com>
Message-ID: <CAHk-=wiz739MaJQdHdK85WbBChKjt7PDavW15saX-NkWYEo0Lg@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 09:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .dput.terminate_walk.path_openat.do_filp_open

Hmm. This may be due to the benchmark being in /proc/net, and
retain_dentry() returning false.

Then the fastpath in fast_dput() won't trigger, and we'll always end
up doing the dentry lock if we're the last user (which presumably we
will be, there's probably not anybody else there?)

                Linus

