Return-Path: <linux-kernel+bounces-181418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602538C7BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A841F22DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E031581FE;
	Thu, 16 May 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvk25VVJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F156F23
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881567; cv=none; b=DsgQJBXBNvYcD4HUNoBZzM+hhIg3XtlwUUN8aeLlBP9+vAT9lKIK/SIqmVHCp+U7nC5mNybeEMnkeYa6ZphCJnOy8UGPuqSV0EHF/MxSLDeOcJjLNw+nW0pYexVWQOwO318A+aTU+U/VZfCesXgOSLwZV2dWXPsfDygOZ1x3Mds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881567; c=relaxed/simple;
	bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngA140XM2CxusHP/wPEwyxaHXm9h1C9bK2OYtF0zf47mgcBCrTdagRiuh4Lou8pDj+KE65qwVFJbYjNX5Ht1IfuJhQiN7LlXSimCu+D4Bxqo5ZVFf/UtDDJf+2mQR0gP5W0/4CIZIGnqECDhDGWgqnQBqgpRurmpWpcEotG1Ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uvk25VVJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so4130746a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715881565; x=1716486365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
        b=Uvk25VVJ9qbuzNpsL4oChQJRfYlnagT5+r09sGWMK8+VC5E7d42aFumVLuCBUx2R+H
         O2/I4e4BQgCX8VxtxTJTuyE4bTivpQW+DwcPpWLpknm36LMKsbzc2KQERnhnZfWiG5B9
         mFdxJ3h8TGu4sq3yW09XEBiv0CfJCgILIT1H6vBlRjqit0UNJLPx3BMdn1rTRkrYW29z
         fAdDmgN265mqTniWjLbqUUgGLzMoCxHLyvBSsDM8uUCv2gguF8YyvFjEozHTpBWT5aDG
         Aec2B+fYLVJ/lWU8+5znnJ3hxebXUwF35Pi6mUGtjQDQyGpFULmoj6LjVi0n8JC1OJhR
         +k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881565; x=1716486365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
        b=Yv0WdSH5JKI5rlY9b8Ae7YbKcHNraVFSPzJcRbFBi2i41WouEPt830x0FeA/jx5tnM
         yXKEuZatE30iuPE8fk1TN5QueM6vZah8DSinUdIrNdfk3Ww9j7k5ITq1eDhB75qtE8QW
         /WmB137qO6BQKGnK3EeyD2M/RN1aX8cfvxTuEsNBmyPNdI7LYpuUaYF4TInJjlAtf26t
         EgxsEhXwI6qDzyt+DaVpKL7rPdeydqgrl33zIOYWZlTpTLQLvA07MLoJxEwgb08SBoWl
         xc7ukkYMevVSM8M/DgBDOVtrw9GmdfZmiis+DQQrSSps1fzQdA6zSY9q/rf0KuCJqeC2
         feTA==
X-Forwarded-Encrypted: i=1; AJvYcCVTEueYpuZd9EEI3juCIGU9l2mwS6eiV4deHsp/6BEBI8WttUVFhPb+MlqV/t/NFi/yLbEAAKJAtLIFy4/W+TJ6Tydwza4TsPkFATj6
X-Gm-Message-State: AOJu0YwUdB9b6fHkANnkRRw1/Ypy7LIXPeTMJEo4ZQFAjtrMryrmNZeP
	uL0xnDcvpsMivHxFpW0zpvVlin3WGuPR+IchoA/AhjgqV7ShwE7BGst+wa2Y/fQf9SN2bH+JQbM
	LFIZLhDHmxKzkTPcFy8CTpnqbZQC6S3meie4D
X-Google-Smtp-Source: AGHT+IFtVHnI/HeI6RHiNHcOM4sVWOXQMemsaRcFuf/AFZHYdohKi+ZquyO7RYepjpYsIMd518QWrm82tL8e3zmrYb8=
X-Received: by 2002:a17:906:7045:b0:a58:c80e:edd9 with SMTP id
 a640c23a62f3a-a5a2d68127cmr1194167166b.77.1715881564304; Thu, 16 May 2024
 10:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com> <20240510152620.2227312-3-aleksander.lobakin@intel.com>
In-Reply-To: <20240510152620.2227312-3-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 16 May 2024 10:45:49 -0700
Message-ID: <CAHS8izMRaw3TyURSwdoAnd67EHpgdfazm7-jOFUAWuCAOd39ng@mail.gmail.com>
Subject: Re: [PATCH RFC iwl-next 02/12] idpf: stop using macros for accessing
 queue descriptors
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:28=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> In C, we have structures and unions.
> Casting `void *` via macros is not only error-prone, but also looks
> confusing and awful in general.
> In preparation for splitting the queue structs, replace it with a
> union and direct array dereferences.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

