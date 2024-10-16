Return-Path: <linux-kernel+bounces-368497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B549A1073
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596EB28217F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8418891F;
	Wed, 16 Oct 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvNrxYqO"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F942187350
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099058; cv=none; b=lOWInlnn9/+0xCvurJgIgwCHLOwPfQ/Vui1kY0MVPAZUG7r+rEFe0EFblbkkkdjlyoX8DfXsoORefeAGdwbAhycWpA7CVVv9osSF6znCscn+x6FswqwyhS1cdRVi2mpFgPX6dUVuzu1NHOhXuS45LKrqw5xLgauAIVgGv7XykAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099058; c=relaxed/simple;
	bh=1qcDEKEXdEe+vXVETIwM5sey0mOwmtEmxTAsdaInNAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWQh44gLu0IPwomHbLvaYZz6VRpGtbz3VbWFzK2qrD0EXzR9BOKJlB675w8IzkHdj+0gSjiUI/N3L0sRCtebTGx4d1uo9qVO6RxvNqrzl81GLBv/WEmUpScIT3D1RqIhH2Ul2Oh9gsWSQcdLfIFs2pRf+Fk/7AutpqydiHiV80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvNrxYqO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4601a471aecso11371cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729099055; x=1729703855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6N/pHBmZnFXpVq6+UL3T9SWfEc3WQ8exbB8tpXp45E=;
        b=TvNrxYqOY9m5dmlF1slyChDCFfA9jaz2iU0zRxrxaMA0jBXaAzcP7MXgc9RIBIuyz+
         FjcM5FEME5GXlkPqxhKa4BIZWx2aE3E68YQCSsT9jbbCmc1kCu4dY+XH6iVPmU1FeP1O
         06gHphuJhDx0X1V6UX4wW6WOZOdVqukZfBQtNrMWniF0o4uQjGrBiPQOPBAmjl/eCJDF
         2ErUcbnLkZYlf/vgtiQENN0ZRDnHf+k8udDQdXfRCGYZ2NaO6i6vVKKhlnjY5qc+e6BR
         3cZKyR5eJqRLyk29cHugoIJU8kg4oON3UDiHoR0/cVjL0hUWHkxVKhawTuAhHD5x94xJ
         5SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099055; x=1729703855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6N/pHBmZnFXpVq6+UL3T9SWfEc3WQ8exbB8tpXp45E=;
        b=wbJCR03MS0KQS7VqluJYYYZFaQxBbCbONpVjs8iFoHYQ5jnhEI+FlR7lvO316Qq4ge
         kyvC6LvpLpgHD/bq0FX4HIdrghTql6Mj7zIaJzAVHJkPYWuLu1ecQNs8Nm+/shu7UAct
         Al+mTAU9wexA7f7gDohNCBUnJyz42MsS5yOtIvm6B7wdCFQxfX7+aQtBD+36nt349+L+
         kd8/CwOk+Hmdlrkgi/bRmj4ri+1HxXKgIWBuatuJzB3C8jGlZzBjubg+aHNVCxpMiGHK
         Sr56SYQtHPjgGFfTKf4xUdrKRHr1izMruPQN37eue2WNYuHm3jbQ394oEbjgo9fi+WCI
         Ir1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjuV2GPlaqrqOYvsxvVyUkOSYrD/gkIU+Ylud6aFVFpaRhm8XdAGNAb3NiefCpJFwXuCZWvswXJm4BhP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyfnp4NuGBgAdeSbo70zdbTJFHJ9XQYOmD+hJ9iSE38P+gb5xs
	1cFICx99KFmrVxRzI8zNG0D66jahipnAjONKaMeifdccSTts/d986l0KH5tGjUB/AZNuaetvOVb
	AR8t7H5kFV/LiExRBaxBuXSaDFIJys3/iNCuM
X-Google-Smtp-Source: AGHT+IEePLBNjlQIEzNDgfNbNMSxGyKJwTaLZWj25xyJ0R8z1vqkjzL/pzKBBv0CgTEy+r6lEoCb5QFBcNuwTz3HKxI=
X-Received: by 2002:a05:622a:a7c7:b0:460:48c3:c352 with SMTP id
 d75a77b69052e-4608eaa4aa8mr5488141cf.1.1729099055385; Wed, 16 Oct 2024
 10:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015213721.3804209-1-shakeel.butt@linux.dev>
In-Reply-To: <20241015213721.3804209-1-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Oct 2024 10:17:22 -0700
Message-ID: <CABdmKX3iqmPnmSDi=KCy+0QSws+PjLR1jLs8HL-JjorCARM02A@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The memcg stats are maintained in rstat infrastructure which provides ver=
y
> fast updates side and reasonable read side.  However memcg added plethora
> of stats and made the read side, which is cgroup rstat flush, very slow.
> To solve that, threshold was added in the memcg stats read side i.e.  no
> need to flush the stats if updates are within the threshold.
>
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective.  We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates.  Let's add trace to get that visibility.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: JP Kobryn <inwardvessel@gmail.com>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

