Return-Path: <linux-kernel+bounces-369207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA69A1A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1E71F239B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313416F851;
	Thu, 17 Oct 2024 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRBRf1ro"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45316BE2A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144765; cv=none; b=ZVhlKx3Tjuw30Q0Z69/J7eJqeg6tFpxnfgPLniOgcc1j+HyO4ZiHgMNlNoypPT52Qo49s+oSdVJ2gkPjyxTIXHgMMFa5NEYSbkcUpvI2Qp884Sl0WmAUNyLJyDYCg5g7KRwMFzeQ3t0w7XlYiaWZI7GpoGeAaUGPmWdzR+i//KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144765; c=relaxed/simple;
	bh=gMO4ouJDcLvZo5+Ri/4bIGTYR4lb7nXDs7PhNSJwBU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYJ7G1tVIWz7dMEMH72HkLMmgcGb+c4eMwwYxtv9G8h+7XFCdbj+qfbOuDxpj8FkfaoxUgpOt3XXJfkxzQGnHf+IvECEjxlKYEWj14oJvaXnUVKOmze5aEaKWvFtxqZ3bWhkqYWiMNFzozZJPj2OSi48mjyH1k9mm3i7y3mwVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRBRf1ro; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so219393241.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729144761; x=1729749561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnCXZCXqb9fRxrqslG34b8/GDW8gVXLfoyZxzqouwKs=;
        b=cRBRf1ro8MOJmOuDsS5cj6gy6xdOqueTYsyyKeVhlh0kIpIbE+KahedWdui7qN8BS1
         bGj0YV5rE3J0zjonOeIetY7j5ieFWS3m+2/jW+vkUIFELB67Hjxv+icWD1B7vJOo6cZm
         DcvjWo3lRcm4tsuqXCDBXbAZMEXOoukyatu0/VlQtlEE+KIaBCvUYb63g+nMHrn9i12l
         WBttkEC5f74kcPyzeqFv9gqGBWKju+PIqmCoJnae08Pbl6B+GRG1aKtP9OibEgS4Lfzt
         1l/UmB3MUO+I30oK13rxZyBoOP9lkX80YPkY9D7F1917qfIZIqcJdNSZBqOwK6AvnoP2
         n8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729144761; x=1729749561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnCXZCXqb9fRxrqslG34b8/GDW8gVXLfoyZxzqouwKs=;
        b=WPU2Ph5+10Ua6UtcY42QDAj6AvlQHLrOYugnNXH5wj7yMa0JkhgBXPGeDWDT6DDQYE
         7UPuRyRK90mMiM20nh/1t8aHgnYwg7lQX9C1ErF3sV474c+K7qKMYA7qCaS4fEtfXcyH
         OjgUoBArYNRTBoHgJfoMDBIhhql19ooCvL8uBx/ZR8oxJAzFdLWQGtKWZgBnZ7mL+7TE
         DZ/5NmtuJhngrbshp7lxestENepgtqYZ6sJVCvzitN53Zfbw2PlPIYeoZMCEw/u6oL+R
         FgO+TnNenD/9dIL0hhAliJJ+aYRsN8IBYZ4jbOW8CyCo4/LX6zPI6K4o/mdXrjTvm9qu
         K1rg==
X-Forwarded-Encrypted: i=1; AJvYcCWtuw7Vt5Dmys4/hKYmiaQU5jk41UoVLAywXV0R39pWAfgtoypqfhonb0ma3NUQt1HDuWAie47SkgIWcy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CyA5lUxKzCmmNDwTQa649SaRzH2QlrkqCQVirp/FpiOOcWQ3
	PgTy04P/Q3wirwCNWvPI7XCGWv+F3E+GvXQ1ARmFo2+mAd4v3q7iuFbAjh1CeWuy01h9Z7pdWA8
	aZCZB9Kq7Li0Bne/xWUfjPuyZFK8=
X-Google-Smtp-Source: AGHT+IGsxv5pSIKTsf3MASQY17mk9YOkB6v2Mlq4rhqx6If7uW3Mw47W0zY2HUDPdaBMDy5UKpo0iJa7SdE7FoglO1g=
X-Received: by 2002:a05:6102:d8c:b0:4a4:8a29:a8ff with SMTP id
 ada2fe7eead31-4a48a29aed9mr10974003137.17.1729144761390; Wed, 16 Oct 2024
 22:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016033030.36990-1-21cnbao@gmail.com> <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
In-Reply-To: <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 17 Oct 2024 18:59:09 +1300
Message-ID: <CAGsJ_4xYqSSUE_zq+2UWLT7UsF_ovH=+QE_va+_dcMq4fnz0rg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon folios
To: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org, yuzhao@google.com
Cc: linux-mm@kvack.org, david@redhat.com, fengbaopeng@honor.com, 
	gaoxu2@honor.com, hailong.liu@oppo.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, lokeshgidra@google.com, mhocko@suse.com, 
	ngeoffray@google.com, shli@fb.com, surenb@google.com, v-songbaohua@oppo.com, 
	yipengxiang@honor.com, Gao Xu <gaoxu2@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:58=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 16 Oct 2024 16:30:30 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > To address this, this patch proposes maintaining a separate list
> > for lazyfree anon folios while keeping them classified under the
> > "file" LRU type to minimize code changes.
>
> Thanks.  I'll await input from other MGLRU developers before adding
> this for testing.

Thanks!

Hi Minchan, Yu,

Any comments? I understand that Minchan may have a broader plan
to "enable the system to maintain a quickly reclaimable memory
pool and provide a knob for admins to control its size." While I
have no objection to that plan, I believe improving MADV_FREE
performance is a more urgent priority and a low-hanging fruit at this
stage.

Thanks
Barry

