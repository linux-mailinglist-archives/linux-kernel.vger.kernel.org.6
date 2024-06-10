Return-Path: <linux-kernel+bounces-208895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80149902A52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCAB23A63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C755882;
	Mon, 10 Jun 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CWhCeBTG"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1E50289
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053009; cv=none; b=ahUKOufrXkWUvDX+AqaxalUvMsIYzl0T/KhCywnhAs6YVd36PqhySIhuABaXCIz+H/S6PqmbKeGDiCWI/y/ohAFNvfYgQp+H7IV9jzI8STxziWlNJ9YspQL7/6lr7ZoikAR4DNPHachtPvIzjDRcKEIKF4gd/qBTkf1YBBPlq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053009; c=relaxed/simple;
	bh=51EEDb0ue/Nhh7wtSldBpAO4aoc8AOeutvOQIatD1gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeICYBWhfRpv31hRbAN2S+0WJ/RZZqQHaauTwxp0mbfFPdiSQb9Jq7BWAjHrEk+OTTq9tVrAnnu7W5FqNapIL/oxWaAw4jLLAGc+3lv3ojjbGDOtp8+DIIeCnKILtewWyK8gjyUIivQytdqlbWk2pKa9zWlbmECFvBV9bEelLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CWhCeBTG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627f3265898so51487477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718053006; x=1718657806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCHlrp1sqWxXkENQgyX1SA6e/23clY3UwLtIBI7esY0=;
        b=CWhCeBTG3Q0p0XsuKyOTUvQ0qPEMzZFPx5wDriOHW+PHt9qNp8exs2zS4RhDUwz6tl
         0teTqbs4HduRtEbNGACtYTgLE6G2Et6VswyA9jy3DI/rd+FESjuGI2WafyolHNngzuHl
         kPNqTPfQxuKGCO5Zhyd49EprGdM9MtZXWPFQkcKs7gPwcRTQi/8eFw5kXRCHSBWdxZjV
         UH6CBNkS7rsS1yd/C3VW9yR4lf8mdKUrEHouq61hQ5uv3MPfx4r4AL+I439mBpsCJCr8
         GONZAvefmIEog28pmMNqE2MIXZm74FWIiVeMae0fvOfNlkx5ax8jZ2IaU+gWnCX5Ufif
         EfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053006; x=1718657806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCHlrp1sqWxXkENQgyX1SA6e/23clY3UwLtIBI7esY0=;
        b=bpjU8ktLXqaieUvgjb5DyQlZjqZNMKGalbtdGG5Cfc53uLhUohM5ndux4zXPBbro4g
         L8oQyKUCChW224txrEHqYOgw4Z91bQ+J6vRoB+VCWJd0k4xqFKrsHdbal7NiEtkArZrg
         i19rv+HeYkg/50odwbeDVGvvwqh7aeVu2ZLZf9FCBC1ZNncH96CAQbBfjs58f2vvqZbj
         MFkZmCkq1VRuxUmFwf7S3up87+xVLrjNRS7M9P1VuTAZb8Dzm4PMwh1g5Xi2OEb6SaZp
         iuh0shM30idt21XdJiM3bD1e/TKdek7L1WVWr3xEJut+hJ4ASMSne90Q2503EuuV5ap7
         D2aw==
X-Forwarded-Encrypted: i=1; AJvYcCV+08vDD6fQcnNBWnmwJQD2JHzVz8LCsQwp9v5goKk3RmRN2Yb5tsDxcsBepy3zTEEeZ5AY+f+R1K9JRePIh/jNAw27ebBHgBds9dHc
X-Gm-Message-State: AOJu0YysMlqyLdKjnVqNwx+LoKbpQv4u6jsXWCW2OPntTcssDzFWKS1A
	thjmZt4brBG95vAiaw7EUf2qPT8wb5LrO+VB38JN/MN0QfdK3iqJVJBYP7SqF2FbAS9tNCd2+sq
	JmaSXOYlViY3oiff9LHpcjwYvol74NXtreF2k
X-Google-Smtp-Source: AGHT+IFvfIOmbU92tIEUP97U962ZwkX+dae5pNDe8HVsVV2fINnzI7Cy6PJ/dYbQrp9/0zG0WtFUc6q1Xyv7UapuZHg=
X-Received: by 2002:a0d:c186:0:b0:62d:355:5b34 with SMTP id
 00721157ae682-62d03555e3fmr47903587b3.20.1718053006262; Mon, 10 Jun 2024
 13:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jun 2024 16:56:35 -0400
Message-ID: <CAHC9VhRekFEc5HHAEhp52tNT6NLnLw__fpy7F0Yq=Qry0Jk_-Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] capability: introduce new capable flag CAP_OPT_NOAUDIT_ONDENY
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:38=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a new capable flag, CAP_OPT_NOAUDIT_ONDENY, to not generate
> an audit event if the requested capability is not granted.  This will be
> used in a new capable_any() functionality to reduce the number of
> necessary capable calls.
>
> Handle the flag accordingly in AppArmor and SELinux.
>
> CC: linux-block@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v5:
>    rename flag to CAP_OPT_NOAUDIT_ONDENY, suggested by Serge:
>      https://lore.kernel.org/all/20230606190013.GA640488@mail.hallyn.com/
> ---
>  include/linux/security.h       |  2 ++
>  security/apparmor/capability.c |  8 +++++---
>  security/selinux/hooks.c       | 14 ++++++++------
>  3 files changed, 15 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

