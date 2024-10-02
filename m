Return-Path: <linux-kernel+bounces-348145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A498E346
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1F284E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AB156972;
	Wed,  2 Oct 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dx+X9e0v"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113D1FDA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895754; cv=none; b=EBLW5ZurtM11RtpF0OkTnUkTYpHzQA+mNuytYi5flT40idac6MPfnaOnvgetMWkOEP+VeeW3mJVvP9aCB69NabhIwtzwkxaSMANUjWTj1j/rXTcBVIM8budMFBUibQwPaZkWmkpgTE4XM3Hnhc/+YkmPyG1md37f6+DfQI11ZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895754; c=relaxed/simple;
	bh=T6AAXml313zISn5iWhjCQ56vdjkXJb815qA9eISEf50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdGHZ6sMgtgGwZB76yXdSDMtP3x2qkoKGrM7JLUoHFUo4O5bZElY7qfOelJqJv2ZqF8xi/hWOeCqATWi6UH+aiVIrly3BMcb/opUDMgxnzg/zpgeo985E418DaPNTYOFa4+TjF4OEEKWlEtH4uL/ZoGBY1t7WCPKc3hI5YbQPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dx+X9e0v; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so7028666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727895749; x=1728500549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pk5sxpXelnlcFpZhaVYKsnlMlWwcl7IaLwVfXSaqYY=;
        b=Dx+X9e0v1ON2PiU9acK9tMsp0PfUYsEd413PhojKRDNBkvcRemxuaPKc2mw2bRrT93
         zTu94pGrhyusuzkbe0QlJUvIcueTTilfURsuaKkIbWg54AC/ptwzYZRbE2M5uckGM8PR
         4D0lGiVGBHAT/cEWtmbOfzSwxb298p8pD+gh5WlBfdFYjuzs5JvXTw+vGwhyXZN2xGj+
         0FhwsVMzce38e7D9oVkiLj7LePg3UW4/NrgLxt2ZimqA40B4hmpU22STSkKMoZX311hR
         Xi8YvFuQA1O3P1MwIUqqNMW0pqiZbwso6Jnf4J/nmtqKrsj+JKB/pi0Rvig3g/+aRmL3
         PQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727895749; x=1728500549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pk5sxpXelnlcFpZhaVYKsnlMlWwcl7IaLwVfXSaqYY=;
        b=jxNMJJFg0QNnaPe+j8zPZsgiGITZlsPYTquk3oSSruaCX/nG1wD8gP0EkJh4ZD+7HD
         cFAla+BqLqcwOWIPSaaOPwwaKWWX/sUyn3wS2mXjgBRUYXUHXIOw50iIqdTnqRQ5bniL
         UQBe9LlVQpmY0Ec5O4hvByLMBCS0TotS0atZ8NADKrSWXJmnZWO6Tc2s5slRdlW90/rx
         WRdaMdQ+dABkQZp0WdodUrPO8ae7X9duu2B07ArMF9FpVe4z+gM2HCu5qhHwLbcKsyVL
         t7ZyJ52VhvbaVEstR+7HMzFfmf5mCz7bsMJpNSx3cttmYk1ZkEY/6n7yJCtrjcBkX88N
         VzGw==
X-Gm-Message-State: AOJu0YxZ1GB4zHwdAEA2uyMZMQy2bZASwXTO7V+64HXpKTHGkGuGBwLG
	SPCgSHttgDp1K/ev1dwroAfTyhGVbZ2yzLhf+ZWA2nEnttJRKV8Bk1xKTIROhxVoCcXMxCs6EpY
	QD82z8jgt3thR2IWY1RuV8mFmo1EKoObKUSacAmGRnZeycjr/ZtHi
X-Google-Smtp-Source: AGHT+IEQt7ReEYDqSY4zyY91bDH/qUjp+ixDClQiovmpzvG2Hkk9clXBh+QR0WalQsCDKdeFliAJ5KFFI/XDIDV9ylA=
X-Received: by 2002:a17:906:dac3:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a98f825d922mr442028066b.27.1727895748742; Wed, 02 Oct 2024
 12:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 2 Oct 2024 12:01:51 -0700
Message-ID: <CAJD7tkYLD9815CLS+6FCkokeOvPt4Pa6XTnpUAGdaDJF9kdNmA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: swap: Call count_mthp_stat() outside ifdef CONFIG_TRANSPARENT_HUGEPAGE.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:30=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This patch moves the call to count_mthp_stat() in count_swpout_vm_event()
> to be outside the "ifdef CONFIG_TRANSPARENT_HUGEPAGE" based on changes
> made in commit 246d3aa3e53151fa150f10257ddd8a4facd31a6a ("mm: cleanup
>  count_mthp_stat() definition").
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>


I don't think this really makes a difference, but I will leave it to
the THP folks to decide.

However, if you go through with this, please also do the same for the
call in shrink_folio_list() for consistency.

>
> ---
>  mm/page_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4aa34862676f..a28d28b6b3ce 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -289,8 +289,8 @@ static inline void count_swpout_vm_event(struct folio=
 *folio)
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> -       count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
> +       count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>         count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
> --
> 2.27.0
>

