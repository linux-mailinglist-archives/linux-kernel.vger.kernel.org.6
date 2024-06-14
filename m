Return-Path: <linux-kernel+bounces-215477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C99909357
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9924F288138
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AF1487F4;
	Fri, 14 Jun 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJgilkFU"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A760DFA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396646; cv=none; b=bAVxHvjpWJzH+TOLmbyD+z2NHz6hgJ/kwas7AWoySavRQmd3bTOd0DsKKMXa7QTULhVzYFnzXcjoP58XXNoqKYWjczbDYy9igpndjLZPm7ZSBA+YAk17KeBqwdh+H2s5SX+o9oAr+XfUJziZmwDSG2eXK18FlpDFkY6Lozk2Txs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396646; c=relaxed/simple;
	bh=ZWrw3butiWjOLPjkXlESkdz/5W+n6p0ka63sDmIgbZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkTiO9SV25VIfXSFU0uJiPdbxh6O8oZyejbjNyoVtRLxiUnlqD+8Bm4Gnh7IicQBS9D6KE1JMe4y/iWDA1/cLivtIqFtW9Ji7yAcZGXHSCevY03i/8s8b5MfMOh18z/1++uChnyiTHHG8pn5YP2XOyvlssT5ZOiaSryzB/RGYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJgilkFU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b06b78e716so16296716d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718396644; x=1719001444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWrw3butiWjOLPjkXlESkdz/5W+n6p0ka63sDmIgbZQ=;
        b=GJgilkFUKkh7mvZiUE/qBW/xKjgoM8Wfu43UrMddiqckRjdnY64xtF0pgfs4YYx8Vc
         8QmrMe15xVWDEen96/1MbMNe2FYN7ftWQ9w/W2ungeFNZJLLkMXtWhQ5zmvtcUSWvimA
         ojx+TbVFXVaY0BUo5o+jml+mrPz35lnn3ltEgcqmY414iJ+EuGcdqDDvs2vWVaiCvO3R
         zXXiFyefPFPa7Uj1RzIPRMK6kg8m/1hRu2HbiOg2ZPvXwFrYrxIxuNo+hQK2KGO3EPgF
         fnrWCkdZ3+GngP4h2FgthBWDzdgdtJtR6EqRit3s7iOQj7V+EW2A7YGFVN+gyOn8v/Hz
         7I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718396644; x=1719001444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWrw3butiWjOLPjkXlESkdz/5W+n6p0ka63sDmIgbZQ=;
        b=i3Phv+sQkE9sc53uW8MuyKqkjYPf8ox+aJZiZRePBJjjdXalPsM98wxenkmMPhEoD9
         XAJiN2lnhBdrLMC8TNZJndfvyT7dXpg9D3hQuONioUL81qxlwkyc9xDSzO3pjXOc/7pV
         qx9rfN2o5Jygr4hDN6vwAbBlpMBnqu2lMCZlWqXTBgdJ4WAZghBwzz7ciE0uMbvOYP4q
         DDP0bsRG7nLaRr1R/rwcHkHpbnAMsQs7p6JCW42wEudFOvDJ34gDL26F6n7cTVQj3hsO
         ul6v76ZZUK/dCyVaEsiEJTtb9VwXHGwdzzJPJ1IvR1hIcKb/wEq6tHTUWmicMRnqJkNe
         LmBw==
X-Forwarded-Encrypted: i=1; AJvYcCUZk8u5ww5PHK2sQSrQ6ywSC/mMVMzzDehIvjMTACtzoMIY0GFBvSz5mJIzOoeDC4ls2ALbv4rZT2Q6Ru1C2Zqq9MRrOebC5AnJYVsX
X-Gm-Message-State: AOJu0YzjcYVIZN9KBgkufqXCIB/dAatVm5myZf4g5qtoUM1bp6TPr5zc
	ZduA6WOsI5T6/UykUm7aaiucsb5TamxqEkjclXvbr/BxMCb37rsb0/ndZxj3kPTti29ic26518u
	2HXsB7enGY/hmIODx00EVW+mI8uqQkg==
X-Google-Smtp-Source: AGHT+IG6Bmp99MEbT4YNb5gU213CyLosXWWBrsjdxJ47G76bQCqBHRpQfbxZB62ZH6eD5CJh6WydnjkXHK/E1oYRod4=
X-Received: by 2002:ad4:4e82:0:b0:6b0:789f:9ce2 with SMTP id
 6a1803df08f44-6b2afc7931dmr35757836d6.2.1718396643629; Fri, 14 Jun 2024
 13:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100902.3469724-1-usamaarif642@gmail.com> <20240614100902.3469724-2-usamaarif642@gmail.com>
In-Reply-To: <20240614100902.3469724-2-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 14 Jun 2024 13:23:52 -0700
Message-ID: <CAKEwX=NF00ju=gY2QwcJvJctDDzni0c9NdTcF2ajU-geFrMdxA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
>
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03=
d1344dde9fce0@epcms5p1/
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>


I like this version a lot :) Really clean.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

