Return-Path: <linux-kernel+bounces-180534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A448C6FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA13F1C21CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D93C39;
	Thu, 16 May 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZiPyViGD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE110E3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821125; cv=none; b=BP7CjqBfNNCpQWU/glwmfEZbDUMcbxydK/VPq1ENH0IP8zq2656jRu2UfEaqa5Iu/Xe8RV5VtRN+3IcfKARRkNKoUJ+x7GKXEII8jXkfRdFYuAzXpEvVVipGxdFzG8cC1BW0jcS9J6Asx7wgeu5y4RCP1hHnN+JMMxWSZtt2O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821125; c=relaxed/simple;
	bh=7BhJCHWbFw2vBW4UWOoKmtl5o/hRhwMMB30aAmCIRIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHa9ETbwRMhh0d9RyY+dHsPXqxoYpxjLj+QNmCrDxOxI5EVNgzBAHGwLRfuXm6z30Mg+6B/ArvUt6UZqg+p15H5QfKQx6yaVXcNzjncLINs+8cP18S0Eukx6TJVmG7x6YzLjcXg1gx8YJN2gvTA0zJ3QZXRAXeh7iVK8EyNrosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZiPyViGD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5727dc6d3edso2667513a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715821122; x=1716425922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hg4NLF7jEXeiNRcO834bQO5LEzD3TDDoCFHLvMHj6Q=;
        b=ZiPyViGDgAHrw43FqkzbUd/okMCFM/X968UU0PbUzEPkBt+xXDwVWP71hFAlIuCCrE
         Y2N7o7cbH2w10PubLtN+IYgmpKgpHnPPy1To/DpDav8eZTY0jP38Ro31ybmTOhshpC65
         lk+jDrM7FIsK186ugvsz1bK9Ov05P1GfaVOTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715821122; x=1716425922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hg4NLF7jEXeiNRcO834bQO5LEzD3TDDoCFHLvMHj6Q=;
        b=pWHjphRmznXoaCKkI7PyAifklUoREjx2uAhAmUHlCSyR8V0ywd/AgYuzrDT7SXLwzp
         K2bfnX0uuR9gsQExPPdqez0/vYk1nOlf6xTmIR2myingR+X5U9Jiz2o4OTk4zraoX21A
         KWoyK+bP5DnkXq4H595kGCPulSIHgmlau+N80mXAzu6g8m/WNHyDMD6UjFbqM1VrpXbW
         BgMRh8+ySJWCoDG+ymuTJKz69wmce4+UX3T5a/lFlt0/WjWAPd0xiOq4XRCclUuXA9VJ
         /62EGCn/DoiPX2PZ3KTYGcxX4c1bI5LHtm/7UWtV7jtP9ZQSkeXR8rB2vt74TaywT5E2
         G+bQ==
X-Gm-Message-State: AOJu0YyRSXwqWejPVFKQdCOzdBQ65jO8WQ8TowohwiBmExD/rlksv0Vh
	tTecq0NM9ZaM/OWKets7YPh8rCDL416Ymzy8GPcEHD3Ig3twCxEly/o+GkEb6mhfGEwjxjcoN+X
	75BUh4w==
X-Google-Smtp-Source: AGHT+IGeOye+GtBV/mzow0GVIKlcXF7bYuAJKFrQsGyITiMVMQJBjBA7l5htmHy2zkiNvbsC9Gcfhw==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1056314666b.70.1715821122102;
        Wed, 15 May 2024 17:58:42 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01598sm932443366b.178.2024.05.15.17.58.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:58:41 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so1876752a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:58:41 -0700 (PDT)
X-Received: by 2002:a17:906:e2c2:b0:a59:c3dd:db2a with SMTP id
 a640c23a62f3a-a5a2d53b04cmr1119476866b.11.1715821121343; Wed, 15 May 2024
 17:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org> <CAHk-=wjTVMV2hBx6pQDBuG6sn75CtTfXrm8TF977fL9sqwnDFg@mail.gmail.com>
 <ZkVZkJPznWI8Y6ZN@slm.duckdns.org>
In-Reply-To: <ZkVZkJPznWI8Y6ZN@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 17:58:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbNOu+NivP2+wrBFoAoyiZfv7+utK7ur_a9quFy7tcAw@mail.gmail.com>
Message-ID: <CAHk-=wgbNOu+NivP2+wrBFoAoyiZfv7+utK7ur_a9quFy7tcAw@mail.gmail.com>
Subject: Re: [GIT PULL] workqueue: Changes for v6.10
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 17:55, Tejun Heo <tj@kernel.org> wrote:
>
> I'll send the corrected pull request right away.

It's fine, I already merged it.

Mistakes happen, this wasn't a huge pattern of problems with you, and
while I could have just merged the non-merge commit I decided that I'd
rather take the ugly empty merge and get your signature than to pick
the "right" commit and avoid the merge.

             Linus

