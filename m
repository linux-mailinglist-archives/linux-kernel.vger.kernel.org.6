Return-Path: <linux-kernel+bounces-261499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD9A93B7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DBB1F21FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4116CD36;
	Wed, 24 Jul 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="In8CvAqq"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2A14B08C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852611; cv=none; b=ncbftv/KSwrKM1kHs+yCwqd1nInwz4fuiFifmJGsXKQooCJfo+384yVdG3qo+UfDTCY+1YjGIMuiTdhov3CH8TL1nBBriKWaXzIt05wdouL6S0QYSKwFFhWu9RH7LNEAZv+5CtYuf1A+V7I8NxJbqQiaKIm+3cwAodorKgOUeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852611; c=relaxed/simple;
	bh=xcnLzfTXgYpBsrPe0Cp0LZSob6SdOshKVqgBDArFwzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3Kl+QlxTHTGJ1TMCcHwpU5vnNRbMSThiVrF9FRIEx0WX6XJJCWEr5p6LeMnqkUW3455/cLk8zDNonudmpME/5trq1IPgeyvGaI69BnZK1ZjG53Nbl4f8V0ppRbH24Hg7yqsC6RHDZCgj4HfbB1/ctO+ru+9mnIWw+PZa4Xk+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=In8CvAqq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6687f2f0986so2250727b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721852607; x=1722457407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gYlyIbBkXb8qsAW1cRX82zo3FxiuDkqxGc6DCAuBao=;
        b=In8CvAqqUZBweU+/svZyNLy08WpJXCmrLtID1YfTxHam3BBBrER7XXmXb91I/n7sNe
         bn9euJ0ObNf8V3z7KIsfRk1QdrDUKZL6iWVImUnPTaaGBzNwqvTQixaP2CBwtIHoqA8e
         bR8IyRB/vhr+lNrvoaHm7j9QG/B5EsuSocjZl1W7WQSnw9c8VHiIOwOBzzlev52xZdnw
         hqj4OhsrL9D4tIeviAQgBBhxdD8DgbmFWEDfqgRkIsr35f3WRcUAWFxhTV8ddEwygIlq
         ibpoUmEfnNLxoJuf1qafW0F1DvqctQuTL+/ddLX2XebOc1shrF/ZX83iH2aalFjFyDIb
         wAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721852607; x=1722457407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gYlyIbBkXb8qsAW1cRX82zo3FxiuDkqxGc6DCAuBao=;
        b=jSLvRuA1ufZRUgTN1RGpoIuB+qmVw2rFx/u7bqX5YApak5UHaGLQNN49ByO1PVrsVQ
         V51fyXPinwnI7HE0YMe8m0HWa9mGsVUSUwikkrn3sizNMTig19jDPdYIT4hfNNjyIlw6
         3S3BbIgJpZyKE40wAcOveZ+4zLn5POQj0GKoRWyWs9OCoRPf5Rd8Ed4RspDKu3fMRhY/
         nj4DCSxuUObLVCz1x+PQF6OMxAKbuEFQyPi1IJPCBQwTHZhcdCzYChqe/X4nEjEQ/l7p
         kq33xUiee0YPXRw5VvFJhrdAn4lcphMlvf6hyMXiqqN4vyFVCCXyy0x0N79zVAIFpduj
         koaw==
X-Forwarded-Encrypted: i=1; AJvYcCWylS/shCjr8Qi3Do/9ewHogfAuLJCOlTnGW+uil8/JgQZjO6FkyDmMGtgsZcp8lFfUC/U2whR8An11aMHsxsmbUhmbkV0jW3JqKgDq
X-Gm-Message-State: AOJu0YzffLs9xtXA+crr0isztasU0OWeAAHRiNJmrV2WDpZOzwJPWi7p
	gdxhXrZ35U7NG/ZsVmlPzAi2s9gTMKjYay0cbq6mMkOShZ+rvEz5vE3KULnDyQWAEWfVHT8YlWM
	jupfK0TJunJAd+0rc1lP7vrrAoPMdhIMgACjh
X-Google-Smtp-Source: AGHT+IEEcMOMal5KuJ8dK2KbEhMkWJaWkbUba3UfO8Xct/hz3BHrKr71DZX/SGkmGDlwXiFsYxniAoqZTENJSPiWQdM=
X-Received: by 2002:a81:5c8a:0:b0:620:2cfb:7a0e with SMTP id
 00721157ae682-67514e42a34mr6143987b3.40.1721852607459; Wed, 24 Jul 2024
 13:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com> <20240717200709.1552558-17-Liam.Howlett@oracle.com>
In-Reply-To: <20240717200709.1552558-17-Liam.Howlett@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jul 2024 16:23:16 -0400
Message-ID: <CAHC9VhQHQ8aWu_eYDXqmMrPkUCd=KV9MV7WbjOtSMCa1GjfGBQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/21] mm/mmap: Use vms accounted pages in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, linux-security-module@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Change from nr_pages variable to vms.nr_accounted for the charged pages
> calculation.  This is necessary for a future patch.
>
> This also avoids checking security_vm_enough_memory_mm() if the amount
> of memory won't change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: linux-security-module@vger.kernel.org
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com

