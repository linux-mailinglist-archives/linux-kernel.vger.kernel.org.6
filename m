Return-Path: <linux-kernel+bounces-364686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F33C99D7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F07B210E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990F1CF7AA;
	Mon, 14 Oct 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ag9bTncm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E11CF5D8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936558; cv=none; b=k9SW4AI5ISyl4g6cLnkoyVr7SCxRLDOdLNH0iLPxf9kiCDagY8/+p25bXxu9mKtmQLBjDvuYWoKo743T05Tb/MQNkNjDAwt3TnhPmEI/XK8o8bi7F+kVD5meOIBandq1RzY+wV99hGvsZKyvrV1UX0ntEMgg1WKQ8DcRf1RlFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936558; c=relaxed/simple;
	bh=pNaDbRzoZ/ch2sXe8zWNqwjvHPWMDpOqULepUTLUdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwvPpO0D7zGpdUWQhoYY33ll0ilkpp6g/G/w/94eTDGoDBSLwFC7ryhBC2x5ssjE75x1KFTD44cpEzeMmbQUsbnysStZUEFTkUsGkfIBWGI6L1zIgLdWziEyL3F1Hly2hQVeOrsIl4Vki0OcAUgWZ5CYV/Cr6UVIVcVg6zIIDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ag9bTncm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso25677a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728936555; x=1729541355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0zqaAbHeI1jkohxhnn3/eoqtBWz6fWnFImTtGcQALM=;
        b=ag9bTncm5vPI/p17T9CR/FjmPdlcay/2/rb3nfUlYq/36+rNK2PIlUvno5LwH03mNH
         E9FJZG/XRh30d9CUWj6DZahwOFcGvNrQMOEkDJNhjMab9LHrliLOd3FRXY/2JqKAl8+V
         vvaRfyXtUALsqKCmANzBdB76veE7mxEVJxNoYQ/aAoDmBzDXyLE5FpX1FjlJYL1pA1Co
         0VqAPiAIZ9DuNoc1VjSpoNUthXSp0wtJK/stVXucRg0h1Ha5OcRpnT28eJo3fgJLO6c9
         8+ntktLZdY3/CwzTs2S3B3Cx1Er8JlO05v3D38ct7sl6waYQFd0wu7jc0Ax13RTNAEHM
         zyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936555; x=1729541355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0zqaAbHeI1jkohxhnn3/eoqtBWz6fWnFImTtGcQALM=;
        b=JbyNsLRCoCuRickBYH2sfvZwm1k8lklDMVJH05Ww0JVzWNotfR7NxquB44JW7Zwq5q
         iBfDXjA+tiOLYyhIeO8IIX53lfrYgiMCMFIxK3OZPdRiFrfBhBxZ/Ird5hVx571gKzTy
         5IzS7C+nSMgdFgCkF3FMKyJqn7k0GVP02q5T0kwPYP1YiuREruIyFL7Ayj1+AmlwzsrB
         VuxCPHIbZKK0HXMBbg2Nm4PYdVX7Ol0ryJY4CzMEr80UaAyDkycKcT9iyIqJaUuPW11k
         Ja8c9DSyZMYeaGZsAveD8cLrfRwHKmjJudqLhC+9Ex023ss++dGa8c6r4WmmVSmfYk8n
         pzWg==
X-Forwarded-Encrypted: i=1; AJvYcCXukToeUeNdlTFMTT4P+DgaVaV2Y/GmthLptidt31YaFXXTteniRF52tlwYcbyaOfajyvYHmBhb8PeYOtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLmg2ewc5VfliQ57H58kzaBEfgaHv887TQ67sC0CoW0CUpcTQ
	KYRZPPuzArKXpI2LphPkmvEGrvGEE18joVpchrGinUHgbaZpKowJ3z4gYCG3Oxz8ZerYCZams+m
	hmzDufiMO59RfttKyjLy6sw5FcKlNZQGVdOE3
X-Google-Smtp-Source: AGHT+IFe+18jaYfQr+21B0WFTGQIwcQex+WsgK+bAeIFw8v1CVPL3tiWr1CxsaBhl5XE5hKvMkCXjZhdZbiCyhqn9EA=
X-Received: by 2002:a05:6402:3495:b0:5c4:2e9f:4cfc with SMTP id
 4fb4d7f45d1cf-5c95b38b9a3mr532129a12.6.1728936554221; Mon, 14 Oct 2024
 13:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com> <20240903232241.43995-6-anthony.yznaga@oracle.com>
In-Reply-To: <20240903232241.43995-6-anthony.yznaga@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 22:08:38 +0200
Message-ID: <CAG48ez0OOpw17d73wB_HC55FVLeKOz0D9+teEHe7YAsY_00=kw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/10] mm/mshare: Add ioctl support
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:22=E2=80=AFAM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
> Reserve a range of ioctls for msharefs and add the first two ioctls
> to get and set the start address and size of an mshare region.
[...]
> +static long
> +msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
> +                       struct mshare_info *minfo)
> +{
> +       unsigned long end =3D minfo->start + minfo->size;
> +
> +       /*
> +        * Validate alignment for start address, and size
> +        */
> +       if ((minfo->start | end) & (PGDIR_SIZE - 1)) {
> +               spin_unlock(&m_data->m_lock);
> +               return -EINVAL;
> +       }
> +
> +       mm->mmap_base =3D minfo->start;
> +       mm->task_size =3D minfo->size;
> +       if (!mm->task_size)
> +               mm->task_size--;
> +
> +       m_data->minfo.start =3D mm->mmap_base;
> +       m_data->minfo.size =3D mm->task_size;
> +       spin_unlock(&m_data->m_lock);
> +
> +       return 0;
> +}
> +
> +static long
> +msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       struct mshare_data *m_data =3D filp->private_data;
> +       struct mm_struct *mm =3D m_data->mm;
> +       struct mshare_info minfo;
> +
> +       switch (cmd) {
> +       case MSHAREFS_GET_SIZE:
> +               spin_lock(&m_data->m_lock);
> +               minfo =3D m_data->minfo;
> +               spin_unlock(&m_data->m_lock);
> +
> +               if (copy_to_user((void __user *)arg, &minfo, sizeof(minfo=
)))
> +                       return -EFAULT;
> +
> +               return 0;
> +
> +       case MSHAREFS_SET_SIZE:
> +               if (copy_from_user(&minfo, (struct mshare_info __user *)a=
rg,
> +                       sizeof(minfo)))
> +                       return -EFAULT;
> +
> +               /*
> +                * If this mshare region has been set up once already, ba=
il out
> +                */
> +               spin_lock(&m_data->m_lock);
> +               if (m_data->minfo.start !=3D 0) {

Is there actually anything that prevents msharefs_set_size() from
setting up m_data with ->minfo.start=3D=3D0, so that a second
MSHAREFS_SET_SIZE invocation will succeed? It would probably be more
reliable to have a separate flag for "has this thing been set up yet".


> +                       spin_unlock(&m_data->m_lock);
> +                       return -EINVAL;
> +               }
> +
> +               return msharefs_set_size(mm, m_data, &minfo);
> +
> +       default:
> +               return -ENOTTY;
> +       }
> +}

