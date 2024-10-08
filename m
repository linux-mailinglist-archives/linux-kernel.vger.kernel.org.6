Return-Path: <linux-kernel+bounces-355308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66AF995057
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B92C2828FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B91DF97D;
	Tue,  8 Oct 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BxVnlhrH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACA1DF736
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394765; cv=none; b=OgajrBGC1Se86CFOGvTvx+X2I62VbO0CyP5k7rM5tn+zDubsZ4xudM0R+kma5c2wFg8tZ4TmmFE5lm6p1nBxA14aG12DTlTzjoIi3fvHKQqGAqpY/LOJo2h6DfK2tLTwfQ4QtND/oENmiIpJbk0wUY9FO/81L7PoARIVxBzNncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394765; c=relaxed/simple;
	bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqXxz3U5paPwo+stzesJ7N18co+BSzJs4kvaPf0d0vF0bCHwX2Maz7klUnJAQwUPAU6ZNuL0WS/XJScUAcautpMEkPfKrtz34HW1PHSknVv80RYAff4h0gFixhhBrZ/2SZRF8P1kdbi27cDGWlCWwOb148GarDlj09y5kUaMJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BxVnlhrH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9941a48ac8so400328066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728394761; x=1728999561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
        b=BxVnlhrHM2jPL78/kLZPAJskamoJWuLxwfQxXTfNfeZTc7tUG9eVBcjXPjn4StY6xH
         QDS0p2AnBisVFZ/5qUoMPDzOSuZHkHLLjcUsy7d+pCNJz7sa0XrLPN+8eT5x1xPiziQR
         PrrnBuB468d2/K8vhjOWxorzGpXOLAh1QvqTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394761; x=1728999561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
        b=pZhxhUuGvBI7rUCn3uQ8nDPJQeIOsZ3SWJIUbHOtP573Hg9o8Rpcz9VF9YW7SHQ0yt
         F+fsKJ+wQHO9sQ5agzf0UgeROLJbynK5+2Cw8DN03BtaB7J0GfU6bgicNnXJN6KfWn7R
         fZuuUBGYRUE+WDC+jCjp5qREhL1JN0xCig4ptr5vXWUafUF3YpSHhMsv10dYbczZfLdI
         iZR+jRO3QfHXvVcZi1GygVVmLXZnSgC+CGdmMhqkps6R8URxyoWAGipuH7GVNS5zSE63
         1puhJ+DZYaoYp3+m+KAoH8IjuzmmTwW2PtoB/l0E4wLvbDigj01MRHcfIBj4ZDm4kc/k
         quNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rxjtk3Mkmaz7fkramO8KgxfFwiJd9WiTMyl8tW9McNwd/EytNQzwR5ShnUXRJBr/ZSI4zEeeNus5NEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtT23iJfrEKfau/OTqZEJWZ9FFA9ZZJArVfQicDtkKBqPDuqx
	2vIMii/TDpCy+nkyNxZpPc5cvAYSn1vHBBPGXpkLHZald56tY/ZpseiTGzliZPgSg+1Qxvx+LT4
	kBzEGUOp6QzySBeQzzAX9/JJK2G7/Yg9Ij+K/vQ==
X-Google-Smtp-Source: AGHT+IGdJR4sHkDLpXK706MeQSJQA8wuiHX1WozZr72hURRz788pd/e+TCc9tNm3xWJ/iS5zYWJT8vj1i0hN7Rpw+bk=
X-Received: by 2002:a17:907:6d20:b0:a99:3f6e:2da1 with SMTP id
 a640c23a62f3a-a993f6e2e6emr1016488366b.38.1728394761064; Tue, 08 Oct 2024
 06:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
In-Reply-To: <20240831093750.1593871-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 8 Oct 2024 15:39:09 +0200
Message-ID: <CAJfpegshz4_Cjj5imF9mpY=8JSGU1riBZJr0N0Jbb3ZaP9aubA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] virtiofs: fix the warning for kernel direct IO
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 11:38, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set aims to fix the warning related to an abnormal size
> parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
> use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
> Beside the abnormal size parameter for kmalloc, the gfp parameter is
> also questionable: GFP_ATOMIC is used even when the allocation occurs
> in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
> allocation is initiated by the kworker. For more details, please check
> the individual patches.

Applied, thanks.

Miklos

