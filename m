Return-Path: <linux-kernel+bounces-406290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEAA9C5F77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86418BA1478
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91966207201;
	Tue, 12 Nov 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DmXz0eh"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41920494F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427741; cv=none; b=kVpZTOj/rXNSI4114GzupjVvjGBzbrqV0e8s1KOd+HRPrBsOqvtaPO2gYI0mCecTAehNYOc1foEQxi0BZL3HGllqmiLi2wkyJ9uHEHCkzA71adLGizgdA7og+JepdvSu0GMXEOSxR+vEmazr7WQkc05LcZbT2TCCXONnxME3HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427741; c=relaxed/simple;
	bh=9IcpRacBKJTxaSWGKlUbuFhxYoOVR2azUbGyST7iUTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZELO1ZnjW6XyWtY70HBeQpRY6Nc46VizYy+CVFH+52gLrbCJ4W3X0LkpwjpvklJT+Voh8/7EfXiSCjyME0U8xbSN8bMbuipm7tjtIphxYr/Z54lNeGM4tfR9o4PnFlezlDuGq0Gkuc5ecjhNo3dra+hrcN20pYszr4vbIDNLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DmXz0eh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608dddaa35so303791cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731427738; x=1732032538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpl8dehN/rWG2F4QZF2FTgN/LLRh9PTYD/zsF0hkLsM=;
        b=0DmXz0ehrbRJn3oxYbV4opJ/o0CYnDKjEHtrqGpPWCXfdxgKxcWqhvLxQoSjpc9QO3
         7XtBCZsDivYNi9ekjGWOiSCb9g3P5MfW1rwt0la3WUg/VzXwd40N2IE5BYhv/eockXBg
         znfHNg9Hodk0ALZ4JZ+LLodeie53KoiHQfDg4xf7JxcjuAsz733EE7o7Nf68o8fE8vfS
         j3gmyR4cUTf+4NvKhT1f8FXYqHy26i1z8c2m9OEergGl/lWJ2jdGT0KYq+LkESdAf+AS
         b/ewR8nDdxPrwTPSTjL8RkZKPTmf6pTy53scxJffSMekSbOW3n85wmBlWcBbub+G5X4G
         kHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427738; x=1732032538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpl8dehN/rWG2F4QZF2FTgN/LLRh9PTYD/zsF0hkLsM=;
        b=YbRoswcWtwSuuiGVpKaIKzFEfl6r3xuJSR0mXlUkhf2c1WzfgGf6DbrEkA30XfCh4X
         s/+3+3vl4m7ZOIlyNSH1BxutDbq/T+V4c96Z1V+YYQPCnF26dIMTDyhcHJGlo0vkDzF7
         Mkp8yWQKVe6KayEfTqJM26s73GdDR2oobpdW+XHf2iRBTc3ne1y8M027tS4wYNmTQoP+
         Zg2PCnUrKsiFlsaI3wSD+l+DFHPYGdC+qb3t2eoe2GGhjFl2vxkW2o0uByjRFFU4JYcM
         xi+jOpi5I7jkr+JmGPECGyTYncgmXT3h9wB87mqY9xzpRFRt5sg931u/9TZzBqwp2Yod
         HvfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqT0SxEAdFMvkuAujasu9N06SoPWJNuWRiBZAhgtt4diJYLL8XTkE/9TDcJ5w5jr46DpAD8w4neRjI5RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcY0qWz6QtfxugIQ9NoJIJPSsk2faWYrATgBY4/07hD8Rwi67
	CQUjgtY8MjfzW8bdOrbnOLNcwMs2WI7PYhvaluNknV1PJCtcO8fugi1gd3gnxD6DSSMh+bXZLFF
	RqNS60c+ZcQl12t8LjUCppTcTs2wGTg1xNnYH
X-Gm-Gg: ASbGncufQu2S3FCrfbLiedh2cvZB5CCx0WCGFMUVYiOumJYhKu9Gz9Vt4uCMBVr17l6
	4YS8Tm+QDjV+fopILHRZPKfJ2J8HfEFlmsFm04NBvsxvYiAw5Mu8ArEXnmBdICA==
X-Google-Smtp-Source: AGHT+IH3WUuIeBOnXwCCCohwIn7m3C49dH6r3RxhltlYD49jVVB/21iX3ULq7DgdUdGoHr+lVXdpj53fQYzjgln26oU=
X-Received: by 2002:ac8:7fd3:0:b0:462:c4fe:ec19 with SMTP id
 d75a77b69052e-463428b334emr2740831cf.21.1731427738132; Tue, 12 Nov 2024
 08:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-3-surenb@google.com>
 <07a72c38-22f5-4b99-9d74-0877eaf2bee2@suse.cz>
In-Reply-To: <07a72c38-22f5-4b99-9d74-0877eaf2bee2@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 08:08:47 -0800
Message-ID: <CAJuCfpFvPis7mdHDsgK=H54SXDNpbJDpDQ2aVYKiFViueQj4Sg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/11/24 21:55, Suren Baghdasaryan wrote:
> > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
> >  {
> >       vma_numab_state_free(vma);
> >       free_anon_vma_name(vma);
> > -     vma_lock_free(vma);
> >       kmem_cache_free(vm_area_cachep, vma);
> >  }
>
> Have you investigated if this allows to perform vma_numab_state_free() an=
d
> free_anon_vma_name() immediately, and only kfree_rcu() the vma itself,
> instead of performing all this in a call_rcu() callback?

Yes, it should be fine to free them immediately. lock_vma_under_rcu()
does not use neither vma->numab_state, nor vma->anon_name.

>
> Of course if we succeed converting vma's to SLAB_TYPESAFE_RCU this immedi=
ate
> freeing of numab state and anon_vma_name would be implied, but maybe it's=
 an
> useful intermediate step on its own.

I'm thinking maybe I should post SLAB_TYPESAFE_RCU conversion before
anything else. It's simple and quite uncontroversial. I will probably
do that today.

