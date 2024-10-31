Return-Path: <linux-kernel+bounces-390903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146E9B7FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CFF2823DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB71BBBE4;
	Thu, 31 Oct 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="el+SnhpX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8041B6541
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391548; cv=none; b=dPiV8QovI7G/Ki9nMAEDbMVNlVMMDfI6oQbcNj7x6CzxXSyidDHd/i4dYFvWpSbZI2w0g3EFvzlnrtToI8Kk+BAU4RRFYBX5Da5AyksCJKOt5GUF2vnf1lemnBqVachBDXcx29jYTYh2KdlRAOnmfqWSaL+bfiRHZ8tgzjh+fJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391548; c=relaxed/simple;
	bh=yFWSmwfok6oEYTTLTKkQ9rZWC2l0aHvY4z6ZJ+NQcCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpxhJxHqhYLhi3ccExCMFeK5Ehra0xqvHgUifg/xw4AV8lEJPcJ28fE2+bLekM7ZieiLvxMHnHBu+h2f90Bwz29ybpn+Ki7cybXuE4vTAb6cEKq/+IC7NaQg+LI+AD03fUKjHYX5A9FNZPvtUh2mUDrnoitRg0WBiKIF7uAUqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=el+SnhpX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c94cee0c8so994335ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730391546; x=1730996346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjLvyMXm9JZDYRseN0Kp+gNlDM9ARjQNJ6AjRKfsYIw=;
        b=el+SnhpXLGdThIHmAg93So/sSCsGkGv3wbCgcL4qXSNxrkCCwKDN0XBaayxDiPwGXc
         YOovLShvH38oOAPN5+vNWRYfZu3yly/29Yf+bIh/1A9PMXVdG8wYmKy1i6QCs89oPlOy
         LscWrPSFBaenATWRLIVMP6ZK3obt1MK0/dWqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391546; x=1730996346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjLvyMXm9JZDYRseN0Kp+gNlDM9ARjQNJ6AjRKfsYIw=;
        b=ECkVX9QSdcnLsTSns4QGu5n4+aLKKd8VIdQRGIkv2/1RzaEtLiIKPUzXzs+9Ickhxg
         8K48nPCj/9sLswnIalRF7FOda+IBiA/UI84dX4U/ulwXEpNNPkkuBH3vGeSV3kYr2o2s
         1bj1jnJL7zKOcRCEwAtR71vVNZWO9+pyVI9rlb2KQg+FqicDZL/7IpPorI9RnyV6prhu
         vlnOg3uyA12UtE8jtLskUj4vSMGncCSXDYOi5vf7ij9U8wM5N/92mLtCSZokIWYZWPLW
         HsmBrOeS/zS6b797nmUZ70cx81jb9tGdOwbCkKV3Fq9nGZguFu1sBQd+tQIqZ+4/7fGw
         257g==
X-Forwarded-Encrypted: i=1; AJvYcCUAmmX6Vp9YXW9lxHhe7OZe7LwpPILrPJocLeLSROkFshfcaz4GtaIWRADtcQ1CExc3hYQtRRG/v19MNYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6o3nAuTjCgexztyfzOuL/EqnJ9vMt8nzLnkBOPvKBvh9yXuQG
	OpEuBCYZii+Mzzw6rxM3DFVEzdKOL8E85oynCPVTYxRhCm58pxHcQyv3v8vm749WQtmpZ7gipBj
	lQjsG/5u4lAe0VeVeSXMWFhfiU3thwy0ft+7f
X-Google-Smtp-Source: AGHT+IEYEulEG8uwOdZ6nHWVRi6xht4GwFzjK7BexdW1RrCf5iD6UAW7Vc5bcQ9XIli0/7HCgS3q1a8Cpyo8PwB8l68=
X-Received: by 2002:a17:903:1104:b0:20b:99cd:c27e with SMTP id
 d9443c01a7336-210c68866afmr117631165ad.3.1730391546355; Thu, 31 Oct 2024
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028195343.2104-1-rabbelkin@mail.ru> <20241028195343.2104-3-rabbelkin@mail.ru>
 <b5aed7cd-3a1b-4d0a-a9fe-e8a2a7778cdd@linux.dev>
In-Reply-To: <b5aed7cd-3a1b-4d0a-a9fe-e8a2a7778cdd@linux.dev>
From: Florent Revest <revest@chromium.org>
Date: Thu, 31 Oct 2024 17:18:55 +0100
Message-ID: <CABRcYmKyrDEwGiwWiixsjc49g9ypkVVBQAYEsHu-QifiFSvWLw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test cases for various
 pointer specifiers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Acked-by: Florent Revest <revest@chromium.org>

On Tue, Oct 29, 2024 at 7:19=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> > Extend snprintf negative tests to cover pointer specifiers to prevent p=
ossible
> > invalid handling of %p% from happening again.
> >
> >   ./test_progs -t snprintf
> >   #302/1   snprintf/snprintf_positive:OK
> >   #302/2   snprintf/snprintf_negative:OK
> >   #302     snprintf:OK
> >   #303     snprintf_btf:OK
> >   Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

