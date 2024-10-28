Return-Path: <linux-kernel+bounces-385650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A79B39F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A48A1C21D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A31DF989;
	Mon, 28 Oct 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoUEfHZL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B011DF97C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142367; cv=none; b=gr+0a4KHsAwJtavdM66wNUqraipjKReTe9Gxn2y+6726lBSCPKWukC+kkAL4JgQVq2YkQkwWfbfnZ1twAUTd2o09m2BBIGmRV74zSb6CxTfm/5udVBsd0Q9eUw3eFwPadnZ0CF+dqOGdA7yVyyxOioTNakd8uSOYJFhgqBji+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142367; c=relaxed/simple;
	bh=SUQUIgm5d3IQ7Hq15vLMl/J1OFWIhT2/IVJ53w9Q0Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMAu2T+ZKnCvyS2wsd1yxQ4JJEhD4o0z7wm9tDUk6r+KkdI46BD5loPuBFrGW+hQU27NewRrh2jWokfnngQx8kq1ON5RzgltS8YjWAEBRG0y4Y8HsU/8jRpik2RDvoRJawWht/1w/h5vZpULwGJULt+yyDiMVD2cxBBIQtVVZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AoUEfHZL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so7285427e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730142363; x=1730747163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sUA383ePY3cLN09IzuAP8lfzOlaIkGWSAwBIwcN9qDM=;
        b=AoUEfHZLcrlpZeutkRa/JQ9FxMa1djW0HepxG/wKM7hPK1fHkiy69LJYDXBoe+8OXL
         O1QZZhbhRk4UTZ+r2x2/gw/0GtCCeU2XckGEW1fWudqo0kVPhxpEOVXyLxoacPIa8zk6
         EA1EUoFfbhiXflnwy2zmviGlTfBW21RjPmBDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142363; x=1730747163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUA383ePY3cLN09IzuAP8lfzOlaIkGWSAwBIwcN9qDM=;
        b=AKYYsff8KCG0YJK60IYrfPtIegyqd1MsE6ugH0glmxvO3zD1eAomY2ofLm2HX/tw2g
         wI8jGzcPdjZHZ5RKazu7yYx2TTe6N4pDHnziB64WYcK6QhY7C5S+JhkgDOdxS9M8pXfh
         RvX5+oGKWTnxUlkecO425kwSu2XHcxHyQhZcsf8Fk6YLVTc+1bkxxwdrLMyGHfaraFI1
         /4A0f0gEA0CCko8AgVP+jNBiXckygbPRQxjqcrOrmVNL2iI4lNEWSI5Z92uedOhtXl8V
         8XnnjB/jjv/zrvhsG8MstTbxoEsT+kyV+FBJzQhCst+Q65CqM31Cxsl0qRChfu69P1SB
         RBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVJFcwUBYec/pPPGLJL/M3MtK9J4rr7a/CVQXlBKe/SwGXqGTVdLbkXeT+pL0ckR8eXuTDi6QB6Jp8s+oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWSFj2Q1FnzmhwXOKeSNsSKDM0iAkUfa74IAyddQrMtb0GDMx
	6Kso+F+AUfxThjgefd9qw37RCB4srh5kyqDEEV+3sodzcOu3gYXdFk/0Vv7xQAxqsNlysxfikvh
	AcV4=
X-Google-Smtp-Source: AGHT+IFu17VDghlYKV8xl74LB8yA7y3e+/1ybWGQNssdnFFKObFszPhATvhuWohY5qmpfJaUKLNAgw==
X-Received: by 2002:a05:6512:3053:b0:539:a4ef:6765 with SMTP id 2adb3069b0e04-53b348ba142mr6559880e87.7.1730142362713;
        Mon, 28 Oct 2024 12:06:02 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e124859sm1168807e87.64.2024.10.28.12.06.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 12:06:02 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f2b95775so5448976e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:06:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpyQV0zfTIGUHkN6zXqNO9DuZr261l54JAreINesGu3imb2usJ+seSPNVD73HrZf10o22DArvUm+yBamk=@vger.kernel.org
X-Received: by 2002:a05:6512:1189:b0:53b:163a:f279 with SMTP id
 2adb3069b0e04-53b34a345f7mr6904745e87.53.1730142360985; Mon, 28 Oct 2024
 12:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk> <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
In-Reply-To: <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Oct 2024 09:05:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
Message-ID: <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region() error
 path behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 08:57, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> So likely hook on your mapping changes flags to set VM_MTE | VM_MTE_ALLOWED and
> expects this to be checked after (ugh).

Gaah. Yes. mm/shmem.c: shmem_mmap() does

        /* arm64 - allow memory tagging on RAM-based files */
        vm_flags_set(vma, VM_MTE_ALLOWED);

and while I found the equivalent hack for the VM_SPARC_ADI case, I
hadn't noticed that MTE thing.

How very annoying.

So the arch_validate_flags() case does need to be done after the ->mmap() call.

How about just finalizing everything, and then doing a regular
munmap() afterwards and returning an error (all still holding the mmap
semaphore, of course).

That still avoids the whole "partially completed mmap" case.

             Linus

