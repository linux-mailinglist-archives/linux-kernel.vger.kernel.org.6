Return-Path: <linux-kernel+bounces-301592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9A95F2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5531F233F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A6185945;
	Mon, 26 Aug 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="R6dTqiCp"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF3185E7B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679289; cv=none; b=Lm8Jv1R131biao8RzbSbY3bM1ESTX6D5o6VCF2qFCWpfIUWNS1sNxHtoiJV5mjtnLzMJhb8Hl1e1x+Wx/iOzCIcRi/bluol1VahGizNDG2vE6qQRegn3ARvKrP5pR9ZHmOyPib3Ez5/P/iTTg5kmJehFpl7M96A3chAMPybNMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679289; c=relaxed/simple;
	bh=sj8FjlDhb8FrCpLrXqSGR+t1pa2ldUyCypN0rEuuhdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxrxyrHhIrrUbqRnZOU83K0XF5L9H0YE+Aj+Z4bW6EnIq6ydCsFvkS2nTNNukC5TdkVhwFz8uOxLN8iwd72Bcjy3JUoJ+GJpjaK6m15MT2SXLfBSq26Xr07UVfi+ZzN8hXgZVJIJ+Za3/IJPSny8VKxQvXddSZTQ6IAzxIw3I9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=R6dTqiCp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BD7E33F67D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724679284;
	bh=wa2RMhR78BaHm2VHuwhjPWdcU8rO0GKC1FkCDsO20v8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=R6dTqiCpvPthUknoKTwdd3zWHOun355C+qyHvSvPgOh+Mz9xJlPT24FQu2RmeSX5y
	 yJMrkAyz4qcEbp1B7BDL2EIlrfMJNHHZ/JH55en9vQOuFDLP2q1+nJ1sNd8+a0OG5e
	 gStvecpojoLAUSxkbxhCZIi2olPAQAIjHzaixoDy1rDa+1rvAPuk/jXbIYlU3Me5Tb
	 0/Ko6j3m/QfLqc/uKXzIggkLXIDoaxwKv+twqtOqcjHXBIqfRpSkzvTAjfrcY4a/TT
	 BQEUmbLoHe7NlDdCRn7h1QdgIexItt4vJ3N1g9RpZrJ99Sj8T0oOf4zFnXrEF20Tti
	 U0iUkSFHzigHA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7143d66b510so4696023b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724679283; x=1725284083;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wa2RMhR78BaHm2VHuwhjPWdcU8rO0GKC1FkCDsO20v8=;
        b=BtO6C2H16CZ4DoDz6az292nSqxVO+a5aLv7aZPQCfs4X74gNMFzFv0msTqRv49iqOR
         iu15EMre4+9cZzk0Gq5bLLDc6d6nJpU4ScG607nkHqnrCGQRUSntX3xxn3cinLtQlTHt
         2jFQZrXyU4H+FirZ2YACOK8a2Wc6Fahvaa5zYYxhV26ZgbiYSwT1Jnp34OjdEtLKn1AD
         Mk8fu7nn6L8WVHqehk8amFs//DYHGjuQbnUytXPZ4NFR6+BTu0wLURXBo27LR9lKImrd
         s0O9SjpugGYTugF++oXmjTPMP4j6vkDRoM31VSqzA5ufiHP98zgDEDfLR7t3COGUm9uM
         /JYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbLJfdvycMGy9hLfP+JUZDMqUK5DUj1AeHKZ+XRRm8WGW8XNU6/hnDmCQHeGpbhiZ7XZn+3ojAvPDR/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKPZUKRyB+qcizNtkbhssAruHr8ssG7jmpEG+VISoCojIv0b/
	7wMsIkMshCNKFxbbMLlzBFzhYd/77C9I6HjChZZvP9lcY0hARFwTXZvnp6y1PNMcwN1ILjUIEM/
	kFGUJciUhF/pnLjkG5GJHKJKSHW4f5puZAIdfwcWrmNRN+TRYjPOaybgjyRdZ5Z6ArmNZU+iysI
	FQOg==
X-Received: by 2002:a05:6a00:91d0:b0:714:10d2:baae with SMTP id d2e1a72fcca58-714457d3456mr10981278b3a.14.1724679283024;
        Mon, 26 Aug 2024 06:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtDq3UfRYa9zSSlw5VssnEWk7ArsIMz2I5L9LZu9eHCrFMen2AJcPpBmKw28y/w5pZfYNrfQ==
X-Received: by 2002:a05:6a00:91d0:b0:714:10d2:baae with SMTP id d2e1a72fcca58-714457d3456mr10981241b3a.14.1724679282479;
        Mon, 26 Aug 2024 06:34:42 -0700 (PDT)
Received: from ?IPv6:2001:1284:f502:1ed0:dd4a:fefa:915f:4c09? ([2001:1284:f502:1ed0:dd4a:fefa:915f:4c09])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434336fb3sm6966847b3a.201.2024.08.26.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:34:41 -0700 (PDT)
Message-ID: <63b777bb7b200f26f06211d62e2be8e5e571666d.camel@canonical.com>
Subject: Re: [PATCH 01/13] LSM: Add the lsmblob data structure.
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Mon, 26 Aug 2024 10:34:36 -0300
In-Reply-To: <20240825190048.13289-2-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
	 <20240825190048.13289-2-casey@schaufler-ca.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Casey,

On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
> When more than one security module is exporting data to audit and
> networking sub-systems a single 32 bit integer is no longer
> sufficient to represent the data. Add a structure to be used instead.
>=20
> The lsmblob structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> The module specific information is included in a new set of
> header files under include/lsm. Each security module is allowed
> to define the information included for its use in the lsmblob.
> SELinux includes a u32 secid. Smack includes a pointer into its
> global label list. The conditional compilation based on feature
> inclusion is contained in the include/lsm files.
>=20
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>  include/linux/security.h     | 20 ++++++++++++++++++++
>  5 files changed, 86 insertions(+)
>  create mode 100644 include/linux/lsm/apparmor.h
>  create mode 100644 include/linux/lsm/bpf.h
>  create mode 100644 include/linux/lsm/selinux.h
>  create mode 100644 include/linux/lsm/smack.h
>=20
> diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
> new file mode 100644
> index 000000000000..8ff1cd899a20
> --- /dev/null
> +++ b/include/linux/lsm/apparmor.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * AppArmor presents a single u32 value which is known as a secid.

Just a small nitpick: this comment doesn't match the code since it's
using aa_label instead of a u32 secid.

> + */
> +#ifndef __LINUX_LSM_APPARMOR_H
> +#define __LINUX_LSM_APPARMOR_H
> +
> +struct aa_label;
> +
> +struct lsmblob_apparmor {
> +#ifdef CONFIG_SECURITY_APPARMOR
> +	struct aa_label *label;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_APPARMOR_H */
> diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
> new file mode 100644
> index 000000000000..48abdcd82ded
> --- /dev/null
> +++ b/include/linux/lsm/bpf.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * BPF may present a single u32 value.
> + */
> +#ifndef __LINUX_LSM_BPF_H
> +#define __LINUX_LSM_BPF_H
> +#include <linux/types.h>
> +
> +struct lsmblob_bpf {
> +#ifdef CONFIG_BPF_LSM
> +	u32 secid;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_BPF_H */
> diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
> new file mode 100644
> index 000000000000..fd16456b36ac
> --- /dev/null
> +++ b/include/linux/lsm/selinux.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * SELinux presents a single u32 value which is known as a secid.
> + */
> +#ifndef __LINUX_LSM_SELINUX_H
> +#define __LINUX_LSM_SELINUX_H
> +#include <linux/types.h>
> +
> +struct lsmblob_selinux {
> +#ifdef CONFIG_SECURITY_SELINUX
> +	u32 secid;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_SELINUX_H */
> diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
> new file mode 100644
> index 000000000000..2018f288302f
> --- /dev/null
> +++ b/include/linux/lsm/smack.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Linux Security Module interface to other subsystems.
> + * Smack presents a pointer into the global Smack label list.
> + */
> +#ifndef __LINUX_LSM_SMACK_H
> +#define __LINUX_LSM_SMACK_H
> +
> +struct smack_known;
> +
> +struct lsmblob_smack {
> +#ifdef CONFIG_SECURITY_SMACK
> +	struct smack_known *skp;
> +#endif
> +};
> +
> +#endif /* ! __LINUX_LSM_SMACK_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1390f1efb4f0..0057a22137e8 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -34,6 +34,10 @@
>  #include <linux/sockptr.h>
>  #include <linux/bpf.h>
>  #include <uapi/linux/lsm.h>
> +#include <linux/lsm/selinux.h>
> +#include <linux/lsm/smack.h>
> +#include <linux/lsm/apparmor.h>
> +#include <linux/lsm/bpf.h>
> =20
>  struct linux_binprm;
>  struct cred;
> @@ -140,6 +144,22 @@ enum lockdown_reason {
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> =20
> +/* scaffolding */
> +struct lsmblob_scaffold {
> +	u32 secid;
> +};
> +
> +/*
> + * Data exported by the security modules
> + */
> +struct lsmblob {
> +	struct lsmblob_selinux selinux;
> +	struct lsmblob_smack smack;
> +	struct lsmblob_apparmor apparmor;
> +	struct lsmblob_bpf bpf;
> +	struct lsmblob_scaffold scaffold;
> +};
> +
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1=
];
>  extern u32 lsm_active_cnt;
>  extern const struct lsm_id *lsm_idlist[];


