Return-Path: <linux-kernel+bounces-423691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED79DAB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2532165097
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD97200B8C;
	Wed, 27 Nov 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HuhYe1c5"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB8200132
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724075; cv=none; b=uuXE3hCYLCn9B4lHjYFXNruAFRISl0pP6c5epPJtA6l6GQj8WhC0GNTXppqn0OO0uFDW6cG1+aG/4xOzjNriKBn4neVkdq7TknOynyr30zj4GcmTHaHLQ6NVQ0/aGB8RSArsXyc+VdEMKhmRUdfLjhdOrzMGwABsgf2NwOsPCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724075; c=relaxed/simple;
	bh=wdNY7HX2WspIyz6Q35Nz/LQqzU4lAK3ST4AREKvs+EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+/g3jn2KkL84qChkUT7KQ2Utf4vSLIHbYj2n4ZF3tAm2b52Z1RuvDFzCqZpJOZWBmnLV3rvCWyBoDjZGgUHloguedf9F3fnVB7jOeuoZHKH6PR9xtnO0lDuSHS9lYfBCV9V/Nuj4st3rM01rOtMFtpU79HCN1zZg12dumTlQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HuhYe1c5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d01db666ceso7127312a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732724071; x=1733328871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjj15h+61TIjL9fWQW0WlE61jSKFQDeRBQ9KAl+OOw=;
        b=HuhYe1c5tZRQI2cZnAvlur0MOwKqsftMpv7uTXLAyMjsG09ToJeuiTAVkBXEfVj+hr
         3v5jwGiYO+EP6hnSSGatn7n/tHMrGLwytsJCgi6le+aSjhKTg/dCWX4eMbXMc9bbiatz
         5gm8sWSo6uTF9nJVa9GLfjCuV8bRq9Q3q5Scc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724071; x=1733328871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvjj15h+61TIjL9fWQW0WlE61jSKFQDeRBQ9KAl+OOw=;
        b=ZSh7PfPZNb2h1fux/X3GQEnK7BaNMOwl3cw40UX/ppmqaIZScWLoGIR3uuuaKIQR78
         yPPRnPmn+kS32WrjGDSlPj++Ij49G2B64+22OY63Ymq1U/+nRquWnLonGJErJ4nhxyG8
         XpT0YbL20d9VYjLsZtqSysN+y8BVFTtSzuyHDRIZkzwCt76KUVmHUMBZO2iBagU1TyUu
         2UMP/N8SIWKs29dlzksxgl6NLpoEklfCikBbIZ9UeiQ/CmgiA7/fEfvzquBSjE6AKiAb
         CAzP0Mdf7ZpntROBnHMuSdknO6oRT6kP9j50O/vJw2EGfyxy6nK9mBrTEl6eeGzWJYr4
         Z1dg==
X-Forwarded-Encrypted: i=1; AJvYcCXccWVYDd20wl8eTQUqBSUFFBMx2rM0+AUDo0E5OH0AIouXAWV5KQTE1KUej3bWYwIq5fU6YRtJ9RZXvas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgniMeGOs/TIAZxHMzub7AAjB0m71D3O7aUzBhZeD5iwM6pqwV
	rXp6Oftr80f/WFoOsB4r6QDe6wHnQqWxKBeyYv4zo4K47IhUm95TFe2lp+FNYAH1vdtx8s5Kpu1
	CnQeElw==
X-Gm-Gg: ASbGncud1HkmCNpApgQY4HSjcrn6LYbVCzIVzt9v5LQd6DgEL1w5U5FwwVIcPNHVZwY
	AGh8Q2C0quW1n1+iyFJORkZvdVsqDw4GUbUIog3M/Jt5UQO2AfBe6Lx/lKXOmr9+FvFlo/bf8MC
	tgUm0yYtTnYVZicZzTZzRk23Nt7tFY81wCkEFCb/tJsqfXI/GRhVQ+C0KlumKG3DsMPdoj+Kms7
	CDLQHkrky3/0nXJMIOz3KrVWCnUOil8FyBdT6+6HLCzuvR44dhKn14LpRQamuLhc/5ZG7TrEelJ
	F+57hT4hmOYFcQi6P6GuSKSo
X-Google-Smtp-Source: AGHT+IFrsvf+8cVf2qIHFszkWRDh4Aa8U8SAY65GppRpUGwI53WYYbw2AvSssn+RztDnF7dB5dCcrw==
X-Received: by 2002:a17:906:1db2:b0:aa5:459e:2db with SMTP id a640c23a62f3a-aa581062652mr264203766b.53.1732724071363;
        Wed, 27 Nov 2024 08:14:31 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm727374666b.187.2024.11.27.08.14.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:14:30 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa543c4db92so568355166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm4U+iqSPbYRmE3iGZ3zi559XVBfvYiCWVJxGEZdkaZP9UVkAhJaFNu6zHx+N9JMeUgzgrxBxk/ywH8Yo=@vger.kernel.org
X-Received: by 2002:a17:906:310c:b0:aa5:1dc0:7c1 with SMTP id
 a640c23a62f3a-aa580ed01d1mr234195366b.9.1732724070395; Wed, 27 Nov 2024
 08:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-vfs-fixes-08465cd270d3@brauner>
In-Reply-To: <20241127-vfs-fixes-08465cd270d3@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 08:14:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQC9pt4s3K0Be57ay2kSyDbUjiF2Jq4V1BPYi1z3Qx0A@mail.gmail.com>
Message-ID: <CAHk-=wjQC9pt4s3K0Be57ay2kSyDbUjiF2Jq4V1BPYi1z3Qx0A@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 07:41, Christian Brauner <brauner@kernel.org> wrote:
>
> I was sent a bug fix for the backing file rework that relied on the
> overlayfs pull request. The vfs.fixes branch used an earlier mainline
> commit as base. So I thought how to resolve this and my solution was to
> create a new ovl.fixes branch which contained the overlayfs changes for
> v6.13 and then apply the fix on top of it. That branch was then merged
> into vfs.fixes with an explanation why. Let me know if I should do this
> differently next time.

Thanks, this looks good - exactly like I think it should have been done.

Pulled,
             Linus

