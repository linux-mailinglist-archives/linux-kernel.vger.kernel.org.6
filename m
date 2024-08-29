Return-Path: <linux-kernel+bounces-306559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014D964078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E245D28186F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4818C90B;
	Thu, 29 Aug 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ouPYeu28"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F318C937
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924637; cv=none; b=IbewqBab/4Dfuz6JmogshtBcPoXhb2WfkBHLpB6dTQRbzOwuw7JOsiDz9wqPsqyUZqoE9QZup/ObqBmlOHMfuniASGLitHfwQjVv6rqj1f8OPWp3KLvkIZuTWfPrBwcLHgC+YpZIhc3yRNdlvBAI5UDmQIQOXWqR2jQiw9onD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924637; c=relaxed/simple;
	bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT5TT/Ciu/i2UlLOCg/F3L7uMseeP58QIXFEwSj4KzW1MfGdhn2ahwcehkf/J+kfEnz/BhlEBX5eRCCGgqGTa91ob0rMQQZeh8jiZt9+0eVgcHhAty5hUQPGvtxxbZVDe8o5ieWIqH1bMDWzQ2MnzhFk0F2MX1z0U1SGBeWUNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ouPYeu28; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86883231b4so42417966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724924634; x=1725529434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
        b=ouPYeu28QfmfP8rZfXqgKAOzq4gi1aF/Mxbiyd9Vm6hBQcWsuq8KotSXL+e6+Y6uKh
         kd98Rr/8kRSNZBkINQ6FiOs98oS2Y0PaFonpPBEBP4/97ICpjP4FmTXXRO7nHuH277G9
         kNfabgksSs1hZdmXh61HTh95WIw4z0V296QnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924634; x=1725529434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
        b=cK4sPb7DBlv1uovRc34ccxXDWeY7U6Mj2UljMYZe20I8VxdrGvcpcpdp+3aA4Cr/vT
         xqv+bFXp3rOM3ijwyt5fLGoJDOwqYle2oCpNPQCGQKKpS19Ct4iFWSlHOftRaEIa3EDk
         Z8LneRJ7rj4Sfd6FzCi/OX3D8393Pfc90gfcai2VE+685zYefoBB2H9ZbrTZ0VrXftNA
         kRniM+8Q0q4ByNO0dO3xuCnnNx3ymtdQQdw4sfcV7DHCIy8TTcXbgZSOeQdbh5HDSxHl
         KOyHpxLdruALQgOVmz4bmjtFvH9BGJ3aTPs6rSpFKsrJsbdF2E1NNRGdkFwxtEPR4gVQ
         uLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVfFiHZWnVOFH8Fco8mQMiEmgFw/zDn0/IoO7rTyWXOOLqZ9oPnABYV9pmbMTiSTjL9cjWyBL9jser1rbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNJ18XER2DT3wvendw8Gb7iK3yK2lHzch+QmzXzHM/K2B4nRS
	WMWijOXyNjHYzHxEglqxWClfHj44cOABp68Ztr5jt1lZEgG94BCBrz+5f66+mwDxZq/t6pM8lYi
	IoqB5zIg6Qb0gQqu25BZBG1S96Jqawdv8/aB1/XQeFKexsZdd
X-Google-Smtp-Source: AGHT+IHsNUkYXjfU1oM+c5YkSz3TMi9+2UKHgA3/7MACl7eKulH+vN+TQMlnBEik3EWNhJiL3d5fjhwJ5AyvhnwieYQ=
X-Received: by 2002:a17:906:794c:b0:a80:bf0f:2256 with SMTP id
 a640c23a62f3a-a897f7821d9mr162353766b.8.1724924633804; Thu, 29 Aug 2024
 02:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517161028.7046-1-aaptel@nvidia.com>
In-Reply-To: <20240517161028.7046-1-aaptel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 11:43:42 +0200
Message-ID: <CAJfpegtBjy+ns4e73B3qB2_U82wwuq33LNcFuHtfMy9agncaHw@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: use correct name fuse_conn_list in docstring
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 18:10, Aurelien Aptel <aaptel@nvidia.com> wrote:
>
> fuse_mount_list doesn't exist, use fuse_conn_list.
>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Applied, thanks.

Miklos

