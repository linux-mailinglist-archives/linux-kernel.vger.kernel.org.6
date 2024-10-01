Return-Path: <linux-kernel+bounces-346701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4098C7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38687285E61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4B19F41B;
	Tue,  1 Oct 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjalqvRb"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48561CB32B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818857; cv=none; b=nV8Pq3U0GQfpdINHmCyUJjDuiT+PzrIOum6RV1CfaLtBBHSsCKC9x4vbs0PdFO8uD/c+l4ivcvlCYDQsUMLkML6k43F6yGjRNgyJOYqpNWgGpyBmgQVAaMBQmId2gfFqYtsJ6QtoSPWXLOF/R0uLzYsmuAb6NXfry3xwOuq7Vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818857; c=relaxed/simple;
	bh=4IuiZkHpzDuYZ509owtUOMYOMkM28kYX5oMu/9iARSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1zl2QDqy0Bg9hkVVGYTugEUBcmz/0Cg9tZRuwaBkTR2uCqS8twXxbkS/Zb8C2n2Ao30YhXMJ97Xy8mOljiuhTezbt+E6+3mbmHweuDCGlHhjf99IZSP5DZNZ9lJrEU34Gzl+aSszHHywWtnxKeCm4yBoPigl75EDwGaYnMDEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjalqvRb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398e33155fso4235546e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727818854; x=1728423654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6ZUOGkluVo88+h6EwNIX/y68DTEkY3MNYQDDMOZx1w=;
        b=AjalqvRbeABUu9Ale8PFPDHzq3iWfxcJcZKDmOcB28P3LOWGkydsQaCIWRJCUECTvW
         3T2sd69BZ+3m5vBJkseAADU+GKi4lawAxTaU9eK6ZOQ18ZzIe4cul94hnL+SR7kUcyu0
         EJtzZMhMFnxpNvW/0jhool9uXVQfoipBQH+7zvnA7ge2p/saEZu1ryDo3cY7w+T0R4xv
         ZQvpmshwSwJU15fb7vCJoNt1L67c1WDjj3c062PhUPFWhj1QOFC4l7VIpqLluJQfkzqq
         o604hwn/XANSs00kouIGiWwQXfdrxWIO05LCKc+DXd6OLZLNuHb3qo1b+RDIJjIX4/SW
         mImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727818854; x=1728423654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6ZUOGkluVo88+h6EwNIX/y68DTEkY3MNYQDDMOZx1w=;
        b=qSW2pgO0WzCbAUJ2Uwx0CvzKN/wkyKJeSHlaWna9qUXhAOlje0lT0gC3ye4l6v/llj
         1Xou57ivmgj6P40TzzmAR0TjaDmXJln59pY4GJCWstb59IRb9/vpz/0hOx64pbzisDTo
         vhH3wYY4k/hwL+nvEANmiigRQrMV1vmqco8H7PRUuh1aJ5YhI+ZO/fYiLESPR+XWuXFW
         zJPIZOpEvxjwLwtuEnnFxbZPV4Z6wfCpVZoHepaa6pxfQAToy9H0P1P936dHxvhX7jeh
         g30QxKX3FFLyAL2asCxEfcAQfuyVsyFI5pEq/VOpBvhP8yzdxJIqGWHKzfOWN36vXz8/
         Dn7g==
X-Forwarded-Encrypted: i=1; AJvYcCUKmE80Yjv4t3uW0jV3ASD3LjBui4aK/SnbNnI4p9V/6gzeSSsYmYOrtDbvMedStjUO04mkhs1nXuaDssM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjVAFiFj+AIIZlTA9CYo8d+pu0o2ZynOSC7NzPqSSj7aOgNKF
	nzuelrge/gIIsnZEMkgBVop1E4uKKh53DDNxdgCI2tY9fcOh6jIa2GvhiMyf/HRsktaCb+T7ENy
	ReHCmPIN/CdrMrjCXlyaTgaQHk7OTc6QRE85T
X-Google-Smtp-Source: AGHT+IGSH4IxcrGWkax0XWAa+E07aDrZCdoXV4Cm4wdNQjcRBI3kNA9B0iPr/+4N5Pw29L77ZUL5oPKDnnuOLyMwlTE=
X-Received: by 2002:a05:6512:10ce:b0:539:8c87:1e3e with SMTP id
 2adb3069b0e04-539a0675f3amr529092e87.29.1727818853622; Tue, 01 Oct 2024
 14:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726602374.git.ashish.kalra@amd.com> <afd7d4c5192109519ada49885e9585a1699820bc.1726602374.git.ashish.kalra@amd.com>
In-Reply-To: <afd7d4c5192109519ada49885e9585a1699820bc.1726602374.git.ashish.kalra@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Tue, 1 Oct 2024 15:40:41 -0600
Message-ID: <CAMkAt6paBpDpX0w_0WzXp4KhoiryZ0mCvLZJDZUspTxEvS4Skg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] crypto: ccp: New bit-field definitions for
 SNP_PLATFORM_STATUS command
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	herbert@gondor.apana.org.au, x86@kernel.org, john.allen@amd.com, 
	davem@davemloft.net, thomas.lendacky@amd.com, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 2:16=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com>=
 wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Define new bit-field definitions returned by SNP_PLATFORM_STATUS command
> such as new capabilities like SNP_FEATURE_INFO command availability,
> ciphertext hiding enabled and capability.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  include/uapi/linux/psp-sev.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
> index 832c15d9155b..dd7298b67b37 100644
> --- a/include/uapi/linux/psp-sev.h
> +++ b/include/uapi/linux/psp-sev.h
> @@ -178,6 +178,10 @@ struct sev_user_data_get_id2 {
>   * @mask_chip_id: whether chip id is present in attestation reports or n=
ot
>   * @mask_chip_key: whether attestation reports are signed or not
>   * @vlek_en: VLEK (Version Loaded Endorsement Key) hashstick is loaded
> + * @feature_info: whether SNP_FEATURE_INFO command is available
> + * @rapl_dis: whether RAPL is disabled
> + * @ciphertext_hiding_cap: whether platform has ciphertext hiding capabi=
lity
> + * @ciphertext_hiding_en: whether ciphertext hiding is enabled
>   * @rsvd1: reserved
>   * @guest_count: the number of guest currently managed by the firmware
>   * @current_tcb_version: current TCB version
> @@ -193,7 +197,11 @@ struct sev_user_data_snp_status {
>         __u32 mask_chip_id:1;           /* Out */
>         __u32 mask_chip_key:1;          /* Out */
>         __u32 vlek_en:1;                /* Out */
> -       __u32 rsvd1:29;
> +       __u32 feature_info:1;           /* Out */

Is this the right way for userspace to check if a command is
available? None of the other commands are detailed like this one is.

> +       __u32 rapl_dis:1;               /* Out */
> +       __u32 ciphertext_hiding_cap:1;  /* Out */
> +       __u32 ciphertext_hiding_en:1;   /* Out */
> +       __u32 rsvd1:25;
>         __u32 guest_count;              /* Out */
>         __u64 current_tcb_version;      /* Out */
>         __u64 reported_tcb_version;     /* Out */
> --
> 2.34.1
>
>

