Return-Path: <linux-kernel+bounces-391412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBF9B8658
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B43F1C21419
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4C1EABD0;
	Thu, 31 Oct 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HwhAHJM3"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5A1D0E03
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415231; cv=none; b=HEzwzHivtMN6E1sWaBbTRlkQA5Nx1CNsa1db+MERvhWvhWdF9UctG3O/lt6uO0DneUqmqlmdjD4CaEVAVnJoA/lOzQiwJ1uqb9O0pKrn7P++v6cEqzhVLdjUCZcDsfZzaLldAAcwfW8DNAGA8hIKKzisVCCPgViCF9Cd6QGZABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415231; c=relaxed/simple;
	bh=d+KWwf0GkCHU+dO7dz7Ix9366JgUxkGbxc68is0rego=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=u7n3qHtrUN+lJV/jqPMm7XRp2JrMbSeL64WD+XCvoScQgrz+Pv13yEOzoxj8+Y0XcQgCjmh8dHhiBNjmvPnarc7fHxbs17mFWJtR/FiTcWJFJeGHw1Z40aEecK+Va41lBst9YTNt6Vf8IzDyPoDljJj8rQYH6jzF3iyHqfMkVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HwhAHJM3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b18da94ba9so123363485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415219; x=1731020019; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=HwhAHJM3tGqQd5r1l+ZE2Yf79wCAK3bP28oxsvotyurrRNEy46/9sjDN7Nb/tCOQLZ
         Hhb5QsdiXXy2BEMFk6Lw+t2y2JtNJCnArD//sJ8UCnrxT72AcDqYtpcyBDI6RN8dK+mH
         zoxp99b8QxPVllEDJA8BJTPTkD8q5gkl+qUsrgR9dWZaZxQ92Zu/YBzYenTxTk/8vMbW
         B0gzbjS9nnoepjR2aOd+BJtxlyLZH0ykx9Jq/6JPkBcEs6SBSVwK5b9xRw5oD0hqAACd
         /JYdkye1PvTHRqxEbVRUiAPQLszfIdxMuenem/A7QL0ywJOytU7XaS9PGtP5Lr70d4kO
         +N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415219; x=1731020019;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/1IevD7DLvIM994VGktPASZhi2RFBUm322v1qsmqeM=;
        b=nJNgB/1s4E5I4o2u09d+h8VbU1u5Te+R9Y2YZ9bOMJN2kuAKxs1TCyHC4h8cGqKaqo
         7V0KK8EDj0mM+9BIDQ0LjoORzQoVw4wqR5YjdoVRuKSD9H8WMYS7pfksSCpOKhUCPunu
         TLqTGXSTQF7m362TCc9feBeDPgj/PeYzExOKGbhnoVnbj5osen5Ugs4L3cGc+Di7+gjW
         USPRDncWpEfO0Yb+AwoUo7kl/gkFdTJf4rZ/CNBdB/7sXm1cW74uzBtk9O/Sq8GABnZa
         RK15zn6/VhnxS7d1ayrIqo6P3NgJmaQTGLT4JXaXqQrFmz1lXq43B651kyZap58Hjoaz
         KvKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUEJiUFfjYCkBDBeqqB1gKFkjzueEWc77VDev4WeF7FpckPp09ehQcGLTnBv3QPCLQdVaItAsEc4DOCSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWsJGoFk0fBIwSfD3Dev0OuzxK61sEFtMzSjvP+aor1VeU0Sv
	QjwsuCiKa9kGeaO90CRiYmZ5HYNLqOKXh5+9tjeOLG+6Us5K7SaPTBU4ifLOgw==
X-Google-Smtp-Source: AGHT+IHejnUcO00gdkp6GIPiLQ9d5ZeTLg4Tg4eKKtHh64s2L4WuXTwedaEARJS6sJEf6l71xF95Rw==
X-Received: by 2002:a05:620a:248:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7b2f3cd68f1mr599328885a.5.1730415219210;
        Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f820dsm115059585a.32.2024.10.31.15.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:38 -0400
Message-ID: <68a956fa44249434dedf7d13cd949b35@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
References: <20241023212158.18718-3-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-3-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single
> lsm_context pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> security_secid_to_secctx() and security_lsmproc_to_secctx()
> will now return the length value on success instead of 0.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c                |  5 ++-
>  include/linux/lsm_hook_defs.h           |  5 ++-
>  include/linux/security.h                |  9 +++---
>  include/net/scm.h                       |  5 ++-
>  kernel/audit.c                          |  9 +++---
>  kernel/auditsc.c                        | 16 ++++------
>  net/ipv4/ip_sockglue.c                  |  4 +--
>  net/netfilter/nf_conntrack_netlink.c    |  8 ++---
>  net/netfilter/nf_conntrack_standalone.c |  4 +--
>  net/netfilter/nfnetlink_queue.c         | 27 +++++++---------
>  net/netlabel/netlabel_unlabeled.c       | 14 +++------
>  net/netlabel/netlabel_user.c            |  3 +-
>  security/apparmor/include/secid.h       |  5 ++-
>  security/apparmor/secid.c               | 26 +++++++--------
>  security/security.c                     | 34 +++++++++-----------
>  security/selinux/hooks.c                | 23 +++++++++++---
>  security/smack/smack_lsm.c              | 42 +++++++++++++++----------
>  17 files changed, 118 insertions(+), 121 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com

