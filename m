Return-Path: <linux-kernel+bounces-377058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF99AB95A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E122844E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846581CCEE7;
	Tue, 22 Oct 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb76ho8f"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9613B58A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635024; cv=none; b=Mqdtts4PrzpXU556U9FkYYMaaGpDXXwb5UqL+7i8SByQiB62xXshv21TYYQ1ElqRF4qK67YLez3z4jTQi0+yS2QL4reb8X3/VV2QjPjw5/8nGabTizZjLFxS1+qOPEO3jJiEkdDl/rrE4heneDX6hp2477UPkOUQyAn+wJ3fl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635024; c=relaxed/simple;
	bh=a9IYrBS4FpIqfUJHez9sndCjnvvE3gyt7XfLWF/7Rng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhd44AxiojCv+zrTyD5U0LbmN3zfFcu2x9kw+ZUjXDDVtETDV/oupCo9L8VBX7nCyjuNoP7wwB93MpAEghVg8UE3TtJCVaW6zcc79b6W3RkJ3RvpRStVTmWDINfgpbvkYlV9knOgbH4F4Q/CRdIYOI8meWqe+4vQY6teZsNu48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb76ho8f; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7180a5ba498so2783060a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729635021; x=1730239821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9IYrBS4FpIqfUJHez9sndCjnvvE3gyt7XfLWF/7Rng=;
        b=Sb76ho8fi64XyWsJ7X8sOqqSxmKjM36CkD+FvBC7m2n1Vwah/RYy28DcQ0Ris+0gCc
         HWQjdLWZWjsdPdlw2Fmvnu7oDcEh/8ldwyP+Ah2TO98Nbj6iSU6nsc8kQqcjMt/QWmP7
         hz5yqpZon2TPXkurq5nQd4UXyaYcbRSjPAkTbVQG2KLirKgrq710Cuw4aACYnc/zYJwl
         lxDkeUMa11bFoMb7fRwmmj9YnXkwCdQGM3jWe9eOAqpdUSLwUaxemSy01Z6KbXFyQ969
         wNt38nSQk0PZ8C6BXKe0GIgO8z4ZFUu0LQ5q//aGx+aIN8WotdCUVIqYc4W/jtHLqvrQ
         pGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635021; x=1730239821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9IYrBS4FpIqfUJHez9sndCjnvvE3gyt7XfLWF/7Rng=;
        b=KpwZ5CK+U6oQ/+Agbw0k+F0ygIqaztoMlVtR6u7zYeU73KsNF5NcUvZ12hMMQcC32X
         HWuf3ID9987fHOOM/p3C/w+qZu6Enwqu7WYmoW/r9LJsNlCt68J2n2PPzd1YTWnyz3hc
         PyBnHgzGotcAvT0xMdrJIfsCtv1q/88oVwwjZTQrIvG1ebIMsDZ09cLBxLdzbipGueZg
         qkGsn94M7xwo2dTJDvfw0pFG4UXsj7hyF698sJ6fbgREMrSXIcr2mGGl8Df7SX0A8vr3
         UiDupaPLRFTtv1pcUnRV3qf8SX7EvyVUbRlKl9IH6Gf6O73jCaWPPv49YqzuGsmRhIwP
         tmjg==
X-Forwarded-Encrypted: i=1; AJvYcCUHJeofGRj0j86jsRgl0+rcqMdnFyFpYdSRZoXD0isbF7sf+Hbukm61RvAyRNEGjkcVdtL2+MYDQjPhOXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG0XTVWLXy+GyL5i0yeVVhww+FgyckDoQj7CZskyain0HWaHo
	QyhKtJ9cnj2prCrv0G8Ne91H9G8Cmn5NJladB/9yIOcO2tcHDDcz3pz8wW6QgSxUmefWgcrsxfm
	wbG9GYrJTer184NIadD3rhRVEC/WR0w==
X-Google-Smtp-Source: AGHT+IHJ/4VDrnVmJ1ae1YwcM1k12ymdIbxxE2bls78DYUCFsjtWp3LAKoKevSP1AV/Bnmh6Uq1PGCqrnlj/s+omfP4=
X-Received: by 2002:a05:6358:70c:b0:1bc:59a1:5bb8 with SMTP id
 e5c5f4694b2df-1c3d80d33bdmr53816755d.6.1729635021644; Tue, 22 Oct 2024
 15:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com> <20241018174114.2871880-3-Liam.Howlett@oracle.com>
In-Reply-To: <20241018174114.2871880-3-Liam.Howlett@oracle.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Tue, 22 Oct 2024 23:10:10 +0100
Message-ID: <CAKbZUD1wuosJM_ZrLfaxFQqd181SwSA9=bF6v=PGN00JjVXB7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/mremap: Remove goto from mremap_to()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:41=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> mremap_to() has a goto label at the end that doesn't unwind anything.
> Removing the label makes the code cleaner.
>
> This commit also adds documentation on the function.

Thanks for the nice cleanup across this series :)

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Pedro Falcato <pedro.falcato@gmail.com>

--=20
Pedro

