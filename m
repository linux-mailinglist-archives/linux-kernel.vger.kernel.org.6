Return-Path: <linux-kernel+bounces-532639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48AA45025
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E474188C2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D42215172;
	Tue, 25 Feb 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHGM+7S9"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9182135B6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522529; cv=none; b=gBh3RBP9rpa61ao4KfHrp8XVVudCH6wYBafqW3K5OHrg6zqCw/zR9XpwDfk2jqQOl0A0UYck1+UTII7H5pIrnZ9gqlUKPCuLOIGCu3sa29DDDw8MdkkhwW/jYHnpXf/MFwrCStVEJb6y10LpEo8ubCs0i6eLQ9zGben5lxEzcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522529; c=relaxed/simple;
	bh=JpnNtM3ALYIN6NMVHSPc0tO/Xi12yjgAOZhMGdcbQN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V5YHqOS4KR/52a7PlSsztBuMfzf5pXrgmLSY2uphL9t+NAFYtRgP43SJPFpiz3CP86nyFRdOp9Yo6h+cljrprZMXt6DVI9qkqI5PIM1wncO7Tdl5/DVUqmGzllu6NPEMxuhH0vOTZliKQQMzHT/XY805n9hG5oq4s5qOWmbQAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHGM+7S9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc46431885so20108912a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740522528; x=1741127328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ1g0mrUUxkUYLXEel+mk1QRtmfWBrQqVWukeD4l44w=;
        b=jHGM+7S9+d9FoqpOcxU6ahtmLahb9lkHowAepW+B7hLQ7CDp4D7ZSfQxaraLOF1Pxl
         ZDlzxL2HQN4L6vSjYAkY37L0gX8LpqmtGm7bobQlNP/iOqrGLqET+GHWbltlmRvzdGdr
         HzeU35TzOKAqS2vXshmAJZPl5ya2o7l3seyj9WXGg24aqg5a7xsE236cCMBRsDAajGuF
         ud0VSiKesGyK/N/+lZu3xCqNWA2R/nvePli+fVGDH4rPVcOm1lg5akCBR0/Xg47GaslS
         Jeo9DQvoH4D306DGUREcCODU6tqoM1tqxuqvpgQPO86xgoFlg7wgiz7Xic6mGuat/kRY
         dRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522528; x=1741127328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ1g0mrUUxkUYLXEel+mk1QRtmfWBrQqVWukeD4l44w=;
        b=xAVEcRJWIuHiocF3CzyLOQchxICHpd+bB/mRUzk6FaN2+hNRLU3R5RGko/Vb/UDMuW
         s0HyWSacpxUKOQXnC1Nmp6iG0sgXy2/t4QqBabkwNDwEgJ1apZCNyvLI8upm5G6nxo+A
         jBuiKP/iDI6VhBRPLVU4qYTFWjCWxgrGHpBqNx9Lv9Dqo5VuLgkSnBSf0t7ld3kfHhhI
         GUtkRMwK4C28YsqbzNDMmtiNjmS0WR5/I3rMHVE6Z4FYCdEhw+zdfV+SXdHuyVEG/x1w
         hCN9iH3k9yq3/5ymj34DUgf8ypxXCD84BhVGsveDwGkvx2nQZwyBhPInnnjoxa2EFV3x
         pDvg==
X-Forwarded-Encrypted: i=1; AJvYcCUNWqceTmag90KD1hWanA7hB8Wv74SLM/20wOCkTT7y50CkhRdGQvd95Qaz/7f06uiTcEn6uZcDnLtdXsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNv4iGXs1/sStFEJKv6I8YQcu64O2s/kmtxbTQnSftKGT4Ev0
	Y3YsBWvA2U6HwgFDjfnc7JIIni7nfX2zF7jodZ4VmobRK/z/5ODbOaglMpy1rlt2ttZ5EKzOxMS
	MCA==
X-Google-Smtp-Source: AGHT+IHPMOLjqXDahjHXCs/m7LvJtLpfnNjXUG9EkPnxnpvT/GyZUXLxwNikQZw5S5HAHQIVkJ1YiRiJceU=
X-Received: from pjbsg17.prod.google.com ([2002:a17:90b:5211:b0:2fa:2661:76ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1344:b0:2fa:2252:f438
 with SMTP id 98e67ed59e1d1-2fce8740eb3mr29741371a91.30.1740522527792; Tue, 25
 Feb 2025 14:28:47 -0800 (PST)
Date: Tue, 25 Feb 2025 14:28:46 -0800
In-Reply-To: <20250225213937.2471419-2-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225213937.2471419-1-huibo.wang@amd.com> <20250225213937.2471419-2-huibo.wang@amd.com>
Message-ID: <Z75EHspU4ZPcqw0U@google.com>
Subject: Re: [PATCH v5 1/2] KVM: SVM: Convert plain error code numbers to defines
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paluri PavanKumar <pavankumar.paluri@amd.com>, Pavan Kumar Paluri <papaluri@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 25, 2025, Melody Wang wrote:
> Convert VMGEXIT SW_EXITINFO1 codes from plain numbers to proper defines.
> 
> No functionality changed.
> 
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Pavan Kumar Paluri <papaluri@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  8 ++++++++
>  arch/x86/kvm/svm/sev.c            | 12 ++++++------
>  arch/x86/kvm/svm/svm.c            |  2 +-
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index dcbccdb280f9..3aca97d22cdc 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -211,6 +211,14 @@ struct snp_psc_desc {
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> +/*
> + * Error codes of the GHCB SW_EXITINFO1 related to GHCB input that can be

The use of "Error codes" is confusing due to a psuedo-conflict with the below
comment for the "Error codes" for malformed input.

On that topic, the comment for _those_ error codes is a bad example, and shouldn't
be used as the basis for copy+paste.  Most notably, it doesn't explicitly state
that the values are *defined* by the GHCB.

> + * communicated back to the guest
> + */
> +#define GHCB_HV_RESP_NO_ACTION		0
> +#define GHCB_HV_RESP_ISSUE_EXCEPTION	1
> +#define GHCB_HV_RESP_MALFORMED_INPUT	2
> +
>  /*
>   * Error codes related to GHCB input that can be communicated back to the guest
>   * by setting the lower 32-bits of the GHCB SW_EXITINFO1 field to 2.

Now that GHCB_HV_RESP_MALFORMED_INPUT is properly defined, this comment can refer
to "malformed input (see above)" instead of open coding '2'.

