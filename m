Return-Path: <linux-kernel+bounces-348633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C298E9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAB3283C90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4107839E3;
	Thu,  3 Oct 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PETeABPv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB142A8F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938669; cv=none; b=HbZyLkehWjWarCQDkX6qkXNKafOiJyMe1Myyr3pfT73gJFG5qbj93Zh6C6/hCmmUi+yWnx/dQklHvXRqsvLMcAvRqu2zwmqtRMsENfIkf0oJrm+s5yMoUgQ5r2pccSJl89pzDOcEbm7RMc+THZx9sjLeVtX/WZiO+A9UfjDdH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938669; c=relaxed/simple;
	bh=oHxgNAg/d8qsRPxwf4s+VaLr3kQe3rroRD1BDVg+gM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcm7J9RysfH6m9NUlC6YO/N+OG8ZzIex+4FNGZV258g/8jfjm5c3v+ZUcAws0ACmnVrdOiddy9OISDUfw0VQOCw0Ddc8ZTjwUQlLoWDKegijuvyv+JJFWDfw5130d4k/d/kBeJc44NV/2wKJvu66mO2CHFRxBxvos6w4ToqLE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PETeABPv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso645980a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727938666; x=1728543466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGecQKR7ZoIYH4vaHNJNV/6/ajVJtBZfvfEOkIG81WE=;
        b=PETeABPvE02tj48SuqgWrYaiojzo1ZoaLLa8gUQmbyS++Ncc6XQTo5OxSBr1Wq0SIq
         3sDpIT8clE0/WTqGFmlvPAnNlwOMf4xT8alBV2HPXzk2SM8dGiw+18N8Qw+ABY0RNB4s
         3ZxsiUXS5LzN+kEG9B7trSuGosFg1XVKNYgoLKXs1H/01uD6ePF/2xeS/yCCcJbu4tOx
         C7xyp6HSzQ9FaJzcXG2js60v84ed3k7luEoGl8iq8CMtIZnL347GzYfmJHxHKD/rk7+k
         PK58/dMl/epdpv18BqrgMfUhLndx0UUXtjML/gZcxQYPjIww4BW60owM/ifDrLhTVSvZ
         3Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938666; x=1728543466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGecQKR7ZoIYH4vaHNJNV/6/ajVJtBZfvfEOkIG81WE=;
        b=DRxWCQjTQhQHvgWgALtIwgszanfOmgq2ncuve3Cvt6zRNvJa6dEnPVtZjBwyYX6dNd
         WEhud+wXSGhekV8QvFbDS2o1Edr7YjhVCGjR9ap9H/kcVHzP0TlQWjy2MFw/OzQUJ2Mu
         y5xu0mmpRul960m3tFKQbap3VOTGivJFKcZ6W2mOuYheWt5uB5v/sfsjyKd18mgwuwls
         0MblUUX8Ls0YhH30SmUrCG3Kn5TgbJfIoKpfPLKQ7ptVjHjamQyLgjNtadf3X3Hm37Ah
         4Kd7uGk0fuEnrXRDhcNAQY7DHR3fhmyVGBNIM1plwBpDIGv51KcXjW4mOAk8pgfclvSR
         lmmA==
X-Forwarded-Encrypted: i=1; AJvYcCWfuYyEOoAIyZkzoWkgD49p9U/hTuRzV67TOi2gY1rfJ898WwoCGZ0sLsM6iucZYtLrOgfPR4K3V6Glr0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOd19vQEWJdN1EU7FDYg2h7sSTjL2hY2dr4qUc5Vp6yxTsw2M
	GLyhg3bKHyguN0HEpMjS1aaGw+qFFta6/I7NIRFxDQYQx9sBilNX4dH5Npw663oBr9Zf7i3+JOe
	L/A2SRLF/HR9VypgUECF6nq9sYiH7cBtDToUFig==
X-Google-Smtp-Source: AGHT+IH4QGNNGP1NJcTcHJDWHlXA92zW2AJIpIf/rMuRfbu+fTqO/rDiEJy3cDA2artuxJKreIShbOnY5J0XVGAbl6I=
X-Received: by 2002:a05:6402:5108:b0:5c2:4cbe:ac1c with SMTP id
 4fb4d7f45d1cf-5c8b18eed8fmr3645435a12.4.1727938665602; Wed, 02 Oct 2024
 23:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001174611.12155-1-quic_pintu@quicinc.com>
In-Reply-To: <20241001174611.12155-1-quic_pintu@quicinc.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 3 Oct 2024 12:27:34 +0530
Message-ID: <CAO_48GFPg=R4JaSZtgTKjh0TLKTrw24AF0nRMvFRXxwYCP28fg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dma-buf: replace symbolic permission S_IRUGO with
 octal 0444
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: christian.koenig@amd.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org, 
	pintu.ping@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Pintu,

On Tue, 1 Oct 2024 at 23:16, Pintu Kumar <quic_pintu@quicinc.com> wrote:
>
> Symbolic permissions are not preferred, instead use the octal.
> Also, fix other warnings/errors as well for cleanup.
>
> WARNING: Block comments use * on subsequent lines
> +       /* only support discovering the end of the buffer,
> +          but also allow SEEK_SET to maintain the idiomatic
>
> WARNING: Block comments use a trailing */ on a separate line
> +          SEEK_END(0), SEEK_CUR(0) pattern */
>
> WARNING: Block comments use a trailing */ on a separate line
> +        * before passing the sgt back to the exporter. */
>
> ERROR: "foo * bar" should be "foo *bar"
> +static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
>
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +       d = debugfs_create_file("bufinfo", S_IRUGO, dma_buf_debugfs_dir,
>
> total: 1 errors, 4 warnings, 1746 lines checked
>
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

Thanks for this patch - could you please also mention in the commit
log how did you find this? It looks like you ran checkpatch, but it's
not clear from the commit log.

Since this patch does multiple things related to checkpatch warnings
(change S_IRUGO to 0444, comments correction, function declaration
correction), can I please ask you to change the commit title to also
reflect that?
> ---
>  drivers/dma-buf/dma-buf.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8892bc701a66..2e63d50e46d3 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -176,8 +176,9 @@ static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
>         dmabuf = file->private_data;
>
>         /* only support discovering the end of the buffer,
> -          but also allow SEEK_SET to maintain the idiomatic
> -          SEEK_END(0), SEEK_CUR(0) pattern */
> +        * but also allow SEEK_SET to maintain the idiomatic
> +        * SEEK_END(0), SEEK_CUR(0) pattern.
> +        */
>         if (whence == SEEK_END)
>                 base = dmabuf->size;
>         else if (whence == SEEK_SET)
> @@ -782,13 +783,14 @@ static void mangle_sg_table(struct sg_table *sg_table)
>         /* To catch abuse of the underlying struct page by importers mix
>          * up the bits, but take care to preserve the low SG_ bits to
>          * not corrupt the sgt. The mixing is undone in __unmap_dma_buf
> -        * before passing the sgt back to the exporter. */
> +        * before passing the sgt back to the exporter.
> +        */
>         for_each_sgtable_sg(sg_table, sg, i)
>                 sg->page_link ^= ~0xffUL;
>  #endif
>
>  }
> -static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
> +static struct sg_table *__map_dma_buf(struct dma_buf_attachment *attach,
>                                        enum dma_data_direction direction)
>  {
>         struct sg_table *sg_table;
> @@ -1694,7 +1696,7 @@ static int dma_buf_init_debugfs(void)
>
>         dma_buf_debugfs_dir = d;
>
> -       d = debugfs_create_file("bufinfo", S_IRUGO, dma_buf_debugfs_dir,
> +       d = debugfs_create_file("bufinfo", 0444, dma_buf_debugfs_dir,
>                                 NULL, &dma_buf_debug_fops);
>         if (IS_ERR(d)) {
>                 pr_debug("dma_buf: debugfs: failed to create node bufinfo\n");
> --
> 2.17.1
>

Best,
Sumit.

