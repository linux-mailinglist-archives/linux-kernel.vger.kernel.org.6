Return-Path: <linux-kernel+bounces-202493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E28FCD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E5A1F21FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72F1A2FD8;
	Wed,  5 Jun 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDMaeJy1"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED51A36A6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589036; cv=none; b=Hg/uDL3smujcK0YmhJDvI9PbEhHFy9IBYo/SfaKChNm+Y6mRo76zT+9EtRf3yH6bKv7cjkWLOiWMwOm4uyqMEJ0l0EUPwxEUUgb3zNBAJS4s9kc4jQLBQtrcGp4tSHz/kfmLBs5OlH+usPf6uJmqtlJS5J/Csu/11v1vFQGONYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589036; c=relaxed/simple;
	bh=6XXxWiOiR+u276GHgRQbO10d9sLX/iCBmrOC3KZAeNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjmqkPMmkjtDoUh4/n6LXfnoWty+pOB7BgtJ+7QBWwdd4uB/qpMy3fQjwjRLdsp4yEcsyoFgJnkTmKYqcrrFgI1CTOjavGk/2sl8HZN4qeBd4EKFqSyKvaja28uPzQi54OTL28XjWpazz/PLxLODr4f9GOH3tO/+EtHkEjqw4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDMaeJy1; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d1fd550871so1049186b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717589034; x=1718193834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfU5RvgXa6noLSObezkjdqjtTZtf5TE3PhxYWpHDRm8=;
        b=WDMaeJy10JNtsLcgTKRJ8T0lwwOqBMTHWF15IDYex+6uoaC8fhtwXm6+T+wawtlZP1
         +fgW7WZCtHgO+GPERMuzbUJAb6nzV0SJYLLvfxizbEToQl/vxGGyNsbHwh7DACQVo6Oj
         oHegMfcFSzK3QW9b2REReGCLu41pmjriTRznNXDugI2kJnWY/D92KIuJH5rdmf8nrsJL
         aJ+mI89uk8BTTgAibAj3q2tl2Awbaqu4FfWhciRPikZYwO5hmAIzOuKPd2dmniY+QQMX
         9+KvDlW6catdJrLz1HCBKWse6OaSctsp/jk58feW70ita/6If7ZFHMGwhMA/uosewtu7
         POrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589034; x=1718193834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfU5RvgXa6noLSObezkjdqjtTZtf5TE3PhxYWpHDRm8=;
        b=CS4xK4BVoQBVZNB7tYWWjxHUc3KCDt0OjmhbWRruHFAB81hsggEsW8UBw/cUuV1PZf
         DzImcYYmvfEovBu2lxTl2v82taFlzjTykFXRV5f3rf10ELP+7cG13RyWAF9Bsutz8eYK
         z+ZxdshLgKMvrTOA8+x53BykVA/R7bBOs1bq/dyP39CW4nO2iTsDFYU9uWDJGeF7SR9+
         byZmaMJ0m0kArZcRxR/eMQAx/oBTmvQqV8j3PQm7qRTkpEKvPCRXdoxebfkkOmhGPVMm
         fKpCIxsx/b6KPe48m0pveFVou35rqeQ2zXwLMMXWxGzIfHmgGG04gCRcShWFL0+Sznuy
         IYLA==
X-Forwarded-Encrypted: i=1; AJvYcCVtkVoM6/561Zn0Qg9yBQkKSrFanlZBchCilz6Xzx4RBrSalMdhYxOcNmjMPJ82c2BKpM9WBmcFZZ28kKarlyR5fg011ipG8/MVuswV
X-Gm-Message-State: AOJu0YxrH2IAKuDVoKN90zXhaZGPh0i4p6fkePfI/7GpBOUGVLp/8P6z
	Iuc/e7xUn5nGaps2jQZXEZ672mW9kYKQyNSkkAaYeHzcUwtHjd7oKQV4SJjJPQ+7FKF5/TW5AwH
	jfXL0oerOTnYosVWsfd1WN2m3KoeI/SaTTNHc
X-Google-Smtp-Source: AGHT+IGgQiXZFEiixSSa68R2r8TivxLrnDReyAP/jHo+afBsrwWUzmjR3j17eq7K/ZdRWmJht89jR/C+XRFa0Bp4FFA=
X-Received: by 2002:a05:6808:3081:b0:3d1:fe2e:f896 with SMTP id
 5614622812f47-3d20429b7eemr2770398b6e.16.1717589033342; Wed, 05 Jun 2024
 05:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-kvm-arm64-fix-pkvm-sve-vl-v1-0-680d6b43b4c1@kernel.org> <20240605-kvm-arm64-fix-pkvm-sve-vl-v1-2-680d6b43b4c1@kernel.org>
In-Reply-To: <20240605-kvm-arm64-fix-pkvm-sve-vl-v1-2-680d6b43b4c1@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 5 Jun 2024 13:03:16 +0100
Message-ID: <CA+EHjTyGWu-5JQjhit310VY8fOeVZ1Ht7cbfYoF-AUi0yEDJYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64/fpsimd: Discover maximum vector length
 implemented by any CPU
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Jun 5, 2024 at 12:50=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> When discovering the vector lengths for SVE and SME we do not currently
> record the maximum VL supported on any individual CPU.  This is expected
> to be the same for all CPUs but the architecture allows asymmetry, if we
> do encounter an asymmetric system then some CPUs may support VLs higher
> than the maximum Linux will use.  Since the pKVM hypervisor needs to
> support saving and restoring anything the host can physically set it
> needs to know the maximum value any CPU could have, add support for
> enumerating it and validation for late CPUs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h | 13 +++++++++++++
>  arch/arm64/kernel/fpsimd.c      | 26 +++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)

Actually, I was working on fixing it and was about to send this, which
I think might be a bit simpler than what you have. Let me know what
you think and I'll send it as a proper patch if you agree:

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsim=
d.h
index bc69ac368d73..8bde13b7faa3 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -184,6 +184,9 @@ struct vl_info {
        int max_vl;
        int max_virtualisable_vl;

+       /* The maximum vl encountered for any cpu in the system. */
+       int max_system_vl;
+
        /*
         * Set of available vector lengths,
         * where length vq encoded as bit __vq_to_bit(vq):
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 82e8a6017382..e0af4c3c9a40 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1006,7 +1006,7 @@ int sme_get_current_vl(void)
 static void vec_probe_vqs(struct vl_info *info,
                          DECLARE_BITMAP(map, SVE_VQ_MAX))
 {
-       unsigned int vq, vl;
+       unsigned int vq, vl, max_vl =3D 0;

        bitmap_zero(map, SVE_VQ_MAX);

@@ -1031,7 +1031,12 @@ static void vec_probe_vqs(struct vl_info *info,

                vq =3D sve_vq_from_vl(vl); /* skip intervening lengths */
                set_bit(__vq_to_bit(vq), map);
+
+               if (!max_vl)
+                       max_vl =3D vl;
        }
+
+       info->max_system_vl =3D max((int) max_vl, info->max_system_vl);
 }

 /*
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 3fc8ca164dbe..9f751cce8081 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -52,7 +52,7 @@ int __init kvm_arm_init_sve(void)
 {
        if (system_supports_sve()) {
                kvm_sve_max_vl =3D sve_max_virtualisable_vl();
-               kvm_host_sve_max_vl =3D sve_max_vl();
+               kvm_host_sve_max_vl =3D vl_info[ARM64_VEC_SVE].max_system_v=
l;
                kvm_nvhe_sym(kvm_host_sve_max_vl) =3D kvm_host_sve_max_vl;

                /*

