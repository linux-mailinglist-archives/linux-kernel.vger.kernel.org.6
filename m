Return-Path: <linux-kernel+bounces-175525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE68C20D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257FBB20EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD331635C4;
	Fri, 10 May 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J6PKm0iI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665481635B7
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333047; cv=none; b=HPZsNDfUHc8QmhswMEa0yjDFd2EIBw2LH4TBd16+LHF0cRDFcYbOLXGR2chlSlhjmHIivzo8HfWvl+N1EmXkA4K8z2IzLrhEySkz0k3bKPTmn6P98+ZmLVEgPAI7uoFHD3t4f11/OxuiZ3VdChMfWP3v3eWkKnkZbR3/tFaC2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333047; c=relaxed/simple;
	bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNQIZZTRKkeD7HYzhJcYkhRD9qq/O/QUZISTIwETJwA8ZYz0BJOC7LDzWYG3rwvc+qsTY2Xe9HWGVwvXz0LGjGZ4jU39AKlb0uuYd8uXNNOJSkFc3GURmCSu+GAza/Yw6reFMRtoyz5QScgDjlcEZwhi+7827Jc2SKyWS2HD9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J6PKm0iI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52192578b95so2008433e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715333043; x=1715937843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
        b=J6PKm0iI97liOMawv3Xf9F+UDm4jxYDjniXPPya1MdYTGRZBuD9xww8atsOT72KmPy
         vzcNzQJjQ7uZmNterneF6Fn8+aVSK6hWZmLkkVHxcZhLJ0rI8C/wKgJG3uq4HvpnqtN+
         FFa3PMHWziX/JqRbiXM1g5cxOy6w8HXSmxlqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333043; x=1715937843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
        b=C/2axvIlH+xqiaHyFtlWhgHmA1mud9fzpGQ8+dw/YyNte4eXGc896sfSUirS769wsr
         z6XLt4LVY7wJCiCCkvG5mSQH0pyW9RhKU4EHPyID8YBH3eugun6f9hOjhbsNzhPTjJZO
         NXn/vUTnKDPkM0xJ4pe4euxI2ni3yVCotlY3Lj05Q+oQpPSYHDnN6z9xraeApCIiqQwu
         fhU6x4ue0wPVPk1e9Bn+FP838Qho81tOPbm/oCNtrdLvYlXyat9CYXi46LGZ+1ZG8eZl
         8A4p25uy9lo+kNsRZTIjlkvRKXYctR7w1zu+Vp/ZJv1UQOF+foGPhuzelci9EMzJDD5e
         G4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUPgStnuLjSKtr42ERei1XFgRqsM4katz8F3LfZjsL7/k9nB9HtJhEze/E0NyzLNENhUon0ZEb1uFZ6V0ONl6Tdso86CiVkNtUhcRNI
X-Gm-Message-State: AOJu0Yw8oQFRsUh0+WmJRFINjobb52YHUWdfF3kQWQU0gApPrnyAF9gg
	3r3sT+9ib7NloScnQZD3cD5EuGAXtTHU0pukRJ/G5HlzRoE/ViF3A+itAVr6XPiCAxh2wpLCvuy
	S6Wl+pCnMrWQ+RlTuKyGxiwjnKvTC47Z3Cwo1eXYvzgrZVz+h
X-Google-Smtp-Source: AGHT+IEBQo/Qbfl2WC+0rK4SGXKb1MtU+UuvKOJs0bGdaUK/2EFugpwAD8QMjqigbM55196R57Wz0hxTuWlnljjn/MU=
X-Received: by 2002:a17:907:6d01:b0:a59:9f3e:b1ca with SMTP id
 a640c23a62f3a-a5a2d6657camr156437666b.55.1715332611232; Fri, 10 May 2024
 02:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509122154.782930-1-houtao@huaweicloud.com>
In-Reply-To: <20240509122154.782930-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 11:16:40 +0200
Message-ID: <CAJfpegvJgFfJmDZXw7NBGZ5WASdxTy+EVjQxBSydAq1oARCntw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: two tiny fixes for fuse_resend()
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Zhao Chen <winters.zc@antgroup.com>, 
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:21, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set just includes two tiny fixes for fuse_resend(). Patch #1
> replaces __set_bit() by set_bit() to set FR_PENDING atomically. Patch #2
> clears FR_SENT when moving requests from processing lists to pending
> list.
>
> Please check the individual patches for more details. And comments are
> always welcome.

Applied, thanks.

Miklos

