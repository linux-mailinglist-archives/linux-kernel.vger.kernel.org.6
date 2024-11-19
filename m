Return-Path: <linux-kernel+bounces-414621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C39D2B56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA63AB27EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634051CC8A0;
	Tue, 19 Nov 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW4QlL7o"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1DE57D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034149; cv=none; b=QzqslGf3pDNKFbTTRt4HdhZJ8GSx4bwRoyd31nbSzWJYPwKqVaGr9FHQVIwSTMqr04D4gA0c6UbdeV8KsW6m+l+1UHFSkeU2jPs5HhbfRv7MhjrMC8x1KZKWE31UevZBr82S0gsmK/BXahkfG1YysRm61bAdOpu/RBtWqQy5jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034149; c=relaxed/simple;
	bh=EGGdEQPe+aUfqVGOU65LKu9rxpQoOawFlcoNSgIh1ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI+8vS1MHVD+HRgYDZhZ4Ldq57mAV/r8uW2M+lO0AnSG4qw1MXjDSH94UKpjYEZfR4hz5YoKwVUQHsBtOKvh0dlPtSVY9v3f0B8t+u5pv22185HxZ12xWZ1G/5As+JudMHIWpYoL/hCP4rjC1AfN3WsQGn/nGDmu07/WxsoSreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW4QlL7o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720d5ada03cso4103518b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034148; x=1732638948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AW51nF2d4Vra84SoBwduSRXmtopJSBkFMLYztV8dgU=;
        b=GW4QlL7owZpt+pVgvFK7BjJbWejEMy+gW8Kym05YNXeqekdCIB62esdN79vRdA2I74
         eveZBKLKzwaihbKQxY2xAzTS0UEXKi/Ho/AF4oBTolJcn2haTIH9LBDJtqVgheZNUWXY
         LZHz/AX9dviEX3bfjv/zBBROUKUHP85pCa6e9kzg8nLxfl2nNaucsBkan+/+vkHzehzX
         iczXO3afSCq85xAkD405DEBawmEqNxtWTeqkMwedrZ9OStNWW3aINKXm9nxlOKy1adhd
         kA7P/dJ77dmAMEm3fl/rFiIuPgDipMHD2zICDSTgVLPdmQHBTrA0NnSStENPgyOQFj0B
         q+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034148; x=1732638948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AW51nF2d4Vra84SoBwduSRXmtopJSBkFMLYztV8dgU=;
        b=VPqG/w57aJJPRdagNwjEVXw5lk5O7zAcqOcLsPDQYplpqz9MlcNI1dOK2e5KiEqUPG
         KfYVID8/IPOhiYrBsd9b4b5cMSSiA0xXEkylHSkeIWkdF0/S6pVlBidiXT+qmOo9ZxRa
         D4Zo3aiMTYHE3KcNRpRJ5puOEngwwAKHipsVbpKkwF5/YrPKhooRO7CcXOpj5knF7Oyg
         p3zW6SaIDhANjMOk7s8SJqCLkvsZ5TQwwzZVUEoCOmB8R7SfOiOeujWOiBaN3m6dV+BG
         cLRlop2IL7gdYvF1zx/ERzgLRxKkY27vOUlz+wtiOnIiQlymRXR5or0t4x4GIjUME3ni
         eBXw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Jraq34gYaTZ04xoJEPz6mGM2T0bbp4bLxaE4M3+jUpf2CKZFFujsmdft85o2QWvmZaV86Inwbr9rOGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5rs8SgfP7Y2a3cwaIQLvemvdrHBoWtaiSyOTtkfkxM4Ox6Z+
	B9PQOqaCAIhzdOUQUZCsvhtu2Mab/i/CAPluI7J8/pyig5BIBWlYxJFZKb+Tk1Knlp4pBhhw74B
	AZ6O7izEVyQ1+tfVcqZ4Gebg/Nj0=
X-Google-Smtp-Source: AGHT+IFFRlfsL/PdTDxz6p2u32S29AC79MVUnMyJQSmdkoisaP0t5aq5QfVaQBTFcz5UeKmnsGoNFRPwes/MpuP6DDw=
X-Received: by 2002:a05:6a00:a1c:b0:71e:680d:5e94 with SMTP id
 d2e1a72fcca58-72476cc96d3mr22863920b3a.19.1732034147566; Tue, 19 Nov 2024
 08:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
 <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de>
In-Reply-To: <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Tue, 19 Nov 2024 22:05:35 +0530
Message-ID: <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Fix dereference NULL return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:33=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Skip to the next CPU if `pte` is assigned NULL by `lookup_address`
>
>                           a null pointer was returned by a lookup_address=
() call.
>
>
> * How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?

For the Fixes tag, I'm not sure which commit hash I should put. Should I us=
e
the commit where the function was introduced?

>
> * Would a summary phrase like =E2=80=9CPrevent null pointer dereference i=
n snp_kexec_finish()=E2=80=9D
>   be a bit nicer?

You're right, I'll change the phrasing. Thank you for the feedback.

Best Regards,
Shresth

