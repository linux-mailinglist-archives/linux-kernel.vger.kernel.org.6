Return-Path: <linux-kernel+bounces-380332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A479AEC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F061C2239C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3481E048D;
	Thu, 24 Oct 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0lHL3ux"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77E146D6B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788353; cv=none; b=itLw5zbnCjBhdE5UOxZSW/H2y4AJxxOlzq7Oj8LjwLFRQG0vkt9osFi/lf2G7LyeYhNY8tCyvbRJFD6QonzEy+jmv1KSb0ciyo2eF5TYglnmSM+OL0/5Fp7hPaHdw7A1QhuXOSVzUORAGORtp6lOGYrYi7URtJxgLJOJlX+QIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788353; c=relaxed/simple;
	bh=IVjqsPa8/r/WWwqF0pevUJIDLCx/2vQIgGj6cc6incw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emzwd74iBhLzvG7zhQpSYE5iKDzKtma+O6ZxrtK572xuHrFZeLLoDbGRkaMJshKmgR67PcHoH53CC443F2JJrrAMqYSEj1kPrPsRR7PIkGYRnqeOkbnKGGovdwZznYfgQEuzUkfpwOorGYL2bJ+g2R8+3M08diu7YXyttAta4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0lHL3ux; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e5130832aso821962b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729788351; x=1730393151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbcx/f+avMo0nfnfoFrvHy0s7zMVYb5RcXeOKVfhBB0=;
        b=L0lHL3uxV23s66hCG3n381zf25SGWVB6hmvbh5esh1vGVfE1jCcCfuH87o23W7zMUp
         MCsbwIVh+pv8QIdV9Gzx41fswV3kA3iKPoxzZPNkAzRlPXcgtviYRDbonN9M84YN7zkF
         JCUi0mwn4/vU0JPg4jsF5U4/+xccxXMWiVquRfIvhwiHK4ZQColiLqGiaC4ax8YMeJD6
         Z47M34j0jm+4ZsCkrhpGWC8FiB45rITpvByNUl202PuPwy8DROZEZyIEHyvlOq/p05HM
         XNLJKTIuDVB9FJF+d0hyUasS/nXlR/bPVIjSiFWgKwZ3NShONrMhJr9/xYkZEBh43nz2
         bp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788351; x=1730393151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbcx/f+avMo0nfnfoFrvHy0s7zMVYb5RcXeOKVfhBB0=;
        b=psy8m508NRaF/tTMV61La8vA1SaiLEzc+99Uw8bS8osmW99IP1fEbgMbm5h1PR6KbG
         RkoN1m1EMPNs/vS87x4Bo/V8U79EDCoDf11v+BBTBp7Vut1wpjZo26xLcUNspAfveV1i
         UWpRADCyqlZMq10Devd/tWEu15C6C/cYO3Mwes/+KI0DYjDZSNO5zcurmD6enZunwlQf
         8u8DrlTI/nThBJ+7T5uOGAo/qrz0JC//F88Divwod2vNemymd704TCPEcQQM/1QKn+iv
         KK0fhzY2Xn7wcMKq1zk7NXAb9pmbIgBg4bDXyU2/OUsoC3xkoPGdCAEbnfzYK5ssU1Fo
         eTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCLpS0FDvRWB9kIM1wdk4KduyZlpxftssk4qiGJRMnCN1WYYr0ItlD508tF3Qve2UdNj1djzX6q29JzqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVoguT/wzj3AnhpDGt1ichIImYKRhZQi9jm9U666z1fvoyyDD
	n+JzdFydka4EnOU0rNzXYNOMW+2IHqcThHHUeNqEgf6x1Yj0vbPNin9wP6msLpQC/8eRpggiCDP
	7vS8g1XU6qmwMg8t348cx6b05X69QnJWFnVVn
X-Google-Smtp-Source: AGHT+IGyVGhrIax31DbYyaNPPps689qKUUGZ/dBmIonlf0Ms5Q31B+FIXf7PnrvX0k/Y2NDzzkEVUzrdywoXgv6bmrc=
X-Received: by 2002:a05:6a21:9d91:b0:1d7:1277:8d0f with SMTP id
 adf61e73a8af0-1d978bd6450mr8093124637.48.1729788350739; Thu, 24 Oct 2024
 09:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024061347.1771063-1-saravanak@google.com> <2024102457-manager-counting-ff68@gregkh>
In-Reply-To: <2024102457-manager-counting-ff68@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 24 Oct 2024 09:45:10 -0700
Message-ID: <CAGETcx_BD_G3oOHvT7aRr98Ag7-XvrMX=NW_wm9Cx9M5+qr-aw@mail.gmail.com>
Subject: Re: [PATCH 0/3] A few minor fw_devlink fixes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:08=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 23, 2024 at 11:13:41PM -0700, Saravana Kannan wrote:
> > Probably easiest for Greg to pull in these changes?
> >
> > PSA: Do not pull any of these patches into stable kernels. fw_devlink
> > had a lot of changes that landed in the last year. It's hard to ensure
> > cherry-picks have picked up all the dependencies correctly. If any of
> > these really need to get cherry-picked into stable kernels, cc me and
> > wait for my explicit Ack.
>
> You can do that with the correct tag in the commit as per the stable
> documentation if you really want to :)
>
> But why would these not be able to go backwards?  What changed to
> require them now and not be ok for older kernels?

Depending on how far back we go in terms of kernel version, it'd be a
bunch of cycle detection logic, deferred probe behavior change, etc.
And those patches might have other dependencies themselves, etc.

He's one example of such a breakage:
https://lore.kernel.org/all/20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.=
com/

-Saravana

