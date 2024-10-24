Return-Path: <linux-kernel+bounces-379133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671599ADA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30185283895
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008816191B;
	Thu, 24 Oct 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0SXg1bS"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F02158D92
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729740483; cv=none; b=qzOyXdbQP//LgcbTiMjPl+ykbtxXxiK4Jdxag8XglXTqKiMC8bk4Ttz2spzK3RyA20gfBv1WN3En6fCKwe+o63zKDshSvf/M4gRNw9yF+904y1ucuQVLH2fiGMsWqHOR+Cb8z54vQPVnOzH7Hsq/f4bbZ4ECc7IqnHpjlPp+nKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729740483; c=relaxed/simple;
	bh=vQ0d4WGw6pEdJYN+ZwXAfdMBcTgiT+jpquDiUMZpyhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3ZOe2kBu6N7tZyXsb6gZxVZoXsjYGgFA9BMQBU/xs125X5G+R08z1PED4lP98pqttEhuGyvBz6Eh3JEyf3KBxyRFW03lQzy3adaGXssh+YrtIRxjvpT4BYc9/AScTfSSOkR4JAHxz1n/kthHIqlkE1FNyO+xwXfCm83L0mA9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0SXg1bS; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a47fd930b8so149580137.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729740481; x=1730345281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTFJCH2cGLy0xaDEoQI/3kJizQVbXaha5YCvWl5U4Jw=;
        b=D0SXg1bS3UBz1R8SBh7PNF+bioFDqxToVFDquCqjMThq7+nbmMxQoAmHzKhILP/ah3
         6bqKX6DHAe7rfUgBB1rsvB5CHplMd/k34duGnt2FdtWW2HrR8AdGA0h7YM5M8iBCa+Od
         37Mkjfg+BdUOvFlDVU+650LCmVVf/RvOfMKm5M1HXx0QYxK/hXpm7fj6oFysgvpYNBTZ
         UXlbKMZsIzl0G9efpSxOYxhQbfv0FtbCAWLwxv9EiogmN0G0cUk+mRwpU2qk9pf7jokR
         gLgr7vM7cjT4rOIMTXMjA4kzJEmcB6772zbLWIE5Ij+9EaPbH2H1Amv9hPCadeb5rKW6
         Uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729740481; x=1730345281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTFJCH2cGLy0xaDEoQI/3kJizQVbXaha5YCvWl5U4Jw=;
        b=KYQg41qgLoMaTBdKgiqQROeomR6AT3NfOqLQCw1vvLe7GXiGOYN4tc5z38I0/wnE8U
         clL0eduLLG+ezpc9U9Su3/ErHA7TK2RYNSlx+X4EPusyMt6V6g9oQQBhz+MJlPqa9qwc
         8IBKiZB49rOSDpEBz4LHgCd4UHg5tpT9GPy14IVsNkD+PUqfCB7pGgtAoEuTw8YCCFKG
         38hF4FdHKds5uSt0fWZ0QkUrhkTdCRI+jXrVrLn9xc/1Ld2rbDbgOHGOYSCmDw3mGA8P
         fcefywB4Y4UpVoIpyVbK4vMuP66q3eXkiQTcU4C2ienYKpOvs3SU5AM8hYtp3IeeUrBu
         vHjA==
X-Forwarded-Encrypted: i=1; AJvYcCXEdV0sUW9pWpN9GfonD5DjgyoyCjcD0j39WYasxPiHEJBPKZA9RO4mRdG5W4BrU+lZ+6ObuaPC/8tvg+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNc6cj+HlwpTKqZVCOwLiNtL6VrLjWFQHykkPToZNzoPT+gOmR
	W2Pq/eY4O4bT6KTkImQopjnCxaPCN7GyB1CPfOFjsXv/T6RjCfvMF7aJuFtqHikIxoqumSUSz7t
	krUcm6TpW8fX7SfsqI+08rItnU5B7N55qiBaS
X-Google-Smtp-Source: AGHT+IEFmKIrH0tEdhot3dQD3vWVXcyr4nBHaZ/45p+WXMlhwsIRW1Qi8jPw4tHBO8r92w8rBgRlQYFQmMzDo6ipkFs=
X-Received: by 2002:a05:6102:954:b0:4a5:b712:2c94 with SMTP id
 ada2fe7eead31-4a751bff426mr5723576137.14.1729740480730; Wed, 23 Oct 2024
 20:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019012940.3656292-1-jthoughton@google.com>
 <20241019012940.3656292-2-jthoughton@google.com> <20241023202608.d4c3c8a5fef8b7e33667cf31@linux-foundation.org>
In-Reply-To: <20241023202608.d4c3c8a5fef8b7e33667cf31@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 23 Oct 2024 21:27:23 -0600
Message-ID: <CAOUHufZnsT3SGgVGRm=9H=1yYSsotCJsy58rJ5JPsSW3-AHCJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: multi-gen LRU: remove MM_LEAF_OLD and
 MM_NONLEAF_TOTAL stats
To: Andrew Morton <akpm@linux-foundation.org>
Cc: James Houghton <jthoughton@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Stevens <stevensd@google.com>, Wei Xu <weixugc@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:26=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 19 Oct 2024 01:29:38 +0000 James Houghton <jthoughton@google.com>=
 wrote:
>
> > From: Yu Zhao <yuzhao@google.com>
> >
> > The removed stats, MM_LEAF_OLD and MM_NONLEAF_TOTAL, are not very
> > helpful and become more complicated to properly compute when adding
> > test/clear_young() notifiers in MGLRU's mm walk.
> >
>
> Patch 2/2 has Fixes: and cc:stable.  Patch 2/2 requires patch 1/2.  So I
> added the same Fixes: and cc:stable to patch 1/2.

SGTM. Thanks!

