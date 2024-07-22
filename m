Return-Path: <linux-kernel+bounces-259183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1B939244
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CE11F223D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBB16EB50;
	Mon, 22 Jul 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZT9NtxD3"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3438F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664367; cv=none; b=DtavQ9l50wEwelnTxfOtCcnmfDONd4BYVn0KL1ea52CbJkrhAcHR4cM+/zZUKBHkWa5z4RFy7pHs4HvN1kEkWw0Zi+sIZ1MhIoDePEy9TEBJ3GXcx2ytRIxXw8PWVu6VXlcy/fADDjACyml/e55oL8TxEXXaEcaJd8haXJmhLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664367; c=relaxed/simple;
	bh=yX8s5ckqkA+tmDQRyK0eydul/3vH3fqS4T3avsDFFDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDjraPhUU0ud+35TjmXWdxCGo9TVVSwYO+h+R8zM63ogPv1yWdsnajXq4SK2PpDOAs37TERorcu+BWuqG8dYWZM7tT1u8hTxlQtr/euvhFlfWExxDtr/a3J3NKJR8dSDYYTW11ceMzCKcYpnQnbjQb8BgmvNTjxZu0v2ClqM744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZT9NtxD3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05e94a979eso3201143276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721664365; x=1722269165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l77jSYybQoKi38+B80qfMYfJS9baLUBLOyUXFrvfZIE=;
        b=ZT9NtxD3bPSxhsji5jAiq4/Y0uaaJ4/RGSgvYhAS/BtwBkHke6FNr3nZYwC/FfPkmV
         Eootu4FF5pmfEXeJAiZGIkDC4EpicqCoBPt1hAOResjXGwuUQTX/cIVWt7zciqtCGUwD
         pEyecrnXBCNKnMYWO9Lv66lXUFNCjpaB4Mbq+8hAyDVxoP+RzKpPI8L8aVBplQrXn4Aj
         wYrcQEIL+MlnQ+8vjr1loOw1ixutvehyhNOrfXTH/vwtYvam1t34QH1E3GDl4n/3E4Ur
         OP0mgoQJ99EZKvorcomtZWaVjIX6JF+tmpjx0SfGZFhG8e+nUtdcsQapgOlshqCahSpg
         fZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721664365; x=1722269165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l77jSYybQoKi38+B80qfMYfJS9baLUBLOyUXFrvfZIE=;
        b=i1/Ku/dJ4Q/FW0zbBLgLFPgVIPK6/Zat2FIW02rWVFtWzn2ytQ5kT/YjXGk0UiDng6
         HlJZR3eWjrn56ciJ5PAL9lwczITuucelqWPFVO34GW+Qc0D/GbZ/1mNTBRLZRPy1W21S
         i324VKs1strCQlFvlHy+YcEqu3WhjXcqsf0LZpmxEYo2vUbiECtQFFFtQUwDlmJHFeGe
         CoWUJc/QDUEwNtfVbw9e1YApwqF/pNc1hFrtmGVrzlSS/SU9tw3gVRXAfbSQps7m7QUi
         xDEgwgLf52jFd8tirnMu2XWbmgj5+ItXH9fltowbDB/tbxOMztkAcvjRjEDq9mlQMXwQ
         M2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvlPxOBrLPpLMKKHbbNsScKqR2h9upPQWXYOn5c4fZMzNIf6ph5elxynTiAls/i+ojeBY0boE++CCsEmktZ6mrmWzByb4bw8iM2Z4i
X-Gm-Message-State: AOJu0Yy3C97aBinVKlqDz8KX5EBUWzN6JGB8045k0vHbUZVKEldMvJ5L
	XkVN4m7PTnKR6cCCFgFPTQbRwdkQ/HuLLUw/j9he58uyV24f+gsgPNd37X8fVN2W+yaMvS056+c
	aYKoztr8KBDVBugbairDg8jmpVGs0LATmSAh9rw==
X-Google-Smtp-Source: AGHT+IEG9SkUvJgZIdWtaf/EFjPpmxBx+1aNx5IoS27Aunm/PI/GhuSsGK4x2MLGLXNoDyTHQlooZdORQO200RrHaC8=
X-Received: by 2002:a25:4a83:0:b0:e03:a2f6:6787 with SMTP id
 3f1490d57ef6-e05ff1ea636mr9827351276.10.1721664363508; Mon, 22 Jul 2024
 09:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com> <ZleYXoesgdAboMoF@surfacebook.localdomain>
In-Reply-To: <ZleYXoesgdAboMoF@surfacebook.localdomain>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 23 Jul 2024 00:05:52 +0800
Message-ID: <CAMSo37X1GRUtuyHDL5GfQAqbH8EVjgAWR129D3uTF3CRPpLKPQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Assign dummy scatterlist to unidirectional transfers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2024 at 05:04, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> Wed, May 29, 2024 at 11:42:35AM -0400, N=C3=ADcolas F. R. A. Prado kirjoi=
tti:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> > introduced a regression: unmapped data could now be passed to the DMA
> > APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi=
:
> > Don't mark message DMA mapped when no transfer in it is") and commit
> > da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
> > APIs") addressed the problem, but only partially. Unidirectional
> > transactions will still result in null pointer dereference. To prevent
> > that from happening, assign a dummy scatterlist when no data is mapped,
> > so that the DMA API can be called and not result in a null pointer
> > dereference.
>
> I feel that with this the da560097c056 ("spi: Check if transfer is mapped
> before calling DMA sync APIs") can be reverted as unneeded. N=C3=ADcolas,=
 can
> you check that? If it works, we better revert the unneeded checks.

FYI, just tested based on the Android Common Kernel android-mainline branch=
,
with only the following two changes, the issue is not reported too:
    9dedabe95b49 spi: Assign dummy scatterlist to unidirectional transfers
    9f788ba457b4 spi: Don't mark message DMA mapped when no transfer in it =
is


--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

