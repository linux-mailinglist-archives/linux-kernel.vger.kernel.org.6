Return-Path: <linux-kernel+bounces-450037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2AF9F59DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53A216F9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1E1F9F5E;
	Tue, 17 Dec 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xL2+mjJi"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE63155CB3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475923; cv=none; b=IkzPBjr6xJRIXB9Qc01+os9FxNEVGEafFprmKftR3yHZv5pUJWVUM0LrXKMdC7vYybeOEGOSPOAMmzim/Y405oK50eghFkPnr4+8ktxEXDmzbranAkmae7rb70anVYFH9EMMgFuOzp2vY1EsU7iSNMF993n5sRvYQc1rHLp/+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475923; c=relaxed/simple;
	bh=+eyhKNJumZs6/FTEwOn6NrjFWtzki3e9oRxmhRQgX1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1OszNyaHWe7veQbFwJnAOIY2ltWefH4CXgsZEZIDqWsX5ceBao2jHvvuoMS4TjxyHGCK+tde+nN0NMLV32HY5pyhb0GnFMEChWVwb57ab8RHqg4dKNOQCw3PGY52YZAm/e3nCPUwq6T2OYZUjvlgUJtKT4FImiRWbfd3htdTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xL2+mjJi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1175368066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734475919; x=1735080719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVYL3s9CILTnwogTJZ1OTIZuv0ARpRPo5KpbFGa6KD8=;
        b=xL2+mjJi2YQwtSt4Yapr/JgbFLX9aECv5HMoMBmOG3xvVfDIIG2n1gK9XrKlBpxpwH
         90qjWwizqyRFAJt7176MCmN+5YBUGI9TshVBz5kTtoE4n+SlB2UMYosMkaGt4FWl4Nvi
         eh3eZ5nJxmuiIHN5QUW/zxuZNq+YmuWuZ8OSYMZbZIez3nFgs0cL2hbBHcyBs2MV9XEf
         HL/+vJmEYft9P0hCn2BiLUOgWTgQygby9ZeOuB9W4/Xtmx6a9aFMTWOVXYN9caaPcdy0
         JaXuEZsKQbHPykEDA3JPV/snigAlHVRryUzMOaOWqzd4OOeAOIGB9ZobUFgKJDHLrkLG
         iW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734475919; x=1735080719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVYL3s9CILTnwogTJZ1OTIZuv0ARpRPo5KpbFGa6KD8=;
        b=fUC2IJsvPZnK8mH61WzOONrN49aa9wsQeOtYRL53CwaLzeHpdR6iaZNm5HYr5lAyYX
         l38/k+SyLSOjYhwbABcaAOkR8Zup9nt4Dmc7VrPIgoiQWbu/NcVzG9L+YZAbNffEfzRT
         dF6aX5ZkLWPx3FSYhS0S8xvyoGcdjKz9L5nwKznsc7Drk1CNurVWxu1Ai7ifE5j45ZEl
         zuPqZzDaCBtMdNUskl1dM/bc7gWf2rHxZufXXNmPeiVwgArpvq+7CSl2574A2389jzwS
         5O9Eat1ZZBmR+dRZ1BafYlUh7pu5ocuSFzvMQY+vVudqzY9z+0LOreElUROb9yCU/mgT
         p3bA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQqp/1OFDGh4YuqVvjZFhBNyGdlBmgelCc1pzCjfgl8yQY+oARFlQTEn61DIp+xxORIy9AxX59q4Bl3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkSJ91GIp2Hcsdju52tUNeMjFcARWw9qt3llJ1ph8FzHjvWiI
	q76KDJAVOZcVLsHFP8icfGJsx7IRBsWEen8p2Tvrd6N5baDrdkaQlUVao8h6k18koF1IfHL86F0
	v9qRvobEblRA1a9nB99fh5bacWS0DMGGKNi5c
X-Gm-Gg: ASbGncvvDaOKn8g/FnnUHjEUKQrEZn/SMiajAitj7u9C4inyf+gkCij6819PFgwjQcC
	PJvPi9MeaQ4YN/iKa9yt7hZzZl3JBZqE/Ah+9GQ==
X-Google-Smtp-Source: AGHT+IH1GTjImrAaApRrEGDhHMKaiEFNxqjHCuhUD4o38YaFXBS8IA8KoPJRL636fi9mhowUw350/nmafoSV7nTEPLA=
X-Received: by 2002:a17:907:72cb:b0:aa6:8a1b:8b74 with SMTP id
 a640c23a62f3a-aabf4920960mr39223766b.53.1734475918650; Tue, 17 Dec 2024
 14:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734392473.git.ashish.kalra@amd.com> <a148a9d450b3c1dfd4e171d2c1d326381f11b504.1734392473.git.ashish.kalra@amd.com>
In-Reply-To: <a148a9d450b3c1dfd4e171d2c1d326381f11b504.1734392473.git.ashish.kalra@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 17 Dec 2024 14:51:47 -0800
X-Gm-Features: AbW1kvaHDgTDS8JrAFaBs3expr5K210DWpQNsbnGYLLnTtGnZ9fPc2iUNyA1dYg
Message-ID: <CAAH4kHai4mqmY6CB3Ybk6JxD7M=OX44k0S=2n_h_F4mVSVco6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] crypto: ccp: Register SNP panic notifier only if
 SNP is enabled
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:58=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com>=
 wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Register the SNP panic notifier if and only if SNP is actually
> initialized and deregistering the notifier when shutting down
> SNP in PSP driver when KVM module is unloaded.
>
> Currently the SNP panic notifier is being registered
> irrespective of SNP being enabled/initialized and with this
> change the SNP panic notifier is registered only if SNP
> support is enabled and initialized.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 9632a9a5c92e..7c15dec55f58 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -109,6 +109,13 @@ static void *sev_init_ex_buffer;
>   */
>  static struct sev_data_range_list *snp_range_list;
>
> +static int snp_shutdown_on_panic(struct notifier_block *nb,
> +                                unsigned long reason, void *arg);
> +
> +static struct notifier_block snp_panic_notifier =3D {
> +       .notifier_call =3D snp_shutdown_on_panic,
> +};
> +
>  static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
> @@ -1191,6 +1198,9 @@ static int __sev_snp_init_locked(int *error)
>         dev_info(sev->dev, "SEV-SNP API:%d.%d build:%d\n", sev->api_major=
,
>                  sev->api_minor, sev->build);
>
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &snp_panic_notifier);
> +
>         sev_es_tmr_size =3D SNP_TMR_SIZE;
>
>         return 0;
> @@ -1751,6 +1761,9 @@ static int __sev_snp_shutdown_locked(int *error, bo=
ol panic)
>         sev->snp_initialized =3D false;
>         dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
>
> +       atomic_notifier_chain_unregister(&panic_notifier_list,
> +                                        &snp_panic_notifier);
> +
>         /* Reset TMR size back to default */
>         sev_es_tmr_size =3D SEV_TMR_SIZE;
>
> @@ -2490,10 +2503,6 @@ static int snp_shutdown_on_panic(struct notifier_b=
lock *nb,
>         return NOTIFY_DONE;
>  }
>
> -static struct notifier_block snp_panic_notifier =3D {
> -       .notifier_call =3D snp_shutdown_on_panic,
> -};
> -
>  int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
>                                 void *data, int *error)
>  {
> @@ -2542,8 +2551,6 @@ void sev_pci_init(void)
>         dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initial=
ized ?
>                 "-SNP" : "", sev->api_major, sev->api_minor, sev->build);
>
> -       atomic_notifier_chain_register(&panic_notifier_list,
> -                                      &snp_panic_notifier);
>         return;
>
>  err:
> @@ -2561,6 +2568,4 @@ void sev_pci_exit(void)
>
>         sev_firmware_shutdown(sev);
>
> -       atomic_notifier_chain_unregister(&panic_notifier_list,
> -                                        &snp_panic_notifier);
>  }
> --
> 2.34.1
>

Reviewed-by: Dionna Glaze <dionnaglaze@google.com>

--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

