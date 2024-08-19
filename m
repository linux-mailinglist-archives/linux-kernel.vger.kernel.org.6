Return-Path: <linux-kernel+bounces-291854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538B95680E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D9A1C21615
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908516193C;
	Mon, 19 Aug 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIONgEGl"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AC1607AB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062561; cv=none; b=I/AENcPCemmfWeZNZmWseMdiPSMscWuuvLkd5teXPluSohUZo9ysWK1m2rurpCeO2a1LcPLvxh4adS//8poBdxHNZaEri9yH5JrAyZyx7nZ2D0K0xTb945Sg0Q7oNtuEtd/5GmiRzDVCnsKpgxI2VBg9oxCZo4h+S2rFrFFcKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062561; c=relaxed/simple;
	bh=nANsEqLIgPJNcu9quUSP7ATZv8Jx4VYpsDGTH5gD1oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmtEii13r3QU+HDnan3aBaG2ng/cwc23zSODy05/RbMVPbsWfQ6mYQxr48SZrF1DTgmaDqzqe4gYyRx8rQE3nS7rUb5YS1Ucj/R+b5e4X+ixVxKSdoP8/zoBrKGcXthk8H94AuslgihGUK7PmI4wWnrAwkWarc05huwZszPQqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIONgEGl; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso1663184e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724062559; x=1724667359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sa2lODxveZ7v5yXJROcCSh4jkb7CfMK4iLTqO/U2EWI=;
        b=PIONgEGl0JE+Cwm1/orsjOnvCf7ph49+mfH98ERRa5rOR0kDIKOi4aU7gAg0Pi7geq
         iN8Rk70THmGFwPAHahaDS3CxrhaPZIr2K72+hx/S7E6fYag+OLokzIavqNkbJ3DnVHPk
         cN2XNntd1JYiKLTgXm8TFO5JgzU/VSnAl2MDSAgpVbTmWbYxyrZmxvwrnZPhHN/suW0T
         klkAKDDKV0bHrwFvs7MC9LDXGUeF+jG7ii/GVC2UgslUAfSt/gCD7sSUwXVvTlEQ+bxU
         vyIswzO2h64MC3iaFuYiyv7MrxP/BHgMQbgQyUDhJ88r/K4wdcMp8jiH3z7+8VsYYVWo
         PQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062559; x=1724667359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sa2lODxveZ7v5yXJROcCSh4jkb7CfMK4iLTqO/U2EWI=;
        b=KEHcFzrFHswHaR3fwiQ0cD/XAG5+qehA0l0hfNtO9SHE5lCAhCA/DxxbQGv/MQqspe
         fIHxHuqlIvFI117rRd2io6Ij34IjSzTTdUl1z/OxsnvKrk+IVEKXMiYn42l5Y2JjAooC
         FtjqVioqJ2lC0xt+G62wAE1ub2kxuvJyxsk6pVol5fwsPMuf7z2nw61SCa4bBsc55o4z
         I/KLGuBFZ83+dVgfdna/mySy5A3VBL99WFnaothv3UpXUg9z87biAPnEyKywC1TQWAN6
         zLZnzBAbJpSNOLmpmlbHi0H2lRUJh/COa2ZPR5clJ5xX9psDjK6vQ8qpdMgE5v9V9eIg
         4epw==
X-Forwarded-Encrypted: i=1; AJvYcCW3+O3UU7Sl8TryV+CD+PDqbYKeK3Qjn5WqcY2QhrS2GgKQBFwdjom3kH9x8p18Z/pcouiHYlsPiWbeYl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDceHA8/2Yy+QxEsOwFbHrLNJfBz0a+7VR+z8dDsoX5XoDne+
	FkchZVk9edozt47fzSWswGpkREIPox6MX4Q/FiztSFeJo92WTVuzrWGdRDYmBWUvUxyg5uYkkkG
	aZ6murbvBzrD7wXBwt+lIhbo2HH+P6eUrhnNKpg==
X-Google-Smtp-Source: AGHT+IFCsPmzV94E1oL22YZOQLjNqffxEp+5JZ7SruX5LPi1CMN5a9dPiP22C8nBnuWQWfjya0hWY6fDFAAH9KV7IAE=
X-Received: by 2002:a05:6122:1797:b0:4f5:1787:18aa with SMTP id
 71dfb90a1353d-4fc6c221f99mr11922575e0c.0.1724062559333; Mon, 19 Aug 2024
 03:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
In-Reply-To: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 19 Aug 2024 15:45:47 +0530
Message-ID: <CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com>
Subject: Re: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above
 array bounds of 'struct list_head[1]' [-Werror=array-bounds]
To: Chris Li <chrisl@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Kairui Song <kasong@tencent.com>, Barry Song <21cnbao@gmail.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:58, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The x86 builds failed with gcc-8 due to following build warnings / errors on
> Linux next-20240802 to next-20240819.
>
> x86_64 defconfig gcc-8 build failed
> x86_64 defconfig gcc-13 build pass
>
> First seen on the next-20240802 tag.
>
>   GOOD: next-20240730
>   BAD:  next-20240802

Anders bisected this and found the first bad commit id as,
aded4352f648 ("mm: swap: separate SSD allocation from
scan_swap_map_slots()") first faulty one

- Naresh

