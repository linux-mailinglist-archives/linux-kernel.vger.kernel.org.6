Return-Path: <linux-kernel+bounces-352423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584E991EE4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F34B21426
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66729405;
	Sun,  6 Oct 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="a7wAsigS"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135E1CD3F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224940; cv=none; b=B3EnpI5RHyaYA7etaGixAQL5Swzl37zojTSStAsle26xUfiWegHyC8q0sLCUK0UiAW7BEeD2qwWovi2c/EDsF0HD1ckniM7B3bPqcZ+II8c0U58+PjBeIppbZnhDwArQ4tjsqwjRnhlDh00BKQQID9jc9c8yawNMmfsP+NO66RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224940; c=relaxed/simple;
	bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLt9eBWNS5hEqXMrYc47npaTmSQYxs9SIlYIJai7mEbU8zC5QCIXhF4Z/3kK1f1KTW3IF/2w/TrHdSX6pRqRy41cZNSt43+CMEZ2NkgjtO5yyseUPqyYetjz31r9f85s2+sd8ZbAocF6ntdJUSKT43SJTQe4anVYXWATZDKgGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=a7wAsigS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso4771451a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728224937; x=1728829737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
        b=a7wAsigS5KIW3PMQtmb31aKgweL8Wu+uluAFdSiVe7P/vEPZT/mXnWkMEPuWFnvNUC
         PyLAMuIuUjt5jwDR3UJo8Ncn6+TXiBmPYskawrZ/Pv/3Fn65wTUUQmR3CCSzhyTM40nv
         1yODh4aQqQH1NwsFvMX/Xa0wanoMLES8JevOc21PZs9URxAsn6RRGLGSDgw+gfkFqjsG
         wXhKLDing37MOZpsQic8c5ZlJDL+heLllM6w/DA7O75EAC2gaipoYqILxiOtKGQ8YT2I
         q3sUmqQVbwKJ07Xg2r1yX+ThgHmgwZvLJWjnR9cr3Z2rIiOhosv+rNAYlHh3/ORFT4pO
         a+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728224937; x=1728829737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvh1VNDKgVQtS0kqZZTJM4ITFk0EyN0F03KA/hlcgRk=;
        b=rNkaplcV7Q0nTOm7mjAH9PQXSK7kT5ZHm/qrEwFKxu8EdwWbMZIoGRIzz+q773Nn7D
         ww/8UcGizkl8YjAb9vOiYsAawWmt7EFGiOMk3YTs2+3IC4CbrQPCSEy+01gYBKZq+qVO
         yozd2WGPGvjDTkam+k9oKji4EztiQqAtPw8VRtqpHbn7+c3xjacNGKCZNasXjMmtqgcF
         sls1LPG9mAlArVFAiUli0ZCJYzBfDk9Gmk8LPMIR7RMpm2m1fvGfI+Y3wMIR4kVwIbQA
         a43AtRj4oHIPCf8QpjjswX5McP2LBY6h6tcwB3iqnb1Z6CGesTQ71vv4bsX/lgMW+H9A
         aa+w==
X-Forwarded-Encrypted: i=1; AJvYcCU5z2lMDfkJZAeyOU0bbxKQMAWTeLJkwnXk72sHN+0adrJZTsUk/lYVtzeo/F7m4QWdBapzT6N5QCWp33s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXBy9faD7im9bKmwgV62p5ur21KZMLhGDp6JKq6YVIY00KiWU
	WAkzF9h8eDYpNVkNnsal6v+g6no780yXfHoTk+W3box/P+qXUVJU5laUtdUVxKZdwa5Z8gdqZU0
	xJ9Og05ayvU/bCKePoMuHQhuUY+9R33kxczvV0w==
X-Google-Smtp-Source: AGHT+IERmoeIAzbY//wPQ0ALN0hsGZOsI5Ri64LPZKPMVqcGOVQM6SZuK6lN209r8+tDeh3E7y0WZX9FnBRU4TONBKA=
X-Received: by 2002:a05:6402:3512:b0:5c8:97dd:3b03 with SMTP id
 4fb4d7f45d1cf-5c8d2e9ef80mr6600615a12.33.1728224937414; Sun, 06 Oct 2024
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-4-yizhou.tang@shopee.com> <Zv1OYxSYWUHarUrL@infradead.org>
In-Reply-To: <Zv1OYxSYWUHarUrL@infradead.org>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Sun, 6 Oct 2024 22:28:45 +0800
Message-ID: <CACuPKxn=XaJPcANC4VwtSX63EaVpYJA5FJ9mcN+LR+XmMpASiA@mail.gmail.com>
Subject: Re: [PATCH 3/3] xfs: Fix comment of xfs_buffered_write_iomap_begin()
To: Christoph Hellwig <hch@infradead.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:45=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Wed, Oct 02, 2024 at 09:00:04PM +0800, Tang Yizhou wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > Since macro MAX_WRITEBACK_PAGES has been removed from the writeback
> > path, change MAX_WRITEBACK_PAGES to the actual value of 1024.
>
> Well, that's an indicator that this code need a bit of a resync with
> the writeback code so that the comment stays true.

Thanks for your advice. I will rewrite the code following the logic of
writeback_chunk_size().

Yi

