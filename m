Return-Path: <linux-kernel+bounces-383257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EE9B1914
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1241F219CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E691DFFD;
	Sat, 26 Oct 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcNiFeI0"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7920314
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956404; cv=none; b=NaOrXVzB1YHVVw6AFhfqtV6jBy/0+kcQT7AjDop3CZ30vfT2tRIu0LVeugRWnOVHt5OKoWkdTcILlhmn7BuuanME5I6CcUacqI9SkWqpHFjFGTBgOUo98khERdKtZDACUueXJhPsfj5uysOds6jFKKEuFpReSihA1QEhMBvNrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956404; c=relaxed/simple;
	bh=j+TOt+oBoXAXIref9ySAzCU2ABgXyfapBlEIF4iWO1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho+IOLsqdO5VJ+fq0i3iGfJSxGIMbMRqAOENdHyTHLdAdRz/BQ+WITYI2ahpiTrkdaf16417atiKGewK4dveH91rxktZltpmpT1NtwPGasrK80B6u1AabX9GVUT07MBdiomEemgSqoxOapeRNzLk85bhasF/V2coJz96uc5HSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcNiFeI0; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a47240d31aso824280137.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729956401; x=1730561201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=QcNiFeI0D+4/GuAlhGXHe9GX8KU08JRwuhTU2KTl9W5MsI5PXZE0hf5chrDmwO4UMr
         5NwN9HrHhG+XIdOOiGWJ15D/+Slyu2ROHE+SryvQgnk5qFU5L7Ljx6Vwkpft1b6NYWGs
         BX/qVMoX1t6hxO5F6HS7tC4/faBNjEpp73nEzZSlL89EbID9AIJDKUF9QtyTTDrKaS7y
         +nIe0QER7LmRaqnjHOGT/dV+taSPp45QW4eOVYtGQ3avFKFWU00pzBkpKmL3cYKltsAG
         BfQkFysK/Jpdcs+l2cSS9fXP52yz4Hgm8+AfPrmB6j+8BacHbVDrJfsY/znkKZPiBYEp
         yM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956401; x=1730561201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=b6aVdcMrYTwtQ9tONeCEt7kRP6eEHx4xwHGvCuE7ve6Tdh7YVhLm8McSxgZfhDLPFG
         U3AAqUXpVMxE38wbtCYfbIa86zfDt2Ek2V5haLg9DUlp2ELCiANq4n6UrE76rWn78d2b
         u8asgLLQ0vsSovDfYJCP+Zxvwd4Fh9XstncO2D119UOqIYZALE5n8F8eIOpz/C8fkCVE
         sqhlwwy7O+e8hKwVKrbPR35kzWPo68tkIBDt+EWWT9IzVGTej3Y/yDCxnB0wpzVtp5Ck
         Sw2O2VViCg1+UWF+FmgzPtN2wrsKEDtxPKtJSPIRmjFCpyokSOcNmLu2sS445LZG1g1B
         DHpw==
X-Forwarded-Encrypted: i=1; AJvYcCWTxaHNC6BA03lN00xfTk8mB7zk154l0F0k8dugBbalsOtgWpWryMMp2sPERRXx0E7/HuZAqT08x7FMfys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtPOurCxh4MBCMqyIQykRW92YmrNv0rJiuY5xNdOvzHT+nE5g
	vTThgfhh5Hgeiaax/5JsbjmrZLVVyUFwdAit8WxcZssLSiKKz0gtQYc5hcI6xncqInVIfDzIo1I
	SqfgnpISjZHhGdt0dph3qcGVXrCrY8cLMn4+X
X-Google-Smtp-Source: AGHT+IErUT0EIQ3izExbmaeiykyMEE+HsZfO112pFWJqZp8vISP3bZ5byVVQr2RWeeWRFFt6XPR1QkksNOhNbda7Msk=
X-Received: by 2002:a05:6102:5112:b0:4a5:b0d3:cbbe with SMTP id
 ada2fe7eead31-4a8cfb27a5fmr2090677137.1.1729956401467; Sat, 26 Oct 2024
 08:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
In-Reply-To: <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 26 Oct 2024 09:26:04 -0600
Message-ID: <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > While updating the generation of the folios, MGLRU requires that the
> > folio's memcg association remains stable. With the charge migration
> > deprecated, there is no need for MGLRU to acquire locks to keep the
> > folio and memcg association stable.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Andrew, can you please apply the following fix to this patch after your
> unused fixup?

Thanks!

> index fd7171658b63..b8b0e8fa1332 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3353,7 +3353,7 @@ static struct folio *get_pfn_folio(unsigned long pf=
n, struct mem_cgroup *memcg,
>         if (folio_nid(folio) !=3D pgdat->node_id)
>                 return NULL;
>
> -       if (folio_memcg_rcu(folio) !=3D memcg)
> +       if (folio_memcg(folio) !=3D memcg)
>                 return NULL;
>
>         /* file VMAs can contain anon pages from COW */
>
>

