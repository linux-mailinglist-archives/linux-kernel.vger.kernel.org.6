Return-Path: <linux-kernel+bounces-202805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D48FD167
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CFD1F23DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4D3C488;
	Wed,  5 Jun 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uft7vvsE"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261127701
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600208; cv=none; b=nanydyg0MT3NP8NpyI1oIfLsXJdTH3jpY84cvGgJ6xG5bwJmCpw7Ho5QHg8b/gm3g2Crxab2jrRM5+EvWd2v2bPxiI84t8zl27SHS7GFynAVRRns87xndayZHJ9G6FSbCuep/iZFa90llPscoSkH6G+rcgZHz1+oxrsqBKM7ibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600208; c=relaxed/simple;
	bh=XIVQPDWD64eYeYQKjEF3OnoyWC3wyS3XLFk9t2rDyRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzeFiB9i33XuiOI66/DcNZDwYC5ekioiMwD/dbIwWBqpNp76w3Fh/apDM8h7ewRUi8w1qCjovgXKphzohc8NVZn4czj64PrsPMdbyWsL2+83Jf5EgN1J8d6Fmqwzm19V23NXoBrTDRkuyafVstThuew+3QhdPVPHcrxfZoaU9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uft7vvsE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c9001a14ffso4093122a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717600206; x=1718205006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMdlMnpu2rLutfBaZ7FjrKi42VwaFOFSjyMRzM4+P80=;
        b=uft7vvsE60Ji0QtCJYyp2hANsXP07hhyJXAK37ldiXxOJgeS1E+KOLLmTrhrmng1NE
         W6yojNGKBrGSCJ8N0K4Yd2r2hXtWBhsQmvd9aIrZA+htz4eQSawi8/zh0UcWdiO6Zf0o
         1p7HmopTW1Su/F579Et4qdc5ZkVNYOuuC4jlriX8nu5PWX0zMaAPFcelsuzreILdVM8T
         YIEYSWl2Kfslmry8AQM9oGIshXnOF8FdKalVZEnZX91eS9/PcdZcQs7YcycG+00epmb2
         z89/MmCtTxLtDTS9CiDruYnY+f+ghXGBlb8L5PONJ2U259lhn0AUimdPJR4bjIvFlsiL
         ofog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717600206; x=1718205006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMdlMnpu2rLutfBaZ7FjrKi42VwaFOFSjyMRzM4+P80=;
        b=WW+Sg9XLXCkrkkVhNawITiqG49hQtZJDYeI5XgZA2IeV2FQpSn0QJnKdHWS1fXYn+R
         X/rdYyfiM4atiaU3j4jnBvu5rN7z+fywMVznmjHKWIPksZSjiMFoMaHEDZdmx3qYBazO
         UlDun3NNmIimOryPN+UbGBHUuFzeOWYwP9TyRUwASfXX9Cfk7OgHkxM5QmAxdI812VPr
         3ikv3HMzh6ZcB0goDjG0wGJZfBeuAkv/oncws1gTT8S8eObMZn1Hciu5VMrs2RgM8xAX
         Z2IRQV0anDVcBLY2xJK7oAZOMnQdYn1QEIC7+0VtVBq7hJdLNKNyXywRlNG3fv+fdN4I
         j8OA==
X-Forwarded-Encrypted: i=1; AJvYcCXQh7HuD/tcWnP9MQ5jv/SVyY2gxuzac2ZvamAsv+/vtPyUIQKbN3vGTfqACEAHNB+B8nTVzV3nSvIfkC/L3X8V0nc2dX9agxZAkeFW
X-Gm-Message-State: AOJu0YxABG59BRgNfp1JjJ3355KSmO5zptl45TErdkSomJG758OAR0wb
	ApbZyvY2MDhE9MQOF5bSnqLssBXHfDe6AURM3qMQJZ8gXaVtal5r4EdBi8Fl3tl294X3F8GRJK3
	PmA==
X-Google-Smtp-Source: AGHT+IEey3wmkUpf69Avkqmye51ogQqEPgRMRLIp2jlDpff17NiOASAUjHxDUtnJ8BIMPggZX5XlnZeHMo8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:452:b0:659:fa27:f2a7 with SMTP id
 41be03b00d2f7-6d952ec43ebmr7263a12.11.1717600206172; Wed, 05 Jun 2024
 08:10:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:10:04 -0700
In-Reply-To: <171754374489.2780783.15684128983475310982.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506225321.3440701-1-alejandro.j.jimenez@oracle.com> <171754374489.2780783.15684128983475310982.b4-ty@google.com>
Message-ID: <ZmB_zGGqhwMh2jOH@google.com>
Subject: Re: [PATCH v2 0/2] Print names of apicv inhibit reasons in traces
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, vasant.hegde@amd.com, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 04, 2024, Sean Christopherson wrote:
> On Mon, 06 May 2024 22:53:19 +0000, Alejandro Jimenez wrote:
> > v2:
> > - Use Sean's implementation/patch from v1: https://lore.kernel.org/all/ZjVQOFLXWrZvoa-Y@google.com/
> > - Fix typo in commit message (s/inhbit/inhibit).
> > - Add patch renaming APICV_INHIBIT_REASON_DISABLE to APICV_INHIBIT_REASON_DISABLED.
> > - Drop Vasant's R-b from v1 since implementation was refined, even though the
> > general approach and behavior remains the same.
> > 
> > [...]
> 
> Applied to kvm-x86 misc, thanks!
> 
> [1/2] KVM: x86: Print names of apicv inhibit reasons in traces
>       https://github.com/kvm-x86/linux/commit/8b5bf6b80eb3
> [2/2] KVM: x86: Keep consistent naming for APICv/AVIC inhibit reasons
>       https://github.com/kvm-x86/linux/commit/f9979c52eb02

FYI, hashes changed due to dropping an unrelated commit.

[1/2] KVM: x86: Print names of apicv inhibit reasons in traces
      https://github.com/kvm-x86/linux/commit/69148ccec679
[2/2] KVM: x86: Keep consistent naming for APICv/AVIC inhibit reasons
      https://github.com/kvm-x86/linux/commit/f992572120fb

