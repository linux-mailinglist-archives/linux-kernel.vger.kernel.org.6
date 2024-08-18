Return-Path: <linux-kernel+bounces-290988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740A955BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FB3B21514
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3D17BBE;
	Sun, 18 Aug 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSVb+BO7"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888217BA0
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967950; cv=none; b=sx/FgEQfNABmXh93THLra+Vu15uTY4Oz9tcJkwytwfRs2mG/v2VUDSWOY2pYYZRXDlrLl6wfs0TK8RU39vFcrgFy0X4sMST3o1v3OEy1ni521dbbIpsaQcP/meKSlTBShaKubo+0IbdnHeaDv3fsEkkbIKBYvRNye5lUiSSFn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967950; c=relaxed/simple;
	bh=MwnpCKgQiCzsZpoNRCnCDpACPOCmhsbUb+ZJJVr+V3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lR5eNZkbjOV3iV2SQv5nLU7rN0L9xp9/gqXuPhOxwkMvNVIyZsvKk4A2Y4QaQ64dJo1Xh3izrJ9YM51PBaSk/sm720cVGBBeXUL29Zl/Ri1NX5vpcDF1bpRVHeXKJIphL1P0P8Q0RtD1cd0E4FcPkOFcrpgdkZvZQIjMuusUWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSVb+BO7; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928989e272so1290299137.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723967948; x=1724572748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MwnpCKgQiCzsZpoNRCnCDpACPOCmhsbUb+ZJJVr+V3w=;
        b=YSVb+BO7Gci6/H2V/AYka+aLdXzLAb9Gmhw7DpZpncfbicJVkvS6btoyGCELO+w6lm
         4mdc/HXxippbZ6VPjTRt1NokJpaQrBZIN8bjfVsIvzLA0axZqo/EZaZX1w3hd9uiiVYj
         7gi+41EUl5jmBQeE2qS87v/uBwIaeiJmK2zdFSatj37iAqLMb4bEzzjrKPurDKnjtX23
         snmHgPwkGF72DznNZ7niy14xtkesRaSVaW+ew2U3sXavvYPDtzYEmao0aN3TqCz+0jGs
         XocfNexwA/Ymx0+RW8BSZFeXdQVdaz0k8Poptk6dx0YEgF4VrjWnzxYkrwdwT9ckbjFg
         exQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723967948; x=1724572748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwnpCKgQiCzsZpoNRCnCDpACPOCmhsbUb+ZJJVr+V3w=;
        b=DS7nMERqhMby9s7AwF0zoUxQWITjZTNI4g3dKn2MjOMeAce2Fb5K2lRf66I8g+jBsK
         Zk1Z5Q2g0ufKoDfyOwG3cihyv1/tO1b5WZS6uNeM8Ndidjj+GJDOHMqdYtCa/V/AUalN
         Ed07pbot0/UeSyuvpPFnPLrqqXhDqk7iNgqzOxOj3rpN/AyvEPTXo579+D0Oxk0wGLYW
         x0Kc//E5BdxMsNhprj3JPYlJBlSlst+7jvtyb3yl4QKJgc3RrQ1XrGeWg1B9UzCzPWMy
         DdcRQT9PnnWr60L3gaEhgZP6Mba7Ucrkf8BEHylubIbWUjyMR0wzGusg6FsvyqFhDpp9
         U3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW16g8hwzTirig5BUcJsU1YG4K6YkOZvEcRUvarOz1147BvUEG7+aHXfc1D0SQKHQUE+tYeaFzzKmjiGKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZC8RGCyjlhkvtVnHuruhF9JoJvOa9frhxxO0AHQeXtLY4QQ1
	En+hDw0ZHZM8D5tHN5PZK21rinhuMnO7qfnxEowuBT0AtacLTsRc6myOVOaQ24urCH6h1/3PzN7
	WlTclgT8hLJhKskGUJMdmTKhkRHA=
X-Google-Smtp-Source: AGHT+IHSfiSmxxifHMC1ZurHvaoB3jd8EcGU18ZwRGcA6qOeuPq/bpMmU/f2vF7D1Vw6sBg4IAY0p/52mF0wxCjrPzU=
X-Received: by 2002:a05:6102:374d:b0:48f:b1d3:4890 with SMTP id
 ada2fe7eead31-497885ba5c6mr4795172137.31.1723967948141; Sun, 18 Aug 2024
 00:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com>
In-Reply-To: <20240811224940.39876-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 19:58:57 +1200
Message-ID: <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Usama Arif <usamaarif642@gmail.com>
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, ioworker0@gmail.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrew, David, Usama,

I'm attempting to rebase this series on top of Usama's
[PATCH v3 0/6] mm: split underutilized THPs[1]

However, I feel it is impossible and we might be tackling things
in the wrong order.

This series should probably come before Usama's one, as the new
partially_mapped should be ok to handle both nr_split_deferred
and split_deferred. That said, the new partially_mapped still has
several unresolved issues blocking my rebase.

[1]https://lore.kernel.org/linux-mm/20240813120328.1275952-1-usamaarif642@gmail.com

What do you think about this?

Thanks
Barry

