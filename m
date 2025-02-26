Return-Path: <linux-kernel+bounces-532990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E6A45496
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C7316DFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA2231A24;
	Wed, 26 Feb 2025 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A5GK1svh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F36139B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740544709; cv=none; b=ggSsWTMQE+bBA35ftUL0IuFCHOKIID9J758zJlmVKhwIVQ2AoMHHsUvPlFpOWFi03TnsigpbUfbQFL9QZss/b8lbM65D1sGOjemjL4CLeZMzRlAPbuXNNiQho3FHE10eiWT6CGJovDbZRs3fL8N4mq40Qe+olHZAqZHHZZC8IIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740544709; c=relaxed/simple;
	bh=o9VGrTU4RH4cAU41oDJXkuncLuI++NgQaN6Ju8dG7xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL9AgQ+t1JUT4LovtOM7M+VqKjBG8l2zFfjqbVkViNudmDw68+VPK5V8MpJETTRXmuIT3TLy9s2E5gRfd/+VOoW+4oohg/2ExLtbWmsFFw0jUqLjLaqsSf0HnyDhqnDN+V/vADlhF1rzd/iQLR2Lfq0IQIychvRKaTdChVRwcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A5GK1svh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so135913155ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740544707; x=1741149507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+/R6mF8ulvbTpjWGGHSNowxI5O61Kjp1943O9pSz4Q=;
        b=A5GK1svhSE0JhckBp9mTdM0lSr9S+dIOK5Hm8DYiyKUBWaDLrwY/kW3hH+MpZ3HTQb
         Zz0gqsO1/oE6qfAxRlDzKfgm7Tgglbie5MZ/nUfdyhpTasato/u4qvsVOkloypwrq3v7
         FUhSBdUwuoA1VrAd6kbgAn4bCc3DAM+OJ0iNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740544707; x=1741149507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+/R6mF8ulvbTpjWGGHSNowxI5O61Kjp1943O9pSz4Q=;
        b=E1pQQF0JPyGekKiwGM0AVZ0R5cuZMYQehHPpq8+oZW1/XTVGOq8pEcaeJS4zW4rpGU
         4QubiZv4+YbBlMPKaSvPxNMdHHPLhtUYA3Kw/vTS+gnfcvsrosv90Str0j4aw0Ijp3Mr
         u0yKhaaMUV7c0JH0Dwiv/t6fFOyWXN8lBNhkXvmnUJ5yENj0r2wJSwmDQoj4dollEtIr
         9oMp+Cq/qweGQbizuU3cafqGSAc38YHbYsdLfzy3ppCRILWf3mxH1XJc1UJvCf/k83St
         xg/LKthhxbseGAplwsuqa/EdPk1aP0CXQPQveyb5K1kIEcCoh1aN9qBAE4iG8OuT6mCD
         izwA==
X-Forwarded-Encrypted: i=1; AJvYcCWfvKH84DUHOmgx9ILxTIMgSqKShlwEGZa7cEeikMC0CBBztmNXppJjQfME8AHEtkekM3cUkOZHUPU64Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwNMAE6yysWj7/57G3C99UOqtxztuYvO2s/a+FEVvxvbjmaOV
	qWulqB/eWSHDPYViOQTnkda0r64zj20YTgPtumIaI6tfbs1CAGG5kAaEhSV2vQ==
X-Gm-Gg: ASbGncvO5MlVEuyIAuO6C6i5kidM137rBaMouGCRS/uL8nj7vOu3khhWC5Ka6GiGdyT
	r5AzenlF40OF4Zs7cRzzmsEq9q0T3Gyd3BmsyUqbwtmD78xosblWbDuyQ5cFOHpWqdoaRX1bDku
	KpNsHoQ0Yt7Jy+lQIi3+Ayz5zGEG4Dxkn+rFQ5EHQQm/INJ/vAvex+3qgYZugAjcb1GVIom9PTT
	kiN/kjMedoRXeVezKWGxmN5TVqjBQd/6RDvHr5Dtws+jVlqKv5qSl0NEKk75U1HJFsTnpD03O69
	oNgP1a28OQtoAH26KWl47sfzFX+lzbQ6lAtnW/Ukp59cXY8o
X-Google-Smtp-Source: AGHT+IG10Apvxta2uy2ZB6Teg2ycVFSkdt9WvO84IDvz2UCEnqR4AXx9tGBee/Hk4tpgf8TZpx10EQ==
X-Received: by 2002:a05:6a00:2ea1:b0:732:6214:8294 with SMTP id d2e1a72fcca58-73426c7c5b2mr28798806b3a.1.1740544707246;
        Tue, 25 Feb 2025 20:38:27 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d7e5:44ee:77f5:4b71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6ad9c9sm2453197b3a.28.2025.02.25.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 20:38:26 -0800 (PST)
Date: Wed, 26 Feb 2025 13:38:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <sp5amdg3pewlnhcigeitslfdmf4sprss6fia4vrtx6dwixotlf@lfuama2h2nrw>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>

On (25/02/25 16:02), Masami Hiramatsu (Google) wrote:
> The "hung_task" shows a long-time uninterruptible slept task, but most
> often, it's blocked on a mutex acquired by another task. Without
> dumping such a task, investigating the root cause of the hung task
> problem is very difficult.
> 
> This introduce task_struct::blocker_mutex to point the mutex lock
> which this task is waiting for. Since the mutex has "owner"
> information, we can find the owner task and dump it with hung tasks.
> 
> Note: the owner can be changed while dumping the owner task, so
> this is "likely" the owner of the mutex.

I assume another possibility can be that the owner is still around,
let's say a kworker that simply forgot to mutex_unlock(), so we'll
get its backtrace but it can be misleading, because kworker in
question might be doing something completely unrelated.  But this
is still better than nothing.

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

