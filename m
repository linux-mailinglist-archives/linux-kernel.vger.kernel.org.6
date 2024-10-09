Return-Path: <linux-kernel+bounces-357360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C882997056
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48456282587
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B981F7099;
	Wed,  9 Oct 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VGlkuqiU"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5D1F7084
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488239; cv=none; b=UG3ceCNxMDnyoCabPH0lQtB8gFf2fD0RQF/y0/ZOnFB57VylBXzxzE/Y3u1o0wBh7gf24P2mxXjPldmcPeo1tYKUSgJz43mhGDSWzOW1FqzUiUusoOk9pQ5iIlJCoH6j3L+H9EXmkFkdVGe3o2x2WiluJEixoWUwo2N3V1WxsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488239; c=relaxed/simple;
	bh=La4KVBvoExKm9pO09UAsxMsz2f1GjMBJB04Ukn3GBBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcS++brfMlcDZhMhhFc4SZQasKNxEFlpd8K8woSGJhWTPW7xwpeh8X12tG9zg6vdLXkQYJgeCNGM3Mw+7w77ppRuGp9b0WFu5wHT6l6S0Z9DbBoIWJJxZ2p94ieXH1JuWeyrwhH/jLkC8CIZ0DCWg9Fu9O53nb2TKqWq7tpNMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VGlkuqiU; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50a87472832so1863978e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488236; x=1729093036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=VGlkuqiUsB0pWWkcZ3G0Zj5BDzVCtgiQCy283PDBNf3/M0aBDd3r+YxGncj7lg3CyJ
         2yaYH4Tg9TyACyW2XOp+Rb4dcCfr3eOGPL4JFIx9zY5fzKgqH6Wh+OXWasXIn0GFuh7t
         U5aakPSJyibwjoQeIBRXwqFnufHi4ZcxlF4CrK0gL9Y3Mn4ne4tB71SOzrNQTPfdhVkJ
         Uf/OwTuU3Ju+0wIc25QX2ZtyzL46dx0R3Yh0sqh4/mWW5bu54Qsh4Etzp4EzonDGt443
         JEDxfZsRR2/CGo5GB2sOpLAOxq9rwkhp/GexxnA1Ws8eYu4IWdgr7ZMmOcJixiMaQK4s
         0kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488236; x=1729093036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD7QcnVhTK/TsR50NL59rPOb7Kr6qLYjhaf79NkEfzg=;
        b=T76Th00Cv8RdsRh3qm4W5sUo7TzZHrpNQpRt5hyss4+BvoioEZfRjs00T04L8kpPV3
         ECL57VV8Y5CoNp1Xki01DX8Dq9qwEHbOd2F/CQGnHxH1heQNlOWq3KbzWiL4Or48L5KL
         Kvo2gaVaExOHgPM2x9UtYFrTUNS5XqzOihuvAEgIlf1cQdIOuxqjVN8RzR9Mu3DuRglH
         xxn1BSkn8eu9xZ3vHj8EDcScRGjqKQwQhzuJCKCdJpllktFyCZEv0QlshHr4MdwcEBvP
         F2wojQPv6Qy2U3cHj0190CAljeWuIzJUrSWm7TQM2XHBOkKyxhZ5Jw2ZyqBYgA3GrzQx
         0iuA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9O6tcis7xRV/mkhb4/z3CeaH8SYq6fqF0t/p2JsS8dSzYuSSou5b85G828uIA9ob9xW59Zs4U7SgUNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/UNqED42G14QPc8opl4QT2VcZ+mKvSKAseRLWyRNoiRsSB8s
	MKiFW+1IYbLMMdYRdnCsd7F92C+lTNJRMXGoBuU87kBwuy9JHe+dhw9KWqRtwynfv0kwQntBgYQ
	vON8+bWBA5w38VF9O/SRIzgYBdbOi5FYBApvT
X-Google-Smtp-Source: AGHT+IEu5xzMzhH/wgeDgjEGKWpciv4mCxSojd55huo7SKv5IrO0ylLHZx0Mi5aaHn5HxWNAJbzCfGMT+FuD46vf8r4=
X-Received: by 2002:a05:6122:3126:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50cf0c7e54dmr2055501e0c.10.1728488235831; Wed, 09 Oct 2024
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com> <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:37:05 -0400
Message-ID: <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Move out the mutex in the ima_iint_cache structure to a new structure
> > called ima_iint_cache_lock, so that a lock can be taken regardless of
> > whether or not inode integrity metadata are stored in the inode.
> >
> > Introduce ima_inode_security() to simplify accessing the new structure =
in
> > the inode security blob.
> >
> > Move the mutex initialization and annotation in the new function
> > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > ima_iint_unlock() to respectively lock and unlock the mutex.
> >
> > Finally, expand the critical region in process_measurement() guarded by
> > iint->mutex up to where the inode was locked, use only one iint lock in
> > __ima_inode_hash(), since the mutex is now in the inode security blob, =
and
> > replace the inode_lock()/inode_unlock() calls in ima_check_last_writer(=
).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima.h      | 26 ++++++++---
> >  security/integrity/ima/ima_api.c  |  4 +-
> >  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
> >  security/integrity/ima/ima_main.c | 39 +++++++---------
> >  4 files changed, 104 insertions(+), 42 deletions(-)
>
> I'm not an IMA expert, but it looks reasonable to me, although
> shouldn't this carry a stable CC in the patch metadata?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Sorry, one more thing ... did you verify this patchset resolves the
syzbot problem?  I saw at least one reproducer.

--=20
paul-moore.com

