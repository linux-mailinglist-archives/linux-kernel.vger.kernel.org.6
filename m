Return-Path: <linux-kernel+bounces-294264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7C958B61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148AE1C21F54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E519408E;
	Tue, 20 Aug 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="COT6fnp1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1043179
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167937; cv=none; b=uU0skTfCRNhrjfFXZr2m0XzAN/QgIy4UWG2ZUZMxtb9NB05oQRRJXAoCavntAt50Zyd/+dW4YgZLeFtZyDCMpB/x71INWFb0B79bSu7LRR2f8BCqjiofOR2LtbhcRUjtGjey7Gnpvb/vkGCT9dDsWWNdkjDjvhnFpipKVx4lCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167937; c=relaxed/simple;
	bh=MiDlbS6ff17tWH6m3MZ6F9tz3FBlacdmGvTetKNSYdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO1X5KITgdJs110TxxWWovcdGJPrXBonlbhd/egWlQR8y8xDSTO+re578YP0XzxfNbIB9eu6N+3qXfrUvs3zAoGBvfxa1gVkjZQwJsArEwzoPHAWTq/ebxFbqEhHtN67gmAOfxBQnbqTUZDKBD25dL6ONCOBlAK8t7IzCsMJzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=COT6fnp1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso561509566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724167933; x=1724772733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=COT6fnp1ekSFW+XCZTP8q/YUcMrcw8vRiYP6n4uEYR/QQ4cNRyqr6M6+eCs3LUMlzq
         UWyTcLOxre/G3yRBkqGj9EJwYpMfaTDYJOFogsapglakMtNidWVKeBoihAIYq6/kN/Q/
         TJs/2l0sVmHJGHyGljcTgLjFuyhyQfwKp2gLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167933; x=1724772733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=By3s+lM/nkCjkU68O8icoxziU2qtSpPXAmPvzGSItWMccFjteEBT5MNRIUbW06SsPL
         r1D4rKlVKP+UEN4gbY/ISXaNBYSQSTPi3Bx94t/4zBHsKUdDcgTvE+yR/RDxQ5AlokaV
         GORhM4N8mYD6y81UG4x3x5+aW3xbZbwnIEIUSkAGb6a8EKaLvOkv+X/sKY18+0xjfYXm
         qAK/yUrjFYPSfMJ7+DJASz0t1soK7ESMaFW1HzJVHf+iorJL+T5+Jcap6cXeH2Zkxzmr
         AeSilQilylEeT6iAUqY4upHKiw5j65GwLuxGCYR4mPEkTyGapmD9ZyD124l4cM/mM2lk
         eA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV56kJNRtQAp0rNU22ivD+mz6G4JpxHn2H/mYBTnKRYjhMcfL8v58oJFyDYRbQDaFvRiq67YhhiasKFcBUOQmpLD7ay68HQKNdMm5Wx
X-Gm-Message-State: AOJu0YyvdrLCQmHoTz1/0Z3TZKOpp9m6wJbXmLPDWIFV1ArU2Rrs3YV4
	hCCfVVxzGnknqFnl5IlDgZ2k5hVWStF5syrdFhv9l3+g+/BpaL4ybiatPHnwCyd8LIOksWm/xKc
	XKA+RYw==
X-Google-Smtp-Source: AGHT+IE+pu1g+DM1cShbWVHikJuUCJVxUSGK9OmhQ2zKu4MiVMljTD0Am94bzhGNb9dJ6DFk9lsVJw==
X-Received: by 2002:a17:907:944a:b0:a77:abe5:5f47 with SMTP id a640c23a62f3a-a8392a4971amr923067166b.63.1724167933142;
        Tue, 20 Aug 2024 08:32:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947187sm770173266b.166.2024.08.20.08.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so4749702a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJmzOw5/oc7ufOFzViqGvZi1hiwF7jzN7ChQccSNiowNqanxG/+PZziI51kJ8MPXMNLhVSuZDVeIeorT4UGo0+LyhjYu+8rxjlAwAc
X-Received: by 2002:a05:6402:2710:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-5beca5c5750mr8152922a12.19.1724167931490; Tue, 20 Aug 2024
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <87y14rso9o.fsf@mail.lhotse>
In-Reply-To: <87y14rso9o.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 08:31:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > +static struct vm_special_mapping vdso_mapping = {
> > +     .name = "[vdso]",
> > +     .pages = syscall_pages;
>                               ^
>                               should be ,

Ack. Changed here locally. But I assume you also don't actually test sh...

It would be good to get acks from the architectures that still used
the legacy interface.

              Linus

