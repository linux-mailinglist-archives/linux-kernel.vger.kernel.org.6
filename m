Return-Path: <linux-kernel+bounces-558629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD75A5E8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA42D3B9C31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B21F4630;
	Wed, 12 Mar 2025 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TQrCwuVA"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CA1F3BA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823502; cv=none; b=qBY5wVTQgukdox9Xkjo6vB6O5+qPEzBzxxhRSb3IQfgmuBs8thXsoL16e34kJsAkkqrxKIulSWm4po25jqnrfo0nguVIxIDHA2vb7Q1+1xKViL2M/5jw/JDqeK7zlXz7bIzEYBYMMdhsFahcL3Z9UjVQRuYCZfBvBjYv2ct51eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823502; c=relaxed/simple;
	bh=VSZeQ/my8BFqmlDPi2QBVw79lfsnEAPO9LqbIejJYXQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PsfeEko2uqdJY7DMT2Ouin+Ed/Mgsm39/MxeDxZKvqtLmD8CKYvyDMqWy5Bh2vNxXgMqpSBtZLPmELLYA6aBGjeV2NhkpzEGrJ+r4ffvh7Isjg9Jn9NIsoY/TtS3d02JNvUncr3RMJoReou7pvEHqfD5NSY0rma3dPGfW/PGhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TQrCwuVA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476964b2c1dso5648441cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823498; x=1742428298; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRaBKu8m0fRQQzayD1HUneCZ9kYje/3LUrxSORvh3Kg=;
        b=TQrCwuVACi3327wPdgzR0SDML+pF/XcI9PC9SyMInupIDKsIlkfqzFp9gZdMVvXnlU
         B/3sSKt0ltF2K5L9GWGOi9o96pb3X/YjQPyXOjHeN7F/dkq1HDSteNKqDF5dWiIWf8O7
         x5Hbah1bypjIGEXck/OGnM1oY0qeKv8LHN+BeUXbm2HteRjEe2eJDjPRIh6JYfrCXfW3
         1MpTv0UfOikmMgAaI0eSXMVVBZdSPVTZu9s4Igdme1XjuVDauTMahqMDc6ibH4h4G61k
         ChRhgZr1xPuI2VqPUxGqBI9TZLnG01urllqmsFsL3XTG6SGJ4StbqaYglMfgRpHRkmKR
         iFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823498; x=1742428298;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRaBKu8m0fRQQzayD1HUneCZ9kYje/3LUrxSORvh3Kg=;
        b=JWO3yy3UH59zGuI8mghqLbft3HZUIKefYgb9bmCVzoch9CadAt9pCg1pYo2/JEqKVa
         PfiehVENti/ymJKQt7FToe5r+62H9rURA1oZiQMRQpyIxBuVQECVqIPCzE1Y8o13MUjW
         7t2ArlnYpYL31epcDpx3v5YZaEyInt0S4/0a7GTzWpDPUXvtwHdxlRDHvQwxepU4AjCt
         fEK5aPRoAVKxACItcI1shEEosa5OrTLZy/A1kXM1/iKakaiOB2KmejLTuTQAwZYpznbW
         7yaW0Ru4JbvND6ERchwcx1Gg7D+pO0Vu25EHeCiflOadcp1p6lYUXvarUahOky57yRCv
         BQuw==
X-Forwarded-Encrypted: i=1; AJvYcCVakiNFg+PcVWnR0axxJYK10aGYgFB4RVoqxy2P6mR7baKYFWn2iJeFfzRWBdjCOaSYz1fLeVEyFYjKuq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEW7JuSivFCQxCy3H+bC88KoPURzVHV0QAJIoHukJi/V/53EiQ
	DF6CgMEA2jewSKsYIHUNY1vGEwumPKwFjRbZMBdyYQD8XCa7ZR2Ct/O5CXKAYw==
X-Gm-Gg: ASbGncsapepPFlt30+m3Ps3jF+AW4ksFfjPcP4ZENuQh23Xv4T6g995HR6zSOehMpFT
	SoX+cUBT+yC0E3DGO5A+mT38+J0B6meVW0AawNJhyJ+QL9ElqC6mn0aUM4ZSXHo26sjQmR0Lg5k
	WX0cz+CKoWhQpaLSm19Ov7/ek1W/Nhxrwt8MYlprtEuv0+YULvFXNMqUjBRetjwgC0R2O6SB9jK
	A6mHkL0sFAx3ta5AtxNrr/4djLiZB/VSIKzAoZ1dLX2IJ5FLyCBypBz1+y/T9nKjiIlVXfhdH4z
	v9f+Cxse+n3u64FFUKGttH7FarvX9zTA3mFWKlvqTWS3CMnKQ4h5kwkyuXHF2JA7Roxqt167HYt
	/6uHeZDvuJzSqMg==
X-Google-Smtp-Source: AGHT+IGWu+3ka+Y4IH7wMg46s96MmAivhTh9BUXmfCkIPlUhY7zH5Ov4Q5CiLvjyN5NPXeFeiE15Gg==
X-Received: by 2002:ac8:7fc6:0:b0:476:7d74:dcfc with SMTP id d75a77b69052e-4767d74dff3mr226896341cf.4.1741823498434;
        Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb82bca3sm1412251cf.70.2025.03.12.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:37 -0400
Message-ID: <4d544b6fa041fec084c3d70a9f101418@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 5/6] Audit: multiple subject lsm values for netlabel
References: <20250307183701.16970-6-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-6-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Refactor audit_log_task_context(), creating a new
> audit_log_subject_context(). This is used in netlabel auditing
> to provide multiple subject security contexts as necessary.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  8 ++++++++
>  kernel/audit.c               | 21 ++++++++++++++-------
>  net/netlabel/netlabel_user.c |  9 +--------
>  3 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..ee3e2ce70c45 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -37,6 +37,7 @@ struct audit_watch;
>  struct audit_tree;
>  struct sk_buff;
>  struct kern_ipc_perm;
> +struct lsm_prop;
>  
>  struct audit_krule {
>  	u32			pflags;
> @@ -185,6 +186,8 @@ extern void		    audit_log_path_denied(int type,
>  						  const char *operation);
>  extern void		    audit_log_lost(const char *message);
>  
> +extern int audit_log_subject_context(struct audit_buffer *ab,
> +				     struct lsm_prop *blob);

Let's try to keep the typing down, how about "audit_log_subj_ctx()"?

--
paul-moore.com

