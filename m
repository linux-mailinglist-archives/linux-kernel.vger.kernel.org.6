Return-Path: <linux-kernel+bounces-343841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99598A026
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1F41F22357
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90E18D65A;
	Mon, 30 Sep 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4u77dX3"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F714D71E;
	Mon, 30 Sep 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694932; cv=none; b=HMqrXYTJMEDba3K0xSPAq3ijL4UMAmrYyJx1wjPC+8D+zTZXnH7/vIABJiPgTaVT2t0Iej8NTKKVyOYTGmbV+rFWzM/IZ26fDRSTYEtbQcd+eo2KVxiiZ6UviGSGEiRmBfs4N+ovoRYibTb35vxvbI3CtjlIFh5y4AYUHNrnA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694932; c=relaxed/simple;
	bh=nAllHEy37MQSZwQx3FS/KmYURYA3jo/U7B7bkMt71aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIXO5WJ6nOctbzTcd6UiM4ekjCNjrLzg6JzP9VyfOUxX1lE+liNkH56AxQLGGyOQNfxnEgEZ9hIxDBtRrXloVqPWyHlEdb+W/qzaEC984XQvYH8TZvjiGi592Jnf+kVPA45nDXBdPuyipoUL1OchwVhXpuLV1XudjbGGS66zDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4u77dX3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45aeed46f5eso17301781cf.3;
        Mon, 30 Sep 2024 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727694930; x=1728299730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAllHEy37MQSZwQx3FS/KmYURYA3jo/U7B7bkMt71aA=;
        b=c4u77dX3zbmKpJJtL6u0TcsH+/UNRGyWZ2lieL8wJH/JiWOTiNqzNFcS+d6ctW0pcB
         yi3LSlo0xD7kIz9CRAQkkwiGxdF9feb93jtMBSnAh/X7x7OmZcfy8IowK1gxv/HZTuA+
         oX83M4+/h3E9sz6kDDRHYnuCJdXyxPY11J6o207IdLI782savSkaafDTa5X58R/3rBsH
         jFqu04hcXeIjAcsWolQQM3ahoc2NLxT2PnXA/0Z7DrEJbFpQvgZhRtvfr7Xj8PbRNvjG
         nXmkXnT7ZE2BScM9+KFDcYfybHZnQEGVNY8h0rU83muy+X2Yx9tZ0iyFAKk+BIYHXg4f
         Hkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727694930; x=1728299730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAllHEy37MQSZwQx3FS/KmYURYA3jo/U7B7bkMt71aA=;
        b=QcZfYq43XOVAx8WduWPkAFHd4lMpgZO/DGafbUsT9T2UrJiSD3vWAHaE45G3itxMh/
         5qOGpKrPeiZYuCW/w+PCLW5odlq941Hc7pWccUFDlAeqs25AYy+t/j930AADTMVbpWdG
         I4EmdlY4COQbTbjdSw1E7/DlKvsr/ZP62r7M7cv1b85J+DbNOREt/Zh6gipxwy9GovX0
         f7QrUEKdzPJFciV85YIiC2PNaW551fbx8xxj/P0oExy79t4+V5COEbaDGbHLNEKD7xsf
         OpwY+gSD05fifAd6mcXoH8oIAZfBSrGw97ydS2b6DLhKTR2aH6AnkcOs/IvK6Z1sROqF
         znDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNvzl1nMz8RhxAakPORHEZr3N+M6UBGf8EN4HMoSTfjKfBXyaYtaFILb9pkpyxecGW4PUH2KpL48uRh1knPSc=@vger.kernel.org, AJvYcCXk5P1eQkNehdTfKujdjM4eZMnvF3ZJiyrS6Cp5Oym0rt8DGhJ/ChVxk8OUMvmfpA2IhHnPxPHbJyeOvtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRFwU0yj7ix8s7bnxA9bH2V+H2TAFXcwAy9ETwDJ5ALTobG5m
	pez2EiKYBMPD/fBtSbgjtX06SUMoFGzaJJ9DL1uwnz6/TfNxUvQCF9Vwlr1t7tUkcz+ZQAhTP+6
	irgkqUEdE96JW6ypLOzvpD+VKz+s=
X-Google-Smtp-Source: AGHT+IE2f3oG/+wQiScu/8IpSiODNStabHKHwALVPaVqp0yP4HzudWt4fy0QryyGmZhPlXVT3K9BlDbh3E3Yy87Aw2U=
X-Received: by 2002:ac8:7f8c:0:b0:458:5bb4:7751 with SMTP id
 d75a77b69052e-45c9f1e7c03mr176108911cf.13.1727694929493; Mon, 30 Sep 2024
 04:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
 <32476CD7-74D6-4575-9D93-2FBCD5AE3E10@collabora.com> <51fe3ee3-0b81-418d-b05f-626dbcea4f57@de.bosch.com>
In-Reply-To: <51fe3ee3-0b81-418d-b05f-626dbcea4f57@de.bosch.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 08:14:53 -0300
Message-ID: <CAM_RzfZ0LVTBGpyMj5X1GTgdzhw=zx=E_zMSFNmNSks91jBMGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] device: rust: change the name function
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dirk Behme <dirk.behme@de.bosch.com> writes:
>
>
> On 29.09.2024 17:35, Daniel Almeida wrote:
> > links may become stale,
> > so please do not link to anything.
>
> This sounds a little too general to me ;)
>
> I mean we link a lot, using the 'Link' tag even in patches.
>
> For example the mailing list archive has the 'permalink' button and
> Zulip has the 'Copy link to message' button I think can be used.
>
>
> > Lastly, I can=E2=80=99t see a diff anywhere.
>
> Yes, I was confused by that, too. But I wonder if just the numbering is
> wrong? I.e. if [PATCH 1/2] was intended to be the cover letter 0/1 and
> the [PATCH 2/2] was intended to be the actual patch 1/1? Just a hint :)
>
> Best regards
>
> Dirk

I can resend the patch with the message commit fixed and the correct numera=
tion.
Thanks for your comment in my patch.

