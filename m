Return-Path: <linux-kernel+bounces-447778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E019F36DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB57C16E792
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF1204F75;
	Mon, 16 Dec 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1gZwNXL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5341202C3E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368139; cv=none; b=FCQuPHkAQb/ElpQHeuBU7Sraq7uf05qjNtZ7uhznWSY34Ma3Mdc57/j3gu/d/0tFJPGryUS5G1bSAbKP0lo09kYnSzzTQB43mSa0Xb5pmMm6Hw9Y3YOLDhOdy75EVcUtxUA7PHvfZomGtOODz5orGaXRj1miOAGl9ls+Y0mN7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368139; c=relaxed/simple;
	bh=exIcYFMr/HRpQfKDSPgzbZF56CjdZYovi5aOzoilGs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMBaHnxfrDQ0OeiHLQgAwanUkLCbjpBs2u+o/tElC97SmAE8r9VGv/zy6vXwYDS9sGtyJtfEid06OhPgtLKvrPSbxfik/BXZETq+6supzL/nAYhbVbU3DjYMeSFzZooAlcmKeDtNq4PyNZS77aZ6rB22WW4EIIi1AaLmFiKk0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1gZwNXL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso6591698a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734368136; x=1734972936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5F9L8ao2FWg6tQlgvlzr46lLj33BvkE+wjWX2g+pmKY=;
        b=U1gZwNXL2jr6eJLdZsoBEh7ijUM41yek3w/7aAJzSlNiK/HdBiPb5oYyxuCYYfocZs
         Kf0CS71ryc1JK4rDOHtGmuzuXa9V/okp8ePDrgY2XNebXMn4El5annZW0uhS0HdM0emh
         wjduYPkUweQARQAazU7dnUXODkmiOk4SxB8vnf8zbfUqfDw6/9/OeGW5SOllDQtqr5mu
         Dovd8gAI2CMf5JM20MV3K8fxxOuLgqiqL6OCaU4e2tJ/GkztGaAbXGzO7qCnoKdsPsKa
         HgrMGqbbdNH2gH8H2WhZDB+LtyJaj6rh1tMt6W3/q9wQlTI5jqLuXQ8cXtl3FsbVqL/v
         ptmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368136; x=1734972936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F9L8ao2FWg6tQlgvlzr46lLj33BvkE+wjWX2g+pmKY=;
        b=iRs8ZRvh1CRaR7IQ8NcwNIra8tIEO0Drwq8OrVw5rp+8o1dwG3AWPHXNb+NkTfIHFG
         1E/HIjMfzmIyTonucjCc/9yCSRE6Yzx0qIVmhuH0uOI4e+51jWudbadrCyhHtWj5w9YX
         PFmkoTa7TnlTN26PPk7UGKLnXKdO3+8Zv8u8UHP4DFXxSK/I3RHN2I0pB0rm2SyVEw/U
         h+uO7qph0F7Doo5nTtqsj3Y45TQOVwKLxVh/AcUwh/E8Cl6kWgCjaMdb+R0X0r5BiSSS
         DBAIW57iYAD9NDPA8YTk2yDL/Xst2yEVZh2q5s60zo9Kbmglvb/C7UYZoBEAli12KqiC
         Pj6g==
X-Forwarded-Encrypted: i=1; AJvYcCVzKf5XwU1Eatwvr2UUivKzdvfdtIpyBgM7cKbEpUzHZ3VwyAp+PzZL73v7DfMeOjr9uFbngEzuEUIxqJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQAergDgiDNovQAa8yx4GjPbWn/KZaAbPCPPgGV1rfVizKXW5
	/ok6F26ddQChWo+NAOqk6qRfubFH4gkgRZRIRaf+/c5J2u9qz9wh6LDo6GRpynovml0Rq2cg78+
	JgAoktTRRTHy2Jt3sXRbmm9wgzz3rUaUjsadhHg==
X-Gm-Gg: ASbGncu60uSCh8f1KJM/YRCXFzDKxLSqIIkCCEx585n/07acnIfN1Xzo/YSqcnKnQ+5
	ai1fDWM/Iy+EES02tlA3OVPSgK8Bjp01LXjtlDBc4hkqyIf/yYN3RlauwwwVb1srA0Z9yaEp1
X-Google-Smtp-Source: AGHT+IHTRK/qYe6I9n70QN7A90ugOLz4h7UelfHoHHl07NZBTG0IUS3BQKGGrhwGG2+AQ5jg+1boyJI3eh0HXS0ECBI=
X-Received: by 2002:a05:6402:5207:b0:5d0:bde9:2992 with SMTP id
 4fb4d7f45d1cf-5d63c39fac0mr12471441a12.26.1734368136212; Mon, 16 Dec 2024
 08:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204111130.2218497-1-b-padhi@ti.com>
In-Reply-To: <20241204111130.2218497-1-b-padhi@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 16 Dec 2024 09:55:24 -0700
Message-ID: <CANLsYkw+-VVgDrpS9n_gTpNPGzgh8QhwqF66Qz0UbyEOL-5p9A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Use Device Lifecycle managed functions in TI R5 Remoteproc
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com, 
	jan.kiszka@siemens.com, christophe.jaillet@wanadoo.fr, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 04:11, Beleswar Padhi <b-padhi@ti.com> wrote:
>
> This series uses various devm_ helpers to simplify device removal path in
> ti_k3_r5_remoteproc driver. This is the first series in the TI K3
> Remoteproc refactoring as long planned since [0].
>
> Testing Done:
> 1. Tested boot of R5F remoteprocs in MCU and MAIN voltage domain in both
> IPC-Only mode and Kernel remoteproc mode in all Jacinto K3 devices.
> 2. Tested Lockstep, Split and Single-CPU Mode configuration (wherever
> applicable) of R5F remoteprocs in all Jacinto K3 devices.
> 3. Tested shutdown of R5F remoteprocs from Linux userspace and also by
> executing `modprobe -r ti_k3_r5_remoteproc`.
> 4. Tested that each patch in this series generates no new warnings/errors.
>
> [0]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/
>
> Beleswar Padhi (5):
>   remoteproc: k3-r5: Add devm action to release reserved memory
>   remoteproc: k3-r5: Use devm_kcalloc() helper
>   remoteproc: k3-r5: Add devm action to release tsp
>   remoteproc: k3-r5: Use devm_ioremap_wc() helper
>   remoteproc: k3-r5: Use devm_rproc_add() helper
>
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 86 ++++++++++--------------
>  1 file changed, 34 insertions(+), 52 deletions(-)
>

Please note that I am looking for an R-B and T-B tag from two
different people (for now one of each will suffice) before looking at
patches.

Thanks,
Mathieu

> --
> 2.34.1
>

