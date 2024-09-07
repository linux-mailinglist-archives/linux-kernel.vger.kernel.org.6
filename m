Return-Path: <linux-kernel+bounces-319596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87096FF05
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E890AB22FD5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB3D512;
	Sat,  7 Sep 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzGaCZpN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EB79C4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673025; cv=none; b=WPu+oHgckMhPChD8BSYZEHECTi6i5Goh4XbEAuEb30SkN2kcHOaybo/RJfJnn+BUtaBzyjdIINVcCGCsZvjjUfQWvaOcYiCdg7mphukjUuqFSIbHzbweenr7Vfx5J9D5nkIFXtaxOPPo5ZGud0PSxO82Lc0XrxczW2/Gu55yQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673025; c=relaxed/simple;
	bh=BtdkTeqwNyarNLUud1ny560jYA6MG9kqwt3/BoPR9L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhiF0P3sM3CDWl8XTi7mnja1bcR8wW5COxO3hMtHckXbZ9tfJ/EwukSsYoGq7BlR6cLbNlnePk5sqj3bV73BzaRdRr1EWjbhCJexx2AjhsJHmdASgqcYVL1awH8Ps9x2VxoP/PkXzMqcRiw78+TRFuJgnJMQ7Mz87oK6f/kItEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzGaCZpN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725673021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUAh66u18yZqVcGU/SfKdY2rCCidwdXVDKvY/bEyf10=;
	b=hzGaCZpNEhunw4EcyMTOazzZGx+mjQt3Hz4N8tk26M8H1DchShHCI/TT8zb+Tp9l4OQcL5
	0rhCD5WEDJYcoJo6ODXRy5aS2gj+wLzxjKUzbqWiYO1bxRJEjSGJ5g6juQvMEc1Tf/nRef
	dXiPbcmgifZm2RfTBFEMPgFXHp3Bjr0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-OZdkHiftPFGR0ze-pZXEBQ-1; Fri, 06 Sep 2024 21:36:57 -0400
X-MC-Unique: OZdkHiftPFGR0ze-pZXEBQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-49be848125eso274915137.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 18:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725673017; x=1726277817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUAh66u18yZqVcGU/SfKdY2rCCidwdXVDKvY/bEyf10=;
        b=hCM++yy0AD6/7eIT9ifjvT2VPZeo6iCq4nR1onrf+90RQ1vVT8ILjbcvtCqiSFlnyC
         vq4kYfSC2aT7JZ0FwT1hL6gnkDU8LSrj1NRf1UHSQGLoZAANGyvFTVqo9WC7/h+2vWrZ
         SkzCnjM54CSk0hXhX9xq1Rfy3H2uW+XoIEPM1/I/uvF0PgkwH03KNsv4kbA3CddrIXqI
         fvwXNLB/efqWEE0wALUlvlqL2X9KlkTlEoORCQbEa6oTkCVe8kurmkqa0n9Pj3WN4bV4
         Yb2NtvsrWdH3l3KlgcV0a+OtKvGsae7p5Ix9fzlPciWcMyvx5lf2C0ESkg0zhzhLkWhd
         ld8g==
X-Forwarded-Encrypted: i=1; AJvYcCWcRcHZYl1LkRSGuRewaZg4xVl7RIFfOWYOXe3hWkWunSiOVG8xDn5/i9SiLx0C/Hq37kzbMucp0Kzspnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2+i/uNJj4N8Wu4btL8FyEe1NyGbzvm5eO0VJ2dAx0n32HTWc
	kEwb1yWr/rDaKdjm5q3R+TYHOra0mhuVm8kXVlPSxSPEywBC7pDWPxjB92TIKkZ2rBxh6E4zPLp
	OhksCHABRpk2CJ7bFFwXIkdZLJRlEfKayDqhP6JRtYuPt8VGhUe9ucVKLpYfZ9tYt+cMttUa802
	fSRWbXAKUQy/tqt641DAc3VirLheeHpEk6Zj2h
X-Received: by 2002:a05:6102:3ec6:b0:493:effa:e721 with SMTP id ada2fe7eead31-49bde2eabf3mr5698686137.27.1725673017011;
        Fri, 06 Sep 2024 18:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+YqWeP+1a0zNpj9U4DtEaZ2NfnITUQpG1RUgzpmtbvOkDbAmqnJSxayXCQ5xY8mwozaogNP4TDnANrW8B4dQ=
X-Received: by 2002:a05:6102:3ec6:b0:493:effa:e721 with SMTP id
 ada2fe7eead31-49bde2eabf3mr5698669137.27.1725673016557; Fri, 06 Sep 2024
 18:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906174941.1147197-2-costa.shul@redhat.com>
In-Reply-To: <20240906174941.1147197-2-costa.shul@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 7 Sep 2024 09:36:45 +0800
Message-ID: <CAFj5m9KbZyeM+0h_d=KqGC5B9Vj2OOuHvdhzLXexLkctWtzKhA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xive: Use cpumask_intersects()
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 1:50=E2=80=AFAM Costa Shulyupin <costa.shul@redhat.c=
om> wrote:
>
> Replace `cpumask_any_and(a, b) >=3D nr_cpu_ids`
> with the more readable `!cpumask_intersects(a, b)`.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  arch/powerpc/sysdev/xive/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index fa01818c1972c..a6c388bdf5d08 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -726,7 +726,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
>         pr_debug("%s: irq %d/0x%x\n", __func__, d->irq, hw_irq);
>
>         /* Is this valid ? */
> -       if (cpumask_any_and(cpumask, cpu_online_mask) >=3D nr_cpu_ids)
> +       if (!cpumask_intersects(cpumask, cpu_online_mask))
>                 return -EINVAL;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


