Return-Path: <linux-kernel+bounces-342335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43F988DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA85D1C21738
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F7335A7;
	Sat, 28 Sep 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmWGuIPW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE079FD
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727492576; cv=none; b=EGawClAsGfYP0gjll6OR9hW8+0ojzCTZmm+rRErmd5noYzxCOivzjjzyrbfaJxKg4UUd855IaqdMX2Es3Gvq3Au4SGj3vIpr9Hru0AjYpUxYdpPL4hH3oE+/yufj3cfAy0AHBLmFG5T5OCpeCVhpic+AVAdpMSRh7NstyoaOFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727492576; c=relaxed/simple;
	bh=eTDXozxQFUaFOdAySKHX6Las5bLYwX8QKsofqDQedKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jjmldz4GIy2oMUSHekvXwpi0D/L29XnXA9Q2tV9Un/if7GZzvZ7NQT5DSdYihgo3sYcT+EuEYT7ZolqiIKxCcCLXuXFPrX0LWSCako9ZS5wyiXvlOHPtJy3F9IocFMVsaR33DpsePd0Hn7BITcELeY6ibPDpRObN00uVqCHemXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmWGuIPW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso283849266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727492572; x=1728097372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp7MtRyqEGb3AtDPUyaqzq2eMSwplE2bfAUsUtMCVxA=;
        b=xmWGuIPWJUsNqDjMYbm0Ju7S6uTurbq/79PWl3yUuW1ami7XYvnHkoRNyyXylA9pTo
         AQf8TgMMlokp3+46ZIafuuEoc7V2DbI9PaAruP3+UpaARL1IEagtu1boIWFPjqriiIGL
         qMfk9U3E4qDMOLYniMAsQDzMcR8EAIjEinoPDFVPIc2f6jTbsvGU1tv+spNQT6rhP2hC
         ENBpsIdNf6SoIFoBS5AAokgs2y6D8M4zkmCrzk/C6l08WHNOUbVad1KcSHZ11DtCObtk
         c6+ZObjCExJj9zsQwONAkJpsIDzYv8lQQVaYCWCI57VRPC7UDSET3GgRrQbu34rAOSR2
         3Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727492572; x=1728097372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp7MtRyqEGb3AtDPUyaqzq2eMSwplE2bfAUsUtMCVxA=;
        b=CfnN3Tpxz/BtQE7qXxIarPSSy2iPCkyUy96FdQ0NzYhRZNeELQhra7jqDPgsuq04lW
         KqVIcGW7349zwVCWc5azgRwHlqf07jR/UTVSE9O8SjvXX5bCDsqQbloKJDhmbg4RPWUq
         kD28bCXXVVhCD0GFwa7g7dSuTevCLwGNH5Ni9QjZjyyHhiK5aUdnXgVRJ6u+piPKof5x
         lAK+D+iXuPwEPMENrrEde0LBSxsUQJYcPC4noGhYMAqjJk4j8SDOvLU66w+4RIMb2zc/
         VidcwAsGgQeWxz57/YFUDaSpTafVId/S3bjOx4Ac+LiM+kBdYO9G7c7EyujqfaBQBTTR
         qmxw==
X-Gm-Message-State: AOJu0YyExZtREKevcdCBIVcVV7uekMPPCCWiw28knSsmVOWZxZo7mzMP
	08uAuYWbc5sYane8xJfgXfq6HKJeAgMoFTtD9APdJEvhEhpIyP7ek8kJ8md+zZtArDQPncOAfep
	tf9pnKWdQXxithQp0iV3UBN0UDHAv4kLjSU1U
X-Google-Smtp-Source: AGHT+IHd27XmqwWu/zJtZLehBsRs6tu84k8OpJ2PNiaESRKdlCXR/BnJPbtRk6DJhBHTs4KrYcASvbbRtAWWipnYg6E=
X-Received: by 2002:a17:907:d18:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a93c30f0cd7mr543625666b.16.1727492572355; Fri, 27 Sep 2024
 20:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-5-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 20:02:14 -0700
Message-ID: <CAJD7tkY_PG6vMwExts28Wa2+QcRYcLubbMfctjyVFv94yd9w3g@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] mm: Provide a new count_objcg_events() API for
 batch event updates.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> With the introduction of zswap_store() swapping out large folios,
> we need to efficiently update the objcg's memcg events once per
> successfully stored folio. For instance, the 'ZSWPOUT' event needs
> to be incremented by folio_nr_pages().
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  include/linux/memcontrol.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 15c2716f9aa3..f47fd00c5eea 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1778,6 +1778,21 @@ static inline void count_objcg_event(struct obj_cg=
roup *objcg,
>         rcu_read_unlock();
>  }
>
> +static inline void count_objcg_events(struct obj_cgroup *objcg,
> +                                     enum vm_event_item idx,
> +                                     unsigned long count)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       if (!memcg_kmem_online())
> +               return;
> +
> +       rcu_read_lock();
> +       memcg =3D obj_cgroup_memcg(objcg);
> +       count_memcg_events(memcg, idx, count);
> +       rcu_read_unlock();
> +}

Instead of replicating the code in count_objcg_event(), we should
change count_objcg_event() to become count_objcg_events() (i.e. add a
count parameter). The existing callers can pass in 1, there's only 3
of them anyway (2 after patch 6), and they are all in zswap.

> +
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1834,6 +1849,11 @@ static inline void count_objcg_event(struct obj_cg=
roup *objcg,
>  {
>  }
>
> +static inline void count_objcg_events(struct obj_cgroup *objcg,
> +                                     enum vm_event_item idx,
> +                                     unsigned long count)
> +{
> +}
>  #endif /* CONFIG_MEMCG */
>
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
> --
> 2.27.0
>

