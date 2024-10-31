Return-Path: <linux-kernel+bounces-391410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF939B8650
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDB1C21175
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B21D04A6;
	Thu, 31 Oct 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mcxc8UaQ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B801CF5E2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415225; cv=none; b=AxKaL8Qw6+/rmoDU+aVJxEham1jzCTel8gsKCriV3q5RliVGOMxFVdefEhB2eOILtH7f67pPbF6+QRSSrgxsyzwTeHF2WggurjOGCaSMSwC0SuDQNupbusskO5fI2JFgIC6HYpLKc2Mk9Np29g6G8mUrDWsiYGKFcdJAZWLgWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415225; c=relaxed/simple;
	bh=JjJ8QQeKo9Bc7l3L6oH1g7yFrDcQSl74/ZP+UEmeNJo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gF+CZ0MOst0VCN0x9xwMNwgCgv8XbY1PkMBp2Y5q+CcFyMZla7+CTWYW9PJ1/xTVhL9zcPgayz5pyRy2Ht6RgiSLpwLHIVhIBfddvogpS0ZFtZA3dLgqaZ9cFcLC9EWoijCAcbcxPhOzzyQ/P6YREaGy1Qkgb6eHY9IarEX3Y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mcxc8UaQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so9429716d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415218; x=1731020018; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCgwTKVFt7wqnix2xMLtGBGcv0MC1rv7OZcvDtlQUvc=;
        b=Mcxc8UaQdORTCwDIGzUqqGfNPY0R1MqZWMghxrP22t+ndyCWybzR8eUNk3kd+8E5SC
         9D706fy6xmJx26psBwLxg3FBRJFOkC/oXbo8efVCKt2vHaTjjvTNpcWxpmFkRiDAULo2
         Y5FeR/ls0vY/shOpgiRK4BvtXzTZhEdezRgmawieO4/mpNOXJ6scH5w4/JW8JyW4KNj8
         dGBoYVz8UWUg9hVQhdCnkKoN2NyIEDua6w+4Nw3947Bu7zs4Zq51IMb0asxpHUo4+QrT
         AXR2L+2Q2h+2FxPhxSdT0UhvrzotpQr7rqitRVJcLw1Lt6KvJuVq0GNxatjEHKKLOSki
         kiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415218; x=1731020018;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCgwTKVFt7wqnix2xMLtGBGcv0MC1rv7OZcvDtlQUvc=;
        b=CuhXC+ZRTG6BLkRMilcpyYnf3DvKV91oVDCok9JA4+arzwiU3B72JascwwHL/1SMLk
         yNoPISCUTQ4URWRpaact3991HQe0mWRJuRDBEqzVFfd2YhksBG+3lOqRRRKmkUArkKf3
         m+sHbH6+cMYaZHXZTHpX/GhQ1Td+FSTZchvAqHZifRcJtjIPcQDS88yvAvvxdka7WjJN
         Gs4lhPvI76ZyT1R7vIE/octRanmHYYD8hjDC29Rg+z+v2zcGlYZyihVhJou8Sc+3Vyyu
         aCWXTFlrN9NQ+1dMFEXUrnV//9Y9JPtybo1rxX+GIFk15dcoRvt/lvRbzflwJNDyuQBZ
         RAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWOvzCa6AGrjUyXBDGxRV5Re4cpI4OrWslXnz6f4uz3Li1XRPACifiamrBrPhU7leO/B4eZIz5BFW7/azE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiT32YXaN20dSrnuJOWuhq3/6hGG046EzTiio+WBJGPN60W9E
	k65jh25tk9xJIfAHG2H0LE3rIwTYpoHG12GSD3PBULiiALvhtkaBKo+PJcbzYQ==
X-Google-Smtp-Source: AGHT+IEWkU1+2+UR2q0jbd3R64LMFCKC5USLw1o7THh7ScgK7rY6LOrzEpmH2Dade75ISTlwVkPOWQ==
X-Received: by 2002:a05:6214:5888:b0:6cb:fa7c:33bb with SMTP id 6a1803df08f44-6d1856b635fmr278669766d6.12.1730415217948;
        Thu, 31 Oct 2024 15:53:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9efbesm12768306d6.12.2024.10.31.15.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:37 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:37 -0400
Message-ID: <da6c8ffc5088f7dc728b2fcf61ee34ea@paul-moore.com>
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
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 1/5] LSM: Ensure the correct LSM context releaser
References: <20241023212158.18718-2-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-2-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a new lsm_context data structure to hold all the information about a
> "security context", including the string, its size and which LSM allocated
> the string. The allocation information is necessary because LSMs have
> different policies regarding the lifecycle of these strings. SELinux
> allocates and destroys them on each use, whereas Smack provides a pointer
> to an entry in a list that never goes away.
> 
> Update security_release_secctx() to use the lsm_context instead of a
> (char *, len) pair. Change its callers to do likewise.  The LSMs
> supporting this hook have had comments added to remind the developer
> that there is more work to be done.
> 
> The BPF security module provides all LSM hooks. While there has yet to
> be a known instance of a BPF configuration that uses security contexts,
> the possibility is real. In the existing implementation there is
> potential for multiple frees in that case.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c                | 24 +++++++--------
>  fs/ceph/xattr.c                         |  6 +++-
>  fs/nfs/nfs4proc.c                       |  8 +++--
>  fs/nfsd/nfs4xdr.c                       |  8 +++--
>  include/linux/lsm_hook_defs.h           |  2 +-
>  include/linux/security.h                | 35 ++++++++++++++++++++--
>  include/net/scm.h                       | 11 +++----
>  kernel/audit.c                          | 30 +++++++++----------
>  kernel/auditsc.c                        | 23 +++++++-------
>  net/ipv4/ip_sockglue.c                  | 10 +++----
>  net/netfilter/nf_conntrack_netlink.c    | 10 +++----
>  net/netfilter/nf_conntrack_standalone.c |  9 +++---
>  net/netfilter/nfnetlink_queue.c         | 13 +++++---
>  net/netlabel/netlabel_unlabeled.c       | 40 +++++++++++--------------
>  net/netlabel/netlabel_user.c            | 11 ++++---
>  security/apparmor/include/secid.h       |  2 +-
>  security/apparmor/secid.c               | 11 +++++--
>  security/security.c                     |  8 ++---
>  security/selinux/hooks.c                | 11 +++++--
>  19 files changed, 165 insertions(+), 107 deletions(-)

This revision looks okay to me, and with no real comments from the other
affected subsystems on this or the previous revision I'm going to go
ahead and merge this into the lsm/dev branch.

Thanks Casey.

--
paul-moore.com

